From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 5/7] HID: wiimote: Add force-feedback support
Date: Sat, 13 Aug 2011 15:29:13 +0200
Message-ID: <1313242155-3620-6-git-send-email-dh.herrmann@googlemail.com>
References: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55308 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1HMN3j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Aug 2011 09:29:39 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so2801621fxh.19
        for <linux-input@vger.kernel.org>; Sat, 13 Aug 2011 06:29:38 -0700 (PDT)
In-Reply-To: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com, padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org

The wiimote has a single rumble motor. This adds force feedback support for
wiimote devices with FF_RUMBLE. The rumble motor is very simple and only
supports an on/off switch so no complex ff-effects are supported.

This also removes the event callback that was registered before but unused. The
ff-device overwrites this callback, anyway.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   39 ++++++++++++++++++++++++++++++++-------
 1 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index c18aaaf..4a68565 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -280,6 +280,31 @@ static void wiimote_leds_set(struct led_classdev *led_dev,
 	}
 }
 
+static int wiimote_ff_play(struct input_dev *dev, void *data,
+							struct ff_effect *eff)
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
 #define wiifs_led_show_set(num)						\
 static ssize_t wiifs_led_show_##num(struct device *dev,			\
 			struct device_attribute *attr, char *buf)	\
@@ -312,12 +337,6 @@ wiifs_led_show_set(2);
 wiifs_led_show_set(3);
 wiifs_led_show_set(4);
 
-static int wiimote_input_event(struct input_dev *dev, unsigned int type,
-						unsigned int code, int value)
-{
-	return 0;
-}
-
 static int wiimote_input_open(struct input_dev *dev)
 {
 	struct wiimote_data *wdata = input_get_drvdata(dev);
@@ -465,7 +484,6 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	hid_set_drvdata(hdev, wdata);
 
 	input_set_drvdata(wdata->input, wdata);
-	wdata->input->event = wiimote_input_event;
 	wdata->input->open = wiimote_input_open;
 	wdata->input->close = wiimote_input_close;
 	wdata->input->dev.parent = &wdata->hdev->dev;
@@ -479,6 +497,13 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	for (i = 0; i < WIIPROTO_KEY_COUNT; ++i)
 		set_bit(wiiproto_keymap[i], wdata->input->keybit);
 
+	set_bit(FF_RUMBLE, wdata->input->ffbit);
+	if (input_ff_create_memless(wdata->input, NULL, wiimote_ff_play)) {
+		input_free_device(wdata->input);
+		kfree(wdata);
+		return NULL;
+	}
+
 	spin_lock_init(&wdata->qlock);
 	INIT_WORK(&wdata->worker, wiimote_worker);
 
-- 
1.7.6

