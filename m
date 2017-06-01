From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [WIP PATCH 3/4] ACPI: button: Let input filter out the LID events
Date: Thu,  1 Jun 2017 20:46:31 +0200
Message-ID: <20170601184632.2980-4-benjamin.tissoires@redhat.com>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

The input stack already filters out the LID events. So instead of
filtering them out at the source, we can hook up after the input
processing and propagate the lid switch events when the input stack
tells us to.

An other benefit is that if userspace (think libinput) "fixes" the lid
switch state by some heuristics, this new state is forwarded to the
listeners in the kernel.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/acpi/button.c | 156 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 139 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9ad7604..03e5981 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -109,8 +109,6 @@ struct acpi_button {
 	struct input_dev *input;
 	char phys[32];			/* for input device */
 	unsigned long pushed;
-	int last_state;
-	ktime_t last_time;
 	bool suspended;
 };
 
@@ -184,7 +182,6 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
 static int acpi_lid_notify_state(struct acpi_device *device, int state)
 {
 	struct acpi_button *button = acpi_driver_data(device);
-	int ret;
 
 	/* button_input_lock must be held */
 
@@ -205,20 +202,129 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 	if (state)
 		pm_wakeup_hard_event(&device->dev);
 
-	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
-	if (ret == NOTIFY_DONE)
-		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
-						   device);
-	if (ret == NOTIFY_DONE || ret == NOTIFY_OK) {
-		/*
-		 * It is also regarded as success if the notifier_chain
-		 * returns NOTIFY_OK or NOTIFY_DONE.
-		 */
-		ret = 0;
+	return 0;
+}
+
+/*
+ * Pass incoming event to all connected clients.
+ */
+static void acpi_button_lid_events(struct input_handle *handle,
+				   const struct input_value *vals,
+				   unsigned int count)
+{
+	const struct input_value *v;
+	int state = -1;
+	int ret;
+
+	for (v = vals; v != vals + count; v++) {
+		switch (v->type) {
+		case EV_SYN:
+			if (v->code == SYN_REPORT && state >= 0) {
+				ret = blocking_notifier_call_chain(&acpi_lid_notifier,
+								state,
+								lid_device);
+				if (ret == NOTIFY_DONE)
+					ret = blocking_notifier_call_chain(&acpi_lid_notifier,
+								state,
+								lid_device);
+				if (ret == NOTIFY_DONE || ret == NOTIFY_OK) {
+					/*
+					 * It is also regarded as success if
+					 * the notifier_chain returns NOTIFY_OK
+					 * or NOTIFY_DONE.
+					 */
+					ret = 0;
+				}
+			}
+			break;
+		case EV_SW:
+			if (v->code == SW_LID)
+				state = !v->value;
+			break;
+		}
 	}
-	return ret;
 }
 
+static int acpi_button_lid_connect(struct input_handler *handler,
+				   struct input_dev *dev,
+				   const struct input_device_id *id)
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
+	handle->name = "acpi-button-lid";
+
+	error = input_register_handle(handle);
+	if (error) {
+		dev_err(&lid_device->dev, "Error installing input handle\n");
+		goto err_free;
+	}
+
+	error = input_open_device(handle);
+	if (error) {
+		dev_err(&lid_device->dev, "Failed to open input device\n");
+		goto err_unregister;
+	}
+
+	return 0;
+
+ err_unregister:
+	input_unregister_handle(handle);
+ err_free:
+	kfree(handle);
+	return error;
+}
+
+static void acpi_button_lid_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+bool acpi_button_lid_match(struct input_handler *handler,
+			   struct input_dev *dev)
+{
+	struct acpi_button *button;
+
+	if (!lid_device)
+		return false;
+
+	button = acpi_driver_data(lid_device);
+
+	if (dev != button->input)
+		return false;
+
+	return true;
+}
+
+static const struct input_device_id acpi_button_lid_ids[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT_MASK(EV_SW) },
+		.swbit = { BIT_MASK(SW_LID) },
+	},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(input, acpi_button_lid_ids);
+
+static struct input_handler acpi_button_lid_handler = {
+	.match		= acpi_button_lid_match,
+	.connect	= acpi_button_lid_connect,
+	.disconnect	= acpi_button_lid_disconnect,
+	.events		= acpi_button_lid_events,
+	.name		= "acpi-lid-callchain",
+	.id_table	= acpi_button_lid_ids,
+};
+
+
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_device *device = seq->private;
@@ -581,8 +687,6 @@ static int acpi_button_add(struct acpi_device *device)
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
-		button->last_state = !!acpi_lid_evaluate_state(device);
-		button->last_time = ktime_get();
 	} else {
 		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
@@ -674,4 +778,22 @@ module_param_call(lid_init_state,
 		  NULL, 0644);
 MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
 
-module_acpi_driver(acpi_button_driver);
+static int __init acpi_button_init(void)
+{
+	int error;
+
+	error = input_register_handler(&acpi_button_lid_handler);
+	if (error)
+		return error;
+
+	return acpi_bus_register_driver(&acpi_button_driver);
+}
+
+static void __exit acpi_button_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_button_driver);
+	input_unregister_handler(&acpi_button_lid_handler);
+}
+
+module_init(acpi_button_init);
+module_exit(acpi_button_exit);
-- 
2.9.4
