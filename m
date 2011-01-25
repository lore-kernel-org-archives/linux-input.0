From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v4] input: wacom - Pass touch resolution to clients through input_absinfo
Date: Tue, 25 Jan 2011 11:38:29 -0800
Message-ID: <1295984309-9408-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45494 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab1AYTjO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 14:39:14 -0500
Received: by ywe10 with SMTP id 10so1467955ywe.19
        for <linux-input@vger.kernel.org>; Tue, 25 Jan 2011 11:39:13 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Fixed the workaround used for kernels older than 2.6.35.

This version added a funtion, wacom_calculate_touch_res, to calculate
touch resolutions. The word "touch" is needed since the routine does
not apply to pen tablets.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index f44c822..367fa82 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1101,6 +1101,13 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 	}
 }
 
+static unsigned int wacom_calculate_touch_res(unsigned int logical_max,
+					      unsigned int physical_max)
+{
+       /* Touch physical dimensions are in 100th of mm */
+       return (logical_max * 100) / physical_max;
+}
+
 void wacom_setup_input_capabilities(struct input_dev *input_dev,
 				    struct wacom_wac *wacom_wac)
 {
@@ -1228,8 +1235,12 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case TABLETPC:
 		if (features->device_type == BTN_TOOL_DOUBLETAP ||
 		    features->device_type == BTN_TOOL_TRIPLETAP) {
-			input_set_abs_params(input_dev, ABS_RX, 0, features->x_phy, 0, 0);
-			input_set_abs_params(input_dev, ABS_RY, 0, features->y_phy, 0, 0);
+			input_abs_set_res(input_dev, ABS_X,
+				wacom_calculate_touch_res(features->x_max,
+							features->x_phy));
+			input_abs_set_res(input_dev, ABS_Y,
+				wacom_calculate_touch_res(features->y_max,
+							features->y_phy));
 			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
 		}
 
@@ -1272,6 +1283,12 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			input_set_abs_params(input_dev, ABS_MT_PRESSURE,
 					     0, features->pressure_max,
 					     features->pressure_fuzz, 0);
+			input_abs_set_res(input_dev, ABS_X,
+				wacom_calculate_touch_res(features->x_max,
+							features->x_phy));
+			input_abs_set_res(input_dev, ABS_Y,
+				wacom_calculate_touch_res(features->y_max,
+							features->y_phy));
 		} else if (features->device_type == BTN_TOOL_PEN) {
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-- 
1.7.3.4

