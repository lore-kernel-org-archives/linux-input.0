From: matthew@incomplete.io
Subject: [PATCH] INPUT: wacom: Added definition for Wacom CTH680 The Wacom Creative Pen & Touch Tablet M (CTH680, 056A:0303) is a newer revision of the Bamboo series. This patch adds product 0303 to wacom.ko.
Date: Sat,  2 Nov 2013 12:04:49 -0700
Message-ID: <1383419089-31248-1-git-send-email-matthew@incomplete.io>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [199.73.29.170] ([199.73.29.170]:58018 "EHLO
	gumby.musicalcarrion.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751096Ab3KBTMi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Nov 2013 15:12:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, Matthew Geddes <matthew@incomplete.io>

From: Matthew Geddes <matthew@incomplete.io>

Signed-off-by: Matthew Geddes <matthew@incomplete.io>
---
 drivers/input/tablet/wacom_wac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c59b797..5015269 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -2128,6 +2128,9 @@ static const struct wacom_features wacom_features_0x300 =
 static const struct wacom_features wacom_features_0x301 =
 	{ "Wacom Bamboo One M",    WACOM_PKGLEN_BBPEN,    21648, 13530, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x303 =
+	{ "Wacom Creative Touch & Pen M", WACOM_PKGLEN_BBPEN, 21648, 13530,
+	  1023, 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x6004 =
 	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2258,6 +2261,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x10F) },
 	{ USB_DEVICE_WACOM(0x300) },
 	{ USB_DEVICE_WACOM(0x301) },
+	{ USB_DEVICE_WACOM(0x303) },
 	{ USB_DEVICE_WACOM(0x304) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x47) },
-- 
1.8.3.2

