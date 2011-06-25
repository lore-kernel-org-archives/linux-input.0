From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4] input : wacom - Remove BTN_TOOL_FINGER for pad
Date: Fri, 24 Jun 2011 17:15:39 -0700
Message-ID: <1308960939-20510-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50012 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1FYAOL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 20:14:11 -0400
Received: by pwj7 with SMTP id 7so2074697pwj.19
        for <linux-input@vger.kernel.org>; Fri, 24 Jun 2011 17:14:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

BTN_TOOL_FINGER was designed to indicate a single finger touch.
Remove the lines that borrowed this type for expresskeys and
tablet buttons.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 0c302c9..7ce1294 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -278,7 +278,6 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 			input_report_key(input, BTN_4, (data[7] & 0x80));
 			rw = ((data[7] & 0x18) >> 3) - ((data[7] & 0x20) >> 3);
 			input_report_rel(input, REL_WHEEL, rw);
-			input_report_key(input, BTN_TOOL_FINGER, 0xf0);
 			if (!prox)
 				wacom->id[1] = 0;
 			input_report_abs(input, ABS_MISC, wacom->id[1]);
@@ -296,7 +295,6 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 			input_report_key(input, BTN_4, (data[7] & 0x10));
 			input_report_key(input, BTN_5, (data[7] & 0x40));
 			input_report_abs(input, ABS_WHEEL, (data[8] & 0x7f));
-			input_report_key(input, BTN_TOOL_FINGER, 0xf0);
 			if (!prox)
 				wacom->id[1] = 0;
 			input_report_abs(input, ABS_MISC, wacom->id[1]);
@@ -495,10 +493,6 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 
 	/* pad packets. Works as a second tool and is always in prox */
 	if (data[0] == WACOM_REPORT_INTUOSPAD) {
-		/* initiate the pad as a device */
-		if (wacom->tool[1] != BTN_TOOL_FINGER)
-			wacom->tool[1] = BTN_TOOL_FINGER;
-
 		if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
 			input_report_key(input, BTN_0, (data[2] & 0x01));
 			input_report_key(input, BTN_1, (data[3] & 0x01));
@@ -1090,7 +1084,6 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case WACOM_G4:
 		input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
 
-		__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
 		__set_bit(BTN_0, input_dev->keybit);
 		__set_bit(BTN_4, input_dev->keybit);
 		/* fall through */
@@ -1128,7 +1121,6 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case CINTIQ:
 		for (i = 0; i < 8; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
-		__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
 
 		if (wacom_wac->features.type != WACOM_21UX2) {
 			input_set_abs_params(input_dev, ABS_RX, 0, 4096, 0, 0);
@@ -1155,8 +1147,6 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_2, input_dev->keybit);
 		__set_bit(BTN_3, input_dev->keybit);
 
-		__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
-
 		input_set_abs_params(input_dev, ABS_RX, 0, 4096, 0, 0);
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		/* fall through */
@@ -1174,7 +1164,6 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case INTUOS4S:
 		for (i = 0; i < 7; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
-		__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
 
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		wacom_setup_intuos(wacom_wac);
-- 
1.7.5.4

