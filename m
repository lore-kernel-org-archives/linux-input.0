From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] HID: wiimote: add LEGO-wiimote VID
Date: Fri, 18 Oct 2013 16:26:22 +0200
Message-ID: <1382106382-24800-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:62834 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab3JRO0a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Oct 2013 10:26:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, stable@vger.kernel.org

The LEGO-wiimote uses a different VID than the Nintendo ID. The device is
technically the same so add the ID.

Cc: <stable@vger.kernel.org> # 3.11+
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-core.c         | 1 +
 drivers/hid/hid-ids.h          | 1 +
 drivers/hid/hid-wiimote-core.c | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 95d2dff..e6c3a03 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1871,6 +1871,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO2, USB_DEVICE_ID_NINTENDO_WIIMOTE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE2) },
 	{ }
 };
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ac803c5..000e0df 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -639,6 +639,7 @@
 #define USB_DEVICE_ID_NEXTWINDOW_TOUCHSCREEN	0x0003
 
 #define USB_VENDOR_ID_NINTENDO		0x057e
+#define USB_VENDOR_ID_NINTENDO2		0x054c
 #define USB_DEVICE_ID_NINTENDO_WIIMOTE	0x0306
 #define USB_DEVICE_ID_NINTENDO_WIIMOTE2	0x0330
 
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index abb20db..1446f52 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -834,7 +834,8 @@ static void wiimote_init_set_type(struct wiimote_data *wdata,
 		goto done;
 	}
 
-	if (vendor == USB_VENDOR_ID_NINTENDO) {
+	if (vendor == USB_VENDOR_ID_NINTENDO ||
+	    vendor == USB_VENDOR_ID_NINTENDO2) {
 		if (product == USB_DEVICE_ID_NINTENDO_WIIMOTE) {
 			devtype = WIIMOTE_DEV_GEN10;
 			goto done;
@@ -1855,6 +1856,8 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 static const struct hid_device_id wiimote_hid_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
 				USB_DEVICE_ID_NINTENDO_WIIMOTE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO2,
+				USB_DEVICE_ID_NINTENDO_WIIMOTE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
 				USB_DEVICE_ID_NINTENDO_WIIMOTE2) },
 	{ }
-- 
1.8.4

