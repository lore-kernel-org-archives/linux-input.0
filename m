From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 2/5] Input: xpad: do not submit active URBs
Date: Sun,  1 Nov 2015 16:31:36 +0100
Message-ID: <1446391899-24250-3-git-send-email-rojtberg@gmail.com>
References: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38254 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKAPiA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Nov 2015 10:38:00 -0500
Received: by wmeg8 with SMTP id g8so42807797wme.1
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2015 07:37:59 -0800 (PST)
In-Reply-To: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

track the active status of the irq_out URB to prevent submission while
it is active. Failure to do so results in the "URB submitted while
active" warning/ stacktrace.

Also add missing locking around xpad->odata usages: as we can not use
mutexes in xpad_play_effect, replace the mutex by a spinlock.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 23e5613..595e3ad 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -329,9 +329,10 @@ struct usb_xpad {
 	dma_addr_t idata_dma;
 
 	struct urb *irq_out;		/* urb for interrupt out report */
+	int irq_out_active;		/* we must not use an active URB */
 	unsigned char *odata;		/* output data */
 	dma_addr_t odata_dma;
-	struct mutex odata_mutex;
+	spinlock_t odata_lock;
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct xpad_led *led;
@@ -708,6 +709,7 @@ static void xpad_irq_out(struct urb *urb)
 	switch (status) {
 	case 0:
 		/* success */
+		xpad->irq_out_active = 0;
 		return;
 
 	case -ECONNRESET:
@@ -716,6 +718,7 @@ static void xpad_irq_out(struct urb *urb)
 		/* this urb is terminated, clean up */
 		dev_dbg(dev, "%s - urb shutting down with status: %d\n",
 			__func__, status);
+		xpad->irq_out_active = 0;
 		return;
 
 	default:
@@ -747,7 +750,7 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 		goto fail1;
 	}
 
-	mutex_init(&xpad->odata_mutex);
+	spin_lock_init(&xpad->odata_lock);
 
 	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xpad->irq_out) {
@@ -790,8 +793,9 @@ static void xpad_deinit_output(struct usb_xpad *xpad)
 static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 {
 	int retval;
+	unsigned long flags;
 
-	mutex_lock(&xpad->odata_mutex);
+	spin_lock_irqsave(&xpad->odata_lock, flags);
 
 	xpad->odata[0] = 0x08;
 	xpad->odata[1] = 0x00;
@@ -807,9 +811,16 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 	xpad->odata[11] = 0x00;
 	xpad->irq_out->transfer_buffer_length = 12;
 
-	retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+	if (!xpad->irq_out_active) {
+		retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		xpad->irq_out_active = 1;
+	} else {
+		dev_dbg(&xpad->dev->dev, "%s - dropped, irq_out is active\n",
+				__func__);
+		retval = -EIO;
+	}
 
-	mutex_unlock(&xpad->odata_mutex);
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
 
 	return retval;
 }
@@ -820,6 +831,9 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	struct usb_xpad *xpad = input_get_drvdata(dev);
 	__u16 strong;
 	__u16 weak;
+	int retval;
+
+	unsigned long flags;
 
 	if (effect->type != FF_RUMBLE)
 		return 0;
@@ -827,6 +841,8 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	strong = effect->u.rumble.strong_magnitude;
 	weak = effect->u.rumble.weak_magnitude;
 
+	spin_lock_irqsave(&xpad->odata_lock, flags);
+
 	switch (xpad->xtype) {
 	case XTYPE_XBOX:
 		xpad->odata[0] = 0x00;
@@ -883,13 +899,25 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 		break;
 
 	default:
+		spin_unlock_irqrestore(&xpad->odata_lock, flags);
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
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
+
+	return retval;
 }
 
 static int xpad_init_ff(struct usb_xpad *xpad)
@@ -940,9 +968,11 @@ struct xpad_led {
  */
 static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
+	unsigned long flags;
+
 	command %= 16;
 
-	mutex_lock(&xpad->odata_mutex);
+	spin_lock_irqsave(&xpad->odata_lock, flags);
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX360:
@@ -968,8 +998,14 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 		break;
 	}
 
-	usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-	mutex_unlock(&xpad->odata_mutex);
+	if (!xpad->irq_out_active) {
+		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		xpad->irq_out_active = 1;
+	} else
+		dev_dbg(&xpad->dev->dev, "%s - dropped, irq_out is active\n",
+				__func__);
+
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
 }
 
 /*
@@ -1051,6 +1087,9 @@ static void xpad_identify_controller(struct usb_xpad *xpad) { }
 static int xpad_open(struct input_dev *dev)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
+	int retval;
+
+	unsigned long flags;
 
 	/* URB was submitted in probe */
 	if (xpad->xtype == XTYPE_XBOX360W)
@@ -1061,11 +1100,14 @@ static int xpad_open(struct input_dev *dev)
 		return -EIO;
 
 	if (xpad->xtype == XTYPE_XBOXONE) {
+		spin_lock_irqsave(&xpad->odata_lock, flags);
 		/* Xbox one controller needs to be initialized. */
 		xpad->odata[0] = 0x05;
 		xpad->odata[1] = 0x20;
 		xpad->irq_out->transfer_buffer_length = 2;
-		return usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		spin_unlock_irqrestore(&xpad->odata_lock, flags);
+		return retval;
 	}
 
 	return 0;
-- 
1.9.1

