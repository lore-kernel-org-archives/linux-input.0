From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: multitouch: Add pointstick support for ALPS Touchpad
Date: Fri, 14 Jun 2019 16:56:55 +0800
Message-ID: <20190614085655.8255-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-input@vger.kernel.org

There's a new ALPS touchpad/pointstick combo device that requires
MT_CLS_WIN_8_DUAL to make its pointsitck work as a mouse.

The device can be found on HP ZBook 17 G5.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index eac0c54c5970..5311c62aeb88 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -80,6 +80,7 @@
 #define HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP	0x1220
 #define HID_DEVICE_ID_ALPS_U1		0x1215
 #define HID_DEVICE_ID_ALPS_T4_BTNLESS	0x120C
+#define HID_DEVICE_ID_ALPS_1222		0x1222
 
 
 #define USB_VENDOR_ID_AMI		0x046b
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5df5dd56ecc8..b603c14d043b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1776,6 +1776,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_ALPS_JP,
 			HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP) },
+	{ .driver_data = MT_CLS_WIN_8_DUAL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_ALPS_JP,
+			HID_DEVICE_ID_ALPS_1222) },
 
 	/* Lenovo X1 TAB Gen 2 */
 	{ .driver_data = MT_CLS_WIN_8_DUAL,
-- 
2.17.1
