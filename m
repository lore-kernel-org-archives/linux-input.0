From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 1/5] Input: xpad: handle "present" and "gone" correctly
Date: Sun,  1 Nov 2015 16:31:35 +0100
Message-ID: <1446391899-24250-2-git-send-email-rojtberg@gmail.com>
References: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37544 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKAPby (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Nov 2015 10:31:54 -0500
Received: by wmff134 with SMTP id f134so42639149wmf.0
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2015 07:31:52 -0800 (PST)
In-Reply-To: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

Handle the "a new device is present" message properly by dynamically
creating the input device at this point in time. This means we now do
not "preallocate" all 4 devices when a single
wireless base station is seen. This requires a workqueue as we are in
interrupt context when we learn about this.

Also properly disconnect any devices that we are told are removed.

Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 66 +++++++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index fd4100d..23e5613 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -343,8 +343,12 @@ struct usb_xpad {
 	int xtype;			/* type of xbox device */
 	int pad_nr;			/* the order x360 pads were attached */
 	const char *name;		/* name of the device */
+	struct work_struct work;	/* init/remove device from callback */
 };
 
+static int xpad_init_input(struct usb_xpad *xpad);
+static void xpad_deinit_input(struct usb_xpad *xpad);
+
 /*
  *	xpad_process_packet
  *
@@ -497,6 +501,22 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 
 static void xpad_identify_controller(struct usb_xpad *xpad);
 
+static void presence_work_function(struct work_struct *work)
+{
+	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
+	int error;
+
+	if (xpad->pad_present) {
+		error = xpad_init_input(xpad);
+		if (error) {
+			/* complain only, not much else we can do here */
+			dev_err(&xpad->dev->dev, "unable to init device\n");
+		}
+	} else {
+		xpad_deinit_input(xpad);
+	}
+}
+
 /*
  * xpad360w_process_packet
  *
@@ -513,17 +533,16 @@ static void xpad_identify_controller(struct usb_xpad *xpad);
  */
 static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
+	int presence;
+
 	/* Presence change */
 	if (data[0] & 0x08) {
-		if (data[1] & 0x80) {
-			xpad->pad_present = 1;
-			/*
-			 * Light up the segment corresponding to
-			 * controller number.
-			 */
-			xpad_identify_controller(xpad);
-		} else
-			xpad->pad_present = 0;
+		presence = (data[1] & 0x80) != 0;
+
+		if (xpad->pad_present != presence) {
+			xpad->pad_present = presence;
+			schedule_work(&xpad->work);
+		}
 	}
 
 	/* Valid pad data */
@@ -1001,14 +1020,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (error)
 		goto err_free_id;
 
-	if (xpad->xtype == XTYPE_XBOX360) {
-		/*
-		 * Light up the segment corresponding to controller
-		 * number on wired devices. On wireless we'll do that
-		 * when they respond to "presence" packet.
-		 */
-		xpad_identify_controller(xpad);
-	}
+	xpad_identify_controller(xpad);
 
 	return 0;
 
@@ -1241,6 +1253,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	xpad->mapping = xpad_device[i].mapping;
 	xpad->xtype = xpad_device[i].xtype;
 	xpad->name = xpad_device[i].name;
+	INIT_WORK(&xpad->work, presence_work_function);
 
 	if (xpad->xtype == XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
@@ -1277,10 +1290,6 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 
 	usb_set_intfdata(intf, xpad);
 
-	error = xpad_init_input(xpad);
-	if (error)
-		goto err_deinit_output;
-
 	if (xpad->xtype == XTYPE_XBOX360W) {
 		/*
 		 * Submit the int URB immediately rather than waiting for open
@@ -1292,7 +1301,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->irq_in->dev = xpad->udev;
 		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
 		if (error)
-			goto err_deinit_input;
+			goto err_deinit_output;
 
 		/*
 		 * Send presence packet.
@@ -1304,13 +1313,16 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		error = xpad_inquiry_pad_presence(xpad);
 		if (error)
 			goto err_kill_in_urb;
+	} else {
+		xpad->pad_present = 1;
+		error = xpad_init_input(xpad);
+		if (error)
+			goto err_deinit_output;
 	}
 	return 0;
 
 err_kill_in_urb:
 	usb_kill_urb(xpad->irq_in);
-err_deinit_input:
-	xpad_deinit_input(xpad);
 err_deinit_output:
 	xpad_deinit_output(xpad);
 err_free_in_urb:
@@ -1327,13 +1339,17 @@ static void xpad_disconnect(struct usb_interface *intf)
 {
 	struct usb_xpad *xpad = usb_get_intfdata (intf);
 
-	xpad_deinit_input(xpad);
 	xpad_deinit_output(xpad);
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
 		usb_kill_urb(xpad->irq_in);
 	}
 
+	cancel_work_sync(&xpad->work);
+
+	if (xpad->pad_present)
+		xpad_deinit_input(xpad);
+
 	usb_free_urb(xpad->irq_in);
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 			xpad->idata, xpad->idata_dma);
-- 
1.9.1

