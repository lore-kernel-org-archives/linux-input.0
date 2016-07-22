From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5 2/3] ACPI / button: Add KEY_LID_OPEN/KEY_LID_CLOSE for new usage model
Date: Fri, 22 Jul 2016 14:24:52 +0800
Message-ID: <d216a62818e17f320130332ad0b75cf70722ffdd.1469168549.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There are many AML tables reporting wrong initial lid state (Link 1), and
some of them never report lid open state (Link 2). For example, lid
notifications on Surface 3 are as follows (no open event):
    Method (_E4C, 0, Serialized)
    {
        If (LEqual(HELD, One))
        {
            Store(One, ^^LID.LIDB)
        }
        Else
        {
            Store(Zero, ^^LID.LIDB)
            Notify (LID, 0x80)
        }
    }
For the first issue, we can work it around via reporting forced initial
"open" state (however, it is apparently still not reliable) and sending
complement switch events.
For the second issue, it is totally a different usage model than the switch
event type because the switch event type requires the driver to send paired
events while the events is naturally not paired on this platform. There is
only one case that the lid driver can help to make a paired events on such
platforms: if the "lid close" is used to trigger system pending, then the
driver can report a forced "lid open" via resume callback. But if "lid
close" is not used to trigger system suspending, then the lid driver can
never have a chance to make the events paired. And an even worse thing is
the forced value breaks some use cases (e.x., dark resume).

As a proxy layer acting between, ACPI button driver is not able to handle
all such platform designed cases via Linux input switch events, but need to
re-define the usage model of the ACPI lid. That is:
1. It's initial state is not reliable;
2. There may not be an open event;
3. Userspace should only take action against the close event which is
   reliable, always sent after a real lid close.

So we need to introduce a new ABI, which is input key events based, not
input switch events based. And this usage model could help to ensure a
reliable lid state during runtime. Adopting with this usage model, the
platform firmware has been facilitated to have the maximum possibilities to
force the hosting OS to behave as what they want.

This patch adds a set of new input key events so that the new userspace
programs can use them to handle this usage model correctly. And in the
meanwhile, the old input switch event is kept so that no old programs will
be broken by the ABI change.

Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=89211
        https://bugzilla.kernel.org/show_bug.cgi?id=106151
Link 2: https://bugzilla.kernel.org/show_bug.cgi?id=106941
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: linux-input@vger.kernel.org
---
 drivers/acpi/button.c                  |   26 +++++++++++++++++++++++---
 include/uapi/linux/input-event-codes.h |    7 +++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 41fd21d..c5fd793 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -106,6 +106,8 @@ struct acpi_button {
 	unsigned long pushed;
 	int sw_last_state;
 	unsigned long sw_last_time;
+	int key_last_state;
+	unsigned long key_last_time;
 	bool suspended;
 };
 
@@ -139,7 +141,8 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
 static int acpi_lid_notify_state(struct acpi_device *device, int state)
 {
 	struct acpi_button *button = acpi_driver_data(device);
-	unsigned long sw_tout;
+	int keycode;
+	unsigned long sw_tout, key_tout;
 	int ret;
 
 	/* Send the switch event */
@@ -156,6 +159,20 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 	button->sw_last_state = !!state;
 	button->sw_last_time = jiffies;
 
+	/* Send the key event */
+	key_tout = button->key_last_time +
+		   msecs_to_jiffies(lid_report_interval);
+	if (time_after(jiffies, key_tout) ||
+	    (button->key_last_state != !!state)) {
+		keycode = state ? KEY_LID_OPEN : KEY_LID_CLOSE;
+		input_report_key(button->input, keycode, 1);
+		input_sync(button->input);
+		input_report_key(button->input, keycode, 0);
+		input_sync(button->input);
+		button->key_last_state = !!state;
+		button->key_last_time = jiffies;
+	}
+
 	if (state)
 		pm_wakeup_event(&device->dev, 0);
 
@@ -424,8 +441,9 @@ static int acpi_button_add(struct acpi_device *device)
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
-		button->sw_last_state = !!acpi_lid_evaluate_state(device);
-		button->sw_last_time = jiffies;
+		button->sw_last_state = button->key_last_state =
+			!!acpi_lid_evaluate_state(device);
+		button->sw_last_time = button->key_last_time = jiffies;
 	} else {
 		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
@@ -455,6 +473,8 @@ static int acpi_button_add(struct acpi_device *device)
 
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

