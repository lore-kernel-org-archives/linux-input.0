From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: usbhid: add Chicony/Pixart usb optical mouse that
 needs QUIRK_ALWAYS_POLL
Date: Thu, 21 May 2015 14:41:36 -0400
Message-ID: <CAN+gG=E=Qg1PpGHxZ5Ty=U_0fcwLQWR6X0mdQ02ef_Mv3a-auw@mail.gmail.com>
References: <1432231455-4172-1-git-send-email-herton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34347 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbbEUSlh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 14:41:37 -0400
In-Reply-To: <1432231455-4172-1-git-send-email-herton@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Herton R. Krzesinski" <herton@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Hi Herton,

On Thu, May 21, 2015 at 2:04 PM, Herton R. Krzesinski <herton@redhat.com> wrote:
> I received a report from an user of following mouse which needs this quirk:
>
> usb 1-1.6: USB disconnect, device number 58
> usb 1-1.6: new low speed USB device number 59 using ehci_hcd
> usb 1-1.6: New USB device found, idVendor=04f2, idProduct=1053
> usb 1-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 1-1.6: Product: USB Optical Mouse
> usb 1-1.6: Manufacturer: PixArt
> usb 1-1.6: configuration #1 chosen from 1 choice
> input: PixArt USB Optical Mouse as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6:1.0/input/input5887
> generic-usb 0003:04F2:1053.16FE: input,hidraw2: USB HID v1.11 Mouse [PixArt USB Optical Mouse] on usb-0000:00:1a.0-1.6/input0
>
> The quirk was tested by the reporter and it fixed the frequent disconnections etc.
>
> Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
> ---
>  drivers/hid/hid-ids.h           | 1 +
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 41f167e..b5ff1d0 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -223,6 +223,7 @@
>  #define USB_DEVICE_ID_CHIC_GAMEPAD     0x0014
>
>  #define USB_VENDOR_ID_CHICONY          0x04f2
> +#define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE 0x1053

Just a small nitpick here. Please try to keep the list ordered by PID.

Maybe Jiri can amend that directly in his tree too.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  #define USB_DEVICE_ID_CHICONY_TACTICAL_PAD     0x0418
>  #define USB_DEVICE_ID_CHICONY_MULTI_TOUCH      0xb19d
>  #define USB_DEVICE_ID_CHICONY_WIRELESS 0x0618
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index a775143..b0f7e9f4 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -69,6 +69,7 @@ static const struct hid_blacklist {
>         { USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_PEDALS, HID_QUIRK_NOGET },
>         { USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK, HID_QUIRK_NOGET },
>         { USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
> +       { USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
>         { USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
>         { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUIRK_ALWAYS_POLL },
>         { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, HID_QUIRK_ALWAYS_POLL },
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
