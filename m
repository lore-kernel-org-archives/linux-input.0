From: Dirk Hohndel <dirk@hohndel.org>
Subject: [PATCH] Add support for the MacBook Pro 10,2 keyboard / touchpad
Date: Tue, 30 Oct 2012 12:51:29 -0700 (PDT)
Message-ID: <20121030125129.631506.FMU5719@air.gr8dns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.hohndel.org ([198.145.64.135]:60815 "EHLO mail.hohndel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab2J3T5v (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Oct 2012 15:57:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Linus Torvalds <torvalds@linux-foundation.org>


>From 364d79a254029881345d34ab02d5127fe74e288c Mon Sep 17 00:00:00 2001
From: Dirk Hohndel <dirk@hohndel.org>
Date: Tue, 30 Oct 2012 11:11:48 -0700
Subject: [PATCH] Add support for the MacBook Pro 10,2 keyboard / touchpad

This enables the existing drivers for keyboard and touchpad with the new
USB IDs found on the MBP 13" Reasonable Resolution (also known as the
Retina Display).

Signed-off-by: Dirk Hohndel <dirk@hohndel.org>
---
 drivers/hid/hid-apple.c       |  6 ++++++
 drivers/hid/hid-core.c        |  3 +++
 drivers/hid/hid-ids.h         |  3 +++
 drivers/input/mouse/bcm5974.c | 21 +++++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 06ebdbb..fd7722a 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -522,6 +522,12 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_JIS),
 		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS),
+		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bd3971b..e0f7a83 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1532,6 +1532,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ISO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_JIS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 269b509..9d7a428 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -118,6 +118,9 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI	0x0252
 #define USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO	0x0253
 #define USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS	0x0254
+#define USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI	0x0259
+#define USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO	0x025a
+#define USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS	0x025b
 #define USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI	0x0249
 #define USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO	0x024a
 #define USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS	0x024b
diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 3a78f23..2baff1b 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -84,6 +84,10 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI	0x0262
 #define USB_DEVICE_ID_APPLE_WELLSPRING7_ISO	0x0263
 #define USB_DEVICE_ID_APPLE_WELLSPRING7_JIS	0x0264
+/* MacbookPro10,2 (unibody, October 2012) */
+#define USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI	0x0259
+#define USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO	0x025a
+#define USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS	0x025b
 
 #define BCM5974_DEVICE(prod) {					\
 	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -137,6 +141,10 @@ static const struct usb_device_id bcm5974_table[] = {
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7_ISO),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7_JIS),
+	/* MacbookPro10,2 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS),
 	/* Terminating entry */
 	{}
 };
@@ -379,6 +387,19 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		{ SN_COORD, -150, 6730 },
 		{ SN_ORIENT, -MAX_FINGER_ORIENTATION, MAX_FINGER_ORIENTATION }
 	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0x84, sizeof(struct bt_data),
+		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		{ SN_PRESSURE, 0, 300 },
+		{ SN_WIDTH, 0, 2048 },
+		{ SN_COORD, -4750, 5280 },
+		{ SN_COORD, -150, 6730 },
+		{ SN_ORIENT, -MAX_FINGER_ORIENTATION, MAX_FINGER_ORIENTATION }
+	},
 	{}
 };
 
-- 
1.8.0.rc0.18.gf84667d


-- 
Dirk Hohndel
Intel Open Source Technology Center
