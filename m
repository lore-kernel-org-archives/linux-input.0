From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5 1/3] ACPI / button: Add missing event to keep SW_LID running without additional event loss
Date: Fri, 22 Jul 2016 14:24:42 +0800
Message-ID: <0d28076e25047db356eeedbb2d8ae204f0ec893d.1469168549.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There are several possibilities that a lid event can be lost. For example,
EC event queue full, or the resume order of the underlying drivers.

When the event loss happens, new event may also be lost due to the type of
the SW_LID (switch event). The 2nd loss is what we want to avoid.

This patch adds a mechanism to insert lid events as a compensation for the
switch event nature of the lid events in order to avoid the 2nd loss.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: linux-input@vger.kernel.org
---
 drivers/acpi/button.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 148f4e5..41fd21d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -104,6 +104,8 @@ struct acpi_button {
 	struct input_dev *input;
 	char phys[32];			/* for input device */
 	unsigned long pushed;
+	int sw_last_state;
+	unsigned long sw_last_time;
 	bool suspended;
 };
 
@@ -111,6 +113,10 @@ static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
 
+static unsigned long lid_report_interval __read_mostly = 500;
+module_param(lid_report_interval, ulong, 0644);
+MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -133,11 +139,22 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
 static int acpi_lid_notify_state(struct acpi_device *device, int state)
 {
 	struct acpi_button *button = acpi_driver_data(device);
+	unsigned long sw_tout;
 	int ret;
 
-	/* input layer checks if event is redundant */
+	/* Send the switch event */
+	sw_tout = button->sw_last_time +
+		  msecs_to_jiffies(lid_report_interval);
+	if (time_after(jiffies, sw_tout) &&
+	    (button->sw_last_state == !!state)) {
+		/* Send the complement switch event */
+		input_report_switch(button->input, SW_LID, state);
+		input_sync(button->input);
+	}
 	input_report_switch(button->input, SW_LID, !state);
 	input_sync(button->input);
+	button->sw_last_state = !!state;
+	button->sw_last_time = jiffies;
 
 	if (state)
 		pm_wakeup_event(&device->dev, 0);
@@ -407,6 +424,8 @@ static int acpi_button_add(struct acpi_device *device)
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
+		button->sw_last_state = !!acpi_lid_evaluate_state(device);
+		button->sw_last_time = jiffies;
 	} else {
 		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
-- 
1.7.10
