From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] input: wacom - fix a typo for Cintiq 22HDT
Date: Thu,  9 May 2013 12:40:22 -0700
Message-ID: <1368128422-12127-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:62774 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab3EITke (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 May 2013 15:40:34 -0400
Received: by mail-da0-f48.google.com with SMTP id h32so494886dak.7
        for <linux-input@vger.kernel.org>; Thu, 09 May 2013 12:40:34 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

And make the lines easier to read.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 3b6998a..2bc7839 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1955,7 +1955,8 @@ static const struct wacom_features wacom_features_0xF4 =
 	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xF8 =
 	{ "Wacom Cintiq 24HD touch", WACOM_PKGLEN_INTUOS,   104480, 65600, 2047, /* Pen */
-	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf6 };
+	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf6 };
 static const struct wacom_features wacom_features_0xF6 =
 	{ "Wacom Cintiq 24HD touch", .type = WACOM_24HDT, /* Touch */
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf8, .touch_max = 10 };
@@ -1998,7 +1999,8 @@ static const struct wacom_features wacom_features_0xFA =
 	  63, WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0x5B =
 	{ "Wacom Cintiq 22HDT", WACOM_PKGLEN_INTUOS,      95840, 54260, 2047,
-	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5e };
+	  63, WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5e };
 static const struct wacom_features wacom_features_0x5E =
 	{ "Wacom Cintiq 22HDT", .type = WACOM_24HDT,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5b, .touch_max = 10 };
@@ -2031,7 +2033,7 @@ static const struct wacom_features wacom_features_0xE5 =
 static const struct wacom_features wacom_features_0xE6 =
 	{ "Wacom ISDv4 E6",       WACOM_PKGLEN_TPC2FG,    27760, 15694,  255,
 	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
-	.touch_max = 2 };
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xEC =
 	{ "Wacom ISDv4 EC",       WACOM_PKGLEN_GRAPHIRE,  25710, 14500,  255,
 	  0, TABLETPC,    WACOM_INTUOS_RES, WACOM_INTUOS_RES };
-- 
1.8.1.2

