From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 5/7] HID: wacom: Further clean up wacom_intuos_general packet decoder
Date: Mon, 30 Nov 2015 17:13:50 -0800
Message-ID: <1448932432-10115-5-git-send-email-killertofu@gmail.com>
References: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34916 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbbLABN7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 20:13:59 -0500
Received: by pacej9 with SMTP id ej9so202496674pac.2
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2015 17:13:58 -0800 (PST)
In-Reply-To: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Continue re-organizing and trimming cases to make it easier to wrap
the brain around. A number of changes were made after consulting the
protocol spec and so don't necessarily follow from the code itself.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 87 +++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a426cb2..ce3afab 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -925,7 +925,6 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		break;
 
 	case 0x0a:
-	case 0x0b:
 		/* airbrush second packet */
 		input_report_abs(input, ABS_WHEEL,
 				(data[6] << 2) | ((data[7] >> 6) & 3));
@@ -935,7 +934,6 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		break;
 
 	case 0x05:
-	case 0x07:
 		/* Rotation packet */
 		if (features->type >= INTUOS3S) {
 			/* I3 marker pen rotation */
@@ -944,61 +942,56 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 				((t-1) / 2 + 450)) : (450 - t / 2) ;
 			input_report_abs(input, ABS_Z, t);
 		} else {
-			/* 4D mouse rotation packet */
+			/* 4D mouse 2nd packet */
 			t = (data[6] << 3) | ((data[7] >> 5) & 7);
 			input_report_abs(input, ABS_RZ, (data[7] & 0x20) ?
 				((t - 1) / 2) : -t / 2);
 		}
 		break;
 
-	/* 4D mouse, 2D mouse, marker pen rotation, tilt mouse, or Lens cursor packets */
 	case 0x04:
+		/* 4D mouse 1st packet */
+		input_report_key(input, BTN_LEFT,   data[8] & 0x01);
+		input_report_key(input, BTN_MIDDLE, data[8] & 0x02);
+		input_report_key(input, BTN_RIGHT,  data[8] & 0x04);
+
+		input_report_key(input, BTN_SIDE,   data[8] & 0x20);
+		input_report_key(input, BTN_EXTRA,  data[8] & 0x10);
+		t = (data[6] << 2) | ((data[7] >> 6) & 3);
+		input_report_abs(input, ABS_THROTTLE, (data[8] & 0x08) ? -t : t);
+		break;
+
 	case 0x06:
-	case 0x08:
-		if (features->type < INTUOS3S && type != 0x08) {
-			/* 4D mouse packet */
-			input_report_key(input, BTN_LEFT,   data[8] & 0x01);
-			input_report_key(input, BTN_MIDDLE, data[8] & 0x02);
-			input_report_key(input, BTN_RIGHT,  data[8] & 0x04);
+		/* I4 mouse */
+		input_report_key(input, BTN_LEFT,   data[6] & 0x01);
+		input_report_key(input, BTN_MIDDLE, data[6] & 0x02);
+		input_report_key(input, BTN_RIGHT,  data[6] & 0x04);
+		input_report_rel(input, REL_WHEEL, ((data[7] & 0x80) >> 7)
+				 - ((data[7] & 0x40) >> 6));
+		input_report_key(input, BTN_SIDE,   data[6] & 0x08);
+		input_report_key(input, BTN_EXTRA,  data[6] & 0x10);
 
-			input_report_key(input, BTN_SIDE,   data[8] & 0x20);
-			input_report_key(input, BTN_EXTRA,  data[8] & 0x10);
-			t = (data[6] << 2) | ((data[7] >> 6) & 3);
-			input_report_abs(input, ABS_THROTTLE, (data[8] & 0x08) ? -t : t);
-		}
-		else if (wacom->tool[idx] == BTN_TOOL_MOUSE) {
-			/* I4 mouse */
-			if (features->type >= INTUOS4S && features->type <= INTUOSPL) {
-				input_report_key(input, BTN_LEFT,   data[6] & 0x01);
-				input_report_key(input, BTN_MIDDLE, data[6] & 0x02);
-				input_report_key(input, BTN_RIGHT,  data[6] & 0x04);
-				input_report_rel(input, REL_WHEEL, ((data[7] & 0x80) >> 7)
-						 - ((data[7] & 0x40) >> 6));
-				input_report_key(input, BTN_SIDE,   data[6] & 0x08);
-				input_report_key(input, BTN_EXTRA,  data[6] & 0x10);
-
-				input_report_abs(input, ABS_TILT_X,
-					(((data[7] << 1) & 0x7e) | (data[8] >> 7)) - 64);
-				input_report_abs(input, ABS_TILT_Y, (data[8] & 0x7f) - 64);
-			} else {
-				/* 2D mouse packet */
-				input_report_key(input, BTN_LEFT,   data[8] & 0x04);
-				input_report_key(input, BTN_MIDDLE, data[8] & 0x08);
-				input_report_key(input, BTN_RIGHT,  data[8] & 0x10);
-				input_report_rel(input, REL_WHEEL, (data[8] & 0x01)
-						 - ((data[8] & 0x02) >> 1));
-
-				/* I3 2D mouse side buttons */
-				if (features->type >= INTUOS3S && features->type <= INTUOS3L) {
-					input_report_key(input, BTN_SIDE,   data[8] & 0x40);
-					input_report_key(input, BTN_EXTRA,  data[8] & 0x20);
-				}
+		input_report_abs(input, ABS_TILT_X,
+			(((data[7] << 1) & 0x7e) | (data[8] >> 7)) - 64);
+		input_report_abs(input, ABS_TILT_Y, (data[8] & 0x7f) - 64);
+		break;
+
+	case 0x08:
+		if (wacom->tool[idx] == BTN_TOOL_MOUSE) {
+			/* 2D mouse packet */
+			input_report_key(input, BTN_LEFT,   data[8] & 0x04);
+			input_report_key(input, BTN_MIDDLE, data[8] & 0x08);
+			input_report_key(input, BTN_RIGHT,  data[8] & 0x10);
+			input_report_rel(input, REL_WHEEL, (data[8] & 0x01)
+					 - ((data[8] & 0x02) >> 1));
+
+			/* I3 2D mouse side buttons */
+			if (features->type >= INTUOS3S && features->type <= INTUOS3L) {
+				input_report_key(input, BTN_SIDE,   data[8] & 0x40);
+				input_report_key(input, BTN_EXTRA,  data[8] & 0x20);
 			}
 		}
-		else if ((features->type < INTUOS3S || features->type == INTUOS3L ||
-		          features->type == INTUOS4L || features->type == INTUOS5L ||
-		          features->type == INTUOSPL) &&
-		         wacom->tool[idx] == BTN_TOOL_LENS) {
+		else if (wacom->tool[idx] == BTN_TOOL_LENS) {
 			/* Lens cursor packets */
 			input_report_key(input, BTN_LEFT,   data[8] & 0x01);
 			input_report_key(input, BTN_MIDDLE, data[8] & 0x02);
@@ -1008,7 +1001,9 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		}
 		break;
 
+	case 0x07:
 	case 0x09:
+	case 0x0b:
 	case 0x0c:
 	case 0x0d:
 	case 0x0e:
-- 
2.6.2

