From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Add secondary vendor id for the marco,
 USB_DEVICE_ID_MS_TYPE_COVER_3_V2
Date: Thu, 21 May 2015 01:30:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505210129060.8186@pobox.suse.cz>
References: <1432138645-11540-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57273 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053AbbETXa1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 19:30:27 -0400
In-Reply-To: <1432138645-11540-1-git-send-email-xerofoify@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Alan Wu <alan.c.wu@gmail.com>

On Wed, 20 May 2015, Nicholas Krause wrote:

> This adds a secondary marco for the vendor id, 
> USB_DEVICE_ID_MS_TYPE_COVER_3_V2 in order to support this device having 
> a secondary vendor id. Further more we also add this marco to the 
> structures, hid_blacklist and ms_devices and move over the function, 
> hid_scan_collection to use support this newer macro.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

I don't trust your patches any more, sorry. Adding Alan to Ack this.

> ---
>  drivers/hid/hid-core.c          | 4 +++-
>  drivers/hid/hid-ids.h           | 1 +
>  drivers/hid/hid-microsoft.c     | 2 ++
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  4 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 722a925..16fa795 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -706,7 +706,8 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
>  
>  	if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
>  	    (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
> -	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP) &&
> +	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP ||
> +	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_V2) &&
>  	    hid->group == HID_GROUP_MULTITOUCH)
>  		hid->group = HID_GROUP_GENERIC;
>  
> @@ -1900,6 +1901,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_V2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 41f167e..1371732 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -671,6 +671,7 @@
>  #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
>  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
>  #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07dc
> +#define USB_DEVICE_ID_MS_TYPE_COVER_3_V2 0x07de
>  #define USB_DEVICE_ID_MS_TYPE_COVER_3_JP 0x07dd
>  
>  #define USB_VENDOR_ID_MOJO		0x8282
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index af935eb..6f23d81 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -278,6 +278,8 @@ static const struct hid_device_id ms_devices[] = {
>  		.driver_data = MS_DUPLICATE_USAGES },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
>  		.driver_data = MS_HIDINPUT },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_V2),
> +		.driver_data = MS_HIDINPUT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP),
>  		.driver_data = MS_HIDINPUT },
>  
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index a775143..4b02c59 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -87,6 +87,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A, HID_QUIRK_ALWAYS_POLL },
>  	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
> +	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_V2, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
> -- 
> 2.1.4
> 

-- 
Jiri Kosina
SUSE Labs
