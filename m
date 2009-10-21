From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: N-trig support
Date: Wed, 21 Oct 2009 06:14:38 -0400
Message-ID: <4ADEDF0E.6070905@seas.upenn.edu>
References: <4AD5DEF5.9020401@suse.com> <200910150547.30061.webmaster@geomaticien.com> <4AD6BEF8.6040308@seas.upenn.edu> <200910210639.08138.webmaster@geomaticien.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030009040602080207070103"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:53562 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbZJUKbd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2009 06:31:33 -0400
In-Reply-To: <200910210639.08138.webmaster@geomaticien.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: webmaster@geomaticien.com
Cc: Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------030009040602080207070103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel FAIVRE wrote:
>
> - reported a bug for outdated n--trig.c , suggesting is replacement by the one
> from git as suggested by Rafi.
> https://bugzilla.novell.com/show_bug.cgi?id=548463
>
> - tested the last linuxwacom-dev from cvs, patched to support n-trig :
> the touch support is far better with the dev version : a touch tap is a click
> far more easily than with the last release. Touch beacame very smooth, as
> much as comfortable as under windows !
> Last commit on linuxwacom was "Support Tablet PCs 0xE2 and 0xE3 as well as
> touch only tablet 0x9F" : THE NTRIG PATCH IS STILL MISSING !!!

Yes, the tapping behavior improved, but after a personal request I took another look and have an experimental version which is
actually quite a bit better (for tapping).

I have not posted this yet because it still has a couple of odd behaviors and I haven't had time to sort them out.  First, sometimes
buttons get stuck down (not sure if its only the eraser or other stylus buttons).  Secondly, I'm seeing warping (pointer jumps from
a distant location).

I have not planned to spend time on it for at least another week, but if you find the tap improvement is important and you're trying
to prepare for a release, I will try to get this fixed this week.

> Multitouch support :
> In wcmUSB.c, we can see that support for multitouch is now included, waiting
> an event BTN_TOOL_TRIPLETAP.
> A new option for xorg.conf, "Gesture", is used.
> Actually, this could not work for n-trig because hid-ntrig.ko does NOT send
> any BTN_TOOL_TRIPLETAP event, but it may be something to investigate ?

As for multitouch I have not gone as considering the wacom support.  I have never seen events multitouch events come from my
digitizer to the kernel in linux.  Stephane did have that working, but only with an earlier version of the firmware.  I'm not sure
what he used for his demos, but it wasn't the wacom driver.

Our current working hypothesis is that we just need to pass the digitizer some commands during initialization.  I'd be happy for
help if anyone has the desire and the time to work on that.


> Screen buttons support :
> Among patches for linuxwacom on sourceforge, one is used to detect and convert
> events from these three buttons.

At least for the xt (4 buttons) and xt2 (3 buttons).  The screen buttons just send relatively normal key events, just with funny
codes.  I personally just map them at boot with setkeycodes:
	setkeycodes e01f 72     e01b 75 e023 77 e01e 80 e058 120 e018 121 e01a 122 e017 123
(the other four are arrow buttons on the side of the screen of the xt).

> X crashes : I encounter some X crashes with wacom_drv.so :
> The system log reports :
> wacom: v1.49-pc-1:USB Wacom Graphire and Wacom Intuos tablet driver
> [Xorg[2694]: segfault at 6a0000000f ip 00007fded576e5c5 sp 00007fff73602780
> error 4 in wacom_drv.so [7fded578000+18000]
>
> Wacom X drivers compiled from last release or from cvs have the same issue.
> That happens always when quitting an X session, and freeze display and all
> input devices, including keyboard. That also sometimes happens at boottime
> when starting X.
> When X crash after booting, logs always reports things like :
> 0 is not supported by linuxwacom or
> 1F is not supported by linuxwacom ...
> When closing the X session, it seems to be related to :
> X(deleteInputDeviceRequest+0x3b) [0x47713b]
>
> In both cases, this issue seems related to wrong device vendor/product used in
> linuxwacom. Any idea to fix that ?

I'm using an update from cvs from October 5.  I have not seen any crashes related to the wacom driver, nor have I seen any such
crashes in recent memory (at least a year).

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkre3w4ACgkQwuRiAT9o60/N0gCfazn/u2wIr1DoF3/2gHnv0PDu
fOUAn0nHfVhburgRKScDZStr68+q/GC+
=8XAC
-----END PGP SIGNATURE-----

--------------030009040602080207070103
Content-Type: text/x-csrc;
 name="hid-ntrig.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hid-ntrig.c"

/*
 *  HID driver for N-Trig touchscreens
 *
 *  Copyright (c) 2008 Rafi Rubin
 *  Copyright (c) 2009 Stephane Chatty
 *
 */

/*
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 */

#include <linux/device.h>
#include <linux/hid.h>
#include <linux/module.h>

#include "hid-ids.h"

#define NTRIG_DUPLICATE_USAGES	0x001

#define nt_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
					EV_KEY, (c))

struct ntrig_data {
	__s32 x, y, id, w, h;
	char reading_a_point, found_contact_id;
	char pen_active;
	char finger_active;
	char inverted;
	__s32 tool;
	char inrange;
};

/*
 * this driver is aimed at two firmware versions in circulation:
 *  - dual pen/finger single touch
 *  - finger multitouch, pen not working
 */

static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
		struct hid_field *field, struct hid_usage *usage,
		unsigned long **bit, int *max)
{
	switch (usage->hid & HID_USAGE_PAGE) {

	case HID_UP_GENDESK:
		switch (usage->hid) {
		case HID_GD_X:
			hid_map_usage(hi, usage, bit, max,
					EV_ABS, ABS_MT_POSITION_X);
			input_set_abs_params(hi->input, ABS_X,
					field->logical_minimum,
					field->logical_maximum, 0, 0);
			return 1;
		case HID_GD_Y:
			hid_map_usage(hi, usage, bit, max,
					EV_ABS, ABS_MT_POSITION_Y);
			input_set_abs_params(hi->input, ABS_Y,
					field->logical_minimum,
					field->logical_maximum, 0, 0);
			return 1;
		}
		return 0;

	case HID_UP_DIGITIZER:
		switch (usage->hid) {
		/* we do not want to map these for now */
		case HID_DG_CONTACTID: /* value is useless */
		case HID_DG_INPUTMODE:
		case HID_DG_DEVICEINDEX:
		case HID_DG_CONTACTCOUNT:
		case HID_DG_CONTACTMAX:
			return 0;

		/* original mapping by Rafi Rubin */
		case HID_DG_CONFIDENCE:
			nt_map_key_clear(BTN_TOOL_DOUBLETAP);
			return 1;

		/* width/height mapped on TouchMajor/TouchMinor/Orientation */
		case HID_DG_WIDTH:
			hid_map_usage(hi, usage, bit, max,
					EV_ABS, ABS_MT_TOUCH_MAJOR);
			return 1;
		case HID_DG_HEIGHT:
			hid_map_usage(hi, usage, bit, max,
					EV_ABS, ABS_MT_TOUCH_MINOR);
			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
					0, 1, 0, 0);
			return 1;
		}
		return 0;

	case 0xff000000:
		/* we do not want to map these: no input-oriented meaning */
		return -1;
	}

	return 0;
}

static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
		struct hid_field *field, struct hid_usage *usage,
		unsigned long **bit, int *max)
{
	if (usage->type == EV_KEY || usage->type == EV_REL
			|| usage->type == EV_ABS)
		clear_bit(usage->code, *bit);

	return 0;
}

/*
 * this function is called upon all reports
 * so that we can filter contact point information,
 * decide whether we are in multi or single touch mode
 * and call input_mt_sync after each point if necessary
 */
static int ntrig_event (struct hid_device *hid, struct hid_field *field,
		                        struct hid_usage *usage, __s32 value)
{
	struct input_dev *input = field->hidinput->input;
	struct ntrig_data *nd = hid_get_drvdata(hid);

        if (hid->claimed & HID_CLAIMED_INPUT) {
		switch (usage->hid) {

		case HID_DG_INRANGE:
			input_sync(input);
			if (nd->tool!= field->application)
			{
				if (field->application == HID_DG_PEN)
				{
					input_report_key(input, BTN_TOOL_DOUBLETAP, 0);
					input_report_key(input, nd->inverted ? BTN_TOOL_RUBBER : 
							BTN_TOOL_PEN, (value != 0));
				}
				else if(field->application == HID_DG_TOUCHSCREEN)
				{
					input_report_key(input, BTN_TOOL_RUBBER, 0);
					input_report_key(input, BTN_TOOL_PEN, 0);
					input_report_key(input, BTN_TOOL_DOUBLETAP, (value != 0));
				}
				else
				{
				}
				input_sync(input);
				nd->tool=field->application;
			}
			else
			{
				if((value != 0) && (nd->inrange == 0))
				{
					if (field->application == HID_DG_PEN)
					{
						input_report_key(input, nd->inverted ? BTN_TOOL_RUBBER : 
								BTN_TOOL_PEN, 1);
					}
					//HID_DG_TOUCHSCREEN
					else if(field->application == HID_DG_TOUCHSCREEN)
					{
						input_report_key(input, BTN_TOOL_DOUBLETAP, 1);
					}
				}
				input_sync(input);
			}
			nd->inrange= (value != 0);
			break;

		case HID_DG_INVERT:
			if (field->application == HID_DG_PEN && nd->inverted != value)
			{
				input_report_key(input,
						nd->inverted ? BTN_TOOL_RUBBER : BTN_TOOL_PEN
						, 0);
				input_report_key(input,
						value ? BTN_TOOL_RUBBER : BTN_TOOL_PEN
						, nd->inrange);
				input_sync(input);
			}
			nd->inverted = value;
			return 0;

		case HID_GD_X:
			nd->x = value;
			nd->reading_a_point = 1;
			break;
		case HID_GD_Y:
			nd->y = value;
			break;
		case HID_DG_CONTACTID:
			nd->id = value;
			/* we receive this only when in multitouch mode */
			nd->found_contact_id = 1;
			break;
		case HID_DG_WIDTH:
			nd->w = value;
			break;
		case HID_DG_HEIGHT:
			nd->h = value;
			break;
		case HID_DG_CONFIDENCE:
				input_event(input, EV_ABS, ABS_X, nd->x);
				input_event(input, EV_ABS, ABS_Y, nd->y);
				input_sync(input);
			return 0;
		case HID_DG_TIPPRESSURE:
			/*
			 * when in single touch mode, this is the last
			 * report received in a pen event. We want
			 * to emit a normal (X, Y) position
			 */
			if (! nd->found_contact_id) {
				input_event(input, EV_ABS, ABS_X, nd->x);
				input_event(input, EV_ABS, ABS_Y, nd->y);
				input_event(input, EV_ABS, ABS_PRESSURE, value);
				input_sync(input);
			}
			break;
		case 0xff000002:
			/*
			 * we receive this when the device is in multitouch
			 * mode. The first of the three values tagged with
			 * this usage tells if the contact point is real
			 * or a placeholder
			 */
			if (!nd->reading_a_point || value != 1)
				break;
			/* emit a normal (X, Y) for the first point only */
			if (nd->id == 0) {
				input_event(input, EV_ABS, ABS_X, nd->x);
				input_event(input, EV_ABS, ABS_Y, nd->y);
			}
			input_event(input, EV_ABS, ABS_MT_POSITION_X, nd->x);
			input_event(input, EV_ABS, ABS_MT_POSITION_Y, nd->y);
			if (nd->w > nd->h) {
				input_event(input, EV_ABS,
						ABS_MT_ORIENTATION, 1);
				input_event(input, EV_ABS,
						ABS_MT_TOUCH_MAJOR, nd->w);
				input_event(input, EV_ABS,
						ABS_MT_TOUCH_MINOR, nd->h);
			} else {
				input_event(input, EV_ABS,
						ABS_MT_ORIENTATION, 0);
				input_event(input, EV_ABS,
						ABS_MT_TOUCH_MAJOR, nd->h);
				input_event(input, EV_ABS,
						ABS_MT_TOUCH_MINOR, nd->w);
			}
			input_mt_sync(field->hidinput->input);
			nd->reading_a_point = 0;
			nd->found_contact_id = 0;
			break;

		default:
			/* fallback to the generic hidinput handling */
			return 0;
		}
	}

	/* we have handled the hidinput part, now remains hiddev */
        if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
                hid->hiddev_hid_event(hid, field, usage, value);

	return 1;
}

static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
{
	int ret;
	struct ntrig_data *nd;

	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
	nd->inrange=0;
	nd->tool=0;
	if (!nd) {
		dev_err(&hdev->dev, "cannot allocate N-Trig data\n");
		return -ENOMEM;
	}
	nd->reading_a_point = 0;
	nd->found_contact_id = 0;
	hid_set_drvdata(hdev, nd);

	ret = hid_parse(hdev);
	if (!ret)
		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);

	if (ret)
		kfree (nd);

	return ret;
}

static void ntrig_remove(struct hid_device *hdev)
{
	hid_hw_stop(hdev);
	kfree(hid_get_drvdata(hdev));
}

static const struct hid_device_id ntrig_devices[] = {
	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN),
		.driver_data = NTRIG_DUPLICATE_USAGES },
	{ }
};
MODULE_DEVICE_TABLE(hid, ntrig_devices);

static const struct hid_usage_id ntrig_grabbed_usages[] = {
	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
};

static struct hid_driver ntrig_driver = {
	.name = "ntrig",
	.id_table = ntrig_devices,
	.probe = ntrig_probe,
	.remove = ntrig_remove,
	.input_mapping = ntrig_input_mapping,
	.input_mapped = ntrig_input_mapped,
	.usage_table = ntrig_grabbed_usages,
	.event = ntrig_event,
};

static int __init ntrig_init(void)
{
	return hid_register_driver(&ntrig_driver);
}

static void __exit ntrig_exit(void)
{
	hid_unregister_driver(&ntrig_driver);
}

module_init(ntrig_init);
module_exit(ntrig_exit);
MODULE_LICENSE("GPL");

--------------030009040602080207070103--
