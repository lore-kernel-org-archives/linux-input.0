From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] TiVo USB IR Dongle support
Date: Sat, 12 Dec 2009 15:32:59 -0800
Message-ID: <20091212233259.GB16760@core.coreip.homeip.net>
References: <20091206214543.GA5290@acer.drzhang.net> <20091212190143.GA3591@acer.drzhang.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:64259 "HELO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932903AbZLMBRh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Dec 2009 20:17:37 -0500
Received: by pzk1 with SMTP id 1so1526477pzk.33
        for <linux-input@vger.kernel.org>; Sat, 12 Dec 2009 17:17:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091212190143.GA3591@acer.drzhang.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chaogui Zhang <czhang@marywood.edu>
Cc: linux-input@vger.kernel.org

Hi Chaogui,

On Sat, Dec 12, 2009 at 02:01:43PM -0500, Chaogui Zhang wrote:
> 
> Hi, Dmitry,
> 
> This is a resubmit of the new TiVo IR dongle driver I sent in a few days ago. Sorry
> that I forgot to cc my last message to you.
> 
> I revised the code and this patch should safely ignore any non-TiVo remote. As I 
> mentioned, I hope this would be useful for anyone who might have this receiver. 
> Given the current debate on the kernel IR integration, it will be fine if you 
> would like to wait until the dust settles. Please let me know what you think. 
> 

Thank you for the patch, a few comments below.

> Thank you very much!
> 
> Signed-off-by: Chaogui Zhang <czhang@marywood.edu>
> ---
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index a9bb254..57ae574 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -148,6 +148,19 @@ config INPUT_KEYSPAN_REMOTE
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called keyspan_remote.
>  
> +config INPUT_TIVOIR
> +	tristate "TiVo USB IR Dongle (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL
> +	depends on USB_ARCH_HAS_HCD
> +	select USB
> +	help
> +	  Say Y here if you want to use the TiVo USB IR Dongle. It works with
> +	  the bundled TiVo remote and this driver maps all buttons to keypress
> +	  events.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called tivoir.
> +
>  config INPUT_POWERMATE
>  	tristate "Griffin PowerMate and Contour Jog support"
>  	depends on USB_ARCH_HAS_HCD
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index a8b8485..b449048 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_INPUT_RB532_BUTTON)	+= rb532_button.o
>  obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
>  obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
>  obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
> +obj-$(CONFIG_INPUT_TIVOIR)		+= tivoir.o
>  obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
>  obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
>  obj-$(CONFIG_INPUT_WINBOND_CIR)		+= winbond-cir.o
> diff --git a/drivers/input/misc/tivoir.c b/drivers/input/misc/tivoir.c
> new file mode 100644
> index 0000000..bc946c5
> --- /dev/null
> +++ b/drivers/input/misc/tivoir.c
> @@ -0,0 +1,580 @@
> +/*
> + * 	tivoir.c: Input driver for the USB TiVo PC IR Dongle
> + *
> + * 	Copyright (C) 2009 Chaogui Zhang (czhang@marywood.edu)
> + *
> + *	Based in part on the Keyspan DMR driver (keyspan_remote.c) by 
> + *	Michael Downey (downey@zymeta.com)
> + *	
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License as
> + *	published by the Free Software Foundation, version 2.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/usb/input.h>
> +
> +#define DRIVER_VERSION  "v0.1"
> +#define DRIVER_AUTHOR   "Chaogui Zhang <czhang@marywood.edu>"
> +#define DRIVER_DESC     "Driver for the TiVo PC IR Dongle."
> +#define DRIVER_LICENSE  "GPL"
> +
> +/* Parameters that can be passed to the driver. */
> +static int debug;
> +module_param(debug, int, 0444);
> +MODULE_PARM_DESC(debug, "Enable extra debug messages and information");
> +
> +/* Vendor and product ids */
> +#define USB_TIVOIR_VENDOR_ID		0x105A
> +#define USB_TIVOIR_PRODUCT_ID		0x2000
> +#define TIVO_REMOTE_ADDR		0x3085
> +
> +#define PULSE_BIT	0x80	/* Pulse is indicated by a 1 in the highest bit */
> +#define PULSE_MASK	0x7f	/* Lower 7 bits is the length of the pulse transmitted */
> +#define RECV_SIZE       32	/* TiVo IR Dongle has a transfer limit of 32 bytes. */
> +
> +/*
> + * Table that maps the remote keycodes to input keys.
> + * The comments are the labels on the TiVo remote that came with the dongle.
> + */
> +
> +static const struct {
> +	u8 code;
> +	u16 key;
> +} tivoir_key_table[] = {
> +	{ 0x09, KEY_MENU },	/* TiVo Logo */
> +	{ 0x10, KEY_POWER2 },	/* TV Power */
> +	{ 0x11, KEY_TV },	/* Live TV/Swap */
> +	{ 0x13, KEY_INFO },
> +	{ 0x14, KEY_UP }, 
> +	{ 0x15, KEY_RIGHT },
> +	{ 0x16, KEY_DOWN }, 
> +	{ 0x17, KEY_LEFT }, 
> +	{ 0x18, KEY_RED },	/* Thumb down */
> +	{ 0x19, KEY_SELECT }, 
> +	{ 0x1a, KEY_GREEN },	/* Thumb up */
> +	{ 0x1b, KEY_MUTE }, 
> +	{ 0x1c, KEY_VOLUMEUP }, 
> +	{ 0x1d, KEY_VOLUMEDOWN }, 
> +	{ 0x1e, KEY_CHANNELUP }, 
> +	{ 0x1f, KEY_CHANNELDOWN }, 
> +	{ 0x20, KEY_RECORD }, 
> +	{ 0x21, KEY_PLAY }, 
> +	{ 0x22, KEY_REWIND }, 
> +	{ 0x23, KEY_PAUSE }, 
> +	{ 0x24, KEY_FASTFORWARD }, 
> +	{ 0x25, KEY_SLOW }, 
> +	{ 0x26, KEY_FRAMEBACK },	/* TiVo quick replay */
> +	{ 0x27, KEY_FRAMEFORWARD },	/* Skip */
> +	{ 0x28, KEY_1 }, 
> +	{ 0x29, KEY_2 }, 
> +	{ 0x2a, KEY_3 }, 
> +	{ 0x2b, KEY_4 }, 
> +	{ 0x2c, KEY_5 }, 
> +	{ 0x2d, KEY_6 }, 
> +	{ 0x2e, KEY_7 }, 
> +	{ 0x2f, KEY_8 }, 
> +	{ 0x30, KEY_9 }, 
> +	{ 0x31, KEY_0 }, 
> +	{ 0x32, KEY_CLEAR }, 
> +	{ 0x33, KEY_ENTER }, 
> +	{ 0x34, KEY_VIDEO },	/* TV Input */
> +	{ 0x36, KEY_EPG },	/* Guide */
> +	{ 0x44, KEY_ZOOM },	/* Aspect */
> +	{ 0x48, KEY_STOP }, 
> +	{ 0x4a, KEY_DVD },		/* DVD Menu */
> +	{ 0x5f, KEY_CYCLEWINDOWS }	/* Window */
> +};
> +
> +/* table of devices that work with this driver */
> +static struct usb_device_id tivoir_table[] = {
> +	{USB_DEVICE(USB_TIVOIR_VENDOR_ID, USB_TIVOIR_PRODUCT_ID)},
> +	{}			/* Terminating entry */
> +};
> +
> +/* Structure to hold all of our driver specific stuff */
> +struct usb_tivoir {
> +	char name[128];
> +	char phys[64];
> +	unsigned short keymap[ARRAY_SIZE(tivoir_key_table)];
> +	struct usb_device *udev;
> +	struct input_dev *input;
> +	struct usb_interface *interface;
> +	struct usb_endpoint_descriptor *in_endpoint;
> +	struct urb *irq_urb;
> +	int open;

Not used.

> +	dma_addr_t in_dma;
> +	unsigned char *in_buffer;
> +
> +	/* variables used to parse messages from remote. */
> +	int stage;
> +	int pulse;	
> +	int space;	
> +	u32 code;	/* 32 bit raw code from the remote */
> +	int repeat;
> +	int bitcount;
> +};
> +
> +static struct usb_driver tivoir_driver;
> +
> +/*
> + * Debug routine that prints out what we've received from the remote.
> + */
> +static void tivoir_print_packet(struct usb_tivoir *remote)
> +{
> +	u8 codes[4 * RECV_SIZE];
> +	int i, length;
> +
> +	/* The lower 5 bits of the first byte of each packet indicates the size
> +	 * of the transferred buffer, not including the first byte itself.
> +	 */
> +
> +	length = (remote->in_buffer[0]) & 0x1f;
> +	for (i = 0; i <= length; i++)
> +		snprintf(codes + i * 3, 4, "%02x ", remote->in_buffer[i]);
> +
> +	/* 0x80 at the end of a regular packet or in a separate packet
> +	   indicates key release */
> +
> +	if (i < RECV_SIZE && remote->in_buffer[i] == 0x80)
> +		snprintf(codes + i * 3, 4, "%02x ", remote->in_buffer[i]);
> +
> +	dev_info(&remote->udev->dev, "%s: %s\n", __func__, codes);
> +}
> +
> +static inline u16 code_address(u32 code)
> +{
> +	return code >> 16;	/* Higher 16 bits of the code is the remote address */
> +}
> +
> +static inline u8 code_command(u32 code)
> +{
> +	return code & 0xff;	/* Lower 8 bits of the code is the command */
> +}
> +
> +static int tivoir_lookup(u8 code)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tivoir_key_table); i++) {
> +		if (tivoir_key_table[i].code == code)
> +			return tivoir_key_table[i].key;
> +		if (tivoir_key_table[i].code > code)
> +			return -1;
> +	}
> +
> +	return -1;
> +}
> +
> +static void tivoir_report_key(struct usb_tivoir *remote)
> +{
> +	struct input_dev *input = remote->input;
> +	u16 key;
> +
> +	if (debug)
> +		dev_info(&remote->udev->dev, "%s: Remote address = 0x%04x, command = 0x%02x\n",
> +			__func__, remote->code >> 16, remote->code & 0xff);

Just change to dev_dbg here...

> +	if (code_address(remote->code) == TIVO_REMOTE_ADDR) {
> +		key = tivoir_lookup(code_command(remote->code));
> +		if (key < 0) {	/* invalid code, do nothing */
> +			remote->code = 0;
> +			return;
> +		}		
> +		input_report_key(input, key, remote->repeat);
> +		input_sync(input);
> +	} else {
> +		if (debug)
> +			dev_info(&remote->udev->dev, "%s: Mismatch of remote address.\n", __func__);
> +		remote->code = 0;
> +	}
> +}
> +
> +static inline int is_pulse(u8 code)
> +{
> +	return code & PULSE_BIT;
> +}
> +
> +/* Check the inital AGC burst and space value to match the NEC protocol */
> +static inline int is_nec(int leadpulse, int leadspace)
> +{
> +	/* leadpulse should be 9 ms = 9000 us and leadspace should be
> +	 * 4.5 ms = 4500 us. We allow +/- 200 microseconds for both.
> +	 * Time is measured in units of 50 microseconds.
> +	 * 170 == 8800/50, 184 == 9200/50,
> +	 * 86 == 4300/50, 94 == 4700/50.
> +	 */
> +	return (leadpulse >= 170 && leadpulse <= 184) 
> +	    && (leadspace >= 86 && leadspace <= 94);

That surely should be '||'. I prefer it at the end too.

> +}
> +
> +/* Routine that resets the remote data to clean state */
> +static inline void reset_remote(struct usb_tivoir *remote) {

Opening brace on a separate line please.

> +		remote->stage = 0;
> +		remote->pulse = 0;
> +		remote->space = 0;
> +		remote->bitcount = 0;
> +		remote->code = 0;
> +		remote->repeat = 0;

Extra identation for entire block.

> +}
> +
> +/* Routine that decode pulse/space value into one NEC logic bit */
> +static int nec_bit(int pulse, int space) {

Opening brace on a separate line please.

> +	/* Check that pulse is between 0.450ms and 0.650ms  (NEC protocol says 0.560ms) */
> +	if (pulse < 9 || pulse > 14) 
> +		return -1;
> +
> +	/* Space value about 1.690ms (about 33 * 50 micro seconds) indicates a 1 bit. 
> +	 * Space value about 0.560ms (about 11 * 50 micro seconds) indicates a 0 bit. 
> +	 */
> +	if (space >= 30 && space <= 35) { 
> +		return 1;	/* logic one */
> +	}
> +	if (space >= 9 && space <= 14) {
> +		return 0;	/* logic zero */
> +	}
> +
> +	return -1;	/* Inappropriate space value for NEC */
> +}
> +
> +/*
> + * Routine that processes each data packet coming in from the remote.
> + */
> +static void tivoir_process_packet(struct usb_tivoir *remote)
> +{
> +	int i, length, bit;
> +	u8 code;
> +
> +	/* Lower 5 bits of the first byte is the length of the packet */
> +	length = (remote->in_buffer[0]) & 0x1f;
> +
> +	if (length == 0) {
> +		remote->repeat = 0;
> +		if(remote->code != 0) tivoir_report_key(remote);

Formatting... You know, just run it through scripts/checkpatch.pl

> +		reset_remote(remote);
> +		return;
> +	}
> +
> +	for (i = 1; i <= length; i++) {
> +		code = remote->in_buffer[i];
> +		if (remote->stage == 0) {
> +			if (is_pulse(code)) {
> +				remote->pulse += code & PULSE_MASK;
> +			} else {
> +				remote->space += code;
> +				if (is_nec(remote->pulse, remote->space)) {
> +					/* Get ready to receive the code */
> +					remote->stage = 1;
> +					remote->pulse = 0;
> +					remote->space = 0;
> +				} else {	/* Non NEC remote, ignore the rest 
> +						 * wait for stop signal
> +						 */
> +					if(debug) dev_info(&remote->udev->dev, "%s: Non NEC remote.\n",
> +							   __func__);
> +					remote->stage = 2;	
> +				}
> +			}
> +			continue;
> +		}
> +		if (remote->stage == 1) {
> +			if (is_pulse(code)) 
> +				remote->pulse = code & PULSE_MASK;
> +			else
> +				remote->space = code;
> +
> +			if(remote->pulse == 0 || remote->space == 0) /* pulse/space not filled in yet */
> +				continue;
> +
> +			bit = nec_bit(remote->pulse, remote->space);
> +
> +			/* reset pulse/space value after decoding */
> +			remote->pulse = 0;
> +			remote->space = 0;
> +
> +			if(bit < 0) {	/* Non NEC remote, ignore the rest and wait for stop signal */
> +				remote->stage = 2;
> +				continue;
> +			}
> +
> +			/* A logic 1 or 0 bit detected, store it in remote->code.
> +			 * First 16 bits are the remote address, LSB first. 
> +			 * Last 16 bits are the remote command, LSB first.
> +			 * We save the address in the higher 16 bits in remote->code
> +			 * and the command in the lower 16 bits in remote->code.
> +			 */
> +			if (remote->bitcount < 16)  
> +				bit = bit << (remote->bitcount + 16);
> +			else
> +				bit = bit << (remote->bitcount - 16);
> +			remote->code |= bit;
> +			remote->bitcount++;
> +			
> +			if (remote->bitcount == 32) {
> +				/* Received all 32 bits from the remote, report the key pressed */
> +				remote->repeat = 1;
> +				tivoir_report_key(remote);
> +				remote->stage = 2;
> +			}
> +			continue;
> +		}
> +		if (remote->stage == 2) {	/* waiting for stop signal */

It looks this while loop body wants:

		switch (remote->stage) {
		case 1:
			...
		case 2:
			...
		case 3:
			...
		}

Maybe even add #defines for 1, 2 and 3.

> +			if (code == 0x5f) {	/* beginning of stop signal, followed by 0x80 */
> +				if(i+1 < RECV_SIZE && remote->in_buffer[i+1] == 0x80)
> +				remote->repeat = 0;
> +				if(remote->code != 0) tivoir_report_key(remote);
> +				reset_remote(remote);
> +			}
> +		}
> +
> +	}
> +}
> +
> +/*
> + * Routine used to handle a new packet that has come in.
> + */
> +static void tivoir_irq_recv(struct urb *urb)
> +{
> +	struct usb_tivoir *dev = urb->context;
> +	int i, retval;
> +
> +	/* Check our status in case we need to bail out early. */
> +	switch (urb->status) {
> +	case 0:
> +		break;
> +
> +	/* Device went away so don't keep trying to read from it. */
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		return;
> +
> +	default:
> +		goto resubmit;
> +		break;
> +	}
> +
> +	if (debug)
> +		tivoir_print_packet(dev);
> +	tivoir_process_packet(dev);
> +
> +	for (i = 0; i < RECV_SIZE; i++)
> +		dev->in_buffer[i] = 0;
> +
> +resubmit:
> +	retval = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (retval)
> +		err("%s - usb_submit_urb failed with result: %d", __func__,
> +		    retval);
> +}
> +
> +static int tivoir_open(struct input_dev *dev)
> +{
> +	struct usb_tivoir *remote = input_get_drvdata(dev);
> +
> +	remote->irq_urb->dev = remote->udev;
> +	if (usb_submit_urb(remote->irq_urb, GFP_KERNEL))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static void tivoir_close(struct input_dev *dev)
> +{
> +	struct usb_tivoir *remote = input_get_drvdata(dev);
> +
> +	usb_kill_urb(remote->irq_urb);
> +}
> +
> +static struct usb_endpoint_descriptor *tivoir_get_in_endpoint(struct usb_host_interface *iface)
> +{
> +	struct usb_endpoint_descriptor *endpoint;
> +	int i;
> +
> +	for (i = 0; i < iface->desc.bNumEndpoints; ++i) {
> +		endpoint = &iface->endpoint[i].desc;
> +
> +		if (usb_endpoint_is_int_in(endpoint)) {
> +			/* we found our interrupt in endpoint */
> +			return endpoint;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * Routine that sets up the driver to handle a specific USB device detected on the bus.
> + */
> +static int tivoir_probe(struct usb_interface *interface, const struct usb_device_id *id)
> +{
> +	struct usb_device *udev = interface_to_usbdev(interface);
> +	struct usb_endpoint_descriptor *endpoint;
> +	struct usb_tivoir *remote;
> +	struct input_dev *input_dev;
> +	int i, error;
> +
> +	endpoint = tivoir_get_in_endpoint(interface->cur_altsetting);
> +	if (!endpoint)
> +		return -ENODEV;
> +
> +	/* The interface descriptor has invalid bInterval setting 0x00 and the usb core
> +	 * driver sets it to the default of 32ms, which is too big and causes data loss.
> +	 * Set it to 16ms here.
> +	 */
> +	endpoint->bInterval = 16;
> +
> +	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!remote || !input_dev) {
> +		error = -ENOMEM;
> +		goto fail1;
> +	}
> +
> +	remote->udev = udev;
> +	remote->input = input_dev;
> +	remote->interface = interface;
> +	remote->in_endpoint = endpoint;
> +
> +	remote->in_buffer =
> +	    usb_buffer_alloc(udev, RECV_SIZE, GFP_ATOMIC, &remote->in_dma);
> +	if (!remote->in_buffer) {
> +		error = -ENOMEM;
> +		goto fail1;
> +	}
> +
> +	remote->irq_urb = usb_alloc_urb(0, GFP_KERNEL);
> +	if (!remote->irq_urb) {
> +		error = -ENOMEM;
> +		goto fail2;
> +	}
> +
> +	if (udev->manufacturer)
> +		strlcpy(remote->name, udev->manufacturer, sizeof(remote->name));
> +
> +	if (udev->product) {
> +		if (udev->manufacturer)
> +			strlcat(remote->name, " ", sizeof(remote->name));
> +		strlcat(remote->name, udev->product, sizeof(remote->name));
> +	}
> +
> +	if (!strlen(remote->name))
> +		snprintf(remote->name, sizeof(remote->name),
> +			 "USB TiVo PC IR Dongle %04x:%04x",
> +			 le16_to_cpu(udev->descriptor.idVendor),
> +			 le16_to_cpu(udev->descriptor.idProduct));
> +
> +	usb_make_path(udev, remote->phys, sizeof(remote->phys));
> +	strlcat(remote->phys, "/input0", sizeof(remote->phys));
> +	memcpy(remote->keymap, tivoir_key_table, sizeof(remote->keymap));
> +
> +	input_dev->name = remote->name;
> +	input_dev->phys = remote->phys;
> +	usb_to_input_id(udev, &input_dev->id);
> +	input_dev->dev.parent = &interface->dev;
> +	input_dev->keycode = remote->keymap;
> +	input_dev->keycodesize = sizeof(unsigned short);
> +	input_dev->keycodemax = ARRAY_SIZE(remote->keymap);

You can't set keycode, keycodesize and keycodemax if you are using
anything but plain array for keymap (where "scancode" is used as an
index in the array of keycodes), otherwise default kernel implementation
of getting and setting keycodes will not work correctly.

Consider using the sparse keymap library (drivers/input/sparse-keymap.c
- now in mainline) instead.

> +
> +	set_bit(EV_KEY, input_dev->evbit);
> +	for (i = 0; i < ARRAY_SIZE(tivoir_key_table); i++)
> +		set_bit(tivoir_key_table[i].key, input_dev->keybit);
> +	clear_bit(KEY_RESERVED, input_dev->keybit);
> +
> +	input_set_drvdata(input_dev, remote);
> +
> +	input_dev->open = tivoir_open;
> +	input_dev->close = tivoir_close;
> +
> +	/*
> +	 * Initialize the URB to access the device.
> +	 * The urb gets sent to the device in tivoir_open()
> +	 */
> +	usb_fill_int_urb(remote->irq_urb,
> +			 remote->udev,
> +			 usb_rcvintpipe(remote->udev,
> +					endpoint->bEndpointAddress),
> +			 remote->in_buffer, RECV_SIZE, tivoir_irq_recv, remote,
> +			 endpoint->bInterval);
> +	remote->irq_urb->transfer_dma = remote->in_dma;
> +	remote->irq_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
> +
> +	/* we can register the device now, as it is ready */
> +	error = input_register_device(remote->input);
> +	if (error)
> +		goto fail3;
> +
> +	/* save our data pointer in this interface device */
> +	usb_set_intfdata(interface, remote);
> +
> +	return 0;
> +
> +fail3:	usb_free_urb(remote->irq_urb);
> +fail2:	usb_buffer_free(udev, RECV_SIZE, remote->in_buffer,
> +			remote->in_dma);
> +fail1:	kfree(remote);
> +	input_free_device(input_dev);
> +
> +	return error;
> +}
> +
> +/*
> + * Routine called when a device is disconnected from the USB.
> + */
> +static void tivoir_disconnect(struct usb_interface *interface)
> +{
> +	struct usb_tivoir *remote;
> +
> +	remote = usb_get_intfdata(interface);
> +	usb_set_intfdata(interface, NULL);
> +
> +	if (remote) {		

No need to check for remote being not NULL - we won't be called
otherwise.

> +		/* We have a valid driver structure so clean up everything we allocated. */
> +		input_unregister_device(remote->input);
> +		usb_kill_urb(remote->irq_urb);
> +		usb_free_urb(remote->irq_urb);
> +		usb_buffer_free(remote->udev, RECV_SIZE, remote->in_buffer,
> +				remote->in_dma);
> +		kfree(remote);
> +	}
> +}
> +
> +/*
> + * Standard driver set up sections
> + */
> +static struct usb_driver tivoir_driver = {
> +	.name = "tivoir",
> +	.probe = tivoir_probe,
> +	.disconnect = tivoir_disconnect,
> +	.id_table = tivoir_table
> +};
> +
> +static int __init usb_tivoir_init(void)
> +{
> +	int result;
> +
> +	/* register this driver with the USB subsystem */
> +	result = usb_register(&tivoir_driver);
> +	if (result)
> +		err("usb_register failed. Error number %d\n", result);
> +
> +	return result;
> +}
> +
> +static void __exit usb_tivoir_exit(void)
> +{
> +	/* deregister this driver with the USB subsystem */
> +	usb_deregister(&tivoir_driver);
> +}
> +
> +module_init(usb_tivoir_init);
> +module_exit(usb_tivoir_exit);
> +
> +MODULE_DEVICE_TABLE(usb, tivoir_table);
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE(DRIVER_LICENSE);

-- 
Dmitry
