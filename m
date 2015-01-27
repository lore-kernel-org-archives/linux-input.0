From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/3] Consolidate input capability settings for pen and touch
Date: Tue, 27 Jan 2015 13:29:36 -0800
Message-ID: <1422394176-15106-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:64582 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759836AbbA0V3V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 16:29:21 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so21234272pdj.1
        for <linux-input@vger.kernel.org>; Tue, 27 Jan 2015 13:29:21 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

After PAD moved to its own interface, there were duplicated statements
in wacom_setup_pentouch_input_capabilities. Merge them together to
reduce future maintenance effort.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 67 ++++++++-----------------------------------------
 1 file changed, 10 insertions(+), 57 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6d490f6..d239d82 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2089,32 +2089,17 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 	wacom_abs_set_axis(input_dev, wacom_wac);
 
 	switch (features->type) {
-	case WACOM_MO:
-	case WACOM_G4:
-		/* fall through */
-
-	case GRAPHIRE:
-		input_set_capability(input_dev, EV_REL, REL_WHEEL);
-
-		__set_bit(BTN_LEFT, input_dev->keybit);
-		__set_bit(BTN_RIGHT, input_dev->keybit);
-		__set_bit(BTN_MIDDLE, input_dev->keybit);
-
-		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
-		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-		__set_bit(BTN_TOOL_MOUSE, input_dev->keybit);
-		__set_bit(BTN_STYLUS, input_dev->keybit);
-		__set_bit(BTN_STYLUS2, input_dev->keybit);
-
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-		break;
-
 	case GRAPHIRE_BT:
 		__clear_bit(ABS_MISC, input_dev->absbit);
+
+	case WACOM_MO:
+	case WACOM_G4:
 		input_set_abs_params(input_dev, ABS_DISTANCE, 0,
 					      features->distance_max,
 					      0, 0);
+		/* fall through */
 
+	case GRAPHIRE:
 		input_set_capability(input_dev, EV_REL, REL_WHEEL);
 
 		__set_bit(BTN_LEFT, input_dev->keybit);
@@ -2131,30 +2116,13 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case WACOM_24HD:
-		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
-		input_abs_set_res(input_dev, ABS_Z, 287);
-		input_set_abs_params(input_dev, ABS_THROTTLE, 0, 71, 0, 0);
-		/* fall through */
-
 	case DTK:
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
-
-		wacom_setup_cintiq(wacom_wac);
-		break;
-
 	case WACOM_22HD:
 	case WACOM_21UX2:
 	case WACOM_BEE:
 	case CINTIQ:
-		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
-		input_abs_set_res(input_dev, ABS_Z, 287);
-
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
-
-		wacom_setup_cintiq(wacom_wac);
-		break;
-
 	case WACOM_13HD:
+	case CINTIQ_HYBRID:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
 		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
@@ -2164,6 +2132,10 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 	case INTUOS3:
 	case INTUOS3L:
 	case INTUOS3S:
+	case INTUOS4:
+	case INTUOS4WL:
+	case INTUOS4L:
+	case INTUOS4S:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
 		/* fall through */
@@ -2202,17 +2174,6 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 		}
 		break;
 
-	case INTUOS4:
-	case INTUOS4WL:
-	case INTUOS4L:
-	case INTUOS4S:
-		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
-		input_abs_set_res(input_dev, ABS_Z, 287);
-		wacom_setup_intuos(wacom_wac);
-
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-		break;
-
 	case WACOM_24HDT:
 		if (features->device_type == BTN_TOOL_FINGER) {
 			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features->x_max, 0, 0);
@@ -2308,14 +2269,6 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 					      0, 0);
 		}
 		break;
-
-	case CINTIQ_HYBRID:
-		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
-		input_abs_set_res(input_dev, ABS_Z, 287);
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
-
-		wacom_setup_cintiq(wacom_wac);
-		break;
 	}
 	return 0;
 }
-- 
1.9.1

