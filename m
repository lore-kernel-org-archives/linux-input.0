From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/8] Input: eeepc-laptop - switch to using sparse keymap
	library
Date: Wed, 02 Dec 2009 01:24:31 -0800
Message-ID: <20091202092430.30409.85129.stgit@localhost.localdomain>
References: <20091202091056.30409.50455.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:42964 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbZLBJY1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2009 04:24:27 -0500
In-Reply-To: <20091202091056.30409.50455.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/Kconfig        |    1 
 drivers/platform/x86/eeepc-laptop.c |  153 +++++++++++------------------------
 2 files changed, 49 insertions(+), 105 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 18b66fd..ae9c976 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -336,6 +336,7 @@ config EEEPC_LAPTOP
 	depends on HOTPLUG_PCI
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
+	select INPUT_SPARSEKMAP
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
 
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 4226e53..009c70b 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -31,6 +31,7 @@
 #include <acpi/acpi_bus.h>
 #include <linux/uaccess.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 #include <linux/rfkill.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
@@ -169,31 +170,23 @@ static struct platform_driver platform_driver = {
 
 static struct platform_device *platform_device;
 
-struct key_entry {
-	char type;
-	u8 code;
-	u16 keycode;
-};
-
-enum { KE_KEY, KE_END };
-
-static struct key_entry eeepc_keymap[] = {
+static const struct key_entry eeepc_keymap[] = {
 	/* Sleep already handled via generic ACPI code */
-	{KE_KEY, 0x10, KEY_WLAN },
-	{KE_KEY, 0x11, KEY_WLAN },
-	{KE_KEY, 0x12, KEY_PROG1 },
-	{KE_KEY, 0x13, KEY_MUTE },
-	{KE_KEY, 0x14, KEY_VOLUMEDOWN },
-	{KE_KEY, 0x15, KEY_VOLUMEUP },
-	{KE_KEY, 0x1a, KEY_COFFEE },
-	{KE_KEY, 0x1b, KEY_ZOOM },
-	{KE_KEY, 0x1c, KEY_PROG2 },
-	{KE_KEY, 0x1d, KEY_PROG3 },
-	{KE_KEY, NOTIFY_BRN_MIN,     KEY_BRIGHTNESSDOWN },
-	{KE_KEY, NOTIFY_BRN_MIN + 2, KEY_BRIGHTNESSUP },
-	{KE_KEY, 0x30, KEY_SWITCHVIDEOMODE },
-	{KE_KEY, 0x31, KEY_SWITCHVIDEOMODE },
-	{KE_KEY, 0x32, KEY_SWITCHVIDEOMODE },
+	{KE_KEY, 0x10, { KEY_WLAN } },
+	{KE_KEY, 0x11, { KEY_WLAN } },
+	{KE_KEY, 0x12, { KEY_PROG1 } },
+	{KE_KEY, 0x13, { KEY_MUTE } },
+	{KE_KEY, 0x14, { KEY_VOLUMEDOWN } },
+	{KE_KEY, 0x15, { KEY_VOLUMEUP } },
+	{KE_KEY, 0x1a, { KEY_COFFEE } },
+	{KE_KEY, 0x1b, { KEY_ZOOM } },
+	{KE_KEY, 0x1c, { KEY_PROG2 } },
+	{KE_KEY, 0x1d, { KEY_PROG3 } },
+	{KE_KEY, NOTIFY_BRN_MIN,     { KEY_BRIGHTNESSDOWN } },
+	{KE_KEY, NOTIFY_BRN_MIN + 2, { KEY_BRIGHTNESSUP } },
+	{KE_KEY, 0x30, { KEY_SWITCHVIDEOMODE } },
+	{KE_KEY, 0x31, { KEY_SWITCHVIDEOMODE } },
+	{KE_KEY, 0x32, { KEY_SWITCHVIDEOMODE } },
 	{KE_END, 0},
 };
 
@@ -509,61 +502,6 @@ static struct attribute_group platform_attribute_group = {
 /*
  * Hotkey functions
  */
-static struct key_entry *eepc_get_entry_by_scancode(int code)
-{
-	struct key_entry *key;
-
-	for (key = eeepc_keymap; key->type != KE_END; key++)
-		if (code == key->code)
-			return key;
-
-	return NULL;
-}
-
-static struct key_entry *eepc_get_entry_by_keycode(int code)
-{
-	struct key_entry *key;
-
-	for (key = eeepc_keymap; key->type != KE_END; key++)
-		if (code == key->keycode && key->type == KE_KEY)
-			return key;
-
-	return NULL;
-}
-
-static int eeepc_getkeycode(struct input_dev *dev, int scancode, int *keycode)
-{
-	struct key_entry *key = eepc_get_entry_by_scancode(scancode);
-
-	if (key && key->type == KE_KEY) {
-		*keycode = key->keycode;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int eeepc_setkeycode(struct input_dev *dev, int scancode, int keycode)
-{
-	struct key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key = eepc_get_entry_by_scancode(scancode);
-	if (key && key->type == KE_KEY) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!eepc_get_entry_by_keycode(old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static void cmsg_quirk(int cm, const char *name)
 {
 	int dummy;
@@ -698,7 +636,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 
 static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
 {
-	static struct key_entry *key;
+	struct key_entry *key;
 	u16 count;
 	int brn = -ENODEV;
 
@@ -729,7 +667,7 @@ static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
 			else
 				event = NOTIFY_BRN_MIN + 1; /* ... unchanged */
 		}
-		key = eepc_get_entry_by_scancode(event);
+		key = sparse_keymap_entry_from_scancode(ehotk->inputdev, event);
 		if (key) {
 			switch (key->type) {
 			case KE_KEY:
@@ -1017,8 +955,10 @@ static void eeepc_rfkill_exit(void)
 
 static void eeepc_input_exit(void)
 {
-	if (ehotk->inputdev)
+	if (ehotk->inputdev) {
+		sparse_keymap_free(ehotk->inputdev);
 		input_unregister_device(ehotk->inputdev);
+	}
 }
 
 static void eeepc_hwmon_exit(void)
@@ -1158,36 +1098,39 @@ static int eeepc_hwmon_init(struct device *dev)
 
 static int eeepc_input_init(struct device *dev)
 {
-	const struct key_entry *key;
-	int result;
+	struct input_dev *input;
+	int error;
 
-	ehotk->inputdev = input_allocate_device();
-	if (!ehotk->inputdev) {
+	input = input_allocate_device();
+	if (!input) {
 		pr_info("Unable to allocate input device\n");
 		return -ENOMEM;
 	}
-	ehotk->inputdev->name = "Asus EeePC extra buttons";
-	ehotk->inputdev->dev.parent = dev;
-	ehotk->inputdev->phys = EEEPC_HOTK_FILE "/input0";
-	ehotk->inputdev->id.bustype = BUS_HOST;
-	ehotk->inputdev->getkeycode = eeepc_getkeycode;
-	ehotk->inputdev->setkeycode = eeepc_setkeycode;
-
-	for (key = eeepc_keymap; key->type != KE_END; key++) {
-		switch (key->type) {
-		case KE_KEY:
-			set_bit(EV_KEY, ehotk->inputdev->evbit);
-			set_bit(key->keycode, ehotk->inputdev->keybit);
-			break;
-		}
+	input->name = "Asus EeePC extra buttons";
+	input->dev.parent = dev;
+	input->phys = EEEPC_HOTK_FILE "/input0";
+	input->id.bustype = BUS_HOST;
+
+	error = sparse_keymap_setup(input, eeepc_keymap, NULL);
+	if (error) {
+		pr_err("Unable to setup input device keymap\n");
+		goto err_free_dev;
 	}
-	result = input_register_device(ehotk->inputdev);
-	if (result) {
-		pr_info("Unable to register input device\n");
-		input_free_device(ehotk->inputdev);
-		return result;
+
+	error = input_register_device(input);
+	if (error) {
+		pr_err("Unable to register input device\n");
+		goto err_free_keymap;
 	}
+
+	ehotk->inputdev = input;
 	return 0;
+
+ err_free_keymap:
+	sparse_keymap_free(input);
+ err_free_dev:
+	input_free_device(input);
+	return error;
 }
 
 static int __devinit eeepc_hotk_add(struct acpi_device *device)

