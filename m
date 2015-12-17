From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] Input: xpad: workaround dead irq_out after suspend/
 resume
Date: Wed, 16 Dec 2015 17:09:37 -0800
Message-ID: <20151217010937.GE10962@dtor-ws>
References: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
 <1446391899-24250-5-git-send-email-rojtberg@gmail.com>
 <20151210064131.GB35505@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34755 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966196AbbLQBJk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 20:09:40 -0500
Received: by mail-pf0-f177.google.com with SMTP id 68so20973066pfc.1
        for <linux-input@vger.kernel.org>; Wed, 16 Dec 2015 17:09:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151210064131.GB35505@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Wed, Dec 09, 2015 at 10:41:31PM -0800, Dmitry Torokhov wrote:
> On Sun, Nov 01, 2015 at 04:31:38PM +0100, Pavel Rojtberg wrote:
> > From: Pavel Rojtberg <rojtberg@gmail.com>
...
> > +
> > +static int xpad_resume(struct usb_interface *intf)
> > +{
> > +	usb_queue_reset_device(intf);
> 
> Why do we have to force reset (and tear down the device)? I am sure we
> can resume it properly.

Does the patch below work for you?

-- 
Dmitry


Input: xpad - workaround dead irq_out after suspend/ resume

From: Pavel Rojtberg <rojtberg@gmail.com>

The irq_out urb is dead after suspend/ resume on my x360 wr pad. (also
reproduced by Zachary Lund [0]) Work around this by implementing suspend
and resume callbacks and properly shutting down URBs on suspend and
restarting them on resume.

[0]: https://github.com/paroj/xpad/issues/6

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/xpad.c |  156 ++++++++++++++++++++++++++++++-----------
 1 file changed, 114 insertions(+), 42 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f88cf00..36328b3 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -864,12 +864,6 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
  fail1:	return error;
 }
 
-static void xpad_stop_output(struct usb_xpad *xpad)
-{
-	if (xpad->xtype != XTYPE_UNKNOWN)
-		usb_kill_urb(xpad->irq_out);
-}
-
 static void xpad_deinit_output(struct usb_xpad *xpad)
 {
 	if (xpad->xtype != XTYPE_UNKNOWN) {
@@ -930,7 +924,7 @@ static int xpad_start_xbox_one(struct usb_xpad *xpad)
 	packet->len = 5;
 	packet->pending = true;
 
-	retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+	retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL) ? -EIO : 0;
 
 	spin_unlock_irqrestore(&xpad->odata_lock, flags);
 
@@ -1194,32 +1188,73 @@ static void xpad_led_disconnect(struct usb_xpad *xpad) { }
 static void xpad_identify_controller(struct usb_xpad *xpad) { }
 #endif
 
-static int xpad_open(struct input_dev *dev)
+static int xpad_start_input(struct usb_xpad *xpad)
 {
-	struct usb_xpad *xpad = input_get_drvdata(dev);
-
-	/* URB was submitted in probe */
-	if (xpad->xtype == XTYPE_XBOX360W)
-		return 0;
+	int error;
 
-	xpad->irq_in->dev = xpad->udev;
 	if (usb_submit_urb(xpad->irq_in, GFP_KERNEL))
 		return -EIO;
 
-	if (xpad->xtype == XTYPE_XBOXONE)
-		return xpad_start_xbox_one(xpad);
+	if (xpad->xtype == XTYPE_XBOXONE) {
+		error = xpad_start_xbox_one(xpad);
+		if (error) {
+			usb_kill_urb(xpad->irq_in);
+			return error;
+		}
+	}
 
 	return 0;
 }
 
-static void xpad_close(struct input_dev *dev)
+static void xpad_stop_input(struct usb_xpad *xpad)
 {
-	struct usb_xpad *xpad = input_get_drvdata(dev);
+	usb_kill_urb(xpad->irq_in);
+}
+
+static int xpad360w_start_input(struct usb_xpad *xpad)
+{
+	int error;
 
-	if (xpad->xtype != XTYPE_XBOX360W)
+	error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
+	if (error)
+		return -EIO;
+
+	/*
+	 * Send presence packet.
+	 * This will force the controller to resend connection packets.
+	 * This is useful in the case we activate the module after the
+	 * adapter has been plugged in, as it won't automatically
+	 * send us info about the controllers.
+	 */
+	error = xpad_inquiry_pad_presence(xpad);
+	if (error) {
 		usb_kill_urb(xpad->irq_in);
+		return error;
+	}
+
+	return 0;
+}
+
+static void xpad360w_stop_input(struct usb_xpad *xpad)
+{
+	usb_kill_urb(xpad->irq_in);
+
+	/* Make sure we are done with presence work if it was scheduled */
+	flush_work(&xpad->work);
+}
+
+static int xpad_open(struct input_dev *dev)
+{
+	struct usb_xpad *xpad = input_get_drvdata(dev);
+
+	return xpad_start_input(xpad);
+}
 
-	xpad_stop_output(xpad);
+static void xpad_close(struct input_dev *dev)
+{
+	struct usb_xpad *xpad = input_get_drvdata(dev);
+
+	xpad_stop_input(xpad);
 }
 
 static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
@@ -1274,8 +1309,10 @@ static int xpad_init_input(struct usb_xpad *xpad)
 
 	input_set_drvdata(input_dev, xpad);
 
-	input_dev->open = xpad_open;
-	input_dev->close = xpad_close;
+	if (xpad->xtype != XTYPE_XBOX360W) {
+		input_dev->open = xpad_open;
+		input_dev->close = xpad_close;
+	}
 
 	__set_bit(EV_KEY, input_dev->evbit);
 
@@ -1443,21 +1480,9 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		 * exactly the message that a controller has arrived that
 		 * we're waiting for.
 		 */
-		xpad->irq_in->dev = xpad->udev;
-		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
+		error = xpad360w_start_input(xpad);
 		if (error)
 			goto err_deinit_output;
-
-		/*
-		 * Send presence packet.
-		 * This will force the controller to resend connection packets.
-		 * This is useful in the case we activate the module after the
-		 * adapter has been plugged in, as it won't automatically
-		 * send us info about the controllers.
-		 */
-		error = xpad_inquiry_pad_presence(xpad);
-		if (error)
-			goto err_kill_in_urb;
 	} else {
 		error = xpad_init_input(xpad);
 		if (error)
@@ -1465,8 +1490,6 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	}
 	return 0;
 
-err_kill_in_urb:
-	usb_kill_urb(xpad->irq_in);
 err_deinit_output:
 	xpad_deinit_output(xpad);
 err_free_in_urb:
@@ -1476,20 +1499,24 @@ err_free_idata:
 err_free_mem:
 	kfree(xpad);
 	return error;
-
 }
 
 static void xpad_disconnect(struct usb_interface *intf)
 {
-	struct usb_xpad *xpad = usb_get_intfdata (intf);
+	struct usb_xpad *xpad = usb_get_intfdata(intf);
 
 	if (xpad->xtype == XTYPE_XBOX360W)
-		usb_kill_urb(xpad->irq_in);
-
-	cancel_work_sync(&xpad->work);
+		xpad360w_stop_input(xpad);
 
 	xpad_deinit_input(xpad);
 
+	/*
+	 * Now that both input device and LED device are gone we can
+	 * stop output URB.
+	 */
+	if (xpad->xtype == XTYPE_XBOX360W)
+		usb_kill_urb(xpad->irq_out);
+
 	usb_free_urb(xpad->irq_in);
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 			xpad->idata, xpad->idata_dma);
@@ -1501,10 +1528,55 @@ static void xpad_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 }
 
+static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct usb_xpad *xpad = usb_get_intfdata(intf);
+	struct input_dev *input = xpad->dev;
+
+	if (xpad->xtype == XTYPE_XBOX360W) {
+		/*
+		 * Wireless controllers always listen to input so
+		 * they are notified when controller shows up
+		 * or goes away.
+		 */
+		xpad360w_stop_input(xpad);
+	} else {
+		mutex_lock(&input->mutex);
+		if (input->users)
+			xpad_stop_input(xpad);
+		mutex_unlock(&input->mutex);
+	}
+
+	if (xpad->xtype != XTYPE_UNKNOWN)
+		usb_kill_urb(xpad->irq_out);
+
+	return 0;
+}
+
+static int xpad_resume(struct usb_interface *intf)
+{
+	struct usb_xpad *xpad = usb_get_intfdata(intf);
+	struct input_dev *input = xpad->dev;
+	int retval = 0;
+
+	if (xpad->xtype == XTYPE_XBOX360W) {
+		retval = xpad360w_start_input(xpad);
+	} else {
+		mutex_lock(&input->mutex);
+		if (input->users)
+			retval = xpad_start_input(xpad);
+		mutex_unlock(&input->mutex);
+	}
+
+	return retval;
+}
+
 static struct usb_driver xpad_driver = {
 	.name		= "xpad",
 	.probe		= xpad_probe,
 	.disconnect	= xpad_disconnect,
+	.suspend	= xpad_suspend,
+	.resume		= xpad_resume,
 	.id_table	= xpad_table,
 };
 
