From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: asus: Add product-id for the T100TAF and T100HA
 keyboard docks
Date: Mon, 27 Nov 2017 09:35:31 +0100
Message-ID: <20171127083531.GD30708@mail.corp.redhat.com>
References: <20171126154010.954-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbdK0Ifg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Nov 2017 03:35:36 -0500
Content-Disposition: inline
In-Reply-To: <20171126154010.954-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Nov 26 2017 or thereabouts, Hans de Goede wrote:
> The T100TAF and T100HA keyboard docks have the same special keys and
> custom protocol multitouch touchpad as the T100TA, but use a different
> product id.
> 
> The T100TAF and T100HA both use the same product id, but the T100HA's
> touchpad has a different coordinate range.
> 
> This commits adds supports for the new USB id and uses a dmi-check to
> determine if we're dealing with the T100TAF or T100HA.

This feels really wrong. Either people at Asus are insane, either the
Windows driver has a query to fetch the correct logical and physical
min/max.

Could you share the hid-recorder output of the touchpad? Ideally, I'd
like to compare it between the 2 (T100TAF and T100HA).

If there is no differences, we might need to resort to have someone
sniff the usb traces from a Windows VM :/

(There is nothing wrong with your code per se, it's just tat it will
transform this driver into something even more uglier)

Cheers,
Benjamin
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=197849
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -The new device-id is for both the T100TAF and the T100HA
> -The T100HA touchpad has different coordinate ranges, take this into account
> -Rebase on top of hid/for-4.16/hid-quirks-cleanup/_base
> -Drop the ASUS T100TA entry from hid_have_special_driver, things work fine
>  without it
> ---
>  drivers/hid/hid-asus.c   | 24 ++++++++++++++++++++++--
>  drivers/hid/hid-ids.h    |  3 ++-
>  drivers/hid/hid-quirks.c |  1 -
>  3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 1bb7b63b3150..6d2894b7d8e7 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -26,6 +26,7 @@
>   * any later version.
>   */
>  
> +#include <linux/dmi.h>
>  #include <linux/hid.h>
>  #include <linux/module.h>
>  #include <linux/input/mt.h>
> @@ -119,6 +120,15 @@ static const struct asus_touchpad_info asus_t100ta_tp = {
>  	.max_contacts = 5,
>  };
>  
> +static const struct asus_touchpad_info asus_t100ha_tp = {
> +	.max_x = 2640,
> +	.max_y = 1320,
> +	.res_x = 30, /* units/mm */
> +	.res_y = 29, /* units/mm */
> +	.contact_size = 5,
> +	.max_contacts = 5,
> +};
> +
>  static const struct asus_touchpad_info asus_t100chi_tp = {
>  	.max_x = 2640,
>  	.max_y = 1320,
> @@ -606,7 +616,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  		if (intf->altsetting->desc.bInterfaceNumber == T100_TPAD_INTF) {
>  			drvdata->quirks = QUIRK_SKIP_INPUT_MAPPING;
> -			drvdata->tp = &asus_t100ta_tp;
> +			/*
> +			 * The T100HA uses the same USB-ids as the T100TAF,
> +			 * but has different max_x / max_y values.
> +			 */
> +			if (dmi_match(DMI_PRODUCT_NAME, "T100HAN"))
> +				drvdata->tp = &asus_t100ha_tp;
> +			else
> +				drvdata->tp = &asus_t100ta_tp;
>  		}
>  	}
>  
> @@ -751,7 +768,10 @@ static const struct hid_device_id asus_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3), QUIRK_G752_KEYBOARD },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> -		USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD),
> +		USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD),
> +	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +		USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
>  	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5da3d6256d25..dc1db8558850 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -178,7 +178,8 @@
>  #define USB_VENDOR_ID_ASUSTEK		0x0b05
>  #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
>  #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
> -#define USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD	0x17e0
> +#define USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD	0x17e0
> +#define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD	0x1807
>  #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
>  #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
>  #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 015e0c10248b..1cf1e9a0d699 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -284,7 +284,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD) },
> -- 
> 2.14.3
> 
