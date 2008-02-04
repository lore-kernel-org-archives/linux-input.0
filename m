From: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Subject: [RFA/PATCH] support newer macbook input devices
Date: Mon, 04 Feb 2008 10:37:15 +0100
Message-ID: <1202117835.10709.6.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: mactel-linux-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Harper <basilisk-J+42sR5q9TmsTnJN9+BGXg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Preliminary support for new macbook input devices (keyboard/touchpad)

Signed-off-by: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
---
Diffed against 2.6.24.

This is a "request for adoption", I made this patch for my brother's
macbook but don't have the hardware myself. I'm sure the patch needs
style cleanups/changes and I haven't figured out yet how apple calls the
new touchpad so I called it "Geyser IV.1".

Also, we need the US and JP USB IDs.

Alex, are you still interested in touchpad stuff on the new hardware?

 hid/hid-input.c          |   50 +++++++++++++++++++++++++++++++++++++++++++----
 hid/usbhid/hid-quirks.c  |    2 +
 input/mouse/appletouch.c |   11 +++++++++-
 3 files changed, 58 insertions(+), 5 deletions(-)

Index: linux-2.6.24-rc6/drivers/input/mouse/appletouch.c
===================================================================
--- linux-2.6.24-rc6.orig/drivers/input/mouse/appletouch.c	2007-12-27 01:17:57.000000000 +0100
+++ linux-2.6.24-rc6/drivers/input/mouse/appletouch.c	2007-12-27 01:35:32.000000000 +0100
@@ -62,6 +62,11 @@
 #define GEYSER4_ISO_PRODUCT_ID	0x021B
 #define GEYSER4_JIS_PRODUCT_ID	0x021C
 
+/*
+ * Geyser IV.1 (no difference to IV known so far)
+ */
+#define GEYSER4_1_ISO_PRODUCT_ID	0x022a
+
 #define ATP_DEVICE(prod)					\
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |		\
 		       USB_DEVICE_ID_MATCH_INT_CLASS |		\
@@ -93,6 +98,9 @@
 	{ ATP_DEVICE(GEYSER4_ISO_PRODUCT_ID) },
 	{ ATP_DEVICE(GEYSER4_JIS_PRODUCT_ID) },
 
+	/* Core2 Duo MacBook (late 2007 version) */
+	{ ATP_DEVICE(GEYSER4_1_ISO_PRODUCT_ID) },
+
 	/* Terminating entry */
 	{ }
 };
@@ -217,7 +225,8 @@
 		(productId == GEYSER3_JIS_PRODUCT_ID) ||
 		(productId == GEYSER4_ANSI_PRODUCT_ID) ||
 		(productId == GEYSER4_ISO_PRODUCT_ID) ||
-		(productId == GEYSER4_JIS_PRODUCT_ID);
+		(productId == GEYSER4_JIS_PRODUCT_ID) ||
+		(productId == GEYSER4_1_ISO_PRODUCT_ID);
 }
 
 /*
Index: linux-2.6.24-rc6/drivers/hid/usbhid/hid-quirks.c
===================================================================
--- linux-2.6.24-rc6.orig/drivers/hid/usbhid/hid-quirks.c	2007-12-27 02:05:09.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hid/usbhid/hid-quirks.c	2007-12-27 02:06:52.000000000 +0100
@@ -59,6 +59,7 @@
 #define USB_DEVICE_ID_APPLE_GEYSER4_ANSI	0x021a
 #define USB_DEVICE_ID_APPLE_GEYSER4_ISO	0x021b
 #define USB_DEVICE_ID_APPLE_GEYSER4_JIS	0x021c
+#define USB_DEVICE_ID_APPLE_GEYSER4_1_ISO	0x022a
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
 #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
 #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
@@ -551,6 +552,7 @@
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_POWERBOOK_ISO_KEYBOARD},
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_1_ISO, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_POWERBOOK_ISO_KEYBOARD},
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 
Index: linux-2.6.24-rc6/drivers/hid/hid-input.c
===================================================================
--- linux-2.6.24-rc6.orig/drivers/hid/hid-input.c	2007-12-27 02:34:47.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hid/hid-input.c	2007-12-27 02:59:41.000000000 +0100
@@ -119,6 +119,27 @@
 	{ }
 };
 
+static struct hidinput_key_translation macbook_fn_keys[] = {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F3,	KEY_PROG1,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F4,	KEY_PROG2,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F5,	KEY_PROG3,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F6,	KEY_PROG4,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F7,	KEY_PREVIOUSSONG,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F8,	KEY_PLAYPAUSE,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F9,	KEY_NEXTSONG,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F10,	KEY_MUTE,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F11,	KEY_VOLUMEDOWN,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F12,	KEY_VOLUMEUP,		POWERBOOK_FLAG_FKEY },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
 static struct hidinput_key_translation powerbook_numlock_keys[] = {
 	{ KEY_J,        KEY_KP1 },
 	{ KEY_K,        KEY_KP2 },
@@ -177,7 +198,10 @@
 	if (hid_pb_fnmode) {
 		int do_translate;
 
-		trans = find_translation(powerbook_fn_keys, usage->code);
+		if (hid->product == 0x22a)
+			trans = find_translation(macbook_fn_keys, usage->code);
+		else
+			trans = find_translation(powerbook_fn_keys, usage->code);
 		if (trans) {
 			if (test_bit(usage->code, hid->pb_pressed_fn))
 				do_translate = 1;
@@ -228,10 +252,28 @@
 	return 0;
 }
 
-static void hidinput_pb_setup(struct input_dev *input)
+static void hidinput_macbook_setup(struct input_dev *input)
+{
+	struct hidinput_key_translation *trans;
+
+	/* Enable all needed keys */
+	for (trans = macbook_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
+	for (trans = powerbook_iso_keyboard; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+}
+
+static void hidinput_pb_setup(struct hid_device *hid, struct input_dev *input)
 {
 	struct hidinput_key_translation *trans;
 
+	/* new MacBooks */
+	if (hid->product == 0x22a) {
+		hidinput_macbook_setup(input);
+		return;
+	}
+
 	set_bit(KEY_NUMLOCK, input->keybit);
 
 	/* Enable all needed keys */
@@ -252,7 +294,7 @@
 	return 0;
 }
 
-static inline void hidinput_pb_setup(struct input_dev *input)
+static inline void hidinput_pb_setup(struct hid_device *hid, struct input_dev *input)
 {
 }
 #endif
@@ -792,7 +834,7 @@
 				case 0x003:
 					/* The fn key on Apple PowerBooks */
 					map_key_clear(KEY_FN);
-					hidinput_pb_setup(input);
+					hidinput_pb_setup(device, input);
 					break;
 
 				default:    goto ignore;
