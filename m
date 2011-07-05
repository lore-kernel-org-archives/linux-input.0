From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/3 v2] input : wacom - Update Graphire4 and old Bamboo tablet buttons
Date: Tue,  5 Jul 2011 16:25:32 -0700
Message-ID: <1309908332-18829-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65079 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab1GEXYE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 19:24:04 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so5629017iyb.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 16:24:03 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Bamboo touch sets BTN_BACK, BTN_FORWARD, BTN_LEFT, and BTN_RIGHT
as the default button events for tablet buttons. Change Graphire4
and old Bamboo to the same settings.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index b93501a..19554a4 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -275,8 +275,8 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
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
@@ -291,10 +291,10 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
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
@@ -1076,17 +1076,14 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 
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

