From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Input : wacom - add support for 0x10d
Date: Tue,  5 Mar 2013 17:51:18 -0800
Message-ID: <1362534678-30181-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36019 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab3CFBv1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Mar 2013 20:51:27 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so8782146ieb.1
        for <linux-input@vger.kernel.org>; Tue, 05 Mar 2013 17:51:27 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Stephan Frank <sfrank@cs.tu-berlin.de>

From: Stephan Frank <sfrank@cs.tu-berlin.de

It is a Wacom device found in Fujitsu Lifebook T902.

Signed-off-by: Stephan Frank <sfrank@cs.tu-berlin.de>
Acked-by: Ping Cheng <pingc@wacom.com>
---
note: patch is based on next branch
---
 drivers/input/tablet/wacom_wac.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index ad11ec5..74800e2 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -2017,6 +2017,9 @@ static const struct wacom_features wacom_features_0x100 =
 static const struct wacom_features wacom_features_0x101 =
 	{ "Wacom ISDv4 101",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
 	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x10D =
+	{ "Wacom ISDv4 10D",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
+	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x4001 =
 	{ "Wacom ISDv4 4001",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
 	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2200,6 +2203,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xEF) },
 	{ USB_DEVICE_WACOM(0x100) },
 	{ USB_DEVICE_WACOM(0x101) },
+	{ USB_DEVICE_WACOM(0x10D) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
-- 
1.7.10.4

