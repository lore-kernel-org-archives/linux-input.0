From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v2] input: wacom - Pass touch resolution to clients through input_absinfo
Date: Mon, 24 Jan 2011 15:06:13 -0800
Message-ID: <1295910373-2450-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61425 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab1AXXGk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 18:06:40 -0500
Received: by pzk35 with SMTP id 35so767094pzk.19
        for <linux-input@vger.kernel.org>; Mon, 24 Jan 2011 15:06:40 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Fixed the workaround used for kernels older than 2.6.35.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index f44c822..12d5ccf 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1228,8 +1228,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case TABLETPC:
 		if (features->device_type == BTN_TOOL_DOUBLETAP ||
 		    features->device_type == BTN_TOOL_TRIPLETAP) {
-			input_set_abs_params(input_dev, ABS_RX, 0, features->x_phy, 0, 0);
-			input_set_abs_params(input_dev, ABS_RY, 0, features->y_phy, 0, 0);
+			/* set touch resolution in points/mm */
+			input_abs_set_res(input_dev, ABS_X,
+				100 * features->x_max / features->x_phy);
+			input_abs_set_res(input_dev, ABS_Y,
+				100 * features->y_max / features->y_phy);
 			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
 		}
 
@@ -1272,6 +1275,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			input_set_abs_params(input_dev, ABS_MT_PRESSURE,
 					     0, features->pressure_max,
 					     features->pressure_fuzz, 0);
+			/* set touch resolution in points/mm */
+			input_abs_set_res(input_dev, ABS_X,
+				100 * features->x_max / features->x_phy);
+			input_abs_set_res(input_dev, ABS_Y,
+				100 * features->y_max / features->y_phy);
 		} else if (features->device_type == BTN_TOOL_PEN) {
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-- 
1.7.3.4

