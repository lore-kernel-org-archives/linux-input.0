From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 14/15] Input: xpad: workaround dead irq_out after suspend/ resume
Date: Thu,  1 Oct 2015 22:57:25 +0200
Message-ID: <1443733046-29610-15-git-send-email-rojtberg@gmail.com>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38467 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933058AbbJAU5w (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 16:57:52 -0400
Received: by wiclk2 with SMTP id lk2so6355305wic.1
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2015 13:57:51 -0700 (PDT)
In-Reply-To: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
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
 drivers/input/joystick/xpad.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index cd0718a..9490d96 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1419,33 +1419,53 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
 	ida_remove(&xpad_pad_seq, xpad->pad_nr);
 }
 
+static void xpad_stop_communication(struct usb_xpad *xpad) {
+	xpad_stop_output(xpad);
+
+	if (xpad->xtype == XTYPE_XBOX360W) {
+		usb_kill_urb(xpad->irq_in);
+	}
+
+	cancel_work_sync(&xpad->work);
+}
+
 static void xpad_disconnect(struct usb_interface *intf)
 {
 	struct usb_xpad *xpad = usb_get_intfdata (intf);
 
 	if (xpad->pad_present)
 		xpad_deinit_input(xpad);
-	xpad_deinit_output(xpad);
 
-	if (xpad->xtype == XTYPE_XBOX360W) {
-		usb_kill_urb(xpad->irq_in);
-	}
+	xpad_stop_communication(xpad);
+
+	xpad_deinit_output(xpad);
 
 	usb_free_urb(xpad->irq_in);
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 			xpad->idata, xpad->idata_dma);
 
-	cancel_work_sync(&xpad->work);
-
 	kfree(xpad);
 
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

