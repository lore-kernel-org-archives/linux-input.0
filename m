From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 26/27] HID: wacom: leds: handle the switch of the LEDs directly in the kernel
Date: Tue,  5 Jul 2016 16:39:22 +0200
Message-ID: <1467729563-23318-27-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44358 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933234AbcGEOkU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jul 2016 10:40:20 -0400
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

The EKR switches the LED directly, and there is no point in having
userspace handling the switch it self when it's easy enough to do
in the kernel.

The other benefit is that now userspace does not need to have root access
to the LED but need only to read them with user privileges.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     |  4 ++++
 drivers/hid/wacom_sys.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/hid/wacom_wac.c | 53 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 9159dd3..8f8a162 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -216,4 +216,8 @@ int wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value);
 void wacom_wac_report(struct hid_device *hdev, struct hid_report *report);
 void wacom_battery_work(struct work_struct *work);
+enum led_brightness wacom_leds_brightness_get(struct wacom_led *led);
+struct wacom_led *wacom_led_find(struct wacom *wacom, unsigned int group,
+				 unsigned int id);
+struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur);
 #endif
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 153e453..4a0bb6f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -984,7 +984,7 @@ static int wacom_devm_sysfs_create_group(struct wacom *wacom,
 					       group);
 }
 
-static enum led_brightness wacom_leds_brightness_get(struct wacom_led *led)
+enum led_brightness wacom_leds_brightness_get(struct wacom_led *led)
 {
 	struct wacom *wacom = led->wacom;
 
@@ -1057,6 +1057,17 @@ static int wacom_led_register_one(struct device *dev, struct wacom *wacom,
 	if (!name)
 		return -ENOMEM;
 
+	if (!read_only) {
+		led->trigger.name = name;
+		error = devm_led_trigger_register(dev, &led->trigger);
+		if (error) {
+			hid_err(wacom->hdev,
+				"failed to register LED trigger %s: %d\n",
+				led->cdev.name, error);
+			return error;
+		}
+	}
+
 	led->group = group;
 	led->id = id;
 	led->wacom = wacom;
@@ -1065,10 +1076,12 @@ static int wacom_led_register_one(struct device *dev, struct wacom *wacom,
 	led->cdev.name = name;
 	led->cdev.max_brightness = LED_FULL;
 	led->cdev.brightness_get = __wacom_led_brightness_get;
-	if (!read_only)
+	if (!read_only) {
 		led->cdev.brightness_set_blocking = wacom_led_brightness_set;
-	else
+		led->cdev.default_trigger = led->cdev.name;
+	} else {
 		led->cdev.brightness_set = wacom_led_readonly_brightness_set;
+	}
 
 	error = devm_led_classdev_register(dev, &led->cdev);
 	if (error) {
@@ -1145,6 +1158,50 @@ err:
 	return error;
 }
 
+struct wacom_led *wacom_led_find(struct wacom *wacom, unsigned int group_id,
+				 unsigned int id)
+{
+	struct wacom_group_leds *group;
+
+	if (group_id >= wacom->led.count)
+		return NULL;
+
+	group = &wacom->led.groups[group_id];
+
+	if (!group->leds)
+		return NULL;
+
+	id %= group->count;
+
+	return &group->leds[id];
+}
+
+/**
+ * wacom_led_next: gives the next available led with a wacom trigger.
+ *
+ * returns the next available struct wacom_led which has its default trigger
+ * or the current one if none is available.
+ */
+struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur)
+{
+	struct wacom_led *next_led;
+	int group, next;
+
+	if (!wacom || !cur)
+		return NULL;
+
+	group = cur->group;
+	next = cur->id;
+
+	do {
+		next_led = wacom_led_find(wacom, group, ++next);
+		if (!next_led || next_led == cur)
+			return next_led;
+	} while (next_led->cdev.trigger != &next_led->trigger);
+
+	return next_led;
+}
+
 static void wacom_led_groups_release(void *data)
 {
 	struct wacom *wacom = data;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6904e9b..a2b9c09 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2764,11 +2764,64 @@ static void wacom_setup_numbered_buttons(struct input_dev *input_dev,
 		__set_bit(BTN_BASE + (i-16), input_dev->keybit);
 }
 
+static bool wacom_is_led_toggled(struct wacom *wacom, int button_count,
+				 int mask, int group)
+{
+	int button_per_group;
+
+	button_per_group = button_count/wacom->led.count;
+
+	return mask & (1 << (group * button_per_group));
+}
+
+static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
+			     int group)
+{
+	struct wacom_led *led, *next_led;
+	int cur;
+	bool pressed;
+
+	pressed = wacom_is_led_toggled(wacom, button_count, mask, group);
+	cur = wacom->led.groups[group].select;
+
+	led = wacom_led_find(wacom, group, cur);
+	if (!led) {
+		hid_err(wacom->hdev, "can't find current LED %d in group %d\n",
+			cur, group);
+		return;
+	}
+
+	if (!pressed) {
+		led->held = false;
+		return;
+	}
+
+	if (led->held && pressed)
+		return;
+
+	next_led = wacom_led_next(wacom, led);
+	if (!next_led) {
+		hid_err(wacom->hdev, "can't find next LED in group %d\n",
+			group);
+		return;
+	}
+	if (next_led == led)
+		return;
+
+	next_led->held = true;
+	led_trigger_event(&next_led->trigger,
+			  wacom_leds_brightness_get(next_led));
+}
+
 static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 				int button_count, int mask)
 {
+	struct wacom *wacom = input_get_drvdata(input_dev);
 	int i;
 
+	for (i = 0; i < wacom->led.count; i++)
+		wacom_update_led(wacom,  button_count, mask, i);
+
 	for (i = 0; i < button_count && i < 10; i++)
 		input_report_key(input_dev, BTN_0 + i, mask & (1 << i));
 	for (i = 10; i < button_count && i < 16; i++)
-- 
2.5.5

