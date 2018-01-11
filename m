From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [RESEND PATCH v2] input: pxrc: new driver for PhoenixRC Flight
 Controller Adapter
Date: Thu, 11 Jan 2018 13:07:42 +0100
Message-ID: <20180111120742.GA32505@gmail.com>
References: <20180110131139.7238-1-marcus.folkesson@gmail.com>
 <20180111003714.34kgsbdtaqjwuyis@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180111003714.34kgsbdtaqjwuyis@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thank you for your review!

On Wed, Jan 10, 2018 at 04:37:14PM -0800, Dmitry Torokhov wrote:
> Hi Marcus,
> 
> On Wed, Jan 10, 2018 at 02:11:39PM +0100, Marcus Folkesson wrote:
> > This driver let you plug in your RC controller to the adapter and
> > use it as input device in various RC simulators.
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> > v2:
> > 	- Change module license to GPLv2 to match SPDX tag
> > 
> >  Documentation/input/devices/pxrc.rst |  57 ++++++++
> >  drivers/input/joystick/Kconfig       |   9 ++
> >  drivers/input/joystick/Makefile      |   1 +
> >  drivers/input/joystick/pxrc.c        | 254 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 321 insertions(+)
> >  create mode 100644 Documentation/input/devices/pxrc.rst
> >  create mode 100644 drivers/input/joystick/pxrc.c
> > 
> > diff --git a/Documentation/input/devices/pxrc.rst b/Documentation/input/devices/pxrc.rst
> > new file mode 100644
> > index 000000000000..0ec466c58958
> > --- /dev/null
> > +++ b/Documentation/input/devices/pxrc.rst
> > @@ -0,0 +1,57 @@
> > +=======================================================
> > +pxrc - PhoenixRC Flight Controller Adapter
> > +=======================================================
> > +
> > +:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
> > +
> > +This driver let you use your own RC controller plugged into the
> > +adapter that comes with PhoenixRC [1]_ or other compatible adapters.
> > +
> > +The adapter supports 7 analog channels and 1 digital input switch.
> > +
> > +Notes
> > +=====
> > +
> > +Many RC controllers is able to configure which stick goes to which channel.
> > +This is also configurable in most simulators, so a matching is not necessary.
> > +
> > +The driver is generating the following input event for analog channels:
> > +
> > ++---------+----------------+
> > +| Channel |      Event     |
> > ++=========+================+
> > +|     1   |  ABS_X         |
> > ++---------+----------------+
> > +|     2   |  ABS_Y         |
> > ++---------+----------------+
> > +|     3   |  ABS_RX        |
> > ++---------+----------------+
> > +|     4   |  ABS_RY        |
> > ++---------+----------------+
> > +|     5   |  ABS_TILT_X    |
> > ++---------+----------------+
> > +|     6   |  ABS_TILT_Y    |
> > ++---------+----------------+
> 
> TILT are normally reserved for stylus/pen. Do we have better event codes
> maybe? Is there a picture of the RC so I can make more sense of the
> proposed event assignment?
> 

Ok, maybe RUDDER and MISC?
The driver is actually for an "adapter" [1] that you connect your RC to.
The RC is then mapping its sticks/buttons to different channels. Unlike other
joysticks, this mapping is not fixed but something you setup in your RC.

For example, I'm using a Turnigy 9xr[2].

The RC is typically used with a RC Flight Simulator software (I'm using
Heli-X [3] when testing) which also map the channels to events (throttle,
rudder and so on).


> > +|     7   |  ABS_THROTTLE  |
> > ++---------+----------------+
> > +
> > +The digital input switch is generated as an `BTN_A` event.
> > +
> > +Manual Testing
> > +==============
> > +
> > +To test this driver's functionality you may use `input-event` which is part of
> > +the `input layer utilities` suite [2]_.
> > +
> > +For example::
> > +
> > +    > modprobe pxrc
> > +    > input-events <devnr>
> > +
> > +To print all input events from input `devnr`.
> > +
> > +References
> > +==========
> > +
> > +.. [1] http://www.phoenix-sim.com/
> > +.. [2] https://www.kraxel.org/cgit/input/
> > diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> > index f3c2f6ea8b44..18ab6dafff41 100644
> > --- a/drivers/input/joystick/Kconfig
> > +++ b/drivers/input/joystick/Kconfig
> > @@ -351,4 +351,13 @@ config JOYSTICK_PSXPAD_SPI_FF
> >  
> >  	  To drive rumble motor a dedicated power supply is required.
> >  
> > +config JOYSTICK_PXRC
> > +	tristate "PhoenixRC Flight Controller Adapter"
> > +	depends on USB_ARCH_HAS_HCD
> > +	select USB
> > +	help
> > +	  Say Y here if you want to use the PhoenixRC Flight Controller Adapter.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called pxrc.
> >  endif
> > diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
> > index 67651efda2e1..dd0492ebbed7 100644
> > --- a/drivers/input/joystick/Makefile
> > +++ b/drivers/input/joystick/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_JOYSTICK_JOYDUMP)		+= joydump.o
> >  obj-$(CONFIG_JOYSTICK_MAGELLAN)		+= magellan.o
> >  obj-$(CONFIG_JOYSTICK_MAPLE)		+= maplecontrol.o
> >  obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+= psxpad-spi.o
> > +obj-$(CONFIG_JOYSTICK_PXRC)			+= pxrc.o
> >  obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
> >  obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
> >  obj-$(CONFIG_JOYSTICK_SPACEORB)		+= spaceorb.o
> > diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> > new file mode 100644
> > index 000000000000..2bec99df97e2
> > --- /dev/null
> > +++ b/drivers/input/joystick/pxrc.c
> > @@ -0,0 +1,254 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Phoenix RC Flight Controller Adapter
> > + *
> > + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> > + *
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/slab.h>
> > +#include <linux/module.h>
> > +#include <linux/kref.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/usb.h>
> > +#include <linux/mutex.h>
> > +#include <linux/input.h>
> > +
> > +#define PXRC_VENDOR_ID	(0x1781)
> > +#define PXRC_PRODUCT_ID	(0x0898)
> > +
> > +static const struct usb_device_id pxrc_table[] = {
> > +	{ USB_DEVICE(PXRC_VENDOR_ID, PXRC_PRODUCT_ID) },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(usb, pxrc_table);
> > +
> > +struct usb_pxrc {
> > +	struct input_dev	*input_dev;
> > +	struct usb_device	*udev;
> > +	struct usb_interface	*interface;
> > +	struct usb_anchor	anchor;
> > +	__u8			epaddr;
> > +	char			phys[64];
> > +	unsigned char           *data;
> > +	size_t			bsize;
> > +	struct kref		kref;
> > +};
> > +
> > +#define to_pxrc_dev(d) container_of(d, struct usb_pxrc, kref)
> > +static void pxrc_delete(struct kref *kref)
> > +{
> > +	struct usb_pxrc *pxrc = to_pxrc_dev(kref);
> > +
> > +	usb_put_dev(pxrc->udev);
> > +}
> > +
> > +static void pxrc_usb_irq(struct urb *urb)
> > +{
> > +	struct usb_pxrc *pxrc = urb->context;
> > +
> > +	switch (urb->status) {
> > +	case 0:
> > +		/* success */
> > +		break;
> > +	case -ETIME:
> > +		/* this urb is timing out */
> > +		dev_dbg(&pxrc->interface->dev,
> > +			"%s - urb timed out - was the device unplugged?\n",
> > +			__func__);
> > +		return;
> > +	case -ECONNRESET:
> > +	case -ENOENT:
> > +	case -ESHUTDOWN:
> > +	case -EPIPE:
> > +		/* this urb is terminated, clean up */
> > +		dev_dbg(&pxrc->interface->dev, "%s - urb shutting down with status: %d\n",
> > +			__func__, urb->status);
> > +		return;
> > +	default:
> > +		dev_dbg(&pxrc->interface->dev, "%s - nonzero urb status received: %d\n",
> > +			__func__, urb->status);
> > +		goto exit;
> > +	}
> > +
> > +	if (urb->actual_length == 8) {
> > +		input_report_abs(pxrc->input_dev, ABS_X, pxrc->data[0]);
> > +		input_report_abs(pxrc->input_dev, ABS_Y, pxrc->data[2]);
> > +		input_report_abs(pxrc->input_dev, ABS_RX, pxrc->data[3]);
> > +		input_report_abs(pxrc->input_dev, ABS_RY, pxrc->data[4]);
> > +		input_report_abs(pxrc->input_dev, ABS_TILT_X, pxrc->data[5]);
> > +		input_report_abs(pxrc->input_dev, ABS_TILT_Y, pxrc->data[6]);
> > +		input_report_abs(pxrc->input_dev, ABS_THROTTLE, pxrc->data[7]);
> > +
> > +		input_report_key(pxrc->input_dev, BTN_A, pxrc->data[1]);
> > +	}
> > +
> > +exit:
> > +	/* Resubmit to fetch new fresh URBs */
> > +	usb_anchor_urb(urb, &pxrc->anchor);
> > +	if (usb_submit_urb(urb, GFP_ATOMIC) < 0)
> > +		usb_unanchor_urb(urb);
> > +}
> > +
> > +static int pxrc_submit_intr_urb(struct usb_pxrc *pxrc)
> > +{
> > +	struct urb *urb;
> > +	unsigned int pipe;
> > +	int err;
> > +
> > +	urb = usb_alloc_urb(0, GFP_KERNEL);
> > +	if (!urb)
> > +		return -ENOMEM;
> > +
> > +	pipe = usb_rcvintpipe(pxrc->udev, pxrc->epaddr),
> > +	usb_fill_int_urb(urb, pxrc->udev, pipe, pxrc->data, pxrc->bsize,
> > +						pxrc_usb_irq, pxrc, 1);
> > +	usb_anchor_urb(urb, &pxrc->anchor);
> > +	err = usb_submit_urb(urb, GFP_KERNEL);
> > +	if (err < 0)
> > +		usb_unanchor_urb(urb);
> > +
> > +	usb_free_urb(urb);
> > +	return err;
> > +}
> > +
> > +static int pxrc_open(struct input_dev *input)
> > +{
> > +	struct usb_pxrc *pxrc = input_get_drvdata(input);
> > +	int err;
> > +
> > +	err = pxrc_submit_intr_urb(pxrc);
> > +	if (err < 0)
> > +		goto error;
> > +
> > +	kref_get(&pxrc->kref);
> > +	return 0;
> > +
> > +error:
> > +	usb_kill_anchored_urbs(&pxrc->anchor);
> > +	return err;
> > +}
> > +
> > +static void pxrc_close(struct input_dev *input)
> > +{
> > +	struct usb_pxrc *pxrc = input_get_drvdata(input);
> > +
> > +	usb_kill_anchored_urbs(&pxrc->anchor);
> > +	kref_put(&pxrc->kref, pxrc_delete);
> 
> This is way to complex and I am not sure why you need to anchor URBs and
> have a separate refcounting, etc. I do not think it is even safe with
> module unloading as kref might be in flight as you run through module
> unload and devm will destroy most of the objects.
> 
> Why don't you simply use usb_kill_urb() here and be done.
> input_unregister_device() that is called as part of devm unwind on
> device unbind will make sure that pxrc_close() is called.
> 
> Thanks.
> 

Ok, I drop the refcounting. pxrc_delete() did more before I changed most
allocations to devm_*.
I tried to get the refcounting similiar to /drivers/usb/usb-skeleton.c.

I have tried different approaches with the create/delete URBs.
At first I had the URB in the usb_pxrc struct that I allocated in the
probe function where I also submitted the URB.

This worked but I found it waste to submit URBs when noone has opened the
device, so I moved the submitting to pxrc_open().
The problem was that the same URB was submitted multiple times (gives a
warning) upon multiple calls to open(2).

So I removed the URB from usb_pxrc and used an anchor to still have a
reference to it for deletion. This part is heavily inspired by
drivers/bluetooth/bpa10x.c.
Maybe I should do it differently?

I must admit that I'm not very familiar with USB drivers.

> > +}
> > +
> > +static int pxrc_input_init(struct usb_pxrc *pxrc)
> > +{
> > +	pxrc->input_dev = devm_input_allocate_device(&pxrc->interface->dev);
> > +	if (pxrc->input_dev == NULL) {
> > +		dev_err(&pxrc->interface->dev, "couldn't allocate input device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	pxrc->input_dev->name = "PXRC Flight Controller Adapter";
> > +	pxrc->input_dev->phys = pxrc->phys;
> > +	pxrc->input_dev->id.bustype = BUS_USB;
> > +	pxrc->input_dev->id.vendor = PXRC_VENDOR_ID;
> > +	pxrc->input_dev->id.product = PXRC_PRODUCT_ID;
> > +	pxrc->input_dev->id.version = 0x01;
> 
> 	usb_to_input_id(udev, &pxrc->input_dev->id);
> 

Will do, thanks.

> > +
> > +	pxrc->input_dev->open = pxrc_open;
> > +	pxrc->input_dev->close = pxrc_close;
> > +
> > +	pxrc->input_dev->evbit[0] =	BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
> > +	pxrc->input_dev->absbit[0] =	BIT_MASK(ABS_X) |
> > +					BIT_MASK(ABS_Y) |
> > +					BIT_MASK(ABS_RY) |
> > +					BIT_MASK(ABS_RX) |
> > +					BIT_MASK(ABS_THROTTLE) |
> > +					BIT_MASK(ABS_TILT_X) |
> > +					BIT_MASK(ABS_TILT_Y);
> 
> Not needed, it will be done as part of input_set_abs_params() below.
> 

Ok

> > +
> > +	pxrc->input_dev->keybit[BIT_WORD(BTN_JOYSTICK)] = BIT_MASK(BTN_A);
> 
> input_set_capability(pxrc->input_dev, EV_KEY, BTN_A);
> 

Ok

> > +
> > +	input_set_abs_params(pxrc->input_dev, ABS_X, 0, 255, 0, 0);
> > +	input_set_abs_params(pxrc->input_dev, ABS_Y, 0, 255, 0, 0);
> > +	input_set_abs_params(pxrc->input_dev, ABS_RX, 0, 255, 0, 0);
> > +	input_set_abs_params(pxrc->input_dev, ABS_RY, 0, 255, 0, 0);
> > +	input_set_abs_params(pxrc->input_dev, ABS_TILT_X, 0, 255, 0, 0);
> > +	input_set_abs_params(pxrc->input_dev, ABS_TILT_Y, 0, 255, 0, 0);
> > +	input_set_abs_params(pxrc->input_dev, ABS_THROTTLE, 0, 255, 0, 0);
> > +
> > +	input_set_drvdata(pxrc->input_dev, pxrc);
> > +
> > +	return input_register_device(pxrc->input_dev);
> > +}
> > +
> > +static int pxrc_probe(struct usb_interface *interface,
> > +		      const struct usb_device_id *id)
> > +{
> > +	struct usb_pxrc *pxrc;
> > +	struct usb_endpoint_descriptor *epirq;
> > +	int retval;
> > +
> > +	pxrc = devm_kzalloc(&interface->dev, sizeof(*pxrc), GFP_KERNEL);
> > +
> > +	if (!pxrc)
> > +		return -ENOMEM;
> > +
> > +	kref_init(&pxrc->kref);
> > +	init_usb_anchor(&pxrc->anchor);
> > +
> > +	pxrc->udev = usb_get_dev(interface_to_usbdev(interface));
> > +	pxrc->interface = interface;
> > +
> > +	/* Set up the endpoint information */
> > +	/* This device only has an interrupt endpoint */
> > +	retval = usb_find_common_endpoints(interface->cur_altsetting,
> > +			NULL, NULL, &epirq, NULL);
> > +	if (retval) {
> > +		dev_err(&interface->dev,
> > +			"Could not find endpoint\n");
> > +		goto error;
> > +	}
> > +
> > +	pxrc->bsize = usb_endpoint_maxp(epirq);
> > +	pxrc->epaddr = epirq->bEndpointAddress;
> > +	pxrc->data = devm_kmalloc(&interface->dev, pxrc->bsize, GFP_KERNEL);
> > +	if (!pxrc->data) {
> > +		retval = -ENOMEM;
> > +		goto error;
> > +	}
> > +
> > +	usb_set_intfdata(interface, pxrc);
> > +	usb_make_path(pxrc->udev, pxrc->phys, sizeof(pxrc->phys));
> > +
> > +	retval = pxrc_input_init(pxrc);
> > +	if (retval)
> > +		goto error;
> > +
> > +	return 0;
> > +
> > +error:
> > +	/* this frees allocated memory */
> > +	kref_put(&pxrc->kref, pxrc_delete);
> > +
> > +	return retval;
> > +}
> > +
> > +static void pxrc_disconnect(struct usb_interface *interface)
> > +{
> > +	struct usb_pxrc *pxrc = usb_get_intfdata(interface);
> > +
> > +	kref_put(&pxrc->kref, pxrc_delete);
> > +}
> > +
> > +static struct usb_driver pxrc_driver = {
> > +	.name =		"pxrc",
> > +	.probe =	pxrc_probe,
> > +	.disconnect =	pxrc_disconnect,
> > +	.id_table =	pxrc_table,
> > +};
> > +
> > +module_usb_driver(pxrc_driver);
> > +
> > +MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
> > +MODULE_DESCRIPTION("PhoenixRC Flight Controller Adapter");
> > +MODULE_LICENSE("GPL v2");
> > -- 
> > 2.15.1
> > 
> 
> Thanks.
> 
> -- 
> Dmitry

Best Regards
Marcus Folkesson


[1] https://images.okr.ro/auctions.v3/400_400/2010/09/24/2/e/630212971498401813252942-8740-400_400.jpg
[2] https://hobbyking.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/legacy/catalog/9xr_ft.jpg
[3] http://www.heli-x.info/cms/[3] http://www.heli-x.info/cms/[3]
http://www.heli-x.info/cms/
