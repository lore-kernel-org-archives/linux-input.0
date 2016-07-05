From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/5] ACPI / button: Add SW_ACPI_LID for new usage model
Date: Tue,  5 Jul 2016 19:18:20 +0800
Message-ID: <6b1b121633175cec0a263b97e8e7a911f041c29e.1467717305.git.lv.zheng@intel.com>
References: <cover.1467717304.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1467717304.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Bastien Nocera:" <hadess@hadess.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There are many AML tables reporting wrong initial lid state, and some of
them never reports lid state. As a proxy layer acting between, ACPI button
driver is not able to handle all such cases, but need to re-define the
usage model of the ACPI lid. That is:
1. It's initial state is not reliable;
2. There may not be open event;
3. Userspace should only take action against the close event which is
   reliable, always sent after a real lid close.

Link: https://lkml.org/2016/3/7/460
Link: https://github.com/systemd/systemd/issues/2087
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org
---
 Documentation/acpi/acpi-lid.txt        |   42 ++++++++++++++++++++++++++++++++
 drivers/acpi/button.c                  |   20 ++++++++++-----
 include/linux/mod_devicetable.h        |    2 +-
 include/uapi/linux/input-event-codes.h |    3 ++-
 4 files changed, 59 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/acpi/acpi-lid.txt

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
new file mode 100644
index 0000000..cba200d
--- /dev/null
+++ b/Documentation/acpi/acpi-lid.txt
@@ -0,0 +1,42 @@
+Restrictions of ACPI Control Method LID Device
+
+1. Expections of _LID control method's returning value
+
+The _LID control method is described to return the "current" lid state.
+However the word of "current" has ambiguity, many BIOSen return the lid
+state upon the last lid notification instead of returning the lid state
+upon the last _LID evaluation. There won't be difference when the _LID
+control method is evaluated during the runtime, the problem is its initial
+returning value. When the BIOSen implement this control method with cached
+value, the initial returning value is likely not reliable. There are simply
+so many examples always retuning "close" as initial lid state.
+
+2. Expections on lid events
+
+There are many BIOSen tables never notifying the lid open event. But it is
+ensured that there is always lid close events reported when the lid is
+closed. This is normally used to trigger system power saving operations on
+Windows, thus it is fully tested and functions correctly.
+
+3. Linux ACPI Control Method LID Device Users
+
+The userspace should stop relying on /proc/acpi/button/lid/LID0/state to
+obtain the lid state. This file is only used for the testing purpose.
+
+New userspace should rely on the lid close event to trigger power saving
+operations and may stop taking actions according to the lid open event. A
+new input event SW_ACPI_LID is prepared for the new userspace to implement
+the ACPI control method lid device specific logics.
+
+During the period the userspace hasn't been switched to use the new
+SW_ACPI_LID event, Linux users can use the following boot parameter to
+handle possible issues:
+  button.lid_init_state=method:
+   This is the default behavior, Linux kernel reports initial lid state
+   using _LID control method's returning value.
+   This may fixes some platforms if the _LID control method's returning
+   value is reliable.
+  button.lid_init_state=open:
+   Linux kernel always reports an initial lid state as "open".
+   This may fixes some platforms if the _LID control method's returning
+   value is not reliable.
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 148f4e5..4ef94d2 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -130,7 +130,8 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
 	return lid_state ? 1 : 0;
 }
 
-static int acpi_lid_notify_state(struct acpi_device *device, int state)
+static int acpi_lid_notify_state(struct acpi_device *device,
+				 int state, bool notify_acpi)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 	int ret;
@@ -138,6 +139,11 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 	/* input layer checks if event is redundant */
 	input_report_switch(button->input, SW_LID, !state);
 	input_sync(button->input);
+	if (notify_acpi) {
+		input_report_switch(button->input,
+				    SW_ACPI_LID, !state);
+		input_sync(button->input);
+	}
 
 	if (state)
 		pm_wakeup_event(&device->dev, 0);
@@ -279,7 +285,8 @@ int acpi_lid_open(void)
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
-static int acpi_lid_update_state(struct acpi_device *device)
+static int acpi_lid_update_state(struct acpi_device *device,
+				 bool notify_acpi)
 {
 	int state;
 
@@ -287,17 +294,17 @@ static int acpi_lid_update_state(struct acpi_device *device)
 	if (state < 0)
 		return state;
 
-	return acpi_lid_notify_state(device, state);
+	return acpi_lid_notify_state(device, state, notify_acpi);
 }
 
 static void acpi_lid_initialize_state(struct acpi_device *device)
 {
 	switch (lid_init_state) {
 	case ACPI_BUTTON_LID_INIT_OPEN:
-		(void)acpi_lid_notify_state(device, 1);
+		(void)acpi_lid_notify_state(device, 1, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(device);
+		(void)acpi_lid_update_state(device, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
@@ -317,7 +324,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
-			acpi_lid_update_state(device);
+			acpi_lid_update_state(device, true);
 		} else {
 			int keycode;
 
@@ -436,6 +443,7 @@ static int acpi_button_add(struct acpi_device *device)
 
 	case ACPI_BUTTON_TYPE_LID:
 		input_set_capability(input, EV_SW, SW_LID);
+		input_set_capability(input, EV_SW, SW_ACPI_LID);
 		break;
 	}
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 6e4c645..1014968 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -291,7 +291,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
-#define INPUT_DEVICE_ID_SW_MAX		0x0f
+#define INPUT_DEVICE_ID_SW_MAX		0x10
 
 #define INPUT_DEVICE_ID_MATCH_BUS	1
 #define INPUT_DEVICE_ID_MATCH_VENDOR	2
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 737fa32..81c344c 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -780,7 +780,8 @@
 #define SW_ROTATE_LOCK		0x0c  /* set = rotate locked/disabled */
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
 #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
-#define SW_MAX			0x0f
+#define SW_ACPI_LID		0x0f  /* set = lid shut */
+#define SW_MAX			0x10
 #define SW_CNT			(SW_MAX+1)
 
 /*
-- 
1.7.10
