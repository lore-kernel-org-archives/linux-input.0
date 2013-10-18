From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Input: wacom - add support for ISDv4 0x10E sensor
Date: Fri, 18 Oct 2013 10:41:40 -0700
Message-ID: <1382118100-933-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62241 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab3JRRlq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Oct 2013 13:41:46 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so2151276pab.20
        for <linux-input@vger.kernel.org>; Fri, 18 Oct 2013 10:41:45 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

Used in the Fujitsu T732

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 1cbc4bb..782c253 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -2126,6 +2126,9 @@ static const struct wacom_features wacom_features_0x101 =
 static const struct wacom_features wacom_features_0x10D =
 	{ "Wacom ISDv4 10D",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
 	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x10E =
+	{ "Wacom ISDv4 10E",      WACOM_PKGLEN_MTTPC,     27760, 15694,  255,
+	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x10F =
 	{ "Wacom ISDv4 10F",      WACOM_PKGLEN_MTTPC,     27760, 15694,  255,
 	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2330,6 +2333,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x100) },
 	{ USB_DEVICE_WACOM(0x101) },
 	{ USB_DEVICE_WACOM(0x10D) },
+	{ USB_DEVICE_WACOM(0x10E) },
 	{ USB_DEVICE_WACOM(0x10F) },
 	{ USB_DEVICE_WACOM(0x300) },
 	{ USB_DEVICE_WACOM(0x301) },
-- 
1.8.4

