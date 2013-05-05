From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 09/26] HID: wiimote: convert BATTERY to module
Date: Sun,  5 May 2013 23:12:53 +0200
Message-ID: <1367788390-29835-10-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48341 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab3EEVN5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:13:57 -0400
Received: by mail-bk0-f46.google.com with SMTP id w5so1350392bku.33
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:13:56 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

This introduces a new sub-device module for the BATTERY handlers. It
moves the whole power_supply battery handling over to wiimote-modules.

This doesn't change any semantics or ABI but only converts the battery
handling into a sub-device module.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    | 80 ++------------------------------
 drivers/hid/hid-wiimote-modules.c | 98 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |  2 +
 3 files changed, 104 insertions(+), 76 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 6ada226..bb1b3e3 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -17,16 +17,10 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/power_supply.h>
 #include <linux/spinlock.h>
 #include "hid-ids.h"
 #include "hid-wiimote.h"
 
-static enum power_supply_property wiimote_battery_props[] = {
-	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_SCOPE,
-};
-
 /* output queue handling */
 
 static int wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
@@ -232,7 +226,7 @@ void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
-static void wiiproto_req_status(struct wiimote_data *wdata)
+void wiiproto_req_status(struct wiimote_data *wdata)
 {
 	__u8 cmd[2];
 
@@ -423,48 +417,6 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata)
 	return WIIMOTE_EXT_UNKNOWN;
 }
 
-static int wiimote_battery_get_property(struct power_supply *psy,
-						enum power_supply_property psp,
-						union power_supply_propval *val)
-{
-	struct wiimote_data *wdata = container_of(psy,
-						struct wiimote_data, battery);
-	int ret = 0, state;
-	unsigned long flags;
-
-	if (psp == POWER_SUPPLY_PROP_SCOPE) {
-		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
-		return 0;
-	}
-
-	ret = wiimote_cmd_acquire(wdata);
-	if (ret)
-		return ret;
-
-	spin_lock_irqsave(&wdata->state.lock, flags);
-	wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
-	wiiproto_req_status(wdata);
-	spin_unlock_irqrestore(&wdata->state.lock, flags);
-
-	wiimote_cmd_wait(wdata);
-	wiimote_cmd_release(wdata);
-
-	spin_lock_irqsave(&wdata->state.lock, flags);
-	state = wdata->state.cmd_battery;
-	spin_unlock_irqrestore(&wdata->state.lock, flags);
-
-	switch (psp) {
-		case POWER_SUPPLY_PROP_CAPACITY:
-			val->intval = state * 100 / 255;
-			break;
-		default:
-			ret = -EINVAL;
-			break;
-	}
-
-	return ret;
-}
-
 static int wiimote_init_ir(struct wiimote_data *wdata, __u16 mode)
 {
 	int ret;
@@ -673,16 +625,19 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 	[WIIMOTE_DEV_GENERIC] = (const __u8[]){
 		WIIMOD_KEYS,
 		WIIMOD_RUMBLE,
+		WIIMOD_BATTERY,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN10] = (const __u8[]){
 		WIIMOD_KEYS,
 		WIIMOD_RUMBLE,
+		WIIMOD_BATTERY,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN20] = (const __u8[]){
 		WIIMOD_KEYS,
 		WIIMOD_RUMBLE,
+		WIIMOD_BATTERY,
 		WIIMOD_NULL,
 	},
 };
@@ -1349,8 +1304,6 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 
 	cancel_work_sync(&wdata->init_worker);
 	wiimote_modules_unload(wdata);
-	power_supply_unregister(&wdata->battery);
-	kfree(wdata->battery.name);
 	input_unregister_device(wdata->accel);
 	input_unregister_device(wdata->ir);
 	cancel_work_sync(&wdata->queue.worker);
@@ -1404,26 +1357,6 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_ir;
 	}
 
-	wdata->battery.properties = wiimote_battery_props;
-	wdata->battery.num_properties = ARRAY_SIZE(wiimote_battery_props);
-	wdata->battery.get_property = wiimote_battery_get_property;
-	wdata->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-	wdata->battery.use_for_apm = 0;
-	wdata->battery.name = kasprintf(GFP_KERNEL, "wiimote_battery_%s",
-					wdata->hdev->uniq);
-	if (!wdata->battery.name) {
-		ret = -ENOMEM;
-		goto err_battery_name;
-	}
-
-	ret = power_supply_register(&wdata->hdev->dev, &wdata->battery);
-	if (ret) {
-		hid_err(hdev, "Cannot register battery device\n");
-		goto err_battery;
-	}
-
-	power_supply_powers(&wdata->battery, &hdev->dev);
-
 	ret = wiimote_leds_create(wdata);
 	if (ret)
 		goto err_free;
@@ -1452,11 +1385,6 @@ err_free:
 	wiimote_destroy(wdata);
 	return ret;
 
-err_battery:
-	kfree(wdata->battery.name);
-err_battery_name:
-	input_unregister_device(wdata->ir);
-	wdata->ir = NULL;
 err_ir:
 	input_unregister_device(wdata->accel);
 	wdata->accel = NULL;
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 616f240..4cbbbe6 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -171,9 +171,107 @@ static const struct wiimod_ops wiimod_rumble = {
 	.remove = wiimod_rumble_remove,
 };
 
+/*
+ * Battery
+ * 1 byte of battery capacity information is sent along every protocol status
+ * report. The wiimote core caches it but we try to update it on every
+ * user-space request.
+ * This is supported by nearly every device so it's almost always enabled.
+ */
+
+static enum power_supply_property wiimod_battery_props[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
+};
+
+static int wiimod_battery_get_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	struct wiimote_data *wdata = container_of(psy, struct wiimote_data,
+						  battery);
+	int ret = 0, state;
+	unsigned long flags;
+
+	if (psp == POWER_SUPPLY_PROP_SCOPE) {
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		return 0;
+	} else if (psp != POWER_SUPPLY_PROP_CAPACITY) {
+		return -EINVAL;
+	}
+
+	ret = wiimote_cmd_acquire(wdata);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
+	wiiproto_req_status(wdata);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	wiimote_cmd_wait(wdata);
+	wiimote_cmd_release(wdata);
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	state = wdata->state.cmd_battery;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	val->intval = state * 100 / 255;
+	return ret;
+}
+
+static int wiimod_battery_probe(const struct wiimod_ops *ops,
+				struct wiimote_data *wdata)
+{
+	int ret;
+
+	wdata->battery.properties = wiimod_battery_props;
+	wdata->battery.num_properties = ARRAY_SIZE(wiimod_battery_props);
+	wdata->battery.get_property = wiimod_battery_get_property;
+	wdata->battery.type = POWER_SUPPLY_TYPE_BATTERY;
+	wdata->battery.use_for_apm = 0;
+	wdata->battery.name = kasprintf(GFP_KERNEL, "wiimote_battery_%s",
+					wdata->hdev->uniq);
+	if (!wdata->battery.name)
+		return -ENOMEM;
+
+	ret = power_supply_register(&wdata->hdev->dev, &wdata->battery);
+	if (ret) {
+		hid_err(wdata->hdev, "cannot register battery device\n");
+		goto err_free;
+	}
+
+	power_supply_powers(&wdata->battery, &wdata->hdev->dev);
+	return 0;
+
+err_free:
+	kfree(wdata->battery.name);
+	wdata->battery.name = NULL;
+	return ret;
+}
+
+static void wiimod_battery_remove(const struct wiimod_ops *ops,
+				  struct wiimote_data *wdata)
+{
+	if (!wdata->battery.name)
+		return;
+
+	power_supply_unregister(&wdata->battery);
+	kfree(wdata->battery.name);
+	wdata->battery.name = NULL;
+}
+
+static const struct wiimod_ops wiimod_battery = {
+	.flags = 0,
+	.arg = 0,
+	.probe = wiimod_battery_probe,
+	.remove = wiimod_battery_remove,
+};
+
 /* module table */
 
 const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
 	[WIIMOD_KEYS] = &wiimod_keys,
 	[WIIMOD_RUMBLE] = &wiimod_rumble,
+	[WIIMOD_BATTERY] = &wiimod_battery,
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 93c48fb..4151514 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -128,6 +128,7 @@ struct wiimote_data {
 enum wiimod_module {
 	WIIMOD_KEYS,
 	WIIMOD_RUMBLE,
+	WIIMOD_BATTERY,
 	WIIMOD_NUM,
 	WIIMOD_NULL = WIIMOD_NUM,
 };
@@ -184,6 +185,7 @@ enum wiiproto_reqs {
 
 extern void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm);
 extern void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble);
+extern void wiiproto_req_status(struct wiimote_data *wdata);
 extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 						const __u8 *wmem, __u8 size);
 extern ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset,
-- 
1.8.2.2

