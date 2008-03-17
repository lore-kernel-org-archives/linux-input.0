From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 3/7] xpad: add more xbox 360 controller ids
Date: Mon, 17 Mar 2008 21:22:53 +0200
Message-ID: <20080317192845.363722569@gmail.com>
References: <20080317192250.208635026@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:53834 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754337AbYCQT3E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2008 15:29:04 -0400
Content-Disposition: inline; filename=xpad-new-xbox360-ids.diff
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Anssi Hannula <anssi.hannula@gmail.com>

Add Mad Catz and 0x0e6f xbox360 controllers which are already found
in xpad_device[] table in xpad.c into the vendor id list. Also add
Logitech into the vendor list for Logitech Chillstream gamepads.
Also add the RedOctane Guitar Hero X-plorer.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/joystick/xpad.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c
===================================================================
--- linux-2.6.25-rc3-mm1-xpad.orig/drivers/input/joystick/xpad.c	2008-03-05 15:24:14.000000000 +0200
+++ linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c	2008-03-06 23:33:41.000000000 +0200
@@ -110,6 +110,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
+	{ 0x046d, 0xc242, "Logitech Chillstream Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
 	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x05fd, 0x1007, "Mad Catz Controller (unverified)", MAP_DPAD_TO_AXES, XTYPE_XBOX },
@@ -136,6 +137,7 @@ static const struct xpad_device {
 	{ 0x0f30, 0x8888, "BigBen XBMiniPad Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x102c, 0xff0c, "Joytech Wireless Advanced Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
+	{ 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
 	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
@@ -188,6 +190,10 @@ static const signed short xpad_abs_pad[]
 static struct usb_device_id xpad_table [] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
 	{ XPAD_XBOX360_VENDOR(0x045e) },	/* Microsoft X-Box 360 controllers */
+	{ XPAD_XBOX360_VENDOR(0x046d) },	/* Logitech X-Box 360 style controllers */
+	{ XPAD_XBOX360_VENDOR(0x0738) },	/* Mad Catz X-Box 360 controllers */
+	{ XPAD_XBOX360_VENDOR(0x0e6f) },	/* 0x0e6f X-Box 360 controllers */
+	{ XPAD_XBOX360_VENDOR(0x1430) },	/* RedOctane X-Box 360 controllers */
 	{ }
 };
 

--
Anssi Hannula
