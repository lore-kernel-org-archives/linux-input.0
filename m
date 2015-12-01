From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/7] HID: wacom: Move Intuos pad handling code into dedicated function
Date: Mon, 30 Nov 2015 17:13:46 -0800
Message-ID: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32895 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbLABNz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 20:13:55 -0500
Received: by pabfh17 with SMTP id fh17so208549566pab.0
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2015 17:13:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Begin slimming down the body of 'wacom_intuos_irq' by moving out its
largest block of code to a dedicated 'wacom_intuos_pad' function.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 482 +++++++++++++++++++++++++-----------------------
 1 file changed, 247 insertions(+), 235 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 8b29949..c611ea5 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -446,6 +446,249 @@ static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom_wac)
 	}
 }
 
+static int wacom_intuos_pad(struct wacom_wac *wacom)
+{
+	struct wacom_features *features = &wacom->features;
+	unsigned char *data = wacom->data;
+	struct input_dev *input = wacom->pad_input;
+
+	/* pad packets. Works as a second tool and is always in prox */
+	if (!(data[0] == WACOM_REPORT_INTUOSPAD || data[0] == WACOM_REPORT_INTUOS5PAD ||
+	      data[0] == WACOM_REPORT_CINTIQPAD))
+		return 0;
+
+	if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
+		input_report_key(input, BTN_0, (data[2] & 0x01));
+		input_report_key(input, BTN_1, (data[3] & 0x01));
+		input_report_key(input, BTN_2, (data[3] & 0x02));
+		input_report_key(input, BTN_3, (data[3] & 0x04));
+		input_report_key(input, BTN_4, (data[3] & 0x08));
+		input_report_key(input, BTN_5, (data[3] & 0x10));
+		input_report_key(input, BTN_6, (data[3] & 0x20));
+		if (data[1] & 0x80) {
+			input_report_abs(input, ABS_WHEEL, (data[1] & 0x7f));
+		} else {
+			/* Out of proximity, clear wheel value. */
+			input_report_abs(input, ABS_WHEEL, 0);
+		}
+		if (features->type != INTUOS4S) {
+			input_report_key(input, BTN_7, (data[3] & 0x40));
+			input_report_key(input, BTN_8, (data[3] & 0x80));
+		}
+		if (data[1] | (data[2] & 0x01) | data[3]) {
+			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		} else {
+			input_report_abs(input, ABS_MISC, 0);
+		}
+	} else if (features->type == DTK) {
+		input_report_key(input, BTN_0, (data[6] & 0x01));
+		input_report_key(input, BTN_1, (data[6] & 0x02));
+		input_report_key(input, BTN_2, (data[6] & 0x04));
+		input_report_key(input, BTN_3, (data[6] & 0x08));
+		input_report_key(input, BTN_4, (data[6] & 0x10));
+		input_report_key(input, BTN_5, (data[6] & 0x20));
+		if (data[6] & 0x3f) {
+			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		} else {
+			input_report_abs(input, ABS_MISC, 0);
+		}
+	} else if (features->type == WACOM_13HD) {
+		input_report_key(input, BTN_0, (data[3] & 0x01));
+		input_report_key(input, BTN_1, (data[4] & 0x01));
+		input_report_key(input, BTN_2, (data[4] & 0x02));
+		input_report_key(input, BTN_3, (data[4] & 0x04));
+		input_report_key(input, BTN_4, (data[4] & 0x08));
+		input_report_key(input, BTN_5, (data[4] & 0x10));
+		input_report_key(input, BTN_6, (data[4] & 0x20));
+		input_report_key(input, BTN_7, (data[4] & 0x40));
+		input_report_key(input, BTN_8, (data[4] & 0x80));
+		if ((data[3] & 0x01) | data[4]) {
+			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		} else {
+			input_report_abs(input, ABS_MISC, 0);
+		}
+	} else if (features->type == WACOM_24HD) {
+		input_report_key(input, BTN_0, (data[6] & 0x01));
+		input_report_key(input, BTN_1, (data[6] & 0x02));
+		input_report_key(input, BTN_2, (data[6] & 0x04));
+		input_report_key(input, BTN_3, (data[6] & 0x08));
+		input_report_key(input, BTN_4, (data[6] & 0x10));
+		input_report_key(input, BTN_5, (data[6] & 0x20));
+		input_report_key(input, BTN_6, (data[6] & 0x40));
+		input_report_key(input, BTN_7, (data[6] & 0x80));
+		input_report_key(input, BTN_8, (data[8] & 0x01));
+		input_report_key(input, BTN_9, (data[8] & 0x02));
+		input_report_key(input, BTN_A, (data[8] & 0x04));
+		input_report_key(input, BTN_B, (data[8] & 0x08));
+		input_report_key(input, BTN_C, (data[8] & 0x10));
+		input_report_key(input, BTN_X, (data[8] & 0x20));
+		input_report_key(input, BTN_Y, (data[8] & 0x40));
+		input_report_key(input, BTN_Z, (data[8] & 0x80));
+
+		/*
+		 * Three "buttons" are available on the 24HD which are
+		 * physically implemented as a touchstrip. Each button
+		 * is approximately 3 bits wide with a 2 bit spacing.
+		 * The raw touchstrip bits are stored at:
+		 *    ((data[3] & 0x1f) << 8) | data[4])
+		 */
+		input_report_key(input, KEY_PROG1, data[4] & 0x07);
+		input_report_key(input, KEY_PROG2, data[4] & 0xE0);
+		input_report_key(input, KEY_PROG3, data[3] & 0x1C);
+
+		if (data[1] & 0x80) {
+			input_report_abs(input, ABS_WHEEL, (data[1] & 0x7f));
+		} else {
+			/* Out of proximity, clear wheel value. */
+			input_report_abs(input, ABS_WHEEL, 0);
+		}
+
+		if (data[2] & 0x80) {
+			input_report_abs(input, ABS_THROTTLE, (data[2] & 0x7f));
+		} else {
+			/* Out of proximity, clear second wheel value. */
+			input_report_abs(input, ABS_THROTTLE, 0);
+		}
+
+		if (data[1] | data[2] | (data[3] & 0x1f) | data[4] | data[6] | data[8]) {
+			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		} else {
+			input_report_abs(input, ABS_MISC, 0);
+		}
+	} else if (features->type == WACOM_27QHD) {
+		input_report_key(input, KEY_PROG1, data[2] & 0x01);
+		input_report_key(input, KEY_PROG2, data[2] & 0x02);
+		input_report_key(input, KEY_PROG3, data[2] & 0x04);
+
+		input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[4]));
+		input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[6]));
+		input_report_abs(input, ABS_Z, be16_to_cpup((__be16 *)&data[8]));
+		if ((data[2] & 0x07) | data[4] | data[5] | data[6] | data[7] | data[8] | data[9]) {
+			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		} else {
+			input_report_abs(input, ABS_MISC, 0);
+		}
+	} else if (features->type == CINTIQ_HYBRID) {
+		/*
+		 * Do not send hardware buttons under Android. They
+		 * are already sent to the system through GPIO (and
+		 * have different meaning).
+		 */
+		input_report_key(input, BTN_1, (data[4] & 0x01));
+		input_report_key(input, BTN_2, (data[4] & 0x02));
+		input_report_key(input, BTN_3, (data[4] & 0x04));
+		input_report_key(input, BTN_4, (data[4] & 0x08));
+
+		input_report_key(input, BTN_5, (data[4] & 0x10));  /* Right  */
+		input_report_key(input, BTN_6, (data[4] & 0x20));  /* Up     */
+		input_report_key(input, BTN_7, (data[4] & 0x40));  /* Left   */
+		input_report_key(input, BTN_8, (data[4] & 0x80));  /* Down   */
+		input_report_key(input, BTN_0, (data[3] & 0x01));  /* Center */
+
+		if (data[4] | (data[3] & 0x01)) {
+			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		} else {
+			input_report_abs(input, ABS_MISC, 0);
+		}
+
+	} else if (features->type == CINTIQ_COMPANION_2) {
+		input_report_key(input, BTN_1, (data[1] & 0x02));
+		input_report_key(input, BTN_2, (data[2] & 0x01));
+		input_report_key(input, BTN_3, (data[2] & 0x02));
+		input_report_key(input, BTN_4, (data[2] & 0x04));
+		input_report_key(input, BTN_5, (data[2] & 0x08));
+		input_report_key(input, BTN_6, (data[1] & 0x04));
+
+		input_report_key(input, BTN_7, (data[2] & 0x10));  /* Right  */
+		input_report_key(input, BTN_8, (data[2] & 0x20));  /* Up	 */
+		input_report_key(input, BTN_9, (data[2] & 0x40));  /* Left   */
+		input_report_key(input, BTN_A, (data[2] & 0x80));  /* Down   */
+		input_report_key(input, BTN_0, (data[1] & 0x01));  /* Center */
+
+		if (data[2] | (data[1] & 0x07)) {
+			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		} else {
+			input_report_abs(input, ABS_MISC, 0);
+		}
+
+	} else if (features->type >= INTUOS5S && features->type <= INTUOSPL) {
+		int i;
+
+		/* Touch ring mode switch has no capacitive sensor */
+		input_report_key(input, BTN_0, (data[3] & 0x01));
+
+		/*
+		 * ExpressKeys on Intuos5/Intuos Pro have a capacitive sensor in
+		 * addition to the mechanical switch. Switch data is
+		 * stored in data[4], capacitive data in data[5].
+		 */
+		for (i = 0; i < 8; i++)
+			input_report_key(input, BTN_1 + i, data[4] & (1 << i));
+
+		if (data[2] & 0x80) {
+			input_report_abs(input, ABS_WHEEL, (data[2] & 0x7f));
+		} else {
+			/* Out of proximity, clear wheel value. */
+			input_report_abs(input, ABS_WHEEL, 0);
+		}
+
+		if (data[2] | (data[3] & 0x01) | data[4] | data[5]) {
+			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		} else {
+			input_report_abs(input, ABS_MISC, 0);
+		}
+	} else {
+		if (features->type == WACOM_21UX2 || features->type == WACOM_22HD) {
+			input_report_key(input, BTN_0, (data[5] & 0x01));
+			input_report_key(input, BTN_1, (data[6] & 0x01));
+			input_report_key(input, BTN_2, (data[6] & 0x02));
+			input_report_key(input, BTN_3, (data[6] & 0x04));
+			input_report_key(input, BTN_4, (data[6] & 0x08));
+			input_report_key(input, BTN_5, (data[6] & 0x10));
+			input_report_key(input, BTN_6, (data[6] & 0x20));
+			input_report_key(input, BTN_7, (data[6] & 0x40));
+			input_report_key(input, BTN_8, (data[6] & 0x80));
+			input_report_key(input, BTN_9, (data[7] & 0x01));
+			input_report_key(input, BTN_A, (data[8] & 0x01));
+			input_report_key(input, BTN_B, (data[8] & 0x02));
+			input_report_key(input, BTN_C, (data[8] & 0x04));
+			input_report_key(input, BTN_X, (data[8] & 0x08));
+			input_report_key(input, BTN_Y, (data[8] & 0x10));
+			input_report_key(input, BTN_Z, (data[8] & 0x20));
+			input_report_key(input, BTN_BASE, (data[8] & 0x40));
+			input_report_key(input, BTN_BASE2, (data[8] & 0x80));
+
+			if (features->type == WACOM_22HD) {
+				input_report_key(input, KEY_PROG1, data[9] & 0x01);
+				input_report_key(input, KEY_PROG2, data[9] & 0x02);
+				input_report_key(input, KEY_PROG3, data[9] & 0x04);
+			}
+		} else {
+			input_report_key(input, BTN_0, (data[5] & 0x01));
+			input_report_key(input, BTN_1, (data[5] & 0x02));
+			input_report_key(input, BTN_2, (data[5] & 0x04));
+			input_report_key(input, BTN_3, (data[5] & 0x08));
+			input_report_key(input, BTN_4, (data[6] & 0x01));
+			input_report_key(input, BTN_5, (data[6] & 0x02));
+			input_report_key(input, BTN_6, (data[6] & 0x04));
+			input_report_key(input, BTN_7, (data[6] & 0x08));
+			input_report_key(input, BTN_8, (data[5] & 0x10));
+			input_report_key(input, BTN_9, (data[6] & 0x10));
+		}
+		input_report_abs(input, ABS_RX, ((data[1] & 0x1f) << 8) | data[2]);
+		input_report_abs(input, ABS_RY, ((data[3] & 0x1f) << 8) | data[4]);
+
+		if ((data[5] & 0x1f) | data[6] | (data[1] & 0x1f) |
+			data[2] | (data[3] & 0x1f) | data[4] | data[8] |
+			(data[7] & 0x01)) {
+			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		} else {
+			input_report_abs(input, ABS_MISC, 0);
+		}
+	}
+	return 1;
+}
+
 static int wacom_intuos_inout(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
@@ -814,241 +1057,10 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	if (features->type == INTUOS)
 		idx = data[1] & 0x01;
 
-	/* pad packets. Works as a second tool and is always in prox */
-	if (data[0] == WACOM_REPORT_INTUOSPAD || data[0] == WACOM_REPORT_INTUOS5PAD ||
-	    data[0] == WACOM_REPORT_CINTIQPAD) {
-		input = wacom->pad_input;
-		if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
-			input_report_key(input, BTN_0, (data[2] & 0x01));
-			input_report_key(input, BTN_1, (data[3] & 0x01));
-			input_report_key(input, BTN_2, (data[3] & 0x02));
-			input_report_key(input, BTN_3, (data[3] & 0x04));
-			input_report_key(input, BTN_4, (data[3] & 0x08));
-			input_report_key(input, BTN_5, (data[3] & 0x10));
-			input_report_key(input, BTN_6, (data[3] & 0x20));
-			if (data[1] & 0x80) {
-				input_report_abs(input, ABS_WHEEL, (data[1] & 0x7f));
-			} else {
-				/* Out of proximity, clear wheel value. */
-				input_report_abs(input, ABS_WHEEL, 0);
-			}
-			if (features->type != INTUOS4S) {
-				input_report_key(input, BTN_7, (data[3] & 0x40));
-				input_report_key(input, BTN_8, (data[3] & 0x80));
-			}
-			if (data[1] | (data[2] & 0x01) | data[3]) {
-				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-			} else {
-				input_report_abs(input, ABS_MISC, 0);
-			}
-		} else if (features->type == DTK) {
-			input_report_key(input, BTN_0, (data[6] & 0x01));
-			input_report_key(input, BTN_1, (data[6] & 0x02));
-			input_report_key(input, BTN_2, (data[6] & 0x04));
-			input_report_key(input, BTN_3, (data[6] & 0x08));
-			input_report_key(input, BTN_4, (data[6] & 0x10));
-			input_report_key(input, BTN_5, (data[6] & 0x20));
-			if (data[6] & 0x3f) {
-				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-			} else {
-				input_report_abs(input, ABS_MISC, 0);
-			}
-		} else if (features->type == WACOM_13HD) {
-			input_report_key(input, BTN_0, (data[3] & 0x01));
-			input_report_key(input, BTN_1, (data[4] & 0x01));
-			input_report_key(input, BTN_2, (data[4] & 0x02));
-			input_report_key(input, BTN_3, (data[4] & 0x04));
-			input_report_key(input, BTN_4, (data[4] & 0x08));
-			input_report_key(input, BTN_5, (data[4] & 0x10));
-			input_report_key(input, BTN_6, (data[4] & 0x20));
-			input_report_key(input, BTN_7, (data[4] & 0x40));
-			input_report_key(input, BTN_8, (data[4] & 0x80));
-			if ((data[3] & 0x01) | data[4]) {
-				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-			} else {
-				input_report_abs(input, ABS_MISC, 0);
-			}
-		} else if (features->type == WACOM_24HD) {
-			input_report_key(input, BTN_0, (data[6] & 0x01));
-			input_report_key(input, BTN_1, (data[6] & 0x02));
-			input_report_key(input, BTN_2, (data[6] & 0x04));
-			input_report_key(input, BTN_3, (data[6] & 0x08));
-			input_report_key(input, BTN_4, (data[6] & 0x10));
-			input_report_key(input, BTN_5, (data[6] & 0x20));
-			input_report_key(input, BTN_6, (data[6] & 0x40));
-			input_report_key(input, BTN_7, (data[6] & 0x80));
-			input_report_key(input, BTN_8, (data[8] & 0x01));
-			input_report_key(input, BTN_9, (data[8] & 0x02));
-			input_report_key(input, BTN_A, (data[8] & 0x04));
-			input_report_key(input, BTN_B, (data[8] & 0x08));
-			input_report_key(input, BTN_C, (data[8] & 0x10));
-			input_report_key(input, BTN_X, (data[8] & 0x20));
-			input_report_key(input, BTN_Y, (data[8] & 0x40));
-			input_report_key(input, BTN_Z, (data[8] & 0x80));
-
-			/*
-			 * Three "buttons" are available on the 24HD which are
-			 * physically implemented as a touchstrip. Each button
-			 * is approximately 3 bits wide with a 2 bit spacing.
-			 * The raw touchstrip bits are stored at:
-			 *    ((data[3] & 0x1f) << 8) | data[4])
-			 */
-			input_report_key(input, KEY_PROG1, data[4] & 0x07);
-			input_report_key(input, KEY_PROG2, data[4] & 0xE0);
-			input_report_key(input, KEY_PROG3, data[3] & 0x1C);
-
-			if (data[1] & 0x80) {
-				input_report_abs(input, ABS_WHEEL, (data[1] & 0x7f));
-			} else {
-				/* Out of proximity, clear wheel value. */
-				input_report_abs(input, ABS_WHEEL, 0);
-			}
-
-			if (data[2] & 0x80) {
-				input_report_abs(input, ABS_THROTTLE, (data[2] & 0x7f));
-			} else {
-				/* Out of proximity, clear second wheel value. */
-				input_report_abs(input, ABS_THROTTLE, 0);
-			}
-
-			if (data[1] | data[2] | (data[3] & 0x1f) | data[4] | data[6] | data[8]) {
-				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-			} else {
-				input_report_abs(input, ABS_MISC, 0);
-			}
-		} else if (features->type == WACOM_27QHD) {
-			input_report_key(input, KEY_PROG1, data[2] & 0x01);
-			input_report_key(input, KEY_PROG2, data[2] & 0x02);
-			input_report_key(input, KEY_PROG3, data[2] & 0x04);
-
-			input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[4]));
-			input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[6]));
-			input_report_abs(input, ABS_Z, be16_to_cpup((__be16 *)&data[8]));
-			if ((data[2] & 0x07) | data[4] | data[5] | data[6] | data[7] | data[8] | data[9]) {
-				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-			} else {
-				input_report_abs(input, ABS_MISC, 0);
-			}
-		} else if (features->type == CINTIQ_HYBRID) {
-			/*
-			 * Do not send hardware buttons under Android. They
-			 * are already sent to the system through GPIO (and
-			 * have different meaning).
-			 */
-			input_report_key(input, BTN_1, (data[4] & 0x01));
-			input_report_key(input, BTN_2, (data[4] & 0x02));
-			input_report_key(input, BTN_3, (data[4] & 0x04));
-			input_report_key(input, BTN_4, (data[4] & 0x08));
-
-			input_report_key(input, BTN_5, (data[4] & 0x10));  /* Right  */
-			input_report_key(input, BTN_6, (data[4] & 0x20));  /* Up     */
-			input_report_key(input, BTN_7, (data[4] & 0x40));  /* Left   */
-			input_report_key(input, BTN_8, (data[4] & 0x80));  /* Down   */
-			input_report_key(input, BTN_0, (data[3] & 0x01));  /* Center */
-
-			if (data[4] | (data[3] & 0x01)) {
-				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-			} else {
-				input_report_abs(input, ABS_MISC, 0);
-			}
-
-		} else if (features->type == CINTIQ_COMPANION_2) {
-			input_report_key(input, BTN_1, (data[1] & 0x02));
-			input_report_key(input, BTN_2, (data[2] & 0x01));
-			input_report_key(input, BTN_3, (data[2] & 0x02));
-			input_report_key(input, BTN_4, (data[2] & 0x04));
-			input_report_key(input, BTN_5, (data[2] & 0x08));
-			input_report_key(input, BTN_6, (data[1] & 0x04));
-
-			input_report_key(input, BTN_7, (data[2] & 0x10));  /* Right  */
-			input_report_key(input, BTN_8, (data[2] & 0x20));  /* Up	 */
-			input_report_key(input, BTN_9, (data[2] & 0x40));  /* Left   */
-			input_report_key(input, BTN_A, (data[2] & 0x80));  /* Down   */
-			input_report_key(input, BTN_0, (data[1] & 0x01));  /* Center */
-
-			if (data[2] | (data[1] & 0x07)) {
-				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-			} else {
-				input_report_abs(input, ABS_MISC, 0);
-			}
-
-		} else if (features->type >= INTUOS5S && features->type <= INTUOSPL) {
-			int i;
-
-			/* Touch ring mode switch has no capacitive sensor */
-			input_report_key(input, BTN_0, (data[3] & 0x01));
-
-			/*
-			 * ExpressKeys on Intuos5/Intuos Pro have a capacitive sensor in
-			 * addition to the mechanical switch. Switch data is
-			 * stored in data[4], capacitive data in data[5].
-			 */
-			for (i = 0; i < 8; i++)
-				input_report_key(input, BTN_1 + i, data[4] & (1 << i));
-
-			if (data[2] & 0x80) {
-				input_report_abs(input, ABS_WHEEL, (data[2] & 0x7f));
-			} else {
-				/* Out of proximity, clear wheel value. */
-				input_report_abs(input, ABS_WHEEL, 0);
-			}
-
-			if (data[2] | (data[3] & 0x01) | data[4] | data[5]) {
-				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-			} else {
-				input_report_abs(input, ABS_MISC, 0);
-			}
-		} else {
-			if (features->type == WACOM_21UX2 || features->type == WACOM_22HD) {
-				input_report_key(input, BTN_0, (data[5] & 0x01));
-				input_report_key(input, BTN_1, (data[6] & 0x01));
-				input_report_key(input, BTN_2, (data[6] & 0x02));
-				input_report_key(input, BTN_3, (data[6] & 0x04));
-				input_report_key(input, BTN_4, (data[6] & 0x08));
-				input_report_key(input, BTN_5, (data[6] & 0x10));
-				input_report_key(input, BTN_6, (data[6] & 0x20));
-				input_report_key(input, BTN_7, (data[6] & 0x40));
-				input_report_key(input, BTN_8, (data[6] & 0x80));
-				input_report_key(input, BTN_9, (data[7] & 0x01));
-				input_report_key(input, BTN_A, (data[8] & 0x01));
-				input_report_key(input, BTN_B, (data[8] & 0x02));
-				input_report_key(input, BTN_C, (data[8] & 0x04));
-				input_report_key(input, BTN_X, (data[8] & 0x08));
-				input_report_key(input, BTN_Y, (data[8] & 0x10));
-				input_report_key(input, BTN_Z, (data[8] & 0x20));
-				input_report_key(input, BTN_BASE, (data[8] & 0x40));
-				input_report_key(input, BTN_BASE2, (data[8] & 0x80));
-
-				if (features->type == WACOM_22HD) {
-					input_report_key(input, KEY_PROG1, data[9] & 0x01);
-					input_report_key(input, KEY_PROG2, data[9] & 0x02);
-					input_report_key(input, KEY_PROG3, data[9] & 0x04);
-				}
-			} else {
-				input_report_key(input, BTN_0, (data[5] & 0x01));
-				input_report_key(input, BTN_1, (data[5] & 0x02));
-				input_report_key(input, BTN_2, (data[5] & 0x04));
-				input_report_key(input, BTN_3, (data[5] & 0x08));
-				input_report_key(input, BTN_4, (data[6] & 0x01));
-				input_report_key(input, BTN_5, (data[6] & 0x02));
-				input_report_key(input, BTN_6, (data[6] & 0x04));
-				input_report_key(input, BTN_7, (data[6] & 0x08));
-				input_report_key(input, BTN_8, (data[5] & 0x10));
-				input_report_key(input, BTN_9, (data[6] & 0x10));
-			}
-			input_report_abs(input, ABS_RX, ((data[1] & 0x1f) << 8) | data[2]);
-			input_report_abs(input, ABS_RY, ((data[3] & 0x1f) << 8) | data[4]);
-
-			if ((data[5] & 0x1f) | data[6] | (data[1] & 0x1f) |
-				data[2] | (data[3] & 0x1f) | data[4] | data[8] |
-				(data[7] & 0x01)) {
-				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-			} else {
-				input_report_abs(input, ABS_MISC, 0);
-			}
-		}
-                return 1;
-	}
+	/* process pad events */
+	result = wacom_intuos_pad(wacom);
+	if (result)
+		return result;
 
 	/* process in/out prox events */
 	result = wacom_intuos_inout(wacom);
-- 
2.6.2

