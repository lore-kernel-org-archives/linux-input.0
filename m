From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/9] Input: wistron_btns - switch to using sparse keymap
	library
Date: Thu, 03 Dec 2009 22:12:03 -0800
Message-ID: <20091204061203.28288.68062.stgit@localhost.localdomain>
References: <20091204060701.28288.91430.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:58439 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbZLDGL7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 01:11:59 -0500
In-Reply-To: <20091204060701.28288.91430.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>, Anisse Astier <anisse@astier.eu>

The keymap manipulation code was split into a library module,
so let's make us of it.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/Kconfig        |    1 
 drivers/input/misc/wistron_btns.c |  178 +++++++++----------------------------
 2 files changed, 45 insertions(+), 134 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index a9bb254..d25ecbb 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -80,6 +80,7 @@ config INPUT_WISTRON_BTNS
 	tristate "x86 Wistron laptop button interface"
 	depends on X86 && !X86_64
 	select INPUT_POLLDEV
+	select INPUT_SPARSEKMAP
 	select NEW_LEDS
 	select LEDS_CLASS
 	select CHECK_SIGNATURE
diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 00eb9d6..b70c066 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -21,6 +21,7 @@
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/input-polldev.h>
+#include <linux/input/sparse-keymap.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
@@ -224,19 +225,8 @@ static void bios_set_state(u8 subsys, int enable)
 
 /* Hardware database */
 
-struct key_entry {
-	char type;		/* See KE_* below */
-	u8 code;
-	union {
-		u16 keycode;		/* For KE_KEY */
-		struct {		/* For KE_SW */
-			u8 code;
-			u8 value;
-		} sw;
-	};
-};
-
-enum { KE_END, KE_KEY, KE_SW, KE_WIFI, KE_BLUETOOTH };
+#define KE_WIFI		(KE_LAST + 1)
+#define KE_BLUETOOTH	(KE_LAST + 2)
 
 #define FE_MAIL_LED 0x01
 #define FE_WIFI_LED 0x02
@@ -1037,21 +1027,6 @@ static unsigned long jiffies_last_press;
 static bool wifi_enabled;
 static bool bluetooth_enabled;
 
-static void report_key(struct input_dev *dev, unsigned int keycode)
-{
-	input_report_key(dev, keycode, 1);
-	input_sync(dev);
-	input_report_key(dev, keycode, 0);
-	input_sync(dev);
-}
-
-static void report_switch(struct input_dev *dev, unsigned int code, int value)
-{
-	input_report_switch(dev, code, value);
-	input_sync(dev);
-}
-
-
  /* led management */
 static void wistron_mail_led_set(struct led_classdev *led_cdev,
 				enum led_brightness value)
@@ -1128,43 +1103,13 @@ static inline void wistron_led_resume(void)
 		led_classdev_resume(&wistron_wifi_led);
 }
 
-static struct key_entry *wistron_get_entry_by_scancode(int code)
-{
-	struct key_entry *key;
-
-	for (key = keymap; key->type != KE_END; key++)
-		if (code == key->code)
-			return key;
-
-	return NULL;
-}
-
-static struct key_entry *wistron_get_entry_by_keycode(int keycode)
-{
-	struct key_entry *key;
-
-	for (key = keymap; key->type != KE_END; key++)
-		if (key->type == KE_KEY && keycode == key->keycode)
-			return key;
-
-	return NULL;
-}
-
 static void handle_key(u8 code)
 {
-	const struct key_entry *key = wistron_get_entry_by_scancode(code);
+	const struct key_entry *key =
+		sparse_keymap_entry_from_scancode(wistron_idev->input, code);
 
 	if (key) {
 		switch (key->type) {
-		case KE_KEY:
-			report_key(wistron_idev->input, key->keycode);
-			break;
-
-		case KE_SW:
-			report_switch(wistron_idev->input,
-				      key->sw.code, key->sw.value);
-			break;
-
 		case KE_WIFI:
 			if (have_wifi) {
 				wifi_enabled = !wifi_enabled;
@@ -1180,7 +1125,9 @@ static void handle_key(u8 code)
 			break;
 
 		default:
-			BUG();
+			sparse_keymap_report_entry(wistron_idev->input,
+						   key, 1, true);
+			break;
 		}
 		jiffies_last_press = jiffies;
 	} else
@@ -1220,42 +1167,39 @@ static void wistron_poll(struct input_polled_dev *dev)
 		dev->poll_interval = POLL_INTERVAL_DEFAULT;
 }
 
-static int wistron_getkeycode(struct input_dev *dev, int scancode, int *keycode)
+static int __devinit wistron_setup_keymap(struct input_dev *dev,
+					  struct key_entry *entry)
 {
-	const struct key_entry *key = wistron_get_entry_by_scancode(scancode);
+	switch (entry->type) {
 
-	if (key && key->type == KE_KEY) {
-		*keycode = key->keycode;
-		return 0;
-	}
-
-	return -EINVAL;
-}
+	/* if wifi or bluetooth are not available, create normal keys */
+	case KE_WIFI:
+		if (!have_wifi) {
+			entry->type = KE_KEY;
+			entry->keycode = KEY_WLAN;
+		}
+		break;
 
-static int wistron_setkeycode(struct input_dev *dev, int scancode, int keycode)
-{
-	struct key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key = wistron_get_entry_by_scancode(scancode);
-	if (key && key->type == KE_KEY) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!wistron_get_entry_by_keycode(old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
+	case KE_BLUETOOTH:
+		if (!have_bluetooth) {
+			entry->type = KE_KEY;
+			entry->keycode = KEY_BLUETOOTH;
+		}
+		break;
+
+	case KE_END:
+		if (entry->code & FE_UNTESTED)
+			printk(KERN_WARNING "Untested laptop multimedia keys, "
+				"please report success or failure to "
+				"eric.piel@tremplin-utc.net\n");
+		break;
 	}
 
-	return -EINVAL;
+	return 0;
 }
 
 static int __devinit setup_input_dev(void)
 {
-	struct key_entry *key;
 	struct input_dev *input_dev;
 	int error;
 
@@ -1273,56 +1217,21 @@ static int __devinit setup_input_dev(void)
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->dev.parent = &wistron_device->dev;
 
-	input_dev->getkeycode = wistron_getkeycode;
-	input_dev->setkeycode = wistron_setkeycode;
-
-	for (key = keymap; key->type != KE_END; key++) {
-		switch (key->type) {
-			case KE_KEY:
-				set_bit(EV_KEY, input_dev->evbit);
-				set_bit(key->keycode, input_dev->keybit);
-				break;
-
-			case KE_SW:
-				set_bit(EV_SW, input_dev->evbit);
-				set_bit(key->sw.code, input_dev->swbit);
-				break;
-
-			/* if wifi or bluetooth are not available, create normal keys */
-			case KE_WIFI:
-				if (!have_wifi) {
-					key->type = KE_KEY;
-					key->keycode = KEY_WLAN;
-					key--;
-				}
-				break;
-
-			case KE_BLUETOOTH:
-				if (!have_bluetooth) {
-					key->type = KE_KEY;
-					key->keycode = KEY_BLUETOOTH;
-					key--;
-				}
-				break;
-
-			default:
-				break;
-		}
-	}
-
-	/* reads information flags on KE_END */
-	if (key->code & FE_UNTESTED)
-		printk(KERN_WARNING "Untested laptop multimedia keys, "
-			"please report success or failure to eric.piel"
-			"@tremplin-utc.net\n");
+	error = sparse_keymap_setup(input_dev, keymap, wistron_setup_keymap);
+	if (error)
+		goto err_free_dev;
 
 	error = input_register_polled_device(wistron_idev);
-	if (error) {
-		input_free_polled_device(wistron_idev);
-		return error;
-	}
+	if (error)
+		goto err_free_keymap;
 
 	return 0;
+
+ err_free_keymap:
+	sparse_keymap_free(input_dev);
+ err_free_dev:
+	input_free_polled_device(wistron_idev);
+	return error;
 }
 
 /* Driver core */
@@ -1371,6 +1280,7 @@ static int __devexit wistron_remove(struct platform_device *dev)
 {
 	wistron_led_remove();
 	input_unregister_polled_device(wistron_idev);
+	sparse_keymap_free(wistron_idev->input);
 	input_free_polled_device(wistron_idev);
 	bios_detach();
 

