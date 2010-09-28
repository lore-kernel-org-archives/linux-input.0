From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Sitronix ST9RM01 multitouch panel
Date: Tue, 28 Sep 2010 20:24:29 +0200
Message-ID: <4CA232DD.7070803@euromail.se>
References: <20100928093949.26553.55566.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:52840 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755902Ab0I1SZZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 14:25:25 -0400
In-Reply-To: <20100928093949.26553.55566.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rudy Huang <rudy_huang@sitronix.com.tw>
Cc: Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, jkosina@suse.cz, =?UTF-8?B?U3TDqXBoYW5lIENoYXR0eQ==?= <chatty@enac.fr>

Hi Rudy,

> diff --git a/drivers/hid/hid-sitronix.c b/drivers/hid/hid-sitronix.c
> new file mode 100644
> index 0000000..8608b12
> --- /dev/null
> +++ b/drivers/hid/hid-sitronix.c
> @@ -0,0 +1,286 @@
> +/*
> + *  HID driver for Sitronix ST9RM01 multitouch panels
> + *
> + *  Copyright (c) 2010 Gaggery Tsai <gaggery.tsai@gmail.com>


Since this driver is heavily based on the other MT hid drivers, it would be nice
with a recognition here. Or better, as Stephane said, perhaps this driver could
simply be merged with hid-stantum.c?

> + *
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +#define DRIVER_AUTHOR           "Sitronix, Inc."
> +#define DRIVER_NAME             "sitronix"
> +#define DRIVER_DESC             "Sitronix USB touch"
> +#define DRIVER_DATE             "20100903"
> +#define DRIVER_MAJOR            1
> +#define DRIVER_MINOR            2
> +#define DRIVER_PATCHLEVEL       0
> +
> +MODULE_AUTHOR("Gaggery Tsai <gaggery.tsai@gmail.com>");
> +MODULE_DESCRIPTION("Sitronix HID multitouch panels");
> +MODULE_LICENSE("GPL");
> +
> +#include "hid-ids.h"
> +
> +struct sitronix_data {
> +	s32 x, y, z, w, h;	/* x, y, pressure, width, height */
> +	u16 id;		/* touch id */
> +	bool valid;		/* valid finger data, or just placeholder? */
> +	bool first;		/* first finger in the HID packet? */
> +	bool activity;		/* at least one active finger so far? */
> +};


How many contacts does the device support?

> +
> +static int sitronix_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> +		struct hid_field *field, struct hid_usage *usage,
> +		unsigned long **bit, int *max)
> +{
> +	switch (usage->hid & HID_USAGE_PAGE) {
> +
> +	case HID_UP_GENDESK:
> +		switch (usage->hid) {
> +		case HID_GD_X:
> +			hid_map_usage(hi, usage, bit, max,
> +					EV_ABS, ABS_MT_POSITION_X);
> +			/* touchscreen emulation */
> +			input_set_abs_params(hi->input, ABS_X,
> +						field->logical_minimum,
> +						field->logical_maximum, 0, 0);
> +			return 1;
> +		case HID_GD_Y:
> +			hid_map_usage(hi, usage, bit, max,
> +					EV_ABS, ABS_MT_POSITION_Y);
> +			/* touchscreen emulation */
> +			input_set_abs_params(hi->input, ABS_Y,
> +						field->logical_minimum,
> +						field->logical_maximum, 0, 0);
> +			return 1;
> +		}
> +		return 0;
> +
> +	case HID_UP_DIGITIZER:
> +		switch (usage->hid) {
> +		case HID_DG_INRANGE:
> +		case HID_DG_CONFIDENCE:
> +		case HID_DG_INPUTMODE:
> +		case HID_DG_DEVICEINDEX:
> +		case HID_DG_CONTACTCOUNT:
> +		case HID_DG_CONTACTMAX:
> +
> +			return -1;
> +
> +		case HID_DG_TIPSWITCH:
> +			/* touchscreen emulation */
> +			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
> +			return 1;
> +
> +		case HID_DG_WIDTH:
> +			hid_map_usage(hi, usage, bit, max,
> +					EV_ABS, ABS_MT_TOUCH_MAJOR);
> +			return 1;
> +		case HID_DG_HEIGHT:
> +			hid_map_usage(hi, usage, bit, max,
> +					EV_ABS, ABS_MT_TOUCH_MINOR);
> +			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
> +					1, 1, 0, 0);


This line is copying an error that there is a recent patch for.

> +			return 1;
> +		case HID_DG_CONTACTID:
> +			hid_map_usage(hi, usage, bit, max,
> +					EV_ABS, ABS_MT_TRACKING_ID);


This usage of ABS_MT_TRACKING_ID is not ideal. The HID contact id normally maps
to a slot number, which suggests the MT slots protocol be used instead.

On a completely different note, there is a new virtual testing project,
https://wiki.ubuntu.com/Multitouch/Testing/uTouchEvEmu, which could be of
interest to those seeking to formalize driver capabilities beyond the driver code.

> +			return 1;
> +
> +		}
> +		return 0;
> +
> +	case 0xff000000:
> +		/* no input-oriented meaning */
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sitronix_input_mapped(struct hid_device *hdev, struct hid_input *hi,
> +		struct hid_field *field, struct hid_usage *usage,
> +		unsigned long **bit, int *max)
> +{
> +	if (usage->type == EV_KEY || usage->type == EV_ABS)
> +		clear_bit(usage->code, *bit);
> +
> +	return 0;
> +
> +}
> +
> +/*
> + * this function is called when a whole finger has been parsed,
> + * so that it can decide what to send to the input layer.
> + */
> +static void sitronix_filter_event(struct sitronix_data *sd,
> +					struct input_dev *input)
> +{
> +	bool wide;
> +
> +	if (!sd->valid) {
> +		/*
> +		 * touchscreen emulation: if the first finger is not valid and
> +		 * there previously was finger activity, this is a release
> +		 */
> +		if (sd->first && sd->activity) {
> +			input_event(input, EV_KEY, BTN_TOUCH, 0);
> +			sd->activity = false;
> +		}
> +		return;
> +	}


I believe this touch construction is error prone.

> +
> +	input_event(input, EV_ABS, ABS_MT_TRACKING_ID, sd->id);
> +	input_event(input, EV_ABS, ABS_MT_POSITION_X, sd->x);
> +	input_event(input, EV_ABS, ABS_MT_POSITION_Y, sd->y);
> +
> +	wide = (sd->w > sd->h);
> +	input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
> +	input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, wide ? sd->w : sd->h);
> +	input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, wide ? sd->h : sd->w);
> +
> +	input_mt_sync(input);
> +	sd->valid = false;
> +
> +	/* touchscreen emulation */
> +	if (sd->first) {
> +		if (!sd->activity) {
> +			input_event(input, EV_KEY, BTN_TOUCH, 1);
> +			sd->activity = true;
> +		}
> +		input_event(input, EV_ABS, ABS_X, sd->x);
> +		input_event(input, EV_ABS, ABS_Y, sd->y);
> +	}
> +	sd->first = false;


Same here. How about is_touch = number_of_fingers > 0? Works nicely in many
other drivers.

> +}
> +
> +
> +static int sitronix_event(struct hid_device *hid, struct hid_field *field,
> +				struct hid_usage *usage, s32 value)
> +{
> +	struct sitronix_data *sd = hid_get_drvdata(hid);
> +
> +	if (hid->claimed & HID_CLAIMED_INPUT) {
> +		struct input_dev *input = field->hidinput->input;
> +
> +		switch (usage->hid) {
> +		case HID_DG_INRANGE:
> +			/* this is the last field in a finger */
> +			if (value > 0)
> +				sd->valid = true;
> +			else
> +				sd->valid = false;
> +			break;


sd->valid = value would suffice.

> +		case HID_DG_WIDTH:
> +			sd->w = value;
> +			break;
> +		case HID_DG_HEIGHT:
> +			sd->h = value;
> +			sitronix_filter_event(sd, input);


This kind of construction is unfortunate, because similar devices may have a
different attribute set, of the attributes may appear in a different order.
Better would be to allow to first collect all attributes in random order, then
perform the contact update.

> +			break;
> +		case HID_GD_X:
> +			sd->x = value;
> +			break;
> +		case HID_GD_Y:
> +			sd->y = value;
> +			break;
> +		case HID_DG_CONTACTID:
> +			if (value == 4)
> +				sd->first = true;
> +			sd->id = value;
> +			break;


Is contact ID == 4 a special value of some sorts?

> +		case HID_DG_CONFIDENCE:
> +			break;
> +		case HID_DG_CONTACTCOUNT:
> +			/* this comes only before the first finger */
> +			break;
> +
> +		default:
> +			/* ignore the others */
> +			return 1;
> +		}
> +	}
> +
> +	/* we have handled the hidinput part, now remains hiddev */
> +	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_hid_event)
> +		hid->hiddev_hid_event(hid, field, usage, value);
> +	return 1;
> +}
> +
> +static int sitronix_probe(struct hid_device *hdev,
> +				const struct hid_device_id *id)
> +{
> +	int ret;
> +	struct sitronix_data *sd;

> +
> +	sd = kmalloc(sizeof(struct sitronix_data), GFP_KERNEL);
> +	if (!sd) {
> +		dev_err(&hdev->dev, "cannot allocate Stantum data\n");
> +		return -ENOMEM;
> +	}
> +	sd->valid = false;
> +	sd->first = false;
> +	sd->activity = false;
> +	hid_set_drvdata(hdev, sd);


Please use kzalloc() instead of manually setting variables to zero.

> +
> +	ret = hid_parse(hdev);
> +	if (!ret)
> +		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +
> +	if (ret)
> +		kfree(sd);
> +
> +	return ret;
> +}
> +
> +static void sitronix_remove(struct hid_device *hdev)
> +{
> +	hid_hw_stop(hdev);
> +	kfree(hid_get_drvdata(hdev));
> +	hid_set_drvdata(hdev, NULL);
> +}
> +
> +static const struct hid_device_id sitronix_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SITRONIX, USB_DEVICE_ID_ST9RM01) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, sitronix_devices);
> +
> +static const struct hid_usage_id sitronix_grabbed_usages[] = {
> +	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
> +	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
> +};
> +
> +static struct hid_driver sitronix_driver = {
> +	.name = "sitronix",
> +	.id_table = sitronix_devices,
> +	.probe = sitronix_probe,
> +	.remove = sitronix_remove,
> +	.input_mapping = sitronix_input_mapping,
> +	.input_mapped = sitronix_input_mapped,
> +	.usage_table = sitronix_grabbed_usages,
> +	.event = sitronix_event,
> +};
> +
> +static int __init sitronix_init(void)
> +{
> +	return hid_register_driver(&sitronix_driver);
> +}
> +
> +static void __exit sitronix_exit(void)
> +{
> +	hid_unregister_driver(&sitronix_driver);
> +}
> +
> +module_init(sitronix_init);
> +module_exit(sitronix_exit);
> +


Thanks,
Henrik
