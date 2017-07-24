From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH 2/2] HID: multitouch: Support Asus T304UA media keys
Date: Mon, 24 Jul 2017 14:22:25 -0700
Message-ID: <20170724212225.3426-3-jprvita@endlessm.com>
References: <20170724212225.3426-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35360 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755884AbdGXVWr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 17:22:47 -0400
In-Reply-To: <20170724212225.3426-1-jprvita@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux@endlessm.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The Asus T304UA convertible sports a magnetic detachable keyboard with
touchpad, which is connected over USB. Most of the keyboard hotkeys are
exposed through the same USB interface as the touchpad, defined in the
report descriptor as follows:

0x06, 0x31, 0xFF,  // Usage Page (Vendor Defined 0xFF31)
0x09, 0x76,        // Usage (0x76)
0xA1, 0x01,        // Collection (Application)
0x05, 0xFF,        //   Usage Page (Reserved 0xFF)
0x85, 0x5A,        //   Report ID (90)
0x19, 0x00,        //   Usage Minimum (0x00)
0x2A, 0xFF, 0x00,  //   Usage Maximum (0xFF)
0x15, 0x00,        //   Logical Minimum (0)
0x26, 0xFF, 0x00,  //   Logical Maximum (255)
0x75, 0x08,        //   Report Size (8)
0x95, 0x0F,        //   Report Count (15)
0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
0x05, 0xFF,        //   Usage Page (Reserved 0xFF)
0x85, 0x5A,        //   Report ID (90)
0x19, 0x00,        //   Usage Minimum (0x00)
0x2A, 0xFF, 0x00,  //   Usage Maximum (0xFF)
0x15, 0x00,        //   Logical Minimum (0)
0x26, 0xFF, 0x00,  //   Logical Maximum (255)
0x75, 0x08,        //   Report Size (8)
0x95, 0x02,        //   Report Count (2)
0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
0xC0,              // End Collection

This UsagePage is declared as a variable, but we need to treat it as an
array to be able to map each Usage we care about to its corresponding
input key.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/hid/hid-ids.h        |  1 +
 drivers/hid/hid-multitouch.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/hid.h          |  2 ++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3d911bfd91cf..6b7f9707076e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -176,6 +176,7 @@
 #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
 #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
 #define USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD	0x17e0
+#define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 152d33120a55..6b3de7b01571 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -72,6 +72,7 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_FIX_CONST_CONTACT_ID	BIT(14)
 #define MT_QUIRK_TOUCH_SIZE_SCALING	BIT(15)
 #define MT_QUIRK_STICKY_FINGERS		BIT(16)
+#define MT_QUIRK_ASUS_CUSTOM_UP		BIT(17)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -169,6 +170,7 @@ static void mt_post_parse(struct mt_device *td);
 #define MT_CLS_GENERALTOUCH_TWOFINGERS		0x0108
 #define MT_CLS_GENERALTOUCH_PWT_TENFINGERS	0x0109
 #define MT_CLS_LG				0x010a
+#define MT_CLS_ASUS				0x010b
 #define MT_CLS_VTL				0x0110
 #define MT_CLS_GOOGLE				0x0111
 
@@ -290,6 +292,10 @@ static struct mt_class mt_classes[] = {
 			MT_QUIRK_IGNORE_DUPLICATES |
 			MT_QUIRK_HOVERING |
 			MT_QUIRK_CONTACT_CNT_ACCURATE },
+	{ .name = MT_CLS_ASUS,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_ASUS_CUSTOM_UP },
 	{ .name = MT_CLS_VTL,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
@@ -905,6 +911,8 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	return 0;
 }
 
+#define mt_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, \
+						    max, EV_KEY, (c))
 static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
@@ -923,10 +931,35 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	    field->application != HID_DG_TOUCHPAD &&
 	    field->application != HID_GD_KEYBOARD &&
 	    field->application != HID_CP_CONSUMER_CONTROL &&
-	    field->application != HID_GD_WIRELESS_RADIO_CTLS)
+	    field->application != HID_GD_WIRELESS_RADIO_CTLS &&
+	    !(field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
+	      td->mtclass.quirks & MT_QUIRK_ASUS_CUSTOM_UP))
 		return -1;
 
 	/*
+	 * Some Asus keyboard+touchpad devices have the hotkeys defined in the
+	 * touchpad report descriptor. We need to treat these as an array to
+	 * map usages to input keys.
+	 */
+	if (field->application == 0xff310076 &&
+	    td->mtclass.quirks & MT_QUIRK_ASUS_CUSTOM_UP &&
+	    (usage->hid & HID_USAGE_PAGE) == HID_UP_CUSTOM) {
+		set_bit(EV_REP, hi->input->evbit);
+		if (field->flags & HID_MAIN_ITEM_VARIABLE)
+			field->flags &= ~HID_MAIN_ITEM_VARIABLE;
+		switch (usage->hid & HID_USAGE) {
+		case 0x10: mt_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
+		case 0x20: mt_map_key_clear(KEY_BRIGHTNESSUP);		break;
+		case 0x35: mt_map_key_clear(KEY_DISPLAY_OFF);		break;
+		case 0x6b: mt_map_key_clear(KEY_F21);			break;
+		case 0x6c: mt_map_key_clear(KEY_SLEEP);			break;
+		default:
+			return -1;
+		}
+		return 1;
+	}
+
+	/*
 	 * some egalax touchscreens have "application == HID_DG_TOUCHSCREEN"
 	 * for the stylus.
 	 * The check for mt_report_id ensures we don't process
@@ -1137,6 +1170,9 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		case HID_GD_WIRELESS_RADIO_CTLS:
 			suffix = "Wireless Radio Control";
 			break;
+		case HID_VD_ASUS_CUSTOM_MEDIA_KEYS:
+			suffix = "Custom Media Keys";
+			break;
 		default:
 			suffix = "UNKNOWN";
 			break;
@@ -1388,6 +1424,12 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_ANTON,
 			USB_DEVICE_ID_ANTON_TOUCH_PAD) },
 
+	/* Asus T304UA */
+	{ .driver_data = MT_CLS_ASUS,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_ASUSTEK,
+			USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD) },
+
 	/* Atmel panels */
 	{ .driver_data = MT_CLS_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_ATMEL,
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 5006f9b5d837..a08e6b15d98d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -173,6 +173,7 @@ struct hid_item {
 #define HID_UP_LOGIVENDOR3   0xff430000
 #define HID_UP_LNVENDOR		0xffa00000
 #define HID_UP_SENSOR		0x00200000
+#define HID_UP_ASUSVENDOR	0xff310000
 
 #define HID_USAGE		0x0000ffff
 
@@ -292,6 +293,7 @@ struct hid_item {
 #define HID_DG_BARRELSWITCH2	0x000d005a
 #define HID_DG_TOOLSERIALNUMBER	0x000d005b
 
+#define HID_VD_ASUS_CUSTOM_MEDIA_KEYS	0xff310076
 /*
  * HID report types --- Ouch! HID spec says 1 2 3!
  */
-- 
2.13.2

