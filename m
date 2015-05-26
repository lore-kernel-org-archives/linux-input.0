From: Alan Wu <alan.c.wu@gmail.com>
Subject: Re: [PATCH] hid: Add secondary vendor id for the marco, USB_DEVICE_ID_MS_TYPE_COVER_3_V2
Date: Tue, 26 May 2015 13:58:21 -0700
Message-ID: <CABkLPO+g_pk1v+mrYn7Bh5qkk+g7yYjWr+Z9ZtrNT9n7O=NQjw@mail.gmail.com>
References: <1432216088-19620-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35558 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbbEZU6V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 16:58:21 -0400
In-Reply-To: <1432216088-19620-1-git-send-email-xerofoify@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Hi Jiri,
  I think I have given my input on what should be done with the code.
I'll leave it up to you to decide whether to accept the patch or not.
Please do let me know if you have any questions you want to ask me.

  I would recommend that Nicholas change the 0x07dd to PRO though, as
they might also have a regular Surface 3 in Japan that is different
than yours.

Thanks,
Alan


On Thu, May 21, 2015 at 6:48 AM, Nicholas Krause <xerofoify@gmail.com> wrote:
> This adds a secondary marco for the vendor id,
> USB_DEVICE_ID_MS_TYPE_COVER_3_V2 in order to
> support this device having a secondary vendor id.
> Further more we also add this marco to the
> structures, hid_blacklist and ms_devices and
> move over the function, hid_scan_collection to
> use support this newer macro.
> v2
> Change name of the macro to the more appropriate
>
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/hid/hid-core.c          | 5 ++++-
>  drivers/hid/hid-ids.h           | 3 ++-
>  drivers/hid/hid-microsoft.c     | 2 ++
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 722a925..c04faba 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -706,7 +706,9 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
>
>         if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
>             (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
> -            hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP) &&
> +            hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP ||
> +            hid->product == USB_DEVICE_ID_MS_TYPE_PRO_COVER_3 ||
> +            hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3) &&
>             hid->group == HID_GROUP_MULTITOUCH)
>                 hid->group = HID_GROUP_GENERIC;
>
> @@ -1900,6 +1902,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_PRO_COVER_3) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 41f167e..dac79ef 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -670,7 +670,8 @@
>  #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
>  #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
>  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
> -#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07dc
> +#define USB_DEVICE_ID_MS_TYPE_PRO_COVER_3  0x07dc
> +#define USB_DEVICE_ID_MS_TYPE_COVER_3   0x07de
>  #define USB_DEVICE_ID_MS_TYPE_COVER_3_JP 0x07dd
>
>  #define USB_VENDOR_ID_MOJO             0x8282
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index af935eb..7493280 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -278,6 +278,8 @@ static const struct hid_device_id ms_devices[] = {
>                 .driver_data = MS_DUPLICATE_USAGES },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
>                 .driver_data = MS_HIDINPUT },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_PRO_COVER_3),
> +               .driver_data = MS_HIDINPUT },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP),
>                 .driver_data = MS_HIDINPUT },
>
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index a775143..0c736c7 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -87,6 +87,7 @@ static const struct hid_blacklist {
>         { USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A, HID_QUIRK_ALWAYS_POLL },
>         { USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
>         { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
> +       { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_PRO_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
>         { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP, HID_QUIRK_NO_INIT_REPORTS },
>         { USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
>         { USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
> --
> 2.1.4
>
