From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] HID: wacom - Update maximum X/Y accounding to outbound offset
Date: Thu,  4 Dec 2014 18:25:07 -0800
Message-ID: <1417746307-12245-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:54631 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbaLECZJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Dec 2014 21:25:09 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so19147776pad.41
        for <linux-input@vger.kernel.org>; Thu, 04 Dec 2014 18:25:09 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Defined outbound offset for DTU and Cintiq. But didn't update
the relevant maximum values. Oops...

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index b65e0d7..7b7a61a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2685,11 +2685,11 @@ static const struct wacom_features wacom_features_0x317 =
 	  INTUOSPL, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .touch_max = 16,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xF4 =
-	{ "Wacom Cintiq 24HD", 104280, 65400, 2047, 63,
+	{ "Wacom Cintiq 24HD", 104080, 65200, 2047, 63,
 	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xF8 =
-	{ "Wacom Cintiq 24HD touch", 104280, 65400, 2047, 63, /* Pen */
+	{ "Wacom Cintiq 24HD touch", 104080, 65200, 2047, 63, /* Pen */
 	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf6 };
@@ -2707,7 +2707,7 @@ static const struct wacom_features wacom_features_0xC6 =
 	{ "Wacom Cintiq 12WX", 53020, 33440, 1023, 63,
 	  WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0x304 =
-	{ "Wacom Cintiq 13HD", 59352, 33648, 1023, 63,
+	{ "Wacom Cintiq 13HD", 59152, 33448, 1023, 63,
 	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xC7 =
@@ -2721,7 +2721,7 @@ static const struct wacom_features wacom_features_0xF0 =
 	{ "Wacom DTU1631", 34623, 19553, 511, 0,
 	  DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xFB =
-	{ "Wacom DTU1031", 22096, 13960, 511, 0,
+	{ "Wacom DTU1031", 21896, 13760, 511, 0,
 	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x32F =
@@ -2742,15 +2742,15 @@ static const struct wacom_features wacom_features_0x5D = /* Touch */
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x59, .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xCC =
-	{ "Wacom Cintiq 21UX2", 87000, 65400, 2047, 63,
+	{ "Wacom Cintiq 21UX2", 86800, 65200, 2047, 63,
 	  WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xFA =
-	{ "Wacom Cintiq 22HD", 95640, 54060, 2047, 63,
+	{ "Wacom Cintiq 22HD", 95440, 53860, 2047, 63,
 	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x5B =
-	{ "Wacom Cintiq 22HDT", 95640, 54060, 2047, 63,
+	{ "Wacom Cintiq 22HDT", 95440, 53860, 2047, 63,
 	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5e };
@@ -2897,7 +2897,7 @@ static const struct wacom_features wacom_features_0x6004 =
 	{ "ISD-V4", 12800, 8000, 255, 0,
 	  TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x307 =
-	{ "Wacom ISDv5 307", 59352, 33648, 2047, 63,
+	{ "Wacom ISDv5 307", 59152, 33448, 2047, 63,
 	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x309 };
@@ -2906,7 +2906,7 @@ static const struct wacom_features wacom_features_0x309 =
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x0307, .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x30A =
-	{ "Wacom ISDv5 30A", 59352, 33648, 2047, 63,
+	{ "Wacom ISDv5 30A", 59152, 33448, 2047, 63,
 	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x30C };
-- 
1.9.1

