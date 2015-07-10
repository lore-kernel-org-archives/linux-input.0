From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 8/8] Input: xpad: do not submit active URBs
Date: Sat, 11 Jul 2015 01:47:48 +0200
Message-ID: <1436572068-10661-9-git-send-email-rojtberg@gmail.com>
References: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37909 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbbGKGyk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jul 2015 02:54:40 -0400
Received: by wicmv11 with SMTP id mv11so27856351wic.1
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2015 23:54:38 -0700 (PDT)
In-Reply-To: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

track the active status of the irq_out URB to prevent submission while
it is active. Failure to do so results in the "URB submitted while
active" warning/ stacktrace.

Also add missing mutex locking around xpad->odata usages.

This is an workaround for a suspend/ resume issue on my machine, where
after resume irq_out is completely dead.

In preliminary testing I could not observe any dropping of packets.
(controlling rumble with fftest while setting the LEDs using sysfs)
If there actually are cases where packets are dropped an extension of
this patch to queue the URBs instead of dropping is straightforward.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 150eaaa..3df4671 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -329,6 +329,7 @@ struct usb_xpad {
 	dma_addr_t idata_dma;
 
 	struct urb *irq_out;		/* urb for interrupt out report */
+	int irq_out_active;		/* we must not use an active URB */
 	unsigned char *odata;		/* output data */
 	dma_addr_t odata_dma;
 	struct mutex odata_mutex;
@@ -701,6 +702,7 @@ static void xpad_irq_out(struct urb *urb)
 	switch (status) {
 	case 0:
 		/* success */
+		xpad->irq_out_active = 0;
 		return;
 
 	case -ECONNRESET:
@@ -709,6 +711,7 @@ static void xpad_irq_out(struct urb *urb)
 		/* this urb is terminated, clean up */
 		dev_dbg(dev, "%s - urb shutting down with status: %d\n",
 			__func__, status);
+		xpad->irq_out_active = 0;
 		return;
 
 	default:
@@ -786,6 +789,7 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	struct usb_xpad *xpad = input_get_drvdata(dev);
 	__u16 strong;
 	__u16 weak;
+	int retval;
 
 	if (effect->type != FF_RUMBLE)
 		return 0;
@@ -793,6 +797,8 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	strong = effect->u.rumble.strong_magnitude;
 	weak = effect->u.rumble.weak_magnitude;
 
+	mutex_lock(&xpad->odata_mutex);
+
 	switch (xpad->xtype) {
 	case XTYPE_XBOX:
 		xpad->odata[0] = 0x00;
@@ -849,13 +855,25 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 		break;
 
 	default:
+		mutex_unlock(&xpad->odata_mutex);
 		dev_dbg(&xpad->dev->dev,
 			"%s - rumble command sent to unsupported xpad type: %d\n",
 			__func__, xpad->xtype);
 		return -EINVAL;
 	}
 
-	return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+	if (!xpad->irq_out_active) {
+		retval = usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+		xpad->irq_out_active = 1;
+	} else {
+		retval = -EIO;
+		dev_dbg(&xpad->dev->dev, "%s - dropped, irq_out is active\n",
+				__func__);
+	}
+
+	mutex_unlock(&xpad->odata_mutex);
+
+	return retval;
 }
 
 static int xpad_init_ff(struct usb_xpad *xpad)
@@ -931,7 +949,13 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 		break;
 	}
 
-	usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+	if (!xpad->irq_out_active) {
+		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		xpad->irq_out_active = 1;
+	} else
+		dev_dbg(&xpad->dev->dev, "%s - dropped, irq_out is active\n",
+				__func__);
+
 	mutex_unlock(&xpad->odata_mutex);
 }
 
@@ -1007,6 +1031,7 @@ static void xpad_identify_controller(struct usb_xpad *xpad) { }
 static int xpad_open(struct input_dev *dev)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
+	int retval;
 
 	/* URB was submitted in probe */
 	if (xpad->xtype == XTYPE_XBOX360W)
@@ -1017,11 +1042,14 @@ static int xpad_open(struct input_dev *dev)
 		return -EIO;
 
 	if (xpad->xtype == XTYPE_XBOXONE) {
+		mutex_lock(&xpad->odata_mutex);
 		/* Xbox one controller needs to be initialized. */
 		xpad->odata[0] = 0x05;
 		xpad->odata[1] = 0x20;
 		xpad->irq_out->transfer_buffer_length = 2;
-		return usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		mutex_unlock(&xpad->odata_mutex);
+		return retval;
 	}
 
 	return 0;
@@ -1272,7 +1300,14 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->odata[10] = 0x00;
 		xpad->odata[11] = 0x00;
 		xpad->irq_out->transfer_buffer_length = 12;
-		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+
+		if (!xpad->irq_out_active) {
+			usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+			xpad->irq_out_active = 1;
+		} else
+			dev_dbg(&xpad->dev->dev,
+				"%s - dropped, irq_out is active\n", __func__);
+
 		mutex_unlock(&xpad->odata_mutex);
 	} else {
 		xpad->pad_present = 1;
-- 
1.9.1

