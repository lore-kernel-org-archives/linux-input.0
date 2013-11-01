From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 10/13] HID: wiimote: use ABS_GYRO_* bits for MP
Date: Fri,  1 Nov 2013 21:16:21 +0100
Message-ID: <1383336984-26601-11-git-send-email-dh.herrmann@gmail.com>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:62992 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3KAURA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 16:17:00 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so2226701ead.7
        for <linux-input@vger.kernel.org>; Fri, 01 Nov 2013 13:16:59 -0700 (PDT)
In-Reply-To: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Use the new gyroscope bits for motion-plus. The used ABS_R? bits are
ambiguous and should be replaced by proper bits to not confuse generic
user-space.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-modules.c | 44 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 777f932..e51e82b 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -2222,9 +2222,16 @@ static void wiimod_mp_in_mp(struct wiimote_data *wdata, const __u8 *ext)
 	else
 		z *= 9;
 
-	input_report_abs(wdata->mp, ABS_RX, x);
-	input_report_abs(wdata->mp, ABS_RY, y);
-	input_report_abs(wdata->mp, ABS_RZ, z);
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY) {
+		input_report_abs(wdata->mp, ABS_RX, x);
+		input_report_abs(wdata->mp, ABS_RY, y);
+		input_report_abs(wdata->mp, ABS_RZ, z);
+	} else {
+		input_report_abs(wdata->mp, ABS_GYRO_X, x);
+		input_report_abs(wdata->mp, ABS_GYRO_Y, y);
+		input_report_abs(wdata->mp, ABS_GYRO_Z, z);
+	}
+
 	input_sync(wdata->mp);
 }
 
@@ -2274,15 +2281,28 @@ static int wiimod_mp_probe(const struct wiimod_ops *ops,
 	wdata->mp->name = WIIMOTE_NAME " Motion Plus";
 
 	set_bit(EV_ABS, wdata->mp->evbit);
-	set_bit(ABS_RX, wdata->mp->absbit);
-	set_bit(ABS_RY, wdata->mp->absbit);
-	set_bit(ABS_RZ, wdata->mp->absbit);
-	input_set_abs_params(wdata->mp,
-			     ABS_RX, -16000, 16000, 4, 8);
-	input_set_abs_params(wdata->mp,
-			     ABS_RY, -16000, 16000, 4, 8);
-	input_set_abs_params(wdata->mp,
-			     ABS_RZ, -16000, 16000, 4, 8);
+
+	if (wdata->state.flags & WIIPROTO_FLAG_LEGACY) {
+		set_bit(ABS_RX, wdata->mp->absbit);
+		set_bit(ABS_RY, wdata->mp->absbit);
+		set_bit(ABS_RZ, wdata->mp->absbit);
+		input_set_abs_params(wdata->mp,
+				     ABS_RX, -16000, 16000, 4, 8);
+		input_set_abs_params(wdata->mp,
+				     ABS_RY, -16000, 16000, 4, 8);
+		input_set_abs_params(wdata->mp,
+				     ABS_RZ, -16000, 16000, 4, 8);
+	} else {
+		set_bit(ABS_GYRO_X, wdata->mp->absbit);
+		set_bit(ABS_GYRO_Y, wdata->mp->absbit);
+		set_bit(ABS_GYRO_Z, wdata->mp->absbit);
+		input_set_abs_params(wdata->mp,
+				     ABS_GYRO_X, -16000, 16000, 4, 8);
+		input_set_abs_params(wdata->mp,
+				     ABS_GYRO_Y, -16000, 16000, 4, 8);
+		input_set_abs_params(wdata->mp,
+				     ABS_GYRO_Z, -16000, 16000, 4, 8);
+	}
 
 	ret = input_register_device(wdata->mp);
 	if (ret)
-- 
1.8.4.1

