From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] Input: amikbd - Fix build if !CONFIG_HW_CONSOLE
Date: Thu, 27 Nov 2014 10:42:19 +0100
Message-ID: <1417081340-2989-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:45226 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbaK0JmY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Nov 2014 04:42:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-m68k@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If CONFIG_HW_CONSOLE is not set:

drivers/built-in.o: In function `amikbd_probe':
amikbd.c:(.init.text+0x3e4e): undefined reference to `key_maps'
amikbd.c:(.init.text+0x3dd4): undefined reference to `key_maps'

To fix this, extract the initialization of the console keyboard maps
into amikbd_init_console_keymaps(), protected by #ifdef
CONFIG_HW_CONSOLE.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Discovered during randconfig builds.
---
 drivers/input/keyboard/amikbd.c | 46 ++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
index 096d6067ae1f890f..4f81e65d9e35cb7d 100644
--- a/drivers/input/keyboard/amikbd.c
+++ b/drivers/input/keyboard/amikbd.c
@@ -45,6 +45,7 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Amiga keyboard driver");
 MODULE_LICENSE("GPL");
 
+#ifdef CONFIG_HW_CONSOLE
 static unsigned char amikbd_keycode[0x78] __initdata = {
 	[0]	 = KEY_GRAVE,
 	[1]	 = KEY_1,
@@ -144,6 +145,31 @@ static unsigned char amikbd_keycode[0x78] __initdata = {
 	[103]	 = KEY_RIGHTMETA
 };
 
+static void __init amikbd_init_console_keymaps(void)
+{
+	int i, j;
+
+	for (i = 0; i < MAX_NR_KEYMAPS; i++) {
+		static u_short temp_map[NR_KEYS] __initdata;
+		if (!key_maps[i])
+			continue;
+		memset(temp_map, 0, sizeof(temp_map));
+		for (j = 0; j < 0x78; j++) {
+			if (!amikbd_keycode[j])
+				continue;
+			temp_map[j] = key_maps[i][amikbd_keycode[j]];
+		}
+		for (j = 0; j < NR_KEYS; j++) {
+			if (!temp_map[j])
+				temp_map[j] = 0xf200;
+		}
+		memcpy(key_maps[i], temp_map, sizeof(temp_map));
+	}
+}
+#else /* !CONFIG_HW_CONSOLE */
+static inline void amikbd_init_console_keymaps(void) {}
+#endif /* !CONFIG_HW_CONSOLE */
+
 static const char *amikbd_messages[8] = {
 	[0] = KERN_ALERT "amikbd: Ctrl-Amiga-Amiga reset warning!!\n",
 	[1] = KERN_WARNING "amikbd: keyboard lost sync\n",
@@ -186,7 +212,7 @@ static irqreturn_t amikbd_interrupt(int irq, void *data)
 static int __init amikbd_probe(struct platform_device *pdev)
 {
 	struct input_dev *dev;
-	int i, j, err;
+	int i, err;
 
 	dev = input_allocate_device();
 	if (!dev) {
@@ -207,22 +233,8 @@ static int __init amikbd_probe(struct platform_device *pdev)
 	for (i = 0; i < 0x78; i++)
 		set_bit(i, dev->keybit);
 
-	for (i = 0; i < MAX_NR_KEYMAPS; i++) {
-		static u_short temp_map[NR_KEYS] __initdata;
-		if (!key_maps[i])
-			continue;
-		memset(temp_map, 0, sizeof(temp_map));
-		for (j = 0; j < 0x78; j++) {
-			if (!amikbd_keycode[j])
-				continue;
-			temp_map[j] = key_maps[i][amikbd_keycode[j]];
-		}
-		for (j = 0; j < NR_KEYS; j++) {
-			if (!temp_map[j])
-				temp_map[j] = 0xf200;
-		}
-		memcpy(key_maps[i], temp_map, sizeof(temp_map));
-	}
+	amikbd_init_console_keymaps();
+
 	ciaa.cra &= ~0x41;	 /* serial data in, turn off TA */
 	err = request_irq(IRQ_AMIGA_CIAA_SP, amikbd_interrupt, 0, "amikbd",
 			  dev);
-- 
1.9.1

