From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Surface Pro 2 USB composite device handling
Date: Mon, 10 Mar 2014 16:23:25 -0400
Message-ID: <20140310202325.GB4125@mail.corp.redhat.com>
References: <531CAA1F.4080809@yahoo.de>
 <531CAB67.4020202@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48251 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462AbaCJUX3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 16:23:29 -0400
Content-Disposition: inline
In-Reply-To: <531CAB67.4020202@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derya <derya.kiran@yahoo.de>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Mar 09 2014 or thereabouts, Derya wrote:
> Surface Pro 2 USB composite device handling
> 
> (device changes it product id with attached keyboard cover)
> - Adds MS Surface Pro 2's composite device ids, with and without attached
> keyboard, to the hid-ids
> - Ensures to load hid-core instead of hid-multitouch for the keyboard covers
> - Adds HID_QUIRK_NO_INIT_INPUT_REPORTS to prevent USB submit urb failure
> during keyboard cover (de)attaching
> 
> Signed-off-by: Derya <derya.kiran@yahoo.de>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/hid-core.c          | 9 +++++++++
>  drivers/hid/hid-ids.h           | 3 +++
>  drivers/hid/usbhid/hid-quirks.c | 3 +++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index bb5c494..f4e4820 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -775,6 +775,15 @@ static int hid_scan_report(struct hid_device *hid)
>      if ((parser->scan_flags & HID_SCAN_FLAG_MT_WIN_8) &&
>          (hid->group == HID_GROUP_MULTITOUCH))
>          hid->group = HID_GROUP_MULTITOUCH_WIN_8;
> +
> +    /*
> +     * Handle vendor specific handlings
> +     */
> +    if ((hid->vendor == USB_VENDOR_ID_MICROSOFT) &&
> +        (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_2 ||
> +        hid->product == USB_DEVICE_ID_MS_TOUCH_COVER_2) &&
> +        (hid->group == HID_GROUP_MULTITOUCH))
> +        hid->group = HID_GROUP_GENERIC;
> 
>      vfree(parser);
>      return 0;
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 07cd28c..f61c0d8 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -624,6 +624,9 @@
>  #define USB_DEVICE_ID_MS_PRESENTER_8K_USB    0x0713
>  #define USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K    0x0730
>  #define USB_DEVICE_ID_MS_COMFORT_MOUSE_4500    0x076c
> +#define USB_DEVICE_ID_MS_SURFACE_PRO_2    0x0799
> +#define USB_DEVICE_ID_MS_TOUCH_COVER_2    0x07a7
> +#define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
> 
>  #define USB_VENDOR_ID_MOJO        0x8282
>  #define USB_DEVICE_ID_RETRO_ADAPTER    0x3201
> diff --git a/drivers/hid/usbhid/hid-quirks.c
> b/drivers/hid/usbhid/hid-quirks.c
> index dbd8387..7c4f86e 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -73,6 +73,9 @@ static const struct hid_blacklist {
>      { USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER,
> HID_QUIRK_NO_INIT_REPORTS },
>      { USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28,
> HID_QUIRK_NOGET },
>      { USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
> +    { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_SURFACE_PRO_2,
> HID_QUIRK_NO_INIT_INPUT_REPORTS },
> +    { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_2,
> HID_QUIRK_NO_INIT_INPUT_REPORTS },
> +    { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2,
> HID_QUIRK_NO_INIT_INPUT_REPORTS },
>      { USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GX680R_LED_PANEL,
> HID_QUIRK_NO_INIT_REPORTS },
>      { USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750,
> HID_QUIRK_NO_INIT_REPORTS },
>      { USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE,
> HID_QUIRK_NO_INIT_REPORTS },
> -- 
> 1.8.3.2
> 
