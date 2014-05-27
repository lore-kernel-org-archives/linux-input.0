From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/3] Input: wacom - Don't declare ABS_X/Y for multitouch
Date: Tue, 27 May 2014 16:18:07 -0700
Message-ID: <1401232687-9738-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:44368 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbaE0XRy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 May 2014 19:17:54 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so85710pab.36
        for <linux-input@vger.kernel.org>; Tue, 27 May 2014 16:17:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

We use ABS_MT_POSITION_X/Y for multitouch (touch_max > 1) events now.
No need to declare ABS_X/Y for touch_max == 2 any more.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Jason Gerecke <killertofu@gmail.com>
Tested-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c98e51c..0eb9960 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1217,8 +1217,8 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 			 * a=(pi*r^2)/C.
 			 */
 			int a = data[5];
-			int x_res  = input_abs_get_res(input, ABS_X);
-			int y_res  = input_abs_get_res(input, ABS_Y);
+			int x_res  = input_abs_get_res(input, ABS_MT_POSITION_X);
+			int y_res  = input_abs_get_res(input, ABS_MT_POSITION_Y);
 			width  = 2 * int_sqrt(a * WACOM_CONTACT_AREA_SCALE);
 			height = width * y_res / x_res;
 		}
@@ -1587,7 +1587,7 @@ static void wacom_abs_set_axis(struct input_dev *input_dev,
 		input_abs_set_res(input_dev, ABS_X, features->x_resolution);
 		input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
 	} else {
-		if (features->touch_max <= 2) {
+		if (features->touch_max == 1) {
 			input_set_abs_params(input_dev, ABS_X, 0,
 				features->x_max, features->x_fuzz, 0);
 			input_set_abs_params(input_dev, ABS_Y, 0,
-- 
1.9.1

