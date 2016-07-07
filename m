From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/4] ACPI / button: Add SW_ACPI_LID for new usage model
Date: Thu,  7 Jul 2016 15:10:52 +0800
Message-ID: <916d5a5b0df5dbe14283ddb31f1128efefbfd1e2.1467875143.git.lv.zheng@intel.com>
References: <cover.1467717304.git.lv.zheng@intel.com> <cover.1467875142.git.lv.zheng@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14767 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756045AbcGGHLr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Jul 2016 03:11:47 -0400
In-Reply-To: <cover.1467875142.git.lv.zheng@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Bastien Nocera:" <hadess@hadess.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

There are many AML tables reporting wrong initial lid state, and some of
them never reports lid state. As a proxy layer acting between, ACPI button
driver is not able to handle all such cases, but need to re-define the
usage model of the ACPI lid. That is:
1. It's initial state is not reliable;
2. There may not be open event;
3. Userspace should only take action against the close event which is
   reliable, always sent after a real lid close.
This patch adds a new input key event so that new userspace programs can
use it to handle this usage model correctly. And in the meanwhile, no old
programs will be broken by the userspace changes.

Link: https://lkml.org/2016/3/7/460
Link: https://github.com/systemd/systemd/issues/2087
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/acpi/button.c                  |   20 ++++++++++++++------
 include/linux/mod_devicetable.h        |    2 +-
 include/uapi/linux/input-event-codes.h |    3 ++-
 3 files changed, 17 insertions(+), 8 deletions(-)

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

