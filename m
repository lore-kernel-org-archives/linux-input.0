From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom - add defines for new Cintiq and DTU outbound tracking
Date: Mon,  1 Dec 2014 13:44:28 -0800
Message-ID: <1417470268-13635-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38641 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbaLAVoh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Dec 2014 16:44:37 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so11744684pde.38
        for <linux-input@vger.kernel.org>; Mon, 01 Dec 2014 13:44:37 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

There are screen to tablet offsets for newer Cintiq and DTU models.
These offsets serve as outbound tracking for those display tablets.

Use defines instead of hardcoded numbers for the offsets.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9565d31..a56660b 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -25,6 +25,10 @@
 #define WACOM_INTUOS_RES	100
 #define WACOM_INTUOS3_RES	200
 
+/* Newer Cintiq and DTU have an offset between tablet and screen areas */
+#define WACOM_DTU_OFFSET	200
+#define WACOM_CINTIQ_OFFSET	400
+
 /*
  * Scale factor relating reported contact size to logical contact area.
  * 2^14/pi is a good approximation on Intuos5 and 3rd-gen Bamboo
@@ -2678,10 +2682,12 @@ static const struct wacom_features wacom_features_0x317 =
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xF4 =
 	{ "Wacom Cintiq 24HD", 104280, 65400, 2047, 63,
-	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200 };
+	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xF8 =
 	{ "Wacom Cintiq 24HD touch", 104280, 65400, 2047, 63, /* Pen */
-	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200,
+	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf6 };
 static const struct wacom_features wacom_features_0xF6 =
 	{ "Wacom Cintiq 24HD touch", .type = WACOM_24HDT, /* Touch */
@@ -2698,7 +2704,8 @@ static const struct wacom_features wacom_features_0xC6 =
 	  WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0x304 =
 	{ "Wacom Cintiq 13HD", 59352, 33648, 1023, 63,
-	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200 };
+	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xC7 =
 	{ "Wacom DTU1931", 37832, 30305, 511, 0,
 	  PL, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2711,13 +2718,16 @@ static const struct wacom_features wacom_features_0xF0 =
 	  DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xFB =
 	{ "Wacom DTU1031", 22096, 13960, 511, 0,
-	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x57 =
 	{ "Wacom DTK2241", 95640, 54060, 2047, 63,
-	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200 };
+	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x59 = /* Pen */
 	{ "Wacom DTH2242", 95640, 54060, 2047, 63,
-	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200,
+	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5D };
 static const struct wacom_features wacom_features_0x5D = /* Touch */
 	{ "Wacom DTH2242",       .type = WACOM_24HDT,
@@ -2725,13 +2735,16 @@ static const struct wacom_features wacom_features_0x5D = /* Touch */
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xCC =
 	{ "Wacom Cintiq 21UX2", 87000, 65400, 2047, 63,
-	  WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200 };
+	  WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xFA =
 	{ "Wacom Cintiq 22HD", 95640, 54060, 2047, 63,
-	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200 };
+	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x5B =
 	{ "Wacom Cintiq 22HDT", 95640, 54060, 2047, 63,
-	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200,
+	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5e };
 static const struct wacom_features wacom_features_0x5E =
 	{ "Wacom Cintiq 22HDT", .type = WACOM_24HDT,
@@ -2877,7 +2890,8 @@ static const struct wacom_features wacom_features_0x6004 =
 	  TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x307 =
 	{ "Wacom ISDv5 307", 59352, 33648, 2047, 63,
-	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200,
+	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x309 };
 static const struct wacom_features wacom_features_0x309 =
 	{ "Wacom ISDv5 309", .type = WACOM_24HDT, /* Touch */
@@ -2885,7 +2899,8 @@ static const struct wacom_features wacom_features_0x309 =
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x30A =
 	{ "Wacom ISDv5 30A", 59352, 33648, 2047, 63,
-	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200,
+	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x30C };
 static const struct wacom_features wacom_features_0x30C =
 	{ "Wacom ISDv5 30C", .type = WACOM_24HDT, /* Touch */
-- 
1.9.1

