From: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Subject: [PATCH] Linux Force Feedback for Saitek Cyborg Evo Force
Date: Mon, 21 Dec 2009 12:45:20 +0100
Message-ID: <4B2F5FD0.10301@physik.uni-muenchen.de>
References: <4B26B824.8010403@physik.uni-muenchen.de> <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz> <4B2ABC62.2030600@physik.uni-muenchen.de> <alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz> <20091218175046.GB23450@core.coreip.homeip.net> <4B2D6377.1020703@physik.uni-muenchen.de> <20091221074419.GD3234@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030603000804030208040106"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:58505 "EHLO
	mail.physik.uni-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754AbZLULpX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2009 06:45:23 -0500
In-Reply-To: <20091221074419.GD3234@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------030603000804030208040106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I am doing this for the first time - I hope I got it correctly.

Cheers,
Johannes

--------------030603000804030208040106
Content-Type: text/x-patch;
 name="saitekff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="saitekff.patch"

This patch adds support for the Saitek Cyborg Evo Force Joystick to the iforce driver

From: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Signed-off-by: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>

diff -ru drivers/input/joystick/iforce_orig/iforce.h drivers/input/joystick/iforce/iforce.h
--- drivers/input/joystick/iforce_orig/iforce.h	2009-12-03 04:51:21.000000000 +0100
+++ drivers/input/joystick/iforce/iforce.h	2009-12-20 00:18:55.000000000 +0100
@@ -96,6 +96,7 @@
 	signed short *btn;
 	signed short *abs;
 	signed short *ff;
+	bool has_btndead;
 };
 
 struct iforce {
diff -ru drivers/input/joystick/iforce_orig/iforce-main.c drivers/input/joystick/iforce/iforce-main.c
--- drivers/input/joystick/iforce_orig/iforce-main.c	2009-12-03 04:51:21.000000000 +0100
+++ drivers/input/joystick/iforce/iforce-main.c	2009-12-20 00:22:36.000000000 +0100
@@ -35,6 +35,10 @@
 { BTN_TRIGGER, BTN_TOP, BTN_THUMB, BTN_TOP2, BTN_BASE,
   BTN_BASE2, BTN_BASE3, BTN_BASE4, BTN_BASE5, BTN_A, BTN_B, BTN_C, -1 };
 
+static signed short btn_saitek_cyborg[] =
+{ BTN_TRIGGER, BTN_THUMB, BTN_TOP, BTN_TOP2, BTN_BASE,
+  BTN_BASE2, BTN_BASE3, BTN_BASE4, BTN_BASE5, BTN_A, BTN_B, BTN_C, -1 };
+
 static signed short btn_avb_pegasus[] =
 { BTN_TRIGGER, BTN_TOP, BTN_THUMB, BTN_TOP2, BTN_BASE,
   BTN_BASE2, BTN_BASE3, BTN_BASE4, -1 };
@@ -54,6 +58,9 @@
 static signed short abs_joystick[] =
 { ABS_X, ABS_Y, ABS_THROTTLE, ABS_HAT0X, ABS_HAT0Y, -1 };
 
+static signed short abs_saitek_joystick[] =
+{ ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER, ABS_HAT0X, ABS_HAT0Y, -1 };
+
 static signed short abs_avb_pegasus[] =
 { ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER, ABS_HAT0X, ABS_HAT0Y,
   ABS_HAT1X, ABS_HAT1Y, -1 };
@@ -67,19 +74,20 @@
   FF_AUTOCENTER, -1 };
 
 static struct iforce_device iforce_device[] = {
-	{ 0x044f, 0xa01c, "Thrustmaster Motor Sport GT",		btn_wheel, abs_wheel, ff_iforce },
-	{ 0x046d, 0xc281, "Logitech WingMan Force",			btn_joystick, abs_joystick, ff_iforce },
-	{ 0x046d, 0xc291, "Logitech WingMan Formula Force",		btn_wheel, abs_wheel, ff_iforce },
-	{ 0x05ef, 0x020a, "AVB Top Shot Pegasus",			btn_avb_pegasus, abs_avb_pegasus, ff_iforce },
-	{ 0x05ef, 0x8884, "AVB Mag Turbo Force",			btn_avb_wheel, abs_wheel, ff_iforce },
-	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_avb_tw, abs_wheel, ff_iforce }, //?
-	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce }, //?
-	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce },
-	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce }, //?
-	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
-	{ 0x06f8, 0x0004, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce }, //?
-	{ 0x06d6, 0x29bc, "Trust Force Feedback Race Master",		btn_wheel, abs_wheel, ff_iforce },
-	{ 0x0000, 0x0000, "Unknown I-Force Device [%04x:%04x]",		btn_joystick, abs_joystick, ff_iforce }
+	{ 0x044f, 0xa01c, "Thrustmaster Motor Sport GT",		btn_wheel, abs_wheel, ff_iforce, true },
+	{ 0x046d, 0xc281, "Logitech WingMan Force",			btn_joystick, abs_joystick, ff_iforce, true },
+	{ 0x046d, 0xc291, "Logitech WingMan Formula Force",		btn_wheel, abs_wheel, ff_iforce, true },
+	{ 0x05ef, 0x020a, "AVB Top Shot Pegasus",			btn_avb_pegasus, abs_avb_pegasus, ff_iforce, true },
+	{ 0x05ef, 0x8884, "AVB Mag Turbo Force",			btn_avb_wheel, abs_wheel, ff_iforce, true },
+	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_avb_tw, abs_wheel, ff_iforce, true }, //?
+	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce, true }, //?
+	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce, true },
+	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce, true }, //?
+	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce, true }, //?
+	{ 0x06f8, 0x0004, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce, true }, //?
+	{ 0x06d6, 0x29bc, "Trust Force Feedback Race Master",		btn_wheel, abs_wheel, ff_iforce, true },
+	{ 0x06a3, 0xffb5, "Saitek Cyborg Evo Force",			btn_saitek_cyborg, abs_saitek_joystick, ff_iforce, false }, //?
+	{ 0x0000, 0x0000, "Unknown I-Force Device [%04x:%04x]",		btn_joystick, abs_joystick, ff_iforce, true }
 };
 
 static int iforce_playback(struct input_dev *dev, int effect_id, int value)
@@ -396,7 +404,8 @@
 
 	for (i = 0; iforce->type->btn[i] >= 0; i++)
 		set_bit(iforce->type->btn[i], input_dev->keybit);
-	set_bit(BTN_DEAD, input_dev->keybit);
+	if (iforce->type->has_btndead)
+		set_bit(BTN_DEAD, input_dev->keybit);
 
 	for (i = 0; iforce->type->abs[i] >= 0; i++) {
 
@@ -408,7 +417,10 @@
 			case ABS_Y:
 			case ABS_WHEEL:
 
-				input_set_abs_params(input_dev, t, -1920, 1920, 16, 128);
+				if (iforce->type->idvendor == 0x06a3) /* Saitek axis */
+					input_set_abs_params(input_dev, t, 0, 4096, 16, 128);
+				else
+					input_set_abs_params(input_dev, t, -1920, 1920, 16, 128);
 				set_bit(t, input_dev->ffbit);
 				break;
 
@@ -421,7 +433,10 @@
 
 			case ABS_RUDDER:
 
-				input_set_abs_params(input_dev, t, -128, 127, 0, 0);
+				if (iforce->type->idvendor == 0x06a3) /* Saitek axis */
+					input_set_abs_params(input_dev, t, 0, 255, 0, 0);
+				else
+					input_set_abs_params(input_dev, t, -128, 127, 0, 0);
 				break;
 
 			case ABS_HAT0X:
diff -ru drivers/input/joystick/iforce_orig/iforce-packets.c drivers/input/joystick/iforce/iforce-packets.c
--- drivers/input/joystick/iforce_orig/iforce-packets.c	2009-12-03 04:51:21.000000000 +0100
+++ drivers/input/joystick/iforce/iforce-packets.c	2009-12-20 01:11:18.000000000 +0100
@@ -182,16 +182,24 @@
 
 		case 0x01:	/* joystick position data */
 		case 0x03:	/* wheel position data */
-			if (HI(cmd) == 1) {
-				input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
-				input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
-				input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
-				if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
-					input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
-			} else {
+		case 0x06:	/* saitek position data */
+			if (HI(cmd) == 3) {
 				input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
 				input_report_abs(dev, ABS_GAS,   255 - data[2]);
 				input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
+			} else {
+				input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
+				input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
+				if (HI(cmd) == 6) {
+					input_report_abs(dev, ABS_THROTTLE, data[4]);
+					if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+						input_report_abs(dev, ABS_RUDDER, 255 - data[7]);
+				} else {
+					input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
+					if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+						input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
+				}
+
 			}
 
 			input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
@@ -220,8 +228,10 @@
 			break;
 
 		case 0x02:	/* status report */
-			input_report_key(dev, BTN_DEAD, data[0] & 0x02);
-			input_sync(dev);
+			if (iforce->type->has_btndead) {
+				input_report_key(dev, BTN_DEAD, data[0] & 0x02);
+				input_sync(dev);
+			}
 
 			/* Check if an effect was just started or stopped */
 			i = data[1] & 0x7f;
diff -ru drivers/input/joystick/iforce_orig/iforce-usb.c drivers/input/joystick/iforce/iforce-usb.c
--- drivers/input/joystick/iforce_orig/iforce-usb.c	2009-12-03 04:51:21.000000000 +0100
+++ drivers/input/joystick/iforce/iforce-usb.c	2009-12-15 22:46:11.000000000 +0100
@@ -227,6 +227,7 @@
 	{ USB_DEVICE(0x06f8, 0x0001) },		/* Guillemot Race Leader Force Feedback */
 	{ USB_DEVICE(0x06f8, 0x0004) },		/* Guillemot Force Feedback Racing Wheel */
 	{ USB_DEVICE(0x06f8, 0xa302) },		/* Guillemot Jet Leader 3D */
+	{ USB_DEVICE(0x06a3, 0xffb5) },		/* Saitek Cyborg Evo Force */
 	{ }					/* Terminating entry */
 };
 

--------------030603000804030208040106--
