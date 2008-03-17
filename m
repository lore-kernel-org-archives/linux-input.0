From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 6/7] xpad: drop obsolete driver versioning
Date: Mon, 17 Mar 2008 21:22:56 +0200
Message-ID: <20080317192846.519183597@gmail.com>
References: <20080317192250.208635026@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:53853 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753483AbYCQT2t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2008 15:28:49 -0400
Content-Disposition: inline; filename=xpad-drop-driver-version.diff
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Anssi Hannula <anssi.hannula@gmail.com>

The driver version numbers and changelog have not been updated in a
long while to reflect actual changes. Remove the version number and
add a notice that later changes can be tracked in SCM.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/joystick/xpad.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c
===================================================================
--- linux-2.6.25-rc3-mm1-xpad.orig/drivers/input/joystick/xpad.c	2008-03-06 23:15:14.000000000 +0200
+++ linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c	2008-03-06 23:22:44.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * X-Box gamepad - v0.0.6
+ * X-Box gamepad driver
  *
  * Copyright (c) 2002 Marko Friedemann <mfr@bmx-chemnitz.de>
  *               2004 Oliver Schwartz <Oliver.Schwartz@gmx.de>,
@@ -68,6 +68,8 @@
  *  - dance pads will map D-PAD to buttons, not axes
  *  - pass the module paramater 'dpad_to_buttons' to force
  *    the D-PAD to map to buttons if your pad is not detected
+ *
+ * Later changes can be tracked in SCM.
  */
 
 #include <linux/kernel.h>
@@ -77,7 +79,6 @@
 #include <linux/module.h>
 #include <linux/usb/input.h>
 
-#define DRIVER_VERSION "v0.0.6"
 #define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
 #define DRIVER_DESC "X-Box pad driver"
 
@@ -769,7 +770,7 @@ static int __init usb_xpad_init(void)
 {
 	int result = usb_register(&xpad_driver);
 	if (result == 0)
-		info(DRIVER_DESC ":" DRIVER_VERSION);
+		info(DRIVER_DESC);
 	return result;
 }
 

--
Anssi Hannula
