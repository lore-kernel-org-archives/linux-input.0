From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/5] input: wacom - Add support for the Wacom Bamboo Pen (CTL-660/K)
Date: Fri, 12 Aug 2011 17:08:03 -0700
Message-ID: <1313194083-4949-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36069 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab1HMAG1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 20:06:27 -0400
Received: by gwaa12 with SMTP id a12so2320913gwa.19
        for <linux-input@vger.kernel.org>; Fri, 12 Aug 2011 17:06:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Gerard Braad <me@gbraad.nl>, Ping Cheng <pingc@wacom.com>

From: Gerard Braad <me@gbraad.nl>

Signed-off-by: Gerard Braad <me@gbraad.nl>
Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 03ebcc8..c1c2f7b 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1460,6 +1460,9 @@ static const struct wacom_features wacom_features_0xD3 =
 static const struct wacom_features wacom_features_0xD4 =
 	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
 	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0xD5 =
+	{ "Wacom Bamboo Pen 6x8",     WACOM_PKGLEN_BBFUN, 21648, 13530, 1023,
+	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD6 =
 	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023,
 	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -1564,6 +1567,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xD2) },
 	{ USB_DEVICE_WACOM(0xD3) },
 	{ USB_DEVICE_WACOM(0xD4) },
+	{ USB_DEVICE_WACOM(0xD5) },
 	{ USB_DEVICE_WACOM(0xD6) },
 	{ USB_DEVICE_WACOM(0xD7) },
 	{ USB_DEVICE_WACOM(0xD8) },
-- 
1.7.6

