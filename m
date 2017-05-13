From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] HID: asus: Add support for T100 keyboard
Date: Sat, 13 May 2017 21:54:28 +0200
Message-ID: <20170513195428.11445-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757433AbdEMTyd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 13 May 2017 15:54:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

The ketboard dock uses with the Asus Transformer T100 series, uses
the same vendor-defined 0xff31 usage-page as some other Asus
keyboards. But with a small twist it has a small descriptor bug which
needs to be fixed up for things to work.

This commit adds adds the USB-ID for this keyboard to the hid-asus
driver and makes asus_report_fixup fix the descriptor issue, fixing
various special function keys on this keyboard not working.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-asus.c | 10 ++++++++++
 drivers/hid/hid-core.c |  1 +
 drivers/hid/hid-ids.h  |  1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 16df6cc90235..101ab2e63d18 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -69,6 +69,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_IS_MULTITOUCH		BIT(3)
 #define QUIRK_NO_CONSUMER_USAGES	BIT(4)
 #define QUIRK_USE_KBD_BACKLIGHT		BIT(5)
+#define QUIRK_T100_KEYBOARD		BIT(6)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -548,6 +549,12 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Asus notebook report descriptor\n");
 		rdesc[55] = 0xdd;
 	}
+	if (drvdata->quirks & QUIRK_T100_KEYBOARD &&
+		 *rsize == 76 && rdesc[73] == 0x81 && rdesc[74] == 0x01) {
+		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
+		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
+	}
+
 	return rdesc;
 }
 
@@ -560,6 +567,9 @@ static const struct hid_device_id asus_devices[] = {
 		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD),
+	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bd48e1568462..10a16b4f946e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1855,6 +1855,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AUREAL, USB_DEVICE_ID_AUREAL_W01RN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185BFM, 0x2208) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 79674a3ee118..8b2d4a75be99 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -173,6 +173,7 @@
 #define USB_VENDOR_ID_ASUSTEK		0x0b05
 #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
 #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
+#define USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD	0x17e0
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
-- 
2.12.2

