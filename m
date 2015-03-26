From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom: Add support for Cintiq 13HD Touch
Date: Wed, 25 Mar 2015 17:08:13 -0700
Message-ID: <1427328493-9998-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33027 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbbCZAIQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2015 20:08:16 -0400
Received: by pabxg6 with SMTP id xg6so45079184pab.0
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2015 17:08:15 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Cintiq 13HD Touch is a new display tablet with pen and 10 finger touches.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---

Hi Jiri, this patch is based on your for-4.1/wacom branch.

 drivers/hid/wacom_wac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 63e767e..b22587a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2741,6 +2741,15 @@ static const struct wacom_features wacom_features_0x304 =
 	{ "Wacom Cintiq 13HD", 59152, 33448, 1023, 63,
 	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
+static const struct wacom_features wacom_features_0x333 =
+	{ "Wacom Cintiq 13HD touch", 59152, 33448, 2047, 63,
+	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x335 };
+static const struct wacom_features wacom_features_0x335 =
+	{ "Wacom Cintiq 13HD touch", .type = WACOM_24HDT, /* Touch */
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x333, .touch_max = 10,
+	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xC7 =
 	{ "Wacom DTU1931", 37832, 30305, 511, 0,
 	  PL, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -3098,6 +3107,8 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x32B) },
 	{ USB_DEVICE_WACOM(0x32C) },
 	{ USB_DEVICE_WACOM(0x32F) },
+	{ USB_DEVICE_WACOM(0x333) },
+	{ USB_DEVICE_WACOM(0x335) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x4004) },
 	{ USB_DEVICE_WACOM(0x5000) },
-- 
1.9.1

