From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 7/8] Input: topstar-laptop - switch to using sparse keymap
	library
Date: Wed, 02 Dec 2009 01:24:41 -0800
Message-ID: <20091202092441.30409.17280.stgit@localhost.localdomain>
References: <20091202091056.30409.50455.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34662 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbZLBJYh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2009 04:24:37 -0500
In-Reply-To: <20091202091056.30409.50455.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/Kconfig          |    1 
 drivers/platform/x86/topstar-laptop.c |  146 ++++++++++++---------------------
 2 files changed, 52 insertions(+), 95 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e555d39..00e94b0 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -405,6 +405,7 @@ config TOPSTAR_LAPTOP
 	tristate "Topstar Laptop Extras"
 	depends on ACPI
 	depends on INPUT
+	select INPUT_SPARSEKMAP
 	---help---
 	  This driver adds support for hotkeys found on Topstar laptops.
 
diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 02f3d4e..7ca08db 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 
 #define ACPI_TOPSTAR_CLASS "topstar"
 
@@ -25,52 +26,25 @@ struct topstar_hkey {
 	struct input_dev *inputdev;
 };
 
-struct tps_key_entry {
-	u8 code;
-	u16 keycode;
+static const struct key_entry topstar_keymap[] = {
+	{ KE_KEY, 0x80, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x81, { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x83, { KEY_VOLUMEUP } },
+	{ KE_KEY, 0x84, { KEY_VOLUMEDOWN } },
+	{ KE_KEY, 0x85, { KEY_MUTE } },
+	{ KE_KEY, 0x86, { KEY_SWITCHVIDEOMODE } },
+	{ KE_KEY, 0x87, { KEY_F13 } }, /* touchpad enable/disable key */
+	{ KE_KEY, 0x88, { KEY_WLAN } },
+	{ KE_KEY, 0x8a, { KEY_WWW } },
+	{ KE_KEY, 0x8b, { KEY_MAIL } },
+	{ KE_KEY, 0x8c, { KEY_MEDIA } },
+	{ KE_KEY, 0x96, { KEY_F14 } }, /* G key? */
+	{ KE_END, 0 }
 };
 
-static struct tps_key_entry topstar_keymap[] = {
-	{ 0x80, KEY_BRIGHTNESSUP },
-	{ 0x81, KEY_BRIGHTNESSDOWN },
-	{ 0x83, KEY_VOLUMEUP },
-	{ 0x84, KEY_VOLUMEDOWN },
-	{ 0x85, KEY_MUTE },
-	{ 0x86, KEY_SWITCHVIDEOMODE },
-	{ 0x87, KEY_F13 }, /* touchpad enable/disable key */
-	{ 0x88, KEY_WLAN },
-	{ 0x8a, KEY_WWW },
-	{ 0x8b, KEY_MAIL },
-	{ 0x8c, KEY_MEDIA },
-	{ 0x96, KEY_F14 }, /* G key? */
-	{ }
-};
-
-static struct tps_key_entry *tps_get_key_by_scancode(int code)
-{
-	struct tps_key_entry *key;
-
-	for (key = topstar_keymap; key->code; key++)
-		if (code == key->code)
-			return key;
-
-	return NULL;
-}
-
-static struct tps_key_entry *tps_get_key_by_keycode(int code)
-{
-	struct tps_key_entry *key;
-
-	for (key = topstar_keymap; key->code; key++)
-		if (code == key->keycode)
-			return key;
-
-	return NULL;
-}
-
 static void acpi_topstar_notify(struct acpi_device *device, u32 event)
 {
-	struct tps_key_entry *key;
+	struct key_entry *key;
 	static bool dup_evnt[2];
 	bool *dup;
 	struct topstar_hkey *hkey = acpi_driver_data(device);
@@ -92,13 +66,16 @@ static void acpi_topstar_notify(struct acpi_device *device, u32 event)
 	if (event == 0x97)
 		event = 0x96;
 
-	key = tps_get_key_by_scancode(event);
+	key = sparse_keymap_entry_from_scancode(hkey->inputdev, event);
 	if (key) {
-		input_report_key(hkey->inputdev, key->keycode, 1);
-		input_sync(hkey->inputdev);
-		input_report_key(hkey->inputdev, key->keycode, 0);
-		input_sync(hkey->inputdev);
-		return;
+		switch (key->type) {
+		case KE_KEY:
+			input_report_key(hkey->inputdev, key->keycode, 1);
+			input_sync(hkey->inputdev);
+			input_report_key(hkey->inputdev, key->keycode, 0);
+			input_sync(hkey->inputdev);
+			return;
+		}
 	}
 
 	/* Known non hotkey events don't handled or that we don't care yet */
@@ -126,63 +103,41 @@ static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
 	return 0;
 }
 
-static int topstar_getkeycode(struct input_dev *dev, int scancode, int *keycode)
-{
-	struct tps_key_entry *key = tps_get_key_by_scancode(scancode);
-
-	if (!key)
-		return -EINVAL;
-
-	*keycode = key->keycode;
-	return 0;
-}
-
-static int topstar_setkeycode(struct input_dev *dev, int scancode, int keycode)
-{
-	struct tps_key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key = tps_get_key_by_scancode(scancode);
-
-	if (!key)
-		return -EINVAL;
-
-	old_keycode = key->keycode;
-	key->keycode = keycode;
-	set_bit(keycode, dev->keybit);
-	if (!tps_get_key_by_keycode(old_keycode))
-		clear_bit(old_keycode, dev->keybit);
-	return 0;
-}
-
 static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
 {
-	struct tps_key_entry *key;
+	struct input_dev *input;
+	int error;
 
-	hkey->inputdev = input_allocate_device();
-	if (!hkey->inputdev) {
+	input = input_allocate_device();
+	if (!input) {
 		pr_err("Unable to allocate input device\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
-	hkey->inputdev->name = "Topstar Laptop extra buttons";
-	hkey->inputdev->phys = "topstar/input0";
-	hkey->inputdev->id.bustype = BUS_HOST;
-	hkey->inputdev->getkeycode = topstar_getkeycode;
-	hkey->inputdev->setkeycode = topstar_setkeycode;
-	for (key = topstar_keymap; key->code; key++) {
-		set_bit(EV_KEY, hkey->inputdev->evbit);
-		set_bit(key->keycode, hkey->inputdev->keybit);
+
+	input->name = "Topstar Laptop extra buttons";
+	input->phys = "topstar/input0";
+	input->id.bustype = BUS_HOST;
+
+	error = sparse_keymap_setup(input, topstar_keymap, NULL);
+	if (error) {
+		pr_err("Unable to setup input device keymap\n");
+		goto err_free_dev;
 	}
-	if (input_register_device(hkey->inputdev)) {
+
+	error = input_register_device(input);
+	if (error) {
 		pr_err("Unable to register input device\n");
-		input_free_device(hkey->inputdev);
-		return -ENODEV;
+		goto err_free_keymap;
 	}
 
+	hkey->inputdev = input;
 	return 0;
+
+ err_free_keymap:
+	sparse_keymap_free(input);
+ err_free_dev:
+	input_free_device(input);
+	return error;
 }
 
 static int acpi_topstar_add(struct acpi_device *device)
@@ -216,6 +171,7 @@ static int acpi_topstar_remove(struct acpi_device *device, int type)
 
 	acpi_topstar_fncx_switch(device, false);
 
+	sparse_keymap_free(tps_hkey->inputdev);
 	input_unregister_device(tps_hkey->inputdev);
 	kfree(tps_hkey);
 

