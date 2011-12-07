From: chris@cnpbagwell.com
Subject: [PATCH] Input: wacom - add product id used by Samsung Slate 7
Date: Tue,  6 Dec 2011 21:27:37 -0600
Message-ID: <1323228457-18735-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56166 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab1LGD17 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Dec 2011 22:27:59 -0500
Received: by yenm1 with SMTP id m1so114409yen.19
        for <linux-input@vger.kernel.org>; Tue, 06 Dec 2011 19:27:59 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com
Cc: stable@kernel.org, mail@harveybraun.com, Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---

New product ID reported by Harvey Braun on linuxwacom mailing list
and also tested this patch with new hardware. Link to report plus
results:

http://sourceforge.net/mailarchive/forum.php?thread_name=CAGzDe_bToDXsztnDsyPiVAmEKXd60aG2zA2%2BTCf3M_X6Z%2BLtTg%40mail.gmail.com&forum_name=linuxwacom-discuss

 drivers/input/tablet/wacom_wac.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index da0d876..2ee47d0 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1470,6 +1470,9 @@ static const struct wacom_features wacom_features_0xE3 =
 static const struct wacom_features wacom_features_0xE6 =
 	{ "Wacom ISDv4 E6",       WACOM_PKGLEN_TPC2FG,    27760, 15694,  255,
 	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0xEC =
+	{ "Wacom ISDv4 EC",       WACOM_PKGLEN_GRAPHIRE,  25710, 14500,  255,
+	  0, TABLETPC,    WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
 	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -1611,6 +1614,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xE2) },
 	{ USB_DEVICE_WACOM(0xE3) },
 	{ USB_DEVICE_WACOM(0xE6) },
+	{ USB_DEVICE_WACOM(0xEC) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_LENOVO(0x6004) },
 	{ }
-- 
1.7.7.4

