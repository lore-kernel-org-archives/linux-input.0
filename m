From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v6] ACPI / button: Fix an issue that the platform triggered "close" event may not be delivered to the userspace
Date: Mon, 25 Jul 2016 09:14:09 +0800
Message-ID: <406eadafbc6e4e7a307ec9af7eed11c46cae7ad8.1469409047.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There are many AML tables reporting wrong initial lid state (Link 1), and
some of them never report lid open state (Link 2). Thus, the usage model of
the ACPI control method lid device is:
1. The initial lid state returned from _LID is not reliable;
2. The lid open event is not reliable;
3. The lid close event is always reliable, used by the platform firmware to
   trigger OSPM power saving operations.

Then we can see an issue in the current ACPI button driver. When the
initial lid state is "close" and the platform never reports "open", we can
see that the userspace could only recieve "close" once. And all follow-up
"close" events can never trigger OSPM power saving operations. This is
because of the type of the lid events. The SW_LID is a switch event, only
the switched value will be delivered to the userspace. When the value never
switches, nothing can be seen by the userspace.

Currently ACPI button driver implements a lid_init_state=open quirk to send
additional "open" after resuming in order to avoid another issue that the
system may be suspended right after resuming because the userspace programs
have strict requirement of the "open" event. However, this breaks some
usage model (e.x., the dark resume scenario). So we need to stop sending
the additional "open" event and switch the driver to lid_init_state=ignore
mode. The userspace programs should also be changed to stop being strict to
the "open" event. This is the preferred mode for the Linux ACPI button
driver and the userspace programs to work together on such buggy platforms.

However, we can see that, without fixing the issue mentioned in the 2nd
paragraph, subsequent platform triggered "close" events cannot be delivered
to the userspace and the power saving operations can not be triggered. So
we need to fix the issue before the userspace changes its behavior.

This patch adds a mechanism to insert lid events as a compensation for the
platform triggered ones to form a complete event switches in order to make
the "close" switch events always reliable.

Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=89211
        https://bugzilla.kernel.org/show_bug.cgi?id=106151
Link 2: https://bugzilla.kernel.org/show_bug.cgi?id=106941
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: linux-input@vger.kernel.org
---
 drivers/acpi/button.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 148f4e5..7e2a9eb 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -104,6 +104,8 @@ struct acpi_button {
 	struct input_dev *input;
 	char phys[32];			/* for input device */
 	unsigned long pushed;
+	int last_state;
+	unsigned long last_time;
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
+	unsigned long timeout;
 	int ret;
 
-	/* input layer checks if event is redundant */
+	/* Send the switch event */
+	timeout = button->last_time +
+		  msecs_to_jiffies(lid_report_interval);
+	if (time_after(jiffies, timeout) &&
+	    (button->last_state == !!state)) {
+		/* Send the complement switch event */
+		input_report_switch(button->input, SW_LID, state);
+		input_sync(button->input);
+	}
 	input_report_switch(button->input, SW_LID, !state);
 	input_sync(button->input);
+	button->last_state = !!state;
+	button->last_time = jiffies;
 
 	if (state)
 		pm_wakeup_event(&device->dev, 0);
@@ -407,6 +424,8 @@ static int acpi_button_add(struct acpi_device *device)
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
+		button->last_state = !!acpi_lid_evaluate_state(device);
+		button->last_time = jiffies;
 	} else {
 		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
-- 
1.7.10
