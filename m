From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [WIP PATCH 4/4] ACPI: button: Fix lid notification locks
Date: Thu,  1 Jun 2017 20:46:32 +0200
Message-ID: <20170601184632.2980-5-benjamin.tissoires@redhat.com>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751603AbdFASrR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 1 Jun 2017 14:47:17 -0400
In-Reply-To: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

From: Lv Zheng <lv.zheng@intel.com>

acpi/button.c now contains the logic to avoid frequently replayed events
which originally was ensured by using blocking notifier.
On the contrary, using a blocking notifier is wrong as it could keep on
returning NOTIFY_DONE, causing events lost.

This patch thus changes lid notification to raw notifier in order not to
have any events lost.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/acpi/button.c | 68 ++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 03e5981..1927b08 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -114,7 +114,7 @@ struct acpi_button {
 
 static DEFINE_MUTEX(button_input_lock);
 
-static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
+static RAW_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
 
@@ -179,14 +179,12 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
 	return lid_state ? 1 : 0;
 }
 
-static int acpi_lid_notify_state(struct acpi_device *device, int state)
+static void acpi_lid_notify_state(struct acpi_device *device, int state)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
-	/* button_input_lock must be held */
-
 	if (!button->input)
-		return 0;
+		return;
 
 	/*
 	 * If the lid is unreliable, always send an "open" event before any
@@ -201,8 +199,6 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 
 	if (state)
 		pm_wakeup_hard_event(&device->dev);
-
-	return 0;
 }
 
 /*
@@ -214,28 +210,14 @@ static void acpi_button_lid_events(struct input_handle *handle,
 {
 	const struct input_value *v;
 	int state = -1;
-	int ret;
 
 	for (v = vals; v != vals + count; v++) {
 		switch (v->type) {
 		case EV_SYN:
-			if (v->code == SYN_REPORT && state >= 0) {
-				ret = blocking_notifier_call_chain(&acpi_lid_notifier,
+			if (v->code == SYN_REPORT && state >= 0)
+				(void)raw_notifier_call_chain(&acpi_lid_notifier,
 								state,
 								lid_device);
-				if (ret == NOTIFY_DONE)
-					ret = blocking_notifier_call_chain(&acpi_lid_notifier,
-								state,
-								lid_device);
-				if (ret == NOTIFY_DONE || ret == NOTIFY_OK) {
-					/*
-					 * It is also regarded as success if
-					 * the notifier_chain returns NOTIFY_OK
-					 * or NOTIFY_DONE.
-					 */
-					ret = 0;
-				}
-			}
 			break;
 		case EV_SW:
 			if (v->code == SW_LID)
@@ -433,13 +415,25 @@ static int acpi_button_remove_fs(struct acpi_device *device)
    -------------------------------------------------------------------------- */
 int acpi_lid_notifier_register(struct notifier_block *nb)
 {
-	return blocking_notifier_chain_register(&acpi_lid_notifier, nb);
+	return raw_notifier_chain_register(&acpi_lid_notifier, nb);
 }
 EXPORT_SYMBOL(acpi_lid_notifier_register);
 
+static inline int __acpi_lid_notifier_unregister(struct notifier_block *nb,
+						 bool sync)
+{
+	int ret;
+
+	ret = raw_notifier_chain_unregister(&acpi_lid_notifier, nb);
+	if (sync)
+		synchronize_rcu();
+
+	return ret;
+}
+
 int acpi_lid_notifier_unregister(struct notifier_block *nb)
 {
-	return blocking_notifier_chain_unregister(&acpi_lid_notifier, nb);
+	return __acpi_lid_notifier_unregister(nb, false);
 }
 EXPORT_SYMBOL(acpi_lid_notifier_unregister);
 
@@ -452,40 +446,36 @@ int acpi_lid_open(void)
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
-static int acpi_lid_update_state(struct acpi_device *device)
+static void acpi_lid_update_state(struct acpi_device *device)
 {
 	int state;
 
 	state = acpi_lid_evaluate_state(device);
 	if (state < 0)
-		return state;
+		return;
 
-	return acpi_lid_notify_state(device, state);
+	acpi_lid_notify_state(device, state);
 }
 
-static int acpi_lid_notify(struct acpi_device *device)
+static void acpi_lid_notify(struct acpi_device *device)
 {
 	struct acpi_button *button = acpi_driver_data(device);
-	int ret;
 
 	mutex_lock(&button_input_lock);
 	if (!button->input)
 		acpi_button_add_input(device);
-	ret = acpi_lid_update_state(device);
+	acpi_lid_update_state(device);
 	mutex_unlock(&button_input_lock);
-
-
-	return ret;
 }
 
 static void acpi_lid_initialize_state(struct acpi_device *device)
 {
 	switch (lid_init_state) {
 	case ACPI_BUTTON_LID_INIT_OPEN:
-		(void)acpi_lid_notify_state(device, 1);
+		acpi_lid_notify_state(device, 1);
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(device);
+		acpi_lid_update_state(device);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
@@ -641,11 +631,7 @@ static int acpi_lid_update_reliable(struct acpi_device *device)
 		if (error)
 			return error;
 
-		error = acpi_lid_update_state(device);
-		if (error) {
-			acpi_button_remove_input(device);
-			return error;
-		}
+		acpi_lid_update_state(device);
 	}
 
 	if (!lid_reliable && button->input)
-- 
2.9.4

