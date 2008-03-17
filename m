From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 4/7] xpad: do not report nonexistent buttons for xbox360
Date: Mon, 17 Mar 2008 21:22:54 +0200
Message-ID: <20080317192845.727304310@gmail.com>
References: <20080317192250.208635026@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:53834 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754337AbYCQT3C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2008 15:29:02 -0400
Content-Disposition: inline; filename=xpad-do-not-report-nonexistent-buttons.diff
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Anssi Hannula <anssi.hannula@gmail.com>

The buttons BTN_C and BTN_Z are only used in the original xbox
controller, not in xbox360 controller. Therefore only add them to
keybit when the controller is a non-360 one.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/joystick/xpad.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

Index: linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c
===================================================================
--- linux-2.6.25-rc3-mm1-xpad.orig/drivers/input/joystick/xpad.c	2008-03-05 02:17:49.000000000 +0200
+++ linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c	2008-03-05 02:25:29.000000000 +0200
@@ -142,12 +142,19 @@ static const struct xpad_device {
 	{ 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_UNKNOWN, XTYPE_UNKNOWN }
 };
 
-static const signed short xpad_btn[] = {
-	BTN_A, BTN_B, BTN_C, BTN_X, BTN_Y, BTN_Z,	/* "analog" buttons */
+/* buttons shared with xbox and xbox360 */
+static const signed short xpad_common_btn[] = {
+	BTN_A, BTN_B, BTN_X, BTN_Y,			/* "analog" buttons */
 	BTN_START, BTN_BACK, BTN_THUMBL, BTN_THUMBR,	/* start/back/sticks */
 	-1						/* terminating entry */
 };
 
+/* original xbox controllers only */
+static const signed short xpad_btn[] = {
+	BTN_C, BTN_Z,		/* "analog" buttons */
+	-1			/* terminating entry */
+};
+
 /* only used if MAP_DPAD_TO_BUTTONS */
 static const signed short xpad_btn_pad[] = {
 	BTN_LEFT, BTN_RIGHT,		/* d-pad left, right */
@@ -676,11 +683,14 @@ static int xpad_probe(struct usb_interfa
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 
 	/* set up buttons */
-	for (i = 0; xpad_btn[i] >= 0; i++)
-		set_bit(xpad_btn[i], input_dev->keybit);
+	for (i = 0; xpad_common_btn[i] >= 0; i++)
+		set_bit(xpad_common_btn[i], input_dev->keybit);
 	if (xpad->xtype == XTYPE_XBOX360)
 		for (i = 0; xpad360_btn[i] >= 0; i++)
 			set_bit(xpad360_btn[i], input_dev->keybit);
+	else
+		for (i = 0; xpad_btn[i] >= 0; i++)
+			set_bit(xpad_btn[i], input_dev->keybit);
 	if (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS)
 		for (i = 0; xpad_btn_pad[i] >= 0; i++)
 			set_bit(xpad_btn_pad[i], input_dev->keybit);

--
Anssi Hannula
