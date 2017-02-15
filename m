From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/3] HID: wacom: generic: add mode change touch key
Date: Tue, 14 Feb 2017 21:27:18 -0800
Message-ID: <1487136438-5210-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33308 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdBOF11 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Feb 2017 00:27:27 -0500
Received: by mail-pg0-f65.google.com with SMTP id 16so529057pgg.0
        for <linux-input@vger.kernel.org>; Tue, 14 Feb 2017 21:27:27 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@gmail.com, dmitry.torokhov@gmail.com, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <ping.cheng@wacom.com>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Wacom Cintiq Pro added a touch key to switch the tablet between
display and opaque mode. This patch informs the change by removing
the old devices and creating new ones with proper properties.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom.h     |  5 +++++
 drivers/hid/wacom_sys.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/wacom_wac.c | 17 ++++++++++++++++-
 drivers/hid/wacom_wac.h |  4 ++++
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index d0d7dc1..ee8e95b 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -111,6 +111,7 @@ enum wacom_worker {
 	WACOM_WORKER_WIRELESS,
 	WACOM_WORKER_BATTERY,
 	WACOM_WORKER_REMOTE,
+	WACOM_WORKER_MODE_CHANGE,
 };
 
 struct wacom;
@@ -168,6 +169,7 @@ struct wacom {
 	struct work_struct remote_work;
 	struct delayed_work init_work;
 	struct wacom_remote *remote;
+	struct work_struct mode_change_work;
 	bool generic_has_leds;
 	struct wacom_leds {
 		struct wacom_group_leds *groups;
@@ -197,6 +199,9 @@ static inline void wacom_schedule_work(struct wacom_wac *wacom_wac,
 	case WACOM_WORKER_REMOTE:
 		schedule_work(&wacom->remote_work);
 		break;
+	case WACOM_WORKER_MODE_CHANGE:
+		schedule_work(&wacom->mode_change_work);
+		break;
 	}
 }
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 3586acb..b3272c6 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -325,6 +325,13 @@ static void wacom_post_parse_hid(struct hid_device *hdev,
 
 	if (features->type == HID_GENERIC) {
 		/* Any last-minute generic device setup */
+		if (wacom_wac->has_mode_change) {
+			if (wacom_wac->is_direct_mode)
+				features->device_type |= WACOM_DEVICETYPE_DIRECT;
+			else
+				features->device_type &= ~WACOM_DEVICETYPE_DIRECT;
+		}
+
 		if (features->touch_max > 1) {
 			if (features->device_type & WACOM_DEVICETYPE_DIRECT)
 				input_mt_init_slots(wacom_wac->touch_input,
@@ -2488,6 +2495,46 @@ static void wacom_remote_work(struct work_struct *work)
 	}
 }
 
+static void wacom_mode_change_work(struct work_struct *work)
+{
+	struct wacom *wacom = container_of(work, struct wacom, mode_change_work);
+	struct wacom_shared *shared = wacom->wacom_wac.shared;
+	struct wacom *wacom1 = NULL;
+	struct wacom *wacom2 = NULL;
+	bool is_direct = wacom->wacom_wac.is_direct_mode;
+	int error = 0;
+
+	if (shared->pen) {
+		wacom1 = hid_get_drvdata(shared->pen);
+		wacom_release_resources(wacom1);
+		hid_hw_stop(wacom1->hdev);
+		wacom1->wacom_wac.has_mode_change = true;
+		wacom1->wacom_wac.is_direct_mode = is_direct;
+	}
+
+	if (shared->touch) {
+		wacom2 = hid_get_drvdata(shared->touch);
+		wacom_release_resources(wacom2);
+		hid_hw_stop(wacom2->hdev);
+		wacom2->wacom_wac.has_mode_change = true;
+		wacom2->wacom_wac.is_direct_mode = is_direct;
+	}
+
+	if (wacom1) {
+		error = wacom_parse_and_register(wacom1, false);
+		if (error)
+			return;
+	}
+
+	if (wacom2) {
+		error = wacom_parse_and_register(wacom2, false);
+		if (error)
+			return;
+	}
+
+	return;
+}
+
 static int wacom_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
@@ -2532,6 +2579,7 @@ static int wacom_probe(struct hid_device *hdev,
 	INIT_WORK(&wacom->wireless_work, wacom_wireless_work);
 	INIT_WORK(&wacom->battery_work, wacom_battery_work);
 	INIT_WORK(&wacom->remote_work, wacom_remote_work);
+	INIT_WORK(&wacom->mode_change_work, wacom_mode_change_work);
 
 	/* ask for the report descriptor to be loaded by HID */
 	error = hid_parse(hdev);
@@ -2574,6 +2622,7 @@ static void wacom_remove(struct hid_device *hdev)
 	cancel_work_sync(&wacom->wireless_work);
 	cancel_work_sync(&wacom->battery_work);
 	cancel_work_sync(&wacom->remote_work);
+	cancel_work_sync(&wacom->mode_change_work);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a0135ac..0c544e7 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1773,6 +1773,14 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 		wacom_map_usage(input, usage, field, EV_KEY, KEY_CONTROLPANEL, 0);
 		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
+	case WACOM_HID_WD_MODE_CHANGE:
+		/* do not overwrite previous data */
+		if (!wacom_wac->has_mode_change) {
+			wacom_wac->has_mode_change = true;
+			wacom_wac->is_direct_mode = true;
+		}
+		features->device_type |= WACOM_DEVICETYPE_PAD;
+		break;
 	}
 
 	switch (equivalent_usage & 0xfffffff0) {
@@ -1821,7 +1829,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	 * Avoid reporting this event and setting inrange_state if this usage
 	 * hasn't been mapped.
 	 */
-	if (!usage->type)
+	if (!usage->type && equivalent_usage != WACOM_HID_WD_MODE_CHANGE)
 		return;
 
 	if (wacom_equivalent_usage(field->physical) == HID_DG_TABLETFUNCTIONKEY) {
@@ -1843,6 +1851,13 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 		}
 		break;
 
+	case WACOM_HID_WD_MODE_CHANGE:
+		if (wacom_wac->is_direct_mode != value) {
+			wacom_wac->is_direct_mode = value;
+			wacom_schedule_work(&wacom->wacom_wac, WACOM_WORKER_MODE_CHANGE);
+		}
+		break;
+
 	case WACOM_HID_WD_BUTTONCENTER:
 		for (i = 0; i < wacom->led.count; i++)
 			wacom_update_led(wacom, features->numbered_buttons,
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 5eba31d..d9669c6 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -120,6 +120,7 @@
 #define WACOM_HID_WD_BATTERY_LEVEL      (WACOM_HID_UP_WACOMDIGITIZER | 0x043b)
 #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
 #define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0950)
+#define WACOM_HID_WD_MODE_CHANGE        (WACOM_HID_UP_WACOMDIGITIZER | 0x0980)
 #define WACOM_HID_WD_CONTROLPANEL       (WACOM_HID_UP_WACOMDIGITIZER | 0x0982)
 #define WACOM_HID_WD_ONSCREEN_KEYBOARD  (WACOM_HID_UP_WACOMDIGITIZER | 0x0983)
 #define WACOM_HID_WD_BUTTONCONFIG       (WACOM_HID_UP_WACOMDIGITIZER | 0x0986)
@@ -330,6 +331,9 @@ struct wacom_wac {
 	int mode_value;
 	struct hid_data hid_data;
 	bool has_mute_touch_switch;
+	bool has_mode_change;
+	bool is_direct_mode;
+
 };
 
 #endif
-- 
1.8.3.1

