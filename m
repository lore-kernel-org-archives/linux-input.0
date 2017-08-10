From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH] HID: multitouch: Support ALPS PTP stick with pid 0x120A
Date: Thu, 10 Aug 2017 17:54:01 +0800
Message-ID: <20170810095401.16795-1-shrirang.bagul@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43018 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbdHJJyK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Aug 2017 05:54:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds ALPS PTP sticks with pid/device id 0x120A to the list of
devices supported by hid-multitouch.

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b397a14ab970..97197cf2362f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -75,6 +75,7 @@
 
 #define USB_VENDOR_ID_ALPS_JP		0x044E
 #define HID_DEVICE_ID_ALPS_U1_DUAL	0x120B
+#define HID_DEVICE_ID_ALPS_U1_PTP_2		0x120A
 #define HID_DEVICE_ID_ALPS_U1_DUAL_PTP	0x121F
 #define HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP	0x1220
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 440b999304a5..f309871bad15 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1418,6 +1418,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_ALPS_JP,
 			HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP) },
+	{ .driver_data = MT_CLS_WIN_8_DUAL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_ALPS_JP,
+			HID_DEVICE_ID_ALPS_U1_PTP_2) },
 
 	/* Anton devices */
 	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
-- 
2.11.0

