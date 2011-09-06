From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 14/15] HID: wiimote: Read wiimote battery charge level
Date: Tue,  6 Sep 2011 13:50:39 +0200
Message-ID: <1315309840-4664-15-git-send-email-dh.herrmann@googlemail.com>
References: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44212 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296Ab1IFLv2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 07:51:28 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4508571fxh.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 04:51:27 -0700 (PDT)
In-Reply-To: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

This registers a power_supply device for every remote to retrieve the current
battery charge level. Since this information is not sent by the wiimote
continously, we need to explicitely request it.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/Kconfig       |    1 +
 drivers/hid/hid-wiimote.c |   60 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1130a89..9907dc9 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -590,6 +590,7 @@ config HID_WIIMOTE
 	tristate "Nintendo Wii Remote support"
 	depends on BT_HIDP
 	depends on LEDS_CLASS
+	select POWER_SUPPLY
 	---help---
 	Support for the Nintendo Wii Remote bluetooth device.
 
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 48198cb..c83cafa 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -17,6 +17,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/power_supply.h>
 #include <linux/spinlock.h>
 #include "hid-ids.h"
 
@@ -51,6 +52,7 @@ struct wiimote_data {
 	struct led_classdev *leds[4];
 	struct input_dev *accel;
 	struct input_dev *ir;
+	struct power_supply battery;
 
 	spinlock_t qlock;
 	__u8 head;
@@ -133,6 +135,10 @@ static __u16 wiiproto_keymap[] = {
 	BTN_MODE,	/* WIIPROTO_KEY_HOME */
 };
 
+static enum power_supply_property wiimote_battery_props[] = {
+	POWER_SUPPLY_PROP_CAPACITY
+};
+
 /* requires the state.lock spinlock to be held */
 static inline bool wiimote_cmd_pending(struct wiimote_data *wdata, int cmd,
 								__u32 opt)
@@ -453,6 +459,43 @@ static int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 	return ret;
 }
 
+static int wiimote_battery_get_property(struct power_supply *psy,
+						enum power_supply_property psp,
+						union power_supply_propval *val)
+{
+	struct wiimote_data *wdata = container_of(psy,
+						struct wiimote_data, battery);
+	int ret = 0, state;
+	unsigned long flags;
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
+	ret = wiimote_cmd_wait(wdata);
+	state = wdata->state.cmd_battery;
+	wiimote_cmd_release(wdata);
+
+	if (ret)
+		return ret;
+
+	switch (psp) {
+		case POWER_SUPPLY_PROP_CAPACITY:
+			val->intval = state * 100 / 255;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+	}
+
+	return ret;
+}
+
 static int wiimote_init_ir(struct wiimote_data *wdata, __u16 mode)
 {
 	int ret;
@@ -1155,6 +1198,7 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 {
 	wiimote_leds_destroy(wdata);
 
+	power_supply_unregister(&wdata->battery);
 	input_unregister_device(wdata->accel);
 	input_unregister_device(wdata->ir);
 	input_unregister_device(wdata->input);
@@ -1206,6 +1250,19 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_input;
 	}
 
+	wdata->battery.properties = wiimote_battery_props;
+	wdata->battery.num_properties = ARRAY_SIZE(wiimote_battery_props);
+	wdata->battery.get_property = wiimote_battery_get_property;
+	wdata->battery.name = "wiimote_battery";
+	wdata->battery.type = POWER_SUPPLY_TYPE_BATTERY;
+	wdata->battery.use_for_apm = 0;
+
+	ret = power_supply_register(&wdata->hdev->dev, &wdata->battery);
+	if (ret) {
+		hid_err(hdev, "Cannot register battery device\n");
+		goto err_battery;
+	}
+
 	ret = wiimote_leds_create(wdata);
 	if (ret)
 		goto err_free;
@@ -1223,6 +1280,9 @@ err_free:
 	wiimote_destroy(wdata);
 	return ret;
 
+err_battery:
+	input_unregister_device(wdata->input);
+	wdata->input = NULL;
 err_input:
 	input_unregister_device(wdata->ir);
 	wdata->ir = NULL;
-- 
1.7.6.1

