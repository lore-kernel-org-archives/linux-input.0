From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v3] input: wacom - Pass touch resolution to clients through input_absinfo
Date: Tue, 25 Jan 2011 10:31:19 -0800
Message-ID: <1295980279-5610-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33498 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab1AYSbs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 13:31:48 -0500
Received: by iwn9 with SMTP id 9so70191iwn.19
        for <linux-input@vger.kernel.org>; Tue, 25 Jan 2011 10:31:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Fixed the workaround used for kernels older than 2.6.35.

This version added a funtion, wacom_touch_resolution, to calculate touch resolutions.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/tablet/wacom_wac.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index f44c822..57bac83 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1101,6 +1101,15 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 	}
 }
 
+static int wacom_touch_resolution(struct wacom_features *features, int axe)
+{
+	/* touch physical size is in hundredths of a mm */
+	if (!axe)
+		return (100 * features->x_max / features->x_phy);
+	else
+		return (100 * features->y_max / features->y_phy);
+}
+
 void wacom_setup_input_capabilities(struct input_dev *input_dev,
 				    struct wacom_wac *wacom_wac)
 {
@@ -1228,8 +1237,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case TABLETPC:
 		if (features->device_type == BTN_TOOL_DOUBLETAP ||
 		    features->device_type == BTN_TOOL_TRIPLETAP) {
-			input_set_abs_params(input_dev, ABS_RX, 0, features->x_phy, 0, 0);
-			input_set_abs_params(input_dev, ABS_RY, 0, features->y_phy, 0, 0);
+			/* set touch resolution in points/mm */
+			input_abs_set_res(input_dev, ABS_X,
+					wacom_touch_resolution(features, 0));
+			input_abs_set_res(input_dev, ABS_Y,
+					wacom_touch_resolution(features, 1));
 			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
 		}
 
@@ -1272,6 +1284,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			input_set_abs_params(input_dev, ABS_MT_PRESSURE,
 					     0, features->pressure_max,
 					     features->pressure_fuzz, 0);
+			/* set touch resolution in points/mm */
+			input_abs_set_res(input_dev, ABS_X,
+					wacom_touch_resolution(features, 0));
+			input_abs_set_res(input_dev, ABS_Y,
+					wacom_touch_resolution(features, 0));
 		} else if (features->device_type == BTN_TOOL_PEN) {
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-- 
1.7.3.4

