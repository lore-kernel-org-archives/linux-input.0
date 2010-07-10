From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] Input: xpad - remove mouse buttons and axes for dance pads
Date: Sat, 10 Jul 2010 15:25:58 +0200
Message-ID: <1278768358.3018.2.camel@lovely.krouter>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49499 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001Ab0GJNZK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Jul 2010 09:25:10 -0400
Received: by bwz1 with SMTP id 1so1637490bwz.19
        for <linux-input@vger.kernel.org>; Sat, 10 Jul 2010 06:25:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nicolas =?ISO-8859-1?Q?L=E9veill=E9?= <nicolas@uucidl.com>, Benjamin Valentin <benpicco@zedat.fu-berlin.de>, Anssi Hannula <anssi.hannula@iki.fi>, Michael Gruber <lists.mg@googlemail.com>, linux-input@vger.kernel.org

Dance pads don't have any axes/sticks, only buttons for directions. For
example buttons like left+right will get triggered at once, an axis
can't handle this anyway.  So this patch adds a module parameter named
"sticks_to_null" for unknown devices. A known dance pad makes use of
it by changing to a new mapping-option named DANCEPAD_MAP_CONFIG. Other
tested devices may follow by adding this mapping-option too.

Some buttons of xpad-devices are addressing mouse-buttons instead of
gamepad-buttons. This gets fixed too.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/input/joystick/xpad.c |  107 ++++++++++++++++++++++++-----------------
 1 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index c1087ce..6b2933d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -9,6 +9,7 @@
  *               2005 Dominic Cerquetti <binary1230@yahoo.com>
  *               2006 Adam Buchbinder <adam.buchbinder@gmail.com>
  *               2007 Jan Kratochvil <honza@jikos.cz>
+ *               2010 Christoph Fritz <chf.fritz@googlemail.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -88,6 +89,9 @@
    but we map them to axes when possible to simplify things */
 #define MAP_DPAD_TO_BUTTONS		(1 << 0)
 #define MAP_TRIGGERS_TO_BUTTONS		(1 << 1)
+#define MAP_STICKS_TO_NULL		(1 << 2)
+#define DANCEPAD_MAP_CONFIG	(MAP_DPAD_TO_BUTTONS |			\
+				MAP_TRIGGERS_TO_BUTTONS | MAP_STICKS_TO_NULL)
 
 #define XTYPE_XBOX        0
 #define XTYPE_XBOX360     1
@@ -102,6 +106,10 @@ static int triggers_to_buttons;
 module_param(triggers_to_buttons, bool, S_IRUGO);
 MODULE_PARM_DESC(triggers_to_buttons, "Map triggers to buttons rather than axes for unknown pads");
 
+static int sticks_to_null;
+module_param(sticks_to_null, bool, S_IRUGO);
+MODULE_PARM_DESC(sticks_to_null, "Do not map sticks at all for unknown pads");
+
 static const struct xpad_device {
 	u16 idVendor;
 	u16 idProduct;
@@ -114,7 +122,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
-	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
+	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", DANCEPAD_MAP_CONFIG, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
 	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", 0, XTYPE_XBOX },
@@ -158,7 +166,7 @@ static const struct xpad_device {
 /* buttons shared with xbox and xbox360 */
 static const signed short xpad_common_btn[] = {
 	BTN_A, BTN_B, BTN_X, BTN_Y,			/* "analog" buttons */
-	BTN_START, BTN_BACK, BTN_THUMBL, BTN_THUMBR,	/* start/back/sticks */
+	BTN_START, BTN_SELECT, BTN_THUMBL, BTN_THUMBR,	/* start/back/sticks */
 	-1						/* terminating entry */
 };
 
@@ -168,10 +176,10 @@ static const signed short xpad_btn[] = {
 	-1			/* terminating entry */
 };
 
-/* used when dpad is mapped to nuttons */
+/* used when dpad is mapped to buttons */
 static const signed short xpad_btn_pad[] = {
-	BTN_LEFT, BTN_RIGHT,		/* d-pad left, right */
-	BTN_0, BTN_1,			/* d-pad up, down (XXX names??) */
+	BTN_TRIGGER_HAPPY1, BTN_TRIGGER_HAPPY2,		/* d-pad left, right */
+	BTN_TRIGGER_HAPPY3, BTN_TRIGGER_HAPPY4,		/* d-pad up, down */
 	-1				/* terminating entry */
 };
 
@@ -279,17 +287,19 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 {
 	struct input_dev *dev = xpad->dev;
 
-	/* left stick */
-	input_report_abs(dev, ABS_X,
-			 (__s16) le16_to_cpup((__le16 *)(data + 12)));
-	input_report_abs(dev, ABS_Y,
-			 ~(__s16) le16_to_cpup((__le16 *)(data + 14)));
-
-	/* right stick */
-	input_report_abs(dev, ABS_RX,
-			 (__s16) le16_to_cpup((__le16 *)(data + 16)));
-	input_report_abs(dev, ABS_RY,
-			 ~(__s16) le16_to_cpup((__le16 *)(data + 18)));
+	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
+		/* left stick */
+		input_report_abs(dev, ABS_X,
+				 (__s16) le16_to_cpup((__le16 *)(data + 12)));
+		input_report_abs(dev, ABS_Y,
+				 ~(__s16) le16_to_cpup((__le16 *)(data + 14)));
+
+		/* right stick */
+		input_report_abs(dev, ABS_RX,
+				 (__s16) le16_to_cpup((__le16 *)(data + 16)));
+		input_report_abs(dev, ABS_RY,
+				 ~(__s16) le16_to_cpup((__le16 *)(data + 18)));
+	}
 
 	/* triggers left/right */
 	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
@@ -302,10 +312,11 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 
 	/* digital pad */
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
-		input_report_key(dev, BTN_LEFT,  data[2] & 0x04);
-		input_report_key(dev, BTN_RIGHT, data[2] & 0x08);
-		input_report_key(dev, BTN_0,     data[2] & 0x01); /* up */
-		input_report_key(dev, BTN_1,     data[2] & 0x02); /* down */
+		/* dpad as buttons (left, right, up, down) */
+		input_report_key(dev, BTN_TRIGGER_HAPPY1, data[2] & 0x04);
+		input_report_key(dev, BTN_TRIGGER_HAPPY2, data[2] & 0x08);
+		input_report_key(dev, BTN_TRIGGER_HAPPY3, data[2] & 0x01);
+		input_report_key(dev, BTN_TRIGGER_HAPPY4, data[2] & 0x02);
 	} else {
 		input_report_abs(dev, ABS_HAT0X,
 				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
@@ -315,7 +326,7 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 
 	/* start/back buttons and stick press left/right */
 	input_report_key(dev, BTN_START,  data[2] & 0x10);
-	input_report_key(dev, BTN_BACK,   data[2] & 0x20);
+	input_report_key(dev, BTN_SELECT, data[2] & 0x20);
 	input_report_key(dev, BTN_THUMBL, data[2] & 0x40);
 	input_report_key(dev, BTN_THUMBR, data[2] & 0x80);
 
@@ -349,11 +360,11 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 
 	/* digital pad */
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
-		/* dpad as buttons (right, left, down, up) */
-		input_report_key(dev, BTN_LEFT, data[2] & 0x04);
-		input_report_key(dev, BTN_RIGHT, data[2] & 0x08);
-		input_report_key(dev, BTN_0, data[2] & 0x01);	/* up */
-		input_report_key(dev, BTN_1, data[2] & 0x02);	/* down */
+		/* dpad as buttons (left, right, up, down) */
+		input_report_key(dev, BTN_TRIGGER_HAPPY1, data[2] & 0x04);
+		input_report_key(dev, BTN_TRIGGER_HAPPY2, data[2] & 0x08);
+		input_report_key(dev, BTN_TRIGGER_HAPPY3, data[2] & 0x01);
+		input_report_key(dev, BTN_TRIGGER_HAPPY4, data[2] & 0x02);
 	} else {
 		input_report_abs(dev, ABS_HAT0X,
 				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
@@ -363,7 +374,7 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 
 	/* start/back buttons */
 	input_report_key(dev, BTN_START,  data[2] & 0x10);
-	input_report_key(dev, BTN_BACK,   data[2] & 0x20);
+	input_report_key(dev, BTN_SELECT, data[2] & 0x20);
 
 	/* stick press left/right */
 	input_report_key(dev, BTN_THUMBL, data[2] & 0x40);
@@ -378,17 +389,19 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 	input_report_key(dev, BTN_TR,	data[3] & 0x02);
 	input_report_key(dev, BTN_MODE,	data[3] & 0x04);
 
-	/* left stick */
-	input_report_abs(dev, ABS_X,
-			 (__s16) le16_to_cpup((__le16 *)(data + 6)));
-	input_report_abs(dev, ABS_Y,
-			 ~(__s16) le16_to_cpup((__le16 *)(data + 8)));
-
-	/* right stick */
-	input_report_abs(dev, ABS_RX,
-			 (__s16) le16_to_cpup((__le16 *)(data + 10)));
-	input_report_abs(dev, ABS_RY,
-			 ~(__s16) le16_to_cpup((__le16 *)(data + 12)));
+	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
+		/* left stick */
+		input_report_abs(dev, ABS_X,
+				 (__s16) le16_to_cpup((__le16 *)(data + 6)));
+		input_report_abs(dev, ABS_Y,
+				 ~(__s16) le16_to_cpup((__le16 *)(data + 8)));
+
+		/* right stick */
+		input_report_abs(dev, ABS_RX,
+				 (__s16) le16_to_cpup((__le16 *)(data + 10)));
+		input_report_abs(dev, ABS_RY,
+				 ~(__s16) le16_to_cpup((__le16 *)(data + 12)));
+	}
 
 	/* triggers left/right */
 	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
@@ -814,6 +827,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 			xpad->mapping |= MAP_DPAD_TO_BUTTONS;
 		if (triggers_to_buttons)
 			xpad->mapping |= MAP_TRIGGERS_TO_BUTTONS;
+		if (sticks_to_null)
+			xpad->mapping |= MAP_STICKS_TO_NULL;
 	}
 
 	xpad->dev = input_dev;
@@ -830,16 +845,20 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	input_dev->open = xpad_open;
 	input_dev->close = xpad_close;
 
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	if (xpad->mapping & MAP_STICKS_TO_NULL) {
+		input_dev->evbit[0] = BIT_MASK(EV_KEY);
+	} else {
+		input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+		/* set up axes */
+		for (i = 0; xpad_abs[i] >= 0; i++)
+			xpad_set_up_abs(input_dev, xpad_abs[i]);
+	}
 
-	/* set up standard buttons and axes */
+	/* set up standard buttons */
 	for (i = 0; xpad_common_btn[i] >= 0; i++)
 		__set_bit(xpad_common_btn[i], input_dev->keybit);
 
-	for (i = 0; xpad_abs[i] >= 0; i++)
-		xpad_set_up_abs(input_dev, xpad_abs[i]);
-
-	/* Now set up model-specific ones */
+	/* set up model-specific ones */
 	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX360W) {
 		for (i = 0; xpad360_btn[i] >= 0; i++)
 			__set_bit(xpad360_btn[i], input_dev->keybit);
-- 
1.7.1




