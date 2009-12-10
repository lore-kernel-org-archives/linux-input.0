From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH 7/7] msi-wmi: switch to using input sparse keymap library
Date: Thu, 10 Dec 2009 14:18:19 +0100
Message-ID: <1260451099-25620-8-git-send-email-anisse@astier.eu>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42837 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759694AbZLJN1n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 08:27:43 -0500
In-Reply-To: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>, Anisse Astier <anisse@astier.eu>

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/platform/x86/Kconfig   |    1 +
 drivers/platform/x86/msi-wmi.c |  134 ++++++++++------------------------------
 2 files changed, 33 insertions(+), 102 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 98ec6bd..1f82d6d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -369,6 +369,7 @@ config MSI_WMI
 	tristate "MSI WMI extras"
 	depends on ACPI_WMI
 	depends on INPUT
+	select INPUT_SPARSEKMAP
 	help
 	 Say Y here if you want to support WMI-based hotkeys on MSI laptops.
 
diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index 2c2afc1..e25b80c 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -21,9 +21,9 @@
  */
 
 
-
 #include <linux/kernel.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 #include <linux/acpi.h>
 #include <linux/backlight.h>
 
@@ -52,26 +52,15 @@ MODULE_ALIAS("dmi:*:svnMICRO-STARINTERNATIONAL*:pnMS-6638:*");
 
 #define dprintk(msg...) pr_debug(DRV_PFX msg)
 
-struct key_entry {
-	char type;		/* See KE_* below */
-	u16 code;
-	u16 keycode;
-	ktime_t last_pressed;
-};
-
-/*
- * KE_KEY the only used key type, but keep this, others might also
- * show up in the future. Compare with hp-wmi.c
- */
-enum { KE_KEY, KE_END };
-
+#define KEYCODE_BASE 0xD0
 static struct key_entry msi_wmi_keymap[] = {
-	{ KE_KEY, 0xd0, KEY_BRIGHTNESSUP,   {0, } },
-	{ KE_KEY, 0xd1, KEY_BRIGHTNESSDOWN, {0, } },
-	{ KE_KEY, 0xd2, KEY_VOLUMEUP,	{0, } },
-	{ KE_KEY, 0xd3, KEY_VOLUMEDOWN,	{0, } },
+	{ KE_KEY, KEYCODE_BASE,     {KEY_BRIGHTNESSUP} },
+	{ KE_KEY, KEYCODE_BASE + 1, {KEY_BRIGHTNESSDOWN} },
+	{ KE_KEY, KEYCODE_BASE + 2, {KEY_VOLUMEUP} },
+	{ KE_KEY, KEYCODE_BASE + 3, {KEY_VOLUMEDOWN} },
 	{ KE_END, 0}
 };
+static ktime_t last_pressed[ARRAY_SIZE(msi_wmi_keymap) - 1];
 
 struct backlight_device *backlight;
 
@@ -158,61 +147,6 @@ static struct backlight_ops msi_backlight_ops = {
 	.update_status	= bl_set_status,
 };
 
-static struct key_entry *msi_wmi_get_entry_by_scancode(int code)
-{
-	struct key_entry *key;
-
-	for (key = msi_wmi_keymap; key->type != KE_END; key++)
-		if (code == key->code)
-			return key;
-
-	return NULL;
-}
-
-static struct key_entry *msi_wmi_get_entry_by_keycode(int keycode)
-{
-	struct key_entry *key;
-
-	for (key = msi_wmi_keymap; key->type != KE_END; key++)
-		if (key->type == KE_KEY && keycode == key->keycode)
-			return key;
-
-	return NULL;
-}
-
-static int msi_wmi_getkeycode(struct input_dev *dev, int scancode, int *keycode)
-{
-	struct key_entry *key = msi_wmi_get_entry_by_scancode(scancode);
-
-	if (key && key->type == KE_KEY) {
-		*keycode = key->keycode;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int msi_wmi_setkeycode(struct input_dev *dev, int scancode, int keycode)
-{
-	struct key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key = msi_wmi_get_entry_by_scancode(scancode);
-	if (key && key->type == KE_KEY) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!msi_wmi_get_entry_by_keycode(old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static void msi_wmi_notify(u32 value, void *context)
 {
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -227,21 +161,22 @@ static void msi_wmi_notify(u32 value, void *context)
 	if (obj && obj->type == ACPI_TYPE_INTEGER) {
 		int eventcode = obj->integer.value;
 		dprintk("Eventcode: 0x%x\n", eventcode);
-		key = msi_wmi_get_entry_by_scancode(eventcode);
+		key = sparse_keymap_entry_from_scancode(msi_wmi_input_dev,
+				eventcode);
 		if (key) {
+			ktime_t diff;
 			cur = ktime_get_real();
+			diff = ktime_sub(cur, last_pressed[key->code -
+					KEYCODE_BASE]);
 			/* Ignore event if the same event happened in a 50 ms
 			   timeframe -> Key press may result in 10-20 GPEs */
-			if (ktime_to_us(ktime_sub(cur, key->last_pressed))
-			    < 1000 * 50) {
+			if (ktime_to_us(diff) < 1000 * 50) {
 				dprintk("Suppressed key event 0x%X - "
 					"Last press was %lld us ago\n",
-					 key->code,
-					 ktime_to_us(ktime_sub(cur,
-						       key->last_pressed)));
+					 key->code, ktime_to_us(diff));
 				return;
 			}
-			key->last_pressed = cur;
+			last_pressed[key->code - KEYCODE_BASE] = cur;
 
 			if (key->type == KE_KEY &&
 			/* Brightness is served via acpi video driver */
@@ -250,12 +185,8 @@ static void msi_wmi_notify(u32 value, void *context)
 				dprintk("Send key: 0x%X - "
 					"Input layer keycode: %d\n", key->code,
 					 key->keycode);
-				input_report_key(msi_wmi_input_dev,
-						 key->keycode, 1);
-				input_sync(msi_wmi_input_dev);
-				input_report_key(msi_wmi_input_dev,
-						 key->keycode, 0);
-				input_sync(msi_wmi_input_dev);
+				sparse_keymap_report_entry(msi_wmi_input_dev,
+						key, 1, true);
 			}
 		} else
 			printk(KERN_INFO "Unknown key pressed - %x\n",
@@ -267,7 +198,6 @@ static void msi_wmi_notify(u32 value, void *context)
 
 static int __init msi_wmi_input_setup(void)
 {
-	struct key_entry *key;
 	int err;
 
 	msi_wmi_input_dev = input_allocate_device();
@@ -277,26 +207,25 @@ static int __init msi_wmi_input_setup(void)
 	msi_wmi_input_dev->name = "MSI WMI hotkeys";
 	msi_wmi_input_dev->phys = "wmi/input0";
 	msi_wmi_input_dev->id.bustype = BUS_HOST;
-	msi_wmi_input_dev->getkeycode = msi_wmi_getkeycode;
-	msi_wmi_input_dev->setkeycode = msi_wmi_setkeycode;
-
-	for (key = msi_wmi_keymap; key->type != KE_END; key++) {
-		switch (key->type) {
-		case KE_KEY:
-			set_bit(EV_KEY, msi_wmi_input_dev->evbit);
-			set_bit(key->keycode, msi_wmi_input_dev->keybit);
-			break;
-		}
-	}
+
+	err = sparse_keymap_setup(msi_wmi_input_dev, msi_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
 
 	err = input_register_device(msi_wmi_input_dev);
 
-	if (err) {
-		input_free_device(msi_wmi_input_dev);
-		return err;
-	}
+	if (err)
+		goto err_free_keymap;
+
+	memset(last_pressed, 0, sizeof(last_pressed));
 
 	return 0;
+
+err_free_keymap:
+	sparse_keymap_free(msi_wmi_input_dev);
+err_free_dev:
+	input_free_device(msi_wmi_input_dev);
+	return err;
 }
 
 static int __init msi_wmi_init(void)
@@ -347,6 +276,7 @@ static void __exit msi_wmi_exit(void)
 {
 	if (wmi_has_guid(MSIWMI_EVENT_GUID)) {
 		wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
+		sparse_keymap_free(msi_wmi_input_dev);
 		input_unregister_device(msi_wmi_input_dev);
 		backlight_device_unregister(backlight);
 	}
-- 
1.6.5.3

