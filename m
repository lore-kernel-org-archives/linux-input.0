From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 4/4] HID: microsoft: undefining ms_map_key_clear after usage
Date: Wed, 9 Apr 2014 16:42:21 -0400
Message-ID: <CAN+gG=HFEcsVdmuf6o2GyfSmjWRansS02MVbXdjws7xVNp1QGw@mail.gmail.com>
References: <1396631237-11813-1-git-send-email-tolga@cevel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396631237-11813-1-git-send-email-tolga@cevel.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Tolga Cakir <tolga@cevel.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Derya <derya.kiran@yahoo.de>, Jiri Kosina <jkosina@suse.cz>, Reyad Attiyat <reyad.attiyat@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 4, 2014 at 1:07 PM, Tolga Cakir <tolga@cevel.net> wrote:
> This is inspired by various other hid drivers.
>
> Signed-off-by: Tolga Cakir <tolga@cevel.net>
> ---
>  drivers/hid/hid-microsoft.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index 5674c0c..5281d2d 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -211,6 +211,8 @@ static int ms_sidewinder_kb_quirk(struct hid_input *hi, struct hid_usage *usage,
>         return 1;
>  }
>
> +#undef ms_map_key_clear
> +

Not sure this is really needed. The macro is prefixed by ms_, so I
will simply let it there.

Cheers,
Benjamin

>  static int ms_sidewinder_control(struct hid_device *hdev, __u8 setup)
>  {
>         struct ms_data *sc = hid_get_drvdata(hdev);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
