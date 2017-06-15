From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/1] Support PTP Stick and Touchpad device
Date: Thu, 15 Jun 2017 10:30:56 +0200
Message-ID: <20170615083056.GI5085@mail.corp.redhat.com>
References: <20170614084714.18166-1-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751979AbdFOIbD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Jun 2017 04:31:03 -0400
Content-Disposition: inline
In-Reply-To: <20170614084714.18166-1-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

On Jun 14 2017 or thereabouts, Masaki Ota wrote:
> From Masaki Ota <masaki.ota@jp.alps.com>
>  Support PTP Stick and Touchpad device.
>  This Touchpad is Precision Touchpad(PTP),
>  and Stick Pointer data is the same as Mouse.
>  So Stick Pointer works as Mouse.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> ---
>  drivers/hid/hid-ids.h        |  2 ++
>  drivers/hid/hid-multitouch.c | 24 ++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
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
> index 24d5b6deb571..4ffdda9d80da 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -161,6 +161,7 @@ static void mt_post_parse(struct mt_device *td);
>  #define MT_CLS_GENERALTOUCH_PWT_TENFINGERS	0x0109
>  #define MT_CLS_LG				0x010a
>  #define MT_CLS_VTL				0x0110
> +#define MT_CLS_WIN_8_DUAL			0x0111

This is not vendor specific, so we should use 0x0014 and move this above
in the list.

>  
>  #define MT_DEFAULT_MAXCONTACT	10
>  #define MT_MAX_MAXCONTACT	250
> @@ -278,6 +279,13 @@ static struct mt_class mt_classes[] = {
>  			MT_QUIRK_CONTACT_CNT_ACCURATE |
>  			MT_QUIRK_FORCE_GET_FEATURE,
>  	},
> +	{ .name = MT_CLS_WIN_8_DUAL,
> +		.quirks = MT_QUIRK_ALWAYS_VALID |
> +			MT_QUIRK_IGNORE_DUPLICATES |
> +			MT_QUIRK_HOVERING |
> +			MT_QUIRK_CONTACT_CNT_ACCURATE,
> +		.export_all_inputs = true
> +	},

Same than above, please move this just after MT_CLS_EXPORT_ALL_INPUTS.

>  	{ }
>  };
>  
> @@ -512,7 +520,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			mt_store_field(usage, td, hi);
>  			return 1;
>  		case HID_DG_CONFIDENCE:
> -			if (cls->name == MT_CLS_WIN_8 &&
> +			if ((cls->name == MT_CLS_WIN_8 ||
> +				cls->name == MT_CLS_WIN_8_DUAL) &&
>  				field->application == HID_DG_TOUCHPAD)
>  				cls->quirks |= MT_QUIRK_CONFIDENCE;
>  			mt_store_field(usage, td, hi);
> @@ -579,7 +588,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  		 * MS PTP spec says that external buttons left and right have
>  		 * usages 2 and 3.
>  		 */
> -		if (cls->name == MT_CLS_WIN_8 &&
> +		if ((cls->name == MT_CLS_WIN_8 ||
> +			cls->name == MT_CLS_WIN_8_DUAL) &&
>  		    field->application == HID_DG_TOUCHPAD &&
>  		    (usage->hid & HID_USAGE) > 1)
>  			code--;
> @@ -1290,6 +1300,16 @@ static const struct hid_device_id mt_devices[] = {
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

Rest looks good to me.

Cheers,
Benjamin

