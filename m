From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 11/15] Input: xpad: do not submit active URBs
Date: Thu,  1 Oct 2015 22:57:22 +0200
Message-ID: <1443733046-29610-12-git-send-email-rojtberg@gmail.com>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33916 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757015AbbJAU5t (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 16:57:49 -0400
Received: by wicfx3 with SMTP id fx3so7987192wic.1
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2015 13:57:48 -0700 (PDT)
In-Reply-To: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

track the active status of the irq_out URB to prevent submission while
it is active. Failure to do so results in the "URB submitted while
active" warning/ stacktrace.

Also add missing mutex locking around xpad->odata usages.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 7d53e8e..5eec515 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -330,6 +330,7 @@ struct usb_xpad {
 	dma_addr_t idata_dma;
 
 	struct urb *irq_out;		/* urb for interrupt out report */
+	int irq_out_active;		/* we must not use an active URB */
 	unsigned char *odata;		/* output data */
 	dma_addr_t odata_dma;
 	struct mutex odata_mutex;
@@ -710,6 +711,7 @@ static void xpad_irq_out(struct urb *urb)
 	switch (status) {
 	case 0:
 		/* success */
+		xpad->irq_out_active = 0;
 		return;
 
 	case -ECONNRESET:
@@ -718,6 +720,7 @@ static void xpad_irq_out(struct urb *urb)
 		/* this urb is terminated, clean up */
 		dev_dbg(dev, "%s - urb shutting down with status: %d\n",
 			__func__, status);
+		xpad->irq_out_active = 0;
 		return;
 
 	default:
@@ -795,6 +798,7 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	struct usb_xpad *xpad = input_get_drvdata(dev);
 	__u16 strong;
 	__u16 weak;
+	int retval;
 
 	if (effect->type != FF_RUMBLE)
 		return 0;
@@ -802,6 +806,8 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	strong = effect->u.rumble.strong_magnitude;
 	weak = effect->u.rumble.weak_magnitude;
 
+	mutex_lock(&xpad->odata_mutex);
+
 	switch (xpad->xtype) {
 	case XTYPE_XBOX:
 		xpad->odata[0] = 0x00;
@@ -858,13 +864,25 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
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
@@ -940,7 +958,13 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
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
 
@@ -1028,6 +1052,7 @@ static void xpad_identify_controller(struct usb_xpad *xpad) { }
 static int xpad_open(struct input_dev *dev)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
+	int retval;
 
 	/* URB was submitted in probe */
 	if (xpad->xtype == XTYPE_XBOX360W)
@@ -1038,11 +1063,14 @@ static int xpad_open(struct input_dev *dev)
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
@@ -1300,7 +1328,14 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
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

