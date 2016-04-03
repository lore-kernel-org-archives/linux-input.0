From: Yusuke Fujimaki <usk.fujimaki@gmail.com>
Subject: [PATCH V2] HID: Asus X205TA keyboard driver
Date: Sun,  3 Apr 2016 23:15:16 +0900
Message-ID: <1459692916-3705-1-git-send-email-usk.fujimaki@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32965 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbcDCOP5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Apr 2016 10:15:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id e190so2461706pfe.0
        for <linux-input@vger.kernel.org>; Sun, 03 Apr 2016 07:15:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Yusuke Fujimaki <usk.fujimaki@gmail.com>

Asus X205TA and E200HA built-in keyboard contain
wrong logical maximum value in report descriptor.

This patch correct wrong logical maximum in report
descriptor.

Signed-off-by: Yusuke Fujimaki <usk.fujimaki@gmail.com>
---
Changes in V2:
- Adding support for VivoBook E200HA
- Updating macro,comments and Kconfig

 drivers/hid/Kconfig    |  6 +++++-
 drivers/hid/hid-asus.c | 12 ++++++++----
 drivers/hid/hid-core.c |  2 +-
 drivers/hid/hid-ids.h  |  2 +-
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 513c93e..5646ca4 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -138,7 +138,11 @@ config HID_ASUS
 	tristate "Asus"
 	depends on I2C_HID
 	---help---
-	Support for Asus X205TA built-in keyboard via i2c.
+	Support for Asus notebook built-in keyboard via i2c.
+
+	Supported devices:
+	- EeeBook X205TA
+	- VivoBook E200HA
 
 config HID_AUREAL
 	tristate "Aureal"
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 1734e11..7a811ec 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1,7 +1,11 @@
 /*
- *  HID driver for Asus X205TA built-in keyboard.
+ *  HID driver for Asus notebook built-in keyboard.
  *  Fixes small logical maximum to match usage maximum.
  *
+ *  Currently supported devices are:
+ *    EeeBook X205TA
+ *    VivoBook E200HA
+ *
  *  Copyright (c) 2016 Yusuke Fujimaki <usk.fujimaki@gmail.com>
  *
  *  This module based on hid-ortek by
@@ -25,15 +29,15 @@
 static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	if (*rsize >= 180 && rdesc[54] == 0x25 && rdesc[55] == 0x65) {
-		hid_info(hdev, "Fixing up Asus X205TA report descriptor\n");
+	if (*rsize >= 56 && rdesc[54] == 0x25 && rdesc[55] == 0x65) {
+		hid_info(hdev, "Fixing up Asus notebook report descriptor\n");
 		rdesc[55] = 0xdd;
 	}
 	return rdesc;
 }
 
 static const struct hid_device_id asus_devices[] = {
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_X205TA_KEYBOARD) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 7426b5a..7f8105b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1856,7 +1856,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_X205TA_KEYBOARD) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AUREAL, USB_DEVICE_ID_AUREAL_W01RN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185BFM, 0x2208) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f83e7fd..1219e59 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -163,7 +163,7 @@
 #define USB_VENDOR_ID_ASUSTEK		0x0b05
 #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
 #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
-#define USB_DEVICE_ID_ASUSTEK_X205TA_KEYBOARD  0x8585
+#define USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD	0x8585
 
 #define USB_VENDOR_ID_ATEN		0x0557
 #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
-- 
2.1.4

