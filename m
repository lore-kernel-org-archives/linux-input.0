From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom: Add support for DTK-1651
Date: Tue, 12 Apr 2016 13:37:45 -0700
Message-ID: <1460493465-17823-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34713 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965195AbcDLUiK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2016 16:38:10 -0400
Received: by mail-pf0-f182.google.com with SMTP id c20so20089809pfc.1
        for <linux-input@vger.kernel.org>; Tue, 12 Apr 2016 13:38:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Ping Cheng <pingc@wacom.com>

DTK-1651 is a display pen-only tablet

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 02c4efe..140b90f 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3395,6 +3395,10 @@ static const struct wacom_features wacom_features_0x33E =
 	{ "Wacom Intuos PT M 2", 21600, 13500, 2047, 63,
 	  INTUOSHT2, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 16,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
+static const struct wacom_features wacom_features_0x343 =
+	{ "Wacom DTK1651", 34616, 19559, 1023, 0,
+	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4,
+	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
 	{ "Wacom HID", .type = HID_GENERIC };
@@ -3560,6 +3564,7 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x33C) },
 	{ USB_DEVICE_WACOM(0x33D) },
 	{ USB_DEVICE_WACOM(0x33E) },
+	{ USB_DEVICE_WACOM(0x343) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x4004) },
 	{ USB_DEVICE_WACOM(0x5000) },
-- 
1.9.1

