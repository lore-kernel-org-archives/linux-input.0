From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 1/7] xpad: fix dpad handling of unknown devices
Date: Mon, 17 Mar 2008 21:22:51 +0200
Message-ID: <20080317192844.062733658@gmail.com>
References: <20080317192250.208635026@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:43376 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753164AbYCQT27 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2008 15:28:59 -0400
Content-Disposition: inline; filename=xpad-fix-unknown-dpad-handling.diff
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Anssi Hannula <anssi.hannula@gmail.com>

For devices not specifically listed in xpad.c, xpad->dpad_mapping
is initially set to MAP_DPAD_UNKNOWN. In xpad_probe() it gets changed
to either MAP_DPAD_TO_BUTTONS or MAP_DPAD_TO_AXES, depending on the 
module parameter dpad_to_buttons.

However, MAP_DPAD_UNKNOWN is defined as -1, while the field is u8.
This results in actual value of 255, causing the MAP_DPAD_UNKNOWN
check in xpad_probe() to fail.
Fix that by defining MAP_DPAD_UNKNOWN as 2 instead.

Also, setting module parameter dpad_to_buttons to 1 should obviously
map dpad to buttons, while the default behaviour (0) should be to map
dpad to axes. However, dpad_to_buttons is directly assigned to
xpad->dpad_mapping, and as MAP_DPAD_TO_BUTTONS is 0, the actual
behaviour is reversed.
Fix that by negating dpad_to_buttons in assignment.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/joystick/xpad.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c
===================================================================
--- linux-2.6.25-rc3-mm1-xpad.orig/drivers/input/joystick/xpad.c	2008-03-05 01:48:17.000000000 +0200
+++ linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c	2008-03-05 01:52:52.000000000 +0200
@@ -87,7 +87,7 @@
    but we map them to axes when possible to simplify things */
 #define MAP_DPAD_TO_BUTTONS    0
 #define MAP_DPAD_TO_AXES       1
-#define MAP_DPAD_UNKNOWN       -1
+#define MAP_DPAD_UNKNOWN       2
 
 #define XTYPE_XBOX        0
 #define XTYPE_XBOX360     1
@@ -653,7 +653,7 @@ static int xpad_probe(struct usb_interfa
 	xpad->dpad_mapping = xpad_device[i].dpad_mapping;
 	xpad->xtype = xpad_device[i].xtype;
 	if (xpad->dpad_mapping == MAP_DPAD_UNKNOWN)
-		xpad->dpad_mapping = dpad_to_buttons;
+		xpad->dpad_mapping = !dpad_to_buttons;
 	if (xpad->xtype == XTYPE_UNKNOWN)
 		xpad->xtype = (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC);
 	xpad->dev = input_dev;

--
Anssi Hannula
