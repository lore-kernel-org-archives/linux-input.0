From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Add missing ABS_MISC event and feature declaration for 27QHD
Date: Wed,  4 Feb 2015 14:36:56 -0800
Message-ID: <1423089416-6159-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:43323 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161313AbbBDWgw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 17:36:52 -0500
Received: by pdev10 with SMTP id v10so3493141pde.10
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 14:36:51 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>

27QHD has the same x_min/y_min (WACOM_CINTIQ_OFFSET) as other Cintiqs.

ABS_MISC event is required for PAD packet to work properly with
xf86-input-wacom.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1a65079..8f65ba3 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -778,6 +778,11 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[4]));
 			input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[6]));
 			input_report_abs(input, ABS_Z, be16_to_cpup((__be16 *)&data[8]));
+			if ((data[2] & 0x07) | data[4] | data[5] | data[6] | data[7] | data[8] | data[9]) {
+				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+			} else {
+				input_report_abs(input, ABS_MISC, 0);
+			}
 		} else if (features->type == CINTIQ_HYBRID) {
 			/*
 			 * Do not send hardware buttons under Android. They
@@ -2727,7 +2732,8 @@ static const struct wacom_features wacom_features_0xF6 =
 static const struct wacom_features wacom_features_0x32A =
 	{ "Wacom Cintiq 27QHD", 119740, 67520, 2047,
 	  63, WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
-	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x32B =
 	{ "Wacom Cintiq 27QHD touch", 119740, 67520, 2047, 63,
 	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
-- 
1.9.1

