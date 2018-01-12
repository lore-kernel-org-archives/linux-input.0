From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH v2] input: pxrc: new driver for PhoenixRC Flight
 Controller Adapter
Date: Fri, 12 Jan 2018 00:05:35 -0800
Message-ID: <20180112080535.iw64xbjvtomusc5n@dtor-ws>
References: <20180110131139.7238-1-marcus.folkesson@gmail.com>
 <20180111003714.34kgsbdtaqjwuyis@dtor-ws>
 <20180111120742.GA32505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180111120742.GA32505@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jan 11, 2018 at 01:07:42PM +0100, Marcus Folkesson wrote:
> Hi Dmitry,
> 
> Thank you for your review!
> 
> On Wed, Jan 10, 2018 at 04:37:14PM -0800, Dmitry Torokhov wrote:
> > Hi Marcus,
> > 
> > On Wed, Jan 10, 2018 at 02:11:39PM +0100, Marcus Folkesson wrote:
> > > This driver let you plug in your RC controller to the adapter and
> > > use it as input device in various RC simulators.
> > > 
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > ---
> > > v2:
> > > 	- Change module license to GPLv2 to match SPDX tag
> > > 
> > >  Documentation/input/devices/pxrc.rst |  57 ++++++++
> > >  drivers/input/joystick/Kconfig       |   9 ++
> > >  drivers/input/joystick/Makefile      |   1 +
> > >  drivers/input/joystick/pxrc.c        | 254 +++++++++++++++++++++++++++++++++++
> > >  4 files changed, 321 insertions(+)
> > >  create mode 100644 Documentation/input/devices/pxrc.rst
> > >  create mode 100644 drivers/input/joystick/pxrc.c
> > > 
> > > diff --git a/Documentation/input/devices/pxrc.rst b/Documentation/input/devices/pxrc.rst
> > > new file mode 100644
> > > index 000000000000..0ec466c58958
> > > --- /dev/null
> > > +++ b/Documentation/input/devices/pxrc.rst
> > > @@ -0,0 +1,57 @@
> > > +=======================================================
> > > +pxrc - PhoenixRC Flight Controller Adapter
> > > +=======================================================
> > > +
> > > +:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > +
> > > +This driver let you use your own RC controller plugged into the
> > > +adapter that comes with PhoenixRC [1]_ or other compatible adapters.
> > > +
> > > +The adapter supports 7 analog channels and 1 digital input switch.
> > > +
> > > +Notes
> > > +=====
> > > +
> > > +Many RC controllers is able to configure which stick goes to which channel.
> > > +This is also configurable in most simulators, so a matching is not necessary.
> > > +
> > > +The driver is generating the following input event for analog channels:
> > > +
> > > ++---------+----------------+
> > > +| Channel |      Event     |
> > > ++=========+================+
> > > +|     1   |  ABS_X         |
> > > ++---------+----------------+
> > > +|     2   |  ABS_Y         |
> > > ++---------+----------------+
> > > +|     3   |  ABS_RX        |
> > > ++---------+----------------+
> > > +|     4   |  ABS_RY        |
> > > ++---------+----------------+
> > > +|     5   |  ABS_TILT_X    |
> > > ++---------+----------------+
> > > +|     6   |  ABS_TILT_Y    |
> > > ++---------+----------------+
> > 
> > TILT are normally reserved for stylus/pen. Do we have better event codes
> > maybe? Is there a picture of the RC so I can make more sense of the
> > proposed event assignment?
> > 
> 
> Ok, maybe RUDDER and MISC?

OK.

> The driver is actually for an "adapter" [1] that you connect your RC to.
> The RC is then mapping its sticks/buttons to different channels. Unlike other
> joysticks, this mapping is not fixed but something you setup in your RC.
> 
> For example, I'm using a Turnigy 9xr[2].
> 
> The RC is typically used with a RC Flight Simulator software (I'm using
> Heli-X [3] when testing) which also map the channels to events (throttle,
> rudder and so on).
> 
> 
> > > +|     7   |  ABS_THROTTLE  |
> > > ++---------+----------------+
> > > +
> > > +The digital input switch is generated as an `BTN_A` event.
> > > +
> > > +Manual Testing
> > > +==============
> > > +
> > > +To test this driver's functionality you may use `input-event` which is part of
> > > +the `input layer utilities` suite [2]_.
> > > +
> > > +For example::
> > > +
> > > +    > modprobe pxrc
> > > +    > input-events <devnr>
> > > +
> > > +To print all input events from input `devnr`.
> > > +
> > > +References
> > > +==========
> > > +
> > > +.. [1] http://www.phoenix-sim.com/
> > > +.. [2] https://www.kraxel.org/cgit/input/
> > > diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> > > index f3c2f6ea8b44..18ab6dafff41 100644
> > > --- a/drivers/input/joystick/Kconfig
> > > +++ b/drivers/input/joystick/Kconfig
> > > @@ -351,4 +351,13 @@ config JOYSTICK_PSXPAD_SPI_FF
> > >  
> > >  	  To drive rumble motor a dedicated power supply is required.
> > >  
> > > +config JOYSTICK_PXRC
> > > +	tristate "PhoenixRC Flight Controller Adapter"
> > > +	depends on USB_ARCH_HAS_HCD
> > > +	select USB
> > > +	help
> > > +	  Say Y here if you want to use the PhoenixRC Flight Controller Adapter.
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called pxrc.
> > >  endif
> > > diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
> > > index 67651efda2e1..dd0492ebbed7 100644
> > > --- a/drivers/input/joystick/Makefile
> > > +++ b/drivers/input/joystick/Makefile
> > > @@ -23,6 +23,7 @@ obj-$(CONFIG_JOYSTICK_JOYDUMP)		+= joydump.o
> > >  obj-$(CONFIG_JOYSTICK_MAGELLAN)		+= magellan.o
> > >  obj-$(CONFIG_JOYSTICK_MAPLE)		+= maplecontrol.o
> > >  obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+= psxpad-spi.o
> > > +obj-$(CONFIG_JOYSTICK_PXRC)			+= pxrc.o
> > >  obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
> > >  obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
> > >  obj-$(CONFIG_JOYSTICK_SPACEORB)		+= spaceorb.o
> > > diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> > > new file mode 100644
> > > index 000000000000..2bec99df97e2
> > > --- /dev/null
> > > +++ b/drivers/input/joystick/pxrc.c
> > > @@ -0,0 +1,254 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Driver for Phoenix RC Flight Controller Adapter
> > > + *
> > > + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> > > + *
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/module.h>
> > > +#include <linux/kref.h>
> > > +#include <linux/uaccess.h>
> > > +#include <linux/usb.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/input.h>
> > > +
> > > +#define PXRC_VENDOR_ID	(0x1781)
> > > +#define PXRC_PRODUCT_ID	(0x0898)
> > > +
> > > +static const struct usb_device_id pxrc_table[] = {
> > > +	{ USB_DEVICE(PXRC_VENDOR_ID, PXRC_PRODUCT_ID) },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(usb, pxrc_table);
> > > +
> > > +struct usb_pxrc {
> > > +	struct input_dev	*input_dev;
> > > +	struct usb_device	*udev;
> > > +	struct usb_interface	*interface;
> > > +	struct usb_anchor	anchor;
> > > +	__u8			epaddr;
> > > +	char			phys[64];
> > > +	unsigned char           *data;
> > > +	size_t			bsize;
> > > +	struct kref		kref;
> > > +};
> > > +
> > > +#define to_pxrc_dev(d) container_of(d, struct usb_pxrc, kref)
> > > +static void pxrc_delete(struct kref *kref)
> > > +{
> > > +	struct usb_pxrc *pxrc = to_pxrc_dev(kref);
> > > +
> > > +	usb_put_dev(pxrc->udev);
> > > +}
> > > +
> > > +static void pxrc_usb_irq(struct urb *urb)
> > > +{
> > > +	struct usb_pxrc *pxrc = urb->context;
> > > +
> > > +	switch (urb->status) {
> > > +	case 0:
> > > +		/* success */
> > > +		break;
> > > +	case -ETIME:
> > > +		/* this urb is timing out */
> > > +		dev_dbg(&pxrc->interface->dev,
> > > +			"%s - urb timed out - was the device unplugged?\n",
> > > +			__func__);
> > > +		return;
> > > +	case -ECONNRESET:
> > > +	case -ENOENT:
> > > +	case -ESHUTDOWN:
> > > +	case -EPIPE:
> > > +		/* this urb is terminated, clean up */
> > > +		dev_dbg(&pxrc->interface->dev, "%s - urb shutting down with status: %d\n",
> > > +			__func__, urb->status);
> > > +		return;
> > > +	default:
> > > +		dev_dbg(&pxrc->interface->dev, "%s - nonzero urb status received: %d\n",
> > > +			__func__, urb->status);
> > > +		goto exit;
> > > +	}
> > > +
> > > +	if (urb->actual_length == 8) {
> > > +		input_report_abs(pxrc->input_dev, ABS_X, pxrc->data[0]);
> > > +		input_report_abs(pxrc->input_dev, ABS_Y, pxrc->data[2]);
> > > +		input_report_abs(pxrc->input_dev, ABS_RX, pxrc->data[3]);
> > > +		input_report_abs(pxrc->input_dev, ABS_RY, pxrc->data[4]);
> > > +		input_report_abs(pxrc->input_dev, ABS_TILT_X, pxrc->data[5]);
> > > +		input_report_abs(pxrc->input_dev, ABS_TILT_Y, pxrc->data[6]);
> > > +		input_report_abs(pxrc->input_dev, ABS_THROTTLE, pxrc->data[7]);
> > > +
> > > +		input_report_key(pxrc->input_dev, BTN_A, pxrc->data[1]);
> > > +	}
> > > +
> > > +exit:
> > > +	/* Resubmit to fetch new fresh URBs */
> > > +	usb_anchor_urb(urb, &pxrc->anchor);
> > > +	if (usb_submit_urb(urb, GFP_ATOMIC) < 0)
> > > +		usb_unanchor_urb(urb);
> > > +}
> > > +
> > > +static int pxrc_submit_intr_urb(struct usb_pxrc *pxrc)
> > > +{
> > > +	struct urb *urb;
> > > +	unsigned int pipe;
> > > +	int err;
> > > +
> > > +	urb = usb_alloc_urb(0, GFP_KERNEL);
> > > +	if (!urb)
> > > +		return -ENOMEM;
> > > +
> > > +	pipe = usb_rcvintpipe(pxrc->udev, pxrc->epaddr),
> > > +	usb_fill_int_urb(urb, pxrc->udev, pipe, pxrc->data, pxrc->bsize,
> > > +						pxrc_usb_irq, pxrc, 1);
> > > +	usb_anchor_urb(urb, &pxrc->anchor);
> > > +	err = usb_submit_urb(urb, GFP_KERNEL);
> > > +	if (err < 0)
> > > +		usb_unanchor_urb(urb);
> > > +
> > > +	usb_free_urb(urb);
> > > +	return err;
> > > +}
> > > +
> > > +static int pxrc_open(struct input_dev *input)
> > > +{
> > > +	struct usb_pxrc *pxrc = input_get_drvdata(input);
> > > +	int err;
> > > +
> > > +	err = pxrc_submit_intr_urb(pxrc);
> > > +	if (err < 0)
> > > +		goto error;
> > > +
> > > +	kref_get(&pxrc->kref);
> > > +	return 0;
> > > +
> > > +error:
> > > +	usb_kill_anchored_urbs(&pxrc->anchor);
> > > +	return err;
> > > +}
> > > +
> > > +static void pxrc_close(struct input_dev *input)
> > > +{
> > > +	struct usb_pxrc *pxrc = input_get_drvdata(input);
> > > +
> > > +	usb_kill_anchored_urbs(&pxrc->anchor);
> > > +	kref_put(&pxrc->kref, pxrc_delete);
> > 
> > This is way to complex and I am not sure why you need to anchor URBs and
> > have a separate refcounting, etc. I do not think it is even safe with
> > module unloading as kref might be in flight as you run through module
> > unload and devm will destroy most of the objects.
> > 
> > Why don't you simply use usb_kill_urb() here and be done.
> > input_unregister_device() that is called as part of devm unwind on
> > device unbind will make sure that pxrc_close() is called.
> > 
> > Thanks.
> > 
> 
> Ok, I drop the refcounting. pxrc_delete() did more before I changed most
> allocations to devm_*.
> I tried to get the refcounting similiar to /drivers/usb/usb-skeleton.c.
> 
> I have tried different approaches with the create/delete URBs.
> At first I had the URB in the usb_pxrc struct that I allocated in the
> probe function where I also submitted the URB.
> 
> This worked but I found it waste to submit URBs when noone has opened the
> device, so I moved the submitting to pxrc_open().
> The problem was that the same URB was submitted multiple times (gives a
> warning) upon multiple calls to open(2).

open() should only be called once, unless close() was called. So as long
as you kill the URB in close(), you should not see warnings.

> 
> So I removed the URB from usb_pxrc and used an anchor to still have a
> reference to it for deletion. This part is heavily inspired by
> drivers/bluetooth/bpa10x.c.
> Maybe I should do it differently?
> 
> I must admit that I'm not very familiar with USB drivers.

I'd probably look at drivers/input/mouse/synaptics_usb.c and structured
your driver similarly.

Thanks.

-- 
Dmitry
