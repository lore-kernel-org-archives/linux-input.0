From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: your mail
Date: Wed, 25 Jan 2012 15:09:24 +0100
Message-ID: <4F200D14.80702@gmail.com>
References: <BROWNM3h3vLgAusVxON00000cfa@brown.emailprod.vodafone.se> <20120125132612.GA3890@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48857 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab2AYOJ1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jan 2012 09:09:27 -0500
Received: by werb13 with SMTP id b13so3813995wer.19
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2012 06:09:26 -0800 (PST)
In-Reply-To: <20120125132612.GA3890@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

Hi Henrik,

Op 25-01-12 14:26, Henrik Rydberg schreef:
> Hi Maurus,
>
>> Subject: [RFC] HID: add Microsoft Touch Mouse driver
>>
>> This patch adds support for the proprietary Microsoft Touch Mouse
>> multitouch protocol.
> Exciting stuff, nice job on the patch too. Please find some initial
> comments inline.
>
>> @@ -0,0 +1,371 @@
>> +/*
>> + *  HID driver for the Microsoft Touch Mouse
>> + *
>> + *  Copyright (c) 2011 Maurus Cuelenaere<mcuelenaere@gmail.com>
>> + *
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>> + *
>> + */
>> +
>> +#include<linux/device.h>
>> +#include<linux/input.h>
>> +#include<linux/hid.h>
>> +#include<linux/module.h>
>> +#include<linux/usb.h>
>> +
>> +#include "hid-ids.h"
>> +
>> +#define MSTM_RAW_DATA_HID_ID		0x27
>> +#define MSTM_RAW_DATA_FOOTER		0x51
>> +
>> +#define MSTM_DATA_WIDTH			15
>> +#define MSTM_DATA_HEIGHT		13
>> +
>> +struct mstm_raw_data_packet {
>> +	__u8 hid_id;
>> +	__u8 data_length;
>> +	__u16 unk1;
>> +	__u8 unk2;
>> +	__u8 footer;
>> +	__u8 timestamp;
>> +	__u8 data[25]; /* milliseconds */
>> +};
> I take it this means you get at most 50 nibbles per transfer?

Correct.

Hmm, looks like that milliseconds comment needs to be on the line above it.

>> +
>> +struct mstm_state {
>> +	bool advance_flag;
>> +	int x;
>> +	int y;
>> +	unsigned char last_timestamp;
>> +	unsigned char data[MSTM_DATA_WIDTH][MSTM_DATA_HEIGHT];
>> +};
> The ability to simply send an "input screen" would be perfect
> here. This device may be on the border of what can/should be handled
> via input events. A memory mapped driver, uio-based or something
> similar, could be an option.

In my first tests, I was doing readouts in userspace using hidraw, which 
performed quite well.

Bandwidth could be an issue, but I'd like to use the current APIs as 
much as possible so I don't need to go modifying mtdev, X, ...

>> +
>> +struct mstm_device {
>> +	struct input_dev *input;
>> +
>> +	struct mstm_state state;
>> +};
>> +
>> +#define MSTM_INTERFACE_KEYBOARD		0
>> +#define MSTM_INTERFACE_MOUSE		1
>> +#define MSTM_INTERFACE_CONTROL		2
>> +
>> +static inline int hid_get_interface_number(struct hid_device *hdev) {
>> +	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
>> +	return intf->cur_altsetting->desc.bInterfaceNumber;
>> +}
>> +
>> +/*
>> + * The mouse sensor only yields data for a specific part of its surface.
>> + * Because of this, we can't just increase x and y uniformly; so there's
>> + * a need for this simple algorithm.
>> + *
>> + * Visual representation of available data:
>> + *    0 1 2 3 4 5 6 7 8 9 A B C D E F
>> + *  0       * * * * * * * * * *
>> + *  1     * * * * * * * * * * * *
>> + *  2   * * * * * * * * * * * * * *
>> + *  3   * * * * * * * * * * * * * *
>> + *  4 * * * * * * * * * * * * * * * *
>> + *  5 * * * * * * * * * * * * * * * *
>> + *  6 * * * * * * * * * * * * * * * *
>> + *  7 * * * * * * * * * * * * * * * *
>> + *  8 * * * * * * * * * * * * * * * *
>> + *  9 * * * * * * * * * * * * * * * *
>> + *  A * * * * * * * * * * * * * * * *
>> + *  B * * * * * * * * * * * * * * * *
>> + *  C * * * * * * * * * * * * * * * *
>> + *  D * * * * * * * * * * * * * * * *
>> + */
>> +static void mstm_advance_pointer(struct mstm_state *state)
>> +{
>> +	int max, nextMin;
>> +
>> +	state->x++;
>> +
>> +	switch (state->y) {
>> +	case 0:
>> +		max = 11;
>> +		nextMin = 2;
>> +		break;
>> +	case 1:
>> +		max = 12;
>> +		nextMin = 1;
>> +		break;
>> +	case 2:
>> +		max = 13;
>> +		nextMin = 1;
>> +		break;
>> +	case 3:
>> +		max = 13;
>> +		nextMin = 0;
>> +		break;
>> +	default:
>> +		max = 14;
>> +		nextMin = 0;
>> +		break;
>> +	}
>> +
>> +	if (state->x>  max) {
>> +		state->y++;
>> +		state->x = nextMin;
>> +	}
>> +}
>> +
>> +static void mstm_parse_nibble(struct mstm_state *state, __u8 nibble)
>> +{
>> +	int i;
>> +
>> +	if (state->advance_flag) {
>> +		state->advance_flag = false;
>> +		for (i = -3; i<  nibble; i++)
>> +			mstm_advance_pointer(state);
>> +	} else {
>> +		if (nibble == 0xF) {
>> +			/* The next nibble will indicate how many
>> +			* positions to advance, so set a flag */
>> +			state->advance_flag = true;
>> +		} else {
>> +			state->data[state->x][state->y] = nibble;
>> +			mstm_advance_pointer(state);
>> +		}
>> +	}
>> +}
> Looking good.
>
>> +static void mstm_push_data(struct hid_device *hdev)
>> +{
>> +	struct mstm_device *mstm_dev = hid_get_drvdata(hdev);
>> +	struct input_dev *input = mstm_dev->input;
>> +	int x, y;
>> +
>> +	for (x = 0; x<  MSTM_DATA_WIDTH; x++) {
>> +		for (y = 0; y<  MSTM_DATA_HEIGHT; y++) {
>> +			unsigned char pressure = mstm_dev->state.data[x][y];
>> +			if (pressure>  0) {
>> +				//input_report_abs(input, ABS_MT_BLOB_ID, 1);
>> +				//input_report_abs(input, ABS_MT_TOUCH_MAJOR, pressure/3);
>> +				input_report_abs(input, ABS_MT_POSITION_X, x);
>> +				input_report_abs(input, ABS_MT_POSITION_Y, y);
>> +				input_mt_sync(input);
>> +			}
>> +		}
>> +	}
> True, the blob id has not yet been used, but its definition is
> different from how it is used here. Also, since you do not attempt any
> kind of clustering (single-linkage or similar), the blob as stated
> might not even be connected.

Indeed, without clustering the BLOB_ID would be useless but that line 
was only for testing with one finger.

> One possible option could be to use the
> slots, but only send ABS_MT_TOUCH_MAJOR or ABS_MT_PRESSURE, nothing
> else. The device would (rightfully) not be recognized as MT since the
> position is missing, all data would be available for processing in
> userspace, and bandwidth would be minimized since there could only be
> so many changes coming in per millisecond.

So how does userspace then finds out where these pressure points are 
located?
Or do you mean to just dump all data to user space (15 * 13 * 
sizeof(ABS_MT_PRESSURE value) + overhead)?

>> +static int mstm_input_mapping(struct hid_device *hdev,
>> +		struct hid_input *hi, struct hid_field *field,
>> +		struct hid_usage *usage, unsigned long **bit, int *max)
>> +{
>> +	struct mstm_device *mstm_dev = hid_get_drvdata(hdev);
>> +
>> +	//printk("mstm_input_mapping(%p)\n", hdev);
>> +
>> +	/* bail early if not the correct interface */
>> +	if (mstm_dev == NULL)
>> +		return 0;
>> +
>> +	/* HACK: get rid of ABS_MT_* params */
>> +	if ((usage->hid&  HID_USAGE_PAGE) == HID_UP_GENDESK)
>> +		return -1;
> I am not sure about the hack here, nor its explanation. ;-)

The HID tables specify some ABS_MT_* values and I didn't know whether 
these were going to conflict with the ones I report above, so I just 
discard all GenericDesktop fields.

root@hp4530s:~# grep MT /sys/kernel/debug/hid/0003\:045E\:0773.0006/rdesc
GenericDesktop.MultiAxis ---> Absolute.MTMajor
GenericDesktop.0009 ---> Absolute.MTMinor
GenericDesktop.000a ---> Absolute.MTMajorW
GenericDesktop.000b ---> Absolute.MTMinorW
GenericDesktop.000c ---> Absolute.MTOrientation
GenericDesktop.000d ---> Absolute.MTPositionX
GenericDesktop.000e ---> Absolute.MTPositionY
GenericDesktop.000f ---> Absolute.MTToolType
GenericDesktop.0010 ---> Absolute.MTBlobID

>> +
>> +	/* map input device to hid device */
>> +	mstm_dev->input = hi->input;
>> +
>> +	return 0;
>> +}
>> +
>> +static void mstm_setup_input(struct mstm_device *mstm)
>> +{
>> +	__set_bit(EV_ABS, mstm->input->evbit);
>> +
>> +	input_set_abs_params(mstm->input, ABS_MT_POSITION_X, 0, MSTM_DATA_WIDTH, 0, 0);
>> +	input_set_abs_params(mstm->input, ABS_MT_POSITION_Y, 0, MSTM_DATA_HEIGHT, 0, 0);
>> +	input_set_abs_params(mstm->input, ABS_MT_TOUCH_MAJOR, 0, 0xF, 0, 0);
>> +	input_set_abs_params(mstm->input, ABS_MT_BLOB_ID, 0, 10, 0, 0);
>> +
>> +	input_abs_set_res(mstm->input, ABS_MT_POSITION_X, 6); /* 83mm */
>> +	input_abs_set_res(mstm->input, ABS_MT_POSITION_Y, 5); /* 70mm */
>> +
>> +	input_set_events_per_packet(mstm->input, 60);
>> +}
> Regarding the resolution of touch major, it is generally assumed (in
> userspace) that the units are the same as the position, so scaling in
> the driver is reasonable. Otherwise, why not specify resolution for
> touch major as well?

I didn't specify it because other HID drivers only specified resolutions 
for POSITION_{X,Y}, I'll try it and see how mtview reacts.

Thanks for the review!

-- 
Maurus Cuelenaere

