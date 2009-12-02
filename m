From: Anisse Astier <anisse@astier.eu>
Subject: [RFC PATCH 2/2] Input: msi-wmi - switch to using sparse keymap
 library
Date: Wed, 2 Dec 2009 19:28:12 +0100
Message-ID: <20091202192812.7e9919fb@destiny.ordissimo>
References: <20091202192603.3e1de98a@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091202192603.3e1de98a@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org


Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/platform/x86/Kconfig   |    1 +
 drivers/platform/x86/msi-wmi.c |  123 +++++++++++---------------------=
--------
 2 files changed, 35 insertions(+), 89 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
index fe142af..d6925ad 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -446,6 +446,7 @@ config MSI_WMI
 	tristate "MSI WMI extras"
 	depends on ACPI_WMI
 	depends on INPUT
+	select INPUT_SPARSEKMAP
 	---help---
 	 Say Y here if you want to support WMI-based hotkeys on MSI all-in-on=
e
 	 WindTop AE1900-WT.
diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-=
wmi.c
index fb6d5bd..5dcb6fb 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -1,6 +1,7 @@
 /*
  * MSI WMI hotkeys
  *
+ * Copyright (C) 2009 Anisse Astier <anisse@astier.eu>
  * Copyright (C) 2009 J=C3=A9r=C3=B4me Pouiller <jezz@sysmic.org>
  *
  * Portions based on hp-wmi.c:
@@ -28,51 +29,25 @@
=20
 #include <linux/kernel.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 #include <linux/acpi.h>
 #include <linux/jiffies.h>
=20
 #define MSIWMI_EVENT_GUID "b6f3eef2-3d2f-49dc-9de3-85bce18c62f2"
=20
-struct key_entry {
-	u16 code;
-	u16 keycode;
-};
-
-static struct key_entry msi_wmi_keymap[] =3D {
+static const struct key_entry msi_wmi_keymap[] =3D {
 	/*Brightness keys should be used for a backlight driver*/
-	{208, KEY_BRIGHTNESSUP},
-	{209, KEY_BRIGHTNESSDOWN},
-	{210, KEY_VOLUMEUP},
-	{211, KEY_VOLUMEDOWN},
-	{0}
+	{KE_KEY, 208, {KEY_BRIGHTNESSUP} },
+	{KE_KEY, 209, {KEY_BRIGHTNESSDOWN} },
+	{KE_KEY, 210, {KEY_VOLUMEUP} },
+	{KE_KEY, 211, {KEY_VOLUMEDOWN} },
+	{KE_END, 0}
 };
=20
 static struct input_dev *msi_wmi_input_dev;
 static unsigned long long msi_wmi_time_last_press;
 static unsigned pression_timeout =3D 10;
=20
-static struct key_entry *msi_wmi_get_entry_by_scancode(int code)
-{
-	struct key_entry *key;
-
-	for (key =3D msi_wmi_keymap; key->code; key++)
-		if (code =3D=3D key->code)
-			return key;
-
-	return NULL;
-}
-
-static struct key_entry *msi_wmi_get_entry_by_keycode(int keycode)
-{
-	struct key_entry *key;
-
-	for (key =3D msi_wmi_keymap; key->code; key++)
-		if (keycode =3D=3D key->keycode)
-			return key;
-
-	return NULL;
-}
-
 static void msi_wmi_notify(u32 value, void *context)
 {
 	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
@@ -94,7 +69,8 @@ static void msi_wmi_notify(u32 value, void *context)
 				"MSI WMI: event correctly received: %llu\n",
 				obj->integer.value);
 		msi_wmi_time_last_press =3D get_jiffies_64();
-		key =3D msi_wmi_get_entry_by_scancode(obj->integer.value);
+		key =3D sparse_keymap_entry_from_scancode(msi_wmi_input_dev,
+				obj->integer.value);
 		input_report_key(msi_wmi_input_dev, key->keycode, 1);
 		input_sync(msi_wmi_input_dev);
 		input_report_key(msi_wmi_input_dev, key->keycode, 0);
@@ -102,42 +78,8 @@ static void msi_wmi_notify(u32 value, void *context=
)
 	}
 }
=20
-static int msi_wmi_getkeycode(struct input_dev *dev, int scancode, int=
 *keycode)
-{
-	struct key_entry *key =3D msi_wmi_get_entry_by_scancode(scancode);
-
-	if (key && key->code) {
-		*keycode =3D key->keycode;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int msi_wmi_setkeycode(struct input_dev *dev, int scancode, int=
 keycode)
-{
-	struct key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key =3D msi_wmi_get_entry_by_scancode(scancode);
-	if (key && key->code) {
-		old_keycode =3D key->keycode;
-		key->keycode =3D keycode;
-		set_bit(keycode, dev->keybit);
-		if (!msi_wmi_get_entry_by_keycode(old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static int __init msi_wmi_input_setup(void)
 {
-	struct key_entry *key;
 	int err;
=20
 	msi_wmi_input_dev =3D input_allocate_device();
@@ -145,45 +87,48 @@ static int __init msi_wmi_input_setup(void)
 	msi_wmi_input_dev->name =3D "MSI WMI hotkeys";
 	msi_wmi_input_dev->phys =3D "wmi/input0";
 	msi_wmi_input_dev->id.bustype =3D BUS_HOST;
-	msi_wmi_input_dev->getkeycode =3D msi_wmi_getkeycode;
-	msi_wmi_input_dev->setkeycode =3D msi_wmi_setkeycode;
=20
-	for (key =3D msi_wmi_keymap; key->code; key++) {
-		set_bit(EV_KEY, msi_wmi_input_dev->evbit);
-		set_bit(key->keycode, msi_wmi_input_dev->keybit);
-	}
+	err =3D sparse_keymap_setup(msi_wmi_input_dev, msi_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
=20
+	err =3D wmi_install_notify_handler(MSIWMI_EVENT_GUID,
+					 msi_wmi_notify, NULL);
+	if (err) {
+		printk(KERN_ERR
+		       "MSI WMI: Error while installing notify handler\n");
+		goto err_free_keymap;
+	}
 	err =3D input_register_device(msi_wmi_input_dev);
-
 	if (err)
-		input_free_device(msi_wmi_input_dev);
+		goto err_uninstall_notifier;
+
+	return 0;
+
+err_uninstall_notifier:
+	wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
+err_free_keymap:
+	sparse_keymap_free(msi_wmi_input_dev);
+err_free_dev:
+	input_free_device(msi_wmi_input_dev);
=20
 	return err;
 }
=20
 static int __init msi_wmi_init(void)
 {
-	int err;
+	int err =3D 0;
=20
 	msi_wmi_time_last_press =3D get_jiffies_64();
 	if (!wmi_has_guid(MSIWMI_EVENT_GUID)) {
 		printk(KERN_ERR
 		       "This machine doesn't have MSI-hotkeys through WMI\n");
-		goto load_error;
-	}
-	err =3D wmi_install_notify_handler(MSIWMI_EVENT_GUID,
-					 msi_wmi_notify, NULL);
-	if (err) {
-		printk(KERN_ERR
-		       "MSI WMI: Error while installing notify handler\n");
-		goto load_error;
+		return -ENODEV;
 	}
=20
-	msi_wmi_input_setup();
+	err =3D msi_wmi_input_setup();
=20
-	return 0;
-load_error:
-	return -ENODEV;
+	return err;
 }
=20
 static void __exit msi_wmi_exit(void)
--=20
1.6.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
