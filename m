From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Sun, 10 Nov 2013 23:31:05 -0800
Message-ID: <20131111073105.GA7645@core.coreip.homeip.net>
References: <1383748012-28880-1-git-send-email-floe@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:43810 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab3KKHbJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Nov 2013 02:31:09 -0500
Received: by mail-pb0-f41.google.com with SMTP id wy17so4881554pbc.14
        for <linux-input@vger.kernel.org>; Sun, 10 Nov 2013 23:31:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1383748012-28880-1-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, rydberg@euromail.se, dh.herrmann@gmail.com

Hi Florian,

On Wed, Nov 06, 2013 at 03:26:51PM +0100, Florian Echtler wrote:
> +
> +	/* max value unknown, but major/minor axis
> +	 * can never be larger than screen */
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
> +		0, SENSOR_RES_X, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR,
> +		0, SENSOR_RES_Y, 0, 0);

If the range is unknown do we really want to specify min/max?

Also, does the patch below mess up or device or it still works?

Thanks.

-- 
Dmitry

Input: sur40 - misc changes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sur40.c |  227 ++++++++++++++++++-------------------
 1 file changed, 113 insertions(+), 114 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 48787fd..cfd1b7e 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -1,22 +1,22 @@
 /*
-	Surface2.0/SUR40/PixelSense input driver
-
-	This program is free software; you can redistribute it and/or
-	modify it under the terms of the GNU General Public License as
-	published by the Free Software Foundation; either version 2 of
-	the License, or (at your option) any later version.
-
-	Copyright (c) 2013 by Florian 'floe' Echtler <floe@butterbrot.org>
-
-	Derived from the USB Skeleton driver 1.1,
-	Copyright (c) 2003 Greg Kroah-Hartman (greg@kroah.com)
-
-	and from the Apple USB BCM5974 multitouch driver,
-	Copyright (c) 2008 Henrik Rydberg (rydberg@euromail.se)
-
-	and from the generic hid-multitouch driver,
-	Copyright (c) 2010-2012 Stephane Chatty <chatty@enac.fr>
-*/
+ * Surface2.0/SUR40/PixelSense input driver
+ *
+ * Copyright (c) 2013 by Florian 'floe' Echtler <floe@butterbrot.org>
+ *
+ * Derived from the USB Skeleton driver 1.1,
+ * Copyright (c) 2003 Greg Kroah-Hartman (greg@kroah.com)
+ *
+ * and from the Apple USB BCM5974 multitouch driver,
+ * Copyright (c) 2008 Henrik Rydberg (rydberg@euromail.se)
+ *
+ * and from the generic hid-multitouch driver,
+ * Copyright (c) 2010-2012 Stephane Chatty <chatty@enac.fr>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -49,8 +49,8 @@ struct sur40_blob {
 
 	__le16 blob_id;
 
-	__u8 action;       /* 0x02 = enter/exit, 0x03 = update (?) */
-	__u8 unknown;      /* always 0x01 or 0x02 (no idea what this is?) */
+	u8 action;         /* 0x02 = enter/exit, 0x03 = update (?) */
+	u8 unknown;        /* always 0x01 or 0x02 (no idea what this is?) */
 
 	__le16 bb_pos_x;   /* upper left corner of bounding box */
 	__le16 bb_pos_y;
@@ -72,7 +72,7 @@ struct sur40_blob {
 
 	__le32 area;       /* size in pixels/pressure (?) */
 
-	__u8 padding[32];
+	u8 padding[32];
 
 } __packed;
 
@@ -105,12 +105,6 @@ struct sur40_data {
 /* maximum number of contacts FIXME: this is a guess? */
 #define MAX_CONTACTS 64
 
-/* device ID table */
-static const struct usb_device_id sur40_table[] = {
-	{USB_DEVICE(ID_MICROSOFT, ID_SUR40)},  /* Samsung SUR40 */
-	{}                                     /* terminating null entry */
-};
-
 /* control commands */
 #define SUR40_GET_VERSION 0xb0 /* 12 bytes string    */
 #define SUR40_UNKNOWN1    0xb3 /*  5 bytes           */
@@ -127,32 +121,34 @@ static const struct usb_device_id sur40_table[] = {
  * incident and instructions on how to fix the corrupted EEPROM are available
  * at https://floe.butterbrot.org/matrix/hacking/surface/brick.html
 */
-#define sur40_command(dev, command, index, buffer, size) \
-	usb_control_msg(dev->usbdev, usb_rcvctrlpipe(dev->usbdev, 0), \
-	command, USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN, 0x00, \
-	index, buffer, size, 1000)
-
-MODULE_DEVICE_TABLE(usb, sur40_table);
 
-/* structure to hold all of our device specific stuff */
 struct sur40_state {
 
-	struct usb_device *usbdev;      /* save the usb device pointer */
-	struct device *dev;             /* save the generic device pointer */
-	struct input_polled_dev *input; /* struct for polled input device */
+	struct usb_device *usbdev;
+	struct device *dev;
+	struct input_polled_dev *input;
 
-	struct sur40_data *bulk_in_buffer; /* the buffer to receive data */
-	size_t bulk_in_size;            /* the maximum bulk packet size */
-	__u8 bulk_in_epaddr;            /* address of the bulk in endpoint */
+	struct sur40_data *bulk_in_buffer;
+	size_t bulk_in_size;
+	u8 bulk_in_epaddr;
 
-	char phys[64];                  /* buffer for phys name */
+	char phys[64];
 };
 
-/* initialization routine, called from sur40_open */
+static int sur40_command(struct sur40_state *dev,
+			 u8 command, u16 index, void *buffer, u16 size)
+{
+	return usb_control_msg(dev->usbdev, usb_rcvctrlpipe(dev->usbdev, 0),
+			       command,
+			       USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+			       0x00, index, buffer, size, 1000);
+}
+
+/* Initialization routine, called from sur40_open */
 static int sur40_init(struct sur40_state *dev)
 {
 	int result;
-	__u8 buffer[24];
+	u8 buffer[24];
 
 	/* stupidly replay the original MS driver init sequence */
 	result = sur40_command(dev, SUR40_GET_VERSION, 0x00, buffer, 12);
@@ -177,37 +173,44 @@ static int sur40_init(struct sur40_state *dev)
 
 	result = sur40_command(dev, SUR40_GET_VERSION, 0x03, buffer, 12);
 
-	/* discard the result buffer - no known data inside except
-	   some version strings, maybe extract these sometime..    */
+	/*
+	 * Discard the result buffer - no known data inside except
+	 * some version strings, maybe extract these sometime...
+	 */
 
 	return result;
 }
 
 /*
- * callback routines from input_polled_dev
-*/
+ * Callback routines from input_polled_dev
+ */
 
-/* enable the device, polling will now start */
-void sur40_open(struct input_polled_dev *polldev)
+/* Enable the device, polling will now start. */
+static void sur40_open(struct input_polled_dev *polldev)
 {
 	struct sur40_state *sur40 = polldev->private;
+
 	dev_dbg(sur40->dev, "open\n");
 	sur40_init(sur40);
 }
 
-/* disable device, polling has stopped */
-void sur40_close(struct input_polled_dev *polldev)
+/* Disable device, polling has stopped. */
+static void sur40_close(struct input_polled_dev *polldev)
 {
-	/* no known way to stop the device, except to stop polling */
 	struct sur40_state *sur40 = polldev->private;
+
 	dev_dbg(sur40->dev, "close\n");
+	/*
+	 * There is no known way to stop the device, so we simply
+	 * stop polling.
+	 */
 }
 
 /*
- * this function is called when a whole contact has been processed,
- * so that it can assign it to a slot and store the data there
+ * This function is called when a whole contact has been processed,
+ * so that it can assign it to a slot and store the data there.
  */
-static void report_blob(struct sur40_blob *blob, struct input_dev *input)
+static void sur40_report_blob(struct sur40_blob *blob, struct input_dev *input)
 {
 	int wide, major, minor;
 
@@ -230,33 +233,33 @@ static void report_blob(struct sur40_blob *blob, struct input_dev *input)
 	major = max(bb_size_x, bb_size_y);
 	minor = min(bb_size_x, bb_size_y);
 
-	input_event(input, EV_ABS, ABS_MT_POSITION_X, pos_x);
-	input_event(input, EV_ABS, ABS_MT_POSITION_Y, pos_y);
-	input_event(input, EV_ABS, ABS_MT_TOOL_X, ctr_x);
-	input_event(input, EV_ABS, ABS_MT_TOOL_Y, ctr_y);
+	input_report_abs(input, ABS_MT_POSITION_X, pos_x);
+	input_report_abs(input, ABS_MT_POSITION_Y, pos_y);
+	input_report_abs(input, ABS_MT_TOOL_X, ctr_x);
+	input_report_abs(input, ABS_MT_TOOL_Y, ctr_y);
 
 	/* TODO: use a better orientation measure */
-	input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
-	input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
-	input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
+	input_report_abs(input, ABS_MT_ORIENTATION, wide);
+	input_report_abs(input, ABS_MT_TOUCH_MAJOR, major);
+	input_report_abs(input, ABS_MT_TOUCH_MINOR, minor);
 }
 
 /* core function: poll for new input data */
-void sur40_poll(struct input_polled_dev *polldev)
+static void sur40_poll(struct input_polled_dev *polldev)
 {
 
 	struct sur40_state *sur40 = polldev->private;
 	struct input_dev *input = polldev->input;
 	int result, bulk_read, need_blobs, packet_blobs, i;
-	uint32_t packet_id;
+	u32 packet_id;
 
 	struct sur40_header *header = &sur40->bulk_in_buffer->header;
 	struct sur40_blob *inblob = &sur40->bulk_in_buffer->blobs[0];
 
-	need_blobs = -1;
-
 	dev_dbg(sur40->dev, "poll\n");
 
+	need_blobs = -1;
+
 	do {
 
 		/* perform a blocking bulk read to get data from the device */
@@ -286,9 +289,11 @@ void sur40_poll(struct input_polled_dev *polldev)
 			packet_id = header->packet_id;
 		}
 
-		/* sanity check. when video data is also being retrieved, the
+		/*
+		 * Sanity check. when video data is also being retrieved, the
 		 * packet ID will usually increase in the middle of a series
-		 * instead of at the end. */
+		 * instead of at the end.
+		 */
 		if (packet_id != header->packet_id)
 			dev_warn(sur40->dev, "packet ID mismatch\n");
 
@@ -302,7 +307,7 @@ void sur40_poll(struct input_polled_dev *polldev)
 		for (i = 0; i < packet_blobs; i++) {
 			need_blobs--;
 			dev_dbg(sur40->dev, "processing blob\n");
-			report_blob(&(inblob[i]), input);
+			sur40_report_blob(&(inblob[i]), input);
 		}
 
 	} while (need_blobs > 0);
@@ -311,98 +316,86 @@ void sur40_poll(struct input_polled_dev *polldev)
 	input_sync(input);
 }
 
-/*
- * housekeeping routines
-*/
-
-/* initialize input device parameters */
+/* Initialize input device parameters. */
 static void sur40_input_setup(struct input_dev *input_dev)
 {
-	set_bit(EV_KEY, input_dev->evbit);
-	set_bit(EV_SYN, input_dev->evbit);
-	set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(EV_ABS, input_dev->evbit);
 
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
-		0, SENSOR_RES_X, 0, 0);
+			     0, SENSOR_RES_X, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
-		0, SENSOR_RES_Y, 0, 0);
+			     0, SENSOR_RES_Y, 0, 0);
 
 	input_set_abs_params(input_dev, ABS_MT_TOOL_X,
-		0, SENSOR_RES_X, 0, 0);
+			     0, SENSOR_RES_X, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_TOOL_Y,
-		0, SENSOR_RES_Y, 0, 0);
+			     0, SENSOR_RES_Y, 0, 0);
 
 	/* max value unknown, but major/minor axis
 	 * can never be larger than screen */
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
-		0, SENSOR_RES_X, 0, 0);
+			     0, SENSOR_RES_X, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR,
-		0, SENSOR_RES_Y, 0, 0);
+			     0, SENSOR_RES_Y, 0, 0);
 
 	input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
 
 	input_mt_init_slots(input_dev, MAX_CONTACTS,
-		INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
 }
 
-/* clean up all allocated buffers/structs */
-static inline void sur40_delete(struct sur40_state *sur40)
-{
-	input_free_polled_device(sur40->input);
-	kfree(sur40->bulk_in_buffer);
-	kfree(sur40);
-}
-
-/* check candidate USB interface */
+/* Check candidate USB interface. */
 static int sur40_probe(struct usb_interface *interface,
-	const struct usb_device_id *id)
+		       const struct usb_device_id *id)
 {
 	struct usb_device *usbdev = interface_to_usbdev(interface);
 	struct sur40_state *sur40;
 	struct usb_host_interface *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
 	struct input_polled_dev *poll_dev;
-	int result;
+	int error;
 
-	/* check if we really have the right interface */
+	/* Check if we really have the right interface. */
 	iface_desc = &interface->altsetting[0];
 	if (iface_desc->desc.bInterfaceClass != 0xFF)
 		return -ENODEV;
 
-	/* use endpoint #4 (0x86) */
+	/* Use endpoint #4 (0x86). */
 	endpoint = &iface_desc->endpoint[4].desc;
 	if (endpoint->bEndpointAddress != TOUCH_ENDPOINT)
 		return -ENODEV;
 
-	/* allocate memory for our device state and initialize it */
+	/* Allocate memory for our device state and initialize it. */
 	sur40 = kzalloc(sizeof(struct sur40_state), GFP_KERNEL);
 	if (!sur40)
 		return -ENOMEM;
 
 	poll_dev = input_allocate_polled_device();
 	if (!poll_dev) {
-		result = -ENOMEM;
+		error = -ENOMEM;
 		goto err_free_dev;
 	}
 
-	/* setup polled input device control struct */
+	/* Set up polled input device control structure */
 	poll_dev->private = sur40;
 	poll_dev->poll_interval = POLL_INTERVAL;
 	poll_dev->open = sur40_open;
 	poll_dev->poll = sur40_poll;
 	poll_dev->close = sur40_close;
 
-	/* setup regular input device struct */
+	/* Set up regular input device structure */
 	sur40_input_setup(poll_dev->input);
 
 	poll_dev->input->name = "Samsung SUR40";
-	usb_to_input_id(usbdev, &(poll_dev->input->id));
+	usb_to_input_id(usbdev, &poll_dev->input->id);
 	usb_make_path(usbdev, sur40->phys, sizeof(sur40->phys));
 	strlcat(sur40->phys, "/input0", sizeof(sur40->phys));
 	poll_dev->input->phys = sur40->phys;
+	poll_dev->input->dev.parent = &interface->dev;
 
 	sur40->usbdev = usbdev;
-	sur40->dev = &usbdev->dev;
+	sur40->dev = &interface->dev;
 	sur40->input = poll_dev;
 
 	/* use the bulk-in endpoint tested above */
@@ -411,12 +404,12 @@ static int sur40_probe(struct usb_interface *interface,
 	sur40->bulk_in_buffer = kmalloc(sur40->bulk_in_size, GFP_KERNEL);
 	if (!sur40->bulk_in_buffer) {
 		dev_err(&interface->dev, "Unable to allocate input buffer.");
-		result = -ENOMEM;
+		error = -ENOMEM;
 		goto err_free_polldev;
 	}
 
-	result = input_register_polled_device(poll_dev);
-	if (result) {
+	error = input_register_polled_device(poll_dev);
+	if (error) {
 		dev_err(&interface->dev,
 			"Unable to register polled input device.");
 		goto err_free_buffer;
@@ -424,7 +417,7 @@ static int sur40_probe(struct usb_interface *interface,
 
 	/* we can register the device now, as it is ready */
 	usb_set_intfdata(interface, sur40);
-	dev_dbg(&interface->dev, "%s now attached\n", DRIVER_DESC);
+	dev_dbg(&interface->dev, "%s is now attached\n", DRIVER_DESC);
 
 	return 0;
 
@@ -435,24 +428,30 @@ err_free_polldev:
 err_free_dev:
 	kfree(sur40);
 
-	return result;
+	return error;
 }
 
-/* unregister device & clean up */
+/* Unregister device & clean up. */
 static void sur40_disconnect(struct usb_interface *interface)
 {
 	struct sur40_state *sur40 = usb_get_intfdata(interface);
 
 	input_unregister_polled_device(sur40->input);
+	input_free_polled_device(sur40->input);
+	kfree(sur40->bulk_in_buffer);
+	kfree(sur40);
 
 	usb_set_intfdata(interface, NULL);
-
-	sur40_delete(sur40);
-
-	dev_dbg(&interface->dev, "%s now disconnected\n", DRIVER_DESC);
+	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);
 }
 
-/* usb specific object needed to register this driver with the usb subsystem */
+static const struct usb_device_id sur40_table[] = {
+	{ USB_DEVICE(ID_MICROSOFT, ID_SUR40) },  /* Samsung SUR40 */
+	{ }                                      /* terminating null entry */
+};
+MODULE_DEVICE_TABLE(usb, sur40_table);
+
+/* USB-specific object needed to register this driver with the USB subsystem. */
 static struct usb_driver sur40_driver = {
 	.name = DRIVER_SHORT,
 	.probe = sur40_probe,
