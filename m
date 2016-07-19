From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 1/2] ACPI / button: Add KEY_LID_OPEN/KEY_LID_CLOSE for new usage model
Date: Tue, 19 Jul 2016 16:11:02 +0800
Message-ID: <1b96ee1e5b5ebbed0096adde410a9fd0b7930848.1468915808.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There are many AML tables reporting wrong initial lid state, and some of
them never report lid open state. As a proxy layer acting between, ACPI
button driver is not able to handle all such cases, but need to re-define
the usage model of the ACPI lid. That is:
1. It's initial state is not reliable;
2. There may not be an open event;
3. Userspace should only take action against the close event which is
   reliable, always sent after a real lid close.

OTOH, using an input switch event for the lid device on such platforms can
cause the loss of the close event, but the platforms purposely want to use
these close events to trigger power saving actions.

So we need to introduce a new ABI, which is input key events based, not
input switch events based.

This patch adds a set of new input key events so that the new userspace
programs can use them to handle this usage model correctly. And in the
meanwhile, the old input switch event is kept so that no old programs will
be broken by the ABI change.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: linux-input@vger.kernel.org
---
 drivers/acpi/button.c                  |   34 +++++++++++++++++++++++++++++++-
 include/uapi/linux/input-event-codes.h |    7 +++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 148f4e5..dd16879 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -104,6 +104,8 @@ struct acpi_button {
 	struct input_dev *input;
 	char phys[32];			/* for input device */
 	unsigned long pushed;
+	int last_state;
+	unsigned long timestamp;
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
@@ -133,12 +139,34 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
 static int acpi_lid_notify_state(struct acpi_device *device, int state)
 {
 	struct acpi_button *button = acpi_driver_data(device);
+	int keycode;
+	unsigned long timeout;
 	int ret;
 
-	/* input layer checks if event is redundant */
+	/*
+	 * Send the switch event.
+	 * The input layer checks if the event is redundant.
+	 */
 	input_report_switch(button->input, SW_LID, !state);
 	input_sync(button->input);
 
+	/*
+	 * Send the key event.
+	 * The input layer doesn't check if the event is redundant.
+	 */
+	timeout = button->timestamp +
+		  msecs_to_jiffies(lid_report_interval);
+	if (button->last_state != !!state ||
+	    time_after(jiffies, timeout)) {
+		keycode = state ? KEY_LID_OPEN : KEY_LID_CLOSE;
+		input_report_key(button->input, keycode, 1);
+		input_sync(button->input);
+		input_report_key(button->input, keycode, 0);
+		input_sync(button->input);
+		button->last_state = !!state;
+		button->timestamp = jiffies;
+	}
+
 	if (state)
 		pm_wakeup_event(&device->dev, 0);
 
@@ -407,6 +435,8 @@ static int acpi_button_add(struct acpi_device *device)
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
+		button->last_state = !!acpi_lid_evaluate_state(device);
+		button->timestamp = jiffies;
 	} else {
 		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
@@ -436,6 +466,8 @@ static int acpi_button_add(struct acpi_device *device)
 
 	case ACPI_BUTTON_TYPE_LID:
 		input_set_capability(input, EV_SW, SW_LID);
+		input_set_capability(input, EV_KEY, KEY_LID_OPEN);
+		input_set_capability(input, EV_KEY, KEY_LID_CLOSE);
 		break;
 	}
 
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 737fa32..b062fe1 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -641,6 +641,13 @@
  * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
  */
 #define KEY_DATA			0x275
+/*
+ * Key events sent by the lid drivers.
+ * The drivers may not be able to send paired "open"/"close" events, in
+ * which case, they send KEY_LID_OPEN/KEY_LID_CLOSE instead of SW_LID.
+ */
+#define KEY_LID_OPEN			0x278
+#define KEY_LID_CLOSE			0x279
 
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
-- 
1.7.10

