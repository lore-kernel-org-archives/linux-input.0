From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v2] Add missing ABS_MISC event and feature declaration for 27QHD
Date: Wed,  4 Feb 2015 16:01:54 -0800
Message-ID: <1423094514-17991-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:37101 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbbBEABr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 19:01:47 -0500
Received: by pdbfp1 with SMTP id fp1so3867673pdb.4
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 16:01:46 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>

27QHD has the same x_min/y_min (WACOM_CINTIQ_OFFSET) as other Cintiqs.

ABS_MISC event is required for PAD packet to work properly with
xf86-input-wacom.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
v2: v1 updated the wrong line for features_0x32A.
---
 drivers/hid/wacom_wac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1a65079..f86db1a 100644
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
@@ -2725,9 +2730,9 @@ static const struct wacom_features wacom_features_0xF6 =
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf8, .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x32A =
-	{ "Wacom Cintiq 27QHD", 119740, 67520, 2047,
-	  63, WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
-	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	{ "Wacom Cintiq 27QHD", 119740, 67520, 2047, 63,
+	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x32B =
 	{ "Wacom Cintiq 27QHD touch", 119740, 67520, 2047, 63,
 	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
-- 
1.9.1

