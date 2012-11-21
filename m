From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] input : wacom - Add support for a new MT device (0x4001)
Date: Wed, 21 Nov 2012 10:43:23 -0800
Message-ID: <1353523403-6473-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62960 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab2KUSnc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 13:43:32 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so5279789pbc.19
        for <linux-input@vger.kernel.org>; Wed, 21 Nov 2012 10:43:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

It supports 10 fingers.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index f09f39e..49b55d6 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -2029,6 +2029,9 @@ static const struct wacom_features wacom_features_0x100 =
 static const struct wacom_features wacom_features_0x101 =
 	{ "Wacom ISDv4 101",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
 	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x4001 =
+	{ "Wacom ISDv4 4001",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
+	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
 	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2207,6 +2210,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xEF) },
 	{ USB_DEVICE_WACOM(0x100) },
 	{ USB_DEVICE_WACOM(0x101) },
+	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
 	{ USB_DEVICE_WACOM(0xF8) },
-- 
1.7.10.4

