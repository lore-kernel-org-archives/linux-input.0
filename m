From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 09/13] HID: wiimote: use ABS_ACCEL_* for accelerometer
Date: Fri,  1 Nov 2013 21:16:20 +0100
Message-ID: <1383336984-26601-10-git-send-email-dh.herrmann@gmail.com>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:41988 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3KAUQ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 16:16:58 -0400
Received: by mail-ee0-f47.google.com with SMTP id c13so3196eek.34
        for <linux-input@vger.kernel.org>; Fri, 01 Nov 2013 13:16:57 -0700 (PDT)
In-Reply-To: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Use the new ABS_ACCEL_* bits for accelerometer data _iff_ legacy mode is
not selected. ABS_R? is confusing and ambigiuous. ABS_ACCEL_* was
introduced exactly for accelerometers like the one of the wiimote.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-modules.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index f3de94e..777f932 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -477,9 +477,16 @@ static void wiimod_accel_in_accel(struct wiimote_data *wdata,
 	y |= (accel[1] >> 4) & 0x2;
 	z |= (accel[1] >> 5) & 0x2;
 
-	input_report_abs(wdata->accel, ABS_RX, x - 0x200);
-	input_report_abs(wdata->accel, ABS_RY, y - 0x200);
-	input_report_abs(wdata->accel, ABS_RZ, z - 0x200);
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY) {
+		input_report_abs(wdata->accel, ABS_RX, x - 0x200);
+		input_report_abs(wdata->accel, ABS_RY, y - 0x200);
+		input_report_abs(wdata->accel, ABS_RZ, z - 0x200);
+	} else {
+		input_report_abs(wdata->accel, ABS_ACCEL_X, x - 0x200);
+		input_report_abs(wdata->accel, ABS_ACCEL_Y, y - 0x200);
+		input_report_abs(wdata->accel, ABS_ACCEL_Z, z - 0x200);
+	}
+
 	input_sync(wdata->accel);
 }
 
@@ -525,12 +532,25 @@ static int wiimod_accel_probe(const struct wiimod_ops *ops,
 	wdata->accel->name = WIIMOTE_NAME " Accelerometer";
 
 	set_bit(EV_ABS, wdata->accel->evbit);
-	set_bit(ABS_RX, wdata->accel->absbit);
-	set_bit(ABS_RY, wdata->accel->absbit);
-	set_bit(ABS_RZ, wdata->accel->absbit);
-	input_set_abs_params(wdata->accel, ABS_RX, -500, 500, 2, 4);
-	input_set_abs_params(wdata->accel, ABS_RY, -500, 500, 2, 4);
-	input_set_abs_params(wdata->accel, ABS_RZ, -500, 500, 2, 4);
+
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY) {
+		set_bit(ABS_RX, wdata->accel->absbit);
+		set_bit(ABS_RY, wdata->accel->absbit);
+		set_bit(ABS_RZ, wdata->accel->absbit);
+		input_set_abs_params(wdata->accel, ABS_RX, -500, 500, 2, 4);
+		input_set_abs_params(wdata->accel, ABS_RY, -500, 500, 2, 4);
+		input_set_abs_params(wdata->accel, ABS_RZ, -500, 500, 2, 4);
+	} else {
+		set_bit(ABS_ACCEL_X, wdata->accel->absbit);
+		set_bit(ABS_ACCEL_Y, wdata->accel->absbit);
+		set_bit(ABS_ACCEL_Z, wdata->accel->absbit);
+		input_set_abs_params(wdata->accel, ABS_ACCEL_X,
+				     -500, 500, 2, 4);
+		input_set_abs_params(wdata->accel, ABS_ACCEL_Y,
+				     -500, 500, 2, 4);
+		input_set_abs_params(wdata->accel, ABS_ACCEL_Z,
+				     -500, 500, 2, 4);
+	}
 
 	ret = input_register_device(wdata->accel);
 	if (ret) {
-- 
1.8.4.1

