From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 08/13] HID: wiimote: map classic controller as gamepad
Date: Fri,  1 Nov 2013 21:16:19 +0100
Message-ID: <1383336984-26601-9-git-send-email-dh.herrmann@gmail.com>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:38449 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3KAUQ5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 16:16:57 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so2253680eak.22
        for <linux-input@vger.kernel.org>; Fri, 01 Nov 2013 13:16:55 -0700 (PDT)
In-Reply-To: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Adjust the mappings for the classic-controller extension so it's reported
as normal gamepad. Keep the compatibility mappings so legacy-mode still
works.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-modules.c | 144 ++++++++++++++++++++++++++------------
 1 file changed, 100 insertions(+), 44 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index a02059c..f3de94e 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -1090,7 +1090,7 @@ enum wiimod_classic_keys {
 	WIIMOD_CLASSIC_KEY_NUM,
 };
 
-static const __u16 wiimod_classic_map[] = {
+static const __u16 wiimod_classic_map_legacy[] = {
 	BTN_A,		/* WIIMOD_CLASSIC_KEY_A */
 	BTN_B,		/* WIIMOD_CLASSIC_KEY_B */
 	BTN_X,		/* WIIMOD_CLASSIC_KEY_X */
@@ -1108,10 +1108,32 @@ static const __u16 wiimod_classic_map[] = {
 	BTN_TR,		/* WIIMOD_CLASSIC_KEY_RT */
 };
 
+static const __u16 wiimod_classic_map[] = {
+	BTN_EAST,		/* WIIMOD_CLASSIC_KEY_A */
+	BTN_SOUTH,		/* WIIMOD_CLASSIC_KEY_B */
+	BTN_NORTH,		/* WIIMOD_CLASSIC_KEY_X */
+	BTN_WEST,		/* WIIMOD_CLASSIC_KEY_Y */
+	BTN_TL2,		/* WIIMOD_CLASSIC_KEY_ZL */
+	BTN_TR2,		/* WIIMOD_CLASSIC_KEY_ZR */
+	BTN_START,		/* WIIMOD_CLASSIC_KEY_PLUS */
+	BTN_SELECT,		/* WIIMOD_CLASSIC_KEY_MINUS */
+	BTN_MODE,		/* WIIMOD_CLASSIC_KEY_HOME */
+	BTN_DPAD_LEFT,		/* WIIMOD_CLASSIC_KEY_LEFT */
+	BTN_DPAD_RIGHT,		/* WIIMOD_CLASSIC_KEY_RIGHT */
+	BTN_DPAD_UP,		/* WIIMOD_CLASSIC_KEY_UP */
+	BTN_DPAD_DOWN,		/* WIIMOD_CLASSIC_KEY_DOWN */
+	BTN_TL,			/* WIIMOD_CLASSIC_KEY_LT */
+	BTN_TR,			/* WIIMOD_CLASSIC_KEY_RT */
+};
+
 static void wiimod_classic_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 {
+	const __u16 *map = wiimod_classic_map;
 	__s8 rx, ry, lx, ly, lt, rt;
 
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY)
+		map = wiimod_classic_map_legacy;
+
 	/*   Byte |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |
 	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
 	 *    1   | RX <5:4>  |              LX <5:0>             |
@@ -1177,66 +1199,75 @@ static void wiimod_classic_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 	rt <<= 1;
 	lt <<= 1;
 
-	input_report_abs(wdata->extension.input, ABS_HAT1X, lx - 0x20);
-	input_report_abs(wdata->extension.input, ABS_HAT1Y, ly - 0x20);
-	input_report_abs(wdata->extension.input, ABS_HAT2X, rx - 0x20);
-	input_report_abs(wdata->extension.input, ABS_HAT2Y, ry - 0x20);
-	input_report_abs(wdata->extension.input, ABS_HAT3X, rt);
-	input_report_abs(wdata->extension.input, ABS_HAT3Y, lt);
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY) {
+		input_report_abs(wdata->extension.input, ABS_HAT1X, lx - 0x20);
+		input_report_abs(wdata->extension.input, ABS_HAT1Y, ly - 0x20);
+		input_report_abs(wdata->extension.input, ABS_HAT2X, rx - 0x20);
+		input_report_abs(wdata->extension.input, ABS_HAT2Y, ry - 0x20);
+		input_report_abs(wdata->extension.input, ABS_HAT3X, rt);
+		input_report_abs(wdata->extension.input, ABS_HAT3Y, lt);
+	} else {
+		input_report_abs(wdata->extension.input, ABS_X, lx - 0x20);
+		input_report_abs(wdata->extension.input, ABS_Y, 0x20 - ly);
+		input_report_abs(wdata->extension.input, ABS_RX, rx - 0x20);
+		input_report_abs(wdata->extension.input, ABS_RY, 0x20 - ry);
+		input_report_abs(wdata->extension.input, ABS_HAT1X, rt);
+		input_report_abs(wdata->extension.input, ABS_HAT1Y, lt);
+	}
 
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_RIGHT],
+			 map[WIIMOD_CLASSIC_KEY_RIGHT],
 			 !(ext[4] & 0x80));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_DOWN],
+			 map[WIIMOD_CLASSIC_KEY_DOWN],
 			 !(ext[4] & 0x40));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_LT],
+			 map[WIIMOD_CLASSIC_KEY_LT],
 			 !(ext[4] & 0x20));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_MINUS],
+			 map[WIIMOD_CLASSIC_KEY_MINUS],
 			 !(ext[4] & 0x10));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_HOME],
+			 map[WIIMOD_CLASSIC_KEY_HOME],
 			 !(ext[4] & 0x08));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_PLUS],
+			 map[WIIMOD_CLASSIC_KEY_PLUS],
 			 !(ext[4] & 0x04));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_RT],
+			 map[WIIMOD_CLASSIC_KEY_RT],
 			 !(ext[4] & 0x02));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_ZL],
+			 map[WIIMOD_CLASSIC_KEY_ZL],
 			 !(ext[5] & 0x80));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_B],
+			 map[WIIMOD_CLASSIC_KEY_B],
 			 !(ext[5] & 0x40));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_Y],
+			 map[WIIMOD_CLASSIC_KEY_Y],
 			 !(ext[5] & 0x20));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_A],
+			 map[WIIMOD_CLASSIC_KEY_A],
 			 !(ext[5] & 0x10));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_X],
+			 map[WIIMOD_CLASSIC_KEY_X],
 			 !(ext[5] & 0x08));
 	input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_ZR],
+			 map[WIIMOD_CLASSIC_KEY_ZR],
 			 !(ext[5] & 0x04));
 
 	if (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE) {
 		input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_LEFT],
+			 map[WIIMOD_CLASSIC_KEY_LEFT],
 			 !(ext[1] & 0x01));
 		input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_UP],
+			 map[WIIMOD_CLASSIC_KEY_UP],
 			 !(ext[0] & 0x01));
 	} else {
 		input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_LEFT],
+			 map[WIIMOD_CLASSIC_KEY_LEFT],
 			 !(ext[5] & 0x02));
 		input_report_key(wdata->extension.input,
-			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_UP],
+			 map[WIIMOD_CLASSIC_KEY_UP],
 			 !(ext[5] & 0x01));
 	}
 
@@ -1270,12 +1301,16 @@ static void wiimod_classic_close(struct input_dev *dev)
 static int wiimod_classic_probe(const struct wiimod_ops *ops,
 				struct wiimote_data *wdata)
 {
+	const __u16 *map = wiimod_classic_map;
 	int ret, i;
 
 	wdata->extension.input = input_allocate_device();
 	if (!wdata->extension.input)
 		return -ENOMEM;
 
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY)
+		map = wiimod_classic_map_legacy;
+
 	input_set_drvdata(wdata->extension.input, wdata);
 	wdata->extension.input->open = wiimod_classic_open;
 	wdata->extension.input->close = wiimod_classic_close;
@@ -1288,28 +1323,49 @@ static int wiimod_classic_probe(const struct wiimod_ops *ops,
 
 	set_bit(EV_KEY, wdata->extension.input->evbit);
 	for (i = 0; i < WIIMOD_CLASSIC_KEY_NUM; ++i)
-		set_bit(wiimod_classic_map[i],
-			wdata->extension.input->keybit);
+		set_bit(map[i], wdata->extension.input->keybit);
 
 	set_bit(EV_ABS, wdata->extension.input->evbit);
-	set_bit(ABS_HAT1X, wdata->extension.input->absbit);
-	set_bit(ABS_HAT1Y, wdata->extension.input->absbit);
-	set_bit(ABS_HAT2X, wdata->extension.input->absbit);
-	set_bit(ABS_HAT2Y, wdata->extension.input->absbit);
-	set_bit(ABS_HAT3X, wdata->extension.input->absbit);
-	set_bit(ABS_HAT3Y, wdata->extension.input->absbit);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_HAT1X, -30, 30, 1, 1);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_HAT1Y, -30, 30, 1, 1);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_HAT2X, -30, 30, 1, 1);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_HAT2Y, -30, 30, 1, 1);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_HAT3X, -30, 30, 1, 1);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_HAT3Y, -30, 30, 1, 1);
+
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY) {
+		set_bit(ABS_HAT1X, wdata->extension.input->absbit);
+		set_bit(ABS_HAT1Y, wdata->extension.input->absbit);
+		set_bit(ABS_HAT2X, wdata->extension.input->absbit);
+		set_bit(ABS_HAT2Y, wdata->extension.input->absbit);
+		set_bit(ABS_HAT3X, wdata->extension.input->absbit);
+		set_bit(ABS_HAT3Y, wdata->extension.input->absbit);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_HAT1X, -30, 30, 1, 1);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_HAT1Y, -30, 30, 1, 1);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_HAT2X, -30, 30, 1, 1);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_HAT2Y, -30, 30, 1, 1);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_HAT3X, -30, 30, 1, 1);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_HAT3Y, -30, 30, 1, 1);
+	} else {
+		set_bit(ABS_X, wdata->extension.input->absbit);
+		set_bit(ABS_Y, wdata->extension.input->absbit);
+		set_bit(ABS_RX, wdata->extension.input->absbit);
+		set_bit(ABS_RY, wdata->extension.input->absbit);
+		set_bit(ABS_HAT1X, wdata->extension.input->absbit);
+		set_bit(ABS_HAT1Y, wdata->extension.input->absbit);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_X, -24, 24, 1, 1);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_Y, -24, 24, 1, 1);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_RX, -24, 24, 1, 1);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_RY, -24, 24, 1, 1);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_HAT1X, 0, 52, 1, 1);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_HAT1Y, 0, 52, 1, 1);
+	}
 
 	ret = input_register_device(wdata->extension.input);
 	if (ret)
-- 
1.8.4.1

