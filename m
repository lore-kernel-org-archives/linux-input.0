From: Gerard Braad <me@gbraad.nl>
Subject: [PATCH] Added support for the Wacom Bamboo Pen (CTL-660/K)
Date: Sat,  9 Jul 2011 15:14:38 +0800
Message-ID: <1310195678-22685-1-git-send-email-me@gbraad.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43738 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab1GIHPF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jul 2011 03:15:05 -0400
Received: by iwn6 with SMTP id 6so2330633iwn.19
        for <linux-input@vger.kernel.org>; Sat, 09 Jul 2011 00:15:03 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: linux-input@vger.kernel.org, Gerard Braad <me@gbraad.nl>

---
 drivers/input/tablet/wacom_wac.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 08ba5ad..23c9a40 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1460,6 +1460,9 @@ static const struct wacom_features wacom_features_0xD3 =
 static const struct wacom_features wacom_features_0xD4 =
 	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200,  255,
 	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0xD5 =
+	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     21648, 13530, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD6 =
 	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023,
 	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -1551,6 +1554,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xD2) },
 	{ USB_DEVICE_WACOM(0xD3) },
 	{ USB_DEVICE_WACOM(0xD4) },
+	{ USB_DEVICE_WACOM(0xD5) },
 	{ USB_DEVICE_WACOM(0xD6) },
 	{ USB_DEVICE_WACOM(0xD7) },
 	{ USB_DEVICE_WACOM(0xD8) },
-- 
1.7.5.2

