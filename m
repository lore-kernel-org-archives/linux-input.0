From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/8] Input: dell-wmi - switch to using sparse keymap library
Date: Wed, 02 Dec 2009 01:24:19 -0800
Message-ID: <20091202092419.30409.17350.stgit@localhost.localdomain>
References: <20091202091056.30409.50455.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34662 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbZLBJYQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2009 04:24:16 -0500
In-Reply-To: <20091202091056.30409.50455.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/Kconfig    |    1 
 drivers/platform/x86/dell-wmi.c |  186 +++++++++++++--------------------------
 2 files changed, 61 insertions(+), 126 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 55ca39d..1f10bf4 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -88,6 +88,7 @@ config DELL_WMI
 	tristate "Dell WMI extras"
 	depends on ACPI_WMI
 	depends on INPUT
+	select INPUT_SPARSEKMAP
 	---help---
 	  Say Y here if you want to support WMI-based hotkeys on Dell laptops.
 
diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 0f900cc..5f4a0e6 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 #include <acpi/acpi_drivers.h>
 #include <linux/acpi.h>
 #include <linux/string.h>
@@ -40,13 +41,7 @@ MODULE_LICENSE("GPL");
 
 MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
 
-struct key_entry {
-	char type;		/* See KE_* below */
-	u16 code;
-	u16 keycode;
-};
-
-enum { KE_KEY, KE_SW, KE_IGNORE, KE_END };
+#define KE_IGNORE	(KE_LAST + 1)
 
 /*
  * Certain keys are flagged as KE_IGNORE. All of these are either
@@ -54,105 +49,50 @@ enum { KE_KEY, KE_SW, KE_IGNORE, KE_END };
  * via the keyboard controller so should not be sent again.
  */
 
-static struct key_entry dell_wmi_keymap[] = {
-	{KE_KEY, 0xe045, KEY_PROG1},
-	{KE_KEY, 0xe009, KEY_EJECTCD},
+static const struct key_entry dell_wmi_keymap[] = {
+	{KE_KEY, 0xe045, {KEY_PROG1}},
+	{KE_KEY, 0xe009, {KEY_EJECTCD}},
 
 	/* These also contain the brightness level at offset 6 */
-	{KE_KEY, 0xe006, KEY_BRIGHTNESSUP},
-	{KE_KEY, 0xe005, KEY_BRIGHTNESSDOWN},
+	{KE_KEY, 0xe006, {KEY_BRIGHTNESSUP}},
+	{KE_KEY, 0xe005, {KEY_BRIGHTNESSDOWN}},
 
 	/* Battery health status button */
-	{KE_KEY, 0xe007, KEY_BATTERY},
+	{KE_KEY, 0xe007, {KEY_BATTERY}},
 
 	/* This is actually for all radios. Although physically a
 	 * switch, the notification does not provide an indication of
 	 * state and so it should be reported as a key */
-	{KE_KEY, 0xe008, KEY_WLAN},
+	{KE_KEY, 0xe008, {KEY_WLAN}},
 
 	/* The next device is at offset 6, the active devices are at
 	   offset 8 and the attached devices at offset 10 */
-	{KE_KEY, 0xe00b, KEY_DISPLAYTOGGLE},
+	{KE_KEY, 0xe00b, {KEY_DISPLAYTOGGLE}},
 
-	{KE_IGNORE, 0xe00c, KEY_KBDILLUMTOGGLE},
+	{KE_IGNORE, 0xe00c, {KEY_KBDILLUMTOGGLE}},
 
 	/* BIOS error detected */
-	{KE_IGNORE, 0xe00d, KEY_RESERVED},
+	{KE_IGNORE, 0xe00d, {KEY_RESERVED}},
 
 	/* Wifi Catcher */
-	{KE_KEY, 0xe011, KEY_PROG2},
+	{KE_KEY, 0xe011, {KEY_PROG2}},
 
 	/* Ambient light sensor toggle */
-	{KE_IGNORE, 0xe013, KEY_RESERVED},
-
-	{KE_IGNORE, 0xe020, KEY_MUTE},
-	{KE_IGNORE, 0xe02e, KEY_VOLUMEDOWN},
-	{KE_IGNORE, 0xe030, KEY_VOLUMEUP},
-	{KE_IGNORE, 0xe033, KEY_KBDILLUMUP},
-	{KE_IGNORE, 0xe034, KEY_KBDILLUMDOWN},
-	{KE_IGNORE, 0xe03a, KEY_CAPSLOCK},
-	{KE_IGNORE, 0xe045, KEY_NUMLOCK},
-	{KE_IGNORE, 0xe046, KEY_SCROLLLOCK},
+	{KE_IGNORE, 0xe013, {KEY_RESERVED}},
+
+	{KE_IGNORE, 0xe020, {KEY_MUTE}},
+	{KE_IGNORE, 0xe02e, {KEY_VOLUMEDOWN}},
+	{KE_IGNORE, 0xe030, {KEY_VOLUMEUP}},
+	{KE_IGNORE, 0xe033, {KEY_KBDILLUMUP}},
+	{KE_IGNORE, 0xe034, {KEY_KBDILLUMDOWN}},
+	{KE_IGNORE, 0xe03a, {KEY_CAPSLOCK}},
+	{KE_IGNORE, 0xe045, {KEY_NUMLOCK}},
+	{KE_IGNORE, 0xe046, {KEY_SCROLLLOCK}},
 	{KE_END, 0}
 };
 
 static struct input_dev *dell_wmi_input_dev;
 
-static struct key_entry *dell_wmi_get_entry_by_scancode(int code)
-{
-	struct key_entry *key;
-
-	for (key = dell_wmi_keymap; key->type != KE_END; key++)
-		if (code == key->code)
-			return key;
-
-	return NULL;
-}
-
-static struct key_entry *dell_wmi_get_entry_by_keycode(int keycode)
-{
-	struct key_entry *key;
-
-	for (key = dell_wmi_keymap; key->type != KE_END; key++)
-		if (key->type == KE_KEY && keycode == key->keycode)
-			return key;
-
-	return NULL;
-}
-
-static int dell_wmi_getkeycode(struct input_dev *dev, int scancode,
-			       int *keycode)
-{
-	struct key_entry *key = dell_wmi_get_entry_by_scancode(scancode);
-
-	if (key && key->type == KE_KEY) {
-		*keycode = key->keycode;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int dell_wmi_setkeycode(struct input_dev *dev, int scancode, int keycode)
-{
-	struct key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key = dell_wmi_get_entry_by_scancode(scancode);
-	if (key && key->type == KE_KEY) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!dell_wmi_get_entry_by_keycode(old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
-	}
-	return -EINVAL;
-}
-
 static void dell_wmi_notify(u32 value, void *context)
 {
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -170,7 +110,8 @@ static void dell_wmi_notify(u32 value, void *context)
 		 *  additional information, so mask them off for the
 		 *  scancode lookup
 		 */
-		key = dell_wmi_get_entry_by_scancode(buffer[1] & 0xFFFF);
+		key = sparse_keymap_entry_from_scancode(dell_wmi_input_dev,
+							buffer[1] & 0xFFFF);
 		if (key) {
 			input_report_key(dell_wmi_input_dev, key->keycode, 1);
 			input_sync(dell_wmi_input_dev);
@@ -184,41 +125,37 @@ static void dell_wmi_notify(u32 value, void *context)
 
 static int __init dell_wmi_input_setup(void)
 {
-	struct key_entry *key;
 	int err;
 
 	dell_wmi_input_dev = input_allocate_device();
-
 	if (!dell_wmi_input_dev)
 		return -ENOMEM;
 
 	dell_wmi_input_dev->name = "Dell WMI hotkeys";
 	dell_wmi_input_dev->phys = "wmi/input0";
 	dell_wmi_input_dev->id.bustype = BUS_HOST;
-	dell_wmi_input_dev->getkeycode = dell_wmi_getkeycode;
-	dell_wmi_input_dev->setkeycode = dell_wmi_setkeycode;
-
-	for (key = dell_wmi_keymap; key->type != KE_END; key++) {
-		switch (key->type) {
-		case KE_KEY:
-			set_bit(EV_KEY, dell_wmi_input_dev->evbit);
-			set_bit(key->keycode, dell_wmi_input_dev->keybit);
-			break;
-		case KE_SW:
-			set_bit(EV_SW, dell_wmi_input_dev->evbit);
-			set_bit(key->keycode, dell_wmi_input_dev->swbit);
-			break;
-		}
-	}
 
-	err = input_register_device(dell_wmi_input_dev);
+	err = sparse_keymap_setup(dell_wmi_input_dev, dell_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
 
-	if (err) {
-		input_free_device(dell_wmi_input_dev);
-		return err;
-	}
+	err = input_register_device(dell_wmi_input_dev);
+	if (err)
+		goto err_free_keymap;
 
 	return 0;
+
+ err_free_keymap:
+	sparse_keymap_free(dell_wmi_input_dev);
+ err_free_dev:
+	input_free_device(dell_wmi_input_dev);
+	return err;
+}
+
+static void dell_wmi_input_destroy(void)
+{
+	sparse_keymap_free(dell_wmi_input_dev);
+	input_unregister_device(dell_wmi_input_dev);
 }
 
 static int __init dell_wmi_init(void)
@@ -226,33 +163,30 @@ static int __init dell_wmi_init(void)
 	int err;
 
 	if (wmi_has_guid(DELL_EVENT_GUID)) {
-		err = dell_wmi_input_setup();
-
-		if (err)
-			return err;
+		printk(KERN_WARNING "dell-wmi: No known WMI GUID found\n");
+		return -ENODEV;
+	}
 
-		err = wmi_install_notify_handler(DELL_EVENT_GUID,
-						 dell_wmi_notify, NULL);
-		if (err) {
-			input_unregister_device(dell_wmi_input_dev);
-			printk(KERN_ERR "dell-wmi: Unable to register"
-			       " notify handler - %d\n", err);
-			return err;
-		}
+	err = dell_wmi_input_setup();
+	if (err)
+		return err;
 
-	} else
-		printk(KERN_WARNING "dell-wmi: No known WMI GUID found\n");
+	err = wmi_install_notify_handler(DELL_EVENT_GUID,
+					 dell_wmi_notify, NULL);
+	if (err) {
+		dell_wmi_input_destroy();
+		printk(KERN_ERR "dell-wmi: Unable to register"
+		       " notify handler - %d\n", err);
+		return err;
+	}
 
 	return 0;
 }
+module_init(dell_wmi_init);
 
 static void __exit dell_wmi_exit(void)
 {
-	if (wmi_has_guid(DELL_EVENT_GUID)) {
-		wmi_remove_notify_handler(DELL_EVENT_GUID);
-		input_unregister_device(dell_wmi_input_dev);
-	}
+	wmi_remove_notify_handler(DELL_EVENT_GUID);
+	dell_wmi_input_destroy();
 }
-
-module_init(dell_wmi_init);
 module_exit(dell_wmi_exit);

