From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 03/15] HID: wiimote: Add accelerometer input device
Date: Tue,  6 Sep 2011 13:50:28 +0200
Message-ID: <1315309840-4664-4-git-send-email-dh.herrmann@googlemail.com>
References: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44212 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab1IFLvO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 07:51:14 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4508571fxh.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 04:51:13 -0700 (PDT)
In-Reply-To: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Add new input device for every wiimote which is used to report accelerometer
data to userspace. Only if the input device is currently open, we make the
wiimote send accelerometer data. This saves a whole lot of energy on the wiimote
if an application is only interested in button input reports.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   99 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 57faac5..9fb7bd6 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -36,6 +36,7 @@ struct wiimote_data {
 	struct hid_device *hdev;
 	struct input_dev *input;
 	struct led_classdev *leds[4];
+	struct input_dev *accel;
 
 	spinlock_t qlock;
 	__u8 head;
@@ -51,6 +52,7 @@ struct wiimote_data {
 #define WIIPROTO_FLAG_LED3		0x04
 #define WIIPROTO_FLAG_LED4		0x08
 #define WIIPROTO_FLAG_RUMBLE		0x10
+#define WIIPROTO_FLAG_ACCEL		0x20
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
 
@@ -257,6 +259,20 @@ static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
+static void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel)
+{
+	accel = !!accel;
+	if (accel == !!(wdata->state.flags & WIIPROTO_FLAG_ACCEL))
+		return;
+
+	if (accel)
+		wdata->state.flags |= WIIPROTO_FLAG_ACCEL;
+	else
+		wdata->state.flags &= ~WIIPROTO_FLAG_ACCEL;
+
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+}
+
 static enum led_brightness wiimote_leds_get(struct led_classdev *led_dev)
 {
 	struct wiimote_data *wdata;
@@ -344,6 +360,35 @@ static void wiimote_input_close(struct input_dev *dev)
 	hid_hw_close(wdata->hdev);
 }
 
+static int wiimote_accel_open(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	int ret;
+	unsigned long flags;
+
+	ret = hid_hw_open(wdata->hdev);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiiproto_req_accel(wdata, true);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static void wiimote_accel_close(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiiproto_req_accel(wdata, false);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	hid_hw_close(wdata->hdev);
+}
+
 static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 {
 	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_LEFT],
@@ -490,10 +535,8 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 		return NULL;
 
 	wdata->input = input_allocate_device();
-	if (!wdata->input) {
-		kfree(wdata);
-		return NULL;
-	}
+	if (!wdata->input)
+		goto err;
 
 	wdata->hdev = hdev;
 	hid_set_drvdata(hdev, wdata);
@@ -513,11 +556,30 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 		set_bit(wiiproto_keymap[i], wdata->input->keybit);
 
 	set_bit(FF_RUMBLE, wdata->input->ffbit);
-	if (input_ff_create_memless(wdata->input, NULL, wiimote_ff_play)) {
-		input_free_device(wdata->input);
-		kfree(wdata);
-		return NULL;
-	}
+	if (input_ff_create_memless(wdata->input, NULL, wiimote_ff_play))
+		goto err_input;
+
+	wdata->accel = input_allocate_device();
+	if (!wdata->accel)
+		goto err_input;
+
+	input_set_drvdata(wdata->accel, wdata);
+	wdata->accel->open = wiimote_accel_open;
+	wdata->accel->close = wiimote_accel_close;
+	wdata->accel->dev.parent = &wdata->hdev->dev;
+	wdata->accel->id.bustype = wdata->hdev->bus;
+	wdata->accel->id.vendor = wdata->hdev->vendor;
+	wdata->accel->id.product = wdata->hdev->product;
+	wdata->accel->id.version = wdata->hdev->version;
+	wdata->accel->name = WIIMOTE_NAME " Accelerometer";
+
+	set_bit(EV_ABS, wdata->accel->evbit);
+	set_bit(ABS_RX, wdata->accel->absbit);
+	set_bit(ABS_RY, wdata->accel->absbit);
+	set_bit(ABS_RZ, wdata->accel->absbit);
+	input_set_abs_params(wdata->accel, ABS_RX, -500, 500, 2, 4);
+	input_set_abs_params(wdata->accel, ABS_RY, -500, 500, 2, 4);
+	input_set_abs_params(wdata->accel, ABS_RZ, -500, 500, 2, 4);
 
 	spin_lock_init(&wdata->qlock);
 	INIT_WORK(&wdata->worker, wiimote_worker);
@@ -525,12 +587,19 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	spin_lock_init(&wdata->state.lock);
 
 	return wdata;
+
+err_input:
+	input_free_device(wdata->input);
+err:
+	kfree(wdata);
+	return NULL;
 }
 
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
 	wiimote_leds_destroy(wdata);
 
+	input_unregister_device(wdata->accel);
 	input_unregister_device(wdata->input);
 	cancel_work_sync(&wdata->worker);
 	hid_hw_stop(wdata->hdev);
@@ -562,12 +631,18 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err;
 	}
 
-	ret = input_register_device(wdata->input);
+	ret = input_register_device(wdata->accel);
 	if (ret) {
 		hid_err(hdev, "Cannot register input device\n");
 		goto err_stop;
 	}
 
+	ret = input_register_device(wdata->input);
+	if (ret) {
+		hid_err(hdev, "Cannot register input device\n");
+		goto err_input;
+	}
+
 	ret = wiimote_leds_create(wdata);
 	if (ret)
 		goto err_free;
@@ -585,9 +660,13 @@ err_free:
 	wiimote_destroy(wdata);
 	return ret;
 
+err_input:
+	input_unregister_device(wdata->accel);
+	wdata->accel = NULL;
 err_stop:
 	hid_hw_stop(hdev);
 err:
+	input_free_device(wdata->accel);
 	input_free_device(wdata->input);
 	kfree(wdata);
 	return ret;
-- 
1.7.6.1

