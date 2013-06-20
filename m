From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Preliminary support for Razer Blade multitouch touchpads
Date: Thu, 20 Jun 2013 11:23:37 +0200
Message-ID: <51C2CA19.5000400@gmail.com>
References: <CAG5DJwddL1cTZbA6ofyH5ZPmkLxUCkCMEHAp8Lb8g9+JWLP0JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965153Ab3FTJXo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jun 2013 05:23:44 -0400
In-Reply-To: <CAG5DJwddL1cTZbA6ofyH5ZPmkLxUCkCMEHAp8Lb8g9+JWLP0JA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Zach C." <fxchip@gmail.com>
Cc: Jan Steinhoff <cpad@jan-steinhoff.de>, linux-input@vger.kernel.org

Hi Zach,

On 06/20/2013 08:09 AM, Zach C. wrote:
> Hey guys,
> 
> Attached is a patch for synaptics-usb made against commit
> 8177a9d79c0e942dcac3312f15585d0344d505a5 of Linus's git tree (the one
> commit *right after* 3.10-rc6). It's *extremely* preliminary and there
> are still a few glitches -- namely, the touchpad sends input samples
> *a lot* and X and Y are never the same value twice, even when the
> finger for that packet hasn't moved.

This may be solved by adding a fuzz setting to your axes. It will
flattened the coordinates.

> I'm also not entirely sure that
> the field I'm calling "pressure" is actually pressure -- it might
> actually be orientation or something similar, because the values I
> manage to get out of it don't seem to be related at all to the
> pressure applied to the touchpad. I'm not exactly sure how to tease
> that out.

Most of the times, sensors are not providing a real pressure metric, but
a deduction from the size of the contact. So if it ever works with the
xorg synaptics driver, it should be ok.

> 
> Really, the purpose of sending this incomplete patch in is to request
> comments and feedback about how to proceed. I could probably set a
> threshold for position changes, but that doesn't seem to be the right
> course of action at this level. (Further fixes would be nice, too!)
> 
> Please let me know what you think. Thank you!

Ok. I'm just copy/pasting part of my mail I just sent to Jason as these comments
apply also to your patch:

I have several general comments on your patch and specific details that I have
inlined.

For the general comments:
- please always inline the patch within the mail. It's much easier for us to review
and annotate it. You can use the standard tools "git format-patch" and then "git
send-email" which will send your patch in a proper way.
- Do not forget to sign your patch using "Signed-off-by: Your Name <your@address>".
Without it, Dmitry Torokhov (the input maintainer) will refuse to include your patch in
his tree.
- Add a proper commit message (in addition to the patch's title) explaining why this
patch is required and how you solve the problem, etc...
- beware of the whitespace errors (spaces preceding tabs)
- beware of the 80-column limit

For most of these comments, you can run the tool ./script/checkpatch.pl in your kernel
tree which will raise most of the common pitfalls we can encounter. In your case, this
tool gives 12 errors, 30 warnings, for 312 lines checked


Now let's turn to the specific comments (please note that I am not an USB expert, so
my review will be focused on multitouch and general drivers hints):

> 
> Thanks,
> 
> Zach
> 
> diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
> index 64cf34e..d8d79d3 100644
> --- a/drivers/input/mouse/synaptics_usb.c
> +++ b/drivers/input/mouse/synaptics_usb.c
> @@ -8,6 +8,8 @@
>   *  Copyright (c) 2004 Jan Steinhoff (cpad@jan-steinhoff . de)
>   *  Copyright (c) 2004 Ron Lee (ron@debian.org)
>   *	rewritten for kernel 2.6
> + *  Copyright (c) 2013 Zach Carlson (FxChiP@Gmail.com)
> + *      Razer Blade / multi-finger-struct synaptics touchpad support
>   *
>   *  cPad display character device part is not included. It can be found at
>   *  http://jan-steinhoff.de/linux/synaptics-usb.html
> @@ -44,19 +46,23 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/usb.h>
> +#include <linux/input/mt.h>
>  #include <linux/input.h>
>  #include <linux/usb/input.h>
>  
> -#define USB_VENDOR_ID_SYNAPTICS	0x06cb
> -#define USB_DEVICE_ID_SYNAPTICS_TP	0x0001	/* Synaptics USB TouchPad */
> -#define USB_DEVICE_ID_SYNAPTICS_INT_TP	0x0002	/* Integrated USB TouchPad */
> -#define USB_DEVICE_ID_SYNAPTICS_CPAD	0x0003	/* Synaptics cPad */
> -#define USB_DEVICE_ID_SYNAPTICS_TS	0x0006	/* Synaptics TouchScreen */
> -#define USB_DEVICE_ID_SYNAPTICS_STICK	0x0007	/* Synaptics USB Styk */
> -#define USB_DEVICE_ID_SYNAPTICS_WP	0x0008	/* Synaptics USB WheelPad */
> -#define USB_DEVICE_ID_SYNAPTICS_COMP_TP	0x0009	/* Composite USB TouchPad */
> -#define USB_DEVICE_ID_SYNAPTICS_WTP	0x0010	/* Wireless TouchPad */
> -#define USB_DEVICE_ID_SYNAPTICS_DPAD	0x0013	/* DisplayPad */
> +#define USB_VENDOR_ID_SYNAPTICS	        0x06cb
> +#define USB_VENDOR_ID_SYNUSB_RAZER      0x1532
> +
> +#define USB_DEVICE_ID_SYNAPTICS_TP	       0x0001	/* Synaptics USB TouchPad */
> +#define USB_DEVICE_ID_SYNAPTICS_INT_TP	       0x0002	/* Integrated USB TouchPad */
> +#define USB_DEVICE_ID_SYNAPTICS_CPAD	       0x0003	/* Synaptics cPad */
> +#define USB_DEVICE_ID_SYNAPTICS_TS	       0x0006	/* Synaptics TouchScreen */
> +#define USB_DEVICE_ID_SYNAPTICS_STICK	       0x0007	/* Synaptics USB Styk */
> +#define USB_DEVICE_ID_SYNAPTICS_WP	       0x0008	/* Synaptics USB WheelPad */
> +#define USB_DEVICE_ID_SYNAPTICS_COMP_TP	       0x0009	/* Composite USB TouchPad */
> +#define USB_DEVICE_ID_SYNAPTICS_WTP	       0x0010	/* Wireless TouchPad */
> +#define USB_DEVICE_ID_SYNAPTICS_DPAD	       0x0013	/* DisplayPad */
> +#define USB_DEVICE_ID_SYNUSB_RAZER_BLADE_TP    0x0116  	/* Razer Blade Touchpad */

Please do not introduce whitespace changes that hinders the fact that
you just added _one_ USB_VENDOR_ID and _one_ USB_DEVICE_ID.

>  
>  #define SYNUSB_TOUCHPAD			(1 << 0)
>  #define SYNUSB_STICK			(1 << 1)
> @@ -64,19 +70,32 @@
>  #define SYNUSB_AUXDISPLAY		(1 << 3) /* For cPad */
>  #define SYNUSB_COMBO			(1 << 4) /* Composite device (TP + stick) */
>  #define SYNUSB_IO_ALWAYS		(1 << 5)
> +#define SYNUSB_MF_PACKETS               (1 << 6) /* Multi-finger packets */
> +#define SYNUSB_SHARES_DEVICE            (1 << 7) /* Shares device with other inputs */
>  
>  #define USB_DEVICE_SYNAPTICS(prod, kind)		\
>  	USB_DEVICE(USB_VENDOR_ID_SYNAPTICS,		\
>  		   USB_DEVICE_ID_SYNAPTICS_##prod),	\
>  	.driver_info = (kind),
>  
> +#define USB_DEVICE_SYNUSB_RAZER(prod, kind)	        \
> +	USB_DEVICE(USB_VENDOR_ID_SYNUSB_RAZER,		\
> +		   USB_DEVICE_ID_SYNUSB_RAZER_##prod),	        \
> +	.driver_info = (kind),
> +
>  #define SYNUSB_RECV_SIZE	8
> +#define SYNUSB_MF_RECV_SIZE     64
>  
>  #define XMIN_NOMINAL		1472
>  #define XMAX_NOMINAL		5472
>  #define YMIN_NOMINAL		1408
>  #define YMAX_NOMINAL		4448
>  
> +#define XMIN_NOMINAL_RZR        1181
> +#define XMAX_NOMINAL_RZR        5888
> +#define YMIN_NOMINAL_RZR        1056
> +#define YMAX_NOMINAL_RZR        4686
> +
>  struct synusb {
>  	struct usb_device *udev;
>  	struct usb_interface *intf;
> @@ -129,31 +148,40 @@ static void synusb_report_touchpad(struct synusb *synusb)
>  	unsigned int num_fingers, tool_width;
>  	unsigned int x, y;
>  	unsigned int pressure, w;
> -
> -	pressure = synusb->data[6];
> -	x = be16_to_cpup((__be16 *)&synusb->data[2]);
> -	y = be16_to_cpup((__be16 *)&synusb->data[4]);
> -	w = synusb->data[0] & 0x0f;
> -
> -	if (pressure > 0) {
> -		num_fingers = 1;
> -		tool_width = 5;
> -		switch (w) {
> -		case 0 ... 1:
> -			num_fingers = 2 + w;
> -			break;
> -
> -		case 2:	                /* pen, pretend its a finger */
> -			break;
> -
> -		case 4 ... 15:
> -			tool_width = w;
> -			break;

This is a huge change aiming at reusing the previous code in a loop. I think it would be better
to extract the previous code within a function, and use this function in the loop.

> +	unsigned int finger_index, packet_offset;
> +	unsigned short already_submitted = 0;
> +
> +	for (finger_index = 0;
> +	     finger_index < (synusb->flags & SYNUSB_MF_PACKETS ? 5 :  1);

Please don't rely on numerical values within the code.

You are using several times "synusb->flags & SYNUSB_MF_PACKETS ? XXX : YYY", I really think
it would be more clear to test it once instead of mixing the standard behavior and the
new one (but this is up to the maintainer of the driver to decide).

> +	     finger_index++) {
> +		packet_offset = finger_index * 8; 
> +
> +		pressure = synusb->data[packet_offset+6];
> +		x = be16_to_cpup((__be16 *)&synusb->data[packet_offset+2]);
> +		y = be16_to_cpup((__be16 *)&synusb->data[packet_offset+4]);
> +		w = synusb->data[packet_offset] & 0x0f;
> +
> +		if (pressure > 0) {
> +			num_fingers = (synusb->flags & SYNUSB_MF_PACKETS ? synusb->data[packet_offset+7] >> 4 : 1);
> +			tool_width = 5;
> +			switch (w) {
> +			case 0 ... 1:
> +				/* The finger-count delimiter is always correct */
> +				if (!(synusb->flags & SYNUSB_MF_PACKETS))
> +					num_fingers = 2 + w;
> +				break;
> +
> +			case 2:	                /* pen, pretend its a finger */
> +				break;
> +
> +			case 3 ... 15:
> +				tool_width = w;
> +				break;
> +			}
> +		} else {
> +			num_fingers = (synusb->flags & SYNUSB_MF_PACKETS) ? synusb->data[packet_offset+7] >> 4 : 0;

You are using twice the same line than may contain errors.

> +			tool_width = 0;
>  		}
> -	} else {
> -		num_fingers = 0;
> -		tool_width = 0;
> -	}
>  
>  	/*
>  	 * Post events
> @@ -161,27 +189,56 @@ static void synusb_report_touchpad(struct synusb *synusb)
>  	 * absolute -> relative conversion
>  	 */
>  
> -	if (pressure > 30)
> -		input_report_key(input_dev, BTN_TOUCH, 1);
> -	if (pressure < 25)
> -		input_report_key(input_dev, BTN_TOUCH, 0);
> -
> -	if (num_fingers > 0) {
> -		input_report_abs(input_dev, ABS_X, x);
> -		input_report_abs(input_dev, ABS_Y,
> -				 YMAX_NOMINAL + YMIN_NOMINAL - y);
> +		if (synusb->flags & SYNUSB_MF_PACKETS) {
> +			input_mt_slot(input_dev, synusb->data[packet_offset+7] & 0x0F);
> +			input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, (pressure > 30));
> +			if (pressure > 30) {
> +				if (already_submitted == 0) {
> +					/* First finger with pressure should emulate mouse...
> +					 * but ONLY if it is the ONLY finger. (Otherwise, gestures
> +					 * should be processed) */

I strongly disagree. You can use the pointer emulation even if there is
more than one finger.

> +					input_mt_report_pointer_emulation(input_dev, 
> +					                                  (pressure > 30 && num_fingers == 1)
> +									 );

the second argument here is wrong: it should be use_count, not a boolean saying
whether to use or not the emulation.

> +					already_submitted = 1;

this test (first finger) can be skipped because you just want the pointer
emulation called once. So just put the call out of the big loop.

> +				}
> +				input_report_abs(input_dev, ABS_MT_POSITION_X, x);
> +				input_report_abs(input_dev, ABS_MT_POSITION_Y, 
> +				                 YMAX_NOMINAL_RZR + YMIN_NOMINAL_RZR - y);

interesting, you are reporting the position _after_ having called input_mt_report_pointer_emulation.
That means that the coordinates the pointer emulation will use are the previous ones.

> +				input_report_abs(input_dev, ABS_MT_PRESSURE, pressure);
> +				input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, tool_width);
> +			}
> +
> +			if (finger_index == 4) {

4... Please use a define somewhere.

> +				// Final finger count = report

avoid C99 // comments

> +				input_mt_report_finger_count(input_dev, num_fingers);

This should be called by input_mt_report_pointer_emulation. Also, use input_mt_sync_frame
instead, which will call input_mt_report_pointer_emulation in a proper way.

> +			}
> +
> +
> +		} else {
> +			if (pressure > 30)
> +				input_report_key(input_dev, BTN_TOUCH, 1);
> +			if (pressure < 25)
> +				input_report_key(input_dev, BTN_TOUCH, 0);
> +
> +			if (num_fingers > 0) {
> +				input_report_abs(input_dev, ABS_X, x);
> +				input_report_abs(input_dev, ABS_Y,
> +						 YMAX_NOMINAL + YMIN_NOMINAL - y);
> +			}
> +
> +			input_report_abs(input_dev, ABS_PRESSURE, pressure);
> +			input_report_abs(input_dev, ABS_TOOL_WIDTH, tool_width);
> +
> +			input_report_key(input_dev, BTN_TOOL_FINGER, num_fingers == 1);
> +			input_report_key(input_dev, BTN_TOOL_DOUBLETAP, num_fingers == 2);
> +			input_report_key(input_dev, BTN_TOOL_TRIPLETAP, num_fingers == 3);
> +
> +			if (synusb->flags & SYNUSB_AUXDISPLAY)
> +				input_report_key(input_dev, BTN_MIDDLE, synusb->data[1] & 0x08);
> +		}
>  	}
> -
> -	input_report_abs(input_dev, ABS_PRESSURE, pressure);
> -	input_report_abs(input_dev, ABS_TOOL_WIDTH, tool_width);
> -
> -	input_report_key(input_dev, BTN_TOOL_FINGER, num_fingers == 1);
> -	input_report_key(input_dev, BTN_TOOL_DOUBLETAP, num_fingers == 2);
> -	input_report_key(input_dev, BTN_TOOL_TRIPLETAP, num_fingers == 3);
> -
>  	synusb_report_buttons(synusb);
> -	if (synusb->flags & SYNUSB_AUXDISPLAY)
> -		input_report_key(input_dev, BTN_MIDDLE, synusb->data[1] & 0x08);
>  
>  	input_sync(input_dev);
>  }
> @@ -293,6 +350,14 @@ static int synusb_probe(struct usb_interface *intf,
>  	unsigned int intf_num = intf->cur_altsetting->desc.bInterfaceNumber;
>  	unsigned int altsetting = min(intf->num_altsetting, 1U);
>  	int error;
> +	size_t recv_size = SYNUSB_RECV_SIZE;
> +
> +	if (id->driver_info & SYNUSB_SHARES_DEVICE) {
> +		/* XXX: Trackpad on interface 0. Hack to ignore other interfaces until better method found. */
> +		/* Must NOT bind to keyboards, etc. */
> +		if (intf_num > 0)
> +			return -ENODEV;
> +	}
>  
>  	error = usb_set_interface(udev, intf_num, altsetting);
>  	if (error) {
> @@ -327,13 +392,16 @@ static int synusb_probe(struct usb_interface *intf,
>  					SYNUSB_STICK : SYNUSB_TOUCHPAD;
>  	}
>  
> +	if (synusb->flags & SYNUSB_MF_PACKETS)
> +		recv_size = SYNUSB_MF_RECV_SIZE;
> +
>  	synusb->urb = usb_alloc_urb(0, GFP_KERNEL);
>  	if (!synusb->urb) {
>  		error = -ENOMEM;
>  		goto err_free_mem;
>  	}
>  
> -	synusb->data = usb_alloc_coherent(udev, SYNUSB_RECV_SIZE, GFP_KERNEL,
> +	synusb->data = usb_alloc_coherent(udev, recv_size, GFP_KERNEL,
>  					  &synusb->urb->transfer_dma);
>  	if (!synusb->data) {
>  		error = -ENOMEM;
> @@ -342,7 +410,7 @@ static int synusb_probe(struct usb_interface *intf,
>  
>  	usb_fill_int_urb(synusb->urb, udev,
>  			 usb_rcvintpipe(udev, ep->bEndpointAddress),
> -			 synusb->data, SYNUSB_RECV_SIZE,
> +			 synusb->data, recv_size,
>  			 synusb_irq, synusb,
>  			 ep->bInterval);
>  	synusb->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
> @@ -366,6 +434,13 @@ static int synusb_probe(struct usb_interface *intf,
>  	if (synusb->flags & SYNUSB_STICK)
>  		strlcat(synusb->name, " (Stick)", sizeof(synusb->name));
>  
> +	if (synusb->flags & SYNUSB_MF_PACKETS)
> +		strlcat(synusb->name, " (MT)", sizeof(synusb->name));
> +	
> +	if (synusb->flags & SYNUSB_SHARES_DEVICE) 
> +		strlcat(synusb->name, " (shared)", sizeof(synusb->name));
> +
> +
>  	usb_make_path(udev, synusb->phys, sizeof(synusb->phys));
>  	strlcat(synusb->phys, "/input0", sizeof(synusb->phys));
>  
> @@ -384,6 +459,15 @@ static int synusb_probe(struct usb_interface *intf,
>  	__set_bit(EV_ABS, input_dev->evbit);
>  	__set_bit(EV_KEY, input_dev->evbit);
>  
> +	if (synusb->flags & SYNUSB_MF_PACKETS) {
> +		input_mt_init_slots(input_dev, 5, INPUT_MT_POINTER);

input_mt_init_slots() must be called _after_ having set the different
ABS_MT_* axes.

> +		input_set_abs_params(input_dev, ABS_MT_POSITION_X, 
> +		                     XMIN_NOMINAL_RZR, XMAX_NOMINAL_RZR, 0, 0);
> +		input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> +		                     YMIN_NOMINAL_RZR, YMAX_NOMINAL_RZR, 0, 0);
> +		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 15, 0, 0);
> +	}
> +
>  	if (synusb->flags & SYNUSB_STICK) {
>  		__set_bit(EV_REL, input_dev->evbit);
>  		__set_bit(REL_X, input_dev->relbit);
> @@ -428,7 +512,7 @@ err_stop_io:
>  	if (synusb->flags & SYNUSB_IO_ALWAYS)
>  		synusb_close(synusb->input);
>  err_free_dma:
> -	usb_free_coherent(udev, SYNUSB_RECV_SIZE, synusb->data,
> +	usb_free_coherent(udev, recv_size, synusb->data,
>  			  synusb->urb->transfer_dma);
>  err_free_urb:
>  	usb_free_urb(synusb->urb);
> @@ -444,13 +528,17 @@ static void synusb_disconnect(struct usb_interface *intf)
>  {
>  	struct synusb *synusb = usb_get_intfdata(intf);
>  	struct usb_device *udev = interface_to_usbdev(intf);
> +	size_t recv_size = SYNUSB_RECV_SIZE;
>  
>  	if (synusb->flags & SYNUSB_IO_ALWAYS)
>  		synusb_close(synusb->input);
>  
> +	if (synusb->flags & SYNUSB_MF_PACKETS)
> +		recv_size = SYNUSB_MF_RECV_SIZE;
> +
>  	input_unregister_device(synusb->input);
>  
> -	usb_free_coherent(udev, SYNUSB_RECV_SIZE, synusb->data,
> +	usb_free_coherent(udev, recv_size, synusb->data,
>  			  synusb->urb->transfer_dma);
>  	usb_free_urb(synusb->urb);
>  	kfree(synusb);
> @@ -531,6 +619,7 @@ static struct usb_device_id synusb_idtable[] = {
>  	{ USB_DEVICE_SYNAPTICS(COMP_TP, SYNUSB_COMBO) },
>  	{ USB_DEVICE_SYNAPTICS(WTP, SYNUSB_TOUCHPAD) },
>  	{ USB_DEVICE_SYNAPTICS(DPAD, SYNUSB_TOUCHPAD) },
> +	{ USB_DEVICE_SYNUSB_RAZER(BLADE_TP, SYNUSB_TOUCHPAD | SYNUSB_MF_PACKETS | SYNUSB_SHARES_DEVICE) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(usb, synusb_idtable);
> 

Cheers,
Benjamin
