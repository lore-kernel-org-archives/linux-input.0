From: Anton Chikin <Anton.Chikin@dataart.com>
Subject: RE: [PATCH] HID: added new driver for Panasonic Elite Panaboard
 UB-T780 and UB-T880
Date: Tue, 8 Feb 2011 15:28:24 +0300
Message-ID: <3BF066A8BAB61C43B779966CEE6D7FA09B6CC9DB2D@e6.universe.dart.spb>
References: <1297157786-2004-1-git-send-email-kverlin@gmail.com>
 <20110208103923.GA2009@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110208103923.GA2009@polaris.bitmath.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Anton Chikin <kverlin@gmail.com>
Cc: "jkosina@suse.cz" <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gregory Burmistrov <grig@dataart.com>
List-Id: linux-input@vger.kernel.org

Hi Henrik,

Thank you for your comments. I'll clean up the code. I still have several questions for you. Please find them above.

With best regards,
Anton
-----Original Message-----
From: Henrik Rydberg [mailto:rydberg@euromail.se] 


> +static int LTx = -1;
> +static int LTy = -1;
> +static int LBx = -1;
> +static int LBy = -1;
> +static int RTx = -1;
> +static int RTy = -1;
> +static int RBx = -1;
> +static int RBy = -1;
> +
> +static int LTX = -1;
> +static int LTY = -1;
> +static int LBX = -1;
> +static int LBY = -1;
> +static int RTX = -1;
> +static int RTY = -1;
> +static int RBX = -1;
> +static int RBY = -1;
> +
> +static int Xoff_A = -1;
> +static int Xmag_A = -1;
> +static int Xmag_B = -1;
> +static int Yoff_A = -1;
> +static int Ymag_A = -1;
> +static int Ymag_B = -1;

> This is a lot of variables. Surely it can be simplified someway?
First 16 vars are screen and device coordinates. Other 6 are precalculated in userspace during calibration.
I can eliminate them and add more calculations to calibration function. Should I?

> +	if (!Xmag)
> +		Xmag = 1;

>Why?

> +	x  = (inX * 10000 - Xoff) / Xmag;

Not to divide by zero here.

> +static void ubt780_set_input(struct input_dev *input) {
> +	input->evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS);
> +	input->absbit[0] |= BIT(ABS_X) | BIT(ABS_Y);
> +	set_bit(BTN_LEFT, input->keybit);
> +	set_bit(BTN_RIGHT, input->keybit);
> +
> +	input->absmax[ABS_X] = UBT780_MAX_AXIS_X;
> +	input->absmax[ABS_Y] = UBT780_MAX_AXIS_Y;
> +	input->absmin[ABS_X] = 0;
> +	input->absmin[ABS_Y] = 0;
> +}

> This looks like standard HID stuff, and could probably be setup automatically.
The report of UB-T780 is a little bit broken. I prefer to write 8 straight and clear lines of code from scratch
Instead of tuning and debugging standard HID parser.

> +
> +int ubt_set_device(struct ubt880_data *data, __u32 devid) {
> +	int ret;
> +	data->calib.calibrated = 0;
> +	data->ubt_packet.report = 0;
> +	set_calib_to_device(data);
> +	switch (devid) {
> +	case USB_DEVICE_ID_PANABOARD_UBT780: {
> +		data->switch_mode = ubt780_switch_mode;
> +		data->set_input = ubt780_set_input;
> +		break;
> +	}
> +	case USB_DEVICE_ID_PANABOARD_UBT880: {
> +		data->switch_mode = ubt880_switch_mode;
> +		data->set_input = ubt880_set_input;
> +		break;
> +	}
> +	default: {
> +		ret = -1;
> +	}
> +	}
> +	return 0;
> +}

> Static table would work too.
Do you mean that it would be better to make a separate static table 
for each device and keep one pointer to it instead of multiple pointers to functions?


> +static const struct file_operations ubt880_fops = {
> +	.owner = THIS_MODULE,
> +	.open = ubt880_open_io,
> +	.release = ubt880_release_io,
> +	.unlocked_ioctl = ubt880_ioctl,
> +};

> And this is used solely to communicate with the device for calibration and such? Why is it even part of this driver?
> The above seems like a different driver altogether, and possibly better implemented in userland.

I really need your advice at this point. To calibrate the device we need to do the following:
1. set particular device state
2. read coordinates from device
3. set calibration data back to device
4. set back the device state

I have not written this driver from scratch - I've got the driver and userland calibration utility from previous developers.
At that time it was usbhid fork so I've considered to rewirte it using hid framework, but I've left ioctl communications to keep it compatible
with userland utilities.
Is there a better way to achieve all this not using ioctls? 
Is it worth redoing all this work using sysfs?


> +static void ubt880_report_mt(struct input_dev *input, struct 
> +ubt_mt_contact *pack, int size, struct ubt_calib *calib) {
> +	int i = 0;
> +	/* Report MT contacts */
> +	if (size < 1)
> +		return;
> +	if (!input || !pack || !calib)
> +		return;

> what do these error paths mean?
This is just checks to defend from errors in calling code.
