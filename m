From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: asus: Add support for Fn keys on Asus ROG G752
Date: Mon, 21 Aug 2017 09:14:25 +0200
Message-ID: <20170821071425.GC28808@mail.corp.redhat.com>
References: <20170820125814.21641-1-maxime.bellenge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbdHUHOc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Aug 2017 03:14:32 -0400
Content-Disposition: inline
In-Reply-To: <20170820125814.21641-1-maxime.bellenge@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime =?utf-8?B?QmVsbGVuZ8Op?= <maxime.bellenge@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Aug 20 2017 or thereabouts, Maxime Bellengé wrote:
> This patch adds support for Fn keys on Asus ROG G752 laptop.
> The report descriptor is broken so I fixed it.
> 
> Tested on an Asus G752VT.
> 
> Signed-off-by: Maxime Bellengé <maxime.bellenge@gmail.com>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-asus.c | 29 +++++++++++++++++++++++++++++
>  drivers/hid/hid-core.c |  2 +-
>  drivers/hid/hid-ids.h  |  1 +
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index a4a3c38bc145..2a03ed842186 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -70,6 +70,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_NO_CONSUMER_USAGES	BIT(4)
>  #define QUIRK_USE_KBD_BACKLIGHT		BIT(5)
>  #define QUIRK_T100_KEYBOARD		BIT(6)
> +#define QUIRK_G752_KEYBOARD		BIT(7)
>  
>  #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
>  						 QUIRK_NO_INIT_REPORTS | \
> @@ -568,6 +569,11 @@ static void asus_remove(struct hid_device *hdev)
>  	hid_hw_stop(hdev);
>  }
>  
> +static const __u8 asus_g752_fixed_rdesc[] = {
> +        0x19, 0x00,                     /*   Usage Minimum (0x00)       */
> +        0x2A, 0xFF, 0x00,               /*   Usage Maximum (0xFF)       */
> +};
> +
>  static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		unsigned int *rsize)
>  {
> @@ -583,6 +589,27 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
>  		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
>  	}
> +        if (drvdata->quirks & QUIRK_G752_KEYBOARD &&
> +		 *rsize == 75 && rdesc[61] == 0x15 && rdesc[62] == 0x00) {
> +                /* report is missing usage mninum and maximum */
> +                __u8 *new_rdesc;
> +                size_t new_size = *rsize + sizeof(asus_g752_fixed_rdesc);
> +
> +                new_rdesc = devm_kzalloc(&hdev->dev, new_size, GFP_KERNEL);
> +                if (new_rdesc == NULL)
> +			return rdesc;
> +
> +                hid_info(hdev, "Fixing up Asus G752 keyb report descriptor\n");
> +                /* copy the valid part */
> +                memcpy(new_rdesc, rdesc, 61);
> +                /* insert missing part */
> +                memcpy(new_rdesc + 61, asus_g752_fixed_rdesc, sizeof(asus_g752_fixed_rdesc));
> +                /* copy remaining data */
> +                memcpy(new_rdesc + 61 + sizeof(asus_g752_fixed_rdesc), rdesc + 61, *rsize - 61);
> +
> +                *rsize = new_size;
> +                rdesc = new_rdesc;
> +	}
>  
>  	return rdesc;
>  }
> @@ -596,6 +623,8 @@ static const struct hid_device_id asus_devices[] = {
>  		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
> +        { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +                USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3), QUIRK_G752_KEYBOARD },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  		USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD),
>  	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9017dcc14502..45369f5dad6e 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1979,6 +1979,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
> +        { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
> @@ -3125,4 +3126,3 @@ MODULE_AUTHOR("Andreas Gal");
>  MODULE_AUTHOR("Vojtech Pavlik");
>  MODULE_AUTHOR("Jiri Kosina");
>  MODULE_LICENSE("GPL");
> -
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c9ba4c6db74c..602409663743 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -180,6 +180,7 @@
>  #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
>  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
>  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2 0x1837
> +#define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3 0x1822
>  
>  #define USB_VENDOR_ID_ATEN		0x0557
>  #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
> -- 
> 2.13.5
> 
