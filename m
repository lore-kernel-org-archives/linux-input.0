From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 2/3] HID: wiimote: add 2nd generation Wii Remote IDs
Date: Tue,  2 Apr 2013 19:58:35 +0200
Message-ID: <1364925516-5724-2-git-send-email-dh.herrmann@gmail.com>
References: <1364925516-5724-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:59099 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757797Ab3DBR7K (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Apr 2013 13:59:10 -0400
Received: by mail-bk0-f41.google.com with SMTP id i18so355747bkv.28
        for <linux-input@vger.kernel.org>; Tue, 02 Apr 2013 10:59:08 -0700 (PDT)
In-Reply-To: <1364925516-5724-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

This adds the 2nd generation Wii Remote IDs. They have a different
Bluetooth chipset (CSR instead of Broadcom) and are more restrictive in
what they accept as input. Hence, you need up-to-date BlueZ and
Bluetooth HIDP modules to use these devices.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-core.c         | 1 +
 drivers/hid/hid-ids.h          | 1 +
 drivers/hid/hid-wiimote-core.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ceb3040..b0ad27a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1741,6 +1741,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE2) },
 	{ }
 };
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 266e2ae..a775b1c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -605,6 +605,7 @@
 
 #define USB_VENDOR_ID_NINTENDO		0x057e
 #define USB_DEVICE_ID_NINTENDO_WIIMOTE	0x0306
+#define USB_DEVICE_ID_NINTENDO_WIIMOTE2	0x0330
 
 #define USB_VENDOR_ID_NOVATEK		0x0603
 #define USB_DEVICE_ID_NOVATEK_PCT	0x0600
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index c73bc80..d2c69b9 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1291,6 +1291,8 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 static const struct hid_device_id wiimote_hid_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
 				USB_DEVICE_ID_NINTENDO_WIIMOTE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
+				USB_DEVICE_ID_NINTENDO_WIIMOTE2) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, wiimote_hid_devices);
-- 
1.8.2

