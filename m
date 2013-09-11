From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH] add sur40 driver for Samsung SUR40 (aka MS Surface 2.0/Pixelsense)
Date: Wed, 11 Sep 2013 23:26:03 +0200
Message-ID: <1378934763-17938-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:35295 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432Ab3IKV0T (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Sep 2013 17:26:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: benjamin.tissoires@gmail.com, rydberg@euromail.se, dmitry.torokhov@gmail.com, dh.herrmann@gmail.com, Florian Echtler <floe@butterbrot.org>

From: "Florian Echtler" <floe@butterbrot.org>

This patch adds support for the built-in multitouch sensor in the Samsung
SUR40 touchscreen device, also known as Microsoft Surface 2.0 or Microsoft
Pixelsense. Support for raw video output from the sensor as well as the 
accelerometer will be added in a later patch.

Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/Kconfig  |   10 +
 drivers/input/touchscreen/Makefile |    1 +
 drivers/input/touchscreen/sur40.c  |  444 ++++++++++++++++++++++++++++++++++++
 3 files changed, 455 insertions(+)
 create mode 100644 drivers/input/touchscreen/sur40.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 515cfe7..99aaf10 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -876,6 +876,16 @@ config TOUCHSCREEN_STMPE
 	  To compile this driver as a module, choose M here: the
 	  module will be called stmpe-ts.
 
+config TOUCHSCREEN_SUR40
+	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
+	depends on USB
+	help
+	  Say Y here if you want support for the Samsung SUR40 touchscreen
+	  (also known as Microsoft Surface 2.0 or Microsoft PixelSense).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sur40.
+
 config TOUCHSCREEN_TPS6507X
 	tristate "TPS6507x based touchscreens"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 6bfbeab..b63a25d 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+= pixcir_i2c_ts.o
 obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
 obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
+obj-$(CONFIG_TOUCHSCREEN_SUR40)		+= sur40.o
 obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)	+= ti_am335x_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_TNETV107X)	+= tnetv107x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
new file mode 100644
index 0000000..45f6cf4
--- /dev/null
+++ b/drivers/input/touchscreen/sur40.c
@@ -0,0 +1,444 @@
+/*
+	Surface2.0/SUR40/PixelSense input driver v0.0.1
+
+	This program is free software; you can redistribute it and/or
+	modify it under the terms of the GNU General Public License as
+	published by the Free Software Foundation; either version 2 of
+	the License, or (at your option) any later version.
+
+	Copyright (c) 2013 by Florian 'floe' Echtler <floe@butterbrot.org>
+
+	Derived from the USB Skeleton driver 1.1,
+	Copyright (c) 2003 Greg Kroah-Hartman (greg@kroah.com)
+
+	and from the Apple USB BCM5974 multitouch driver,
+	Copyright (c) 2008 Henrik Rydberg (rydberg@euromail.se)
+
+	and from the generic hid-multitouch driver,
+	Copyright (c) 2010-2012 Stephane Chatty <chatty@enac.fr>
+*/
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/uaccess.h>
+#include <linux/usb.h>
+#include <linux/printk.h>
+#include <linux/input-polldev.h>
+#include <linux/input/mt.h>
+#include <linux/usb/input.h>
+
+/* read 512 bytes from endpoint 0x86 -> get header + blobs */
+struct sur40_header {
+
+	uint16_t type;       /* always 0x0001 */
+	uint16_t count;      /* count of blobs (if 0: continue prev. packet) */
+
+	uint32_t packet_id;
+
+	uint32_t timestamp;  /* milliseconds (inc. by 16 or 17 each frame) */
+	uint32_t unknown;    /* "epoch?" always 02/03 00 00 00 */
+};
+
+struct sur40_blob {
+
+	uint16_t blob_id;
+
+	uint8_t action;      /* 0x02 = enter/exit, 0x03 = update (?) */
+	uint8_t unknown;     /* always 0x01 or 0x02 (no idea what this is?) */
+
+	uint16_t bb_pos_x;   /* upper left corner of bounding box */
+	uint16_t bb_pos_y;
+
+	uint16_t bb_size_x;  /* size of bounding box */
+	uint16_t bb_size_y;
+
+	uint16_t pos_x;      /* finger tip position */
+	uint16_t pos_y;
+
+	uint16_t ctr_x;      /* centroid position */
+	uint16_t ctr_y;
+
+	uint16_t axis_x;     /* somehow related to major/minor axis, mostly: */
+	uint16_t axis_y;     /* axis_x == bb_size_y && axis_y == bb_size_x */
+
+	float angle;         /* orientation in radians relative to x axis */
+	uint32_t area;       /* size in pixels/pressure (?) */
+
+	uint8_t padding[32];
+};
+
+/* read 8 bytes using control message 0xc0,0xb1,0x00,0x00 */
+struct sur40_sensors {
+	uint16_t temp;
+	uint16_t acc_x;
+	uint16_t acc_y;
+	uint16_t acc_z;
+};
+
+/* version information */
+#define DRIVER_VERSION "0.0.1"
+#define DRIVER_SHORT   "sur40"
+#define DRIVER_AUTHOR  "Florian 'floe' Echtler <floe@butterbrot.org>"
+#define DRIVER_DESC    "Surface2.0/SUR40/PixelSense input driver"
+
+/* vendor and device IDs */
+#define ID_MICROSOFT 0x045e
+#define ID_SUR40     0x0775
+
+/* sensor resolution */
+#define SENSOR_RES_X 1920
+#define SENSOR_RES_Y 1080
+
+/* touch data endpoint */
+#define TOUCH_ENDPOINT 0x86
+
+/* polling interval (ms) */
+#define POLL_INTERVAL 10
+
+/* maximum number of contacts FIXME: this is a guess? */
+#define MAX_CONTACTS 64
+
+/* device ID table */
+static const struct usb_device_id sur40_table[] = {
+	{USB_DEVICE(ID_MICROSOFT, ID_SUR40)},  /* Samsung SUR40 */
+	{}                                     /* terminating null entry */
+};
+
+/* control commands */
+#define SUR40_GET_VERSION 0xb0 /* 12 bytes string    */
+#define SUR40_UNKNOWN1    0xb3 /*  5 bytes           */
+#define SUR40_UNKNOWN2    0xc1 /* 24 bytes           */
+
+#define SUR40_GET_STATE   0xc5 /*  4 bytes state (?) */
+#define SUR40_GET_SENSORS 0xb1 /*  8 bytes sensors   */
+
+/*
+ * Note: a earlier, non-public version of this driver used USB_RECIP_ENDPOINT
+ * here by mistake which is very likely to have corrupted the firmware EEPROM
+ * on two separate SUR40 devices. Thanks to Alan Stern who spotted this bug.
+ * Should you ever run into a similar problem, the background story to this
+ * incident and instructions on how to fix the corrupted EEPROM are available
+ * at https://floe.butterbrot.org/matrix/hacking/surface/brick.html
+*/
+#define sur40_command(dev, command, index, buffer, size) \
+	usb_control_msg(dev->usbdev, usb_rcvctrlpipe(dev->usbdev, 0), \
+	command, USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN, 0x00, \
+	index, buffer, size, 1000)
+
+MODULE_DEVICE_TABLE(usb, sur40_table);
+
+/* structure to hold all of our device specific stuff */
+struct sur40_state {
+
+	struct usb_device *usbdev;      /* save the usb device pointer */
+	struct input_polled_dev *input; /* struct for polled input device */
+
+	unsigned char *bulk_in_buffer;  /* the buffer to receive data */
+	size_t bulk_in_size;            /* the maximum bulk packet size */
+	__u8 bulk_in_epaddr;            /* address of the bulk in endpoint */
+
+	char phys[64];                  /* buffer for phys name */
+};
+
+/* debug helper macro */
+#define get_dev(x) (&(x->usbdev->dev))
+
+/* initialization routine, called from sur40_open */
+static int sur40_init(struct sur40_state *dev)
+{
+	int result;
+	__u8 buffer[24];
+
+	/* stupidly replay the original MS driver init sequence */
+	result = sur40_command(dev, SUR40_GET_VERSION, 0x00, buffer, 12);
+	if (result < 0)
+		return result;
+
+	result = sur40_command(dev, SUR40_GET_VERSION, 0x01, buffer, 12);
+	if (result < 0)
+		return result;
+
+	result = sur40_command(dev, SUR40_GET_VERSION, 0x02, buffer, 12);
+	if (result < 0)
+		return result;
+
+	result = sur40_command(dev, SUR40_UNKNOWN2,    0x00, buffer, 24);
+	if (result < 0)
+		return result;
+
+	result = sur40_command(dev, SUR40_UNKNOWN1,    0x00, buffer,  5);
+	if (result < 0)
+		return result;
+
+	result = sur40_command(dev, SUR40_GET_VERSION, 0x03, buffer, 12);
+
+	/* discard the result buffer - no known data inside except
+	   some version strings, maybe extract these sometime..    */
+
+	return result;
+}
+
+/*
+ * callback routines from input_polled_dev
+*/
+
+/* enable the device, polling will now start */
+void sur40_open(struct input_polled_dev *polldev)
+{
+	struct sur40_state *sur40 = polldev->private;
+	dev_dbg(get_dev(sur40), "open\n");
+	sur40_init(sur40);
+}
+
+/* disable device, polling has stopped */
+void sur40_close(struct input_polled_dev *polldev)
+{
+	/* no known way to stop the device, except to stop polling */
+	struct sur40_state *sur40 = polldev->private;
+	dev_dbg(get_dev(sur40), "close\n");
+}
+
+/*
+ * this function is called when a whole contact has been processed,
+ * so that it can assign it to a slot and store the data there
+ */
+static void report_blob(struct sur40_blob *blob, struct input_dev *input)
+{
+	int wide, major, minor;
+
+	int slotnum = input_mt_get_slot_by_key(input, blob->blob_id);
+	if (slotnum < 0 || slotnum >= MAX_CONTACTS)
+		return;
+
+	input_mt_slot(input, slotnum);
+	input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
+	wide = (blob->bb_size_x > blob->bb_size_y);
+	major = max(blob->bb_size_x, blob->bb_size_y);
+	minor = min(blob->bb_size_x, blob->bb_size_y);
+
+	input_event(input, EV_ABS, ABS_MT_POSITION_X, blob->pos_x);
+	input_event(input, EV_ABS, ABS_MT_POSITION_Y, blob->pos_y);
+	input_event(input, EV_ABS, ABS_MT_TOOL_X, blob->ctr_x);
+	input_event(input, EV_ABS, ABS_MT_TOOL_Y, blob->ctr_y);
+	input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
+	input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
+	input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
+}
+
+/* core function: poll for new input data */
+void sur40_poll(struct input_polled_dev *polldev)
+{
+
+	struct sur40_state *sur40 = polldev->private;
+	struct input_dev *input = polldev->input;
+	int result, bulk_read, need_blobs, packet_blobs, i;
+	uint32_t packet_id;
+
+	struct sur40_header *header =
+		(struct sur40_header *)(sur40->bulk_in_buffer);
+	struct sur40_blob *inblob =
+		(struct sur40_blob *)(sur40->bulk_in_buffer +
+		sizeof(struct sur40_header));
+
+	need_blobs = -1;
+
+	dev_dbg(get_dev(sur40), "poll\n");
+
+	do {
+
+		/* perform a blocking bulk read to get data from the device */
+		result = usb_bulk_msg(sur40->usbdev,
+			usb_rcvbulkpipe(sur40->usbdev, sur40->bulk_in_epaddr),
+			sur40->bulk_in_buffer, 512, &bulk_read, 1000);
+
+		dev_dbg(get_dev(sur40), "received %d bytes\n", bulk_read);
+
+		if (result < 0) {
+			dev_err(get_dev(sur40), "error in usb_bulk_read\n");
+			return;
+		}
+
+		result = bulk_read - sizeof(struct sur40_header);
+
+		if (result % sizeof(struct sur40_blob) != 0) {
+			dev_err(get_dev(sur40), "transfer size mismatch\n");
+			return;
+		}
+
+		/* first packet? */
+		if (need_blobs == -1) {
+			need_blobs = header->count;
+			dev_dbg(get_dev(sur40), "need %d blobs\n", need_blobs);
+			packet_id = header->packet_id;
+		}
+
+		/* sanity check. when video data is also being retrieved, the
+		 * packet ID will usually increase in the middle of a series
+		 * instead of at the end. */
+		if (packet_id != header->packet_id)
+			dev_warn(get_dev(sur40), "packet ID mismatch\n");
+
+		packet_blobs = result / sizeof(struct sur40_blob);
+		dev_dbg(get_dev(sur40), "received %d blobs\n", packet_blobs);
+
+		/* packets always contain at least 4 blobs, even if empty */
+		if (packet_blobs > need_blobs)
+			packet_blobs = need_blobs;
+
+		for (i = 0; i < packet_blobs; i++) {
+			need_blobs--;
+			dev_dbg(get_dev(sur40), "processing blob\n");
+			report_blob(&(inblob[i]), input);
+		}
+
+	} while (need_blobs > 0);
+
+	input_mt_sync_frame(input);
+	input_sync(input);
+}
+
+/*
+ * housekeeping routines
+*/
+
+/* initialize input device parameters */
+static void sur40_input_setup(struct input_dev *input_dev)
+{
+	set_bit(EV_KEY, input_dev->evbit);
+	set_bit(EV_SYN, input_dev->evbit);
+	set_bit(EV_ABS, input_dev->evbit);
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+		0, SENSOR_RES_X, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+		0, SENSOR_RES_Y, 0, 0);
+
+	input_set_abs_params(input_dev, ABS_MT_TOOL_X,
+		0, SENSOR_RES_X, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOOL_Y,
+		0, SENSOR_RES_Y, 0, 0);
+
+	/* max value unknown, but major/minor axis
+	 * can never be larger than screen */
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
+		0, SENSOR_RES_X, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR,
+		0, SENSOR_RES_Y, 0, 0);
+
+	input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
+
+	input_mt_init_slots(input_dev, MAX_CONTACTS,
+		INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+}
+
+/* clean up all allocated buffers/structs */
+static inline void sur40_delete(struct sur40_state *sur40)
+{
+	input_free_polled_device(sur40->input);
+	kfree(sur40->bulk_in_buffer);
+	kfree(sur40);
+}
+
+/* check candidate USB interface */
+static int sur40_probe(struct usb_interface *interface,
+	const struct usb_device_id *id)
+{
+	struct usb_device *usbdev = interface_to_usbdev(interface);
+	struct sur40_state *sur40;
+	struct usb_host_interface *iface_desc;
+	struct usb_endpoint_descriptor *endpoint;
+	struct input_polled_dev *poll_dev;
+	int result;
+
+	/* check if we really have the right interface */
+	iface_desc = &interface->altsetting[0];
+	if (iface_desc->desc.bInterfaceClass != 0xFF)
+		return -ENODEV;
+
+	/* use endpoint #4 (0x86) */
+	endpoint = &iface_desc->endpoint[4].desc;
+	if (endpoint->bEndpointAddress != TOUCH_ENDPOINT)
+		return -ENODEV;
+
+	/* allocate memory for our device state and initialize it */
+	sur40 = kzalloc(sizeof(struct sur40_state), GFP_KERNEL);
+	poll_dev = input_allocate_polled_device();
+	if (!sur40 || !poll_dev)
+		return -ENOMEM;
+
+	/* setup polled input device control struct */
+	poll_dev->private = sur40;
+	poll_dev->poll_interval = POLL_INTERVAL;
+	poll_dev->open = sur40_open;
+	poll_dev->poll = sur40_poll;
+	poll_dev->close = sur40_close;
+
+	/* setup regular input device struct */
+	sur40_input_setup(poll_dev->input);
+
+	poll_dev->input->name = "Samsung SUR40";
+	usb_to_input_id(usbdev, &(poll_dev->input->id));
+	usb_make_path(usbdev, sur40->phys, sizeof(sur40->phys));
+	strlcat(sur40->phys, "/input0", sizeof(sur40->phys));
+	poll_dev->input->phys = sur40->phys;
+
+	sur40->usbdev = usbdev;
+	sur40->input = poll_dev;
+
+	/* use the bulk-in endpoint tested above */
+	sur40->bulk_in_size = le16_to_cpu(endpoint->wMaxPacketSize);
+	sur40->bulk_in_epaddr = endpoint->bEndpointAddress;
+	sur40->bulk_in_buffer = kmalloc(2 * sur40->bulk_in_size, GFP_KERNEL);
+	if (!sur40->bulk_in_buffer) {
+		dev_err(&interface->dev, "Unable to allocate input buffer.");
+		sur40_delete(sur40);
+		return -ENOMEM;
+	}
+
+	result = input_register_polled_device(poll_dev);
+	if (result) {
+		dev_err(&interface->dev,
+			"Unable to register polled input device.");
+		sur40_delete(sur40);
+		return result;
+	}
+
+	/* we can register the device now, as it is ready */
+	usb_set_intfdata(interface, sur40);
+	dev_info(&interface->dev, "%s now attached\n", DRIVER_DESC);
+
+	return 0;
+}
+
+/* unregister device & clean up */
+static void sur40_disconnect(struct usb_interface *interface)
+{
+	struct sur40_state *sur40 = usb_get_intfdata(interface);
+
+	input_unregister_polled_device(sur40->input);
+
+	usb_set_intfdata(interface, NULL);
+
+	sur40_delete(sur40);
+
+	dev_info(&interface->dev, "%s now disconnected\n", DRIVER_DESC);
+}
+
+/* usb specific object needed to register this driver with the usb subsystem */
+static struct usb_driver sur40_driver = {
+	.name = DRIVER_SHORT,
+	.probe = sur40_probe,
+	.disconnect = sur40_disconnect,
+	.id_table = sur40_table,
+};
+
+module_usb_driver(sur40_driver);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

