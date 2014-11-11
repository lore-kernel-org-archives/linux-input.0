From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom - Add support for Intuos Pen Medium
Date: Tue, 11 Nov 2014 12:52:08 -0800
Message-ID: <1415739128-28533-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:43365 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaKKUwE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2014 15:52:04 -0500
Received: by mail-pd0-f171.google.com with SMTP id r10so10774157pdi.2
        for <linux-input@vger.kernel.org>; Tue, 11 Nov 2014 12:52:03 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 586b240..8ce7fab 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2878,6 +2878,10 @@ static const struct wacom_features wacom_features_0x30C =
 	{ "Wacom ISDv5 30C", .type = WACOM_24HDT, /* Touch */
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x30A, .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
+static const struct wacom_features wacom_features_0x323 =
+	{ "Wacom Intuos P M", 21600, 13500, 1023, 31,
+	  INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
 	{ "Wacom HID", .type = HID_GENERIC };
@@ -3022,6 +3026,7 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x314) },
 	{ USB_DEVICE_WACOM(0x315) },
 	{ USB_DEVICE_WACOM(0x317) },
+	{ USB_DEVICE_WACOM(0x323) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x4004) },
 	{ USB_DEVICE_WACOM(0x5000) },
-- 
1.9.1

