From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/8] Input: asus-laptop - switch to using sparse keymap library
Date: Wed, 02 Dec 2009 01:24:36 -0800
Message-ID: <20091202092436.30409.64047.stgit@localhost.localdomain>
References: <20091202091056.30409.50455.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:42964 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbZLBJYc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2009 04:24:32 -0500
In-Reply-To: <20091202091056.30409.50455.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/Kconfig       |    1 
 drivers/platform/x86/asus-laptop.c |  181 +++++++++++++-----------------------
 2 files changed, 64 insertions(+), 118 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ae9c976..e555d39 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -59,6 +59,7 @@ config ASUS_LAPTOP
 	select NEW_LEDS
 	select BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
+	select INPUT_SPARSEKMAP
 	---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
 	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index b39d2bb..c04332e 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -49,6 +49,7 @@
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 
 #define ASUS_LAPTOP_VERSION "0.42"
 
@@ -284,41 +285,33 @@ ASUS_LED(pled, "phone", 1);
 ASUS_LED(gled, "gaming", 1);
 ASUS_LED(kled, "kbd_backlight", 3);
 
-struct key_entry {
-	char type;
-	u8 code;
-	u16 keycode;
-};
-
-enum { KE_KEY, KE_END };
-
-static struct key_entry asus_keymap[] = {
-	{KE_KEY, 0x30, KEY_VOLUMEUP},
-	{KE_KEY, 0x31, KEY_VOLUMEDOWN},
-	{KE_KEY, 0x32, KEY_MUTE},
-	{KE_KEY, 0x33, KEY_SWITCHVIDEOMODE},
-	{KE_KEY, 0x34, KEY_SWITCHVIDEOMODE},
-	{KE_KEY, 0x40, KEY_PREVIOUSSONG},
-	{KE_KEY, 0x41, KEY_NEXTSONG},
-	{KE_KEY, 0x43, KEY_STOPCD},
-	{KE_KEY, 0x45, KEY_PLAYPAUSE},
-	{KE_KEY, 0x4c, KEY_MEDIA},
-	{KE_KEY, 0x50, KEY_EMAIL},
-	{KE_KEY, 0x51, KEY_WWW},
-	{KE_KEY, 0x55, KEY_CALC},
-	{KE_KEY, 0x5C, KEY_SCREENLOCK},  /* Screenlock */
-	{KE_KEY, 0x5D, KEY_WLAN},
-	{KE_KEY, 0x5E, KEY_WLAN},
-	{KE_KEY, 0x5F, KEY_WLAN},
-	{KE_KEY, 0x60, KEY_SWITCHVIDEOMODE},
-	{KE_KEY, 0x61, KEY_SWITCHVIDEOMODE},
-	{KE_KEY, 0x6B, BTN_TOUCH}, /* Lock Mouse */
-	{KE_KEY, 0x82, KEY_CAMERA},
-	{KE_KEY, 0x8A, KEY_PROG1},
-	{KE_KEY, 0x95, KEY_MEDIA},
-	{KE_KEY, 0x99, KEY_PHONE},
-	{KE_KEY, 0xc4, KEY_KBDILLUMUP},
-	{KE_KEY, 0xc5, KEY_KBDILLUMDOWN},
+static const struct key_entry asus_keymap[] = {
+	{KE_KEY, 0x30, {KEY_VOLUMEUP}},
+	{KE_KEY, 0x31, {KEY_VOLUMEDOWN}},
+	{KE_KEY, 0x32, {KEY_MUTE}},
+	{KE_KEY, 0x33, {KEY_SWITCHVIDEOMODE}},
+	{KE_KEY, 0x34, {KEY_SWITCHVIDEOMODE}},
+	{KE_KEY, 0x40, {KEY_PREVIOUSSONG}},
+	{KE_KEY, 0x41, {KEY_NEXTSONG}},
+	{KE_KEY, 0x43, {KEY_STOPCD}},
+	{KE_KEY, 0x45, {KEY_PLAYPAUSE}},
+	{KE_KEY, 0x4c, {KEY_MEDIA}},
+	{KE_KEY, 0x50, {KEY_EMAIL}},
+	{KE_KEY, 0x51, {KEY_WWW}},
+	{KE_KEY, 0x55, {KEY_CALC}},
+	{KE_KEY, 0x5C, {KEY_SCREENLOCK}},  /* Screenlock */
+	{KE_KEY, 0x5D, {KEY_WLAN}},
+	{KE_KEY, 0x5E, {KEY_WLAN}},
+	{KE_KEY, 0x5F, {KEY_WLAN}},
+	{KE_KEY, 0x60, {KEY_SWITCHVIDEOMODE}},
+	{KE_KEY, 0x61, {KEY_SWITCHVIDEOMODE}},
+	{KE_KEY, 0x6B, {BTN_TOUCH}}, /* Lock Mouse */
+	{KE_KEY, 0x82, {KEY_CAMERA}},
+	{KE_KEY, 0x8A, {KEY_PROG1}},
+	{KE_KEY, 0x95, {KEY_MEDIA}},
+	{KE_KEY, 0x99, {KEY_PHONE}},
+	{KE_KEY, 0xc4, {KEY_KBDILLUMUP}},
+	{KE_KEY, 0xc5, {KEY_KBDILLUMDOWN}},
 	{KE_END, 0},
 };
 
@@ -866,61 +859,6 @@ static ssize_t store_gps(struct device *dev, struct device_attribute *attr,
 /*
  * Hotkey functions
  */
-static struct key_entry *asus_get_entry_by_scancode(int code)
-{
-	struct key_entry *key;
-
-	for (key = asus_keymap; key->type != KE_END; key++)
-		if (code == key->code)
-			return key;
-
-	return NULL;
-}
-
-static struct key_entry *asus_get_entry_by_keycode(int code)
-{
-	struct key_entry *key;
-
-	for (key = asus_keymap; key->type != KE_END; key++)
-		if (code == key->keycode && key->type == KE_KEY)
-			return key;
-
-	return NULL;
-}
-
-static int asus_getkeycode(struct input_dev *dev, int scancode, int *keycode)
-{
-	struct key_entry *key = asus_get_entry_by_scancode(scancode);
-
-	if (key && key->type == KE_KEY) {
-		*keycode = key->keycode;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int asus_setkeycode(struct input_dev *dev, int scancode, int keycode)
-{
-	struct key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key = asus_get_entry_by_scancode(scancode);
-	if (key && key->type == KE_KEY) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!asus_get_entry_by_keycode(old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static void asus_hotk_notify(struct acpi_device *device, u32 event)
 {
 	static struct key_entry *key;
@@ -949,9 +887,9 @@ static void asus_hotk_notify(struct acpi_device *device, u32 event)
 					count);
 
 	if (hotk->inputdev) {
-		key = asus_get_entry_by_scancode(event);
+		key = sparse_keymap_entry_from_scancode(hotk->inputdev, event);
 		if (!key)
-			return ;
+			return;
 
 		switch (key->type) {
 		case KE_KEY:
@@ -1009,7 +947,7 @@ static struct platform_driver asuspf_driver = {
 	.driver = {
 		   .name = ASUS_HOTK_FILE,
 		   .owner = THIS_MODULE,
-		   }
+	},
 };
 
 static struct platform_device *asuspf_device;
@@ -1184,36 +1122,41 @@ static int asus_hotk_get_info(void)
 	return AE_OK;
 }
 
-static int asus_input_init(void)
+static int __init asus_input_init(void)
 {
-	const struct key_entry *key;
-	int result;
+	struct input_dev *inputdev;
+	int error;
 
-	hotk->inputdev = input_allocate_device();
-	if (!hotk->inputdev) {
-		pr_info("Unable to allocate input device\n");
-		return 0;
+	inputdev = input_allocate_device();
+	if (!inputdev) {
+		pr_err("Unable to allocate input device\n");
+		return -ENOMEM;
 	}
-	hotk->inputdev->name = "Asus Laptop extra buttons";
-	hotk->inputdev->phys = ASUS_HOTK_FILE "/input0";
-	hotk->inputdev->id.bustype = BUS_HOST;
-	hotk->inputdev->getkeycode = asus_getkeycode;
-	hotk->inputdev->setkeycode = asus_setkeycode;
 
-	for (key = asus_keymap; key->type != KE_END; key++) {
-		switch (key->type) {
-		case KE_KEY:
-			set_bit(EV_KEY, hotk->inputdev->evbit);
-			set_bit(key->keycode, hotk->inputdev->keybit);
-			break;
-		}
+	inputdev->name = "Asus Laptop extra buttons";
+	inputdev->phys = ASUS_HOTK_FILE "/input0";
+	inputdev->id.bustype = BUS_HOST;
+
+	error = sparse_keymap_setup(inputdev, asus_keymap, NULL);
+	if (error) {
+		pr_err("Unable to setup input device keymap\n");
+		goto err_free_dev;
 	}
-	result = input_register_device(hotk->inputdev);
-	if (result) {
-		pr_info("Unable to register input device\n");
-		input_free_device(hotk->inputdev);
+
+	error = input_register_device(inputdev);
+	if (error) {
+		pr_err("Unable to register input device\n");
+		goto err_free_keymap;
 	}
-	return result;
+
+	hotk->inputdev = inputdev;
+	return 0;
+
+ err_free_keymap:
+	sparse_keymap_free(inputdev);
+ err_free_dev:
+	input_free_device(inputdev);
+	return error;
 }
 
 static int asus_hotk_check(void)
@@ -1338,8 +1281,10 @@ static void asus_led_exit(void)
 
 static void asus_input_exit(void)
 {
-	if (hotk->inputdev)
+	if (hotk->inputdev) {
+		sparse_keymap_free(hotk->inputdev);
 		input_unregister_device(hotk->inputdev);
+	}
 }
 
 static void __exit asus_laptop_exit(void)

