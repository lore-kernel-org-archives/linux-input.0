From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] input: hid-multitouch- support PixArt optical touch
 screen
Date: Thu, 15 Dec 2011 11:14:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1112151113560.21970@pobox.suse.cz>
References: <4EE964D2.5030707@pixart.com.tw>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37814 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756114Ab1LOKOo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Dec 2011 05:14:44 -0500
In-Reply-To: <4EE964D2.5030707@pixart.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Tian <aaron_tian@pixart.com.tw>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, dmitry.torokhov@gmail.com

On Thu, 15 Dec 2011, Aaron Tian wrote:

> From: Aaron Tian <aaron_tian@pixart.com.tw>
> 
> This patch modifies hid-multitouch driver for supporting PixArt optical
> touch screen.
> Because of the device does not have to set initial report, we apply
> "HID_QUIRK_NO_INIT_REPORTS" quirk
> and add the device into hid_blacklist in drivers/hid/usbhid/hid-quirks.c.
> 
> The patch is according to commit 45e713efe2fa574b6662e7fb63fae9497c5e03d4
> of Linux mainline git (3.2.0-rc4+)
> 
> 
> Signed-off-by: Aaron Tian <aaron_tian@pixart.com.tw>
> ---
> v2: Fixed comments by Benjamin's suggestion.
> Add MT_CLS_INRANGE_CONTACTNUMBER class.
> 
>  drivers/hid/Kconfig             |    1 +
>  drivers/hid/hid-core.c          |    3 +++
>  drivers/hid/hid-ids.h           |    5 +++++
>  drivers/hid/hid-multitouch.c    |   15 +++++++++++++++
>  drivers/hid/usbhid/hid-quirks.c |    3 +++
>  5 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 22a4a05..eda54b6 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -349,6 +349,7 @@ config HID_MULTITOUCH
>  	  - Lumio CrystalTouch panels
>  	  - MosArt dual-touch panels
>  	  - PenMount dual touch panels
> +	  - PixArt optical touch screen
>  	  - Pixcir dual touch panels
>  	  - eGalax dual-touch panels, including the Joojoo and Wetab tablets
>  	  - Stantum multitouch panels
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index af35384..5968764 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1498,6 +1498,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_PCI) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4a441a6..7188e12 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -571,6 +571,11 @@
>  #define USB_VENDOR_ID_PI_ENGINEERING	0x05f3
>  #define USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL	0xff
>  
> +#define USB_VENDOR_ID_PIXART				0x093a
> +#define USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN	0x8001
> +#define USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1	0x8002
> +#define USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2	0x8003
> +
>  #define USB_VENDOR_ID_PLAYDOTCOM	0x0b43
>  #define USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII	0x0003
>  
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index f1c909f..9755afb 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -93,6 +93,7 @@ struct mt_class {
>  #define MT_CLS_DUAL_INRANGE_CONTACTID		0x0005
>  #define MT_CLS_DUAL_INRANGE_CONTACTNUMBER	0x0006
>  #define MT_CLS_DUAL_NSMU_CONTACTID		0x0007
> +#define MT_CLS_INRANGE_CONTACTNUMBER		0x0008

We already have 0x0008 taken for MT_CLS_DUAL_NSMU_CONTACTID, so I have 
made this 0x0009 and applied, thanks.

-- 
Jiri Kosina
SUSE Labs
