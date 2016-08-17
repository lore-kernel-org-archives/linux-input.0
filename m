From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v8 1/2] ACPI / button: Fix an issue in button.lid_init_state=ignore mode
Date: Wed, 17 Aug 2016 16:22:58 +0800
Message-ID: <ea5573a1cf2c6b9d647f2e5a3f20cb99dd85e4d0.1471422130.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On most platforms, _LID returning value, lid open/close events are all
reliable, but there are exceptions. Some AML tables report wrong initial
lid state (Link 1), and some of them never report lid open state (Link 2).
The usage model on such buggy platforms is:
1. The initial lid state returned from _LID is not reliable;
2. The lid open event is not reliable;
3. The lid close event is always reliable, used by the platform firmware to
   trigger OSPM power saving operations.
This usage model is not compliant to the Linux SW_LID model as the Linux
userspace is very strict to the reliability of the open events.

In order not to trigger issues on such buggy platforms, the ACPI button
driver currently implements a lid_init_state=open quirk to send additional
"open" event after resuming. However, this is still not sufficient because:
1. Some special usage models (e.x., the dark resume scenario) cannot be
   supported by this mode.
2. If a "close" event is not used to trigger "suspend", then the subsequent
   "close" events cannot be seen by the userspace.
So we need to stop sending the additional "open" event and switch the
driver to lid_init_state=ignore mode and make sure the platform triggered
events can be reliably delivered to the userspace. The userspace programs
then can be changed to not to be strict to the "open" events on such buggy
platforms.

Why will the subsequent "close" events be lost? This is because the input
layer automatically filters redundant events for switch events. Thus given
that the buggy AML tables do not guarantee paired "open"/"close" events,
the ACPI button driver currently is not able to guarantee that the platform
triggered reliable events can be always be seen by the userspace via
SW_LID.

This patch adds a mechanism to insert lid events as a compensation for the
platform triggered ones to form a complete event switches in order to make
sure that the platform triggered events can always be reliably delivered
to the userspace. This essentially guarantees that the platform triggered
reliable "close" events will always be relibly delivered to the userspace.

However this mechanism is not suitable for lid_init_state=open/method as
it should not send the complement switch event for the unreliable initial
lid state notification. 2 unreliable events can trigger unexpected
behavior. Thus this patch only implements this mechanism for
lid_init_state=ignore.

Known issues:
1. Possible alternative approach
   This approach is based on the fact that Linux requires a switch event
   type for LID events. Another approach is to use key event type to
   implement ACPI lid events.
   With SW event type, since ACPI button driver inserts wrong lid events,
   there could be a potential issue that an "open" event issued from some
   AML update methods could result in a wrong "close" event to be delivered
   to the userspace. While using KEY event type, there is no such problem.
   However there may not be such a kind of real case, and if there is such
   a case, it is worked around in this patch as the complement switch event
   is only generated for "close" event in order to deliver the reliable
   "close" event to the userspace.

Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=89211
        https://bugzilla.kernel.org/show_bug.cgi?id=106151
Link 2: https://bugzilla.kernel.org/show_bug.cgi?id=106941
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: linux-input@vger.kernel.org
---
 drivers/acpi/button.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 31abb0b..e19f530 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -19,6 +19,8 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#define pr_fmt(fmt) "ACPI : button: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -104,6 +106,8 @@ struct acpi_button {
 	struct input_dev *input;
 	char phys[32];			/* for input device */
 	unsigned long pushed;
+	int last_state;
+	ktime_t last_time;
 	bool suspended;
 };
 
@@ -111,6 +115,10 @@ static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
 
+static unsigned long lid_report_interval __read_mostly = 500;
+module_param(lid_report_interval, ulong, 0644);
+MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -134,10 +142,79 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 	int ret;
+	ktime_t next_report;
+	bool do_update;
+
+	/*
+	 * In lid_init_state=ignore mode, if user opens/closes lid
+	 * frequently with "open" missing, and "last_time" is also updated
+	 * frequently, "close" cannot be delivered to the userspace.
+	 * So "last_time" is only updated after a timeout or an actual
+	 * switch.
+	 */
+	if (lid_init_state != ACPI_BUTTON_LID_INIT_IGNORE ||
+	    button->last_state != !!state)
+		do_update = true;
+	else
+		do_update = false;
+
+	next_report = ktime_add(button->last_time,
+				ms_to_ktime(lid_report_interval));
+	if (button->last_state == !!state &&
+	    ktime_after(ktime_get(), next_report)) {
+		/* Complain the buggy firmware */
+		pr_warn_once("The lid device is not compliant to SW_LID.\n");
 
-	/* input layer checks if event is redundant */
-	input_report_switch(button->input, SW_LID, !state);
-	input_sync(button->input);
+		/*
+		 * Send the unreliable complement switch event:
+		 *
+		 * On most platforms, the lid device is reliable. However
+		 * there are exceptions:
+		 * 1. Platforms returning initial lid state as "close" by
+		 *    default after booting/resuming:
+		 *     https://bugzilla.kernel.org/show_bug.cgi?id=89211
+		 *     https://bugzilla.kernel.org/show_bug.cgi?id=106151
+		 * 2. Platforms never reporting "open" events:
+		 *     https://bugzilla.kernel.org/show_bug.cgi?id=106941
+		 * On these buggy platforms, the usage model of the ACPI
+		 * lid device actually is:
+		 * 1. The initial returning value of _LID may not be
+		 *    reliable.
+		 * 2. The open event may not be reliable.
+		 * 3. The close event is reliable.
+		 *
+		 * But SW_LID is typed as input switch event, the input
+		 * layer checks if the event is redundant. Hence if the
+		 * state is not switched, the userspace cannot see this
+		 * platform triggered reliable event. By inserting a
+		 * complement switch event, it then is guaranteed that the
+		 * platform triggered reliable one can always be seen by
+		 * the userspace.
+		 */
+		if (lid_init_state == ACPI_BUTTON_LID_INIT_IGNORE) {
+			do_update = true;
+			/*
+			 * Do generate complement switch event for "close"
+			 * as "close" is reliable and wrong "open" won't
+			 * trigger unexpected behaviors.
+			 * Do not generate complement switch event for
+			 * "open" as "open" is not reliable and wrong
+			 * "close" will trigger unexpected behaviors.
+			 */
+			if (!state) {
+				input_report_switch(button->input,
+						    SW_LID, state);
+				input_sync(button->input);
+			}
+		}
+	}
+	/* Send the platform triggered reliable event */
+	if (do_update) {
+		input_report_switch(button->input, SW_LID, !state);
+		input_sync(button->input);
+		button->last_state = !!state;
+		button->last_time = ktime_get();
+	}
 
 	if (state)
 		pm_wakeup_event(&device->dev, 0);
@@ -411,6 +488,8 @@ static int acpi_button_add(struct acpi_device *device)
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
+		button->last_state = !!acpi_lid_evaluate_state(device);
+		button->last_time = ktime_get();
 	} else {
 		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
-- 
1.7.10

