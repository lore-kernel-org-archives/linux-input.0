From: Oliver Neukum <oliver@neukum.org>
Subject: usb autosuspend for usbtouch
Date: Fri, 4 Apr 2008 16:15:26 +0200
Message-ID: <200804041615.26692.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:56020 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbYDDOVK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2008 10:21:10 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Ritz <daniel.ritz@gmx.ch>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Hi,

this implements autosuspend for the usb touchscreen driver.
I am looking for testers.

	Regards
		Oliver

---

--- linux-2.6.25-rc7-work/drivers/input/touchscreen/usbtouchscreen.c.alt	2008-04-04 15:02:21.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/input/touchscreen/usbtouchscreen.c	2008-04-04 15:45:17.000000000 +0200
@@ -89,13 +89,16 @@ struct usbtouch_usb {
 	int buf_len;
 	struct urb *irq;
 	struct usb_device *udev;
+	struct usb_interface *intf;
 	struct input_dev *input;
 	struct usbtouch_device_info *type;
+	struct mutex lock;
 	char name[128];
 	char phys[64];
 
 	int x, y;
 	int touch, press;
+	unsigned int open:1;
 };
 
 
@@ -784,9 +787,9 @@ out_flush_buf:
 static void usbtouch_irq(struct urb *urb)
 {
 	struct usbtouch_usb *usbtouch = urb->context;
-	int retval;
+	int retval, status = urb->status;
 
-	switch (urb->status) {
+	switch (status) {
 	case 0:
 		/* success */
 		break;
@@ -800,7 +803,7 @@ static void usbtouch_irq(struct urb *urb
 	case -ESHUTDOWN:
 		/* this urb is terminated, clean up */
 		dbg("%s - urb shutting down with status: %d",
-		    __FUNCTION__, urb->status);
+		    __FUNCTION__, status);
 		return;
 	default:
 		dbg("%s - nonzero urb status received: %d",
@@ -811,6 +814,7 @@ static void usbtouch_irq(struct urb *urb
 	usbtouch->type->process_pkt(usbtouch, usbtouch->data, urb->actual_length);
 
 exit:
+	usb_mark_last_busy(usbtouch->udev);
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
 	if (retval)
 		err("%s - usb_submit_urb failed with result: %d",
@@ -820,11 +824,22 @@ exit:
 static int usbtouch_open(struct input_dev *input)
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
+	int rv;
 
+	mutex_lock(&usbtouch->lock);
 	usbtouch->irq->dev = usbtouch->udev;
-
-	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
-		return -EIO;
+	rv = usb_autopm_get_interface(usbtouch->intf);
+	if (rv < 0)
+		goto err_out;
+	rv = usb_submit_urb(usbtouch->irq, GFP_KERNEL);
+	if (rv < 0)
+		goto err_out_put;
+	usbtouch->intf->needs_remote_wakeup = 1;
+	usbtouch->open = 1;
+err_out_put:
+	usb_autopm_put_interface(usbtouch->intf);
+err_out:
+	mutex_unlock(&usbtouch->lock);
 
 	return 0;
 }
@@ -833,7 +848,11 @@ static void usbtouch_close(struct input_
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
 
+	mutex_lock(&usbtouch->lock);
 	usb_kill_urb(usbtouch->irq);
+	usbtouch->intf->needs_remote_wakeup = 0;
+	usbtouch->open = 0;
+	mutex_unlock(&usbtouch->lock);
 }
 
 
@@ -889,6 +908,8 @@ static int usbtouch_probe(struct usb_int
 
 	usbtouch->udev = udev;
 	usbtouch->input = input_dev;
+	usbtouch->intf = intf;
+	mutex_init(&usbtouch->lock);
 
 	if (udev->manufacturer)
 		strlcpy(usbtouch->name, udev->manufacturer, sizeof(usbtouch->name));
@@ -980,12 +1001,40 @@ static void usbtouch_disconnect(struct u
 	kfree(usbtouch);
 }
 
+static int usbtouch_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+
+	mutex_lock(&usbtouch->lock);
+	usb_kill_urb(usbtouch->irq);
+	mutex_unlock(&usbtouch->lock);
+
+	return 0;
+}
+
+static int usbtouch_resume(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	int rv;
+
+	mutex_lock(&usbtouch->lock);
+	if (usbtouch->open)
+		rv = usb_submit_urb(usbtouch->irq, GFP_NOIO);
+	else
+		rv = 0;
+	mutex_unlock(&usbtouch->lock);
+
+	return rv;
+}
+
 MODULE_DEVICE_TABLE(usb, usbtouch_devices);
 
 static struct usb_driver usbtouch_driver = {
 	.name		= "usbtouchscreen",
 	.probe		= usbtouch_probe,
 	.disconnect	= usbtouch_disconnect,
+	.suspend	= usbtouch_suspend,
+	.resume		= usbtouch_resume,
 	.id_table	= usbtouch_devices,
 };
 
