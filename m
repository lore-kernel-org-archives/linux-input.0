From: Filip Sobalski <pinkeen@gmail.com>
Subject: [PATCH 2.6.27.8] keyboard: adds support for a4tech keyboards' scroll wheel
Date: Sun, 14 Dec 2008 15:54:15 +0100
Message-ID: <200812141554.15724.pinkeen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:40000 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbYLNOyT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Dec 2008 09:54:19 -0500
Received: by bwz14 with SMTP id 14so754296bwz.13
        for <linux-input@vger.kernel.org>; Sun, 14 Dec 2008 06:54:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org

Adds support for A4tech keyboards' scroll wheel.
To use - set kernel parameter 'atkbd.scroll' to '2'.

Signed-off-by: Filip Sobalski <pinke...@gmail.com>
---
I am not even near to a kernel hacker. Just wanted to
get running my brand new keyboard's scroll wheel.
Hope somebody will find this useful.

With the kernel parameter atkbd.scroll set to `1`
scroll wheel worked only when moved upwards.
I noticed that kernel complains about unknown
scancodes so I changed a few of the ones in
atkbd_scroll_keys, but that didn't do it.
Then I changed keycode switch case ATKBD_SCR_2 so it
gave opposite numbers. That also didn't work.
Turns out these keyboards have completely different
'protocol' for the sw. I continued to test the unknown
scancodes and ended up with 4 new which were generated
by moving the wheel downwards.

Note that the former 4 are the same for this keyboard
so if microsoft used the same (up) scancodes in their
keyboards its fairly safe to assume that this patch
(meaning my scancodes) should work with majority of
a4tech's keyboards' scroll wheels. But of course it
needs testing what exceeds my humble capabilities.

I think that this patch is so trivial that it could
hardly break anything, but see for yourself.

Nevertheless, this hack works flawlessly with my keyboard
and preserves the driver's functionality concerning MSO
keyboards.
--- linux-2.6.27.8/drivers/input/keyboard/atkbd.c.orig	2008-12-14 12:47:32.706217720 +0100
+++ linux-2.6.27.8/drivers/input/keyboard/atkbd.c	2008-12-14 15:22:46.307754840 +0100
@@ -56,8 +56,12 @@ module_param_named(softraw, atkbd_softra
 MODULE_PARM_DESC(softraw, "Use software generated rawmode");

 static int atkbd_scroll;
-module_param_named(scroll, atkbd_scroll, bool, 0);
-MODULE_PARM_DESC(scroll, "Enable scroll-wheel on MS Office and similar keyboards");
+module_param_named(scroll, atkbd_scroll, uint, 0);
+MODULE_PARM_DESC(scroll, "Enable scroll-wheel on MS Office and similar keyboards (=1) "
+				"or a4tech wireless desktop keyboards (=2)");
+/*
+ * A4tech wireless keyboard scroll wheel support
+ * added by Filip Sobalski <pinke...@gmail.com>
+ */

 static int atkbd_extra;
 module_param_named(extra, atkbd_extra, bool, 0);
@@ -160,6 +164,15 @@ static const unsigned short atkbd_unxlat
 #define ATKBD_SCR_CLICK		250
 #define ATKBD_SCR_LEFT		249
 #define ATKBD_SCR_RIGHT		248
+#define ATKBD_SCR_UP_1		247
+#define ATKBD_SCR_UP_2		246
+#define ATKBD_SCR_UP_4		245
+#define ATKBD_SCR_UP_8		244
+#define ATKBD_SCR_DOWN_1	243
+#define ATKBD_SCR_DOWN_2	241
+#define ATKBD_SCR_DOWN_4	240
+#define ATKBD_SCR_DOWN_8	239
+

 #define ATKBD_SPECIAL		ATKBD_SCR_RIGHT

@@ -173,19 +186,37 @@ static const unsigned short atkbd_unxlat
 #define ATKBD_XL_HANGEUL	0x10
 #define ATKBD_XL_HANJA		0x20

-static const struct {
-	unsigned char keycode;
-	unsigned char set2;
-} atkbd_scroll_keys[] = {
-	{ ATKBD_SCR_1,     0xc5 },
-	{ ATKBD_SCR_2,     0x9d },
-	{ ATKBD_SCR_4,     0xa4 },
-	{ ATKBD_SCR_8,     0x9b },
-	{ ATKBD_SCR_CLICK, 0xe0 },
-	{ ATKBD_SCR_LEFT,  0xcb },
-	{ ATKBD_SCR_RIGHT, 0xd2 },
+struct atkbd_scroll_keys_t {
+    unsigned char keycode;
+    unsigned char set2;
+};
+
+static const struct atkbd_scroll_keys_t atkbd_scroll_keys_ms[] = {
+    { ATKBD_SCR_1,      0xc5 },
+    { ATKBD_SCR_2,      0x9d },
+    { ATKBD_SCR_4,      0xa4 },
+    { ATKBD_SCR_8,      0x9b },
+    { ATKBD_SCR_CLICK,  0xe0 },
+    { ATKBD_SCR_LEFT,   0xcb },
+    { ATKBD_SCR_RIGHT,  0xd2 },
+    { ATKBD_KEY_NULL,   0x00 },
+    { ATKBD_KEY_NULL,   0x00 },
 };

+static const struct atkbd_scroll_keys_t atkbd_scroll_keys_a4[] = {
+    { ATKBD_SCR_UP_1,   0xc5 },
+    { ATKBD_SCR_UP_2,   0x9d },
+    { ATKBD_SCR_UP_4,   0xa4 },
+    { ATKBD_SCR_UP_8,   0x9b },
+    { ATKBD_SCR_DOWN_1, 0x9a },
+    { ATKBD_SCR_DOWN_2, 0xa2 },
+    { ATKBD_SCR_DOWN_4, 0xaa },
+    { ATKBD_SCR_DOWN_8, 0xb1 },
+    { ATKBD_SCR_CLICK,  0x88 },
+};
+
+static struct atkbd_scroll_keys_t atkbd_scroll_keys[9];
+
 /*
  * The atkbd control structure
  */
@@ -464,6 +496,30 @@ static irqreturn_t atkbd_interrupt(struc
 		case ATKBD_SCR_8:
 			scroll = 8 - atkbd->release * 16;
 			break;
+		case ATKBD_SCR_UP_1:
+			scroll = 1;
+			break;
+		case ATKBD_SCR_UP_2:
+			scroll = 2;
+			break;
+		case ATKBD_SCR_UP_4:
+			scroll = 4;
+			break;
+		case ATKBD_SCR_UP_8:
+			scroll = 8;
+			break;
+		case ATKBD_SCR_DOWN_1:
+			scroll = -1;
+			break;
+		case ATKBD_SCR_DOWN_2:
+			scroll = -2;
+			break;
+		case ATKBD_SCR_DOWN_4:
+			scroll = -4;
+			break;
+		case ATKBD_SCR_DOWN_8:
+			scroll = -8;
+			break;
 		case ATKBD_SCR_CLICK:
 			click = !atkbd->release;
 			break;
@@ -893,6 +949,14 @@ static void atkbd_set_keycode_table(stru
 	unsigned int scancode;
 	int i, j;

+    if (atkbd->scroll == 1) {
+	memcpy(atkbd_scroll_keys, atkbd_scroll_keys_ms,
+		sizeof(atkbd_scroll_keys));
+    } else if (atkbd->scroll == 2) {
+	memcpy(atkbd_scroll_keys, atkbd_scroll_keys_a4,
+		sizeof(atkbd_scroll_keys));
+    }
+
 	memset(atkbd->keycode, 0, sizeof(atkbd->keycode));
 	bitmap_zero(atkbd->force_release_mask, 512);
