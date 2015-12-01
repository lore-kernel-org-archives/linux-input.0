From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/7] HID: wacom: Centralize Intuos pen packet decoding
Date: Mon, 30 Nov 2015 17:13:48 -0800
Message-ID: <1448932432-10115-3-git-send-email-killertofu@gmail.com>
References: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36709 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbLABN5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 20:13:57 -0500
Received: by pacdm15 with SMTP id dm15so202576021pac.3
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2015 17:13:56 -0800 (PST)
In-Reply-To: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Continue to slim down 'wacom_intuos_irq' by moving all decoding and
reporting of pen packet data into the  'wacom_intuos_general' function.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 105 +++++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index ec1e13e..e395688 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -880,13 +880,28 @@ static int wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
 	return 0;
 }
 
-static void wacom_intuos_general(struct wacom_wac *wacom)
+static int wacom_intuos_general(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
+	int idx = (features->type == INTUOS) ? (data[1] & 0x01) : 0;
 	unsigned int t;
 
+	if (data[0] != WACOM_REPORT_PENABLED && data[0] != WACOM_REPORT_CINTIQ &&
+		data[0] != WACOM_REPORT_INTUOS_PEN)
+		return 0;
+
+	if (features->type >= INTUOS3S) {
+		input_report_abs(input, ABS_X, (data[2] << 9) | (data[3] << 1) | ((data[9] >> 1) & 1));
+		input_report_abs(input, ABS_Y, (data[4] << 9) | (data[5] << 1) | (data[9] & 1));
+		input_report_abs(input, ABS_DISTANCE, ((data[9] >> 2) & 0x3f));
+	} else {
+		input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[2]));
+		input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[4]));
+		input_report_abs(input, ABS_DISTANCE, ((data[9] >> 3) & 0x1f));
+	}
+
 	/* general pen packet */
 	if ((data[1] & 0xb8) == 0xa0) {
 		t = (data[6] << 2) | ((data[7] >> 6) & 3);
@@ -912,55 +927,6 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 				 (((data[7] << 1) & 0x7e) | (data[8] >> 7)) - 64);
 		input_report_abs(input, ABS_TILT_Y, (data[8] & 0x7f) - 64);
 	}
-}
-
-static int wacom_intuos_irq(struct wacom_wac *wacom)
-{
-	struct wacom_features *features = &wacom->features;
-	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->pen_input;
-	unsigned int t;
-	int idx = 0, result;
-
-	if (data[0] != WACOM_REPORT_PENABLED &&
-	    data[0] != WACOM_REPORT_INTUOSREAD &&
-	    data[0] != WACOM_REPORT_INTUOSWRITE &&
-	    data[0] != WACOM_REPORT_INTUOSPAD &&
-	    data[0] != WACOM_REPORT_INTUOS_PEN &&
-	    data[0] != WACOM_REPORT_CINTIQ &&
-	    data[0] != WACOM_REPORT_CINTIQPAD &&
-	    data[0] != WACOM_REPORT_INTUOS5PAD) {
-		dev_dbg(input->dev.parent,
-			"%s: received unknown report #%d\n", __func__, data[0]);
-                return 0;
-	}
-
-	/* tool number */
-	if (features->type == INTUOS)
-		idx = data[1] & 0x01;
-
-	/* process pad events */
-	result = wacom_intuos_pad(wacom);
-	if (result)
-		return result;
-
-	/* process in/out prox events */
-	result = wacom_intuos_inout(wacom);
-	if (result)
-                return result - 1;
-
-	if (features->type >= INTUOS3S) {
-		input_report_abs(input, ABS_X, (data[2] << 9) | (data[3] << 1) | ((data[9] >> 1) & 1));
-		input_report_abs(input, ABS_Y, (data[4] << 9) | (data[5] << 1) | (data[9] & 1));
-		input_report_abs(input, ABS_DISTANCE, ((data[9] >> 2) & 0x3f));
-	} else {
-		input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[2]));
-		input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[4]));
-		input_report_abs(input, ABS_DISTANCE, ((data[9] >> 3) & 0x1f));
-	}
-
-	/* process general packets */
-	wacom_intuos_general(wacom);
 
 	/* 4D mouse, 2D mouse, marker pen rotation, tilt mouse, or Lens cursor packets */
 	if ((data[1] & 0xbc) == 0xa8 || (data[1] & 0xbe) == 0xb0 || (data[1] & 0xbc) == 0xac) {
@@ -1036,7 +1002,44 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	input_report_key(input, wacom->tool[idx], 1);
 	input_event(input, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
 	wacom->reporting_data = true;
-	return 1;
+	return 2;
+}
+
+static int wacom_intuos_irq(struct wacom_wac *wacom)
+{
+	unsigned char *data = wacom->data;
+	struct input_dev *input = wacom->pen_input;
+	int result;
+
+	if (data[0] != WACOM_REPORT_PENABLED &&
+	    data[0] != WACOM_REPORT_INTUOSREAD &&
+	    data[0] != WACOM_REPORT_INTUOSWRITE &&
+	    data[0] != WACOM_REPORT_INTUOSPAD &&
+	    data[0] != WACOM_REPORT_INTUOS_PEN &&
+	    data[0] != WACOM_REPORT_CINTIQ &&
+	    data[0] != WACOM_REPORT_CINTIQPAD &&
+	    data[0] != WACOM_REPORT_INTUOS5PAD) {
+		dev_dbg(input->dev.parent,
+			"%s: received unknown report #%d\n", __func__, data[0]);
+                return 0;
+	}
+
+	/* process pad events */
+	result = wacom_intuos_pad(wacom);
+	if (result)
+		return result;
+
+	/* process in/out prox events */
+	result = wacom_intuos_inout(wacom);
+	if (result)
+		return result - 1;
+
+	/* process general packets */
+	result = wacom_intuos_general(wacom);
+	if (result)
+		return result - 1;
+
+	return 0;
 }
 
 static int int_dist(int x1, int y1, int x2, int y2)
-- 
2.6.2

