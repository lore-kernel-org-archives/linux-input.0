From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 13/15] Input: xpad: re-submit pending ff and led requests
Date: Thu,  1 Oct 2015 22:57:24 +0200
Message-ID: <1443733046-29610-14-git-send-email-rojtberg@gmail.com>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33949 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148AbbJAU5v (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 16:57:51 -0400
Received: by wicfx3 with SMTP id fx3so7988150wic.1
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2015 13:57:50 -0700 (PDT)
In-Reply-To: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

Store pending brightness and FF effect in the driver structure and
replace it with the latest requests until the device is ready to process
next request. Alternate serving LED vs FF requests to make sure one does
not starve another. See [1] for discussion. Inspired by patch of Sarah
Bessmer [2].

[1]: http://www.spinics.net/lists/linux-input/msg40708.html
[2]: http://www.spinics.net/lists/linux-input/msg31450.html

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 1fd2e23..cd0718a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -335,6 +335,12 @@ struct usb_xpad {
 	dma_addr_t odata_dma;
 	spinlock_t odata_lock;
 
+	unsigned char rum_odata[XPAD_PKT_LEN]; /* cache for rumble data */
+	unsigned char led_odata[XPAD_PKT_LEN]; /* cache for led data */
+	unsigned pend_rum;               /* length of cached rumble data */
+	unsigned pend_led;               /* length of cached led data */
+	int force_led;                   /* force send led cache next */
+
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct xpad_led *led;
 #endif
@@ -705,14 +711,35 @@ static void xpad_irq_out(struct urb *urb)
 	struct usb_xpad *xpad = urb->context;
 	struct device *dev = &xpad->intf->dev;
 	int retval, status;
+	unsigned long flags;
 
 	status = urb->status;
 
 	switch (status) {
 	case 0:
 		/* success */
-		xpad->irq_out_active = 0;
-		return;
+		if(!xpad->pend_led && !xpad->pend_rum) {
+			xpad->irq_out_active = 0;
+			return;
+		}
+
+		spin_lock_irqsave(&xpad->odata_lock, flags);
+
+		if(xpad->pend_led && (!xpad->pend_rum || xpad->force_led)) {
+			xpad->irq_out->transfer_buffer_length = xpad->pend_led;
+			memcpy(xpad->odata, xpad->led_odata, xpad->pend_led);
+			xpad->pend_led = 0;
+			xpad->force_led = 0;
+			dev_dbg(dev, "%s - sending pending led\n", __func__);
+			break;
+		}
+
+		xpad->irq_out->transfer_buffer_length = xpad->pend_rum;
+		memcpy(xpad->odata, xpad->rum_odata, xpad->pend_rum);
+		xpad->pend_rum = 0;
+		xpad->force_led = 1;
+		dev_dbg(dev, "%s - sending pending rumble\n", __func__);
+		break;
 
 	case -ECONNRESET:
 	case -ENOENT:
@@ -726,11 +753,13 @@ static void xpad_irq_out(struct urb *urb)
 	default:
 		dev_dbg(dev, "%s - nonzero urb status received: %d\n",
 			__func__, status);
-		goto exit;
+
+		spin_lock_irqsave(&xpad->odata_lock, flags);
+		break;
 	}
 
-exit:
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
 	if (retval)
 		dev_err(dev, "%s - usb_submit_urb failed with result %d\n",
 			__func__, retval);
@@ -753,6 +782,9 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 	}
 
 	spin_lock_init(&xpad->odata_lock);
+	xpad->pend_led = 0;
+	xpad->pend_rum = 0;
+	xpad->force_led = 0;
 
 	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xpad->irq_out) {
@@ -877,9 +909,17 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 		retval = usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
 		xpad->irq_out_active = 1;
 	} else {
-		retval = -EIO;
-		dev_dbg(&xpad->dev->dev, "%s - dropped, irq_out is active\n",
-				__func__);
+		retval = 0;
+
+		if(xpad->pend_rum) {
+			dev_dbg(&xpad->dev->dev,
+				"%s - overwriting pending\n", __func__);
+
+			retval = -EIO;
+		}
+
+		xpad->pend_rum = xpad->irq_out->transfer_buffer_length;
+		memcpy(xpad->rum_odata, xpad->odata, xpad->pend_rum);
 	}
 
 	spin_unlock_irqrestore(&xpad->odata_lock, flags);
@@ -965,9 +1005,15 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 	if (!xpad->irq_out_active) {
 		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
 		xpad->irq_out_active = 1;
-	} else
-		dev_dbg(&xpad->dev->dev, "%s - dropped, irq_out is active\n",
-				__func__);
+	} else {
+		if(xpad->pend_led) {
+			dev_dbg(&xpad->dev->dev,
+				"%s - overwriting pending\n", __func__);
+		}
+
+		xpad->pend_led = xpad->irq_out->transfer_buffer_length;
+		memcpy(xpad->led_odata, xpad->odata, xpad->pend_led);
+	}
 
 	spin_unlock_irqrestore(&xpad->odata_lock, flags);
 }
-- 
1.9.1

