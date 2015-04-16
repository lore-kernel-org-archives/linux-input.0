From: Aaron Skomra <skomra@gmail.com>
Subject: [PATCH] HID: wacom - Add support for DTU-1141
Date: Thu, 16 Apr 2015 15:01:14 -0700
Message-ID: <1429221674-3348-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32778 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbDPWBW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2015 18:01:22 -0400
Received: by paboj16 with SMTP id oj16so103643038pab.0
        for <linux-input@vger.kernel.org>; Thu, 16 Apr 2015 15:01:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: pinglinux@gmail.com, Aaron Skomra <aaron.skomra@wacom.com>

Signed-off-by: Aaron Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_wac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 69c7df7..1959b18 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2919,6 +2919,9 @@ static const struct wacom_features wacom_features_0x32F =
 	{ "Wacom DTU1031X", 22472, 12728, 511, 0,
 	  DTUSX, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
+static const struct wacom_features wacom_features_0x336 =
+	{ "Wacom DTU1141", 23472, 13203, 1023, 0,
+	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x57 =
 	{ "Wacom DTK2241", 95640, 54060, 2047, 63,
 	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
@@ -3272,6 +3275,7 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x32F) },
 	{ USB_DEVICE_WACOM(0x333) },
 	{ USB_DEVICE_WACOM(0x335) },
+	{ USB_DEVICE_WACOM(0x336) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x4004) },
 	{ USB_DEVICE_WACOM(0x5000) },
-- 
2.1.0

