From: srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH] Add Wacom product id
Date: Tue, 28 Aug 2012 10:51:38 -0700
Message-ID: <1346176298-3189-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11813 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716Ab2H1SB4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Aug 2012 14:01:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>

Added 0x00EF as product id for the Wacom drivers.

Change-Id: Iacdefbd317395309ecb7972f56413829a9c62e1f
Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/input/tablet/wacom_wac.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 58426d0..479dfa7 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1800,6 +1800,9 @@ static const struct wacom_features wacom_features_0xE6 =
 static const struct wacom_features wacom_features_0xEC =
 	{ "Wacom ISDv4 EC",       WACOM_PKGLEN_GRAPHIRE,  25710, 14500,  255,
 	  0, TABLETPC,    WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0xEF =
+	{ "Wacom ISDv4 EF",       WACOM_PKGLEN_GRAPHIRE,  25710, 14500,  255,
+	  0, TABLETPC,    WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
 	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -1973,6 +1976,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xE3) },
 	{ USB_DEVICE_WACOM(0xE6) },
 	{ USB_DEVICE_WACOM(0xEC) },
+	{ USB_DEVICE_WACOM(0xEF) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
 	{ USB_DEVICE_LENOVO(0x6004) },
-- 
1.7.7.6

