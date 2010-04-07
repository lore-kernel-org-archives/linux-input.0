From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: [PATCH] eeepc-wmi: Add backlight support
Date: Wed, 7 Apr 2010 22:17:50 +0800
Message-ID: <20100407141750.GA16896@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:44029 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753431Ab0DGO1s (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Apr 2010 10:27:48 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, Richard Purdie <rpurdie@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

Add backlight support for WMI based Eee PC laptops. In addition, start
to use a platform device to manage all functional devices as more
features will be implemented later.

Signed-off-by: Yong Wang <yong.y.wang@intel.com>
--
 drivers/platform/x86/eeepc-wmi.c |  301 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 266 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/eeepc-wmi.c b/drivers/platform/x86/eeepc-wmi.c
index 9f88226..19438ea 100644
--- a/drivers/platform/x86/eeepc-wmi.c
+++ b/drivers/platform/x86/eeepc-wmi.c
@@ -30,6 +30,9 @@
 #include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+#include <linux/platform_device.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -38,6 +41,7 @@ MODULE_DESCRIPTION("Eee PC WMI Hotkey Driver");
 MODULE_LICENSE("GPL");
 
 #define EEEPC_WMI_EVENT_GUID	"ABBC0F72-8EA1-11D1-00A0-C90629100000"
+#define EEEPC_WMI_MGMT_GUID	"97845ED0-4E6D-11DE-8A39-0800200C9A66"
 
 MODULE_ALIAS("wmi:"EEEPC_WMI_EVENT_GUID);
 
@@ -46,6 +50,11 @@ MODULE_ALIAS("wmi:"EEEPC_WMI_EVENT_GUID);
 #define NOTIFY_BRNDOWN_MIN	0x20
 #define NOTIFY_BRNDOWN_MAX	0x2e
 
+#define EEEPC_WMI_METHODID_DEVS	0x53564544
+#define EEEPC_WMI_METHODID_DSTS	0x53544344
+
+#define EEEPC_WMI_DEVID_BACKLIGHT	0x00050012
+
 static const struct key_entry eeepc_wmi_keymap[] = {
 	/* Sleep already handled via generic ACPI code */
 	{ KE_KEY, 0x5d, { KEY_WLAN } },
@@ -58,7 +67,189 @@ static const struct key_entry eeepc_wmi_keymap[] = {
 	{ KE_END, 0},
 };
 
+struct bios_args {
+	u32	dev_id;
+	u32	ctrl_param;
+};
+
+static struct platform_device *eeepc_wmi_platform_device;
 static struct input_dev *eeepc_wmi_input_dev;
+struct backlight_device *eeepc_wmi_backlight_device;
+
+static int eeepc_wmi_input_init(void)
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
+	eeepc_wmi_input_dev->dev.parent = &eeepc_wmi_platform_device->dev;
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
+static void eeepc_wmi_input_exit(void)
+{
+	if (eeepc_wmi_input_dev) {
+		sparse_keymap_free(eeepc_wmi_input_dev);
+		input_unregister_device(eeepc_wmi_input_dev);
+	}
+
+	eeepc_wmi_input_dev = NULL;
+}
+
+static acpi_status eeepc_wmi_get_devstate(u32 dev_id, u32 *ctrl_param)
+{
+	struct acpi_buffer input = { (acpi_size)sizeof(u32), &dev_id };
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	u32 tmp;
+
+	status = wmi_evaluate_method(EEEPC_WMI_MGMT_GUID,
+			1, EEEPC_WMI_METHODID_DSTS, &input, &output);
+
+	if (ACPI_FAILURE(status))
+		return status;
+
+	obj = (union acpi_object *)output.pointer;
+	if (obj && obj->type == ACPI_TYPE_INTEGER) {
+		tmp = (u32)obj->integer.value;
+	} else {
+		tmp = 0;
+	}
+
+	if (ctrl_param)
+		*ctrl_param = tmp;
+
+	kfree(obj);
+
+	return status;
+
+}
+
+static acpi_status eeepc_wmi_set_devstate(u32 dev_id, u32 ctrl_param)
+{
+	struct bios_args args = {
+		.dev_id = dev_id,
+		.ctrl_param = ctrl_param,
+	};
+	struct acpi_buffer input = { (acpi_size)sizeof(args), &args };
+	acpi_status status;
+
+	status = wmi_evaluate_method(EEEPC_WMI_MGMT_GUID,
+			1, EEEPC_WMI_METHODID_DEVS, &input, NULL);
+
+	return status;
+}
+
+static int read_brightness(struct backlight_device *bd)
+{
+	static u32 ctrl_param;
+	acpi_status status;
+
+	status = eeepc_wmi_get_devstate(EEEPC_WMI_DEVID_BACKLIGHT, &ctrl_param);
+
+	if (ACPI_FAILURE(status)) {
+		return -1;
+	} else {
+		return (ctrl_param & 0x000000FF);
+	}
+}
+
+static int update_bl_status(struct backlight_device *bd)
+{
+
+	static u32 ctrl_param;
+	acpi_status status;
+
+	ctrl_param = bd->props.brightness;
+
+	status = eeepc_wmi_set_devstate(EEEPC_WMI_DEVID_BACKLIGHT, ctrl_param);
+
+	if (ACPI_FAILURE(status)) {
+		return -1;
+	} else {
+		return 0;
+	}
+}
+
+static struct backlight_ops eeepc_wmi_bl_ops = {
+	.get_brightness = read_brightness,
+	.update_status = update_bl_status,
+};
+
+static int eeepc_wmi_backlight_notify(bool increase)
+{
+	struct backlight_device *bd = eeepc_wmi_backlight_device;
+	int old = bd->props.brightness;
+	int new;
+
+	if (increase)
+		new = old + 1;
+	else
+		new = old - 1;
+
+	if (new > bd->props.max_brightness)
+		new = bd->props.max_brightness;
+	else if (new < 0)
+		new = 0;
+
+	bd->props.brightness = new;
+	backlight_update_status(bd);
+	backlight_force_update(bd, BACKLIGHT_UPDATE_HOTKEY);
+
+	return old;
+}
+
+static int eeepc_wmi_backlight_init(void)
+{
+	struct backlight_device *bd;
+
+	bd = backlight_device_register("eeepc-wmi",
+				       &eeepc_wmi_platform_device->dev, NULL,
+				       &eeepc_wmi_bl_ops);
+	if (IS_ERR(bd)) {
+		pr_err("EEEPC WMI:Could not register backlight device\n");
+		eeepc_wmi_backlight_device = NULL;
+		return PTR_ERR(bd);
+	}
+
+	eeepc_wmi_backlight_device = bd;
+
+	bd->props.brightness = read_brightness(bd);
+	bd->props.max_brightness = 15;
+	bd->props.power = FB_BLANK_UNBLANK;
+	backlight_update_status(bd);
+
+	return 0;
+}
+
+static void eeepc_wmi_backlight_exit(void)
+{
+	if (eeepc_wmi_backlight_device)
+		backlight_device_unregister(eeepc_wmi_backlight_device);
+
+	eeepc_wmi_backlight_device = NULL;
+}
 
 static void eeepc_wmi_notify(u32 value, void *context)
 {
@@ -83,6 +274,11 @@ static void eeepc_wmi_notify(u32 value, void *context)
 		else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
 			code = NOTIFY_BRNDOWN_MIN;
 
+		if (code == NOTIFY_BRNUP_MIN || code == NOTIFY_BRNDOWN_MIN) {
+			if (!acpi_video_backlight_support())
+				eeepc_wmi_backlight_notify(code == NOTIFY_BRNUP_MIN);
+		}
+
 		if (!sparse_keymap_report_event(eeepc_wmi_input_dev,
 						code, 1, true))
 			pr_info("EEEPC WMI: Unknown key %x pressed\n", code);
@@ -91,67 +287,102 @@ static void eeepc_wmi_notify(u32 value, void *context)
 	kfree(obj);
 }
 
-static int eeepc_wmi_input_setup(void)
+static int __devinit eeepc_wmi_platform_probe(struct platform_device *device)
 {
 	int err;
+	acpi_status status;
 
-	eeepc_wmi_input_dev = input_allocate_device();
-	if (!eeepc_wmi_input_dev)
-		return -ENOMEM;
-
-	eeepc_wmi_input_dev->name = "Eee PC WMI hotkeys";
-	eeepc_wmi_input_dev->phys = "wmi/input0";
-	eeepc_wmi_input_dev->id.bustype = BUS_HOST;
-
-	err = sparse_keymap_setup(eeepc_wmi_input_dev, eeepc_wmi_keymap, NULL);
+	err = eeepc_wmi_input_init();
 	if (err)
-		goto err_free_dev;
+		goto error_input;
 
-	err = input_register_device(eeepc_wmi_input_dev);
-	if (err)
-		goto err_free_keymap;
+	if (!acpi_video_backlight_support()) {
+		err = eeepc_wmi_backlight_init();
+		if (err)
+			goto error_backlight;
+	} else
+		pr_info("EEEPC WMI: Backlight controlled by ACPI video driver\n");
+
+	status = wmi_install_notify_handler(EEEPC_WMI_EVENT_GUID,
+					eeepc_wmi_notify, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_err("EEEPC WMI: Unable to register notify handler - %d\n",
+			status);
+		err = -ENODEV;
+		goto error_wmi;
+	}
 
 	return 0;
 
-err_free_keymap:
-	sparse_keymap_free(eeepc_wmi_input_dev);
-err_free_dev:
-	input_free_device(eeepc_wmi_input_dev);
+error_wmi:
+	eeepc_wmi_backlight_exit();
+error_backlight:
+	eeepc_wmi_input_exit();
+error_input:
 	return err;
 }
 
+static int __devexit eeepc_wmi_platform_remove(struct platform_device *device)
+{
+	wmi_remove_notify_handler(EEEPC_WMI_EVENT_GUID);
+	eeepc_wmi_backlight_exit();
+	eeepc_wmi_input_exit();
+
+	return 0;
+}
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		.name = "eeepc-wmi",
+		.owner = THIS_MODULE,
+	},
+	.probe = eeepc_wmi_platform_probe,
+	.remove = __devexit_p(eeepc_wmi_platform_remove),
+};
+
 static int __init eeepc_wmi_init(void)
 {
 	int err;
-	acpi_status status;
 
-	if (!wmi_has_guid(EEEPC_WMI_EVENT_GUID)) {
+	if (!wmi_has_guid(EEEPC_WMI_EVENT_GUID) || !wmi_has_guid(EEEPC_WMI_MGMT_GUID)) {
 		pr_warning("EEEPC WMI: No known WMI GUID found\n");
-		return -ENODEV;
+		err = -ENODEV;
+		goto out;
 	}
 
-	err = eeepc_wmi_input_setup();
-	if (err)
-		return err;
+	eeepc_wmi_platform_device = platform_device_alloc("eeepc-wmi", -1);
+	if (!eeepc_wmi_platform_device) {
+		pr_warning("EEEPC WMI: Unable to allocate platform device\n");
+		err = -ENOMEM;
+		goto out;
+	}
 
-	status = wmi_install_notify_handler(EEEPC_WMI_EVENT_GUID,
-					eeepc_wmi_notify, NULL);
-	if (ACPI_FAILURE(status)) {
-		sparse_keymap_free(eeepc_wmi_input_dev);
-		input_unregister_device(eeepc_wmi_input_dev);
-		pr_err("EEEPC WMI: Unable to register notify handler - %d\n",
-			status);
-		return -ENODEV;
+	err = platform_device_add(eeepc_wmi_platform_device);
+	if (err) {
+		pr_warning("EEEPC WMI: Unable to add platform device\n");
+		goto put_dev;
+	}
+
+	err = platform_driver_register(&platform_driver);
+	if (err) {
+		pr_warning("EEEPC WMI: Unable to register platform driver\n");
+		goto del_dev;
 	}
 
 	return 0;
+
+del_dev:
+	platform_device_del(eeepc_wmi_platform_device);
+put_dev:
+	platform_device_put(eeepc_wmi_platform_device);
+out:
+	return err;
 }
 
 static void __exit eeepc_wmi_exit(void)
 {
-	wmi_remove_notify_handler(EEEPC_WMI_EVENT_GUID);
-	sparse_keymap_free(eeepc_wmi_input_dev);
-	input_unregister_device(eeepc_wmi_input_dev);
+	platform_driver_unregister(&platform_driver);
+	platform_device_unregister(eeepc_wmi_platform_device);
 }
 
 module_init(eeepc_wmi_init);
