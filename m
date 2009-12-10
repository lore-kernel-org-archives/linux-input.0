From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH 1/7] X86 drivers: Introduce msi-wmi driver
Date: Thu, 10 Dec 2009 14:18:13 +0100
Message-ID: <1260451099-25620-2-git-send-email-anisse@astier.eu>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>
List-Id: linux-input@vger.kernel.org

From: Thomas Renninger <trenn@suse.de>

This driver serves backlight (including switching) and volume up/down
keys for MSI machines providing a specific wmi interface:
551A1F84-FBDD-4125-91DB-3EA8F44F1D45
B6F3EEF2-3D2F-49DC-9DE3-85BCE18C62F2

Signed-off-by: Thomas Renninger <trenn@suse.de>

CC: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: linux-acpi@vger.kernel.org
CC: Len Brown <lenb@kernel.org>
Tested-by: Matt Chen <machen@novell.com>
Reviewed-by: Anisse Astier <anisse@astier.eu>
---
 drivers/platform/x86/Kconfig   |   10 +
 drivers/platform/x86/Makefile  |    1 +
 drivers/platform/x86/msi-wmi.c |  369 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 380 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/x86/msi-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 55ca39d..98ec6bd 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -365,6 +365,16 @@ config ACPI_WMI
 	  It is safe to enable this driver even if your DSDT doesn't define
 	  any ACPI-WMI devices.
 
+config MSI_WMI
+	tristate "MSI WMI extras"
+	depends on ACPI_WMI
+	depends on INPUT
+	help
+	 Say Y here if you want to support WMI-based hotkeys on MSI laptops.
+
+	 To compile this driver as a module, choose M here: the module will
+	 be called msi-wmi.
+
 config ACPI_ASUS
 	tristate "ASUS/Medion Laptop Extras (DEPRECATED)"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index d1c1621..13aa373 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_FUJITSU_LAPTOP)	+= fujitsu-laptop.o
 obj-$(CONFIG_PANASONIC_LAPTOP)	+= panasonic-laptop.o
 obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
 obj-$(CONFIG_ACPI_WMI)		+= wmi.o
+obj-$(CONFIG_MSI_WMI)		+= msi-wmi.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
new file mode 100644
index 0000000..7e0dab6
--- /dev/null
+++ b/drivers/platform/x86/msi-wmi.c
@@ -0,0 +1,369 @@
+/*
+ * MSI WMI hotkeys
+ *
+ * Copyright (C) 2009 Novell <trenn@suse.de>
+ *
+ * Most stuff taken over from hp-wmi
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
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
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/acpi.h>
+#include <linux/string.h>
+#include <linux/hrtimer.h>
+#include <linux/backlight.h>
+
+MODULE_AUTHOR("Thomas Renninger <trenn@suse.de>");
+MODULE_DESCRIPTION("MSI laptop WMI hotkeys driver");
+MODULE_LICENSE("GPL");
+
+static int debug;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Set this to 1 to let the driver be more verbose");
+
+MODULE_ALIAS("wmi:551A1F84-FBDD-4125-91DB-3EA8F44F1D45");
+MODULE_ALIAS("wmi:B6F3EEF2-3D2F-49DC-9DE3-85BCE18C62F2");
+
+/* Temporary workaround until the WMI sysfs interface goes in
+		{ "svn", DMI_SYS_VENDOR },
+		{ "pn",  DMI_PRODUCT_NAME },
+		{ "pvr", DMI_PRODUCT_VERSION },
+		{ "rvn", DMI_BOARD_VENDOR },
+		{ "rn",  DMI_BOARD_NAME },
+*/
+
+MODULE_ALIAS("dmi:*:svnMICRO-STARINTERNATIONAL*:pnMS-6638:*");
+
+#define DRV_NAME "msi-wmi"
+#define DRV_PFX DRV_NAME ": "
+
+#define MSIWMI_BIOS_GUID "551A1F84-FBDD-4125-91DB-3EA8F44F1D45"
+#define MSIWMI_EVENT_GUID "B6F3EEF2-3D2F-49DC-9DE3-85BCE18C62F2"
+
+#define dprintk(msg...)	do {			\
+	if (debug)				\
+		printk(KERN_INFO DRV_PFX  msg); \
+	} while (0)
+
+struct key_entry {
+	char type;		/* See KE_* below */
+	u16 code;
+	u16 keycode;
+	int instance;
+	ktime_t last_pressed;
+};
+
+/*
+ * KE_KEY the only used key type, but keep this, others might also
+ * show up in the future. Compare with hp-wmi.c
+ */
+enum { KE_KEY, KE_END };
+
+static struct key_entry msi_wmi_keymap[] = {
+	{ KE_KEY, 0xd0, KEY_BRIGHTNESSUP,   0, {0, } },
+	{ KE_KEY, 0xd1, KEY_BRIGHTNESSDOWN, 1, {0, } },
+	{ KE_KEY, 0xd2, KEY_VOLUMEUP,	2, {0, } },
+	{ KE_KEY, 0xd3, KEY_VOLUMEDOWN,	3, {0, } },
+	{ KE_END, 0}
+};
+
+struct backlight_device *backlight;
+
+static int backlight_map[] = { 0x00, 0x33, 0x66, 0x99, 0xCC, 0xFF };
+
+static struct input_dev *msi_wmi_input_dev;
+
+static int msi_wmi_query_block(int instance, int *ret)
+{
+	acpi_status status;
+	union acpi_object *obj;
+
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+
+	status = wmi_query_block(MSIWMI_BIOS_GUID, instance, &output);
+
+	obj = output.pointer;
+
+	if (!obj || obj->type != ACPI_TYPE_INTEGER) {
+		if (obj) {
+			printk(KERN_ERR DRV_PFX "query block returned object "
+			       "type: %d - buffer length:%d\n", obj->type,
+			       obj->type == ACPI_TYPE_BUFFER ?
+			       obj->buffer.length : 0);
+		}
+		kfree(obj);
+		return -EINVAL;
+	}
+	*ret = obj->integer.value;
+	kfree(obj);
+	return 0;
+}
+
+static int msi_wmi_set_block(int instance, int value)
+{
+	acpi_status status;
+
+	struct acpi_buffer input = { sizeof(int), &value };
+
+	dprintk("Going to set block of instance: %d - value: %d\n",
+		instance, value);
+
+	status = wmi_set_block(MSIWMI_BIOS_GUID, instance, &input);
+
+	return ACPI_SUCCESS(status) ? 0 : 1;
+}
+
+static int bl_get(struct backlight_device *bd)
+{
+	int level, err, ret = 0;
+
+	/* Instance 1 is "get backlight", cmp with DSDT */
+	err = msi_wmi_query_block(1, &ret);
+	if (err)
+		printk(KERN_ERR DRV_PFX "Could not query backlight: %d\n", err);
+	dprintk("Get: Query block returned: %d\n", ret);
+	for (level = 0; level < ARRAY_SIZE(backlight_map); level++) {
+		if (backlight_map[level] == ret) {
+			dprintk("Current backlight level: 0x%X - index: %d\n",
+				backlight_map[level], level);
+			break;
+		}
+	}
+	if (level == ARRAY_SIZE(backlight_map)) {
+		printk(KERN_ERR DRV_PFX "get: Invalid brightness value: 0x%X\n",
+		       ret);
+		return -EINVAL;
+	}
+	return level;
+}
+
+static int bl_set_status(struct backlight_device *bd)
+{
+	int bright = bd->props.brightness;
+	if (bright >= ARRAY_SIZE(backlight_map) || bright < 0)
+		return -EINVAL;
+
+	/* Instance 0 is "set backlight" */
+	return msi_wmi_set_block(0, backlight_map[bright]);
+}
+
+static struct backlight_ops msi_backlight_ops = {
+	.get_brightness	= bl_get,
+	.update_status	= bl_set_status,
+};
+
+static struct key_entry *msi_wmi_get_entry_by_scancode(int code)
+{
+	struct key_entry *key;
+
+	for (key = msi_wmi_keymap; key->type != KE_END; key++)
+		if (code == key->code)
+			return key;
+
+	return NULL;
+}
+
+static struct key_entry *msi_wmi_get_entry_by_keycode(int keycode)
+{
+	struct key_entry *key;
+
+	for (key = msi_wmi_keymap; key->type != KE_END; key++)
+		if (key->type == KE_KEY && keycode == key->keycode)
+			return key;
+
+	return NULL;
+}
+
+static int msi_wmi_getkeycode(struct input_dev *dev, int scancode, int *keycode)
+{
+	struct key_entry *key = msi_wmi_get_entry_by_scancode(scancode);
+
+	if (key && key->type == KE_KEY) {
+		*keycode = key->keycode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int msi_wmi_setkeycode(struct input_dev *dev, int scancode, int keycode)
+{
+	struct key_entry *key;
+	int old_keycode;
+
+	if (keycode < 0 || keycode > KEY_MAX)
+		return -EINVAL;
+
+	key = msi_wmi_get_entry_by_scancode(scancode);
+	if (key && key->type == KE_KEY) {
+		old_keycode = key->keycode;
+		key->keycode = keycode;
+		set_bit(keycode, dev->keybit);
+		if (!msi_wmi_get_entry_by_keycode(old_keycode))
+			clear_bit(old_keycode, dev->keybit);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void msi_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	static struct key_entry *key;
+	union acpi_object *obj;
+	ktime_t cur;
+
+	wmi_get_event_data(value, &response);
+
+	obj = (union acpi_object *)response.pointer;
+
+	if (obj && obj->type == ACPI_TYPE_INTEGER) {
+		int eventcode = obj->integer.value;
+		dprintk("Eventcode: 0x%x\n", eventcode);
+		key = msi_wmi_get_entry_by_scancode(eventcode);
+		if (key) {
+			cur = ktime_get_real();
+			/* Ignore event if the same event happened in a 50 ms
+			   timeframe -> Key press may result in 10-20 GPEs */
+			if (ktime_to_us(ktime_sub(cur, key->last_pressed))
+			    < 1000 * 50) {
+				dprintk("Suppressed key event 0x%X - "
+					"Last press was %lld us ago\n",
+					 key->code,
+					 ktime_to_us(ktime_sub(cur,
+						       key->last_pressed)));
+				return;
+			}
+			key->last_pressed = cur;
+
+			switch (key->type) {
+			case KE_KEY:
+				/* Brightness is served via acpi video driver */
+				if (!backlight &&
+				    (key->keycode == KEY_BRIGHTNESSUP ||
+				     key->keycode == KEY_BRIGHTNESSDOWN))
+					break;
+
+				dprintk("Send key: 0x%X - "
+					"Input layer keycode: %d\n", key->code,
+					 key->keycode);
+				input_report_key(msi_wmi_input_dev,
+						 key->keycode, 1);
+				input_sync(msi_wmi_input_dev);
+				input_report_key(msi_wmi_input_dev,
+						 key->keycode, 0);
+				input_sync(msi_wmi_input_dev);
+				break;
+			}
+		} else
+			printk(KERN_INFO "Unknown key pressed - %x\n",
+			       eventcode);
+	} else
+		printk(KERN_INFO DRV_PFX "Unknown event received\n");
+	kfree(response.pointer);
+}
+
+static int __init msi_wmi_input_setup(void)
+{
+	struct key_entry *key;
+	int err;
+
+	msi_wmi_input_dev = input_allocate_device();
+
+	msi_wmi_input_dev->name = "MSI WMI hotkeys";
+	msi_wmi_input_dev->phys = "wmi/input0";
+	msi_wmi_input_dev->id.bustype = BUS_HOST;
+	msi_wmi_input_dev->getkeycode = msi_wmi_getkeycode;
+	msi_wmi_input_dev->setkeycode = msi_wmi_setkeycode;
+
+	for (key = msi_wmi_keymap; key->type != KE_END; key++) {
+		switch (key->type) {
+		case KE_KEY:
+			set_bit(EV_KEY, msi_wmi_input_dev->evbit);
+			set_bit(key->keycode, msi_wmi_input_dev->keybit);
+			break;
+		}
+	}
+
+	err = input_register_device(msi_wmi_input_dev);
+
+	if (err) {
+		input_free_device(msi_wmi_input_dev);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __init msi_wmi_init(void)
+{
+	int err;
+
+	if (wmi_has_guid(MSIWMI_EVENT_GUID)) {
+		err = wmi_install_notify_handler(MSIWMI_EVENT_GUID,
+						 msi_wmi_notify, NULL);
+		if (err)
+			return -EINVAL;
+
+		err = msi_wmi_input_setup();
+		if (err) {
+			wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
+			return -EINVAL;
+		}
+
+		if (!acpi_video_backlight_support()) {
+			backlight = backlight_device_register(DRV_NAME,
+					      NULL, NULL, &msi_backlight_ops);
+			if (IS_ERR(backlight)) {
+				wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
+				input_unregister_device(msi_wmi_input_dev);
+				return -EINVAL;
+			}
+
+			backlight->props.max_brightness = ARRAY_SIZE(backlight_map) - 1;
+			err = bl_get(NULL);
+			if (err < 0) {
+				wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
+				input_unregister_device(msi_wmi_input_dev);
+				backlight_device_unregister(backlight);
+				return -EINVAL;
+			}
+			backlight->props.brightness = err;
+		}
+	}
+	printk(KERN_INFO DRV_PFX "Event handler installed\n");
+	return 0;
+}
+
+static void __exit msi_wmi_exit(void)
+{
+	if (wmi_has_guid(MSIWMI_EVENT_GUID)) {
+		wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
+		input_unregister_device(msi_wmi_input_dev);
+		backlight_device_unregister(backlight);
+	}
+}
+
+module_init(msi_wmi_init);
+module_exit(msi_wmi_exit);
-- 
1.6.5.3

