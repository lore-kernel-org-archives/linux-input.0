From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: bail out if wtp_connect fails
Date: Tue, 16 Dec 2014 17:13:05 -0500
Message-ID: <CAN+gG=F0HhzXQhsaHTEb5Hy2CVTsoOSopCt4grXFnSKt+tPsWw@mail.gmail.com>
References: <1418767562-4136-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418767562-4136-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Peter Wu <peter@lekensteyn.nl>, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Dec 16, 2014 at 5:06 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> If wtp_connect() fails, that means most of the time that the device has
> been disconnected. Subsequent attempts to contact the device will fail
> too, so it's simpler to bail out earlier.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

Jiri, Peter,

the logitech patches are queuing up really fast.
To keep track of them, I made a bundle on patchwork:
https://patchwork.kernel.org/bundle/bentiss/hid-logitech-hidpp/
(/me discovered a new tool to play with)

Right now, the patch "HID: logitech-hidpp: detect HID++ 2.0 errors
too" is waiting for Logitech's approval, and the 2 of this series need
review.

Peter, please tell me if I missed one patch.

Cheers,
Benjamin

>  drivers/hid/hid-logitech-hidpp.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index d008d71..c0fb5fe 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -914,24 +914,24 @@ static int wtp_allocate(struct hid_device *hdev, const struct hid_device_id *id)
>         return 0;
>  };
>
> -static void wtp_connect(struct hid_device *hdev, bool connected)
> +static int wtp_connect(struct hid_device *hdev, bool connected)
>  {
>         struct hidpp_device *hidpp = hid_get_drvdata(hdev);
>         struct wtp_data *wd = hidpp->private_data;
>         int ret;
>
>         if (!connected)
> -               return;
> +               return 0;
>
>         if (!wd->x_size) {
>                 ret = wtp_get_config(hidpp);
>                 if (ret) {
>                         hid_err(hdev, "Can not get wtp config: %d\n", ret);
> -                       return;
> +                       return ret;
>                 }
>         }
>
> -       hidpp_touchpad_set_raw_report_state(hidpp, wd->mt_feature_index,
> +       return hidpp_touchpad_set_raw_report_state(hidpp, wd->mt_feature_index,
>                         true, true);
>  }
>
> @@ -1115,8 +1115,11 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
>         struct input_dev *input;
>         char *name, *devm_name;
>
> -       if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
> -               wtp_connect(hdev, connected);
> +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
> +               ret = wtp_connect(hdev, connected);
> +               if (ret)
> +                       return;
> +       }
>
>         if (!connected || hidpp->delayed_input)
>                 return;
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
