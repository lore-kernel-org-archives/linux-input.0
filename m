From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Tue, 8 Mar 2011 14:12:46 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103081410530.19969@pobox.suse.cz>
References: <1299417912.9645.495.camel@itzy>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36533 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589Ab1CHNMv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2011 08:12:51 -0500
In-Reply-To: <1299417912.9645.495.camel@itzy>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Nauber <richard.nauber@googlemail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>

On Sun, 6 Mar 2011, Richard Nauber wrote:

> --- a/drivers/hid/hid-egalax.c
> +++ /dev/null
> @@ -1,279 +0,0 @@
> -/*
> - *  HID driver for eGalax dual-touch panels
> - *
> - *  Copyright (c) 2010 Stephane Chatty <chatty@enac.fr>
> - *  Copyright (c) 2010 Henrik Rydberg <rydberg@euromail.se>
> - *  Copyright (c) 2010 Canonical, Ltd.

As this is (partial) code movement, I believe the copyrights should be 
moved as well.

At least something along the lines 'based on hid-egalax.c copyrighted as 
follows ...' would be nice.

Added Stephane (the other copyright holder) to CC here.

> - *
> - */
> -
> -/*
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the Free
> - * Software Foundation; either version 2 of the License, or (at your option)
> - * any later version.
> - */
> -
> -#include <linux/device.h>
> -#include <linux/hid.h>
> -#include <linux/module.h>
> -#include <linux/usb.h>
> -#include <linux/input/mt.h>
> -#include <linux/slab.h>
> -#include "usbhid/usbhid.h"
> -
> -MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
> -MODULE_DESCRIPTION("eGalax dual-touch panel");
> -MODULE_LICENSE("GPL");
> -
> -#include "hid-ids.h"
> -
> -#define MAX_SLOTS		2
> -
> -/* estimated signal-to-noise ratios */
> -#define SN_MOVE			4096
> -#define SN_PRESSURE		32
> -
> -struct egalax_data {
> -	int valid;
> -	int slot;
> -	int touch;
> -	int x, y, z;
> -};
> -
> -static void set_abs(struct input_dev *input, unsigned int code,
> -		    struct hid_field *field, int snratio)
> -{
> -	int fmin = field->logical_minimum;
> -	int fmax = field->logical_maximum;
> -	int fuzz = snratio ? (fmax - fmin) / snratio : 0;
> -	input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
> -}
> -
> -static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> -		struct hid_field *field, struct hid_usage *usage,
> -		unsigned long **bit, int *max)
> -{
> -	struct input_dev *input = hi->input;
> -
> -	switch (usage->hid & HID_USAGE_PAGE) {
> -
> -	case HID_UP_GENDESK:
> -		switch (usage->hid) {
> -		case HID_GD_X:
> -			field->logical_maximum = 32760;
> -			hid_map_usage(hi, usage, bit, max,
> -					EV_ABS, ABS_MT_POSITION_X);
> -			set_abs(input, ABS_MT_POSITION_X, field, SN_MOVE);
> -			/* touchscreen emulation */
> -			set_abs(input, ABS_X, field, SN_MOVE);
> -			return 1;
> -		case HID_GD_Y:
> -			field->logical_maximum = 32760;
> -			hid_map_usage(hi, usage, bit, max,
> -					EV_ABS, ABS_MT_POSITION_Y);
> -			set_abs(input, ABS_MT_POSITION_Y, field, SN_MOVE);
> -			/* touchscreen emulation */
> -			set_abs(input, ABS_Y, field, SN_MOVE);
> -			return 1;
> -		}
> -		return 0;
> -
> -	case HID_UP_DIGITIZER:
> -		switch (usage->hid) {
> -		case HID_DG_TIPSWITCH:
> -			/* touchscreen emulation */
> -			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
> -			input_set_capability(input, EV_KEY, BTN_TOUCH);
> -			return 1;
> -		case HID_DG_INRANGE:
> -		case HID_DG_CONFIDENCE:
> -		case HID_DG_CONTACTCOUNT:
> -		case HID_DG_CONTACTMAX:
> -			return -1;
> -		case HID_DG_CONTACTID:
> -			input_mt_init_slots(input, MAX_SLOTS);
> -			return 1;
> -		case HID_DG_TIPPRESSURE:
> -			field->logical_minimum = 0;
> -			hid_map_usage(hi, usage, bit, max,
> -					EV_ABS, ABS_MT_PRESSURE);
> -			set_abs(input, ABS_MT_PRESSURE, field, SN_PRESSURE);
> -			/* touchscreen emulation */
> -			set_abs(input, ABS_PRESSURE, field, SN_PRESSURE);
> -			return 1;
> -		}
> -		return 0;
> -	}
> -
> -	/* ignore others (from other reports we won't get anyway) */
> -	return -1;
> -}
> -
> -static int egalax_input_mapped(struct hid_device *hdev, struct hid_input *hi,
> -		struct hid_field *field, struct hid_usage *usage,
> -		unsigned long **bit, int *max)
> -{
> -	/* tell hid-input to skip setup of these event types */
> -	if (usage->type == EV_KEY || usage->type == EV_ABS)
> -		set_bit(usage->type, hi->input->evbit);
> -	return -1;
> -}
> -
> -/*
> - * this function is called when a whole finger has been parsed,
> - * so that it can decide what to send to the input layer.
> - */
> -static void egalax_filter_event(struct egalax_data *td, struct input_dev *input)
> -{
> -	input_mt_slot(input, td->slot);
> -	input_mt_report_slot_state(input, MT_TOOL_FINGER, td->touch);
> -	if (td->touch) {
> -		input_event(input, EV_ABS, ABS_MT_POSITION_X, td->x);
> -		input_event(input, EV_ABS, ABS_MT_POSITION_Y, td->y);
> -		input_event(input, EV_ABS, ABS_MT_PRESSURE, td->z);
> -	}
> -	input_mt_report_pointer_emulation(input, true);
> -}
> -
> -static int egalax_event(struct hid_device *hid, struct hid_field *field,
> -				struct hid_usage *usage, __s32 value)
> -{
> -	struct egalax_data *td = hid_get_drvdata(hid);
> -
> -	/* Note, eGalax has two product lines: the first is resistive and
> -	 * uses a standard parallel multitouch protocol (product ID ==
> -	 * 48xx).  The second is capacitive and uses an unusual "serial"
> -	 * protocol with a different message for each multitouch finger
> -	 * (product ID == 72xx).
> -	 */
> -	if (hid->claimed & HID_CLAIMED_INPUT) {
> -		struct input_dev *input = field->hidinput->input;
> -
> -		switch (usage->hid) {
> -		case HID_DG_INRANGE:
> -			td->valid = value;
> -			break;
> -		case HID_DG_CONFIDENCE:
> -			/* avoid interference from generic hidinput handling */
> -			break;
> -		case HID_DG_TIPSWITCH:
> -			td->touch = value;
> -			break;
> -		case HID_DG_TIPPRESSURE:
> -			td->z = value;
> -			break;
> -		case HID_DG_CONTACTID:
> -			td->slot = clamp_val(value, 0, MAX_SLOTS - 1);
> -			break;
> -		case HID_GD_X:
> -			td->x = value;
> -			break;
> -		case HID_GD_Y:
> -			td->y = value;
> -			/* this is the last field in a finger */
> -			if (td->valid)
> -				egalax_filter_event(td, input);
> -			break;
> -		case HID_DG_CONTACTCOUNT:
> -			/* touch emulation: this is the last field in a frame */
> -			break;
> -
> -		default:
> -			/* fallback to the generic hidinput handling */
> -			return 0;
> -		}
> -	}
> -
> -	/* we have handled the hidinput part, now remains hiddev */
> -	if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
> -		hid->hiddev_hid_event(hid, field, usage, value);
> -
> -	return 1;
> -}
> -
> -static int egalax_probe(struct hid_device *hdev, const struct hid_device_id *id)
> -{
> -	int ret;
> -	struct egalax_data *td;
> -	struct hid_report *report;
> -
> -	td = kzalloc(sizeof(struct egalax_data), GFP_KERNEL);
> -	if (!td) {
> -		hid_err(hdev, "cannot allocate eGalax data\n");
> -		return -ENOMEM;
> -	}
> -	hid_set_drvdata(hdev, td);
> -
> -	ret = hid_parse(hdev);
> -	if (ret)
> -		goto end;
> -
> -	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> -	if (ret)
> -		goto end;
> -
> -	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[5]; 
> -	if (report) {
> -		report->field[0]->value[0] = 2;
> -		usbhid_submit_report(hdev, report, USB_DIR_OUT);
> -	}
> -
> -end:
> -	if (ret)
> -		kfree(td);
> -
> -	return ret;
> -}
> -
> -static void egalax_remove(struct hid_device *hdev)
> -{
> -	hid_hw_stop(hdev);
> -	kfree(hid_get_drvdata(hdev));
> -	hid_set_drvdata(hdev, NULL);
> -}
> -
> -static const struct hid_device_id egalax_devices[] = {
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> -			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> -			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> -			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> -			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> -			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(hid, egalax_devices);
> -
> -static const struct hid_usage_id egalax_grabbed_usages[] = {
> -	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
> -	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
> -};
> -
> -static struct hid_driver egalax_driver = {
> -	.name = "egalax-touch",
> -	.id_table = egalax_devices,
> -	.probe = egalax_probe,
> -	.remove = egalax_remove,
> -	.input_mapping = egalax_input_mapping,
> -	.input_mapped = egalax_input_mapped,
> -	.usage_table = egalax_grabbed_usages,
> -	.event = egalax_event,
> -};
> -
> -static int __init egalax_init(void)
> -{
> -	return hid_register_driver(&egalax_driver);
> -}
> -
> -static void __exit egalax_exit(void)
> -{
> -	hid_unregister_driver(&egalax_driver);
> -}
> -
> -module_init(egalax_init);
> -module_exit(egalax_exit);
> -
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 07d3183..58df924 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -36,6 +36,8 @@ MODULE_LICENSE("GPL");
>  #define MT_QUIRK_SLOT_IS_CONTACTNUMBER	(1 << 3)
>  #define MT_QUIRK_VALID_IS_INRANGE	(1 << 4)
>  #define MT_QUIRK_VALID_IS_CONFIDENCE	(1 << 5)
> +#define MT_QUIRK_EGALAX			(1 << 6)
> +
>  
>  struct mt_slot {
>  	__s32 x, y, p, w, h;
> @@ -69,6 +71,7 @@ struct mt_class {
>  #define MT_CLS_DUAL1	2
>  #define MT_CLS_DUAL2	3
>  #define MT_CLS_CYPRESS	4
> +#define MT_CLS_EGALAX	5
>  
>  /*
>   * these device-dependent functions determine what slot corresponds
> @@ -118,7 +121,13 @@ struct mt_class mt_classes[] = {
>  		.quirks = MT_QUIRK_NOT_SEEN_MEANS_UP |
>  			MT_QUIRK_CYPRESS,
>  		.maxcontacts = 10 },
> -
> +	{ .name = MT_CLS_EGALAX,
> +		.quirks =  MT_QUIRK_SLOT_IS_CONTACTID |
> +			MT_QUIRK_VALID_IS_INRANGE |
> +			MT_QUIRK_EGALAX,
> +		.maxcontacts = 2 ,
> +		.sn_move = 4096,
> +		.sn_pressure = 32},
>  	{ }
>  };
>  
> @@ -146,9 +155,16 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  {
>  	struct mt_device *td = hid_get_drvdata(hdev);
>  	struct mt_class *cls = td->mtclass;
> +
>  	switch (usage->hid & HID_USAGE_PAGE) {
>  
>  	case HID_UP_GENDESK:
> +
> +	/* fix up the X/Y limits for egalax devices*/
> +	if ((cls->quirks & MT_QUIRK_EGALAX)
> +		&& ((usage->hid == HID_GD_X) || (usage->hid == HID_GD_Y)))
> +			field->logical_maximum = 32760;
> +
>  		switch (usage->hid) {
>  		case HID_GD_X:
>  			hid_map_usage(hi, usage, bit, max,
> @@ -203,6 +219,10 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			td->last_slot_field = usage->hid;
>  			return 1;
>  		case HID_DG_TIPPRESSURE:
> +			/* fix up the pressure range for egalax devices*/
> +			if (cls->quirks & MT_QUIRK_EGALAX)
> +				field->logical_minimum = 0;
> +
>  			hid_map_usage(hi, usage, bit, max,
>  					EV_ABS, ABS_MT_PRESSURE);
>  			set_abs(hi->input, ABS_MT_PRESSURE, field,
> @@ -269,8 +289,10 @@ static void mt_complete_slot(struct mt_device *td)
>  
>  		if (slotnum >= 0 && slotnum < td->mtclass->maxcontacts)
>  			td->slots[slotnum] = td->curdata;
> +
>  	}
>  	td->num_received++;
> +
>  }
>  
>  
> @@ -366,12 +388,15 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
>  		if (usage->hid == td->last_slot_field)
>  			mt_complete_slot(td);
>  
> -		if (field->index == td->last_field_index
> +		if ((field->index == td->last_field_index
>  			&& td->num_received >= td->num_expected)
> +			|| ((quirks & MT_QUIRK_EGALAX)
> +				&& (usage->hid == td->last_slot_field)))
> +			/* for egalax devices: emit an event for every finger
> +			to work around the wrong last_field_index in the report*/
>  			mt_emit_event(td, field->hidinput->input);
>  
>  	}
> -
>  	/* we have handled the hidinput part, now remains hiddev */
>  	if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
>  		hid->hiddev_hid_event(hid, field, usage, value);
> @@ -478,6 +503,23 @@ static const struct hid_device_id mt_devices[] = {
>  		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
>  			USB_DEVICE_ID_CANDO_PIXCIR_MULTI_TOUCH) },
>  
> +	/* eGalax devices */
> +	{  .driver_data = MT_CLS_EGALAX,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
> +	{  .driver_data = MT_CLS_EGALAX,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
> +	{  .driver_data = MT_CLS_EGALAX,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
> +	{  .driver_data = MT_CLS_EGALAX,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
> +	{  .driver_data = MT_CLS_EGALAX,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
> +
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, mt_devices);
> -- 
> 1.7.1
> 
> 
> 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
