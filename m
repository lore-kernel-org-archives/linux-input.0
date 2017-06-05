From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH 1/2] HID: move Asus keyboard support from hid-chicony to hid-asus
Date: Mon,  5 Jun 2017 14:58:56 -0600
Message-ID: <20170605205857.17789-1-drake@endlessm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34869 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEU7E (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Jun 2017 16:59:04 -0400
Received: by mail-vk0-f53.google.com with SMTP id w1so72744903vkd.2
        for <linux-input@vger.kernel.org>; Mon, 05 Jun 2017 13:59:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux@endlessm.com

The Asus AIO keyboard AK1D was added to hid-chicony based on its
USB vendor ID, however images available online suggest that this keyboard
is physically branded as ASUS with no mention of Chicony.

A recent commit also added support for another Asus AIO keyboard into
hid-chicony, this one with USB vendor ID Jess, and a pending review
comment asked me to move it into hid-asus because it is also only
physically branded as ASUS.

I updated the USB ID defines to match the branding and product name,
including noting that the recently added keyboard is labelled as
ASUS MD-5112.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/hid/hid-asus.c    | 29 +++++++++++++++++++++++++++++
 drivers/hid/hid-chicony.c |  2 --
 drivers/hid/hid-core.c    |  4 ++--
 drivers/hid/hid-ids.h     |  4 ++--
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index a6268f2f7408..16a88da545b1 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -422,6 +422,33 @@ static int asus_input_mapping(struct hid_device *hdev,
 		return 1;
 	}
 
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
+		set_bit(EV_REP, hi->input->evbit);
+		switch (usage->hid & HID_USAGE) {
+		case 0xff01: asus_map_key_clear(BTN_1);	break;
+		case 0xff02: asus_map_key_clear(BTN_2);	break;
+		case 0xff03: asus_map_key_clear(BTN_3);	break;
+		case 0xff04: asus_map_key_clear(BTN_4);	break;
+		case 0xff05: asus_map_key_clear(BTN_5);	break;
+		case 0xff06: asus_map_key_clear(BTN_6);	break;
+		case 0xff07: asus_map_key_clear(BTN_7);	break;
+		case 0xff08: asus_map_key_clear(BTN_8);	break;
+		case 0xff09: asus_map_key_clear(BTN_9);	break;
+		case 0xff0a: asus_map_key_clear(BTN_A);	break;
+		case 0xff0b: asus_map_key_clear(BTN_B);	break;
+		case 0x00f1: asus_map_key_clear(KEY_WLAN);	break;
+		case 0x00f2: asus_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
+		case 0x00f3: asus_map_key_clear(KEY_BRIGHTNESSUP);	break;
+		case 0x00f4: asus_map_key_clear(KEY_DISPLAY_OFF);	break;
+		case 0x00f7: asus_map_key_clear(KEY_CAMERA);	break;
+		case 0x00f8: asus_map_key_clear(KEY_PROG1);	break;
+		default:
+			return 0;
+		}
+
+		return 1;
+	}
+
 	if (drvdata->quirks & QUIRK_NO_CONSUMER_USAGES &&
 		(usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
 		switch (usage->hid & HID_USAGE) {
@@ -572,6 +599,8 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD),
 	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
diff --git a/drivers/hid/hid-chicony.c b/drivers/hid/hid-chicony.c
index f04ed9aabc3f..397a789a41be 100644
--- a/drivers/hid/hid-chicony.c
+++ b/drivers/hid/hid-chicony.c
@@ -84,9 +84,7 @@ static __u8 *ch_switch12_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 static const struct hid_device_id ch_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_ACER_SWITCH12) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_JESS_ZEN_AIO_KBD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ch_devices);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ec214a9117a1..391dcc94d2c2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1869,7 +1869,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_ACER_SWITCH12) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K90) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_SCIMITAR_PRO_RGB) },
@@ -1917,7 +1917,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE8595) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_JESS_ZEN_AIO_KBD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS2, USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8a027c112d90..10ad3899c079 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -252,7 +252,7 @@
 #define USB_DEVICE_ID_CHICONY_WIRELESS	0x0618
 #define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE	0x1053
 #define USB_DEVICE_ID_CHICONY_WIRELESS2	0x1123
-#define USB_DEVICE_ID_CHICONY_AK1D	0x1125
+#define USB_DEVICE_ID_ASUS_AK1D		0x1125
 #define USB_DEVICE_ID_CHICONY_ACER_SWITCH12	0x1421
 
 #define USB_VENDOR_ID_CHUNGHWAT		0x2247
@@ -571,7 +571,7 @@
 
 #define USB_VENDOR_ID_JESS		0x0c45
 #define USB_DEVICE_ID_JESS_YUREX	0x1010
-#define USB_DEVICE_ID_JESS_ZEN_AIO_KBD	0x5112
+#define USB_DEVICE_ID_ASUS_MD_5112	0x5112
 
 #define USB_VENDOR_ID_JESS2		0x0f30
 #define USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD 0x0111
-- 
2.11.0

