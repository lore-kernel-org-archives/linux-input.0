From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: Re: [PATCH 1/4] Add acer wmi hotkey events support
Date: Thu, 25 Nov 2010 09:56:52 +0800
Message-ID: <1290650212-14944-1-git-send-email-jlee@novell.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: carlos@strangeworlds.co.uk
Cc: mjg59@srcf.ucam.org, corentin.chary@gmail.com, dmitry.torokhov@gmail.com, tiwai@novell.com, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, corentincj@iksaif.net, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

Add acer wmi hotkey event support. Install a wmi notify handler to
transfer wmi event key to key code, then send out keycode through acer
wmi input device to userland.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
Acked-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Thomas Renninger <trenn@suse.de>
Acked-by: Jiri Benc <jbenc@suse.cz> 
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Corentin Chary <corentincj@iksaif.net> 
---
 drivers/platform/x86/Kconfig    |    2 +
 drivers/platform/x86/acer-wmi.c |  139 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index cff7cc2..c242fdd 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -23,7 +23,9 @@ config ACER_WMI
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on SERIO_I8042
 	depends on RFKILL || RFKILL = n
+	depends on INPUT
 	select ACPI_WMI
+	select INPUT_SPARSEKMAP
 	---help---
 	  This is a driver for newer Acer (and Wistron) laptops. It adds
 	  wireless radio and bluetooth control, and on some laptops,
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 2badee2..930df56 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -37,6 +37,8 @@
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
 #include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 
 #include <acpi/acpi_drivers.h>
 
@@ -48,6 +50,7 @@ MODULE_LICENSE("GPL");
 #define ACER_ERR KERN_ERR ACER_LOGPREFIX
 #define ACER_NOTICE KERN_NOTICE ACER_LOGPREFIX
 #define ACER_INFO KERN_INFO ACER_LOGPREFIX
+#define ACER_WARNING KERN_WARNING ACER_LOGPREFIX
 
 /*
  * Magic Number
@@ -83,8 +86,39 @@ MODULE_LICENSE("GPL");
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
+static const struct key_entry acer_wmi_keymap[] = {
+	{KE_KEY, 0x01, {KEY_WLAN} },     /* WiFi */
+	{KE_KEY, 0x12, {KEY_BLUETOOTH} },	/* BT */
+	{KE_KEY, 0x21, {KEY_PROG1} },    /* Backup */
+	{KE_KEY, 0x22, {KEY_PROG2} },    /* Arcade */
+	{KE_KEY, 0x23, {KEY_PROG3} },    /* P_Key */
+	{KE_KEY, 0x24, {KEY_PROG4} },    /* Social networking_Key */
+	{KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} },	/* Display Switch */
+	{KE_KEY, 0x82, {KEY_F22} },      /* Touch Pad On/Off */
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
@@ -1085,6 +1119,99 @@ static ssize_t show_interface(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(interface, S_IRUGO, show_interface, NULL);
 
+static void acer_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
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
+		if (!sparse_keymap_report_event(acer_wmi_input_dev,
+				return_value.key_num, 1, true))
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
+	acpi_status status;
+	int err;
+
+	acer_wmi_input_dev = input_allocate_device();
+	if (!acer_wmi_input_dev)
+		return -ENOMEM;
+
+	acer_wmi_input_dev->name = "Acer WMI hotkeys";
+	acer_wmi_input_dev->phys = "wmi/input0";
+	acer_wmi_input_dev->id.bustype = BUS_HOST;
+
+	err = sparse_keymap_setup(acer_wmi_input_dev, acer_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
+
+	status = wmi_install_notify_handler(ACERWMID_EVENT_GUID,
+						acer_wmi_notify, NULL);
+	if (ACPI_FAILURE(status)) {
+		err = -EIO;
+		goto err_free_keymap;
+	}
+
+	err = input_register_device(acer_wmi_input_dev);
+	if (err)
+		goto err_uninstall_notifier;
+
+	return 0;
+
+err_uninstall_notifier:
+	wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
+err_free_keymap:
+	sparse_keymap_free(acer_wmi_input_dev);
+err_free_dev:
+	input_free_device(acer_wmi_input_dev);
+	return err;
+}
+
+static void acer_wmi_input_destroy(void)
+{
+	wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
+	sparse_keymap_free(acer_wmi_input_dev);
+	input_unregister_device(acer_wmi_input_dev);
+}
+
 /*
  * debugfs functions
  */
@@ -1327,6 +1454,12 @@ static int __init acer_wmi_init(void)
 		       "generic video driver\n");
 	}
 
+	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
+		err = acer_wmi_input_setup();
+		if (err)
+			return err;
+	}
+
 	err = platform_driver_register(&acer_platform_driver);
 	if (err) {
 		printk(ACER_ERR "Unable to register platform driver.\n");
@@ -1368,11 +1501,17 @@ error_device_add:
 error_device_alloc:
 	platform_driver_unregister(&acer_platform_driver);
 error_platform_register:
+	if (wmi_has_guid(ACERWMID_EVENT_GUID))
+		acer_wmi_input_destroy();
+
 	return err;
 }
 
 static void __exit acer_wmi_exit(void)
 {
+	if (wmi_has_guid(ACERWMID_EVENT_GUID))
+		acer_wmi_input_destroy();
+
 	remove_sysfs(acer_platform_device);
 	remove_debugfs();
 	platform_device_unregister(acer_platform_device);
-- 
1.6.0.2
