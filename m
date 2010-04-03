From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 2/2] xpad: use joystick instead of mouse buttons
Date: Sun, 04 Apr 2010 01:14:20 +0200
Message-ID: <1270336460.4282.5.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:50565 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab0DCXJ0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Apr 2010 19:09:26 -0400
Received: by fg-out-1718.google.com with SMTP id d23so23567fga.1
        for <linux-input@vger.kernel.org>; Sat, 03 Apr 2010 16:09:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dominic Cerquetti <binary1230@yahoo.com>, Jan Kratochvil <honza@jikos.cz>

Let's dance with red octane on strange hardware:
 - don't use mouse buttons
 - add handling of dance pad 'MAP_REDOCTANE_DPAD'


Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/input/joystick/xpad.c |   78 ++++++++++++++++++++++++++++++++---------
 1 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 9b3353b..7912ffb 100644
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
@@ -69,6 +70,11 @@
  *  - pass the module paramater 'dpad_to_buttons' to force
  *    the D-PAD to map to buttons if your pad is not detected
  *
+ * 2010-04-03 - 0.0.7 : no mousebuttons
+ *  - dance pads use extended gamepad buttons BTN_TRIGGER_HAPPY
+ *    instead of mouse buttons
+ *  - correct handling of dance pad 'MAP_REDOCTANE_DPAD'
+ *
  * Later changes can be tracked in SCM.
  */
 
@@ -87,7 +93,8 @@
 /* xbox d-pads should map to buttons, as is required for DDR pads
    but we map them to axes when possible to simplify things */
 #define MAP_DPAD_TO_BUTTONS		(1 << 0)
-#define MAP_TRIGGERS_TO_BUTTONS		(1 << 1)
+#define MAP_TRIGGERS_TO_BUTTONS	(1 << 1)
+#define MAP_REDOCTANE_DPAD		(1 << 2)
 
 #define XTYPE_XBOX        0
 #define XTYPE_XBOX360     1
@@ -114,7 +121,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
-	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
+	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_REDOCTANE_DPAD, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
 	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", 0, XTYPE_XBOX },
@@ -158,7 +165,7 @@ static const struct xpad_device {
 /* buttons shared with xbox and xbox360 */
 static const signed short xpad_common_btn[] = {
 	BTN_A, BTN_B, BTN_X, BTN_Y,			/* "analog" buttons */
-	BTN_START, BTN_BACK, BTN_THUMBL, BTN_THUMBR,	/* start/back/sticks */
+	BTN_START, BTN_SELECT, BTN_THUMBL, BTN_THUMBR,	/* start/back/sticks */
 	-1						/* terminating entry */
 };
 
@@ -168,10 +175,10 @@ static const signed short xpad_btn[] = {
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
 
@@ -206,6 +213,14 @@ static const signed short xpad_abs_triggers[] = {
 	-1
 };
 
+/* used for "RedOctane Xbox Dance Pad" */
+static const signed short xpad_redoxdpad[] = {
+	BTN_A, BTN_B, BTN_X, BTN_Y,
+	BTN_START, BTN_SELECT,
+	BTN_C, BTN_Z, BTN_TL, BTN_TR,		/* up,down,left,right */
+	-1
+};
+
 /* Xbox 360 has a vendor-specific class, so we cannot match it with only
  * USB_INTERFACE_INFO (also specifically refused by USB subsystem), so we
  * match against vendor id as well. Wired Xbox 360 devices have protocol 1,
@@ -279,6 +294,24 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 {
 	struct input_dev *dev = xpad->dev;
 
+	/* process special model */
+	if (xpad->mapping & MAP_REDOCTANE_DPAD) {
+		input_report_key(dev, BTN_A,      data[4]);
+		input_report_key(dev, BTN_B,      data[5]);
+		input_report_key(dev, BTN_X,      data[6]);
+		input_report_key(dev, BTN_Y,      data[7]);
+		input_report_key(dev, BTN_C,      data[2] & 0x01); /* up */
+		input_report_key(dev, BTN_Z,      data[2] & 0x02); /* down */
+		input_report_key(dev, BTN_TL,     data[2] & 0x04); /* left */
+		input_report_key(dev, BTN_TR,     data[2] & 0x08); /* right */
+		input_report_key(dev, BTN_START,  data[2] & 0x10);
+		input_report_key(dev, BTN_SELECT, data[2] & 0x20); /* back */
+		input_sync(dev);
+		return;
+	}
+
+	/* process generic models */
+
 	/* left stick */
 	input_report_abs(dev, ABS_X,
 			 (__s16) le16_to_cpup((__le16 *)(data + 12)));
@@ -302,10 +335,10 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 
 	/* digital pad */
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
-		input_report_key(dev, BTN_LEFT,  data[2] & 0x04);
-		input_report_key(dev, BTN_RIGHT, data[2] & 0x08);
-		input_report_key(dev, BTN_0,     data[2] & 0x01); /* up */
-		input_report_key(dev, BTN_1,     data[2] & 0x02); /* down */
+		input_report_key(dev, BTN_TRIGGER_HAPPY1, data[2] & 0x04); /* left */
+		input_report_key(dev, BTN_TRIGGER_HAPPY2, data[2] & 0x08); /* right */
+		input_report_key(dev, BTN_TRIGGER_HAPPY3, data[2] & 0x01); /* up */
+		input_report_key(dev, BTN_TRIGGER_HAPPY4, data[2] & 0x02); /* down */
 	} else {
 		input_report_abs(dev, ABS_HAT0X,
 				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
@@ -315,7 +348,7 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 
 	/* start/back buttons and stick press left/right */
 	input_report_key(dev, BTN_START,  data[2] & 0x10);
-	input_report_key(dev, BTN_BACK,   data[2] & 0x20);
+	input_report_key(dev, BTN_SELECT, data[2] & 0x20);
 	input_report_key(dev, BTN_THUMBL, data[2] & 0x40);
 	input_report_key(dev, BTN_THUMBR, data[2] & 0x80);
 
@@ -349,11 +382,11 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 
 	/* digital pad */
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
-		/* dpad as buttons (right, left, down, up) */
-		input_report_key(dev, BTN_LEFT, data[2] & 0x04);
-		input_report_key(dev, BTN_RIGHT, data[2] & 0x08);
-		input_report_key(dev, BTN_0, data[2] & 0x01);	/* up */
-		input_report_key(dev, BTN_1, data[2] & 0x02);	/* down */
+		/* dpad as buttons (left, right, up, down) */
+		input_report_key(dev, BTN_TRIGGER_HAPPY1, data[2] & 0x04); /* left */
+		input_report_key(dev, BTN_TRIGGER_HAPPY2, data[2] & 0x08); /* right */
+		input_report_key(dev, BTN_TRIGGER_HAPPY3, data[2] & 0x01); /* up */
+		input_report_key(dev, BTN_TRIGGER_HAPPY4, data[2] & 0x02); /* down */
 	} else {
 		input_report_abs(dev, ABS_HAT0X,
 				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
@@ -363,7 +396,7 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 
 	/* start/back buttons */
 	input_report_key(dev, BTN_START,  data[2] & 0x10);
-	input_report_key(dev, BTN_BACK,   data[2] & 0x20);
+	input_report_key(dev, BTN_SELECT, data[2] & 0x20);
 
 	/* stick press left/right */
 	input_report_key(dev, BTN_THUMBL, data[2] & 0x40);
@@ -830,6 +863,15 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	input_dev->open = xpad_open;
 	input_dev->close = xpad_close;
 
+
+	/* special model set up */
+	if (xpad->mapping & MAP_REDOCTANE_DPAD) {
+		input_dev->evbit[0] = BIT_MASK(EV_KEY);
+		for (i = 0; xpad_redoxdpad[i] >= 0; i++)
+			__set_bit(xpad_redoxdpad[i], input_dev->keybit);
+		goto input_register;
+	}
+
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 
 	/* set up standard buttons and axes */
@@ -864,6 +906,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
 	}
 
+ input_register:
+
 	error = xpad_init_output(intf, xpad);
 	if (error)
 		goto fail2;
-- 
1.5.6.5



