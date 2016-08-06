From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 2/3] Input: xpad - fix One S pad disconnecting when not opened
Date: Sat,  6 Aug 2016 14:30:29 -0700
Message-ID: <1470519030-23051-3-git-send-email-aicommander@gmail.com>
References: <1470519030-23051-1-git-send-email-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36106 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbcHFVad (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Aug 2016 17:30:33 -0400
Received: by mail-pa0-f68.google.com with SMTP id ez1so21353264pab.3
        for <linux-input@vger.kernel.org>; Sat, 06 Aug 2016 14:30:33 -0700 (PDT)
In-Reply-To: <1470519030-23051-1-git-send-email-aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org

The Xbox One S controller will hang after ~2 seconds of input
if it isn't being read by the OS. After another ~5 seconds the
controller will reset itself and reconnect to the host.

To avoid this, we'll just read Xbox One controllers all the time,
like we do for Xbox 360 wireless adapters.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 19886db..6a3a775 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1381,7 +1381,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
 
 	input_set_drvdata(input_dev, xpad);
 
-	if (xpad->xtype != XTYPE_XBOX360W) {
+	if (xpad->xtype != XTYPE_XBOX360W && xpad->xtype != XTYPE_XBOXONE) {
 		input_dev->open = xpad_open;
 		input_dev->close = xpad_close;
 	}
@@ -1573,9 +1573,20 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		error = xpad_init_input(xpad);
 		if (error)
 			goto err_deinit_output;
+
+		/* Newer Xbox One controllers will hang and disconnect if
+		 * not initialized and read from when receiving user input.
+		 */
+		if (xpad->xtype == XTYPE_XBOXONE) {
+			error = xpad_start_input(xpad);
+			if (error)
+				goto err_deinit_input;
+		}
 	}
 	return 0;
 
+err_deinit_input:
+	xpad_deinit_input(xpad);
 err_deinit_output:
 	xpad_deinit_output(xpad);
 err_free_in_urb:
@@ -1593,6 +1604,8 @@ static void xpad_disconnect(struct usb_interface *intf)
 
 	if (xpad->xtype == XTYPE_XBOX360W)
 		xpad360w_stop_input(xpad);
+	else if (xpad->xtype == XTYPE_XBOXONE)
+		xpad_stop_input(xpad);
 
 	xpad_deinit_input(xpad);
 
@@ -1636,7 +1649,7 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 			xpad360w_poweroff_controller(xpad);
 	} else {
 		mutex_lock(&input->mutex);
-		if (input->users)
+		if (input->users || xpad->xtype == XTYPE_XBOXONE)
 			xpad_stop_input(xpad);
 		mutex_unlock(&input->mutex);
 	}
@@ -1656,7 +1669,7 @@ static int xpad_resume(struct usb_interface *intf)
 		retval = xpad360w_start_input(xpad);
 	} else {
 		mutex_lock(&input->mutex);
-		if (input->users)
+		if (input->users || xpad->xtype == XTYPE_XBOXONE)
 			retval = xpad_start_input(xpad);
 		mutex_unlock(&input->mutex);
 	}
-- 
2.7.4

