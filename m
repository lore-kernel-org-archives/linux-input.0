From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Input: wacom - cleanup multitouch code when touch_max is 2
Date: Thu, 29 May 2014 13:03:11 -0700
Message-ID: <1401393791-15614-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:41106 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbaE2UC4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 16:02:56 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so867405pbb.27
        for <linux-input@vger.kernel.org>; Thu, 29 May 2014 13:02:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Historically we dealt with touch_max equals to 2 differently from
other MT devices. Now we use input_mt_*() to process all MT events,
as long as touch_max is greater than 1. So, there is no need to
take (touch_max == 2) as a special case any more.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 977d05c..964db47 100644
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
@@ -1815,14 +1815,8 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case MTTPC:
 	case MTTPC_B:
 	case TABLETPC2FG:
-		if (features->device_type == BTN_TOOL_FINGER) {
-			unsigned int flags = INPUT_MT_DIRECT;
-
-			if (wacom_wac->features.type == TABLETPC2FG)
-				flags = 0;
-
-			input_mt_init_slots(input_dev, features->touch_max, flags);
-		}
+		if ((features->device_type == BTN_TOOL_FINGER) && features->touch_max > 1)
+			input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_DIRECT);
 		/* fall through */
 
 	case TABLETPC:
@@ -1883,10 +1877,6 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 			__set_bit(BTN_RIGHT, input_dev->keybit);
 
 			if (features->touch_max) {
-				/* touch interface */
-				unsigned int flags = INPUT_MT_POINTER;
-
-				__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 				if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
 					input_set_abs_params(input_dev,
 						     ABS_MT_TOUCH_MAJOR,
@@ -1894,12 +1884,8 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 					input_set_abs_params(input_dev,
 						     ABS_MT_TOUCH_MINOR,
 						     0, features->y_max, 0, 0);
-				} else {
-					__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
-					__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
-					flags = 0;
 				}
-				input_mt_init_slots(input_dev, features->touch_max, flags);
+				input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
 			} else {
 				/* buttons/keys only interface */
 				__clear_bit(ABS_X, input_dev->absbit);
-- 
1.9.1

