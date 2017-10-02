From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/1] Revert "HID: multitouch: Support ALPS PTP stick with pid 0x120A"
Date: Mon,  2 Oct 2017 15:50:34 +0800
Message-ID: <20171002075034.21586-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-input@vger.kernel.org

This reverts commit fcaa4a07d2a4b541e91da7a55d8b3331f96d1865.

As noted by Masaki [1], 0x120A + trackpoint will not be used in mass
production machines, so remove the ID accordingly.

[1] http://www.spinics.net/lists/linux-input/msg53222.html

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/hid-ids.h        | 1 -
 drivers/hid/hid-multitouch.c | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 832897d4a849..a98919199858 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -75,7 +75,6 @@
 
 #define USB_VENDOR_ID_ALPS_JP		0x044E
 #define HID_DEVICE_ID_ALPS_U1_DUAL	0x120B
-#define HID_DEVICE_ID_ALPS_U1_PTP_2		0x120A
 #define HID_DEVICE_ID_ALPS_U1_DUAL_PTP	0x121F
 #define HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP	0x1220
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c78625dceced..9e8c4d2ba11d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1419,10 +1419,6 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_ALPS_JP,
 			HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP) },
-	{ .driver_data = MT_CLS_WIN_8_DUAL,
-		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
-			USB_VENDOR_ID_ALPS_JP,
-			HID_DEVICE_ID_ALPS_U1_PTP_2) },
 
 	/* Lenovo X1 TAB Gen 2 */
 	{ .driver_data = MT_CLS_WIN_8_DUAL,
-- 
2.14.2
