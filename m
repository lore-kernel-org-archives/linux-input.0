From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] input: wacom - Pass touch resolution to clients through input_absinfo
Date: Sun, 23 Jan 2011 15:26:41 -0800
Message-ID: <1295825201-12567-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44184 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab1AWX1K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Jan 2011 18:27:10 -0500
Received: by gwj20 with SMTP id 20so1086308gwj.19
        for <linux-input@vger.kernel.org>; Sun, 23 Jan 2011 15:27:09 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Fixed the workaround used for kernels older than 2.6.35.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index f44c822..497d0ba 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1105,7 +1105,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 				    struct wacom_wac *wacom_wac)
 {
 	struct wacom_features *features = &wacom_wac->features;
-	int i;
+	int i, res;
 
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 
@@ -1228,8 +1228,13 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case TABLETPC:
 		if (features->device_type == BTN_TOOL_DOUBLETAP ||
 		    features->device_type == BTN_TOOL_TRIPLETAP) {
-			input_set_abs_params(input_dev, ABS_RX, 0, features->x_phy, 0, 0);
-			input_set_abs_params(input_dev, ABS_RY, 0, features->y_phy, 0, 0);
+			/* set touch resolution in points/mm */
+			res = features->x_phy/100;
+			input_abs_set_res(input_dev, ABS_X,
+					    features->x_max/res);
+			res = features->y_phy/100;
+			input_abs_set_res(input_dev, ABS_Y,
+					    features->y_max/res);
 			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
 		}
 
@@ -1272,6 +1277,13 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			input_set_abs_params(input_dev, ABS_MT_PRESSURE,
 					     0, features->pressure_max,
 					     features->pressure_fuzz, 0);
+			/* set touch resolution in points/mm */
+			res = features->x_phy/100;
+			input_abs_set_res(input_dev, ABS_X,
+					    features->x_max/res);
+			res = features->y_phy/100;
+			input_abs_set_res(input_dev, ABS_Y,
+					    features->y_max/res);
 		} else if (features->device_type == BTN_TOOL_PEN) {
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-- 
1.7.3.4

