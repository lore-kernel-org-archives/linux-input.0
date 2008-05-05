From: "Michael Gruber" <backup.mg@gmx.de>
Subject: [PATCH 2/2] xpad - Allow mapping triggers to buttons
Date: Mon, 05 May 2008 12:34:43 +0200
Message-ID: <20080505103443.266050@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39861 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752935AbYEEKep (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 May 2008 06:34:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

From: Michael Gruber <lists.mg@googlemail.com>

If the new module option triggers_to_buttons is set, the two analog shoulder
triggers will be mapped to 2buttons instead of 2axes for all controllers.

Signed-off-by: Michael Gruber <lists.mg@googlemail.com>

---

A lot of Xbox360 games use LT and RT just like digital buttons, usually for
important commands like attack. Linux users should have access to the same
functionality.

 Documentation/input/xpad.txt  |    3 ++
 drivers/input/joystick/xpad.c |   40 ++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 5 deletions(-)

--- a/Documentation/input/xpad.txt	2008-04-30 20:02:35.000000000 +0200
+++ b/Documentation/input/xpad.txt	2008-05-01 00:09:46.000000000 +0200
@@ -29,6 +29,9 @@ dpad_to_buttons has no effect for known 
 d-pad mapping to use buttons instead of axes for a known controller you
 should set force_dpad_to_buttons to Y. The default is N.
 
+You can also map the two analog shoulder triggers to digital buttons by
+setting triggers_to_buttons to Y. The default is N.
+
 0.1 Normal Controllers
 ----------------------
 With a normal controller, the directional pad is mapped to its own X/Y axes.
--- a/drivers/input/joystick/xpad.c	2008-04-30 20:02:35.000000000 +0200
+++ b/drivers/input/joystick/xpad.c	2008-04-30 20:34:02.000000000 +0200
@@ -101,6 +101,9 @@ MODULE_PARM_DESC(dpad_to_buttons, "Map D
 static int force_dpad_to_buttons;
 module_param(force_dpad_to_buttons, bool, S_IRUGO);
 MODULE_PARM_DESC(force_dpad_to_buttons, "Map D-PAD to buttons rather than axes for all pads");
+static int triggers_to_buttons;
+module_param(triggers_to_buttons, bool, S_IRUGO);
+MODULE_PARM_DESC(triggers_to_buttons, "Map triggers to buttons rather than axes for all pads");
 
 static const struct xpad_device {
 	u16 idVendor;
@@ -176,10 +179,15 @@ static const signed short xpad360_btn[] 
 	-1
 };
 
+/* only used if triggers_to_buttons is set */
+static const signed short xpad_btn_trigger[] = {
+	BTN_TL2, BTN_TR2,	/* triggers left/right */
+	-1			/* terminating entry */
+};
+
 static const signed short xpad_abs[] = {
 	ABS_X, ABS_Y,		/* left stick */
 	ABS_RX, ABS_RY,		/* right stick */
-	ABS_Z, ABS_RZ,		/* triggers left/right */
 	-1			/* terminating entry */
 };
 
@@ -189,6 +197,12 @@ static const signed short xpad_abs_pad[]
 	-1			/* terminating entry */
 };
 
+/* only used if triggers_to_buttons is not set */
+static const signed short xpad_abs_trigger[] = {
+	ABS_Z, ABS_RZ,		/* triggers left/right */
+	-1			/* terminating entry */
+};
+
 /* Xbox 360 has a vendor-specific class, so we cannot match it with only
  * USB_INTERFACE_INFO (also specifically refused by USB subsystem), so we
  * match against vendor id as well. Wired Xbox 360 devices have protocol 1,
@@ -272,8 +286,13 @@ static void xpad_process_packet(struct u
 			 ~(__s16) le16_to_cpup((__le16 *)(data + 18)));
 
 	/* triggers left/right */
-	input_report_abs(dev, ABS_Z, data[10]);
-	input_report_abs(dev, ABS_RZ, data[11]);
+	if (triggers_to_buttons) {
+		input_report_key(dev, BTN_TL2, data[10] > 0x50);
+		input_report_key(dev, BTN_TR2, data[11] > 0x50);
+	} else {
+		input_report_abs(dev, ABS_Z,  data[10]);
+		input_report_abs(dev, ABS_RZ, data[11]);
+	}
 
 	/* digital pad */
 	if (xpad->dpad_mapping == MAP_DPAD_TO_AXES) {
@@ -366,8 +385,13 @@ static void xpad360_process_packet(struc
 			 ~(__s16) le16_to_cpup((__le16 *)(data + 12)));
 
 	/* triggers left/right */
-	input_report_abs(dev, ABS_Z, data[4]);
-	input_report_abs(dev, ABS_RZ, data[5]);
+	if (triggers_to_buttons) {
+		input_report_key(dev, BTN_TL2, data[4] > 0x50);
+		input_report_key(dev, BTN_TR2, data[5] > 0x50);
+	} else {
+		input_report_abs(dev, ABS_Z,  data[4]);
+		input_report_abs(dev, ABS_RZ, data[5]);
+	}
 
 	input_sync(dev);
 }
@@ -786,6 +810,9 @@ static int xpad_probe(struct usb_interfa
 	if (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS)
 		for (i = 0; xpad_btn_pad[i] >= 0; i++)
 			set_bit(xpad_btn_pad[i], input_dev->keybit);
+	if (triggers_to_buttons)
+		for (i = 0; xpad_btn_trigger[i] >= 0; i++)
+			set_bit(xpad_btn_trigger[i], input_dev->keybit);
 
 	/* set up axes */
 	for (i = 0; xpad_abs[i] >= 0; i++)
@@ -793,6 +820,9 @@ static int xpad_probe(struct usb_interfa
 	if (xpad->dpad_mapping == MAP_DPAD_TO_AXES)
 		for (i = 0; xpad_abs_pad[i] >= 0; i++)
 		    xpad_set_up_abs(input_dev, xpad_abs_pad[i]);
+	if (!triggers_to_buttons)
+		for (i = 0; xpad_abs_trigger[i] >= 0; i++)
+		    xpad_set_up_abs(input_dev, xpad_abs_trigger[i]);
 
 	error = xpad_init_output(intf, xpad);
 	if (error)

-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
