From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/9] Input: hp-wmi - switch to using sparse keymap library
Date: Thu, 03 Dec 2009 22:12:19 -0800
Message-ID: <20091204061219.28288.81620.stgit@localhost.localdomain>
References: <20091204060701.28288.91430.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091204060701.28288.91430.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>, Anisse Astier <anisse@astier.eu>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/Kconfig  |    1 
 drivers/platform/x86/hp-wmi.c |  159 ++++++++++++-----------------------------
 2 files changed, 49 insertions(+), 111 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1f10bf4..18b66fd 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -137,6 +137,7 @@ config HP_WMI
 	depends on ACPI_WMI
 	depends on INPUT
 	depends on RFKILL || RFKILL = n
+	select INPUT_SPARSEKMAP
 	help
 	 Say Y here if you want to support WMI-based hotkeys on HP laptops and
 	 to read data from WMI such as docking or ambient light sensor state.
diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index c284217..3e3fe69 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 #include <acpi/acpi_drivers.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
@@ -69,22 +70,14 @@ struct bios_return {
 	u32 value;
 };
 
-struct key_entry {
-	char type;		/* See KE_* below */
-	u16 code;
-	u16 keycode;
-};
-
-enum { KE_KEY, KE_END };
-
-static struct key_entry hp_wmi_keymap[] = {
-	{KE_KEY, 0x02, KEY_BRIGHTNESSUP},
-	{KE_KEY, 0x03, KEY_BRIGHTNESSDOWN},
-	{KE_KEY, 0x20e6, KEY_PROG1},
-	{KE_KEY, 0x2142, KEY_MEDIA},
-	{KE_KEY, 0x213b, KEY_INFO},
-	{KE_KEY, 0x231b, KEY_HELP},
-	{KE_END, 0}
+static const struct key_entry hp_wmi_keymap[] = {
+	{ KE_KEY, 0x02,   { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x03,   { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x20e6, { KEY_PROG1 } },
+	{ KE_KEY, 0x2142, { KEY_MEDIA } },
+	{ KE_KEY, 0x213b, { KEY_INFO } },
+	{ KE_KEY, 0x231b, { KEY_HELP } },
+	{ KE_END, 0}
 };
 
 static struct input_dev *hp_wmi_input_dev;
@@ -274,65 +267,10 @@ static DEVICE_ATTR(als, S_IRUGO | S_IWUSR, show_als, set_als);
 static DEVICE_ATTR(dock, S_IRUGO, show_dock, NULL);
 static DEVICE_ATTR(tablet, S_IRUGO, show_tablet, NULL);
 
-static struct key_entry *hp_wmi_get_entry_by_scancode(int code)
-{
-	struct key_entry *key;
-
-	for (key = hp_wmi_keymap; key->type != KE_END; key++)
-		if (code == key->code)
-			return key;
-
-	return NULL;
-}
-
-static struct key_entry *hp_wmi_get_entry_by_keycode(int keycode)
-{
-	struct key_entry *key;
-
-	for (key = hp_wmi_keymap; key->type != KE_END; key++)
-		if (key->type == KE_KEY && keycode == key->keycode)
-			return key;
-
-	return NULL;
-}
-
-static int hp_wmi_getkeycode(struct input_dev *dev, int scancode, int *keycode)
-{
-	struct key_entry *key = hp_wmi_get_entry_by_scancode(scancode);
-
-	if (key && key->type == KE_KEY) {
-		*keycode = key->keycode;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int hp_wmi_setkeycode(struct input_dev *dev, int scancode, int keycode)
-{
-	struct key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key = hp_wmi_get_entry_by_scancode(scancode);
-	if (key && key->type == KE_KEY) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!hp_wmi_get_entry_by_keycode(old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static void hp_wmi_notify(u32 value, void *context)
 {
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
-	static struct key_entry *key;
+	const struct key_entry *key;
 	union acpi_object *obj;
 
 	wmi_get_event_data(value, &response);
@@ -344,18 +282,11 @@ static void hp_wmi_notify(u32 value, void *context)
 		if (eventcode == 0x4)
 			eventcode = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
 							 0);
-		key = hp_wmi_get_entry_by_scancode(eventcode);
+		key = sparse_keymap_entry_from_scancode(hp_wmi_input_dev,
+							eventcode);
 		if (key) {
-			switch (key->type) {
-			case KE_KEY:
-				input_report_key(hp_wmi_input_dev,
-						 key->keycode, 1);
-				input_sync(hp_wmi_input_dev);
-				input_report_key(hp_wmi_input_dev,
-						 key->keycode, 0);
-				input_sync(hp_wmi_input_dev);
-				break;
-			}
+			sparse_keymap_report_entry(hp_wmi_input_dev,
+						   key, 1, true);
 		} else if (eventcode == 0x1) {
 			input_report_switch(hp_wmi_input_dev, SW_DOCK,
 					    hp_wmi_dock_state());
@@ -381,7 +312,6 @@ static void hp_wmi_notify(u32 value, void *context)
 
 static int __init hp_wmi_input_setup(void)
 {
-	struct key_entry *key;
 	int err;
 
 	hp_wmi_input_dev = input_allocate_device();
@@ -389,21 +319,14 @@ static int __init hp_wmi_input_setup(void)
 	hp_wmi_input_dev->name = "HP WMI hotkeys";
 	hp_wmi_input_dev->phys = "wmi/input0";
 	hp_wmi_input_dev->id.bustype = BUS_HOST;
-	hp_wmi_input_dev->getkeycode = hp_wmi_getkeycode;
-	hp_wmi_input_dev->setkeycode = hp_wmi_setkeycode;
-
-	for (key = hp_wmi_keymap; key->type != KE_END; key++) {
-		switch (key->type) {
-		case KE_KEY:
-			set_bit(EV_KEY, hp_wmi_input_dev->evbit);
-			set_bit(key->keycode, hp_wmi_input_dev->keybit);
-			break;
-		}
-	}
 
-	set_bit(EV_SW, hp_wmi_input_dev->evbit);
-	set_bit(SW_DOCK, hp_wmi_input_dev->swbit);
-	set_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit);
+	__set_bit(EV_SW, hp_wmi_input_dev->evbit);
+	__set_bit(SW_DOCK, hp_wmi_input_dev->swbit);
+	__set_bit(SW_TABLET_MODE, hp_wmi_input_dev->swbit);
+
+	err = sparse_keymap_setup(hp_wmi_input_dev, hp_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
 
 	/* Set initial hardware state */
 	input_report_switch(hp_wmi_input_dev, SW_DOCK, hp_wmi_dock_state());
@@ -411,14 +334,30 @@ static int __init hp_wmi_input_setup(void)
 			    hp_wmi_tablet_state());
 	input_sync(hp_wmi_input_dev);
 
-	err = input_register_device(hp_wmi_input_dev);
+	err = wmi_install_notify_handler(HPWMI_EVENT_GUID, hp_wmi_notify, NULL);
+	if (err)
+		goto err_free_keymap;
 
-	if (err) {
-		input_free_device(hp_wmi_input_dev);
-		return err;
-	}
+	err = input_register_device(hp_wmi_input_dev);
+	if (err)
+		goto err_uninstall_notifier;
 
 	return 0;
+
+ err_uninstall_notifier:
+	wmi_remove_notify_handler(HPWMI_EVENT_GUID);
+ err_free_keymap:
+	sparse_keymap_free(hp_wmi_input_dev);
+ err_free_dev:
+	input_free_device(hp_wmi_input_dev);
+	return err;
+}
+
+static void __exit hp_wmi_input_destroy(void)
+{
+	wmi_remove_notify_handler(HPWMI_EVENT_GUID);
+	sparse_keymap_free(hp_wmi_input_dev);
+	input_unregister_device(hp_wmi_input_dev);
 }
 
 static void cleanup_sysfs(struct platform_device *device)
@@ -541,10 +480,9 @@ static int __init hp_wmi_init(void)
 	int err;
 
 	if (wmi_has_guid(HPWMI_EVENT_GUID)) {
-		err = wmi_install_notify_handler(HPWMI_EVENT_GUID,
-						 hp_wmi_notify, NULL);
-		if (!err)
-			hp_wmi_input_setup();
+		err = hp_wmi_input_setup();
+		if (err)
+			return err;
 	}
 
 	if (wmi_has_guid(HPWMI_BIOS_GUID)) {
@@ -564,10 +502,9 @@ static int __init hp_wmi_init(void)
 
 static void __exit hp_wmi_exit(void)
 {
-	if (wmi_has_guid(HPWMI_EVENT_GUID)) {
-		wmi_remove_notify_handler(HPWMI_EVENT_GUID);
-		input_unregister_device(hp_wmi_input_dev);
-	}
+	if (wmi_has_guid(HPWMI_EVENT_GUID))
+		hp_wmi_input_destroy();
+
 	if (hp_wmi_platform_dev) {
 		platform_device_del(hp_wmi_platform_dev);
 		platform_driver_unregister(&hp_wmi_driver);

