From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Support for Sony NSG-MR5U
Date: Thu, 20 Jun 2013 10:33:29 +0200
Message-ID: <51C2BE59.2030902@gmail.com>
References: <1497744.kpqTRKsYBt@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17375 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965007Ab3FTIdf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jun 2013 04:33:35 -0400
In-Reply-To: <1497744.kpqTRKsYBt@desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Flatt <jflatt@cox.net>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Jason,

On 06/20/2013 08:43 AM, Jason Flatt wrote:
> Hello,
> This is a patch for Sony's GoogleTV multitouch bluetooth remotes, it adds into 
> the shared hid-sony module, and is based on the methods used in the apple 
> magicmouse module.  It builds against the 3.9.0 git tree at:
> git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> Please let me know how it looks, this is my first patch.
> Thank you

Thanks for your first contribution. There is still more work to do, but it's great
to have new contributors.

I have several general comments on your patch and specific details that I have
inlined.

For the general comments:
- the maintainer of the HID subsystem is Jiri Kosina, don't forget to add him in CC
next time if you ever want your patch to land in Linus' tree.
- please use your maintainer's tree[1] to facilitate the inclusion of your patch.
In the "for-next" branch, hid-sony has been changed a lot and your patch can not
be applied.
- please always inline the patch within the mail. It's much easier for us to review
and annotate it. You can use the standard tools "git format-patch" and then "git
send-email" which will send your patch in a proper way.
- Do not forget to sign your patch using "Signed-off-by: Your Name <your@address>".
Without it, Jiri will refuse to include your patch in his tree.
- Add a proper commit message (in addition to the patch's title) explaining why this
patch is required and how you solve the problem, etc...
- beware of the whitespace errors (spaces preceding tabs)
- beware of the 80-column limit
- please do not use the DOS line endings

For most of these comments, you can run the tool ./script/checkpatch.pl in your kernel
tree which will raise most of the common pitfalls we can encounter. In your case, this
tool gives 145 errors, 24 warnings, for 228 lines checked.

- I saw that you tried to add it first into hid-multitouch. Why did it not worked?
If it's because hid-multitouch only handles the multitouch part and drops the rest of the
remote, this can be fixed in the same way it handles touch + pen now (in 3.10).

- Also, if you want us to test your driver, you can post the hid-recorder[2] traces of the
remote. Do not forget to add traces of the different buttons that are present on your
device in addition to the multitouch logs. With hid-replay, we can then replay it on our
kernel, and give you some help and some testings.

[1] http://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/log/?h=for-next
[2] http://bentiss.github.io/hid-replay-docs/


Now let's turn to the specific comments:

>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c

> index 512b01c..a61d9dc 100644

> --- a/drivers/hid/hid-core.c

> +++ b/drivers/hid/hid-core.c

> @@ -1701,6 +1701,8 @@ static const struct hid_device_id hid_have_special_driver[] = {

>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },

>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },

>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },

> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE, USB_DEVICE_ID_SONY_TOUCH_REMOTE_LYRA) },

> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE, USB_DEVICE_ID_SONY_TOUCH_REMOTE_LEO) },


here, checkpatch will complain about the 80 columns limit, but keep using a single line
here as the others are using the same style.

>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },

>  	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },

>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },

> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h

> index 92e47e5..fd85e26 100644

> --- a/drivers/hid/hid-ids.h

> +++ b/drivers/hid/hid-ids.h

> @@ -723,6 +723,10 @@

>  #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268

>  #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f

>  

> +#define USB_VENDOR_ID_SONY_TOUCH_REMOTE		0x0609

> +#define USB_DEVICE_ID_SONY_TOUCH_REMOTE_LYRA	0x0368

> +#define USB_DEVICE_ID_SONY_TOUCH_REMOTE_LEO	0x0369

> +

>  #define USB_VENDOR_ID_SOUNDGRAPH	0x15c2

>  #define USB_DEVICE_ID_SOUNDGRAPH_IMON_FIRST	0x0034

>  #define USB_DEVICE_ID_SOUNDGRAPH_IMON_LAST	0x0046

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c

> index 7a1ebb8..53b3eb9 100644

> --- a/drivers/hid/hid-multitouch.c

> +++ b/drivers/hid/hid-multitouch.c

> @@ -1180,6 +1180,14 @@ static const struct hid_device_id mt_devices[] = {

>  		MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,

>  			USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008) },

>  

> +	/* Sony CE Remote */

> +	{ .driver_data = MT_CLS_DEFAULT,

> +		MT_BT_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE,

> +			USB_DEVICE_ID_SONY_TOUCH_REMOTE_LYRA) },

> +	{ .driver_data = MT_CLS_DEFAULT,

> +		MT_BT_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE,

> +			USB_DEVICE_ID_SONY_TOUCH_REMOTE_LEO) },

> +


Hmm... If you add the VID/PID in hid_have_special_driver, I doubt the device
will never have the HID_GROUP_MULTITOUCH attribute. So this can be skipped
entirely.

>  	/* Stantum panels */

>  	{ .driver_data = MT_CLS_CONFIDENCE,

>  		MT_USB_DEVICE(USB_VENDOR_ID_STANTUM,

> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c

> index 312098e..44e81f8 100644

> --- a/drivers/hid/hid-sony.c

> +++ b/drivers/hid/hid-sony.c

> @@ -6,6 +6,7 @@

>   *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc

>   *  Copyright (c) 2008 Jiri Slaby

>   *  Copyright (c) 2006-2008 Jiri Kosina

> + *  Copyright (c) 2013 Jason Flatt <jflatt@cox.net>

>   */

>  

>  /*

> @@ -17,6 +18,7 @@

>  

>  #include <linux/device.h>

>  #include <linux/hid.h>

> +#include <linux/input/mt.h>

>  #include <linux/module.h>

>  #include <linux/slab.h>

>  #include <linux/usb.h>

> @@ -26,6 +28,17 @@

>  #define VAIO_RDESC_CONSTANT     (1 << 0)

>  #define SIXAXIS_CONTROLLER_USB  (1 << 1)

>  #define SIXAXIS_CONTROLLER_BT   (1 << 2)

> +#define CE_REMOTE_BT            (1 << 4)


why 4? 3 is enough (you are moving the bits, so no need to use a power of 2).

> +

> +/* measured on real hardware */


What does say the report descriptor? Maybe we can retrieve this from the descriptor.

> +#define CE_REMOTE_MIN_X 0

> +#define CE_REMOTE_MAX_X 1667

> +#define CE_REMOTE_SIZE_X (float)48 /* size in mm */

> +#define CE_REMOTE_MIN_Y 0

> +#define CE_REMOTE_MAX_Y 1868

> +#define CE_REMOTE_SIZE_Y (float)51

> +#define CE_REMOTE_RES_X ((CE_REMOTE_MAX_X - CE_REMOTE_MIN_X) / CE_REMOTE_SIZE_X)

> +#define CE_REMOTE_RES_Y ((CE_REMOTE_MAX_Y - CE_REMOTE_MIN_Y) / CE_REMOTE_SIZE_Y)

>  

>  static const u8 sixaxis_rdesc_fixup[] = {

>  	0x95, 0x13, 0x09, 0x01, 0x81, 0x02, 0x95, 0x0C,

> @@ -57,6 +70,7 @@ static const u8 sixaxis_rdesc_fixup2[] = {

>  

>  struct sony_sc {

>  	unsigned long quirks;

> +	struct input_dev *input;

>  };

>  

>  /* Sony Vaio VGX has wrongly mouse pointer declared as constant */

> @@ -94,10 +108,27 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,

>  			 *rsize, (int)sizeof(sixaxis_rdesc_fixup2));

>  		*rsize = sizeof(sixaxis_rdesc_fixup2);

>  		memcpy(rdesc, &sixaxis_rdesc_fixup2, *rsize);

> +	} else if ((sc->quirks & CE_REMOTE_BT) && *rsize == 359 &&

> +			rdesc[358] == 0x0) {

> +		hid_info(hdev, "Fixing up Sony CE Remote report descriptor\n");

> +		*rsize = 358;

>  	}

>  	return rdesc;

>  }

>  

> +static int sony_input_mapping(struct hid_device *hdev, struct hid_input *hi,

> +	struct hid_field *field, struct hid_usage *usage,

> +	unsigned long **bit, int *max)

> +{

> +	struct sony_sc *sc = hid_get_drvdata(hdev);

> +	if (sc->quirks & CE_REMOTE_BT) {

> +		if (!sc->input)

> +			sc->input = hi->input;

> +	}

> +

> +	return 0;

> +}

> +


Adding an input_mapping() callback with this content is not a good idea (see below).
Use the callback .input_configured() instead.

>  static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,

>  		__u8 *rd, int size)

>  {

> @@ -112,8 +143,55 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,

>  		swap(rd[43], rd[44]);

>  		swap(rd[45], rd[46]);

>  		swap(rd[47], rd[48]);

> +	} else if (sc->quirks & CE_REMOTE_BT) {

> +		struct input_dev *input = sc->input;

> +		if (!input) {

> +			hid_err(hdev, "Sony CE Remote no input data structure");

> +			return 0;

> +		}

> +		if (rd[0] == 0x2) { /* report id = trackpad */

> +			__u8 button0 = rd[1] & 0x1;

> +			__u8 button2 = (rd[1] & 0x4) >> 2;

> +			__u8 contact0 = (rd[1] & 0x30) >> 4;

> +			__u8 contact1 = (rd[1] & 0xc0) >> 6;

> +			__u16 touch0x = rd[2] | (rd[3] & 0xf) << 8;

> +			__u16 touch0y = (rd[3] & 0xf0) >> 4 | rd[4] << 4;

> +			__u8 touch0w = rd[5] & 0xf;

> +			__u8 touch0h = (rd[5] & 0xf0) >> 4;

> +			int8_t xrel = rd[6];

> +			__u16 touch1x = rd[7] | (rd[8] & 0xf) << 8;

> +			__u16 touch1y = (rd[8] & 0xf0) >> 4 | rd[9] << 4;

> +			__u8 touch1w = rd[10] & 0xf;

> +			__u8 touch1h = (rd[10] & 0xf0) >> 4;

> +			int8_t yrel = rd[11];


IMO, this parsing could be retrieved through the report descriptors.
It's perfectly fine to use this that way, but it's not the way HID (the protocol) is working.

> +

> +			input_mt_slot(input, 0);

> +			input_mt_report_slot_state(input, MT_TOOL_FINGER, contact0);

> +			/* flip Y-axis */

> +			if (contact0) {

> +				input_report_abs(input, ABS_MT_TOUCH_MAJOR, max(touch0w, touch0h));

> +				input_report_abs(input, ABS_MT_TOUCH_MINOR, min(touch0w, touch0h));

> +				input_report_abs(input, ABS_MT_ORIENTATION, (bool)(touch0w > touch0h));

> +				input_report_abs(input, ABS_MT_POSITION_X, touch0x);

> +				input_report_abs(input, ABS_MT_POSITION_Y, CE_REMOTE_MAX_Y - touch0y);

> +			}

> +			input_mt_slot(input, 1);

> +			input_mt_report_slot_state(input, MT_TOOL_FINGER, contact1);

> +			if (contact1) {

> +				input_report_abs(input, ABS_MT_TOUCH_MAJOR, max(touch1w, touch1h));

> +				input_report_abs(input, ABS_MT_TOUCH_MINOR, min(touch1w, touch1h));

> +				input_report_abs(input, ABS_MT_ORIENTATION, (bool)(touch1w > touch1h));

> +				input_report_abs(input, ABS_MT_POSITION_X, touch1x);

> +				input_report_abs(input, ABS_MT_POSITION_Y, CE_REMOTE_MAX_Y - touch1y);

> +			}


I'm not a fan of having twice the same code. Can't you extract a function of use a loop here
instead?

> +			input_report_rel(input, REL_X, xrel);

> +			input_report_rel(input, REL_Y, yrel);

> +

> +			input_report_key(input, BTN_MOUSE, button0 | button2);

> +			input_mt_report_pointer_emulation(input, true);


It's a better idea to use input_mt_sync_frame instead. It will handle the pointer
emulation and the other required stuffs for multitouch.

> +		}

> +		input_sync(input);


ok, you are syncing the input now, but it will be done later by hid-core in any cases.

>  	}

> -


Please do not add non-related changes that hinders the purpose of the patch.

>  	return 0;


If you return 0 here, that means that hid-core will also treat the report ID 2, sending
ABS_X|Y|RX|RZ events from the touches it registered during the mapping, and it will
break the standard pointer emulation and add spurious events.

>  }

>  

> @@ -192,6 +270,43 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)

>  	return hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEATURE_REPORT);

>  }

>  

> +static int ce_remote_setup_input(struct input_dev *input, struct hid_device *hdev)

> +{

> +	const int FUZZ = 4;

> +	int error;

> +	__set_bit(EV_KEY, input->evbit);


If you give a look at input_mt_init_slots, you will see that using the flag
INPUT_MT_POINTER already set up the EV_KEY bit. And lucky you, you are using
it as an INPUT_MT_POINTER... :)

> +	__set_bit(EV_REL, input->evbit);

> +	__set_bit(EV_ABS, input->evbit);

> +	__clear_bit(BTN_RIGHT, input->keybit);

> +	__clear_bit(BTN_MIDDLE, input->keybit);

> +	__set_bit(BTN_MOUSE, input->keybit);

> +	__set_bit(BTN_TOOL_FINGER, input->keybit);

> +	__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);

> +	__set_bit(BTN_TOUCH, input->keybit);

> +	__set_bit(INPUT_PROP_POINTER, input->propbit);


All 4 previous __set_bit calls are done by input_mt_init_slot with the flag INPUT_MT_POINTER.

> +	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);

> +

> +	error = input_mt_init_slots(input, 2, 0);


input_mt_init_slot must be called _after_ the ABS_MT_* axes are set.

> +	if (error)

> +		return error;

> +

> +	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 15, FUZZ, 0);

> +	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 15, FUZZ, 0);

> +	input_set_abs_params(input, ABS_MT_ORIENTATION, 0, 1, 0, 0);

> +

> +	input_set_abs_params(input, ABS_X, CE_REMOTE_MIN_X, CE_REMOTE_MAX_X, FUZZ, 0);

> +	input_set_abs_params(input, ABS_Y, CE_REMOTE_MIN_Y, CE_REMOTE_MAX_Y, FUZZ, 0);


You do not need to initialize ABS_X|Y as input_mt_init_slot will do it for you.
In addition, setting the fuzz for ABS_X|Y is wrong in the case of the pointer emulation
(the fuzz function is applied twice).

> +	input_set_abs_params(input, ABS_MT_POSITION_X, CE_REMOTE_MIN_X, CE_REMOTE_MAX_X, FUZZ, 0);

> +	input_set_abs_params(input, ABS_MT_POSITION_Y, CE_REMOTE_MIN_Y, CE_REMOTE_MAX_Y, FUZZ, 0);

> +

> +	input_abs_set_res(input, ABS_X, CE_REMOTE_RES_X);

> +	input_abs_set_res(input, ABS_Y, CE_REMOTE_RES_Y);


ditto, remove the ABS_X|Y stuff

> +	input_abs_set_res(input, ABS_MT_POSITION_X, CE_REMOTE_RES_X);

> +	input_abs_set_res(input, ABS_MT_POSITION_Y, CE_REMOTE_RES_Y);

> +


Place the call to input_mt_init_slots here.

> +	return 0;

> +}

> +

>  static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)

>  {

>  	int ret;

> @@ -226,6 +341,15 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)

>  	}

>  	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)

>  		ret = sixaxis_set_operational_bt(hdev);

> +	else if (sc->quirks & CE_REMOTE_BT) {

> +		if (sc->input) {

> +			ret = ce_remote_setup_input(sc->input, hdev);

> +			if (ret) {

> +				hid_err(hdev, "Sony Touch Remote setup input failed (%d)\n", ret);

> +				goto err_stop;

> +			}

> +		}

> +	}


This is a very bad idea:
during the call of hid_hw_start, hid-core will setup the input and register it.
That means that the uevents telling that your device is ready have already been
fired. The problem is that it introduce a race between udev/Xorg and your modification
of the input. So Xorg may open it as a standard device (not multitouch), will not see
that it is a trackpad, and you will then send it axes that it will never understand.

So the solution is to use the callback .input_configured() which is called just before the
registering of your input device. Thus, you are not starting a race, and the uevent will
be fired once the device is properly set.

>  	else

>  		ret = 0;

>  

> @@ -257,6 +381,10 @@ static const struct hid_device_id sony_devices[] = {

>  		.driver_data = VAIO_RDESC_CONSTANT },

>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE),

>  		.driver_data = VAIO_RDESC_CONSTANT },

> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE, USB_DEVICE_ID_SONY_TOUCH_REMOTE_LYRA),

> +		.driver_data = CE_REMOTE_BT },

> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE, USB_DEVICE_ID_SONY_TOUCH_REMOTE_LEO),

> +		.driver_data = CE_REMOTE_BT },

>  	{ }

>  };

>  MODULE_DEVICE_TABLE(hid, sony_devices);

> @@ -266,6 +394,7 @@ static struct hid_driver sony_driver = {

>  	.id_table = sony_devices,

>  	.probe = sony_probe,

>  	.remove = sony_remove,

> +	.input_mapping = sony_input_mapping,


This will conflict with the upstream release.

>  	.report_fixup = sony_report_fixup,

>  	.raw_event = sony_raw_event

>  };

> 

Cheers and good luck for the next iteration.
Benjamin
