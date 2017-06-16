From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Support PTP Stick and Touchpad device
Date: Fri, 16 Jun 2017 10:23:01 +0200
Message-ID: <20170616082301.GN5085@mail.corp.redhat.com>
References: <20170616002940.7279-1-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752923AbdFPIXH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Jun 2017 04:23:07 -0400
Content-Disposition: inline
In-Reply-To: <20170616002940.7279-1-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

On Jun 16 2017 or thereabouts, Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> - Support PTP Stick and Touchpad device.
> - This Touchpad is Precision Touchpad(PTP),
>  and Stick Pointer data is the same as Mouse.
> - Stick Pointer works as Mouse.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> ---

Looks godd to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-ids.h        |  2 ++
>  drivers/hid/hid-multitouch.c | 23 +++++++++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 8ca1e8ce0af2..d36d4ac508f6 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -75,6 +75,8 @@
>  
>  #define USB_VENDOR_ID_ALPS_JP		0x044E
>  #define HID_DEVICE_ID_ALPS_U1_DUAL	0x120B
> +#define HID_DEVICE_ID_ALPS_U1_DUAL_PTP	0x121F
> +#define HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP	0x1220
>  
>  #define USB_VENDOR_ID_AMI		0x046b
>  #define USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE	0xff10
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 24d5b6deb571..ba9d9020f958 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -148,6 +148,7 @@ static void mt_post_parse(struct mt_device *td);
>  /* reserved					0x0011 */
>  #define MT_CLS_WIN_8				0x0012
>  #define MT_CLS_EXPORT_ALL_INPUTS		0x0013
> +#define MT_CLS_WIN_8_DUAL			0x0014
>  
>  /* vendor specific classes */
>  #define MT_CLS_3M				0x0101
> @@ -217,6 +218,12 @@ static struct mt_class mt_classes[] = {
>  		.quirks = MT_QUIRK_ALWAYS_VALID |
>  			MT_QUIRK_CONTACT_CNT_ACCURATE,
>  		.export_all_inputs = true },
> +	{ .name = MT_CLS_WIN_8_DUAL,
> +		.quirks = MT_QUIRK_ALWAYS_VALID |
> +			MT_QUIRK_IGNORE_DUPLICATES |
> +			MT_QUIRK_HOVERING |
> +			MT_QUIRK_CONTACT_CNT_ACCURATE,
> +		.export_all_inputs = true },
>  
>  	/*
>  	 * vendor specific classes
> @@ -512,7 +519,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			mt_store_field(usage, td, hi);
>  			return 1;
>  		case HID_DG_CONFIDENCE:
> -			if (cls->name == MT_CLS_WIN_8 &&
> +			if ((cls->name == MT_CLS_WIN_8 ||
> +				cls->name == MT_CLS_WIN_8_DUAL) &&
>  				field->application == HID_DG_TOUCHPAD)
>  				cls->quirks |= MT_QUIRK_CONFIDENCE;
>  			mt_store_field(usage, td, hi);
> @@ -579,7 +587,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  		 * MS PTP spec says that external buttons left and right have
>  		 * usages 2 and 3.
>  		 */
> -		if (cls->name == MT_CLS_WIN_8 &&
> +		if ((cls->name == MT_CLS_WIN_8 ||
> +			cls->name == MT_CLS_WIN_8_DUAL) &&
>  		    field->application == HID_DG_TOUCHPAD &&
>  		    (usage->hid & HID_USAGE) > 1)
>  			code--;
> @@ -1290,6 +1299,16 @@ static const struct hid_device_id mt_devices[] = {
>  		MT_USB_DEVICE(USB_VENDOR_ID_3M,
>  			USB_DEVICE_ID_3M3266) },
>  
> +	/* Alps devices */
> +	{ .driver_data = MT_CLS_WIN_8_DUAL,
> +		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> +			USB_VENDOR_ID_ALPS_JP,
> +			HID_DEVICE_ID_ALPS_U1_DUAL_PTP) },
> +	{ .driver_data = MT_CLS_WIN_8_DUAL,
> +		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> +			USB_VENDOR_ID_ALPS_JP,
> +			HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP) },
> +
>  	/* Anton devices */
>  	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
>  		MT_USB_DEVICE(USB_VENDOR_ID_ANTON,
> -- 
> 2.11.0
> 
