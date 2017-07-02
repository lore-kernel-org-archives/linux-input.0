From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/5] HID: asus: Add T100CHI bluetooth keyboard dock special keys mapping
Date: Sun,  2 Jul 2017 16:34:15 +0200
Message-ID: <20170702143416.23643-5-hdegoede@redhat.com>
References: <20170702143416.23643-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbdGBOeZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 2 Jul 2017 10:34:25 -0400
In-Reply-To: <20170702143416.23643-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

The Asus Transformer T100CHI comes with a Bluetooth keyboard dock which
uses the same 0xff31 Asus vendor HUT page as other Asus keyboards.

This commit adds its device-id to hid-asus and fixes an issue in the
descriptor of the 0xff31 Usage, which together fixes the special keys
on this keyboard not working.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-asus.c | 26 ++++++++++++++++++++++++++
 drivers/hid/hid-core.c |  1 +
 drivers/hid/hid-ids.h  |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index e27cc4a25ed0..d5519479142f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -65,6 +65,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_NO_CONSUMER_USAGES	BIT(4)
 #define QUIRK_USE_KBD_BACKLIGHT		BIT(5)
 #define QUIRK_T100_KEYBOARD		BIT(6)
+#define QUIRK_T100CHI			BIT(7)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -592,11 +593,34 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Asus notebook report descriptor\n");
 		rdesc[55] = 0xdd;
 	}
+	/* For the T100TA keyboard dock */
 	if (drvdata->quirks & QUIRK_T100_KEYBOARD &&
 		 *rsize == 76 && rdesc[73] == 0x81 && rdesc[74] == 0x01) {
 		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
 		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
 	}
+	/* For the T100CHI keyboard dock */
+	if (drvdata->quirks & QUIRK_T100CHI &&
+		 *rsize == 403 && rdesc[388] == 0x09 && rdesc[389] == 0x76) {
+		/*
+		 * Change Usage (76h) to Usage Minimum (00h), Usage Maximum
+		 * (FFh) and clear the flags in the Input() byte.
+		 * Note the descriptor has a bogus 0 byte at the end so we
+		 * only need 1 extra byte.
+		 */
+		*rsize = 404;
+		rdesc = kmemdup(rdesc, *rsize, GFP_KERNEL);
+		if (!rdesc)
+			return NULL;
+
+		hid_info(hdev, "Fixing up T100CHI keyb report descriptor\n");
+		memmove(rdesc + 392, rdesc + 390, 12);
+		rdesc[388] = 0x19;
+		rdesc[389] = 0x00;
+		rdesc[390] = 0x29;
+		rdesc[391] = 0xff;
+		rdesc[402] = 0x00;
+	}
 
 	return rdesc;
 }
@@ -613,6 +637,8 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD),
 	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD), QUIRK_T100CHI },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bf7f46e8a022..6220e6e8e979 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1892,6 +1892,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD) },
 #endif
 #if IS_ENABLED(CONFIG_HID_AUREAL)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AUREAL, USB_DEVICE_ID_AUREAL_W01RN) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8acd1b779f6d..73b440c822e9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -174,6 +174,7 @@
 #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
 #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
 #define USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD	0x17e0
+#define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
-- 
2.13.0

