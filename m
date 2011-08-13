From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 3/7] HID: wiimote: Register led class devices
Date: Sat, 13 Aug 2011 15:29:11 +0200
Message-ID: <1313242155-3620-4-git-send-email-dh.herrmann@googlemail.com>
References: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55308 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1HMN3g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Aug 2011 09:29:36 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so2801621fxh.19
        for <linux-input@vger.kernel.org>; Sat, 13 Aug 2011 06:29:35 -0700 (PDT)
In-Reply-To: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com, padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org

This registers 4 led devices to allow controlling the wiimote leds via standard
LED sysfs API.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/Kconfig       |    1 +
 drivers/hid/hid-wiimote.c |  130 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 116 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 306b15f..1130a89 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -589,6 +589,7 @@ config HID_WACOM_POWER_SUPPLY
 config HID_WIIMOTE
 	tristate "Nintendo Wii Remote support"
 	depends on BT_HIDP
+	depends on LEDS_CLASS
 	---help---
 	Support for the Nintendo Wii Remote bluetooth device.
 
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index c9793c8..466d45d 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include "hid-ids.h"
@@ -35,6 +36,7 @@ struct wiimote_state {
 struct wiimote_data {
 	struct hid_device *hdev;
 	struct input_dev *input;
+	struct led_classdev *leds[4];
 
 	spinlock_t qlock;
 	__u8 head;
@@ -52,6 +54,9 @@ struct wiimote_data {
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
 
+/* return flag for led \num */
+#define WIIPROTO_FLAG_LED(num) (WIIPROTO_FLAG_LED1 << (num - 1))
+
 enum wiiproto_reqs {
 	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM_K = 0x30,
@@ -191,17 +196,62 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
+static enum led_brightness wiimote_leds_get(struct led_classdev *led_dev)
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
+static void wiimote_leds_set(struct led_classdev *led_dev,
+						enum led_brightness value)
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
 #define wiifs_led_show_set(num)						\
 static ssize_t wiifs_led_show_##num(struct device *dev,			\
 			struct device_attribute *attr, char *buf)	\
 {									\
 	struct wiimote_data *wdata = dev_to_wii(dev);			\
-	unsigned long flags;						\
-	int state;							\
+	bool state;							\
 									\
-	spin_lock_irqsave(&wdata->state.lock, flags);			\
-	state = !!(wdata->state.flags & WIIPROTO_FLAG_LED##num);	\
-	spin_unlock_irqrestore(&wdata->state.lock, flags);		\
+	state = !(wiimote_leds_get(wdata->leds[num - 1]) == LED_OFF);	\
 									\
 	return sprintf(buf, "%d\n", state);				\
 }									\
@@ -210,19 +260,11 @@ static ssize_t wiifs_led_set_##num(struct device *dev,			\
 {									\
 	struct wiimote_data *wdata = dev_to_wii(dev);			\
 	int tmp = simple_strtoul(buf, NULL, 10);			\
-	unsigned long flags;						\
-	__u8 state;							\
-									\
-	spin_lock_irqsave(&wdata->state.lock, flags);			\
-									\
-	state = wdata->state.flags;					\
 									\
 	if (tmp)							\
-		wiiproto_req_leds(wdata, state | WIIPROTO_FLAG_LED##num);\
+		wiimote_leds_set(wdata->leds[num - 1], LED_FULL);	\
 	else								\
-		wiiproto_req_leds(wdata, state & ~WIIPROTO_FLAG_LED##num);\
-									\
-	spin_unlock_irqrestore(&wdata->state.lock, flags);		\
+		wiimote_leds_set(wdata->leds[num - 1], LED_OFF);	\
 									\
 	return count;							\
 }									\
@@ -316,6 +358,58 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
+static void wiimote_leds_destroy(struct wiimote_data *wdata)
+{
+	int i;
+	struct led_classdev *led;
+
+	for (i = 0; i < 4; ++i) {
+		if (wdata->leds[i]) {
+			led = wdata->leds[i];
+			wdata->leds[i] = NULL;
+			led_classdev_unregister(led);
+			kfree(led);
+		}
+	}
+}
+
+static int wiimote_leds_create(struct wiimote_data *wdata)
+{
+	int i, ret;
+	struct device *dev = &wdata->hdev->dev;
+	size_t namesz = strlen(dev_name(dev)) + 9;
+	struct led_classdev *led;
+	char *name;
+
+	for (i = 0; i < 4; ++i) {
+		led = kzalloc(sizeof(struct led_classdev) + namesz, GFP_KERNEL);
+		if (!led) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		name = (void*)&led[1];
+		snprintf(name, namesz, "%s:blue:p%d", dev_name(dev), i);
+		led->name = name;
+		led->brightness = 0;
+		led->max_brightness = 1;
+		led->brightness_get = wiimote_leds_get;
+		led->brightness_set = wiimote_leds_set;
+
+		ret = led_classdev_register(dev, led);
+		if (ret) {
+			kfree(led);
+			goto err;
+		}
+		wdata->leds[i] = led;
+	}
+
+	return 0;
+
+err:
+	wiimote_leds_destroy(wdata);
+	return ret;
+}
+
 static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 {
 	struct wiimote_data *wdata;
@@ -359,6 +453,8 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
+	wiimote_leds_destroy(wdata);
+
 	device_remove_file(&wdata->hdev->dev, &dev_attr_led1);
 	device_remove_file(&wdata->hdev->dev, &dev_attr_led2);
 	device_remove_file(&wdata->hdev->dev, &dev_attr_led3);
@@ -414,6 +510,10 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	if (ret)
 		goto err_free;
 
+	ret = wiimote_leds_create(wdata);
+	if (ret)
+		goto err_free;
+
 	hid_info(hdev, "New device registered\n");
 
 	/* by default set led1 after device initialization */
-- 
1.7.6

