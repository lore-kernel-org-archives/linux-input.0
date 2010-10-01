From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 1/2] Add acer wmi hotkey events support
Date: Fri,  1 Oct 2010 21:51:27 +0800
Message-ID: <1285941088-31196-1-git-send-email-jlee@novell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33429 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab0JANzL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Oct 2010 09:55:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, tiwai@novell.com, trenn@novell.com, jbenc@suse.cz, "Lee, Chun-Yi" <jlee@novell.com>

Add acer wmi hotkey event support. Install a wmi notify handler to
transfer wmi event key to key code, then send out keycode through acer
wmi input device to userland.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/platform/x86/Kconfig    |    1 +
 drivers/platform/x86/acer-wmi.c |  213 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index cff7cc2..76cdf64 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -23,6 +23,7 @@ config ACER_WMI
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on SERIO_I8042
 	depends on RFKILL || RFKILL = n
+	depends on INPUT
 	select ACPI_WMI
 	---help---
 	  This is a driver for newer Acer (and Wistron) laptops. It adds
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 2badee2..79d2553 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -37,6 +37,7 @@
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
 #include <linux/slab.h>
+#include <linux/input.h>
 
 #include <acpi/acpi_drivers.h>
 
@@ -48,6 +49,7 @@ MODULE_LICENSE("GPL");
 #define ACER_ERR KERN_ERR ACER_LOGPREFIX
 #define ACER_NOTICE KERN_NOTICE ACER_LOGPREFIX
 #define ACER_INFO KERN_INFO ACER_LOGPREFIX
+#define ACER_WARNING KERN_WARNING ACER_LOGPREFIX
 
 /*
  * Magic Number
@@ -83,8 +85,47 @@ MODULE_LICENSE("GPL");
 #define WMID_GUID1		"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"
 #define WMID_GUID2		"95764E09-FB56-4e83-B31A-37761F60994A"
 
+/*
+ * Acer ACPI event GUIDs
+ */
+#define ACERWMID_EVENT_GUID "676AA15E-6A47-4D9F-A2CC-1E6D18D14026"
+
 MODULE_ALIAS("wmi:67C3371D-95A3-4C37-BB61-DD47B491DAAB");
 MODULE_ALIAS("wmi:6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3");
+MODULE_ALIAS("wmi:676AA15E-6A47-4D9F-A2CC-1E6D18D14026");
+
+enum acer_wmi_event_ids {
+	WMID_HOTKEY_EVENT = 0x1,
+};
+
+struct key_entry {
+	char type;	/* See KE_* below */
+	u16 code;
+	u16 keycode;
+};
+
+enum { KE_KEY, KE_END };
+
+static struct key_entry acer_wmi_keymap[] = {
+	{KE_KEY, 0x01, KEY_WLAN},	/* WiFi */
+	{KE_KEY, 0x12, KEY_BLUETOOTH},	/* BT */
+	{KE_KEY, 0x21, KEY_PROG1},	/* Backup */
+	{KE_KEY, 0x22, KEY_PROG2},	/* Aracade */
+	{KE_KEY, 0x23, KEY_PROG3},	/* P_Key */
+	{KE_KEY, 0x24, KEY_PROG4},	/* Social networking_Key */
+	{KE_KEY, 0x64, KEY_SWITCHVIDEOMODE},    /* Display Switch */
+	{KE_KEY, 0x82, KEY_F22},	/* Touch Pad On/Off */
+	{KE_END, 0}
+};
+
+static struct input_dev *acer_wmi_input_dev;
+
+struct event_return_value {
+	u8 function;
+	u8 key_num;
+	u16 device_state;
+	u32 reserved;
+} __attribute__((packed));
 
 /*
  * Interface capability flags
@@ -1085,6 +1126,156 @@ static ssize_t show_interface(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(interface, S_IRUGO, show_interface, NULL);
 
+static struct key_entry *acer_wmi_get_entry_by_scancode(unsigned int code)
+{
+	struct key_entry *key;
+
+	for (key = acer_wmi_keymap; key->type != KE_END; key++) {
+		if (code == key->code)
+			return key;
+	}
+
+	return NULL;
+}
+
+static struct key_entry *acer_wmi_get_entry_by_keycode(unsigned int keycode)
+{
+	struct key_entry *key;
+
+	for (key = acer_wmi_keymap; key->type != KE_END; key++)
+		if (key->type == KE_KEY && keycode == key->keycode)
+			return key;
+
+	return NULL;
+}
+
+static int acer_wmi_getkeycode(struct input_dev *dev,
+			unsigned int scancode, unsigned int *keycode)
+{
+	struct key_entry *key = acer_wmi_get_entry_by_scancode(scancode);
+
+	if (key && key->type == KE_KEY) {
+		*keycode = key->keycode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int acer_wmi_setkeycode(struct input_dev *dev,
+			unsigned int scancode, unsigned int keycode)
+{
+	struct key_entry *key;
+	unsigned int old_keycode;
+
+	key = acer_wmi_get_entry_by_scancode(scancode);
+	if (key && key->type == KE_KEY) {
+		old_keycode = key->keycode;
+		key->keycode = keycode;
+		set_bit(keycode, dev->keybit);
+		if (!acer_wmi_get_entry_by_keycode(old_keycode))
+			clear_bit(old_keycode, dev->keybit);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void acer_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	static struct key_entry *key;
+	union acpi_object *obj;
+	struct event_return_value return_value;
+	acpi_status status;
+
+	status = wmi_get_event_data(value, &response);
+	if (status != AE_OK) {
+		printk(ACER_WARNING "bad event status 0x%x\n", status);
+		return;
+	}
+
+	obj = (union acpi_object *)response.pointer;
+
+	if (!obj)
+		return;
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		printk(ACER_WARNING "Unknown response received %d\n",
+			obj->type);
+		kfree(obj);
+		return;
+	}
+	if (obj->buffer.length != 8) {
+		printk(ACER_WARNING "Unknown buffer length %d\n",
+			obj->buffer.length);
+		kfree(obj);
+		return;
+	}
+
+	return_value = *((struct event_return_value *)obj->buffer.pointer);
+	kfree(obj);
+
+	switch (return_value.function) {
+	case WMID_HOTKEY_EVENT:
+		key = acer_wmi_get_entry_by_scancode(return_value.key_num);
+		if (key) {
+			switch (key->type) {
+			case KE_KEY:
+				input_report_key(acer_wmi_input_dev,
+						key->keycode, 1);
+				input_sync(acer_wmi_input_dev);
+				input_report_key(acer_wmi_input_dev,
+						key->keycode, 0);
+				input_sync(acer_wmi_input_dev);
+				break;
+			}
+		} else
+			printk(ACER_WARNING "Unknown key number - 0x%x\n",
+				return_value.key_num);
+		break;
+	default:
+		printk(ACER_WARNING "Unknown function number - %d - %d\n",
+			return_value.function, return_value.key_num);
+		break;
+	}
+}
+
+static int __init acer_wmi_input_setup(void)
+{
+	struct key_entry *key;
+	int err;
+
+	acer_wmi_input_dev = input_allocate_device();
+	if (!acer_wmi_input_dev)
+		return -ENOMEM;
+
+	acer_wmi_input_dev->name = "Acer WMI hotkeys";
+	acer_wmi_input_dev->phys = "wmi/input0";
+	acer_wmi_input_dev->id.bustype = BUS_HOST;
+	acer_wmi_input_dev->getkeycode = acer_wmi_getkeycode;
+	acer_wmi_input_dev->setkeycode = acer_wmi_setkeycode;
+
+	for (key = acer_wmi_keymap; key->type != KE_END; key++) {
+		switch (key->type) {
+		case KE_KEY:
+			set_bit(EV_KEY, acer_wmi_input_dev->evbit);
+			set_bit(key->keycode, acer_wmi_input_dev->keybit);
+			break;
+		}
+	}
+
+	set_bit(EV_SW, acer_wmi_input_dev->evbit);
+
+	err = input_register_device(acer_wmi_input_dev);
+
+	if (err) {
+		input_free_device(acer_wmi_input_dev);
+		return err;
+	}
+
+	return 0;
+}
+
 /*
  * debugfs functions
  */
@@ -1327,6 +1518,18 @@ static int __init acer_wmi_init(void)
 		       "generic video driver\n");
 	}
 
+	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
+		err = wmi_install_notify_handler(ACERWMID_EVENT_GUID,
+						acer_wmi_notify, NULL);
+		if (ACPI_FAILURE(err))
+			return -EINVAL;
+		err = acer_wmi_input_setup();
+		if (err) {
+			wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
+			return err;
+		}
+	}
+
 	err = platform_driver_register(&acer_platform_driver);
 	if (err) {
 		printk(ACER_ERR "Unable to register platform driver.\n");
@@ -1368,11 +1571,21 @@ error_device_add:
 error_device_alloc:
 	platform_driver_unregister(&acer_platform_driver);
 error_platform_register:
+	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
+		input_unregister_device(acer_wmi_input_dev);
+		wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
+	}
+
 	return err;
 }
 
 static void __exit acer_wmi_exit(void)
 {
+	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
+		wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
+		input_unregister_device(acer_wmi_input_dev);
+	}
+
 	remove_sysfs(acer_platform_device);
 	remove_debugfs();
 	platform_device_unregister(acer_platform_device);
-- 
1.6.0.2

