From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH V2 3/5] HID: wiimote: Register led class devices
Date: Wed, 17 Aug 2011 11:43:22 +0200
Message-ID: <1313574204-12664-4-git-send-email-dh.herrmann@googlemail.com>
References: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55339 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab1HQJn6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 05:43:58 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so525065fxh.19
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 02:43:58 -0700 (PDT)
In-Reply-To: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: oliver@neukum.org, jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

This registers 4 led devices to allow controlling the wiimote leds via standard
LED sysfs API. It removes the four sysfs attributes so we don't have two APIs
for one device.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
V2: Remove the four led sysfs attributes in favor of the led class devices.

 drivers/hid/Kconfig       |    1 +
 drivers/hid/hid-wiimote.c |  165 +++++++++++++++++++++++++++++----------------
 2 files changed, 107 insertions(+), 59 deletions(-)

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
index d49f67c..29edd55 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include "hid-ids.h"
@@ -34,6 +35,7 @@ struct wiimote_state {
 struct wiimote_data {
 	struct hid_device *hdev;
 	struct input_dev *input;
+	struct led_classdev *leds[4];
 
 	spinlock_t qlock;
 	__u8 head;
@@ -51,6 +53,9 @@ struct wiimote_data {
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
 
+/* return flag for led \num */
+#define WIIPROTO_FLAG_LED(num) (WIIPROTO_FLAG_LED1 << (num - 1))
+
 enum wiiproto_reqs {
 	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM_K = 0x30,
@@ -85,9 +90,6 @@ static __u16 wiiproto_keymap[] = {
 	BTN_MODE,	/* WIIPROTO_KEY_HOME */
 };
 
-#define dev_to_wii(pdev) hid_get_drvdata(container_of(pdev, struct hid_device, \
-									dev))
-
 static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
 								size_t count)
 {
@@ -190,48 +192,53 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
-#define wiifs_led_show_set(num)						\
-static ssize_t wiifs_led_show_##num(struct device *dev,			\
-			struct device_attribute *attr, char *buf)	\
-{									\
-	struct wiimote_data *wdata = dev_to_wii(dev);			\
-	unsigned long flags;						\
-	int state;							\
-									\
-	spin_lock_irqsave(&wdata->state.lock, flags);			\
-	state = !!(wdata->state.flags & WIIPROTO_FLAG_LED##num);	\
-	spin_unlock_irqrestore(&wdata->state.lock, flags);		\
-									\
-	return sprintf(buf, "%d\n", state);				\
-}									\
-static ssize_t wiifs_led_set_##num(struct device *dev,			\
-	struct device_attribute *attr, const char *buf, size_t count)	\
-{									\
-	struct wiimote_data *wdata = dev_to_wii(dev);			\
-	int tmp = simple_strtoul(buf, NULL, 10);			\
-	unsigned long flags;						\
-	__u8 state;							\
-									\
-	spin_lock_irqsave(&wdata->state.lock, flags);			\
-									\
-	state = wdata->state.flags;					\
-									\
-	if (tmp)							\
-		wiiproto_req_leds(wdata, state | WIIPROTO_FLAG_LED##num);\
-	else								\
-		wiiproto_req_leds(wdata, state & ~WIIPROTO_FLAG_LED##num);\
-									\
-	spin_unlock_irqrestore(&wdata->state.lock, flags);		\
-									\
-	return count;							\
-}									\
-static DEVICE_ATTR(led##num, S_IRUGO | S_IWUSR, wiifs_led_show_##num,	\
-						wiifs_led_set_##num)
-
-wiifs_led_show_set(1);
-wiifs_led_show_set(2);
-wiifs_led_show_set(3);
-wiifs_led_show_set(4);
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
 
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
@@ -315,6 +322,58 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
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
@@ -358,10 +417,7 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
-	device_remove_file(&wdata->hdev->dev, &dev_attr_led1);
-	device_remove_file(&wdata->hdev->dev, &dev_attr_led2);
-	device_remove_file(&wdata->hdev->dev, &dev_attr_led3);
-	device_remove_file(&wdata->hdev->dev, &dev_attr_led4);
+	wiimote_leds_destroy(wdata);
 
 	input_unregister_device(wdata->input);
 	cancel_work_sync(&wdata->worker);
@@ -400,16 +456,7 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
-	ret = device_create_file(&hdev->dev, &dev_attr_led1);
-	if (ret)
-		goto err_free;
-	ret = device_create_file(&hdev->dev, &dev_attr_led2);
-	if (ret)
-		goto err_free;
-	ret = device_create_file(&hdev->dev, &dev_attr_led3);
-	if (ret)
-		goto err_free;
-	ret = device_create_file(&hdev->dev, &dev_attr_led4);
+	ret = wiimote_leds_create(wdata);
 	if (ret)
 		goto err_free;
 
-- 
1.7.6

