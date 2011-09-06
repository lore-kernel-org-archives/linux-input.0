From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 02/15] HID: wiimote: Add force-feedback support
Date: Tue,  6 Sep 2011 13:50:27 +0200
Message-ID: <1315309840-4664-3-git-send-email-dh.herrmann@googlemail.com>
References: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44212 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab1IFLvN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 07:51:13 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4508571fxh.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 04:51:12 -0700 (PDT)
In-Reply-To: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

The wiimote has a single rumble motor. This adds force feedback support for
wiimote devices with FF_RUMBLE. The rumble motor is very simple and only
supports an on/off switch so no complex ff-effects are supported.

This also removes the event callback that was registered before but unused. The
ff-device overwrites this callback, anyway.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 6809754..57faac5 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -305,9 +305,28 @@ static void wiimote_leds_set(struct led_classdev *led_dev,
 	}
 }
 
-static int wiimote_input_event(struct input_dev *dev, unsigned int type,
-						unsigned int code, int value)
+static int wiimote_ff_play(struct input_dev *dev, void *data,
+							struct ff_effect *eff)
 {
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
 	return 0;
 }
 
@@ -480,7 +499,6 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	hid_set_drvdata(hdev, wdata);
 
 	input_set_drvdata(wdata->input, wdata);
-	wdata->input->event = wiimote_input_event;
 	wdata->input->open = wiimote_input_open;
 	wdata->input->close = wiimote_input_close;
 	wdata->input->dev.parent = &wdata->hdev->dev;
@@ -494,6 +512,13 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
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
1.7.6.1

