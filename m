From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH] hid-asus: support Republic of Gamers special keys
Date: Thu, 16 Feb 2017 07:07:20 -0600
Message-ID: <20170216130720.4832-1-drake@endlessm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34274 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754386AbdBPNH2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Feb 2017 08:07:28 -0500
Received: by mail-ua0-f175.google.com with SMTP id 35so10112020uak.1
        for <linux-input@vger.kernel.org>; Thu, 16 Feb 2017 05:07:27 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux@endlessm.com, chiu@endlessm.com

From: Chris Chiu <chiu@endlessm.com>

Add support for the special keys found on the internal keyboard of the
Asus Republic of Gamers (ROG) laptop models GL553VD, GL553VE, GL753VD
and GL753VE.

Also remove HID_ASUS's dependency on I2C_HID because there is nothing
transport-specific in this driver.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/hid/Kconfig    |  6 ++++--
 drivers/hid/hid-asus.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-core.c |  2 ++
 drivers/hid/hid-ids.h  |  2 ++
 include/linux/hid.h    |  1 +
 5 files changed, 47 insertions(+), 2 deletions(-)

Replaces earlier patch titled:
 HID: add Asus macrokey support for Asus "Republic of Gamers" laptop

Moved this into hid-asus and also added the entries to hid_have_special_driver

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1aeb80e..31bb0b2 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -136,13 +136,15 @@ config HID_APPLEIR
 
 config HID_ASUS
 	tristate "Asus"
-	depends on I2C_HID
 	---help---
-	Support for Asus notebook built-in keyboard and touchpad via i2c.
+	Support for Asus notebook built-in keyboard and touchpad via i2c, and
+	the Asus Republic of Gamers laptop keyboard special keys.
 
 	Supported devices:
 	- EeeBook X205TA
 	- VivoBook E200HA
+	- GL553V series
+	- GL753V series
 
 config HID_AUREAL
 	tristate "Aureal"
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 70b12f8..cdfe5f0 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -199,6 +199,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	return 0;
 }
 
+#define rog_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, \
+						    max, EV_KEY, (c))
 static int asus_input_mapping(struct hid_device *hdev,
 		struct hid_input *hi, struct hid_field *field,
 		struct hid_usage *usage, unsigned long **bit,
@@ -213,6 +215,38 @@ static int asus_input_mapping(struct hid_device *hdev,
 		return -1;
 	}
 
+	/* ASUS Republic of Gamers laptop keyboard hotkeys */
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR) {
+		set_bit(EV_REP, hi->input->evbit);
+		switch (usage->hid & HID_USAGE) {
+		case 0x10: rog_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
+		case 0x20: rog_map_key_clear(KEY_BRIGHTNESSUP);		break;
+		case 0x35: rog_map_key_clear(KEY_DISPLAY_OFF);		break;
+		case 0x6c: rog_map_key_clear(KEY_SLEEP);		break;
+		case 0x82: rog_map_key_clear(KEY_CAMERA);		break;
+		case 0x88: rog_map_key_clear(KEY_WLAN);			break;
+		case 0xb5: rog_map_key_clear(KEY_CALC);			break;
+		case 0xc4: rog_map_key_clear(KEY_KBDILLUMUP);		break;
+		case 0xc5: rog_map_key_clear(KEY_KBDILLUMDOWN);		break;
+
+		/* ASUS touchpad toggle */
+		case 0x6b: rog_map_key_clear(KEY_F21);			break;
+
+		/* ROG key */
+		case 0x38: rog_map_key_clear(KEY_PROG1);		break;
+
+		/* Fn+C ASUS Splendid */
+		case 0xba: rog_map_key_clear(KEY_PROG2);		break;
+
+		/* Fn+Space Power4Gear Hybrid */
+		case 0x5c: rog_map_key_clear(KEY_PROG3);		break;
+
+		default:
+			return 0;
+		}
+		return 1;
+	}
+
 	return 0;
 }
 
@@ -323,6 +357,10 @@ static const struct hid_device_id asus_devices[] = {
 		 USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD), KEYBOARD_QUIRKS},
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
 			 USB_DEVICE_ID_ASUSTEK_TOUCHPAD), TOUCHPAD_QUIRKS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1), 0 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 538ff69..2d31d1d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1853,6 +1853,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_TOUCHPAD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AUREAL, USB_DEVICE_ID_AUREAL_W01RN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185BFM, 0x2208) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 86c95d3..ea5b968 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -175,6 +175,8 @@
 #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
 #define USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_TOUCHPAD	0x0101
+#define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
+#define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2 0x1837
 
 #define USB_VENDOR_ID_ATEN		0x0557
 #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 28f38e2b8..bf93241 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -167,6 +167,7 @@ struct hid_item {
 #define HID_UP_HPVENDOR2        0xff010000
 #define HID_UP_MSVENDOR		0xff000000
 #define HID_UP_CUSTOM		0x00ff0000
+#define HID_UP_ASUSVENDOR	0xff310000
 #define HID_UP_LOGIVENDOR	0xffbc0000
 #define HID_UP_LOGIVENDOR2   0xff090000
 #define HID_UP_LOGIVENDOR3   0xff430000
-- 
2.9.3

