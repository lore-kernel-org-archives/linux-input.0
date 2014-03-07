From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/2 ] Surface Pro 2 HID sensor, wacom, keyboard/multitouch
 composite device
Date: Fri, 7 Mar 2014 12:00:29 -0500
Message-ID: <CAN+gG=HXKHHWLwPVPuZkSGkApF53-b_5L6QrHLCKkvziA15m2A@mail.gmail.com>
References: <5319EB7C.5070209@yahoo.de>
	<5319EC31.90202@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:37634 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaCGRAa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 12:00:30 -0500
Received: by mail-la0-f48.google.com with SMTP id gf5so2985558lab.35
        for <linux-input@vger.kernel.org>; Fri, 07 Mar 2014 09:00:29 -0800 (PST)
In-Reply-To: <5319EC31.90202@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derya <derya.kiran@yahoo.de>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>

On Fri, Mar 7, 2014 at 10:56 AM, Derya <derya.kiran@yahoo.de> wrote:
> The Surface Pro 2 has a very annoying USB composite device on port 2.3.
> It has 3 interfaces, interface 0 is the hid-sensor-hub, interface 1 the
> wacom
> digitizer and if a keyboard is attached, then it is on interface 3. This USB
> composite device changes it's product id, it depends on if and which
> keyboard
> cover is attached. Adding the Type-/Touch Cover 2 to hid_have_special_driver
> prevents loading the hid-sensor-hub driver for interface 0, if a cover is
> attached (commit 117309c51dca42121f70cacec801511b76acf75c).

This patch obviously reverts this commit and add different features.
I would be happy if you split it in two:
- the first one would be the revert (given by "git revert" with a
clear commit message) so we will have a clear view that this patch was
broken
- then you do the additions (you will have to re-add things in
hid-ids.h, but it's not a big deal).

> All 3 interfaces are loaded with the microsoft special driver. Interface 3,
> the keyboard covers, has a HID_DG_CONTACTID. This leads to loading of
> hid-multitouch for the keyboard, if we remove it from the special driver
> list.
> Neither the keyboard not the touchpad works with hid-multitouch.
> I add a check for vendor and product id in hid_scan_input_usage to prevent
> the loading of hid-multitouch. By this way it loads hid-generic for
> the keyboards without effecting the other two interfaces.
> The HID_QUIRK_NOGET is needed for hid-sensor-hub, without it Submit urb
> fails
> and it takes some seconds until the devices on this port get responsible
> whenever a keyboard cover is (de)attached.
>
> Signed-off-by: Derya <derya.kiran@yahoo.de>
> ---
>  drivers/hid/hid-core.c          | 5 ++---
>  drivers/hid/hid-ids.h           | 1 +
>  drivers/hid/hid-microsoft.c     | 4 ----
>  drivers/hid/usbhid/hid-quirks.c | 3 +++
>  4 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index cc32a6f..2d60a1a 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -685,7 +685,8 @@ static void hid_scan_input_usage(struct hid_parser
> *parser, u32 usage)
>      struct hid_device *hid = parser->device;
>
>      if (usage == HID_DG_CONTACTID)
> -        hid->group = HID_GROUP_MULTITOUCH;
> +        if (!(hid->vendor == USB_VENDOR_ID_MICROSOFT && (hid->product ==
> USB_DEVICE_ID_MS_TYPE_COVER_2 || hid->product ==
> USB_DEVICE_ID_MS_TOUCH_COVER_2)))
> +            hid->group = HID_GROUP_MULTITOUCH;

Please don't do such vendor specific tests here.

I'd be happy if you put at the end of hid_scan_report()

    /*
    * Handle vendor specific handlings
    */
    if ((hid->vendor == USB_VENDOR_ID_MICROSOFT) &&
        (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_2 ||
         hid->product == USB_DEVICE_ID_MS_TOUCH_COVER_2) &&
        (hid->group != HID_GROUP_MULTITOUCH))
        hid->group = HID_GROUP_GENERIC;

this way, we can add other vendors quirks (who said Wacom? :-P )

>  }
>
>  static void hid_scan_feature_usage(struct hid_parser *parser, u32 usage)
> @@ -1780,8 +1781,6 @@ static const struct hid_device_id
> hid_have_special_driver[] = {
>      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_PRESENTER_8K_USB) },
>      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K) },
>      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
> -    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_TYPE_COVER_2) },
> -    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,

this should be in the revert commit as mentioned

> USB_DEVICE_ID_MS_TOUCH_COVER_2) },
>      { HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
>      { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN)
> },
>      { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG,
> USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_1) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 22f28d6..0aa9f7e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -624,6 +624,7 @@
>  #define USB_DEVICE_ID_MS_PRESENTER_8K_USB    0x0713
>  #define USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K    0x0730
>  #define USB_DEVICE_ID_MS_COMFORT_MOUSE_4500    0x076c
> +#define USB_DEVICE_ID_MS_SURFACE_PRO_2    0x0799        //Surface Pro 2's
> MICROSOFT SAM device without a keyboard cover attached, changes product id

please do not use "//" but /* ... */ for the comments.

Also, we are "limited" to 80 chars per line, so this comment should go
above the two declarations.

> with cover
>  #define USB_DEVICE_ID_MS_TOUCH_COVER_2    0x07a7
>  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
>
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index 404a3a8..c6ef6ee 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -208,10 +208,6 @@ static const struct hid_device_id ms_devices[] = {
>          .driver_data = MS_NOGET },
>      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
>          .driver_data = MS_DUPLICATE_USAGES },
> -    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_TYPE_COVER_2),
> -        .driver_data = 0 },
> -    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_TOUCH_COVER_2),
> -        .driver_data = 0 },

revert patch

>
>      { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_PRESENTER_8K_BT),
>          .driver_data = MS_PRESENTER },
> diff --git a/drivers/hid/usbhid/hid-quirks.c
> b/drivers/hid/usbhid/hid-quirks.c
> index dbd8387..2b7fd92 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -73,6 +73,9 @@ static const struct hid_blacklist {
>      { USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER,
> HID_QUIRK_NO_INIT_REPORTS },
>      { USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28,
> HID_QUIRK_NOGET },
>      { USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
> +    { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_SURFACE_PRO_2,
> HID_QUIRK_NOGET },

please test HID_QUIRK_NO_INIT_INPUT_REPORTS

Good work!

Cheers,
Benjamin

> +    { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_2,
> HID_QUIRK_NOGET },
> +    { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2,
> HID_QUIRK_NOGET },
>      { USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GX680R_LED_PANEL,
> HID_QUIRK_NO_INIT_REPORTS },
>      { USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750,
> HID_QUIRK_NO_INIT_REPORTS },
>      { USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE,
> HID_QUIRK_NO_INIT_REPORTS },
> --
> 1.8.3.2
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
