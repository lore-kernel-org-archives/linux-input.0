From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 10/26] HID: wiimote: convert LEDS to modules
Date: Sun,  5 May 2013 23:12:54 +0200
Message-ID: <1367788390-29835-11-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49509 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab3EEVN7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:13:59 -0400
Received: by mail-bk0-f46.google.com with SMTP id w5so1330901bku.5
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:13:58 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Each of the 4 LEDs may be supported individually by devices. Therefore,
we need one module for each device. To avoid code-duplication, we simply
pass the LED ID as "arg" argument to the module loading code.

This just moves the code over to wiimote-module. The semantics stay the
same as before.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    | 125 ++++------------------------------
 drivers/hid/hid-wiimote-modules.c | 140 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   5 ++
 3 files changed, 158 insertions(+), 112 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index bb1b3e3..4f58c78 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -14,7 +14,6 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/input.h>
-#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
@@ -151,7 +150,7 @@ void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
-static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
+void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
 {
 	__u8 cmd[2];
 
@@ -529,54 +528,6 @@ unlock:
 	return ret;
 }
 
-static enum led_brightness wiimote_leds_get(struct led_classdev *led_dev)
-{
-	struct wiimote_data *wdata;
-	struct device *dev = led_dev->dev->parent;
-	int i;
-	unsigned long flags;
-	bool value = false;
-
-	wdata = hid_get_drvdata(container_of(dev, struct hid_device, dev));
-
-	for (i = 0; i < 4; ++i) {
-		if (wdata->leds[i] == led_dev) {
-			spin_lock_irqsave(&wdata->state.lock, flags);
-			value = wdata->state.flags & WIIPROTO_FLAG_LED(i + 1);
-			spin_unlock_irqrestore(&wdata->state.lock, flags);
-			break;
-		}
-	}
-
-	return value ? LED_FULL : LED_OFF;
-}
-
-static void wiimote_leds_set(struct led_classdev *led_dev,
-						enum led_brightness value)
-{
-	struct wiimote_data *wdata;
-	struct device *dev = led_dev->dev->parent;
-	int i;
-	unsigned long flags;
-	__u8 state, flag;
-
-	wdata = hid_get_drvdata(container_of(dev, struct hid_device, dev));
-
-	for (i = 0; i < 4; ++i) {
-		if (wdata->leds[i] == led_dev) {
-			flag = WIIPROTO_FLAG_LED(i + 1);
-			spin_lock_irqsave(&wdata->state.lock, flags);
-			state = wdata->state.flags;
-			if (value == LED_OFF)
-				wiiproto_req_leds(wdata, state & ~flag);
-			else
-				wiiproto_req_leds(wdata, state | flag);
-			spin_unlock_irqrestore(&wdata->state.lock, flags);
-			break;
-		}
-	}
-}
-
 static int wiimote_accel_open(struct input_dev *dev)
 {
 	struct wiimote_data *wdata = input_get_drvdata(dev);
@@ -626,18 +577,30 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_KEYS,
 		WIIMOD_RUMBLE,
 		WIIMOD_BATTERY,
+		WIIMOD_LED1,
+		WIIMOD_LED2,
+		WIIMOD_LED3,
+		WIIMOD_LED4,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN10] = (const __u8[]){
 		WIIMOD_KEYS,
 		WIIMOD_RUMBLE,
 		WIIMOD_BATTERY,
+		WIIMOD_LED1,
+		WIIMOD_LED2,
+		WIIMOD_LED3,
+		WIIMOD_LED4,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN20] = (const __u8[]){
 		WIIMOD_KEYS,
 		WIIMOD_RUMBLE,
 		WIIMOD_BATTERY,
+		WIIMOD_LED1,
+		WIIMOD_LED2,
+		WIIMOD_LED3,
+		WIIMOD_LED4,
 		WIIMOD_NULL,
 	},
 };
@@ -1159,58 +1122,6 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
-static void wiimote_leds_destroy(struct wiimote_data *wdata)
-{
-	int i;
-	struct led_classdev *led;
-
-	for (i = 0; i < 4; ++i) {
-		if (wdata->leds[i]) {
-			led = wdata->leds[i];
-			wdata->leds[i] = NULL;
-			led_classdev_unregister(led);
-			kfree(led);
-		}
-	}
-}
-
-static int wiimote_leds_create(struct wiimote_data *wdata)
-{
-	int i, ret;
-	struct device *dev = &wdata->hdev->dev;
-	size_t namesz = strlen(dev_name(dev)) + 9;
-	struct led_classdev *led;
-	char *name;
-
-	for (i = 0; i < 4; ++i) {
-		led = kzalloc(sizeof(struct led_classdev) + namesz, GFP_KERNEL);
-		if (!led) {
-			ret = -ENOMEM;
-			goto err;
-		}
-		name = (void*)&led[1];
-		snprintf(name, namesz, "%s:blue:p%d", dev_name(dev), i);
-		led->name = name;
-		led->brightness = 0;
-		led->max_brightness = 1;
-		led->brightness_get = wiimote_leds_get;
-		led->brightness_set = wiimote_leds_set;
-
-		ret = led_classdev_register(dev, led);
-		if (ret) {
-			kfree(led);
-			goto err;
-		}
-		wdata->leds[i] = led;
-	}
-
-	return 0;
-
-err:
-	wiimote_leds_destroy(wdata);
-	return ret;
-}
-
 static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 {
 	struct wiimote_data *wdata;
@@ -1300,7 +1211,6 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 {
 	wiidebug_deinit(wdata);
 	wiiext_deinit(wdata);
-	wiimote_leds_destroy(wdata);
 
 	cancel_work_sync(&wdata->init_worker);
 	wiimote_modules_unload(wdata);
@@ -1357,10 +1267,6 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_ir;
 	}
 
-	ret = wiimote_leds_create(wdata);
-	if (ret)
-		goto err_free;
-
 	ret = wiiext_init(wdata);
 	if (ret)
 		goto err_free;
@@ -1371,11 +1277,6 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 
 	hid_info(hdev, "New device registered\n");
 
-	/* by default set led1 after device initialization */
-	spin_lock_irq(&wdata->state.lock);
-	wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
-	spin_unlock_irq(&wdata->state.lock);
-
 	/* schedule device detection */
 	schedule_work(&wdata->init_worker);
 
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 4cbbbe6..f96de15 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -268,10 +268,150 @@ static const struct wiimod_ops wiimod_battery = {
 	.remove = wiimod_battery_remove,
 };
 
+/*
+ * LED
+ * 0 to 4 player LEDs are supported by devices. The "arg" field of the
+ * wiimod_ops structure specifies which LED this module controls. This allows
+ * to register a limited number of LEDs.
+ * State is managed by wiimote core.
+ */
+
+static enum led_brightness wiimod_led_get(struct led_classdev *led_dev)
+{
+	struct wiimote_data *wdata;
+	struct device *dev = led_dev->dev->parent;
+	int i;
+	unsigned long flags;
+	bool value = false;
+
+	wdata = hid_get_drvdata(container_of(dev, struct hid_device, dev));
+
+	for (i = 0; i < 4; ++i) {
+		if (wdata->leds[i] == led_dev) {
+			spin_lock_irqsave(&wdata->state.lock, flags);
+			value = wdata->state.flags & WIIPROTO_FLAG_LED(i + 1);
+			spin_unlock_irqrestore(&wdata->state.lock, flags);
+			break;
+		}
+	}
+
+	return value ? LED_FULL : LED_OFF;
+}
+
+static void wiimod_led_set(struct led_classdev *led_dev,
+			   enum led_brightness value)
+{
+	struct wiimote_data *wdata;
+	struct device *dev = led_dev->dev->parent;
+	int i;
+	unsigned long flags;
+	__u8 state, flag;
+
+	wdata = hid_get_drvdata(container_of(dev, struct hid_device, dev));
+
+	for (i = 0; i < 4; ++i) {
+		if (wdata->leds[i] == led_dev) {
+			flag = WIIPROTO_FLAG_LED(i + 1);
+			spin_lock_irqsave(&wdata->state.lock, flags);
+			state = wdata->state.flags;
+			if (value == LED_OFF)
+				wiiproto_req_leds(wdata, state & ~flag);
+			else
+				wiiproto_req_leds(wdata, state | flag);
+			spin_unlock_irqrestore(&wdata->state.lock, flags);
+			break;
+		}
+	}
+}
+
+static int wiimod_led_probe(const struct wiimod_ops *ops,
+			    struct wiimote_data *wdata)
+{
+	struct device *dev = &wdata->hdev->dev;
+	size_t namesz = strlen(dev_name(dev)) + 9;
+	struct led_classdev *led;
+	unsigned long flags;
+	char *name;
+	int ret;
+
+	led = kzalloc(sizeof(struct led_classdev) + namesz, GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	name = (void*)&led[1];
+	snprintf(name, namesz, "%s:blue:p%lu", dev_name(dev), ops->arg);
+	led->name = name;
+	led->brightness = 0;
+	led->max_brightness = 1;
+	led->brightness_get = wiimod_led_get;
+	led->brightness_set = wiimod_led_set;
+
+	wdata->leds[ops->arg] = led;
+	ret = led_classdev_register(dev, led);
+	if (ret)
+		goto err_free;
+
+	/* enable LED1 to stop initial LED-blinking */
+	if (ops->arg == 0) {
+		spin_lock_irqsave(&wdata->state.lock, flags);
+		wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
+		spin_unlock_irqrestore(&wdata->state.lock, flags);
+	}
+
+	return 0;
+
+err_free:
+	wdata->leds[ops->arg] = NULL;
+	kfree(led);
+	return ret;
+}
+
+static void wiimod_led_remove(const struct wiimod_ops *ops,
+			      struct wiimote_data *wdata)
+{
+	if (!wdata->leds[ops->arg])
+		return;
+
+	led_classdev_unregister(wdata->leds[ops->arg]);
+	kfree(wdata->leds[ops->arg]);
+	wdata->leds[ops->arg] = NULL;
+}
+
+static const struct wiimod_ops wiimod_leds[4] = {
+	{
+		.flags = 0,
+		.arg = 0,
+		.probe = wiimod_led_probe,
+		.remove = wiimod_led_remove,
+	},
+	{
+		.flags = 0,
+		.arg = 1,
+		.probe = wiimod_led_probe,
+		.remove = wiimod_led_remove,
+	},
+	{
+		.flags = 0,
+		.arg = 2,
+		.probe = wiimod_led_probe,
+		.remove = wiimod_led_remove,
+	},
+	{
+		.flags = 0,
+		.arg = 3,
+		.probe = wiimod_led_probe,
+		.remove = wiimod_led_remove,
+	},
+};
+
 /* module table */
 
 const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
 	[WIIMOD_KEYS] = &wiimod_keys,
 	[WIIMOD_RUMBLE] = &wiimod_rumble,
 	[WIIMOD_BATTERY] = &wiimod_battery,
+	[WIIMOD_LED1] = &wiimod_leds[0],
+	[WIIMOD_LED2] = &wiimod_leds[1],
+	[WIIMOD_LED3] = &wiimod_leds[2],
+	[WIIMOD_LED4] = &wiimod_leds[3],
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 4151514..66150a6 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -129,6 +129,10 @@ enum wiimod_module {
 	WIIMOD_KEYS,
 	WIIMOD_RUMBLE,
 	WIIMOD_BATTERY,
+	WIIMOD_LED1,
+	WIIMOD_LED2,
+	WIIMOD_LED3,
+	WIIMOD_LED4,
 	WIIMOD_NUM,
 	WIIMOD_NULL = WIIMOD_NUM,
 };
@@ -185,6 +189,7 @@ enum wiiproto_reqs {
 
 extern void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm);
 extern void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble);
+extern void wiiproto_req_leds(struct wiimote_data *wdata, int leds);
 extern void wiiproto_req_status(struct wiimote_data *wdata);
 extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 						const __u8 *wmem, __u8 size);
-- 
1.8.2.2

