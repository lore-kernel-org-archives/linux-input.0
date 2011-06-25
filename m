From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4/4] input : wacom - Update Graphire and old Bamboo tablet buttons
Date: Fri, 24 Jun 2011 17:16:02 -0700
Message-ID: <1308960962-20547-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37399 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1FYAOd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 20:14:33 -0400
Received: by pzk9 with SMTP id 9so2057650pzk.19
        for <linux-input@vger.kernel.org>; Fri, 24 Jun 2011 17:14:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

With the removal of BTN_TOOL_FINGER for tablet buttons and
expresskeys, serial number is needed to distingush if the
events were from a regular tool (stylus, eraser, or mouse)
or the attribures (buttons, strips, or wheels) on the tablet
since there are overlapped events between the tools and the
tablet attributes.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 7ce1294..03ebcc8 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -265,6 +265,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 			wacom->id[0] = 0;
 		input_report_abs(input, ABS_MISC, wacom->id[0]); /* report tool id */
 		input_report_key(input, wacom->tool[0], prox);
+		input_event(input, EV_MSC, MSC_SERIAL, 1);
 		input_sync(input); /* sync last event */
 	}
 
@@ -274,8 +275,8 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 		prox = data[7] & 0xf8;
 		if (prox || wacom->id[1]) {
 			wacom->id[1] = PAD_DEVICE_ID;
-			input_report_key(input, BTN_0, (data[7] & 0x40));
-			input_report_key(input, BTN_4, (data[7] & 0x80));
+			input_report_key(input, BTN_BACK, (data[7] & 0x40));
+			input_report_key(input, BTN_FORWARD, (data[7] & 0x80));
 			rw = ((data[7] & 0x18) >> 3) - ((data[7] & 0x20) >> 3);
 			input_report_rel(input, REL_WHEEL, rw);
 			if (!prox)
@@ -290,17 +291,17 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 		prox = (data[7] & 0xf8) || data[8];
 		if (prox || wacom->id[1]) {
 			wacom->id[1] = PAD_DEVICE_ID;
-			input_report_key(input, BTN_0, (data[7] & 0x08));
-			input_report_key(input, BTN_1, (data[7] & 0x20));
-			input_report_key(input, BTN_4, (data[7] & 0x10));
-			input_report_key(input, BTN_5, (data[7] & 0x40));
+			input_report_key(input, BTN_BACK, (data[7] & 0x08));
+			input_report_key(input, BTN_LEFT, (data[7] & 0x20));
+			input_report_key(input, BTN_FORWARD, (data[7] & 0x10));
+			input_report_key(input, BTN_RIGHT, (data[7] & 0x40));
 			input_report_abs(input, ABS_WHEEL, (data[8] & 0x7f));
 			if (!prox)
 				wacom->id[1] = 0;
 			input_report_abs(input, ABS_MISC, wacom->id[1]);
 			input_event(input, EV_MSC, MSC_SERIAL, 0xf0);
+			retval = 1;
 		}
-		retval = 1;
 		break;
 	}
 exit:
@@ -1075,17 +1076,14 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	switch (wacom_wac->features.type) {
 	case WACOM_MO:
-		__set_bit(BTN_1, input_dev->keybit);
-		__set_bit(BTN_5, input_dev->keybit);
-
 		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
 		/* fall through */
 
 	case WACOM_G4:
 		input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
 
-		__set_bit(BTN_0, input_dev->keybit);
-		__set_bit(BTN_4, input_dev->keybit);
+		__set_bit(BTN_BACK, input_dev->keybit);
+		__set_bit(BTN_FORWARD, input_dev->keybit);
 		/* fall through */
 
 	case GRAPHIRE:
-- 
1.7.5.4

