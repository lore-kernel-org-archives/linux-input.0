From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/4] input : wacom - Add 3 new models: 6A, 6B, and 97
Date: Fri, 24 Jun 2011 17:15:21 -0700
Message-ID: <1308960921-20473-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63584 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab1FYANw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 20:13:52 -0400
Received: by pzk9 with SMTP id 9so2057482pzk.19
        for <linux-input@vger.kernel.org>; Fri, 24 Jun 2011 17:13:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, David Foley <favux.is@gmail.com>, Ping Cheng <pingc@wacom.com>

Tested-by: Alex Tervoort <alex.tervoort@gmail.com> for 6A
Signed-off-by: David Foley <favux.is@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 1cbb9a8..0c302c9 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1299,6 +1299,12 @@ static const struct wacom_features wacom_features_0x65 =
 static const struct wacom_features wacom_features_0x69 =
 	{ "Wacom Bamboo1",        WACOM_PKGLEN_GRAPHIRE,   5104,  3712,  511,
 	  63, GRAPHIRE, WACOM_PENPRTN_RES, WACOM_PENPRTN_RES };
+static const struct wacom_features wacom_features_0x6A =
+	{ "Wacom Bamboo1 4x6",    WACOM_PKGLEN_GRAPHIRE,  14760,  9225, 1023,
+	  63, GRAPHIRE, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x6B =
+	{ "Wacom Bamboo1 5x8",    WACOM_PKGLEN_GRAPHIRE,  21648, 13530, 1023,
+	  63, GRAPHIRE, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x20 =
 	{ "Wacom Intuos 4x5",     WACOM_PKGLEN_INTUOS,    12700, 10600, 1023,
 	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -1431,6 +1437,9 @@ static const struct wacom_features wacom_features_0x90 =
 static const struct wacom_features wacom_features_0x93 =
 	{ "Wacom ISDv4 93",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x97 =
+	{ "Wacom ISDv4 97",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  511,
+	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x9A =
 	{ "Wacom ISDv4 9A",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -1515,6 +1524,8 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x64) },
 	{ USB_DEVICE_WACOM(0x65) },
 	{ USB_DEVICE_WACOM(0x69) },
+	{ USB_DEVICE_WACOM(0x6A) },
+	{ USB_DEVICE_WACOM(0x6B) },
 	{ USB_DEVICE_WACOM(0x20) },
 	{ USB_DEVICE_WACOM(0x21) },
 	{ USB_DEVICE_WACOM(0x22) },
@@ -1575,6 +1586,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xCC) },
 	{ USB_DEVICE_WACOM(0x90) },
 	{ USB_DEVICE_WACOM(0x93) },
+	{ USB_DEVICE_WACOM(0x97) },
 	{ USB_DEVICE_WACOM(0x9A) },
 	{ USB_DEVICE_WACOM(0x9F) },
 	{ USB_DEVICE_WACOM(0xE2) },
-- 
1.7.5.4

