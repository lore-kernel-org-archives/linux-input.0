From: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
Subject: Re: [PATCH] Support force feedback on MP-8866
Date: Mon, 15 Aug 2011 18:32:47 +0300
Message-ID: <20110815183247.78875t5hxsff6uqo@www.81.fi>
References: <20110814194203.GA19083@pequod.mess.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sd-mail-sa-01.sanoma.fi ([158.127.18.161]:37826 "EHLO
	sd-mail-sa-01.sanoma.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab1HOPm2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2011 11:42:28 -0400
In-Reply-To: <20110814194203.GA19083@pequod.mess.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Quoting Sean Young <sean@mess.org>:

> Support force feedback on the Dual USB Force Feedback Joypad (MP-8866).
>
> Note I do not have the Smartjoy Plus hardware to test if the driver
> still works with that. It should not be affected, though.

Works fine with SmartJoy Plus.

Acked-by: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>

>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 6f3289a..416128a 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1494,6 +1494,7 @@ static const struct hid_device_id  
> hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UNITEC,  
> USB_DEVICE_ID_UNITEC_USB_TOUCH_0709) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UNITEC,  
> USB_DEVICE_ID_UNITEC_USB_TOUCH_0A19) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM,  
> USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,  
> USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,  
> USB_DEVICE_ID_WALTOP_SLIM_TABLET_12_1_INCH) },
> diff --git a/drivers/hid/hid-sjoy.c b/drivers/hid/hid-sjoy.c
> index 16f7caf..6140943 100644
> --- a/drivers/hid/hid-sjoy.c
> +++ b/drivers/hid/hid-sjoy.c
> @@ -65,8 +65,7 @@ static int sjoyff_init(struct hid_device *hid)
>  {
>  	struct sjoyff_device *sjoyff;
>  	struct hid_report *report;
> -	struct hid_input *hidinput = list_entry(hid->inputs.next,
> -						struct hid_input, list);
> +	struct hid_input *hidinput;
>  	struct list_head *report_list =
>  			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
>  	struct list_head *report_ptr = report_list;
> @@ -78,43 +77,45 @@ static int sjoyff_init(struct hid_device *hid)
>  		return -ENODEV;
>  	}
>
> -	report_ptr = report_ptr->next;
> +	list_for_each_entry(hidinput, &hid->inputs, list) {
> +		report_ptr = report_ptr->next;
>
> -	if (report_ptr == report_list) {
> -		hid_err(hid, "required output report is missing\n");
> -		return -ENODEV;
> -	}
> +		if (report_ptr == report_list) {
> +			hid_err(hid, "required output report is missing\n");
> +			return -ENODEV;
> +		}
>
> -	report = list_entry(report_ptr, struct hid_report, list);
> -	if (report->maxfield < 1) {
> -		hid_err(hid, "no fields in the report\n");
> -		return -ENODEV;
> -	}
> +		report = list_entry(report_ptr, struct hid_report, list);
> +		if (report->maxfield < 1) {
> +			hid_err(hid, "no fields in the report\n");
> +			return -ENODEV;
> +		}
>
> -	if (report->field[0]->report_count < 3) {
> -		hid_err(hid, "not enough values in the field\n");
> -		return -ENODEV;
> -	}
> +		if (report->field[0]->report_count < 3) {
> +			hid_err(hid, "not enough values in the field\n");
> +			return -ENODEV;
> +		}
>
> -	sjoyff = kzalloc(sizeof(struct sjoyff_device), GFP_KERNEL);
> -	if (!sjoyff)
> -		return -ENOMEM;
> +		sjoyff = kzalloc(sizeof(struct sjoyff_device), GFP_KERNEL);
> +		if (!sjoyff)
> +			return -ENOMEM;
>
> -	dev = hidinput->input;
> +		dev = hidinput->input;
>
> -	set_bit(FF_RUMBLE, dev->ffbit);
> +		set_bit(FF_RUMBLE, dev->ffbit);
>
> -	error = input_ff_create_memless(dev, sjoyff, hid_sjoyff_play);
> -	if (error) {
> -		kfree(sjoyff);
> -		return error;
> -	}
> +		error = input_ff_create_memless(dev, sjoyff, hid_sjoyff_play);
> +		if (error) {
> +			kfree(sjoyff);
> +			return error;
> +		}
>
> -	sjoyff->report = report;
> -	sjoyff->report->field[0]->value[0] = 0x01;
> -	sjoyff->report->field[0]->value[1] = 0x00;
> -	sjoyff->report->field[0]->value[2] = 0x00;
> -	usbhid_submit_report(hid, sjoyff->report, USB_DIR_OUT);
> +		sjoyff->report = report;
> +		sjoyff->report->field[0]->value[0] = 0x01;
> +		sjoyff->report->field[0]->value[1] = 0x00;
> +		sjoyff->report->field[0]->value[2] = 0x00;
> +		usbhid_submit_report(hid, sjoyff->report, USB_DIR_OUT);
> +	}
>
>  	hid_info(hid, "Force feedback for SmartJoy PLUS PS2/USB adapter\n");
>
> @@ -131,6 +132,8 @@ static int sjoy_probe(struct hid_device *hdev,  
> const struct hid_device_id *id)
>  {
>  	int ret;
>
> +	hdev->quirks |= id->driver_data;
> +
>  	ret = hid_parse(hdev);
>  	if (ret) {
>  		hid_err(hdev, "parse failed\n");
> @@ -152,6 +155,9 @@ err:
>
>  static const struct hid_device_id sjoy_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD),
> +		.driver_data = HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET |
> +			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, sjoy_devices);
> diff --git a/drivers/hid/usbhid/hid-quirks.c  
> b/drivers/hid/usbhid/hid-quirks.c
> index 621959d..df618a3 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -79,7 +79,6 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U,  
> HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_WALTOP,  
> USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_WALTOP,  
> USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH, HID_QUIRK_MULTI_INPUT },
> -	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD,  
> HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT |  
> HID_QUIRK_SKIP_OUTPUT_REPORTS },
>  	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD,  
> HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
>
>  	{ USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS,  
> HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
>
>



