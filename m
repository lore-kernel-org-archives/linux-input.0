From: Brian Magnuson <bdmagnuson@gmail.com>
Subject: [PATCH] new driver for wireless xbox receiver for review
Date: Tue, 29 May 2007 00:39:57 -0400
Message-ID: <20070529043957.GB6157@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz, bdmagnuson@gmail.com
List-Id: linux-input@vger.kernel.org

Hi,

This patch implements a driver for the "Microsoft Xbox 360 Wireless Receiver
for Windows" that was recently released.  It seems to mostly "just work" for
the basics at this point and I'd like to get some feedback on it since this is
my first attempt at driver development.

It borrows heavily from xpad.c since it's basically the same controller with
new wireless magic.  The difference being that the receiever can host multiple
controllers through the same device and the driver manages them coming and
going.  In particular I moved the input device creation/deletion out of the
probe function and into workqueues kicked off by usb interrupts.  That would
probably be a good place for prospective reviewers to start finding issues. :)

Thanks for looking.

-Brian

Please CC me on replies since I'm not subscribed.  Thanks.

>From 61e650894787215e5939ad73d100d3fb3ab3ff17 Mon Sep 17 00:00:00 2001
From: Brian Magnuson <magnuson@ferrari.(none)>
Date: Mon, 28 May 2007 23:10:18 -0400
Subject: [PATCH] New xboxrcvr driver


Signed-off-by: Brian Magnuson <bdmagnuson@gmail.com>
---
 drivers/input/joystick/xboxrcvr.c |  463 +++++++++++++++++++++++++++++++++++++
 drivers/input/joystick/xboxrcvr.h |   72 ++++++
 2 files changed, 535 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/xboxrcvr.c b/drivers/input/joystick/xboxrcvr.c
new file mode 100644
index 0000000..e132726
--- /dev/null
+++ b/drivers/input/joystick/xboxrcvr.c
@@ -0,0 +1,463 @@
+/*
+ * Xbox wireless receiver input device driver for Linux - v0.0.1
+ *
+ * Copyright (c)  2007 Brian Magnuson <bdmagnuson@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * This driver is based on:
+ *  - information from     http://euc.jp/periphs/xbox-controller.en.html
+ *  - the iForce driver    drivers/char/joystick/iforce.c
+ *  - the skeleton-driver  drivers/usb/usb-skeleton.c
+ *  - the xpad driver      drivers/usb/input/xpad.c
+ *
+ * Thanks to:
+ *  - ITO Takayuki for providing essential xpad information on his website
+ *  - Vojtech Pavlik     - iforce driver / input subsystem
+ *  - Greg Kroah-Hartman - usb-skeleton driver
+ *  - The xpad.c developers on which this driver is based in large part
+ *        Vojtech Pavlik <vojtech@suse.sz>,
+ *        Oliver Schwartz <Oliver.Schwartz@gmx.de>,
+ *        Thomas Pedley <gentoox@shallax.com>,
+ *        Steven Toth <steve@toth.demon.co.uk>,
+ *        Franz Lehner <franz@caos.at>,
+ *        Ivan Hawkes <blackhawk@ivanhawkes.com>
+ *        Edgar Hucek <hostmaster@ed-soft.at>
+ *        Niklas Lundberg <niklas@jahej.com>
+ *
+ * TODO:
+ *  - Der blinken-lights remain blinking.  The xpad method of turning it off
+ *    doesn't appear to work.
+ *  - Rumble is also not functional
+ *  - There's always the headset. :)  Probably belongs in a different driver.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <linux/usb.h>
+#include <linux/version.h>
+#include <linux/usb/input.h>
+#include <linux/usbdevice_fs.h>
+#include <linux/timer.h>
+#include <asm/uaccess.h>
+
+#include "xboxrcvr.h"
+
+static unsigned long debug = 0;
+module_param(debug, ulong, 0644);
+MODULE_PARM_DESC(debug, "debug level");
+
+static const struct xboxrcvr_device xboxrcvr_device[] = {
+	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver for Windows"}, /* Ha! */
+	{ 0x0000, 0x0000, "nothing detected - FAIL"}
+};
+
+static struct usb_device_id xboxrcvr_table [] = {
+	{ USB_DEVICE(0x045e, 0x0719) },
+	{ }
+};
+
+static const signed short xboxrcvr_btn[] = {
+	BTN_A, BTN_B, BTN_X, BTN_Y,                  /* analogue buttons */
+	BTN_START, BTN_BACK, BTN_THUMBL, BTN_THUMBR, /* start/back/sticks */
+	BTN_0, BTN_1, BTN_2, BTN_3,                  /* d-pad as buttons */
+	BTN_TL, BTN_TR,                              /* Button LB/RB */
+	BTN_MODE,                                    /* The big X */
+	-1                                           /* terminating entry */
+};
+
+static const signed short xboxrcvr_abs[] = {
+	ABS_X, ABS_Y,   /* left stick */
+	ABS_RX, ABS_RY, /* right stick */
+	ABS_Z, ABS_RZ,  /* triggers left/right */
+	-1              /* terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, xboxrcvr_table);
+
+/**
+ * xboxrcvr_process_packet
+ *
+ * Completes a request by converting the data into events
+ * for the input subsystem.
+ *
+ * The report descriptor was taken from ITO Takayukis website:
+ *  http://euc.jp/periphs/xbox-controller.en.html
+ */
+static void xboxrcvr_process_packet(struct usb_xboxrcvr *xboxrcvr, unsigned char *sdata)
+{
+	struct input_dev *dev = xboxrcvr->dev;
+	int i;
+	int last;
+
+	/* Four byte shift over so we can just use the code from xpad.c */
+	unsigned char *data = &sdata[4];
+
+	if(debug) {
+		printk(KERN_INFO "xboxrcvr: id: %d, data:", xboxrcvr->id);
+		/* Just the 4 bytes of header info or everything */
+		if(debug == 1)
+			last = 4;
+		else
+			last = 29;
+		for(i = 0; i < last; i++) {
+			printk("0x%02x ", sdata[i]);
+		}
+		printk("\n");
+		return;
+	}
+
+	/* The 1st four bytes appear to be some kind of status word */
+
+	/* Presence change - Create/Delete an input device */
+	/* Well, we're getting something.  Create a device */
+	if(!xboxrcvr->gamepad_present) {
+		xboxrcvr->gamepad_present = 1;
+		schedule_work(&xboxrcvr->idev_build);
+		return;
+	}
+
+	if(!xboxrcvr->gamepad_registered)
+		return;
+
+	if(sdata[0] & 0x8) {
+		if(!(sdata[1] & 0x80)) {
+			/* xboxrcvr->gamepad_present cleared in teardown */
+			xboxrcvr->gamepad_registered = 0;
+			schedule_work(&xboxrcvr->idev_teardown);
+		}
+
+		/* Doesn't do anything yet.  Thanks for noticing */
+		if(sdata[1] & 0x40) {
+			xboxrcvr->headset_present = 1;
+		} else {
+			xboxrcvr->headset_present = 0;
+		}
+	}
+
+	/* Valid pad data */
+	if(!(sdata[1] & 0x1) || !xboxrcvr->open)
+		return;
+
+	/* digital pad (button mode) bits (3 2 1 0) (right left down up) */
+	input_report_key(dev, BTN_0, (data[2] & 0x01));
+	input_report_key(dev, BTN_1, (data[2] & 0x08) >> 3);
+	input_report_key(dev, BTN_2, (data[2] & 0x02) >> 1);
+	input_report_key(dev, BTN_3, (data[2] & 0x04) >> 2);
+
+	/* start and back buttons */
+	input_report_key(dev, BTN_START, (data[2] & 0x10) >> 4);
+	input_report_key(dev, BTN_BACK,  (data[2] & 0x20) >> 5);
+
+	/* stick press left/right */
+	input_report_key(dev, BTN_THUMBL, (data[2] & 0x40) >> 6);
+	input_report_key(dev, BTN_THUMBR,  data[2] >> 7);
+
+	/* buttons A, B, X, Y digital mode */
+	input_report_key(dev, BTN_A,    (data[3] & 0x10) >> 4);
+	input_report_key(dev, BTN_B,    (data[3] & 0x20) >> 5);
+	input_report_key(dev, BTN_X,    (data[3] & 0x80) >> 7);
+	input_report_key(dev, BTN_Y,    (data[3] & 0x40) >> 6);
+	input_report_key(dev, BTN_TL,    data[3] & 0x01);
+	input_report_key(dev, BTN_TR,   (data[3] & 0x02) >> 1);
+	input_report_key(dev, BTN_MODE, (data[3] & 0x04) >> 2);
+
+	/* left stick */
+	input_report_abs(dev, ABS_X,  (__s16)(((__s16)data[7] << 8) | (__s16)data[6]));
+	input_report_abs(dev, ABS_Y,  (__s16)(((__s16)data[9] << 8) | (__s16)data[8]));
+
+	/* right stick */
+	input_report_abs(dev, ABS_RX, (__s16)(((__s16)data[13] << 8) | (__s16)data[12]));
+	input_report_abs(dev, ABS_RY, (__s16)(((__s16)data[11] << 8) | (__s16)data[10]));
+
+	/* triggers left/right */
+	input_report_abs(dev, ABS_Z,  data[4]);
+	input_report_abs(dev, ABS_RZ, data[5]);
+
+	input_sync(dev);
+}
+
+/**
+ * xboxrcvr_open
+ *
+ * Called when a an application opens the device.
+ */
+static int xboxrcvr_open(struct input_dev *dev)
+{
+	struct usb_xboxrcvr *xboxrcvr = dev->private;
+
+	if(debug)
+		info("opening device");
+	xboxrcvr->open = 1;
+
+	return 0;
+}
+
+/**
+ * xboxrcvr_close
+ *
+ * Called when an application closes the device.
+ */
+static void xboxrcvr_close(struct input_dev *dev)
+{
+	struct usb_xboxrcvr *xboxrcvr = dev->private;
+
+	if(debug)
+		info("closing device");
+	xboxrcvr->open = 0;
+}
+
+/**
+ * xboxrcvr_irq_in
+ *
+ * Completion handler for interrupt in transfers (user input).
+ * Just calls xboxrcvr_process_packet which does then emit input events.
+ */
+static void xboxrcvr_irq_in(struct urb *urb)
+{
+	struct usb_xboxrcvr *xboxrcvr = urb->context;
+	int retval;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d",
+		    __FUNCTION__, urb->status);
+		return;
+	default:
+		dbg("%s - nonzero urb status received: %d",
+		    __FUNCTION__, urb->status);
+		goto exit;
+	}
+
+	xboxrcvr_process_packet(xboxrcvr, xboxrcvr->idata);
+
+exit:
+	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	if (retval)
+		err("%s - usb_submit_urb failed with result %d",
+		    __FUNCTION__, retval);
+}
+
+/*
+ * Create an input device when a controller shows up
+*/
+void idev_build_func(struct work_struct *work)
+{
+	struct usb_xboxrcvr *xboxrcvr = container_of(work, struct usb_xboxrcvr,
+	                                             idev_build);
+
+	struct input_dev *input_dev;
+	char path[65];
+	int i;
+
+	input_dev = input_allocate_device();
+	if(!input_dev) {
+		info("Could not allocate input device");
+		return;
+	}
+
+
+	/* FIXME: Yuck.  Need to make sure this doesn't get truncated */
+	usb_make_path(xboxrcvr->udev, path, sizeof(xboxrcvr->phys));
+	snprintf(xboxrcvr->phys, sizeof(xboxrcvr->phys), "%s/input%d", path, xboxrcvr->id);
+	snprintf(xboxrcvr->uniq, sizeof(xboxrcvr->uniq), "xpad%d", xboxrcvr->id >> 1);
+
+	input_dev->name     = xboxrcvr_device[0].name;
+	input_dev->phys     = xboxrcvr->phys;
+	input_dev->uniq     = xboxrcvr->uniq;
+	input_dev->cdev.dev = &(xboxrcvr->intf->dev);
+	input_dev->private  = xboxrcvr;
+	input_dev->open     = xboxrcvr_open;
+	input_dev->close    = xboxrcvr_close;
+	usb_to_input_id(xboxrcvr->udev, &input_dev->id);
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+
+	for (i = 0; xboxrcvr_btn[i] >= 0; ++i)
+		set_bit(xboxrcvr_btn[i], input_dev->keybit);
+
+	for (i = 0; xboxrcvr_abs[i] >= 0; ++i) {
+
+		signed short t = xboxrcvr_abs[i];
+
+		set_bit(t, input_dev->absbit);
+
+		switch (t) {
+			case ABS_X:
+			case ABS_Y:
+			case ABS_RX:
+			case ABS_RY: /* the two sticks */
+				input_set_abs_params(input_dev, t,
+				  -32768, 32767, 16, 12000);
+				break;
+			case ABS_Z:  /* left trigger */
+			case ABS_RZ: /* right trigger */
+				input_set_abs_params(input_dev, t,
+				   0, 255, 0, 0);
+				break;
+		}
+	}
+
+	xboxrcvr->dev = input_dev;
+	input_register_device(xboxrcvr->dev);
+	xboxrcvr->gamepad_registered = 1;
+}
+
+void xboxrcvr_unregister_idev(struct input_dev **input_dev)
+{
+	if(*input_dev)
+		input_unregister_device(*input_dev);
+	*input_dev = NULL;
+}
+
+void idev_teardown_func(struct work_struct *work)
+{
+	struct usb_xboxrcvr *xboxrcvr = container_of(work, struct usb_xboxrcvr,
+	                                             idev_teardown);
+	xboxrcvr_unregister_idev(&xboxrcvr->dev);
+	xboxrcvr->gamepad_present = 0;
+}
+
+/**
+ * xboxrcvr_probe
+ *
+ * Called upon device detection to find a suitable driver.
+ * Must return NULL when no xboxrcvr is found, else setup everything.
+ */
+static int xboxrcvr_probe(struct usb_interface *intf,
+                          const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_xboxrcvr *xboxrcvr;
+
+	struct usb_endpoint_descriptor *ep_irq_in;
+	int status;
+
+	/* Odd numbered interfaces appear to be audio/microphone */
+	if(intf->cur_altsetting->desc.bInterfaceNumber % 2)
+		return -ENODEV;
+
+	xboxrcvr = kzalloc(sizeof(struct usb_xboxrcvr), GFP_KERNEL);
+	if (!xboxrcvr)
+		goto fail1;
+
+	xboxrcvr->id = intf->cur_altsetting->desc.bInterfaceNumber;
+	xboxrcvr->idata = usb_buffer_alloc(udev, XBOXRCVR_PKT_LEN,
+	                                   GFP_ATOMIC, &xboxrcvr->idata_dma);
+	xboxrcvr->udev = udev;
+
+	if (!xboxrcvr->idata)
+		goto fail1;
+
+	/* setup input interrupt pipe (button and axis state) */
+	xboxrcvr->irq_in = usb_alloc_urb(0, GFP_KERNEL);
+	if (!xboxrcvr->irq_in)
+		goto fail2;
+
+	ep_irq_in = &intf->cur_altsetting->endpoint[0].desc;
+	usb_fill_int_urb(xboxrcvr->irq_in, udev,
+	                 usb_rcvintpipe(udev, ep_irq_in->bEndpointAddress),
+	                 xboxrcvr->idata, XBOXRCVR_PKT_LEN, xboxrcvr_irq_in,
+	                 xboxrcvr, ep_irq_in->bInterval);
+	xboxrcvr->irq_in->transfer_dma = xboxrcvr->idata_dma;
+	xboxrcvr->irq_in->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	usb_set_intfdata(intf, xboxrcvr);
+
+	xboxrcvr->irq_in->dev = xboxrcvr->udev;
+	if ((status = usb_submit_urb(xboxrcvr->irq_in, GFP_KERNEL))) {
+		err("submit int urb failed: %d", status);
+		goto fail2;
+	}
+
+	xboxrcvr->intf = intf;
+	INIT_WORK(&xboxrcvr->idev_build, idev_build_func);
+	INIT_WORK(&xboxrcvr->idev_teardown, idev_teardown_func);
+
+	return 0;
+
+fail2:  usb_buffer_free(udev, XBOXRCVR_PKT_LEN, xboxrcvr->idata,
+                        xboxrcvr->idata_dma);
+fail1:  return -ENOMEM;
+}
+
+/**
+ * xboxrcvr_disconnect
+ *
+ * Called upon device disconnect to dispose of the structures and
+ * close the USB connections.
+ */
+static void xboxrcvr_disconnect(struct usb_interface *intf)
+{
+	struct usb_xboxrcvr *xboxrcvr = usb_get_intfdata(intf);
+
+	usb_set_intfdata(intf, NULL);
+	if (xboxrcvr) {
+		usb_kill_urb(xboxrcvr->irq_in);
+		usb_free_urb(xboxrcvr->irq_in);
+
+		xboxrcvr_unregister_idev(&xboxrcvr->dev);
+
+		usb_buffer_free(interface_to_usbdev(intf), XBOXRCVR_PKT_LEN,
+		                xboxrcvr->idata, xboxrcvr->idata_dma);
+
+		kfree(xboxrcvr);
+	}
+
+}
+
+/******************* Linux driver framework specific stuff ************/
+
+static struct usb_driver xboxrcvr_driver = {
+	.name       = "xboxrcvr",
+	.probe      = xboxrcvr_probe,
+	.disconnect = xboxrcvr_disconnect,
+	.id_table   = xboxrcvr_table,
+};
+
+/**
+ * driver init entry point
+ */
+static int __init usb_xboxrcvr_init(void)
+{
+	int result = usb_register(&xboxrcvr_driver);
+	if (result == 0)
+		info(DRIVER_DESC " " DRIVER_VERSION);
+	return result;
+}
+
+/**
+ * driver exit entry point
+ */
+static void __exit usb_xboxrcvr_exit(void)
+{
+	usb_deregister(&xboxrcvr_driver);
+}
+
+module_init(usb_xboxrcvr_init);
+module_exit(usb_xboxrcvr_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/input/joystick/xboxrcvr.h b/drivers/input/joystick/xboxrcvr.h
new file mode 100644
index 0000000..685dbff
--- /dev/null
+++ b/drivers/input/joystick/xboxrcvr.h
@@ -0,0 +1,72 @@
+/*
+ * Xbox wireless receiver input device driver for Linux - v0.0.1
+ *
+ * Copyright (c)  2007 Brian Magnuson <bdmagnuson@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#ifndef __XBOXRCVR_h
+#define __XBOXRCVR_h
+
+/************************* driver internals ***************************/
+#ifdef __KERNEL__
+
+#include <linux/input.h>
+#include <linux/circ_buf.h>
+
+/****************** driver description and version ********************/
+#define DRIVER_VERSION "v0.0.1"
+#define DRIVER_AUTHOR  "Brian Magnuson"
+#define DRIVER_DESC    "Driver for wireless xbox360 controllers"
+
+#define XBOXRCVR_PKT_LEN 32
+
+/************************* the device struct **************************/
+struct usb_xboxrcvr {
+	struct input_dev *dev;      /* input device interface */
+	struct usb_device *udev;    /* usb device */
+
+	struct urb *irq_in;         /* urb for int. in report */
+
+	int id;
+	int gamepad_present;
+	int gamepad_registered;
+	int headset_present;
+
+	struct usb_interface *intf;
+
+	struct work_struct idev_build;
+	struct work_struct idev_teardown;
+
+	unsigned char *idata;   /* input data */
+	dma_addr_t idata_dma;
+
+	int open;               /* open to the input layer */
+
+	char phys[65];          /* physical input dev path */
+	char uniq[5];           /* unique identifier */
+};
+
+/* for the list of know devices */
+struct xboxrcvr_device {
+	u16 idVendor;
+	u16 idProduct;
+	char *name;
+};
+
+#endif /* __KERNEL__ */
+
+#endif /* __XBOXRCVR_h */
-- 
1.4.4.2


>From 4d0e6a5399b5c2bd4f4323f2717804ba8abb9b92 Mon Sep 17 00:00:00 2001
From: Brian Magnuson <magnuson@ferrari.(none)>
Date: Mon, 28 May 2007 23:15:35 -0400
Subject: [PATCH] add kconfig options for xboxrcvr


Signed-off-by: Brian Magnuson <bdmagnuson@gmail.com>
---
 drivers/input/joystick/Kconfig  |   13 +++++++++++++
 drivers/input/joystick/Makefile |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index b002345..6602b27 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -268,4 +268,17 @@ config JOYSTICK_XPAD
 	  To compile this driver as a module, choose M here: the
 	  module will be called xpad.
 
+config JOYSTICK_XBOXRCVR
+	tristate "X-Box wireless receiver support"
+	depends on USB_ARCH_HAS_HCD
+	select USB
+	help
+	  Say Y here if you want to use a MS wireless X-Box receiver with
+	  your computer.  Make sure to say Y to "Joystick support"
+	  (CONFIG_INPUT_JOYDEV) and/or "Event interface support"
+	  (CONFIG_INPUT_EVDEV) as well.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called xboxrcvr.
+
 endif
diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index e855abb..b079781 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -27,5 +27,6 @@ obj-$(CONFIG_JOYSTICK_TURBOGRAFX)	+= turbografx.o
 obj-$(CONFIG_JOYSTICK_TWIDJOY)		+= twidjoy.o
 obj-$(CONFIG_JOYSTICK_WARRIOR)		+= warrior.o
 obj-$(CONFIG_JOYSTICK_XPAD)		+= xpad.o
+obj-$(CONFIG_JOYSTICK_XBOXRCVR)	+= xboxrcvr.o
 
 obj-$(CONFIG_JOYSTICK_IFORCE)		+= iforce/
-- 
1.4.4.2
