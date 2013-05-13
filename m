From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] input : wacom - add an eraser to DTH2242/DTK2241
Date: Mon, 13 May 2013 10:44:00 -0700
Message-ID: <1368467040-23216-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:65346 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab3EMRoB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 May 2013 13:44:01 -0400
Received: by mail-da0-f41.google.com with SMTP id y19so3757729dan.28
        for <linux-input@vger.kernel.org>; Mon, 13 May 2013 10:44:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

plus send begin and end of express keys events for
Cintiq 13HD and DTH2242/DTK2241

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 2bc7839..518282d 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -362,7 +362,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		case 0x100804: /* Intuos4/5 13HD/24HD Art Pen */
 		case 0x140802: /* Intuos4/5 13HD/24HD Classic Pen */
 		case 0x160802: /* Cintiq 13HD Pro Pen */
-		case 0x180802: /* DTH2242 Grip Pen */
+		case 0x180802: /* DTH2242 Pen */
 			wacom->tool[idx] = BTN_TOOL_PEN;
 			break;
 
@@ -400,6 +400,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		case 0x10090a: /* Intuos4/5 13HD/24HD Airbrush Eraser */
 		case 0x10080c: /* Intuos4/5 13HD/24HD Art Pen Eraser */
 		case 0x16080a: /* Cintiq 13HD Pro Pen Eraser */
+		case 0x18080a: /* DTH2242 Eraser */
 			wacom->tool[idx] = BTN_TOOL_RUBBER;
 			break;
 
@@ -550,6 +551,11 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			input_report_key(input, BTN_3, (data[6] & 0x08));
 			input_report_key(input, BTN_4, (data[6] & 0x10));
 			input_report_key(input, BTN_5, (data[6] & 0x20));
+			if (data[6] & 0x3f) {
+				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+			} else {
+				input_report_abs(input, ABS_MISC, 0);
+			}
 		} else if (features->type == WACOM_13HD) {
 			input_report_key(input, BTN_0, (data[3] & 0x01));
 			input_report_key(input, BTN_1, (data[4] & 0x01));
@@ -560,6 +566,11 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			input_report_key(input, BTN_6, (data[4] & 0x20));
 			input_report_key(input, BTN_7, (data[4] & 0x40));
 			input_report_key(input, BTN_8, (data[4] & 0x80));
+			if ((data[3] & 0x01) | data[4]) {
+				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+			} else {
+				input_report_abs(input, ABS_MISC, 0);
+			}
 		} else if (features->type == WACOM_24HD) {
 			input_report_key(input, BTN_0, (data[6] & 0x01));
 			input_report_key(input, BTN_1, (data[6] & 0x02));
@@ -1539,15 +1550,15 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(KEY_PROG1, input_dev->keybit);
 		__set_bit(KEY_PROG2, input_dev->keybit);
 		__set_bit(KEY_PROG3, input_dev->keybit);
+
+		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		input_set_abs_params(input_dev, ABS_THROTTLE, 0, 71, 0, 0);
 		/* fall through */
 
 	case DTK:
 		for (i = 0; i < 6; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
 
-		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
-		input_set_abs_params(input_dev, ABS_THROTTLE, 0, 71, 0, 0);
-
 		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 
 		wacom_setup_cintiq(wacom_wac);
-- 
1.8.1.2

