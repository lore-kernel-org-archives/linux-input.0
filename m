From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: [PATCH v4] eeepc-wmi: new driver for WMI based hotkeys on Eee PC
	laptops
Date: Sun, 21 Mar 2010 10:26:34 +0800
Message-ID: <20100321022634.GA11553@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:25189 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752759Ab0CUCfe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 22:35:34 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

Changes since v3:
1. Call sparse_keymap_free before input_unregister_device

Changes since v2:
1. Define keymap as const
2. Check the return value of wmi_get_event_data
3. Mark brightness key events as KE_IGNORE
4. Replace printk with pr_ family functions
5. Add some missing calls to sparse_keymap_free

Changes since v1:
1. Use sparse keymap
2. Not send brightness input events
3. Fix memory leak of acpi_object
4. Set up input device before registering wmi notifier
5. Not return success if GUID is not found
6. Not check guid here in wmi_exit

---
    
Add a WMI driver for Eee PC laptops. Currently it only supports hotkeys.
    
Signed-off-by: Yong Wang <yong.y.wang@intel.com>
---
 drivers/platform/x86/Kconfig     |   10 +++
 drivers/platform/x86/Makefile    |    1
 drivers/platform/x86/eeepc-wmi.c |  157
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e631dbe..7bec458 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -385,6 +385,16 @@ config EEEPC_LAPTOP
 
 	  If you have an Eee PC laptop, say Y or M here.
 
+config EEEPC_WMI
+	tristate "Eee PC WMI Hotkey Driver (EXPERIMENTAL)"
+	depends on ACPI_WMI
+	depends on INPUT
+	depends on EXPERIMENTAL
+	---help---
+	  Say Y here if you want to support WMI-based hotkeys on Eee PC laptops.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called eeepc-wmi.
 
 config ACPI_WMI
 	tristate "WMI"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 9cd9fa0..a906490 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -4,6 +4,7 @@
 #
 obj-$(CONFIG_ASUS_LAPTOP)	+= asus-laptop.o
 obj-$(CONFIG_EEEPC_LAPTOP)	+= eeepc-laptop.o
+obj-$(CONFIG_EEEPC_WMI)		+= eeepc-wmi.o
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_ACPI_CMPC)		+= classmate-laptop.o
 obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
diff --git a/drivers/platform/x86/eeepc-wmi.c b/drivers/platform/x86/eeepc-wmi.c
new file mode 100644
index 0000000..2466b7b
--- /dev/null
+++ b/drivers/platform/x86/eeepc-wmi.c
@@ -0,0 +1,157 @@
+/*
+ * Eee PC WMI hotkey driver
+ *
+ * Copyright(C) 2010 Intel Corporation.
+ *
+ * Portions based on wistron_btns.c:
+ * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
+ * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
+ * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+
+MODULE_AUTHOR("Yong Wang <yong.y.wang@intel.com>");
+MODULE_DESCRIPTION("Eee PC WMI Hotkey Driver");
+MODULE_LICENSE("GPL");
+
+#define EEEPC_WMI_EVENT_GUID	"ABBC0F72-8EA1-11D1-00A0-C90629100000"
+
+MODULE_ALIAS("wmi:"EEEPC_WMI_EVENT_GUID);
+
+#define NOTIFY_BRNUP_MIN	0x11
+#define NOTIFY_BRNUP_MAX	0x1f
+#define NOTIFY_BRNDOWN_MIN	0x20
+#define NOTIFY_BRNDOWN_MAX	0x2e
+
+static const struct key_entry eeepc_wmi_keymap[] = {
+	/* Sleep already handled via generic ACPI code */
+	{ KE_KEY, 0x5d, { KEY_WLAN } },
+	{ KE_KEY, 0x32, { KEY_MUTE } },
+	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
+	{ KE_KEY, 0x30, { KEY_VOLUMEUP } },
+	{ KE_IGNORE, NOTIFY_BRNDOWN_MIN, { KEY_BRIGHTNESSDOWN } },
+	{ KE_IGNORE, NOTIFY_BRNUP_MIN, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0xcc, { KEY_SWITCHVIDEOMODE } },
+	{ KE_END, 0},
+};
+
+static struct input_dev *eeepc_wmi_input_dev;
+
+static void eeepc_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	int code;
+
+	status = wmi_get_event_data(value, &response);
+	if (status != AE_OK) {
+		pr_err("EEEPC WMI: bad event status 0x%x\n", status);
+		return;
+	}
+
+	obj = (union acpi_object *)response.pointer;
+
+	if (obj && obj->type == ACPI_TYPE_INTEGER) {
+		code = obj->integer.value;
+
+		if (code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNUP_MAX)
+			code = NOTIFY_BRNUP_MIN;
+		else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
+			code = NOTIFY_BRNDOWN_MIN;
+
+		if (!sparse_keymap_report_event(eeepc_wmi_input_dev,
+						code, 1, true))
+			pr_info("EEEPC WMI: Unknown key %x pressed\n", code);
+	}
+
+	kfree(obj);
+}
+
+static int eeepc_wmi_input_setup(void)
+{
+	int err;
+
+	eeepc_wmi_input_dev = input_allocate_device();
+	if (!eeepc_wmi_input_dev)
+		return -ENOMEM;
+
+	eeepc_wmi_input_dev->name = "Eee PC WMI hotkeys";
+	eeepc_wmi_input_dev->phys = "wmi/input0";
+	eeepc_wmi_input_dev->id.bustype = BUS_HOST;
+
+	err = sparse_keymap_setup(eeepc_wmi_input_dev, eeepc_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
+
+	err = input_register_device(eeepc_wmi_input_dev);
+	if (err)
+		goto err_free_keymap;
+
+	return 0;
+
+err_free_keymap:
+	sparse_keymap_free(eeepc_wmi_input_dev);
+err_free_dev:
+	input_free_device(eeepc_wmi_input_dev);
+	return err;
+}
+
+static int __init eeepc_wmi_init(void)
+{
+	int err;
+	acpi_status status;
+
+	if (!wmi_has_guid(EEEPC_WMI_EVENT_GUID)) {
+		pr_warning("EEEPC WMI: No known WMI GUID found\n");
+		return -ENODEV;
+	}
+
+	err = eeepc_wmi_input_setup();
+	if (err)
+		return err;
+
+	status = wmi_install_notify_handler(EEEPC_WMI_EVENT_GUID,
+					eeepc_wmi_notify, NULL);
+	if (ACPI_FAILURE(status)) {
+		sparse_keymap_free(eeepc_wmi_input_dev);
+		input_unregister_device(eeepc_wmi_input_dev);
+		pr_err("EEEPC WMI: Unable to register notify handler - %d\n",
+			status);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit eeepc_wmi_exit(void)
+{
+	wmi_remove_notify_handler(EEEPC_WMI_EVENT_GUID);
+	sparse_keymap_free(eeepc_wmi_input_dev);
+	input_unregister_device(eeepc_wmi_input_dev);
+}
+
+module_init(eeepc_wmi_init);
+module_exit(eeepc_wmi_exit);
