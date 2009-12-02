From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 8/8] Input: panasonic-laptop - switch to using sparse keymap
	library
Date: Wed, 02 Dec 2009 01:24:47 -0800
Message-ID: <20091202092447.30409.25301.stgit@localhost.localdomain>
References: <20091202091056.30409.50455.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:42964 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbZLBJYn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2009 04:24:43 -0500
In-Reply-To: <20091202091056.30409.50455.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/Kconfig            |    1 
 drivers/platform/x86/panasonic-laptop.c |  172 ++++++++++++-------------------
 2 files changed, 66 insertions(+), 107 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 00e94b0..1b27e4d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -168,6 +168,7 @@ config PANASONIC_LAPTOP
 	tristate "Panasonic Laptop Extras"
 	depends on INPUT && ACPI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select INPUT_SPARSEKMAP
 	---help---
 	  This driver adds support for access to backlight control and hotkeys
 	  on Panasonic Let's Note laptops.
diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index fe7cf01..d24b824 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -127,6 +127,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 
 
 #ifndef ACPI_HOTKEY_COMPONENT
@@ -199,30 +200,29 @@ static struct acpi_driver acpi_pcc_driver = {
 			},
 };
 
-#define KEYMAP_SIZE		11
-static const int initial_keymap[KEYMAP_SIZE] = {
-	/*  0 */ KEY_RESERVED,
-	/*  1 */ KEY_BRIGHTNESSDOWN,
-	/*  2 */ KEY_BRIGHTNESSUP,
-	/*  3 */ KEY_DISPLAYTOGGLE,
-	/*  4 */ KEY_MUTE,
-	/*  5 */ KEY_VOLUMEDOWN,
-	/*  6 */ KEY_VOLUMEUP,
-	/*  7 */ KEY_SLEEP,
-	/*  8 */ KEY_PROG1, /* Change CPU boost */
-	/*  9 */ KEY_BATTERY,
-	/* 10 */ KEY_SUSPEND,
+static const struct key_entry panasonic_keymap[] = {
+	{ KE_KEY, 0, { KEY_RESERVED } },
+	{ KE_KEY, 1, { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 2, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 3, { KEY_DISPLAYTOGGLE } },
+	{ KE_KEY, 4, { KEY_MUTE } },
+	{ KE_KEY, 5, { KEY_VOLUMEDOWN } },
+	{ KE_KEY, 6, { KEY_VOLUMEUP } },
+	{ KE_KEY, 7, { KEY_SLEEP } },
+	{ KE_KEY, 8, { KEY_PROG1 } }, /* Change CPU boost */
+	{ KE_KEY, 9, { KEY_BATTERY } },
+	{ KE_KEY, 10, { KEY_SUSPEND } },
+	{ KE_END, 0 }
 };
 
 struct pcc_acpi {
 	acpi_handle		handle;
 	unsigned long		num_sifr;
 	int			sticky_mode;
-	u32 			*sinf;
+	u32			*sinf;
 	struct acpi_device	*device;
 	struct input_dev	*input_dev;
 	struct backlight_device	*backlight;
-	int			keymap[KEYMAP_SIZE];
 };
 
 struct pcc_keyinput {
@@ -445,57 +445,11 @@ static struct attribute_group pcc_attr_group = {
 
 /* hotkey input device driver */
 
-static int pcc_getkeycode(struct input_dev *dev, int scancode, int *keycode)
-{
-	struct pcc_acpi *pcc = input_get_drvdata(dev);
-
-	if (scancode >= ARRAY_SIZE(pcc->keymap))
-		return -EINVAL;
-
-	*keycode = pcc->keymap[scancode];
-
-	return 0;
-}
-
-static int keymap_get_by_keycode(struct pcc_acpi *pcc, int keycode)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(pcc->keymap); i++) {
-		if (pcc->keymap[i] == keycode)
-			return i+1;
-	}
-
-	return 0;
-}
-
-static int pcc_setkeycode(struct input_dev *dev, int scancode, int keycode)
-{
-	struct pcc_acpi *pcc = input_get_drvdata(dev);
-	int oldkeycode;
-
-	if (scancode >= ARRAY_SIZE(pcc->keymap))
-		return -EINVAL;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	oldkeycode = pcc->keymap[scancode];
-	pcc->keymap[scancode] = keycode;
-
-	set_bit(keycode, dev->keybit);
-
-	if (!keymap_get_by_keycode(pcc, oldkeycode))
-		clear_bit(oldkeycode, dev->keybit);
-
-	return 0;
-}
-
 static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 {
+	struct key_entry *key;
 	struct input_dev *hotk_input_dev = pcc->input_dev;
 	int rc;
-	int key_code, hkey_num;
 	unsigned long long result;
 
 	rc = acpi_evaluate_integer(pcc->handle, METHOD_HKEY_QUERY,
@@ -508,25 +462,18 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 
 	acpi_bus_generate_proc_event(pcc->device, HKEY_NOTIFY, result);
 
-	hkey_num = result & 0xf;
-
-	if (hkey_num < 0 || hkey_num >= ARRAY_SIZE(pcc->keymap)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "hotkey number out of range: %d\n",
-				  hkey_num));
-		return;
+	key = sparse_keymap_entry_from_scancode(hotk_input_dev, result & 0xf);
+	if (key) {
+		switch (key->type) {
+		case KE_KEY:
+			input_report_key(hotk_input_dev,
+					 key->keycode, result & 0x80);
+			input_sync(hotk_input_dev);
+			return;
+		}
 	}
 
-	key_code = pcc->keymap[hkey_num];
-
-	if (key_code != KEY_RESERVED) {
-		int pushed = (result & 0x80) ? TRUE : FALSE;
-
-		input_report_key(hotk_input_dev, key_code, pushed);
-		input_sync(hotk_input_dev);
-	}
-
-	return;
+	ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown hotkey event: %d\n", result));
 }
 
 static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
@@ -545,40 +492,55 @@ static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
 
 static int acpi_pcc_init_input(struct pcc_acpi *pcc)
 {
-	int i, rc;
+	struct input_dev *input_dev;
+	int error;
 
-	pcc->input_dev = input_allocate_device();
-	if (!pcc->input_dev) {
+	input_dev = input_allocate_device();
+	if (!input_dev) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Couldn't allocate input device for hotkey"));
 		return -ENOMEM;
 	}
 
-	pcc->input_dev->evbit[0] = BIT(EV_KEY);
+	input_dev->name = ACPI_PCC_DRIVER_NAME;
+	input_dev->phys = ACPI_PCC_INPUT_PHYS;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
 
-	pcc->input_dev->name = ACPI_PCC_DRIVER_NAME;
-	pcc->input_dev->phys = ACPI_PCC_INPUT_PHYS;
-	pcc->input_dev->id.bustype = BUS_HOST;
-	pcc->input_dev->id.vendor = 0x0001;
-	pcc->input_dev->id.product = 0x0001;
-	pcc->input_dev->id.version = 0x0100;
-	pcc->input_dev->getkeycode = pcc_getkeycode;
-	pcc->input_dev->setkeycode = pcc_setkeycode;
+	error = sparse_keymap_setup(input_dev, panasonic_keymap, NULL);
+	if (error) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Unable to setup input device keymap\n"));
+		goto err_free_dev;
+	}
 
-	/* load initial keymap */
-	memcpy(pcc->keymap, initial_keymap, sizeof(pcc->keymap));
+	input_set_drvdata(input_dev, pcc);
 
-	for (i = 0; i < ARRAY_SIZE(pcc->keymap); i++)
-		__set_bit(pcc->keymap[i], pcc->input_dev->keybit);
-	__clear_bit(KEY_RESERVED, pcc->input_dev->keybit);
+	error = input_register_device(input_dev);
+	if (error) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Unable to register input device\n"));
+		goto err_free_keymap;
+	}
 
-	input_set_drvdata(pcc->input_dev, pcc);
+	pcc->input_dev = input_dev;
+	return 0;
 
-	rc = input_register_device(pcc->input_dev);
-	if (rc < 0)
-		input_free_device(pcc->input_dev);
+ err_free_keymap:
+	sparse_keymap_free(input_dev);
+ err_free_dev:
+	input_free_device(input_dev);
+	return error;
+}
 
-	return rc;
+static void acpi_pcc_destroy_input(struct pcc_acpi *pcc)
+{
+	sparse_keymap_free(pcc->input_dev);
+	input_unregister_device(pcc->input_dev);
+	/* no need to input_free_device() since core input API refcount and
+	 * free()s the device */
 }
 
 /* kernel module interface */
@@ -671,9 +633,7 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 out_backlight:
 	backlight_device_unregister(pcc->backlight);
 out_input:
-	input_unregister_device(pcc->input_dev);
-	/* no need to input_free_device() since core input API refcount and
-	 * free()s the device */
+	acpi_pcc_destroy_input(pcc);
 out_sinf:
 	kfree(pcc->sinf);
 out_hotkey:
@@ -710,9 +670,7 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
 
 	backlight_device_unregister(pcc->backlight);
 
-	input_unregister_device(pcc->input_dev);
-	/* no need to input_free_device() since core input API refcount and
-	 * free()s the device */
+	acpi_pcc_destroy_input(pcc);
 
 	kfree(pcc->sinf);
 	kfree(pcc);

