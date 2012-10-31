From: Dirk Hohndel <dirk@hohndel.org>
Subject: Re: [PATCH] Add support for the MacBook Pro 10,2 keyboard / touchpad
Date: Tue, 30 Oct 2012 23:02:28 -0700 (PDT)
Message-ID: <20121030230228.356490.FMU5080@air.gr8dns.org>
References: <20121030222211.GA20026@polaris.bitmath.org> <13ab3c9f72c.2202.2747.dirk@hohndel.org> <20121031054854.GA31983@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.hohndel.org ([198.145.64.135]:40941 "EHLO mail.hohndel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab2JaGCa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 02:02:30 -0400
In-Reply-To: <20121031054854.GA31983@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>

--=-=-=
Content-Type: text/plain

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>> >
>> >The entry in hid_mouse_ignore_list seems to be missing.
>> 
>> Correct. It works fine without that.
>
> Pure luck I think as entries for bcm5974 get sorted before entries for
> HID. To be safe and make sure it works if hid is built-in we need to add
> the new devices to hid_mouse_ignore_list.

Erm - what makes you think I tested this as a module? Actually, come to
think of, I ONLY tested this built in.

> That for devices driven by hid-multitouch, so not applicable to this
> case.

Ok, thanks

>> The keyboard definitely needs it, though.
>> 
>> Let me phrase it this way: the patch, as submitted, happily works on my rMBP 13
>
> By pure luck.

I'll take your word for it. Here's an updated patch

/D


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-Add-support-for-the-MacBook-Pro-10-2-keyboard-touchp.patch

>From 67842b2edeb26e90f2805160e06163ab5f7d87f0 Mon Sep 17 00:00:00 2001
From: Dirk Hohndel <dirk@hohndel.org>
Date: Tue, 30 Oct 2012 11:11:48 -0700
Subject: [PATCH] Add support for the MacBook Pro 10,2 keyboard / touchpad

This enables the existing drivers for keyboard and touchpad with the new
USB IDs found on the MBP 13" Reasonable Resolution (also known as the
Retina Display).

Added entries to both keyboard and mouse ignore lists.

Signed-off-by: Dirk Hohndel <dirk@hohndel.org>
---
 drivers/hid/hid-apple.c       |  6 ++++++
 drivers/hid/hid-core.c        |  6 ++++++
 drivers/hid/hid-ids.h         |  3 +++
 drivers/input/mouse/bcm5974.c | 21 +++++++++++++++++++++
 4 files changed, 36 insertions(+)

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
index bd3971b..f4109fd 100644
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
@@ -2139,6 +2142,9 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ISO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_JIS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
 	{ }
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


--=-=-=
Content-Type: text/plain


-- 
Dirk Hohndel
Intel Open Source Technology Center

--=-=-=--
