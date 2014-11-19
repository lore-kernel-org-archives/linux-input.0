From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/2] HID: wacom: Report ABS_TILT_{X,Y} as signed values
Date: Tue, 18 Nov 2014 16:50:08 -0800
Message-ID: <1416358209-3937-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38651 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbaKSAu1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Nov 2014 19:50:27 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so6697299pab.6
        for <linux-input@vger.kernel.org>; Tue, 18 Nov 2014 16:50:27 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, benjamin.tissores@gmail.com, Jason Gerecke <killertofu@gmail.com>

Centers the ABS_TILT_{X,Y} axes so that a value of zero is reported when
the pen is vertical. Combined with resolution information in the next
patch, this makes it possible for userspace to calculate the pen angle
without needing hardware-specific knowledge. The xf86-input-wacom driver
was updated to support signed tilt values in late-2012 (2f2acec).

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom_wac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 8a83da9..525b648 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -600,8 +600,8 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 		}
 		input_report_abs(input, ABS_PRESSURE, t);
 		input_report_abs(input, ABS_TILT_X,
-				((data[7] << 1) & 0x7e) | (data[8] >> 7));
-		input_report_abs(input, ABS_TILT_Y, data[8] & 0x7f);
+				 (((data[7] << 1) & 0x7e) | (data[8] >> 7)) - 64);
+		input_report_abs(input, ABS_TILT_Y, (data[8] & 0x7f) - 64);
 		input_report_key(input, BTN_STYLUS, data[1] & 2);
 		input_report_key(input, BTN_STYLUS2, data[1] & 4);
 		input_report_key(input, BTN_TOUCH, t > 10);
@@ -612,8 +612,8 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 		input_report_abs(input, ABS_WHEEL,
 				(data[6] << 2) | ((data[7] >> 6) & 3));
 		input_report_abs(input, ABS_TILT_X,
-				((data[7] << 1) & 0x7e) | (data[8] >> 7));
-		input_report_abs(input, ABS_TILT_Y, data[8] & 0x7f);
+				 (((data[7] << 1) & 0x7e) | (data[8] >> 7)) - 64);
+		input_report_abs(input, ABS_TILT_Y, (data[8] & 0x7f) - 64);
 	}
 }
 
@@ -915,8 +915,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 				input_report_key(input, BTN_EXTRA,  data[6] & 0x10);
 
 				input_report_abs(input, ABS_TILT_X,
-					((data[7] << 1) & 0x7e) | (data[8] >> 7));
-				input_report_abs(input, ABS_TILT_Y, data[8] & 0x7f);
+					(((data[7] << 1) & 0x7e) | (data[8] >> 7)) - 64);
+				input_report_abs(input, ABS_TILT_Y, (data[8] & 0x7f) - 64);
 			} else {
 				/* 2D mouse packet */
 				input_report_key(input, BTN_LEFT,   data[8] & 0x04);
@@ -1926,8 +1926,8 @@ static void wacom_setup_cintiq(struct wacom_wac *wacom_wac)
 	input_set_abs_params(input_dev, ABS_DISTANCE,
 			     0, wacom_wac->features.distance_max, 0, 0);
 	input_set_abs_params(input_dev, ABS_WHEEL, 0, 1023, 0, 0);
-	input_set_abs_params(input_dev, ABS_TILT_X, 0, 127, 0, 0);
-	input_set_abs_params(input_dev, ABS_TILT_Y, 0, 127, 0, 0);
+	input_set_abs_params(input_dev, ABS_TILT_X, -64, 63, 0, 0);
+	input_set_abs_params(input_dev, ABS_TILT_Y, -64, 63, 0, 0);
 }
 
 static void wacom_setup_intuos(struct wacom_wac *wacom_wac)
-- 
2.1.3

