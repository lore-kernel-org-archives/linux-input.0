From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCHes] Apple IR receiver driver
Date: Mon, 18 Jan 2010 14:14:25 +0000
Message-ID: <1263824065.20565.2730.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qmiaWmJA00Z+OJR7EbY9"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49070 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab0AROOc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 09:14:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg@redhat.com>, Tino Keitel <tino.keitel@gmx.de>


--=-qmiaWmJA00Z+OJR7EbY9
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

This is an update of the patches sent by Greg [1].

I believe I fixed one of the problems mentioned by Tino (the suspend
support, though my testing was blighted by the fact that resuming
*without* the driver doesn't work so well with the latest input tree, it
works fine with the stock Fedora kernels).

The other problem mentioned by Tino was the fact that some people would
want to use LIRC to use different remotes and have access to more keys.
This can be achieved by using usbhid.quirks. I could certainly document
that for both lirc and in the kernel.

A couple of things:
- Not certain about the suspend code
- Should the Apple TV receiver be handled in the same way? (the LIRC
driver works on all 3 revisions of the IR receiver)
- Where should I document the work-around to use lirc in both LIRC and
the kernel?

The main features of using a kernel driver are:
- Out-of-the-box support, just like in MacOS X, with the "recommended"
remote controller. This is similar to how the ATI remotes are handled.
- On my hacking TODO list are the ability to report flat batteries
through kobject_uevent to user space, and binding support (so as to
filter out all the remotes apart from the "paired" one)

Let me know of any problems

Cheers

[1]: http://thread.gmane.org/gmane.linux.kernel/680590/

--=-qmiaWmJA00Z+OJR7EbY9
Content-Disposition: attachment; filename="0001-PATCH-Input-add-appleir-USB-driver.patch"
Content-Type: text/x-patch; name="0001-PATCH-Input-add-appleir-USB-driver.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From eadd1424ef1657b4666a4e3e3f0862024dec591a Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 17 Jan 2010 00:40:15 +0000
Subject: [PATCH 1/2] [PATCH] Input: add appleir USB driver

From: Bastien Nocera <hadess@hadess.net>

This driver was originally written by James McKenzie, updated by
Greg Kroah-Hartman, further updated by myself.

More recent versions of the IR receiver are also supported through
a patch by Alex Karpenko.

Tested on a MacbookAir1,1

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-apple.c      |    2 -
 drivers/hid/hid-core.c       |    2 +
 drivers/hid/hid-ids.h        |    1 +
 drivers/input/misc/Kconfig   |   12 ++
 drivers/input/misc/Makefile  |    1 +
 drivers/input/misc/appleir.c |  378 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 394 insertions(+), 2 deletions(-)
 create mode 100644 drivers/input/misc/appleir.c

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 4b96e7a..12fe9c6 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -355,8 +355,6 @@ static void apple_remove(struct hid_device *hdev)
 static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ATV_IRCONTROL),
 		.driver_data = APPLE_HIDDEV | APPLE_IGNORE_HIDINPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4),
-		.driver_data = APPLE_HIDDEV | APPLE_IGNORE_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE),
 		.driver_data = APPLE_MIGHTYMOUSE | APPLE_INVERT_HWHEEL },
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 80792d3..3773f69 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1540,6 +1540,8 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_24) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AIRCABLE, USB_DEVICE_ID_AIRCABLE1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ALCOR, USB_DEVICE_ID_ALCOR_USBRS232) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM)},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM2)},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, USB_DEVICE_ID_AVER_FM_MR800) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3839340..8b29a88 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -90,6 +90,7 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING3_JIS	0x0238
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
 #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
+#define USB_DEVICE_ID_APPLE_IRCONTROL	0x8240
 #define USB_DEVICE_ID_APPLE_ATV_IRCONTROL	0x8241
 #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
 
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 16ec523..b46e3f1 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -149,6 +149,18 @@ config INPUT_KEYSPAN_REMOTE
 	  To compile this driver as a module, choose M here: the module will
 	  be called keyspan_remote.
 
+config INPUT_APPLEIR
+	tristate "Apple infrared receiver (built in)"
+	depends on USB_ARCH_HAS_HCD
+	select USB
+	help
+	  Say Y here if you want to use a Apple infrared remote control. All
+	  the Apple computers from 2005 onwards include such a port, except
+	  the unibody Macbook (2009), and Mac Pros.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called appleir.
+
 config INPUT_POWERMATE
 	tristate "Griffin PowerMate and Contour Jog support"
 	depends on USB_ARCH_HAS_HCD
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index a8b8485..041e6f5 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -5,6 +5,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
+obj-$(CONFIG_INPUT_APPLEIR)		+= appleir.o
 obj-$(CONFIG_INPUT_ATI_REMOTE)		+= ati_remote.o
 obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
diff --git a/drivers/input/misc/appleir.c b/drivers/input/misc/appleir.c
new file mode 100644
index 0000000..54a9647
--- /dev/null
+++ b/drivers/input/misc/appleir.c
@@ -0,0 +1,378 @@
+/*
+ * appleir: USB driver for the apple ir device
+ *
+ * Original driver written by James McKenzie
+ * Ported to recent 2.6 kernel versions by Greg Kroah-Hartman <gregkh@suse.de>
+ *
+ * Copyright (C) 2006 James McKenzie
+ * Copyright (C) 2008 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2008 Novell Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation, version 2.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/usb.h>
+#include <linux/usb/input.h>
+#include <asm/unaligned.h>
+#include <asm/byteorder.h>
+
+#define DRIVER_VERSION "v1.2"
+#define DRIVER_AUTHOR "James McKenzie"
+#define DRIVER_DESC "Apple infrared receiver driver"
+#define DRIVER_LICENSE "GPL"
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE(DRIVER_LICENSE);
+
+#define USB_VENDOR_ID_APPLE	0x05ac
+#define USB_DEVICE_ID_APPLE_IRCONTROL	0x8240
+#define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
+
+#define URB_SIZE	32
+
+#define MAX_KEYS	8
+#define MAX_KEYS_MASK	(MAX_KEYS - 1)
+
+#define dbginfo(dev, format, arg...) do { if (debug) dev_info(dev , format , ## arg); } while (0)
+
+static int debug;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Enable extra debug messages and information");
+
+struct appleir {
+	struct input_dev *input_dev;
+	u8 *data;
+	dma_addr_t dma_buf;
+	struct usb_device *usbdev;
+	struct urb *urb;
+	int timer_initted;
+	struct timer_list key_up_timer;
+	int current_key;
+	char phys[32];
+};
+
+static struct usb_device_id appleir_ids[] = {
+	{USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL)},
+	{USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4)},
+	{}
+};
+MODULE_DEVICE_TABLE(usb, appleir_ids);
+
+/* I have two devices both of which report the following */
+/* 25 87 ee 83 0a  	+  */
+/* 25 87 ee 83 0c  	-  */
+/* 25 87 ee 83 09	<< */
+/* 25 87 ee 83 06	>> */
+/* 25 87 ee 83 05	>" */
+/* 25 87 ee 83 03	menu */
+/* 26 00 00 00 00	for key repeat*/
+
+/* Thomas Glanzmann reports the following responses */
+/* 25 87 ee ca 0b	+  */
+/* 25 87 ee ca 0d	-  */
+/* 25 87 ee ca 08	<< */
+/* 25 87 ee ca 07	>> */
+/* 25 87 ee ca 04	>" */
+/* 25 87 ee ca 02 	menu */
+/* 26 00 00 00 00       for key repeat*/
+/* He also observes the following event sometimes */
+/* sent after a key is release, which I interpret */
+/* as a flat battery message */
+/* 25 87 e0 ca 06	flat battery */
+
+/* Alexandre Karpenko reports the following responses for Device ID 0x8242 */
+/* 25 87 ee 47 0b	+  */
+/* 25 87 ee 47 0d	-  */
+/* 25 87 ee 47 08	<< */
+/* 25 87 ee 47 07	>> */
+/* 25 87 ee 47 04	>" */
+/* 25 87 ee 47 02 	menu */
+/* 26 87 ee 47 ** 	for key repeat (** is the code of the key being held) */
+
+static int keymap[MAX_KEYS] = {
+	KEY_RESERVED,
+	KEY_MENU,
+	KEY_PLAYPAUSE,
+	KEY_FORWARD,
+	KEY_BACK,
+	KEY_VOLUMEUP,
+	KEY_VOLUMEDOWN,
+	KEY_RESERVED,
+};
+
+static void dump_packet(struct appleir *appleir, char *msg, u8 *data, int len)
+{
+	int i;
+
+	printk(KERN_ERR "appleir: %s (%d bytes)", msg, len);
+
+	for (i = 0; i < len; ++i)
+		printk(" %02x", data[i]);
+	printk("\n");
+}
+
+static void key_up(struct appleir *appleir, int key)
+{
+	dbginfo (&appleir->input_dev->dev, "key %d up\n", key);
+	input_report_key(appleir->input_dev, key, 0);
+	input_sync(appleir->input_dev);
+}
+
+static void key_down(struct appleir *appleir, int key)
+{
+	dbginfo (&appleir->input_dev->dev, "key %d down\n", key);
+	input_report_key(appleir->input_dev, key, 1);
+	input_sync(appleir->input_dev);
+}
+
+static void battery_flat(struct appleir *appleir)
+{
+	dev_err(&appleir->input_dev->dev, "possible flat battery?\n");
+}
+
+static void key_up_tick(unsigned long data)
+{
+	struct appleir *appleir = (struct appleir *)data;
+
+	if (appleir->current_key) {
+		key_up(appleir, appleir->current_key);
+		appleir->current_key = 0;
+	}
+}
+
+static void new_data(struct appleir *appleir, u8 *data, int len)
+{
+	static const u8 keydown[] = { 0x25, 0x87, 0xee };
+	static const u8 keyrepeat[] = { 0x26, };
+	static const u8 flatbattery[] = { 0x25, 0x87, 0xe0 };
+
+	if (debug)
+		dump_packet(appleir, "received", data, len);
+
+	if (len != 5)
+		return;
+
+	if (!memcmp(data, keydown, sizeof(keydown))) {
+		/*If we already have a key down, take it up before marking */
+		/*this one down */
+		if (appleir->current_key)
+			key_up(appleir, appleir->current_key);
+		appleir->current_key = keymap[(data[4] >> 1) & MAX_KEYS_MASK];
+
+		key_down(appleir, appleir->current_key);
+		/*remote doesn't do key up, either pull them up, in the test */
+		/*above, or here set a timer which pulls them up after 1/8 s */
+		mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
+
+		return;
+	}
+
+	if (!memcmp(data, keyrepeat, sizeof(keyrepeat))) {
+		key_down(appleir, appleir->current_key);
+		/*remote doesn't do key up, either pull them up, in the test */
+		/*above, or here set a timer which pulls them up after 1/8 s */
+		mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
+		return;
+	}
+
+	if (!memcmp(data, flatbattery, sizeof(flatbattery))) {
+		battery_flat(appleir);
+		/* Fall through */
+	}
+
+	dump_packet(appleir, "unknown packet", data, len);
+}
+
+static void appleir_urb(struct urb *urb)
+{
+	struct appleir *appleir = urb->context;
+	int status = urb->status;
+	int retval;
+
+	switch (status) {
+	case 0:
+		new_data(appleir, urb->transfer_buffer, urb->actual_length);
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbginfo(&appleir->input_dev->dev, "%s - urb shutting down with status: %d", __func__,
+		    urb->status);
+		return;
+	default:
+		dbginfo(&appleir->input_dev->dev, "%s - nonzero urb status received: %d", __func__,
+		    urb->status);
+	}
+
+	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	if (retval)
+		err("%s - usb_submit_urb failed with result %d", __func__,
+		    retval);
+}
+
+static int appleir_open(struct input_dev *dev)
+{
+	struct appleir *appleir = input_get_drvdata(dev);
+
+	if (usb_submit_urb(appleir->urb, GFP_KERNEL))
+		return -EIO;
+
+	return 0;
+}
+
+static void appleir_close(struct input_dev *dev)
+{
+	struct appleir *appleir = input_get_drvdata(dev);
+
+	usb_kill_urb(appleir->urb);
+	del_timer_sync(&appleir->key_up_timer);
+}
+
+static int appleir_probe(struct usb_interface *intf,
+			 const struct usb_device_id *id)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *endpoint;
+	struct appleir *appleir = NULL;
+	struct input_dev *input_dev;
+	int retval = -ENOMEM;
+	int i;
+
+	appleir = kzalloc(sizeof(struct appleir), GFP_KERNEL);
+	if (!appleir)
+		goto fail;
+
+	appleir->data = usb_buffer_alloc(dev, URB_SIZE, GFP_KERNEL,
+					 &appleir->dma_buf);
+	if (!appleir->data)
+		goto fail;
+
+	appleir->urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!appleir->urb)
+		goto fail;
+
+	appleir->usbdev = dev;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+		goto fail;
+
+	appleir->input_dev = input_dev;
+
+	usb_make_path(dev, appleir->phys, sizeof(appleir->phys));
+	strlcpy(appleir->phys, "/input0", sizeof(appleir->phys));
+
+	input_dev->name = "Apple infrared remote control driver";
+	input_dev->phys = appleir->phys;
+	usb_to_input_id(dev, &input_dev->id);
+	input_dev->dev.parent = &intf->dev;
+	input_set_drvdata(input_dev, appleir);
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	input_dev->ledbit[0] = 0;
+
+	for (i = 0; i < MAX_KEYS; i++)
+		set_bit(keymap[i], input_dev->keybit);
+
+	clear_bit(0, input_dev->keybit);
+
+	input_dev->open = appleir_open;
+	input_dev->close = appleir_close;
+
+	endpoint = &intf->cur_altsetting->endpoint[0].desc;
+
+	usb_fill_int_urb(appleir->urb, dev,
+			 usb_rcvintpipe(dev, endpoint->bEndpointAddress),
+			 appleir->data, 8,
+			 appleir_urb, appleir, endpoint->bInterval);
+
+	appleir->urb->transfer_dma = appleir->dma_buf;
+	appleir->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	usb_set_intfdata(intf, appleir);
+
+	init_timer(&appleir->key_up_timer);
+
+	appleir->key_up_timer.function = key_up_tick;
+	appleir->key_up_timer.data = (unsigned long)appleir;
+
+	appleir->timer_initted++;
+
+	retval = input_register_device(appleir->input_dev);
+	if (retval)
+		goto fail;
+
+	return 0;
+
+fail:
+	printk(KERN_WARNING "Failed to load appleir\n");
+	if (appleir) {
+		if (appleir->data)
+			usb_buffer_free(dev, URB_SIZE, appleir->data,
+					appleir->dma_buf);
+
+		if (appleir->timer_initted)
+			del_timer_sync(&appleir->key_up_timer);
+
+		if (appleir->input_dev)
+			input_free_device(appleir->input_dev);
+
+		kfree(appleir);
+	}
+
+	return retval;
+}
+
+static void appleir_disconnect(struct usb_interface *intf)
+{
+	struct appleir *appleir = usb_get_intfdata(intf);
+
+	usb_set_intfdata(intf, NULL);
+	if (appleir) {
+		input_unregister_device(appleir->input_dev);
+		if (appleir->timer_initted)
+			del_timer_sync(&appleir->key_up_timer);
+		usb_kill_urb(appleir->urb);
+		usb_free_urb(appleir->urb);
+		usb_buffer_free(interface_to_usbdev(intf), URB_SIZE,
+				appleir->data, appleir->dma_buf);
+		kfree(appleir);
+	}
+}
+
+static struct usb_driver appleir_driver = {
+	.name = "appleir",
+	.probe = appleir_probe,
+	.disconnect = appleir_disconnect,
+	.id_table = appleir_ids,
+};
+
+static int __init appleir_init(void)
+{
+	int retval;
+
+	retval = usb_register(&appleir_driver);
+	if (retval)
+		goto out;
+	printk(KERN_INFO DRIVER_VERSION ":" DRIVER_DESC);
+out:
+	return retval;
+}
+
+static void __exit appleir_exit(void)
+{
+	usb_deregister(&appleir_driver);
+}
+
+module_init(appleir_init);
+module_exit(appleir_exit);
-- 
1.6.5.2


--=-qmiaWmJA00Z+OJR7EbY9
Content-Disposition: attachment; filename="0002-appleir-Add-suspend-support.patch"
Content-Type: text/x-patch; name="0002-appleir-Add-suspend-support.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 39309f376a988b7a5c37e9ef82e9cd6c87af2e97 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Mon, 18 Jan 2010 13:57:03 +0000
Subject: [PATCH 2/2] [appleir] Add suspend support

Close the connection to the device and kill the timer when suspending,
and undo those changes on resume.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/input/misc/appleir.c |  120 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/appleir.c b/drivers/input/misc/appleir.c
index 54a9647..f03db3e 100644
--- a/drivers/input/misc/appleir.c
+++ b/drivers/input/misc/appleir.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/input.h>
+#include <linux/usb/input.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/usb.h>
@@ -53,6 +54,7 @@ struct appleir {
 	u8 *data;
 	dma_addr_t dma_buf;
 	struct usb_device *usbdev;
+	unsigned int flags;
 	struct urb *urb;
 	int timer_initted;
 	struct timer_list key_up_timer;
@@ -60,6 +62,13 @@ struct appleir {
 	char phys[32];
 };
 
+static DEFINE_MUTEX(appleir_mutex);
+
+enum {
+	APPLEIR_OPENED = 0x1,
+	APPLEIR_SUSPENDED = 0x2,
+};
+
 static struct usb_device_id appleir_ids[] = {
 	{USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL)},
 	{USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4)},
@@ -223,19 +232,50 @@ static void appleir_urb(struct urb *urb)
 static int appleir_open(struct input_dev *dev)
 {
 	struct appleir *appleir = input_get_drvdata(dev);
+	struct usb_interface *intf = usb_ifnum_to_if(appleir->usbdev, 0);
+	int r;
+
+	r = usb_autopm_get_interface(intf);
+	if (r) {
+		dev_err(&intf->dev,
+			"%s(): usb_autopm_get_interface() = %d\n", __func__, r);
+		return r;
+	}
+
+	mutex_lock(&appleir_mutex);
 
-	if (usb_submit_urb(appleir->urb, GFP_KERNEL))
-		return -EIO;
+	if (usb_submit_urb(appleir->urb, GFP_KERNEL)) {
+		r = -EIO;
+		goto fail;
+	}
+
+	appleir->flags |= APPLEIR_OPENED;
+
+	mutex_unlock(&appleir_mutex);
+
+	usb_autopm_put_interface(intf);
 
 	return 0;
+fail:
+	mutex_unlock(&appleir_mutex);
+	usb_autopm_put_interface(intf);
+	return r;
 }
 
 static void appleir_close(struct input_dev *dev)
 {
 	struct appleir *appleir = input_get_drvdata(dev);
 
-	usb_kill_urb(appleir->urb);
-	del_timer_sync(&appleir->key_up_timer);
+	mutex_lock(&appleir_mutex);
+
+	if (!(appleir->flags & APPLEIR_SUSPENDED)) {
+		usb_kill_urb(appleir->urb);
+		del_timer_sync(&appleir->key_up_timer);
+	}
+
+	appleir->flags &= ~APPLEIR_OPENED;
+
+	mutex_unlock(&appleir_mutex);
 }
 
 static int appleir_probe(struct usb_interface *intf,
@@ -350,11 +390,75 @@ static void appleir_disconnect(struct usb_interface *intf)
 	}
 }
 
+static int appleir_suspend(struct usb_interface *interface,
+			   pm_message_t message)
+{
+	struct appleir *appleir;
+/*	struct usb_host_interface *alt = interface->cur_altsetting;
+
+	if (alt->desc.bInterfaceNumber)
+		return 0; */
+
+	appleir = usb_get_intfdata(interface);
+
+	mutex_lock(&appleir_mutex);
+
+	if (appleir->flags & APPLEIR_OPENED) {
+		usb_kill_urb(appleir->urb);
+		del_timer_sync(&appleir->key_up_timer);
+	}
+
+	appleir->flags |= APPLEIR_SUSPENDED;
+
+	mutex_unlock(&appleir_mutex);
+
+	return 0;
+}
+
+static int appleir_resume(struct usb_interface *interface)
+{
+	struct appleir *appleir;
+	/* struct usb_host_interface *alt = interface->cur_altsetting;
+
+	if (alt->desc.bInterfaceNumber)
+		return 0; */
+
+	appleir = usb_get_intfdata(interface);
+
+	mutex_lock(&appleir_mutex);
+
+	if (appleir->flags & APPLEIR_OPENED) {
+		struct usb_endpoint_descriptor *endpoint;
+
+		endpoint = &interface->cur_altsetting->endpoint[0].desc;
+		usb_fill_int_urb(appleir->urb, appleir->usbdev,
+				 usb_rcvintpipe(appleir->usbdev, endpoint->bEndpointAddress),
+				 appleir->data, 8,
+				 appleir_urb, appleir, endpoint->bInterval);
+		appleir->urb->transfer_dma = appleir->dma_buf;
+		appleir->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+		init_timer(&appleir->key_up_timer);
+
+		appleir->key_up_timer.function = key_up_tick;
+		appleir->key_up_timer.data = (unsigned long)appleir;
+	}
+
+	appleir->flags &= ~APPLEIR_SUSPENDED;
+
+	mutex_unlock(&appleir_mutex);
+
+	return 0;
+}
+
 static struct usb_driver appleir_driver = {
-	.name = "appleir",
-	.probe = appleir_probe,
-	.disconnect = appleir_disconnect,
-	.id_table = appleir_ids,
+	.name         = "appleir",
+	.probe        = appleir_probe,
+	.disconnect   = appleir_disconnect,
+	.suspend      = appleir_suspend,
+	.resume       = appleir_resume,
+	.reset_resume = appleir_resume,
+	.id_table     = appleir_ids,
 };
 
 static int __init appleir_init(void)
-- 
1.6.5.2


--=-qmiaWmJA00Z+OJR7EbY9--

