From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 4/5] Input: xpad: workaround dead irq_out after suspend/ resume
Date: Sun,  1 Nov 2015 16:31:38 +0100
Message-ID: <1446391899-24250-5-git-send-email-rojtberg@gmail.com>
References: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33894 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKAPb5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Nov 2015 10:31:57 -0500
Received: by wmff134 with SMTP id f134so41619700wmf.1
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2015 07:31:56 -0800 (PST)
In-Reply-To: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

the irq_out urb is dead after suspend/ resume on my x360 wr pad. (also
reproduced by Zachary Lund [0]) Work around this by resetting the usb
device on resume. Added suspend/ resume callbacks to do so.

[0]: https://github.com/paroj/xpad/issues/6

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f3754c7..e8dcc80 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1423,17 +1423,23 @@ err_free_mem:
 
 }
 
-static void xpad_disconnect(struct usb_interface *intf)
+static void xpad_stop_communication(struct usb_xpad *xpad)
 {
-	struct usb_xpad *xpad = usb_get_intfdata (intf);
-
-	xpad_deinit_output(xpad);
+	xpad_stop_output(xpad);
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
 		usb_kill_urb(xpad->irq_in);
 	}
 
 	cancel_work_sync(&xpad->work);
+}
+
+static void xpad_disconnect(struct usb_interface *intf)
+{
+	struct usb_xpad *xpad = usb_get_intfdata(intf);
+
+	xpad_stop_communication(xpad);
+	xpad_deinit_output(xpad);
 
 	if (xpad->pad_present)
 		xpad_deinit_input(xpad);
@@ -1447,10 +1453,26 @@ static void xpad_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 }
 
+static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct usb_xpad *xpad = usb_get_intfdata(intf);
+
+	xpad_stop_communication(xpad);
+	return 0;
+}
+
+static int xpad_resume(struct usb_interface *intf)
+{
+	usb_queue_reset_device(intf);
+	return 0;
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
 
-- 
1.9.1

