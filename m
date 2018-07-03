From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 4/4] HID: multitouch: remove unneeded else conditional cases
Date: Tue, 3 Jul 2018 10:17:58 +0200
Message-ID: <CAO-hwJ+ZHb8xyr=1RgVROvP2=yzmepccVOqZM5qP3hbOEYEo9g@mail.gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com> <d35643165a1d1972fd91e547922697a3c785a413.1530402641.git.joeypabalinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d35643165a1d1972fd91e547922697a3c785a413.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sun, Jul 1, 2018 at 2:19 AM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> Elide lone `else` cases and replace `else if` clauses
> with plain `if` conditionals when they occur immediately
> after return statements.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>

This one looks good.
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Just FYI, I sent out a big refactor of the hid-multitouch code. Jiri
should be still reviewing it, so I am not so sure who will have to
rebase which series on top of the other, but someone between us will
have to do it :)

Cheers,
Benjamin

>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 08b50e5908cecdda66..30b1a2c67f39a41325 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -205,12 +205,12 @@ static void mt_post_parse(struct mt_device *td);
>
>  static int cypress_compute_slot(struct mt_device *td)
>  {
>         if (td->curdata.contactid != 0 || td->num_received == 0)
>                 return td->curdata.contactid;
> -       else
> -               return -1;
> +
> +       return -1;
>  }
>
>  static struct mt_class mt_classes[] = {
>         { .name = MT_CLS_DEFAULT,
>                 .quirks = MT_QUIRK_ALWAYS_VALID |
> @@ -803,12 +803,12 @@ static int mt_compute_timestamp(struct mt_device *td, struct hid_field *field,
>         delta *= 100;
>
>         if (jdelta > MAX_TIMESTAMP_INTERVAL)
>                 /* No data received for a while, resync the timestamp. */
>                 return 0;
> -       else
> -               return td->timestamp + delta;
> +
> +       return td->timestamp + delta;
>  }
>
>  static int mt_touch_event(struct hid_device *hid, struct hid_field *field,
>                                 struct hid_usage *usage, __s32 value)
>  {
> @@ -1110,11 +1110,12 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>          * HID_DG_CONTACTCOUNT from the pen report as it is outside the physical
>          * collection, but within the report ID.
>          */
>         if (field->physical == HID_DG_STYLUS)
>                 return 0;
> -       else if ((field->physical == 0) &&
> +
> +       if ((field->physical == 0) &&
>                  (field->report->id != td->mt_report_id) &&
>                  (td->mt_report_id != -1))
>                 return 0;
>
>         if (field->application == HID_DG_TOUCHSCREEN ||
> --
> 2.18.0
>
