From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/2] input: wacom: Add support for 0x12C ISDv4 sensor
Date: Mon, 30 Jun 2014 14:46:46 -0700
Message-ID: <1404164806-5141-2-git-send-email-killertofu@gmail.com>
References: <1404164806-5141-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:48446 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaF3Vqx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2014 17:46:53 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so8928300pdb.39
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2014 14:46:53 -0700 (PDT)
In-Reply-To: <1404164806-5141-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pinglinux@gmail.com, dmitry.torokhov@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 61a45a5..58022ff 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -2248,6 +2248,9 @@ static const struct wacom_features wacom_features_0x10F =
 static const struct wacom_features wacom_features_0x116 =
 	{ "Wacom ISDv4 116",      WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
 	  0, TABLETPCE, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x12C =
+	{ "Wacom ISDv4 12C",      WACOM_PKGLEN_GRAPHIRE,  27848, 15752,  2047,
+	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x4001 =
 	{ "Wacom ISDv4 4001",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
 	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2472,6 +2475,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x10E) },
 	{ USB_DEVICE_WACOM(0x10F) },
 	{ USB_DEVICE_WACOM(0x116) },
+	{ USB_DEVICE_WACOM(0x12C) },
 	{ USB_DEVICE_WACOM(0x300) },
 	{ USB_DEVICE_WACOM(0x301) },
 	{ USB_DEVICE_DETAILED(0x302, USB_CLASS_HID, 0, 0) },
-- 
2.0.0

