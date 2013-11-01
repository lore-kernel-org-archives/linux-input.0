From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 07/13] HID: wiimote: map nunchuk as real gamepad
Date: Fri,  1 Nov 2013 21:16:18 +0100
Message-ID: <1383336984-26601-8-git-send-email-dh.herrmann@gmail.com>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:40210 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3KAUQz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 16:16:55 -0400
Received: by mail-ee0-f48.google.com with SMTP id d49so4936eek.7
        for <linux-input@vger.kernel.org>; Fri, 01 Nov 2013 13:16:54 -0700 (PDT)
In-Reply-To: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

The nunchuk device can easily be used as reduced gamepad. Add a new
mapping according to linux gamepad rules.

Note that we map it as gamepad with:
 - one analog-stick (left)
 - two trigger buttons (left upper+lower)
 - accelerometer

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-modules.c | 94 ++++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 372fec1..a02059c 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -839,15 +839,24 @@ enum wiimod_nunchuk_keys {
 	WIIMOD_NUNCHUK_KEY_NUM,
 };
 
-static const __u16 wiimod_nunchuk_map[] = {
+static const __u16 wiimod_nunchuk_map_legacy[] = {
 	BTN_C,		/* WIIMOD_NUNCHUK_KEY_C */
 	BTN_Z,		/* WIIMOD_NUNCHUK_KEY_Z */
 };
 
+static const __u16 wiimod_nunchuk_map[] = {
+	BTN_TL,		/* WIIMOD_NUNCHUK_KEY_C */
+	BTN_TL2,	/* WIIMOD_NUNCHUK_KEY_Z */
+};
+
 static void wiimod_nunchuk_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 {
+	const __u16 *map = wiimod_nunchuk_map;
 	__s16 x, y, z, bx, by;
 
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY)
+		map = wiimod_nunchuk_map_legacy;
+
 	/*   Byte |   8    7 |  6    5 |  4    3 |  2 |  1  |
 	 *   -----+----------+---------+---------+----+-----+
 	 *    1   |              Button X <7:0>             |
@@ -902,26 +911,35 @@ static void wiimod_nunchuk_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 	y -= 0x200;
 	z -= 0x200;
 
-	input_report_abs(wdata->extension.input, ABS_HAT0X, bx);
-	input_report_abs(wdata->extension.input, ABS_HAT0Y, by);
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY) {
+		input_report_abs(wdata->extension.input, ABS_HAT0X, bx);
+		input_report_abs(wdata->extension.input, ABS_HAT0Y, by);
 
-	input_report_abs(wdata->extension.input, ABS_RX, x);
-	input_report_abs(wdata->extension.input, ABS_RY, y);
-	input_report_abs(wdata->extension.input, ABS_RZ, z);
+		input_report_abs(wdata->extension.input, ABS_RX, x);
+		input_report_abs(wdata->extension.input, ABS_RY, y);
+		input_report_abs(wdata->extension.input, ABS_RZ, z);
+	} else {
+		input_report_abs(wdata->extension.input, ABS_X, bx);
+		input_report_abs(wdata->extension.input, ABS_Y, -by);
+
+		input_report_abs(wdata->extension.input, ABS_ACCEL_X, x);
+		input_report_abs(wdata->extension.input, ABS_ACCEL_Y, y);
+		input_report_abs(wdata->extension.input, ABS_ACCEL_Z, z);
+	}
 
 	if (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE) {
 		input_report_key(wdata->extension.input,
-			wiimod_nunchuk_map[WIIMOD_NUNCHUK_KEY_Z],
+			map[WIIMOD_NUNCHUK_KEY_Z],
 			!(ext[5] & 0x04));
 		input_report_key(wdata->extension.input,
-			wiimod_nunchuk_map[WIIMOD_NUNCHUK_KEY_C],
+			map[WIIMOD_NUNCHUK_KEY_C],
 			!(ext[5] & 0x08));
 	} else {
 		input_report_key(wdata->extension.input,
-			wiimod_nunchuk_map[WIIMOD_NUNCHUK_KEY_Z],
+			map[WIIMOD_NUNCHUK_KEY_Z],
 			!(ext[5] & 0x01));
 		input_report_key(wdata->extension.input,
-			wiimod_nunchuk_map[WIIMOD_NUNCHUK_KEY_C],
+			map[WIIMOD_NUNCHUK_KEY_C],
 			!(ext[5] & 0x02));
 	}
 
@@ -955,12 +973,16 @@ static void wiimod_nunchuk_close(struct input_dev *dev)
 static int wiimod_nunchuk_probe(const struct wiimod_ops *ops,
 				struct wiimote_data *wdata)
 {
+	const __u16 *map = wiimod_nunchuk_map;
 	int ret, i;
 
 	wdata->extension.input = input_allocate_device();
 	if (!wdata->extension.input)
 		return -ENOMEM;
 
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY)
+		map = wiimod_nunchuk_map_legacy;
+
 	input_set_drvdata(wdata->extension.input, wdata);
 	wdata->extension.input->open = wiimod_nunchuk_open;
 	wdata->extension.input->close = wiimod_nunchuk_close;
@@ -973,25 +995,43 @@ static int wiimod_nunchuk_probe(const struct wiimod_ops *ops,
 
 	set_bit(EV_KEY, wdata->extension.input->evbit);
 	for (i = 0; i < WIIMOD_NUNCHUK_KEY_NUM; ++i)
-		set_bit(wiimod_nunchuk_map[i],
-			wdata->extension.input->keybit);
+		set_bit(map[i], wdata->extension.input->keybit);
 
 	set_bit(EV_ABS, wdata->extension.input->evbit);
-	set_bit(ABS_HAT0X, wdata->extension.input->absbit);
-	set_bit(ABS_HAT0Y, wdata->extension.input->absbit);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_HAT0X, -120, 120, 2, 4);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_HAT0Y, -120, 120, 2, 4);
-	set_bit(ABS_RX, wdata->extension.input->absbit);
-	set_bit(ABS_RY, wdata->extension.input->absbit);
-	set_bit(ABS_RZ, wdata->extension.input->absbit);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_RX, -500, 500, 2, 4);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_RY, -500, 500, 2, 4);
-	input_set_abs_params(wdata->extension.input,
-			     ABS_RZ, -500, 500, 2, 4);
+
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY) {
+		set_bit(ABS_HAT0X, wdata->extension.input->absbit);
+		set_bit(ABS_HAT0Y, wdata->extension.input->absbit);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_HAT0X, -120, 120, 2, 4);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_HAT0Y, -120, 120, 2, 4);
+		set_bit(ABS_RX, wdata->extension.input->absbit);
+		set_bit(ABS_RY, wdata->extension.input->absbit);
+		set_bit(ABS_RZ, wdata->extension.input->absbit);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_RX, -500, 500, 2, 4);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_RY, -500, 500, 2, 4);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_RZ, -500, 500, 2, 4);
+	} else {
+		set_bit(ABS_X, wdata->extension.input->absbit);
+		set_bit(ABS_Y, wdata->extension.input->absbit);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_X, -120, 120, 2, 4);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_Y, -120, 120, 2, 4);
+		set_bit(ABS_ACCEL_X, wdata->extension.input->absbit);
+		set_bit(ABS_ACCEL_Y, wdata->extension.input->absbit);
+		set_bit(ABS_ACCEL_Z, wdata->extension.input->absbit);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_ACCEL_X, -500, 500, 2, 4);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_ACCEL_Y, -500, 500, 2, 4);
+		input_set_abs_params(wdata->extension.input,
+				     ABS_ACCEL_Z, -500, 500, 2, 4);
+	}
 
 	ret = input_register_device(wdata->extension.input);
 	if (ret)
-- 
1.8.4.1

