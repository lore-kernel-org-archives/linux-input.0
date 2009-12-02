From: Anisse Astier <anisse@astier.eu>
Subject: [RFC PATCH 1/2] Input: add msi-wmi driver to support hotkeys in
 =?UTF-8?B?TVNJwqBXaW5kdG9w?= AE1900-WT
Date: Wed, 2 Dec 2009 19:26:03 +0100
Message-ID: <20091202192603.3e1de98a@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52786 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbZLBTV3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2009 14:21:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>


Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hi,

This driver (intiated by=20
http://sysmic.org/dotclear2/index.php?post/2009/06/02/83-msi-wmi-suppor=
t) is
aimed at supporting WMI based hotkeys on MSI=C2=A0Windtop all-in-one AE=
1900-WT.

This patch contains both WMI and DMI auto loading. Once Mathew Garrett'=
s
patch for wmi autoloading is upstream (now in acpi-test), DMI auto load=
ing
could (should?) be removed.

Also, Dmitry is in the process of factoring code for sparse keymaps. Th=
e=20
second patch adds support its sparse keymap lib, removing a lot of code=
=2E

These patches are based on linux-input tree, and have been tested on th=
e
hardware with and without the sparse keymap patch.

 drivers/platform/x86/Kconfig   |   11 ++
 drivers/platform/x86/Makefile  |    1 +
 drivers/platform/x86/msi-wmi.c |  212 ++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/x86/msi-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
index 1b27e4d..fe142af 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -441,4 +441,15 @@ config ACPI_TOSHIBA
=20
 	  If you have a legacy free Toshiba laptop (such as the Libretto L1
 	  series), say Y.
+
+config MSI_WMI
+	tristate "MSI WMI extras"
+	depends on ACPI_WMI
+	depends on INPUT
+	---help---
+	 Say Y here if you want to support WMI-based hotkeys on MSI all-in-on=
e
+	 WindTop AE1900-WT.
+
+	 To compile this driver as a module, choose M here: the module will
+	 be called msi-wmi.
 endif # X86_PLATFORM_DEVICES
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
index d1c1621..22a0c78 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_ACPI_WMI)		+=3D wmi.o
 obj-$(CONFIG_ACPI_ASUS)		+=3D asus_acpi.o
 obj-$(CONFIG_TOPSTAR_LAPTOP)	+=3D topstar-laptop.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+=3D toshiba_acpi.o
+obj-$(CONFIG_MSI_WMI)		+=3D msi-wmi.o
diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-=
wmi.c
new file mode 100644
index 0000000..fb6d5bd
--- /dev/null
+++ b/drivers/platform/x86/msi-wmi.c
@@ -0,0 +1,212 @@
+/*
+ * MSI WMI hotkeys
+ *
+ * Copyright (C) 2009 J=C3=A9r=C3=B4me Pouiller <jezz@sysmic.org>
+ *
+ * Portions based on hp-wmi.c:
+ * Copyright (C) 2008 Red Hat <mjg@redhat.com>
+ *
+ * Portions based on wistron_btns.c:
+ * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
+ * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
+ * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
+ *
+ *  This program is free software; you can redistribute it and/or modi=
fy
+ *  it under the terms of the GNU General Public License as published =
by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-13=
07  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/acpi.h>
+#include <linux/jiffies.h>
+
+#define MSIWMI_EVENT_GUID "b6f3eef2-3d2f-49dc-9de3-85bce18c62f2"
+
+struct key_entry {
+	u16 code;
+	u16 keycode;
+};
+
+static struct key_entry msi_wmi_keymap[] =3D {
+	/*Brightness keys should be used for a backlight driver*/
+	{208, KEY_BRIGHTNESSUP},
+	{209, KEY_BRIGHTNESSDOWN},
+	{210, KEY_VOLUMEUP},
+	{211, KEY_VOLUMEDOWN},
+	{0}
+};
+
+static struct input_dev *msi_wmi_input_dev;
+static unsigned long long msi_wmi_time_last_press;
+static unsigned pression_timeout =3D 10;
+
+static struct key_entry *msi_wmi_get_entry_by_scancode(int code)
+{
+	struct key_entry *key;
+
+	for (key =3D msi_wmi_keymap; key->code; key++)
+		if (code =3D=3D key->code)
+			return key;
+
+	return NULL;
+}
+
+static struct key_entry *msi_wmi_get_entry_by_keycode(int keycode)
+{
+	struct key_entry *key;
+
+	for (key =3D msi_wmi_keymap; key->code; key++)
+		if (keycode =3D=3D key->keycode)
+			return key;
+
+	return NULL;
+}
+
+static void msi_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	static struct key_entry *key;
+	union acpi_object *obj;
+
+	acpi_status ret;
+	ret =3D wmi_get_event_data(value, &response);
+	obj =3D (union acpi_object *)response.pointer;
+
+	if (!obj || obj->type !=3D ACPI_TYPE_INTEGER) {
+		printk(KERN_INFO "MSI WMI: Unknown response received\n");
+		return;
+	}
+
+	if (jiffies_to_msecs(get_jiffies_64() - msi_wmi_time_last_press)
+			> pression_timeout) {
+		printk(KERN_DEBUG
+				"MSI WMI: event correctly received: %llu\n",
+				obj->integer.value);
+		msi_wmi_time_last_press =3D get_jiffies_64();
+		key =3D msi_wmi_get_entry_by_scancode(obj->integer.value);
+		input_report_key(msi_wmi_input_dev, key->keycode, 1);
+		input_sync(msi_wmi_input_dev);
+		input_report_key(msi_wmi_input_dev, key->keycode, 0);
+		input_sync(msi_wmi_input_dev);
+	}
+}
+
+static int msi_wmi_getkeycode(struct input_dev *dev, int scancode, int=
 *keycode)
+{
+	struct key_entry *key =3D msi_wmi_get_entry_by_scancode(scancode);
+
+	if (key && key->code) {
+		*keycode =3D key->keycode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int msi_wmi_setkeycode(struct input_dev *dev, int scancode, int=
 keycode)
+{
+	struct key_entry *key;
+	int old_keycode;
+
+	if (keycode < 0 || keycode > KEY_MAX)
+		return -EINVAL;
+
+	key =3D msi_wmi_get_entry_by_scancode(scancode);
+	if (key && key->code) {
+		old_keycode =3D key->keycode;
+		key->keycode =3D keycode;
+		set_bit(keycode, dev->keybit);
+		if (!msi_wmi_get_entry_by_keycode(old_keycode))
+			clear_bit(old_keycode, dev->keybit);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int __init msi_wmi_input_setup(void)
+{
+	struct key_entry *key;
+	int err;
+
+	msi_wmi_input_dev =3D input_allocate_device();
+
+	msi_wmi_input_dev->name =3D "MSI WMI hotkeys";
+	msi_wmi_input_dev->phys =3D "wmi/input0";
+	msi_wmi_input_dev->id.bustype =3D BUS_HOST;
+	msi_wmi_input_dev->getkeycode =3D msi_wmi_getkeycode;
+	msi_wmi_input_dev->setkeycode =3D msi_wmi_setkeycode;
+
+	for (key =3D msi_wmi_keymap; key->code; key++) {
+		set_bit(EV_KEY, msi_wmi_input_dev->evbit);
+		set_bit(key->keycode, msi_wmi_input_dev->keybit);
+	}
+
+	err =3D input_register_device(msi_wmi_input_dev);
+
+	if (err)
+		input_free_device(msi_wmi_input_dev);
+
+	return err;
+}
+
+static int __init msi_wmi_init(void)
+{
+	int err;
+
+	msi_wmi_time_last_press =3D get_jiffies_64();
+	if (!wmi_has_guid(MSIWMI_EVENT_GUID)) {
+		printk(KERN_ERR
+		       "This machine doesn't have MSI-hotkeys through WMI\n");
+		goto load_error;
+	}
+	err =3D wmi_install_notify_handler(MSIWMI_EVENT_GUID,
+					 msi_wmi_notify, NULL);
+	if (err) {
+		printk(KERN_ERR
+		       "MSI WMI: Error while installing notify handler\n");
+		goto load_error;
+	}
+
+	msi_wmi_input_setup();
+
+	return 0;
+load_error:
+	return -ENODEV;
+}
+
+static void __exit msi_wmi_exit(void)
+{
+	if (wmi_has_guid(MSIWMI_EVENT_GUID)) {
+		wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
+		input_unregister_device(msi_wmi_input_dev);
+	}
+}
+
+module_init(msi_wmi_init);
+module_exit(msi_wmi_exit);
+module_param(pression_timeout, uint, 0);
+
+MODULE_AUTHOR("J=C3=A9r=C3=B4me Pouiller <jezz@sysmic.org>");
+MODULE_AUTHOR("Michael Bouchaud <michael@substantiel.fr");
+MODULE_AUTHOR("Anisse Astier <anisse@astier.eu");
+MODULE_DESCRIPTION("MSI all-in-one WMI hotkeys driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("wmi:" MSIWMI_EVENT_GUID);
+/*This one is useless if there is wmi-autoloading*/
+MODULE_ALIAS("dmi:bvnMICRO-STARINTERNATIONALCO.,LTD:*:svnMICRO-STARINT=
ERNATIO"
+	     "NALCO.,LTD:pnMS-6638:*:rnMS-7438:*:cvnMICRO-STARINTERNATIONALCO=
=2E"
+	     ",LTD:*");
+MODULE_PARM_DESC(pression_timeout,
+		 "How much time interrupts are ignored between each pression");
--=20
1.6.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
