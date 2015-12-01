From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/7] HID: wacom: Slim down wacom_intuos_pad processing
Date: Mon, 30 Nov 2015 17:13:47 -0800
Message-ID: <1448932432-10115-2-git-send-email-killertofu@gmail.com>
References: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32913 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbLABN4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 20:13:56 -0500
Received: by pabfh17 with SMTP id fh17so208550056pab.0
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2015 17:13:56 -0800 (PST)
In-Reply-To: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Seperate the function into two halves: first gather data from the packet,
next report all gathered data. The input subsystem should automatically
mute any events that aren't actually declared for the tablet at hand.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 277 +++++++++++++++---------------------------------
 1 file changed, 86 insertions(+), 191 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c611ea5..ec1e13e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -34,6 +34,9 @@
  */
 #define WACOM_CONTACT_AREA_SCALE 2607
 
+static void wacom_report_numbered_buttons(struct input_dev *input_dev,
+				int button_count, int mask);
+
 /*
  * Percent of battery capacity for Graphire.
  * 8th value means AC online and show 100% capacity.
@@ -451,6 +454,12 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pad_input;
+	int i;
+	int buttons = 0, nbuttons = features->numbered_buttons;
+	int keys = 0, nkeys = 0;
+	int ring1 = 0, ring2 = 0;
+	int strip1 = 0, strip2 = 0;
+	bool prox = false;
 
 	/* pad packets. Works as a second tool and is always in prox */
 	if (!(data[0] == WACOM_REPORT_INTUOSPAD || data[0] == WACOM_REPORT_INTUOS5PAD ||
@@ -458,72 +467,16 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 		return 0;
 
 	if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
-		input_report_key(input, BTN_0, (data[2] & 0x01));
-		input_report_key(input, BTN_1, (data[3] & 0x01));
-		input_report_key(input, BTN_2, (data[3] & 0x02));
-		input_report_key(input, BTN_3, (data[3] & 0x04));
-		input_report_key(input, BTN_4, (data[3] & 0x08));
-		input_report_key(input, BTN_5, (data[3] & 0x10));
-		input_report_key(input, BTN_6, (data[3] & 0x20));
-		if (data[1] & 0x80) {
-			input_report_abs(input, ABS_WHEEL, (data[1] & 0x7f));
-		} else {
-			/* Out of proximity, clear wheel value. */
-			input_report_abs(input, ABS_WHEEL, 0);
-		}
-		if (features->type != INTUOS4S) {
-			input_report_key(input, BTN_7, (data[3] & 0x40));
-			input_report_key(input, BTN_8, (data[3] & 0x80));
-		}
-		if (data[1] | (data[2] & 0x01) | data[3]) {
-			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-		} else {
-			input_report_abs(input, ABS_MISC, 0);
-		}
+		buttons = (data[3] << 1) | (data[2] & 0x01);
+		ring1 = data[1];
 	} else if (features->type == DTK) {
-		input_report_key(input, BTN_0, (data[6] & 0x01));
-		input_report_key(input, BTN_1, (data[6] & 0x02));
-		input_report_key(input, BTN_2, (data[6] & 0x04));
-		input_report_key(input, BTN_3, (data[6] & 0x08));
-		input_report_key(input, BTN_4, (data[6] & 0x10));
-		input_report_key(input, BTN_5, (data[6] & 0x20));
-		if (data[6] & 0x3f) {
-			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-		} else {
-			input_report_abs(input, ABS_MISC, 0);
-		}
+		buttons = data[6];
 	} else if (features->type == WACOM_13HD) {
-		input_report_key(input, BTN_0, (data[3] & 0x01));
-		input_report_key(input, BTN_1, (data[4] & 0x01));
-		input_report_key(input, BTN_2, (data[4] & 0x02));
-		input_report_key(input, BTN_3, (data[4] & 0x04));
-		input_report_key(input, BTN_4, (data[4] & 0x08));
-		input_report_key(input, BTN_5, (data[4] & 0x10));
-		input_report_key(input, BTN_6, (data[4] & 0x20));
-		input_report_key(input, BTN_7, (data[4] & 0x40));
-		input_report_key(input, BTN_8, (data[4] & 0x80));
-		if ((data[3] & 0x01) | data[4]) {
-			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-		} else {
-			input_report_abs(input, ABS_MISC, 0);
-		}
+		buttons = (data[4] << 1) | (data[3] & 0x01);
 	} else if (features->type == WACOM_24HD) {
-		input_report_key(input, BTN_0, (data[6] & 0x01));
-		input_report_key(input, BTN_1, (data[6] & 0x02));
-		input_report_key(input, BTN_2, (data[6] & 0x04));
-		input_report_key(input, BTN_3, (data[6] & 0x08));
-		input_report_key(input, BTN_4, (data[6] & 0x10));
-		input_report_key(input, BTN_5, (data[6] & 0x20));
-		input_report_key(input, BTN_6, (data[6] & 0x40));
-		input_report_key(input, BTN_7, (data[6] & 0x80));
-		input_report_key(input, BTN_8, (data[8] & 0x01));
-		input_report_key(input, BTN_9, (data[8] & 0x02));
-		input_report_key(input, BTN_A, (data[8] & 0x04));
-		input_report_key(input, BTN_B, (data[8] & 0x08));
-		input_report_key(input, BTN_C, (data[8] & 0x10));
-		input_report_key(input, BTN_X, (data[8] & 0x20));
-		input_report_key(input, BTN_Y, (data[8] & 0x40));
-		input_report_key(input, BTN_Z, (data[8] & 0x80));
+		buttons = (data[8] << 8) | data[6];
+		ring1 = data[1];
+		ring2 = data[2];
 
 		/*
 		 * Three "buttons" are available on the 24HD which are
@@ -532,160 +485,89 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 		 * The raw touchstrip bits are stored at:
 		 *    ((data[3] & 0x1f) << 8) | data[4])
 		 */
-		input_report_key(input, KEY_PROG1, data[4] & 0x07);
-		input_report_key(input, KEY_PROG2, data[4] & 0xE0);
-		input_report_key(input, KEY_PROG3, data[3] & 0x1C);
-
-		if (data[1] & 0x80) {
-			input_report_abs(input, ABS_WHEEL, (data[1] & 0x7f));
-		} else {
-			/* Out of proximity, clear wheel value. */
-			input_report_abs(input, ABS_WHEEL, 0);
-		}
-
-		if (data[2] & 0x80) {
-			input_report_abs(input, ABS_THROTTLE, (data[2] & 0x7f));
-		} else {
-			/* Out of proximity, clear second wheel value. */
-			input_report_abs(input, ABS_THROTTLE, 0);
-		}
-
-		if (data[1] | data[2] | (data[3] & 0x1f) | data[4] | data[6] | data[8]) {
-			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-		} else {
-			input_report_abs(input, ABS_MISC, 0);
-		}
+		nkeys = 3;
+		keys = ((data[3] & 0x1C) ? 1<<2 : 0) |
+		       ((data[4] & 0xE0) ? 1<<1 : 0) |
+		       ((data[4] & 0x07) ? 1<<0 : 0);
 	} else if (features->type == WACOM_27QHD) {
-		input_report_key(input, KEY_PROG1, data[2] & 0x01);
-		input_report_key(input, KEY_PROG2, data[2] & 0x02);
-		input_report_key(input, KEY_PROG3, data[2] & 0x04);
+		nkeys = 3;
+		keys = data[2] & 0x07;
 
 		input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[4]));
 		input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[6]));
 		input_report_abs(input, ABS_Z, be16_to_cpup((__be16 *)&data[8]));
-		if ((data[2] & 0x07) | data[4] | data[5] | data[6] | data[7] | data[8] | data[9]) {
-			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-		} else {
-			input_report_abs(input, ABS_MISC, 0);
-		}
 	} else if (features->type == CINTIQ_HYBRID) {
 		/*
 		 * Do not send hardware buttons under Android. They
 		 * are already sent to the system through GPIO (and
 		 * have different meaning).
+		 *
+		 * d-pad right  -> data[4] & 0x10
+		 * d-pad up     -> data[4] & 0x20
+		 * d-pad left   -> data[4] & 0x40
+		 * d-pad down   -> data[4] & 0x80
+		 * d-pad center -> data[3] & 0x01
 		 */
-		input_report_key(input, BTN_1, (data[4] & 0x01));
-		input_report_key(input, BTN_2, (data[4] & 0x02));
-		input_report_key(input, BTN_3, (data[4] & 0x04));
-		input_report_key(input, BTN_4, (data[4] & 0x08));
-
-		input_report_key(input, BTN_5, (data[4] & 0x10));  /* Right  */
-		input_report_key(input, BTN_6, (data[4] & 0x20));  /* Up     */
-		input_report_key(input, BTN_7, (data[4] & 0x40));  /* Left   */
-		input_report_key(input, BTN_8, (data[4] & 0x80));  /* Down   */
-		input_report_key(input, BTN_0, (data[3] & 0x01));  /* Center */
-
-		if (data[4] | (data[3] & 0x01)) {
-			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-		} else {
-			input_report_abs(input, ABS_MISC, 0);
-		}
-
+		buttons = (data[4] << 1) | (data[3] & 0x01);
 	} else if (features->type == CINTIQ_COMPANION_2) {
-		input_report_key(input, BTN_1, (data[1] & 0x02));
-		input_report_key(input, BTN_2, (data[2] & 0x01));
-		input_report_key(input, BTN_3, (data[2] & 0x02));
-		input_report_key(input, BTN_4, (data[2] & 0x04));
-		input_report_key(input, BTN_5, (data[2] & 0x08));
-		input_report_key(input, BTN_6, (data[1] & 0x04));
-
-		input_report_key(input, BTN_7, (data[2] & 0x10));  /* Right  */
-		input_report_key(input, BTN_8, (data[2] & 0x20));  /* Up	 */
-		input_report_key(input, BTN_9, (data[2] & 0x40));  /* Left   */
-		input_report_key(input, BTN_A, (data[2] & 0x80));  /* Down   */
-		input_report_key(input, BTN_0, (data[1] & 0x01));  /* Center */
-
-		if (data[2] | (data[1] & 0x07)) {
-			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-		} else {
-			input_report_abs(input, ABS_MISC, 0);
-		}
-
+		/* d-pad right  -> data[4] & 0x10
+		 * d-pad up     -> data[4] & 0x20
+		 * d-pad left   -> data[4] & 0x40
+		 * d-pad down   -> data[4] & 0x80
+		 * d-pad center -> data[3] & 0x01
+		 */
+		buttons = ((data[2] & 0xF0) << 7) |
+		          ((data[1] & 0x04) << 6) |
+		          ((data[2] & 0x0F) << 2) |
+		          (data[1] & 0x03);
 	} else if (features->type >= INTUOS5S && features->type <= INTUOSPL) {
-		int i;
-
-		/* Touch ring mode switch has no capacitive sensor */
-		input_report_key(input, BTN_0, (data[3] & 0x01));
-
 		/*
 		 * ExpressKeys on Intuos5/Intuos Pro have a capacitive sensor in
 		 * addition to the mechanical switch. Switch data is
 		 * stored in data[4], capacitive data in data[5].
+		 *
+		 * Touch ring mode switch (data[3]) has no capacitive sensor
 		 */
-		for (i = 0; i < 8; i++)
-			input_report_key(input, BTN_1 + i, data[4] & (1 << i));
-
-		if (data[2] & 0x80) {
-			input_report_abs(input, ABS_WHEEL, (data[2] & 0x7f));
-		} else {
-			/* Out of proximity, clear wheel value. */
-			input_report_abs(input, ABS_WHEEL, 0);
-		}
-
-		if (data[2] | (data[3] & 0x01) | data[4] | data[5]) {
-			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-		} else {
-			input_report_abs(input, ABS_MISC, 0);
-		}
+		buttons = (data[4] << 1) | (data[3] & 0x01);
+		ring1 = data[2];
 	} else {
 		if (features->type == WACOM_21UX2 || features->type == WACOM_22HD) {
-			input_report_key(input, BTN_0, (data[5] & 0x01));
-			input_report_key(input, BTN_1, (data[6] & 0x01));
-			input_report_key(input, BTN_2, (data[6] & 0x02));
-			input_report_key(input, BTN_3, (data[6] & 0x04));
-			input_report_key(input, BTN_4, (data[6] & 0x08));
-			input_report_key(input, BTN_5, (data[6] & 0x10));
-			input_report_key(input, BTN_6, (data[6] & 0x20));
-			input_report_key(input, BTN_7, (data[6] & 0x40));
-			input_report_key(input, BTN_8, (data[6] & 0x80));
-			input_report_key(input, BTN_9, (data[7] & 0x01));
-			input_report_key(input, BTN_A, (data[8] & 0x01));
-			input_report_key(input, BTN_B, (data[8] & 0x02));
-			input_report_key(input, BTN_C, (data[8] & 0x04));
-			input_report_key(input, BTN_X, (data[8] & 0x08));
-			input_report_key(input, BTN_Y, (data[8] & 0x10));
-			input_report_key(input, BTN_Z, (data[8] & 0x20));
-			input_report_key(input, BTN_BASE, (data[8] & 0x40));
-			input_report_key(input, BTN_BASE2, (data[8] & 0x80));
+			buttons = (data[8] << 10) | ((data[7] & 0x01) << 9) |
+			          (data[6] << 1) | (data[5] & 0x01);
 
 			if (features->type == WACOM_22HD) {
-				input_report_key(input, KEY_PROG1, data[9] & 0x01);
-				input_report_key(input, KEY_PROG2, data[9] & 0x02);
-				input_report_key(input, KEY_PROG3, data[9] & 0x04);
+				nkeys = 3;
+				keys = data[9] & 0x07;
 			}
 		} else {
-			input_report_key(input, BTN_0, (data[5] & 0x01));
-			input_report_key(input, BTN_1, (data[5] & 0x02));
-			input_report_key(input, BTN_2, (data[5] & 0x04));
-			input_report_key(input, BTN_3, (data[5] & 0x08));
-			input_report_key(input, BTN_4, (data[6] & 0x01));
-			input_report_key(input, BTN_5, (data[6] & 0x02));
-			input_report_key(input, BTN_6, (data[6] & 0x04));
-			input_report_key(input, BTN_7, (data[6] & 0x08));
-			input_report_key(input, BTN_8, (data[5] & 0x10));
-			input_report_key(input, BTN_9, (data[6] & 0x10));
-		}
-		input_report_abs(input, ABS_RX, ((data[1] & 0x1f) << 8) | data[2]);
-		input_report_abs(input, ABS_RY, ((data[3] & 0x1f) << 8) | data[4]);
-
-		if ((data[5] & 0x1f) | data[6] | (data[1] & 0x1f) |
-			data[2] | (data[3] & 0x1f) | data[4] | data[8] |
-			(data[7] & 0x01)) {
-			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-		} else {
-			input_report_abs(input, ABS_MISC, 0);
+			buttons = ((data[6] & 0x10) << 10) |
+			          ((data[5] & 0x10) << 9)  |
+			          ((data[6] & 0x0F) << 4)  |
+			          (data[5] & 0x0F);
 		}
+		strip1 = (data[1] << 8) || data[2];
+		strip2 = (data[3] << 8) || data[4];
 	}
+
+	prox = (buttons & ~(~0 << nbuttons)) || (keys & ~(~0 << nkeys)) ||
+	       (ring1 & 0x80) || (ring2 & 0x80) || strip1 || strip2;
+
+	wacom_report_numbered_buttons(input, nbuttons, buttons);
+
+	for (i = 0; i < nkeys; i++)
+		input_report_key(input, KEY_PROG1 + i, keys & (1 << i));
+
+	input_report_abs(input, ABS_RX, strip1);
+	input_report_abs(input, ABS_RX, strip2);
+
+	input_report_abs(input, ABS_WHEEL,    ring1 & 0x7f ? ring1 : 0);
+	input_report_abs(input, ABS_THROTTLE, ring2 & 0x07 ? ring2 : 0);
+
+	input_report_key(input, wacom->tool[1], prox ? 1 : 0);
+	input_report_abs(input, ABS_MISC, prox ? PAD_DEVICE_ID : 0);
+
+	input_event(input, EV_MSC, MSC_SERIAL, 0xffffffff);
+
 	return 1;
 }
 
@@ -2818,6 +2700,19 @@ static void wacom_setup_numbered_buttons(struct input_dev *input_dev,
 		__set_bit(BTN_BASE + (i-16), input_dev->keybit);
 }
 
+static void wacom_report_numbered_buttons(struct input_dev *input_dev,
+				int button_count, int mask)
+{
+	int i;
+
+	for (i = 0; i < button_count && i < 10; i++)
+		input_report_key(input_dev, BTN_0 + i, mask & (1 << i));
+	for (i = 10; i < button_count && i < 16; i++)
+		input_report_key(input_dev, BTN_A + (i-10), mask & (1 << i));
+	for (i = 16; i < button_count && i < 18; i++)
+		input_report_key(input_dev, BTN_BASE + (i-16), mask & (1 << i));
+}
+
 int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 				   struct wacom_wac *wacom_wac)
 {
-- 
2.6.2

