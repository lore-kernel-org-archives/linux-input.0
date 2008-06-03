From: Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: [PATCH 1/2] ati_remote2: Add loadable keymap support
Date: Tue,  3 Jun 2008 21:45:46 +0300
Message-ID: <1212518747-23000-1-git-send-email-syrjala@sci.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Stokes <linux-2UcvvYt7w9fQXOPxS62xeg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Support for loadable keymaps. The driver now supports individual keymaps
for each of the five modes (AUX1-AUX4 and PC) of the remote. To achieve
this the keymap scancode is interpreted as a combination of the mode and
actual button scancode. The original keycode patches were done by Peter
Stokes <linux-2UcvvYt7w9fQXOPxS62xeg@public.gmane.org> but I modified it quite a lot.

Signed-off-by: Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
---
 drivers/input/misc/ati_remote2.c |  130 +++++++++++++++++++++++++++++---------
 1 files changed, 101 insertions(+), 29 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index f2709b8..b80b2fa 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -1,8 +1,8 @@
 /*
  * ati_remote2 - ATI/Philips USB RF remote driver
  *
- * Copyright (C) 2005 Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
- * Copyright (C) 2007 Peter Stokes <linux-c3qaBEMxZpTYB/AZRZ3tHL0Ud+EcFu5g@public.gmane.org>
+ * Copyright (C) 2005-2008 Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
+ * Copyright (C) 2007-2008 Peter Stokes <linux-2UcvvYt7w9fQXOPxS62xeg@public.gmane.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2
@@ -12,7 +12,7 @@
 #include <linux/usb/input.h>
 
 #define DRIVER_DESC    "ATI/Philips USB RF remote driver"
-#define DRIVER_VERSION "0.2"
+#define DRIVER_VERSION "0.3"
 
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_VERSION(DRIVER_VERSION);
@@ -27,7 +27,7 @@ MODULE_LICENSE("GPL");
  * A remote's "channel" may be altered by pressing and holding the "PC" button for
  * approximately 3 seconds, after which the button will slowly flash the count of the
  * currently configured "channel", using the numeric keypad enter a number between 1 and
- * 16 and then the "PC" button again, the button will slowly flash the count of the
+ * 16 and then press the "PC" button again, the button will slowly flash the count of the
  * newly configured "channel".
  */
 
@@ -45,9 +45,18 @@ static struct usb_device_id ati_remote2_id_table[] = {
 };
 MODULE_DEVICE_TABLE(usb, ati_remote2_id_table);
 
-static struct {
-	int hw_code;
-	int key_code;
+enum {
+	ATI_REMOTE2_AUX1,
+	ATI_REMOTE2_AUX2,
+	ATI_REMOTE2_AUX3,
+	ATI_REMOTE2_AUX4,
+	ATI_REMOTE2_PC,
+	ATI_REMOTE2_MODES,
+};
+
+static const struct {
+	u8  hw_code;
+	u16 keycode;
 } ati_remote2_key_table[] = {
 	{ 0x00, KEY_0 },
 	{ 0x01, KEY_1 },
@@ -73,6 +82,7 @@ static struct {
 	{ 0x37, KEY_RECORD },
 	{ 0x38, KEY_DVD },
 	{ 0x39, KEY_TV },
+	{ 0x3f, KEY_PROG1 }, /* AUX1-AUX4 and PC */
 	{ 0x54, KEY_MENU },
 	{ 0x58, KEY_UP },
 	{ 0x59, KEY_DOWN },
@@ -91,15 +101,9 @@ static struct {
 	{ 0xa9, BTN_LEFT },
 	{ 0xaa, BTN_RIGHT },
 	{ 0xbe, KEY_QUESTION },
-	{ 0xd5, KEY_FRONT },
 	{ 0xd0, KEY_EDIT },
+	{ 0xd5, KEY_FRONT },
 	{ 0xf9, KEY_INFO },
-	{ (0x00 << 8) | 0x3f, KEY_PROG1 },
-	{ (0x01 << 8) | 0x3f, KEY_PROG2 },
-	{ (0x02 << 8) | 0x3f, KEY_PROG3 },
-	{ (0x03 << 8) | 0x3f, KEY_PROG4 },
-	{ (0x04 << 8) | 0x3f, KEY_PC },
-	{ 0, KEY_RESERVED }
 };
 
 struct ati_remote2 {
@@ -117,6 +121,9 @@ struct ati_remote2 {
 
 	char name[64];
 	char phys[64];
+
+	/* Each mode (AUX1-AUX4 and PC) can have an independent keymap. */
+	u16 keycode[ATI_REMOTE2_MODES][ARRAY_SIZE(ati_remote2_key_table)];
 };
 
 static int ati_remote2_probe(struct usb_interface *interface, const struct usb_device_id *id);
@@ -172,7 +179,7 @@ static void ati_remote2_input_mouse(struct ati_remote2 *ar2)
 
 	mode = data[0] & 0x0F;
 
-	if (mode > 4) {
+	if (mode > ATI_REMOTE2_PC) {
 		dev_err(&ar2->intf[0]->dev,
 			"Unknown mode byte (%02x %02x %02x %02x)\n",
 			data[3], data[2], data[1], data[0]);
@@ -191,7 +198,7 @@ static int ati_remote2_lookup(unsigned int hw_code)
 {
 	int i;
 
-	for (i = 0; ati_remote2_key_table[i].key_code != KEY_RESERVED; i++)
+	for (i = 0; i < ARRAY_SIZE(ati_remote2_key_table); i++)
 		if (ati_remote2_key_table[i].hw_code == hw_code)
 			return i;
 
@@ -211,7 +218,7 @@ static void ati_remote2_input_key(struct ati_remote2 *ar2)
 
 	mode = data[0] & 0x0F;
 
-	if (mode > 4) {
+	if (mode > ATI_REMOTE2_PC) {
 		dev_err(&ar2->intf[1]->dev,
 			"Unknown mode byte (%02x %02x %02x %02x)\n",
 			data[3], data[2], data[1], data[0]);
@@ -219,10 +226,6 @@ static void ati_remote2_input_key(struct ati_remote2 *ar2)
 	}
 
 	hw_code = data[2];
-	/*
-	 * Mode keys (AUX1-AUX4, PC) all generate the same code byte.
-	 * Use the mode byte to figure out which one was pressed.
-	 */
 	if (hw_code == 0x3f) {
 		/*
 		 * For some incomprehensible reason the mouse pad generates
@@ -236,8 +239,6 @@ static void ati_remote2_input_key(struct ati_remote2 *ar2)
 
 		if (data[1] == 0)
 			ar2->mode = mode;
-
-		hw_code |= mode << 8;
 	}
 
 	if (!((1 << mode) & mode_mask))
@@ -260,8 +261,8 @@ static void ati_remote2_input_key(struct ati_remote2 *ar2)
 	case 2:	/* repeat */
 
 		/* No repeat for mouse buttons. */
-		if (ati_remote2_key_table[index].key_code == BTN_LEFT ||
-		    ati_remote2_key_table[index].key_code == BTN_RIGHT)
+		if (ar2->keycode[mode][index] == BTN_LEFT ||
+		    ar2->keycode[mode][index] == BTN_RIGHT)
 			return;
 
 		if (!time_after_eq(jiffies, ar2->jiffies))
@@ -276,7 +277,7 @@ static void ati_remote2_input_key(struct ati_remote2 *ar2)
 		return;
 	}
 
-	input_event(idev, EV_KEY, ati_remote2_key_table[index].key_code, data[1]);
+	input_event(idev, EV_KEY, ar2->keycode[mode][index], data[1]);
 	input_sync(idev);
 }
 
@@ -334,10 +335,60 @@ static void ati_remote2_complete_key(struct urb *urb)
 			"%s(): usb_submit_urb() = %d\n", __FUNCTION__, r);
 }
 
+static int ati_remote2_getkeycode(struct input_dev *idev,
+				  int scancode, int *keycode)
+{
+	struct ati_remote2 *ar2 = input_get_drvdata(idev);
+	int index, mode;
+
+	mode = scancode >> 8;
+	if (mode > ATI_REMOTE2_PC || !((1 << mode) & mode_mask))
+		return -EINVAL;
+
+	index = ati_remote2_lookup(scancode & 0xFF);
+	if (index < 0)
+		return -EINVAL;
+
+	*keycode = ar2->keycode[mode][index];
+	return 0;
+}
+
+static int ati_remote2_setkeycode(struct input_dev *idev, int scancode, int keycode)
+{
+	struct ati_remote2 *ar2 = input_get_drvdata(idev);
+	int index, mode, old_keycode;
+
+	mode = scancode >> 8;
+	if (mode > ATI_REMOTE2_PC || !((1 << mode) & mode_mask))
+		return -EINVAL;
+
+	index = ati_remote2_lookup(scancode & 0xFF);
+	if (index < 0)
+		return -EINVAL;
+
+	if (keycode < KEY_RESERVED || keycode > KEY_MAX)
+		return -EINVAL;
+
+	old_keycode = ar2->keycode[mode][index];
+	ar2->keycode[mode][index] = keycode;
+	set_bit(keycode, idev->keybit);
+
+	for (mode = 0; mode < ATI_REMOTE2_MODES; mode++) {
+		for (index = 0; index < ARRAY_SIZE(ati_remote2_key_table); index++) {
+			if (ar2->keycode[mode][index] == old_keycode)
+				return 0;
+		}
+	}
+
+	clear_bit(old_keycode, idev->keybit);
+
+	return 0;
+}
+
 static int ati_remote2_input_init(struct ati_remote2 *ar2)
 {
 	struct input_dev *idev;
-	int i, retval;
+	int index, mode, retval;
 
 	idev = input_allocate_device();
 	if (!idev)
@@ -350,8 +401,26 @@ static int ati_remote2_input_init(struct ati_remote2 *ar2)
 	idev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_LEFT) |
 		BIT_MASK(BTN_RIGHT);
 	idev->relbit[0] = BIT_MASK(REL_X) | BIT_MASK(REL_Y);
-	for (i = 0; ati_remote2_key_table[i].key_code != KEY_RESERVED; i++)
-		set_bit(ati_remote2_key_table[i].key_code, idev->keybit);
+
+	for (mode = 0; mode < ATI_REMOTE2_MODES; mode++) {
+		for (index = 0; index < ARRAY_SIZE(ati_remote2_key_table); index++) {
+			ar2->keycode[mode][index] = ati_remote2_key_table[index].keycode;
+			set_bit(ar2->keycode[mode][index], idev->keybit);
+		}
+	}
+
+	/* AUX1-AUX4 and PC generate the same scancode. */
+	index = ati_remote2_lookup(0x3f);
+	ar2->keycode[ATI_REMOTE2_AUX1][index] = KEY_PROG1;
+	ar2->keycode[ATI_REMOTE2_AUX2][index] = KEY_PROG2;
+	ar2->keycode[ATI_REMOTE2_AUX3][index] = KEY_PROG3;
+	ar2->keycode[ATI_REMOTE2_AUX4][index] = KEY_PROG4;
+	ar2->keycode[ATI_REMOTE2_PC][index] = KEY_PC;
+	set_bit(KEY_PROG1, idev->keybit);
+	set_bit(KEY_PROG2, idev->keybit);
+	set_bit(KEY_PROG3, idev->keybit);
+	set_bit(KEY_PROG4, idev->keybit);
+	set_bit(KEY_PC, idev->keybit);
 
 	idev->rep[REP_DELAY]  = 250;
 	idev->rep[REP_PERIOD] = 33;
@@ -359,6 +428,9 @@ static int ati_remote2_input_init(struct ati_remote2 *ar2)
 	idev->open = ati_remote2_open;
 	idev->close = ati_remote2_close;
 
+	idev->getkeycode = ati_remote2_getkeycode;
+	idev->setkeycode = ati_remote2_setkeycode;
+
 	idev->name = ar2->name;
 	idev->phys = ar2->phys;
 
-- 
1.5.3.7

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
