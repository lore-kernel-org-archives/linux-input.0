From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: core: move Usage Page concatenation to hid_parser_main()
Date: Mon, 25 Mar 2019 11:39:46 +0100
Message-ID: <CAO-hwJKo84vMDubVZM8Tye9wyGYkLC9sOVNUw=hUbzH1ktGv1A@mail.gmail.com>
References: <20190312093652.12829-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312093652.12829-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Jiri Kosina <jikos@kernel.org>, oneukum@suse.de, "Junge, Terry" <Terry.Junge@plantronics.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Nicolas,

On Tue, Mar 12, 2019 at 10:37 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> As seen on some USB wireless keyboards manufactured by Primax, the HID
> parser was using some assumptions that are not always true. In this case
> it's s the fact that, inside the scope of a main item, an Usage Page
> will always precede an Usage.
>
> The spec is not pretty clear as 6.2.2.7 states "Any usage that follows
> is interpreted as a Usage ID and concatenated with the Usage Page".
> While 6.2.2.8 states "When the parser encounters a main item it
> concatenates the last declared Usage Page with a Usage to form a
> complete usage value." Being somewhat contradictory it was decided to
> match Window's implementation, which follows 6.2.2.8.
>
> In summary, the patch moves the Usage Page concatenation from the local
> item parsing function to the main item parsing function.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Patch looks good to me.

Terry, did you have time to review it?

Cheers,
Benjamin

>
> Note: A PR in hid-tools shoud show up anytime soon
>
>  drivers/hid/hid-core.c | 30 ++++++++++++++++++------------
>  include/linux/hid.h    |  1 +
>  2 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9993b692598f..158468ef23a6 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct hid_parser *parser, unsigned type)
>   * Add a usage to the temporary parser table.
>   */
>
> -static int hid_add_usage(struct hid_parser *parser, unsigned usage)
> +static int hid_add_usage(struct hid_parser *parser, unsigned usage, __u8 size)
>  {
>         if (parser->local.usage_index >= HID_MAX_USAGES) {
>                 hid_err(parser->device, "usage index exceeded\n");
>                 return -1;
>         }
>         parser->local.usage[parser->local.usage_index] = usage;
> +       parser->local.usage_size[parser->local.usage_index] = size;
>         parser->local.collection_index[parser->local.usage_index] =
>                 parser->collection_stack_ptr ?
>                 parser->collection_stack[parser->collection_stack_ptr - 1] : 0;
> @@ -486,10 +487,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>                         return 0;
>                 }
>
> -               if (item->size <= 2)
> -                       data = (parser->global.usage_page << 16) + data;
> -
> -               return hid_add_usage(parser, data);
> +               return hid_add_usage(parser, data, item->size);
>
>         case HID_LOCAL_ITEM_TAG_USAGE_MINIMUM:
>
> @@ -498,9 +496,6 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>                         return 0;
>                 }
>
> -               if (item->size <= 2)
> -                       data = (parser->global.usage_page << 16) + data;
> -
>                 parser->local.usage_minimum = data;
>                 return 0;
>
> @@ -511,9 +506,6 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>                         return 0;
>                 }
>
> -               if (item->size <= 2)
> -                       data = (parser->global.usage_page << 16) + data;
> -
>                 count = data - parser->local.usage_minimum;
>                 if (count + parser->local.usage_index >= HID_MAX_USAGES) {
>                         /*
> @@ -533,7 +525,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>                 }
>
>                 for (n = parser->local.usage_minimum; n <= data; n++)
> -                       if (hid_add_usage(parser, n)) {
> +                       if (hid_add_usage(parser, n, item->size)) {
>                                 dbg_hid("hid_add_usage failed\n");
>                                 return -1;
>                         }
> @@ -553,8 +545,22 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>
>  static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
>  {
> +       unsigned int usages;
>         __u32 data;
>         int ret;
> +       int i;
> +
> +       usages = max_t(unsigned, parser->local.usage_index,
> +                                parser->global.report_count);
> +
> +       /*
> +        * As per specification, 6.2.2.8:
> +        * "When the parser encounters a main item it concatenates the last
> +        * declared Usage Page with a Usage to form a complete usage value."
> +        */
> +       for (i = 0; i < usages; i++)
> +               if (parser->local.usage_size[i] <= 2)
> +                       parser->local.usage[i] += parser->global.usage_page << 16;
>
>         data = item_udata(item);
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index f9707d1dcb58..d1fb4b678873 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -417,6 +417,7 @@ struct hid_global {
>
>  struct hid_local {
>         unsigned usage[HID_MAX_USAGES]; /* usage array */
> +       __u8 usage_size[HID_MAX_USAGES]; /* usage size array */
>         unsigned collection_index[HID_MAX_USAGES]; /* collection index array */
>         unsigned usage_index;
>         unsigned usage_minimum;
> --
> 2.21.0
>
