From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH] HID: asus: only support backlight when it's not driven by WMI
Date: Mon,  8 Jan 2018 19:20:42 -0600
Message-ID: <20180109012042.13947-1-drake@endlessm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42185 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934072AbeAIBUq (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 Jan 2018 20:20:46 -0500
Received: by mail-oi0-f67.google.com with SMTP id o64so9430056oia.9
        for <linux-input@vger.kernel.org>; Mon, 08 Jan 2018 17:20:46 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux@endlessm.com, carlo@endlessm.com, corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

The Asus GL502VSK has the same 0B05:1837 keyboard as we've seen in
several Republic of Gamers laptops.

However, in this model, the keybard backlight control exposed by hid-asus
has no effect on the keyboard backlight. Instead, the keyboard
backlight is correctly driven by asus-wmi.

With two keyboard backlight devices available (and only the acer-wmi
one working), GNOME is picking the wrong one to drive in the UI.

Avoid this problem by not creating the backlight interface when we
detect a WMI-driven keyboard backlight.

We have also tested Asus GL702VMK which does have the hid-asus
backlight present, and it still works fine with this patch (WMI method
call returns UNSUPPORTED_METHOD).

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/hid/Kconfig    |  1 +
 drivers/hid/hid-asus.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 779c5ae47f36..6d95abc9d8a1 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -149,6 +149,7 @@ config HID_APPLEIR
 config HID_ASUS
 	tristate "Asus"
 	depends on LEDS_CLASS
+	depends on ACPI_WMI
 	---help---
 	Support for Asus notebook built-in keyboard and touchpad via i2c, and
 	the Asus Republic of Gamers laptop keyboard special keys.
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 1bb7b63b3150..e6830946b4a4 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -26,6 +26,7 @@
  * any later version.
  */
 
+#include <linux/acpi.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/input/mt.h>
@@ -78,6 +79,12 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
 
+#define ASUS_WMI_MGMT_GUID		"97845ED0-4E6D-11DE-8A39-0800200C9A66"
+#define ASUS_WMI_METHODID_DSTS2		0x53545344 /* Device STatuS #2*/
+#define ASUS_WMI_DEVID_KBD_BACKLIGHT	0x00050021
+#define ASUS_WMI_UNSUPPORTED_METHOD	0xFFFFFFFE
+#define ASUS_WMI_DSTS_PRESENCE_BIT	0x00010000
+
 struct asus_kbd_leds {
 	struct led_classdev cdev;
 	struct hid_device *hdev;
@@ -330,6 +337,48 @@ static void asus_kbd_backlight_work(struct work_struct *work)
 		hid_err(led->hdev, "Asus failed to set keyboard backlight: %d\n", ret);
 }
 
+/* WMI-based keyboard backlight LED control (via asus-wmi driver) takes
+ * precedence. We only activate HID-based backlight control when the
+ * WMI control is not available.
+ */
+static bool asus_kbd_wmi_led_control_present(struct hid_device *hdev)
+{
+	u32 args[] = { ASUS_WMI_DEVID_KBD_BACKLIGHT, 0 };
+	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
+	union acpi_object *obj;
+	u32 value;
+
+	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0,
+				     ASUS_WMI_METHODID_DSTS2,
+				     &input, &output);
+
+	if (ACPI_FAILURE(status)) {
+		hid_dbg(hdev, "WMI backlight method failed: %d", status);
+		return false;
+	}
+
+	obj = (union acpi_object *)output.pointer;
+	if (!obj || obj->type != ACPI_TYPE_INTEGER) {
+		hid_dbg(hdev, "WMI backlight method unexpected return type");
+		kfree(obj);
+		return false;
+	}
+
+	value = (u32) obj->integer.value;
+	kfree(obj);
+
+	hid_dbg(hdev, "WMI backlight check: method returned %x", value);
+
+	if (value == ASUS_WMI_UNSUPPORTED_METHOD) {
+		hid_dbg(hdev, "WMI backlight method unsupported");
+		return false;
+	}
+
+	return !!(value & ASUS_WMI_DSTS_PRESENCE_BIT);
+}
+
 static int asus_kbd_register_leds(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -417,7 +466,9 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 
 	drvdata->input = input;
 
-	if (drvdata->enable_backlight && asus_kbd_register_leds(hdev))
+	if (drvdata->enable_backlight &&
+	    !asus_kbd_wmi_led_control_present(hdev) &&
+	    asus_kbd_register_leds(hdev))
 		hid_warn(hdev, "Failed to initialize backlight.\n");
 
 	return 0;
-- 
2.14.1

