From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 1/2] ACPI / button: Add KEY_LID_CLOSE for new usage model
Date: Tue, 12 Jul 2016 18:17:03 +0800
Message-ID: <4537c34e4685658b0a12830499f971c7fc3c0426.1468318558.git.lv.zheng@intel.com>
References: <cover.1467717304.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1467717304.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There are many AML tables reporting wrong initial lid state, and some of
them never reports lid open state. As a proxy layer acting between, ACPI
button driver is not able to handle all such cases, but need to re-define
the usage model of the ACPI lid. That is:
1. It's initial state is not reliable;
2. There may not be an open event;
3. Userspace should only take action against the close event which is
   reliable, always sent after a real lid close.
This patch adds a new input key event so that the new userspace programs
can use it to handle this usage model correctly. And in the meanwhile, no
old programs will be broken by the userspace changes.
This patch also adds a button.lid_event_type parameter to allow the users
to switch between the 2 event types.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: linux-input@vger.kernel.org
---
 drivers/acpi/button.c                  |  109 +++++++++++++++++++++++++-------
 include/uapi/linux/input-event-codes.h |    6 ++
 2 files changed, 91 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 148f4e5..1298ef8 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -57,6 +57,9 @@
 #define ACPI_BUTTON_LID_INIT_OPEN	0x01
 #define ACPI_BUTTON_LID_INIT_METHOD	0x02
 
+#define ACPI_BUTTON_LID_EVENT_KEY	0x00
+#define ACPI_BUTTON_LID_EVENT_SWITCH	0x01
+
 #define _COMPONENT		ACPI_BUTTON_COMPONENT
 ACPI_MODULE_NAME("button");
 
@@ -110,6 +113,7 @@ struct acpi_button {
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
+static u8 lid_event_type = ACPI_BUTTON_LID_EVENT_SWITCH;
 
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
@@ -136,8 +140,17 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 	int ret;
 
 	/* input layer checks if event is redundant */
-	input_report_switch(button->input, SW_LID, !state);
-	input_sync(button->input);
+	if (lid_event_type == ACPI_BUTTON_LID_EVENT_SWITCH) {
+		input_report_switch(button->input, SW_LID, !state);
+		input_sync(button->input);
+	}
+	if (lid_event_type == ACPI_BUTTON_LID_EVENT_KEY &&
+	   !state) {
+		input_report_key(button->input, KEY_LID_CLOSE, 1);
+		input_sync(button->input);
+		input_report_key(button->input, KEY_LID_CLOSE, 0);
+		input_sync(button->input);
+	}
 
 	if (state)
 		pm_wakeup_event(&device->dev, 0);
@@ -292,6 +305,9 @@ static int acpi_lid_update_state(struct acpi_device *device)
 
 static void acpi_lid_initialize_state(struct acpi_device *device)
 {
+	if (lid_event_type == ACPI_BUTTON_LID_EVENT_KEY)
+		return;
+
 	switch (lid_init_state) {
 	case ACPI_BUTTON_LID_INIT_OPEN:
 		(void)acpi_lid_notify_state(device, 1);
@@ -436,6 +452,7 @@ static int acpi_button_add(struct acpi_device *device)
 
 	case ACPI_BUTTON_TYPE_LID:
 		input_set_capability(input, EV_SW, SW_LID);
+		input_set_capability(input, EV_KEY, KEY_LID_CLOSE);
 		break;
 	}
 
@@ -475,35 +492,49 @@ static int acpi_button_remove(struct acpi_device *device)
 
 static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
 {
-	int result = 0;
-
-	if (!strncmp(val, "open", sizeof("open") - 1)) {
-		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
-		pr_info("Notify initial lid state as open\n");
-	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
-		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
-		pr_info("Notify initial lid state with _LID return value\n");
-	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
-		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
-		pr_info("Do not notify initial lid state\n");
-	} else
-		result = -EINVAL;
+	int result = -EINVAL;
+
+	switch (lid_event_type) {
+	case ACPI_BUTTON_LID_EVENT_KEY:
+		if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
+			lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
+			pr_info("Do not notify initial lid state\n");
+		}
+		break;
+	case ACPI_BUTTON_LID_EVENT_SWITCH:
+		if (!strncmp(val, "open", sizeof("open") - 1)) {
+			lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
+			pr_info("Notify initial lid state as open\n");
+		} else if (!strncmp(val, "method", sizeof("method") - 1)) {
+			lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
+			pr_info("Notify initial lid state"
+				" with _LID return value\n");
+		} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
+			lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
+			pr_info("Do not notify initial lid state\n");
+		}
+		break;
+	}
 	return result;
 }
 
 static int param_get_lid_init_state(char *buffer, struct kernel_param *kp)
 {
-	switch (lid_init_state) {
-	case ACPI_BUTTON_LID_INIT_OPEN:
-		return sprintf(buffer, "open");
-	case ACPI_BUTTON_LID_INIT_METHOD:
-		return sprintf(buffer, "method");
-	case ACPI_BUTTON_LID_INIT_IGNORE:
+	switch (lid_event_type) {
+	case ACPI_BUTTON_LID_EVENT_KEY:
 		return sprintf(buffer, "ignore");
-	default:
-		return sprintf(buffer, "invalid");
+	case ACPI_BUTTON_LID_EVENT_SWITCH:
+		switch (lid_init_state) {
+		case ACPI_BUTTON_LID_INIT_OPEN:
+			return sprintf(buffer, "open");
+		case ACPI_BUTTON_LID_INIT_METHOD:
+			return sprintf(buffer, "method");
+		case ACPI_BUTTON_LID_INIT_IGNORE:
+			return sprintf(buffer, "ignore");
+		}
+		break;
 	}
-	return 0;
+	return sprintf(buffer, "invalid");
 }
 
 module_param_call(lid_init_state,
@@ -511,4 +542,34 @@ module_param_call(lid_init_state,
 		  NULL, 0644);
 MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
 
+static int param_set_lid_event_type(const char *val, struct kernel_param *kp)
+{
+	int result = -EINVAL;
+
+	if (!strncmp(val, "key", sizeof("key") - 1)) {
+		lid_event_type = ACPI_BUTTON_LID_EVENT_KEY;
+		pr_info("Notify lid state using key event\n");
+	} else if (!strncmp(val, "switch", sizeof("switch") - 1)) {
+		lid_event_type = ACPI_BUTTON_LID_EVENT_SWITCH;
+		pr_info("Notify lid state using switch event\n");
+	}
+	return result;
+}
+
+static int param_get_lid_event_type(char *buffer, struct kernel_param *kp)
+{
+	switch (lid_event_type) {
+	case ACPI_BUTTON_LID_EVENT_KEY:
+		return sprintf(buffer, "key");
+	case ACPI_BUTTON_LID_EVENT_SWITCH:
+		return sprintf(buffer, "switch");
+	}
+	return sprintf(buffer, "invalid");
+}
+
+module_param_call(lid_event_type,
+		  param_set_lid_event_type, param_get_lid_event_type,
+		  NULL, 0644);
+MODULE_PARM_DESC(lid_event_type, "Event type for reporting LID state");
+
 module_acpi_driver(acpi_button_driver);
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 737fa32..df7c0c0 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -641,6 +641,12 @@
  * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
  */
 #define KEY_DATA			0x275
+/*
+ * Special event sent by the lid drivers. The drivers may not be able to
+ * issue "open" event, in which case, they send KEY_LID_CLOSE instead of
+ * SW_LID.
+ */
+#define KEY_LID_CLOSE			0x278
 
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
-- 
1.7.10

