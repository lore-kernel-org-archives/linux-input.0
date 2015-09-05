From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 6/6] Input: xpad: reset usb device on resume
Date: Sat,  5 Sep 2015 22:58:07 +0200
Message-ID: <1441486687-4836-7-git-send-email-rojtberg@gmail.com>
References: <1441486687-4836-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33896 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbbIEU62 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2015 16:58:28 -0400
Received: by wicfx3 with SMTP id fx3so52545116wic.1
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2015 13:58:27 -0700 (PDT)
In-Reply-To: <1441486687-4836-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

on my machine using the x360w pad the irq_out URB is dead after suspend/
resume. This means that neither sending LED nor FF commands works.
The error seems not to be related to the driver as it also occurs when
xpad is not even loaded. The only fix I found is unplugging the
receiver.
Workaround this error by resetting the usb device on resume. Implemented
suspend/ resume callbacks to this end.

Also ensure usb_kill_urb(xpad->irq_out) is called before
usb_free_urb(xpad->irq_out) in xpad_disconnect.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index ae441a2..986db4b 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1230,17 +1230,24 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 
 }
 
+static void xpad_stop_communication(struct usb_xpad *xpad) {
+	xpad_stop_output(xpad);
+
+	if (xpad->xtype == XTYPE_XBOX360W) {
+		usb_kill_urb(xpad->irq_in);
+	}
+}
+
 static void xpad_disconnect(struct usb_interface *intf)
 {
 	struct usb_xpad *xpad = usb_get_intfdata (intf);
 
 	xpad_led_disconnect(xpad);
 	input_unregister_device(xpad->dev);
-	xpad_deinit_output(xpad);
 
-	if (xpad->xtype == XTYPE_XBOX360W) {
-		usb_kill_urb(xpad->irq_in);
-	}
+	xpad_stop_communication(xpad);
+
+	xpad_deinit_output(xpad);
 
 	usb_free_urb(xpad->irq_in);
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
@@ -1251,10 +1258,23 @@ static void xpad_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 }
 
+static int xpad_suspend(struct usb_interface *intf, pm_message_t message) {
+	struct usb_xpad *xpad = usb_get_intfdata (intf);
+	xpad_stop_communication(xpad);
+	return 0;
+}
+
+static int xpad_resume(struct usb_interface *intf) {
+	usb_queue_reset_device(intf);
+	return 0;
+}
+
 static struct usb_driver xpad_driver = {
 	.name		= "xpad",
 	.probe		= xpad_probe,
 	.disconnect	= xpad_disconnect,
+	.suspend 	= xpad_suspend,
+	.resume 	= xpad_resume,
 	.id_table	= xpad_table,
 };
 
-- 
1.9.1

