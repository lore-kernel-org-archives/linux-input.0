From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] input : wacom - Add 2 Bamboo Pen and touch models
Date: Sun, 23 Jan 2011 15:21:33 -0800
Message-ID: <1295824893-12427-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65252 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab1AWXWD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Jan 2011 18:22:03 -0500
Received: by iyj18 with SMTP id 18so3430068iyj.19
        for <linux-input@vger.kernel.org>; Sun, 23 Jan 2011 15:22:03 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Patch is based on the for-linus instead of the next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
since next is older than for-linus.

Reported-by: David Foley <favux.is@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 5187829..f44c822 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1426,6 +1426,10 @@ static struct wacom_features wacom_features_0xD3 =
 	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023, 63, BAMBOO_PT };
 static const struct wacom_features wacom_features_0xD4 =
 	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200,  255, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xD6 =
+	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xD7 =
+	{ "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 14720,  9200, 1023, 63, BAMBOO_PT };
 static struct wacom_features wacom_features_0xD8 =
 	{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN,   21648, 13530, 1023, 63, BAMBOO_PT };
 static struct wacom_features wacom_features_0xDA =
@@ -1507,6 +1511,8 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xD2) },
 	{ USB_DEVICE_WACOM(0xD3) },
 	{ USB_DEVICE_WACOM(0xD4) },
+	{ USB_DEVICE_WACOM(0xD6) },
+	{ USB_DEVICE_WACOM(0xD7) },
 	{ USB_DEVICE_WACOM(0xD8) },
 	{ USB_DEVICE_WACOM(0xDA) },
 	{ USB_DEVICE_WACOM(0xDB) },
-- 
1.7.3.4

