From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] input : wacom - Add 6 new Bamboo Pen and touch models
Date: Fri, 21 Jan 2011 23:25:30 -0800
Message-ID: <1295681130-27188-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43824 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab1AVH0H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Jan 2011 02:26:07 -0500
Received: by pzk35 with SMTP id 35so414778pzk.19
        for <linux-input@vger.kernel.org>; Fri, 21 Jan 2011 23:26:06 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, David Foley <favux.is@gmail.com>, Ping Cheng <pingc@wacom.com>

Reported-by: David Foley <favux.is@gmail.com>
Signed-off-by: David Foley <favux.is@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 0b05254..4657c02 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1424,6 +1424,18 @@ static struct wacom_features wacom_features_0xD2 =
 	{ "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
 static struct wacom_features wacom_features_0xD3 =
 	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xD4 =
+	{ "Wacom Bamboo 4x5",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xD6 =
+	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xD7 =
+	{ "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 14720,  9200, 1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xD8 =
+	{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN,   21648, 13530, 1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xDA =
+	{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN,  14720,  9200, 1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xDB =
+	{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN,  21648, 13530, 1023, 63, BAMBOO_PT };
 
 #define USB_DEVICE_WACOM(prod)					\
 	USB_DEVICE(USB_VENDOR_ID_WACOM, prod),			\
@@ -1492,6 +1504,12 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xD1) },
 	{ USB_DEVICE_WACOM(0xD2) },
 	{ USB_DEVICE_WACOM(0xD3) },
+	{ USB_DEVICE_WACOM(0xD4) },
+	{ USB_DEVICE_WACOM(0xD6) },
+	{ USB_DEVICE_WACOM(0xD7) },
+	{ USB_DEVICE_WACOM(0xD8) },
+	{ USB_DEVICE_WACOM(0xDA) },
+	{ USB_DEVICE_WACOM(0xDB) },
 	{ USB_DEVICE_WACOM(0xF0) },
 	{ USB_DEVICE_WACOM(0xCC) },
 	{ USB_DEVICE_WACOM(0x90) },
-- 
1.7.3.4

