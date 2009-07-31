From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/2] dell-laptop: Trigger rfkill updates on wifi toggle switch press
Date: Fri, 31 Jul 2009 03:26:47 +0100
Message-ID: <1249007207-27392-2-git-send-email-mjg@redhat.com>
References: <1249007207-27392-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1249007207-27392-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Matthew Garrett <mjg@redhat.com>
List-Id: linux-input@vger.kernel.org

Dell hardware sends the rfkill hardware killswitch event via the keyboard
controller, even if it's a physical toggle switch on the side of the
machine. Add support for catching the input event and updating the rfkill
state, allowing userspace to receive notifications that the change has
occurred.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/platform/x86/dell-laptop.c |  100 ++++++++++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 74909c4..71a4149 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -22,6 +22,7 @@
 #include <linux/rfkill.h>
 #include <linux/power_supply.h>
 #include <linux/acpi.h>
+#include <linux/input.h>
 #include "../../firmware/dcdbas.h"
 
 #define BRIGHTNESS_TOKEN 0x7d
@@ -206,6 +207,16 @@ static const struct rfkill_ops dell_rfkill_ops = {
 	.query = dell_rfkill_query,
 };
 
+static void dell_rfkill_update(void)
+{
+	if (wifi_rfkill)
+		dell_rfkill_query(wifi_rfkill, (void *)1);
+	if (bluetooth_rfkill)
+		dell_rfkill_query(bluetooth_rfkill, (void *)2);
+	if (wwan_rfkill)
+		dell_rfkill_query(wwan_rfkill, (void *)3);
+}
+
 static int dell_setup_rfkill(void)
 {
 	struct calling_interface_buffer buffer;
@@ -310,6 +321,90 @@ static struct backlight_ops dell_ops = {
 	.update_status  = dell_send_intensity,
 };
 
+static const struct input_device_id dell_input_ids[] = {
+	{
+		.bustype = 0x11,
+		.vendor = 0x01,
+		.product = 0x01,
+		.version = 0xab41,
+		.flags = INPUT_DEVICE_ID_MATCH_BUS |
+			 INPUT_DEVICE_ID_MATCH_VENDOR |
+			 INPUT_DEVICE_ID_MATCH_PRODUCT |
+			 INPUT_DEVICE_ID_MATCH_VERSION
+	},
+	{ },
+};
+
+static bool dell_input_filter(struct input_handle *handle, unsigned int type,
+			     unsigned int code, int value)
+{
+	if (type == EV_KEY && code == KEY_WLAN && value == 1) {
+		dell_rfkill_update();
+		return 1;
+	}
+
+	return 0;
+}
+
+static void dell_input_event(struct input_handle *handle, unsigned int type,
+			     unsigned int code, int value)
+{
+}
+
+static int dell_input_connect(struct input_handler *handler,
+			      struct input_dev *dev,
+			      const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int error;
+
+	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = "dell-laptop";
+
+	error = input_register_handle(handle);
+	if (error)
+		goto err_free_handle;
+
+	error = input_open_device(handle);
+	if (error)
+		goto err_unregister_handle;
+
+	error = input_filter_device(handle);
+	if (error)
+		goto err_close_handle;
+
+	return 0;
+
+err_close_handle:
+	input_close_device(handle);
+err_unregister_handle:
+	input_unregister_handle(handle);
+err_free_handle:
+	kfree(handle);
+	return error;
+}
+
+static void dell_input_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static struct input_handler dell_input_handler = {
+	.name = "dell-laptop",
+	.filter = dell_input_filter,
+	.event = dell_input_event,
+	.connect = dell_input_connect,
+	.disconnect = dell_input_disconnect,
+	.id_table = dell_input_ids,
+};
+
 static int __init dell_init(void)
 {
 	struct calling_interface_buffer buffer;
@@ -333,6 +428,10 @@ static int __init dell_init(void)
 		goto out;
 	}
 
+	if (input_register_handler(&dell_input_handler))
+		printk(KERN_INFO
+		       "dell-laptop: Could not register input filter\n");
+
 #ifdef CONFIG_ACPI
 	/* In the event of an ACPI backlight being available, don't
 	 * register the platform controller.
@@ -388,6 +487,7 @@ static void __exit dell_exit(void)
 		rfkill_unregister(bluetooth_rfkill);
 	if (wwan_rfkill)
 		rfkill_unregister(wwan_rfkill);
+	input_unregister_handler(&dell_input_handler);
 }
 
 module_init(dell_init);
-- 
1.6.2.5

