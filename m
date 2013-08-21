From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Input: wacom - add support for 0x300 and 0x301
Date: Tue, 20 Aug 2013 17:53:39 -0700
Message-ID: <1377046419-12376-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:62835 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab3HUAyB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Aug 2013 20:54:01 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so1937654obp.22
        for <linux-input@vger.kernel.org>; Tue, 20 Aug 2013 17:54:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Tested-by: Arjuna Rao Chavala <arjunaraoc@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 541197b..5e67cbf 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -2099,7 +2099,7 @@ static const struct wacom_features wacom_features_0xDA =
 	{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN,  14720,  9200, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
 	  .touch_max = 2 };
-static struct wacom_features wacom_features_0xDB =
+static const struct wacom_features wacom_features_0xDB =
 	{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN,  21648, 13700, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
 	  .touch_max = 2 };
@@ -2114,6 +2114,12 @@ static const struct wacom_features wacom_features_0xDF =
         { "Wacom Bamboo 16FG 6x8", WACOM_PKGLEN_BBPEN,    21648, 13700, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
 	  .touch_max = 16 };
+static const struct wacom_features wacom_features_0x300 =
+	{ "Wacom Bamboo One S",    WACOM_PKGLEN_BBPEN,    14720,  9225, 1023,
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x301 =
+	{ "Wacom Bamboo One M",    WACOM_PKGLEN_BBPEN,    21648, 13530, 1023,
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x6004 =
 	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2240,6 +2246,8 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x100) },
 	{ USB_DEVICE_WACOM(0x101) },
 	{ USB_DEVICE_WACOM(0x10D) },
+	{ USB_DEVICE_WACOM(0x300) },
+	{ USB_DEVICE_WACOM(0x301) },
 	{ USB_DEVICE_WACOM(0x304) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x47) },
-- 
1.8.1.2

