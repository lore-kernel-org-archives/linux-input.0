From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 08/26] HID: wiimote: convert KEYS and RUMBLE to modules
Date: Sun,  5 May 2013 23:12:52 +0200
Message-ID: <1367788390-29835-9-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:50631 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab3EEVNz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:13:55 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so1318565bkc.16
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:13:54 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

This introduces the first sub-device modules by converting the KEYS and
RUMBLE sub-devices into wiimote modules. Both must be converted at once
because they depend on the built-in shared input device.

This mostly moves code from wiimote-core to wiimote-modules and doesn't
change any semantics or ABI.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    | 134 ++++++--------------------------------
 drivers/hid/hid-wiimote-modules.c | 134 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |  18 +++++
 3 files changed, 172 insertions(+), 114 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 275428b..6ada226 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -22,35 +22,6 @@
 #include "hid-ids.h"
 #include "hid-wiimote.h"
 
-enum wiiproto_keys {
-	WIIPROTO_KEY_LEFT,
-	WIIPROTO_KEY_RIGHT,
-	WIIPROTO_KEY_UP,
-	WIIPROTO_KEY_DOWN,
-	WIIPROTO_KEY_PLUS,
-	WIIPROTO_KEY_MINUS,
-	WIIPROTO_KEY_ONE,
-	WIIPROTO_KEY_TWO,
-	WIIPROTO_KEY_A,
-	WIIPROTO_KEY_B,
-	WIIPROTO_KEY_HOME,
-	WIIPROTO_KEY_COUNT
-};
-
-static __u16 wiiproto_keymap[] = {
-	KEY_LEFT,	/* WIIPROTO_KEY_LEFT */
-	KEY_RIGHT,	/* WIIPROTO_KEY_RIGHT */
-	KEY_UP,		/* WIIPROTO_KEY_UP */
-	KEY_DOWN,	/* WIIPROTO_KEY_DOWN */
-	KEY_NEXT,	/* WIIPROTO_KEY_PLUS */
-	KEY_PREVIOUS,	/* WIIPROTO_KEY_MINUS */
-	BTN_1,		/* WIIPROTO_KEY_ONE */
-	BTN_2,		/* WIIPROTO_KEY_TWO */
-	BTN_A,		/* WIIPROTO_KEY_A */
-	BTN_B,		/* WIIPROTO_KEY_B */
-	BTN_MODE,	/* WIIPROTO_KEY_HOME */
-};
-
 static enum power_supply_property wiimote_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_SCOPE,
@@ -166,7 +137,7 @@ static inline void wiiproto_keep_rumble(struct wiimote_data *wdata, __u8 *cmd1)
 		*cmd1 |= 0x01;
 }
 
-static void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble)
+void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble)
 {
 	__u8 cmd[2];
 
@@ -654,31 +625,6 @@ static void wiimote_leds_set(struct led_classdev *led_dev,
 	}
 }
 
-static int wiimote_ff_play(struct input_dev *dev, void *data,
-							struct ff_effect *eff)
-{
-	struct wiimote_data *wdata = input_get_drvdata(dev);
-	__u8 value;
-	unsigned long flags;
-
-	/*
-	 * The wiimote supports only a single rumble motor so if any magnitude
-	 * is set to non-zero then we start the rumble motor. If both are set to
-	 * zero, we stop the rumble motor.
-	 */
-
-	if (eff->u.rumble.strong_magnitude || eff->u.rumble.weak_magnitude)
-		value = 1;
-	else
-		value = 0;
-
-	spin_lock_irqsave(&wdata->state.lock, flags);
-	wiiproto_req_rumble(wdata, value);
-	spin_unlock_irqrestore(&wdata->state.lock, flags);
-
-	return 0;
-}
-
 static int wiimote_accel_open(struct input_dev *dev)
 {
 	struct wiimote_data *wdata = input_get_drvdata(dev);
@@ -725,12 +671,18 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GENERIC] = (const __u8[]){
+		WIIMOD_KEYS,
+		WIIMOD_RUMBLE,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN10] = (const __u8[]){
+		WIIMOD_KEYS,
+		WIIMOD_RUMBLE,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN20] = (const __u8[]){
+		WIIMOD_KEYS,
+		WIIMOD_RUMBLE,
 		WIIMOD_NULL,
 	},
 };
@@ -933,29 +885,17 @@ static void wiimote_init_worker(struct work_struct *work)
 
 static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 {
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_LEFT],
-							!!(payload[0] & 0x01));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_RIGHT],
-							!!(payload[0] & 0x02));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_DOWN],
-							!!(payload[0] & 0x04));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_UP],
-							!!(payload[0] & 0x08));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_PLUS],
-							!!(payload[0] & 0x10));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_TWO],
-							!!(payload[1] & 0x01));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_ONE],
-							!!(payload[1] & 0x02));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_B],
-							!!(payload[1] & 0x04));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_A],
-							!!(payload[1] & 0x08));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_MINUS],
-							!!(payload[1] & 0x10));
-	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_HOME],
-							!!(payload[1] & 0x80));
-	input_sync(wdata->input);
+	const __u8 *iter, *mods;
+	const struct wiimod_ops *ops;
+
+	mods = wiimote_devtype_mods[wdata->state.devtype];
+	for (iter = mods; *iter != WIIMOD_NULL; ++iter) {
+		ops = wiimod_table[*iter];
+		if (ops->in_keys) {
+			ops->in_keys(wdata, payload);
+			break;
+		}
+	}
 }
 
 static void handler_accel(struct wiimote_data *wdata, const __u8 *payload)
@@ -1319,38 +1259,17 @@ err:
 static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 {
 	struct wiimote_data *wdata;
-	int i;
 
 	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
 	if (!wdata)
 		return NULL;
 
-	wdata->input = input_allocate_device();
-	if (!wdata->input)
-		goto err;
-
 	wdata->hdev = hdev;
 	hid_set_drvdata(hdev, wdata);
 
-	input_set_drvdata(wdata->input, wdata);
-	wdata->input->dev.parent = &wdata->hdev->dev;
-	wdata->input->id.bustype = wdata->hdev->bus;
-	wdata->input->id.vendor = wdata->hdev->vendor;
-	wdata->input->id.product = wdata->hdev->product;
-	wdata->input->id.version = wdata->hdev->version;
-	wdata->input->name = WIIMOTE_NAME;
-
-	set_bit(EV_KEY, wdata->input->evbit);
-	for (i = 0; i < WIIPROTO_KEY_COUNT; ++i)
-		set_bit(wiiproto_keymap[i], wdata->input->keybit);
-
-	set_bit(FF_RUMBLE, wdata->input->ffbit);
-	if (input_ff_create_memless(wdata->input, NULL, wiimote_ff_play))
-		goto err_input;
-
 	wdata->accel = input_allocate_device();
 	if (!wdata->accel)
-		goto err_input;
+		goto err;
 
 	input_set_drvdata(wdata->accel, wdata);
 	wdata->accel->open = wiimote_accel_open;
@@ -1417,8 +1336,6 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 
 err_ir:
 	input_free_device(wdata->accel);
-err_input:
-	input_free_device(wdata->input);
 err:
 	kfree(wdata);
 	return NULL;
@@ -1430,13 +1347,12 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 	wiiext_deinit(wdata);
 	wiimote_leds_destroy(wdata);
 
+	cancel_work_sync(&wdata->init_worker);
 	wiimote_modules_unload(wdata);
 	power_supply_unregister(&wdata->battery);
 	kfree(wdata->battery.name);
 	input_unregister_device(wdata->accel);
 	input_unregister_device(wdata->ir);
-	input_unregister_device(wdata->input);
-	cancel_work_sync(&wdata->init_worker);
 	cancel_work_sync(&wdata->queue.worker);
 	hid_hw_close(wdata->hdev);
 	hid_hw_stop(wdata->hdev);
@@ -1488,12 +1404,6 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_ir;
 	}
 
-	ret = input_register_device(wdata->input);
-	if (ret) {
-		hid_err(hdev, "Cannot register input device\n");
-		goto err_input;
-	}
-
 	wdata->battery.properties = wiimote_battery_props;
 	wdata->battery.num_properties = ARRAY_SIZE(wiimote_battery_props);
 	wdata->battery.get_property = wiimote_battery_get_property;
@@ -1545,9 +1455,6 @@ err_free:
 err_battery:
 	kfree(wdata->battery.name);
 err_battery_name:
-	input_unregister_device(wdata->input);
-	wdata->input = NULL;
-err_input:
 	input_unregister_device(wdata->ir);
 	wdata->ir = NULL;
 err_ir:
@@ -1560,7 +1467,6 @@ err_stop:
 err:
 	input_free_device(wdata->ir);
 	input_free_device(wdata->accel);
-	input_free_device(wdata->input);
 	kfree(wdata);
 	return ret;
 }
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 5dcdd23..616f240 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -39,7 +39,141 @@
 #include <linux/spinlock.h>
 #include "hid-wiimote.h"
 
+/*
+ * Keys
+ * The initial Wii Remote provided a bunch of buttons that are reported as
+ * part of the core protocol. Many later devices dropped these and report
+ * invalid data in the core button reports. Load this only on devices which
+ * correctly send button reports.
+ * It uses the shared input device.
+ */
+
+static const __u16 wiimod_keys_map[] = {
+	KEY_LEFT,	/* WIIPROTO_KEY_LEFT */
+	KEY_RIGHT,	/* WIIPROTO_KEY_RIGHT */
+	KEY_UP,		/* WIIPROTO_KEY_UP */
+	KEY_DOWN,	/* WIIPROTO_KEY_DOWN */
+	KEY_NEXT,	/* WIIPROTO_KEY_PLUS */
+	KEY_PREVIOUS,	/* WIIPROTO_KEY_MINUS */
+	BTN_1,		/* WIIPROTO_KEY_ONE */
+	BTN_2,		/* WIIPROTO_KEY_TWO */
+	BTN_A,		/* WIIPROTO_KEY_A */
+	BTN_B,		/* WIIPROTO_KEY_B */
+	BTN_MODE,	/* WIIPROTO_KEY_HOME */
+};
+
+static void wiimod_keys_in_keys(struct wiimote_data *wdata, const __u8 *keys)
+{
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_LEFT],
+							!!(keys[0] & 0x01));
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_RIGHT],
+							!!(keys[0] & 0x02));
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_DOWN],
+							!!(keys[0] & 0x04));
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_UP],
+							!!(keys[0] & 0x08));
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_PLUS],
+							!!(keys[0] & 0x10));
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_TWO],
+							!!(keys[1] & 0x01));
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_ONE],
+							!!(keys[1] & 0x02));
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_B],
+							!!(keys[1] & 0x04));
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_A],
+							!!(keys[1] & 0x08));
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_MINUS],
+							!!(keys[1] & 0x10));
+	input_report_key(wdata->input, wiimod_keys_map[WIIPROTO_KEY_HOME],
+							!!(keys[1] & 0x80));
+	input_sync(wdata->input);
+}
+
+static int wiimod_keys_probe(const struct wiimod_ops *ops,
+			     struct wiimote_data *wdata)
+{
+	unsigned int i;
+
+	set_bit(EV_KEY, wdata->input->evbit);
+	for (i = 0; i < WIIPROTO_KEY_COUNT; ++i)
+		set_bit(wiimod_keys_map[i], wdata->input->keybit);
+
+	return 0;
+}
+
+static const struct wiimod_ops wiimod_keys = {
+	.flags = WIIMOD_FLAG_INPUT,
+	.arg = 0,
+	.probe = wiimod_keys_probe,
+	.remove = NULL,
+	.in_keys = wiimod_keys_in_keys,
+};
+
+/*
+ * Rumble
+ * Nearly all devices provide a rumble feature. A small motor for
+ * force-feedback effects. We provide an FF_RUMBLE memless ff device on the
+ * shared input device if this module is loaded.
+ * The rumble motor is controlled via a flag on almost every output report so
+ * the wiimote core handles the rumble flag. But if a device doesn't provide
+ * the rumble motor, this flag shouldn't be set.
+ */
+
+static int wiimod_rumble_play(struct input_dev *dev, void *data,
+			      struct ff_effect *eff)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	__u8 value;
+	unsigned long flags;
+
+	/*
+	 * The wiimote supports only a single rumble motor so if any magnitude
+	 * is set to non-zero then we start the rumble motor. If both are set to
+	 * zero, we stop the rumble motor.
+	 */
+
+	if (eff->u.rumble.strong_magnitude || eff->u.rumble.weak_magnitude)
+		value = 1;
+	else
+		value = 0;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiiproto_req_rumble(wdata, value);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static int wiimod_rumble_probe(const struct wiimod_ops *ops,
+			       struct wiimote_data *wdata)
+{
+	set_bit(FF_RUMBLE, wdata->input->ffbit);
+	if (input_ff_create_memless(wdata->input, NULL, wiimod_rumble_play))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void wiimod_rumble_remove(const struct wiimod_ops *ops,
+				 struct wiimote_data *wdata)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiiproto_req_rumble(wdata, 0);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static const struct wiimod_ops wiimod_rumble = {
+	.flags = WIIMOD_FLAG_INPUT,
+	.arg = 0,
+	.probe = wiimod_rumble_probe,
+	.remove = wiimod_rumble_remove,
+};
+
 /* module table */
 
 const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
+	[WIIMOD_KEYS] = &wiimod_keys,
+	[WIIMOD_RUMBLE] = &wiimod_rumble,
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 3c94e3c..93c48fb 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -45,6 +45,21 @@
 /* return flag for led \num */
 #define WIIPROTO_FLAG_LED(num) (WIIPROTO_FLAG_LED1 << (num - 1))
 
+enum wiiproto_keys {
+	WIIPROTO_KEY_LEFT,
+	WIIPROTO_KEY_RIGHT,
+	WIIPROTO_KEY_UP,
+	WIIPROTO_KEY_DOWN,
+	WIIPROTO_KEY_PLUS,
+	WIIPROTO_KEY_MINUS,
+	WIIPROTO_KEY_ONE,
+	WIIPROTO_KEY_TWO,
+	WIIPROTO_KEY_A,
+	WIIPROTO_KEY_B,
+	WIIPROTO_KEY_HOME,
+	WIIPROTO_KEY_COUNT
+};
+
 enum wiimote_devtype {
 	WIIMOTE_DEV_PENDING,
 	WIIMOTE_DEV_UNKNOWN,
@@ -111,6 +126,8 @@ struct wiimote_data {
 /* wiimote modules */
 
 enum wiimod_module {
+	WIIMOD_KEYS,
+	WIIMOD_RUMBLE,
 	WIIMOD_NUM,
 	WIIMOD_NULL = WIIMOD_NUM,
 };
@@ -166,6 +183,7 @@ enum wiiproto_reqs {
 									dev))
 
 extern void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm);
+extern void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble);
 extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 						const __u8 *wmem, __u8 size);
 extern ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset,
-- 
1.8.2.2

