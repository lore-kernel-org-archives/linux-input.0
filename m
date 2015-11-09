From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 6/6] HID: hid-logitech-hidpp: G920 remove deadzones
Date: Mon, 9 Nov 2015 09:24:30 +0100
Message-ID: <CAN+gG=HhE1JOqocKXt9hoOk1=Qs3ipJXarkPLi47T+B89QFnXA@mail.gmail.com>
References: <1446912609-2573-1-git-send-email-simon@mungewell.org>
	<1446912609-2573-7-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37954 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbbKIIYb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 03:24:31 -0500
In-Reply-To: <1446912609-2573-7-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@velds.nl>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Sat, Nov 7, 2015 at 5:10 PM, Simon Wood <simon@mungewell.org> wrote:
> Ensure that the G920 is not given the default deadzones.
>
> Signed-off-by: Simon Wood <simon@mungewell.org>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 03e01be..853b9c2 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -1441,6 +1441,27 @@ static int hidpp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>         return 0;
>  }
>
> +static int hidpp_input_mapped(struct hid_device *hdev, struct hid_input *hi,
> +               struct hid_field *field, struct hid_usage *usage,
> +               unsigned long **bit, int *max)
> +{
> +       /* Ensure that Logitech G920 is not given a default fuzz/flat value */
> +       if (usage->type == EV_ABS && (usage->code == ABS_X ||
> +                       usage->code == ABS_Y || usage->code == ABS_Z ||
> +                       usage->code == ABS_RZ)) {
> +               switch (hdev->product) {
> +               case USB_DEVICE_ID_LOGITECH_G920_WHEEL:
> +                       field->application = HID_GD_MULTIAXIS;
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }

I'd rather see this as:

if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
  if (usage->type == EV_ABS && (usage->code == ABS_X ....
    field->application = HID_GD_MULTIAXIS;
  }
}

Just to make sure we do not enter this code path for other devices.

With this change, and the nitpicks in the other patches, the series is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> +
> +       return 0;
> +}
> +
> +
>  static void hidpp_populate_input(struct hidpp_device *hidpp,
>                 struct input_dev *input, bool origin_is_hid_core)
>  {
> @@ -1873,6 +1894,7 @@ static struct hid_driver hidpp_driver = {
>         .raw_event = hidpp_raw_event,
>         .input_configured = hidpp_input_configured,
>         .input_mapping = hidpp_input_mapping,
> +       .input_mapped = hidpp_input_mapped,
>  };
>
>  module_hid_driver(hidpp_driver);
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
