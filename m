From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 4/7] HID: wacom: Replace magic masks and comparisons with switch cases
Date: Mon, 30 Nov 2015 17:13:49 -0800
Message-ID: <1448932432-10115-4-git-send-email-killertofu@gmail.com>
References: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32943 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbbLABN6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 20:13:58 -0500
Received: by pabfh17 with SMTP id fh17so208550955pab.0
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2015 17:13:57 -0800 (PST)
In-Reply-To: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Reasoning through the conditions under which a particular block of code
in 'wacom_intuos_general' will be reached is not at all easy due to the
sheer number of magic masks and comparisons. Remove these and replace
them with a switch statement over the various 'types' of packets that
will be encountered.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 79 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index e395688..a426cb2 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -886,6 +886,7 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 	int idx = (features->type == INTUOS) ? (data[1] & 0x01) : 0;
+	unsigned char type = (data[1] >> 1) & 0x0F;
 	unsigned int t;
 
 	if (data[0] != WACOM_REPORT_PENABLED && data[0] != WACOM_REPORT_CINTIQ &&
@@ -902,8 +903,12 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		input_report_abs(input, ABS_DISTANCE, ((data[9] >> 3) & 0x1f));
 	}
 
-	/* general pen packet */
-	if ((data[1] & 0xb8) == 0xa0) {
+	switch (type) {
+	case 0x00:
+	case 0x01:
+	case 0x02:
+	case 0x03:
+		/* general pen packet */
 		t = (data[6] << 2) | ((data[7] >> 6) & 3);
 		if (features->pressure_max == 2047) {
 			t = (t << 1) | (data[1] & 1);
@@ -917,36 +922,40 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		input_report_key(input, BTN_STYLUS, data[1] & 2);
 		input_report_key(input, BTN_STYLUS2, data[1] & 4);
 		input_report_key(input, BTN_TOUCH, t > 10);
-	}
+		break;
 
-	/* airbrush second packet */
-	if ((data[1] & 0xbc) == 0xb4) {
+	case 0x0a:
+	case 0x0b:
+		/* airbrush second packet */
 		input_report_abs(input, ABS_WHEEL,
 				(data[6] << 2) | ((data[7] >> 6) & 3));
 		input_report_abs(input, ABS_TILT_X,
 				 (((data[7] << 1) & 0x7e) | (data[8] >> 7)) - 64);
 		input_report_abs(input, ABS_TILT_Y, (data[8] & 0x7f) - 64);
-	}
+		break;
 
-	/* 4D mouse, 2D mouse, marker pen rotation, tilt mouse, or Lens cursor packets */
-	if ((data[1] & 0xbc) == 0xa8 || (data[1] & 0xbe) == 0xb0 || (data[1] & 0xbc) == 0xac) {
-
-		if (data[1] & 0x02) {
-			/* Rotation packet */
-			if (features->type >= INTUOS3S) {
-				/* I3 marker pen rotation */
-				t = (data[6] << 3) | ((data[7] >> 5) & 7);
-				t = (data[7] & 0x20) ? ((t > 900) ? ((t-1) / 2 - 1350) :
-					((t-1) / 2 + 450)) : (450 - t / 2) ;
-				input_report_abs(input, ABS_Z, t);
-			} else {
-				/* 4D mouse rotation packet */
-				t = (data[6] << 3) | ((data[7] >> 5) & 7);
-				input_report_abs(input, ABS_RZ, (data[7] & 0x20) ?
-					((t - 1) / 2) : -t / 2);
-			}
+	case 0x05:
+	case 0x07:
+		/* Rotation packet */
+		if (features->type >= INTUOS3S) {
+			/* I3 marker pen rotation */
+			t = (data[6] << 3) | ((data[7] >> 5) & 7);
+			t = (data[7] & 0x20) ? ((t > 900) ? ((t-1) / 2 - 1350) :
+				((t-1) / 2 + 450)) : (450 - t / 2) ;
+			input_report_abs(input, ABS_Z, t);
+		} else {
+			/* 4D mouse rotation packet */
+			t = (data[6] << 3) | ((data[7] >> 5) & 7);
+			input_report_abs(input, ABS_RZ, (data[7] & 0x20) ?
+				((t - 1) / 2) : -t / 2);
+		}
+		break;
 
-		} else if (!(data[1] & 0x10) && features->type < INTUOS3S) {
+	/* 4D mouse, 2D mouse, marker pen rotation, tilt mouse, or Lens cursor packets */
+	case 0x04:
+	case 0x06:
+	case 0x08:
+		if (features->type < INTUOS3S && type != 0x08) {
 			/* 4D mouse packet */
 			input_report_key(input, BTN_LEFT,   data[8] & 0x01);
 			input_report_key(input, BTN_MIDDLE, data[8] & 0x02);
@@ -956,8 +965,8 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 			input_report_key(input, BTN_EXTRA,  data[8] & 0x10);
 			t = (data[6] << 2) | ((data[7] >> 6) & 3);
 			input_report_abs(input, ABS_THROTTLE, (data[8] & 0x08) ? -t : t);
-
-		} else if (wacom->tool[idx] == BTN_TOOL_MOUSE) {
+		}
+		else if (wacom->tool[idx] == BTN_TOOL_MOUSE) {
 			/* I4 mouse */
 			if (features->type >= INTUOS4S && features->type <= INTUOSPL) {
 				input_report_key(input, BTN_LEFT,   data[6] & 0x01);
@@ -985,10 +994,11 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 					input_report_key(input, BTN_EXTRA,  data[8] & 0x20);
 				}
 			}
-		} else if ((features->type < INTUOS3S || features->type == INTUOS3L ||
-				features->type == INTUOS4L || features->type == INTUOS5L ||
-				features->type == INTUOSPL) &&
-			   wacom->tool[idx] == BTN_TOOL_LENS) {
+		}
+		else if ((features->type < INTUOS3S || features->type == INTUOS3L ||
+		          features->type == INTUOS4L || features->type == INTUOS5L ||
+		          features->type == INTUOSPL) &&
+		         wacom->tool[idx] == BTN_TOOL_LENS) {
 			/* Lens cursor packets */
 			input_report_key(input, BTN_LEFT,   data[8] & 0x01);
 			input_report_key(input, BTN_MIDDLE, data[8] & 0x02);
@@ -996,6 +1006,15 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 			input_report_key(input, BTN_SIDE,   data[8] & 0x10);
 			input_report_key(input, BTN_EXTRA,  data[8] & 0x08);
 		}
+		break;
+
+	case 0x09:
+	case 0x0c:
+	case 0x0d:
+	case 0x0e:
+	case 0x0f:
+		/* unhandled */
+		break;
 	}
 
 	input_report_abs(input, ABS_MISC, wacom->id[idx]); /* report tool id */
-- 
2.6.2

