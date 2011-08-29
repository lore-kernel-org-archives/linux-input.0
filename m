From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 05/14] HID: wiimote: Add IR input device
Date: Mon, 29 Aug 2011 15:38:02 +0200
Message-ID: <1314625091-1405-6-git-send-email-dh.herrmann@googlemail.com>
References: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab1H2Nih (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 09:38:37 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4422164fxh.19
        for <linux-input@vger.kernel.org>; Mon, 29 Aug 2011 06:38:37 -0700 (PDT)
In-Reply-To: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, oliver@neukum.org, David Herrmann <dh.herrmann@googlemail.com>

The IR cam of the wiimote reports 4 trackable lights as absolute values. Since
we can turn the IR cam on and off, we register a separate input device so we can
react on open/close callbacks to save wiimote battery power when IR cam is not
needed.

The cam can be in four states: off, basic, extended and full
The DRM chooser automatically selects a proper DRM that includes all required IR
data so no information is lost.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   71 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index de9aadf..4cdaaf6 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -38,6 +38,7 @@ struct wiimote_data {
 	struct input_dev *input;
 	struct led_classdev *leds[4];
 	struct input_dev *accel;
+	struct input_dev *ir;
 
 	spinlock_t qlock;
 	__u8 head;
@@ -54,8 +55,13 @@ struct wiimote_data {
 #define WIIPROTO_FLAG_LED4		0x08
 #define WIIPROTO_FLAG_RUMBLE		0x10
 #define WIIPROTO_FLAG_ACCEL		0x20
+#define WIIPROTO_FLAG_IR_BASIC		0x40
+#define WIIPROTO_FLAG_IR_EXT		0x80
+#define WIIPROTO_FLAG_IR_FULL		0xc0 /* IR_BASIC | IR_EXT */
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
+#define WIIPROTO_FLAGS_IR (WIIPROTO_FLAG_IR_BASIC | WIIPROTO_FLAG_IR_EXT | \
+							WIIPROTO_FLAG_IR_FULL)
 
 /* return flag for led \num */
 #define WIIPROTO_FLAG_LED(num) (WIIPROTO_FLAG_LED1 << (num - 1))
@@ -71,6 +77,7 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_DRM_KA = 0x31,
 	WIIPROTO_REQ_DRM_KAI = 0x33,
 	WIIPROTO_REQ_DRM_KAE = 0x35,
+	WIIPROTO_REQ_DRM_KIE = 0x36,
 	WIIPROTO_REQ_DRM_KAIE = 0x37,
 	WIIPROTO_REQ_DRM_SKAI1 = 0x3e,
 	WIIPROTO_REQ_DRM_SKAI2 = 0x3f,
@@ -248,10 +255,23 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
  */
 static __u8 select_drm(struct wiimote_data *wdata)
 {
-	if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
-		return WIIPROTO_REQ_DRM_KA;
-	else
-		return WIIPROTO_REQ_DRM_K;
+	__u8 ir = wdata->state.flags & WIIPROTO_FLAGS_IR;
+
+	if (ir == WIIPROTO_FLAG_IR_BASIC) {
+		if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
+			return WIIPROTO_REQ_DRM_KAIE;
+		else
+			return WIIPROTO_REQ_DRM_KIE;
+	} else if (ir == WIIPROTO_FLAG_IR_EXT) {
+		return WIIPROTO_REQ_DRM_KAI;
+	} else if (ir == WIIPROTO_FLAG_IR_FULL) {
+		return WIIPROTO_REQ_DRM_SKAI1;
+	} else {
+		if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
+			return WIIPROTO_REQ_DRM_KA;
+		else
+			return WIIPROTO_REQ_DRM_K;
+	}
 }
 
 static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
@@ -681,6 +701,36 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	input_set_abs_params(wdata->accel, ABS_RY, -500, 500, 2, 4);
 	input_set_abs_params(wdata->accel, ABS_RZ, -500, 500, 2, 4);
 
+	wdata->ir = input_allocate_device();
+	if (!wdata->ir)
+		goto err_ir;
+
+	input_set_drvdata(wdata->ir, wdata);
+	wdata->ir->dev.parent = &wdata->hdev->dev;
+	wdata->ir->id.bustype = wdata->hdev->bus;
+	wdata->ir->id.vendor = wdata->hdev->vendor;
+	wdata->ir->id.product = wdata->hdev->product;
+	wdata->ir->id.version = wdata->hdev->version;
+	wdata->ir->name = WIIMOTE_NAME " IR";
+
+	set_bit(EV_ABS, wdata->ir->evbit);
+	set_bit(ABS_HAT0X, wdata->ir->absbit);
+	set_bit(ABS_HAT0Y, wdata->ir->absbit);
+	set_bit(ABS_HAT1X, wdata->ir->absbit);
+	set_bit(ABS_HAT1Y, wdata->ir->absbit);
+	set_bit(ABS_HAT2X, wdata->ir->absbit);
+	set_bit(ABS_HAT2Y, wdata->ir->absbit);
+	set_bit(ABS_HAT3X, wdata->ir->absbit);
+	set_bit(ABS_HAT3Y, wdata->ir->absbit);
+	input_set_abs_params(wdata->ir, ABS_HAT0X, 0, 1023, 2, 4);
+	input_set_abs_params(wdata->ir, ABS_HAT0Y, 0, 767, 2, 4);
+	input_set_abs_params(wdata->ir, ABS_HAT1X, 0, 1023, 2, 4);
+	input_set_abs_params(wdata->ir, ABS_HAT1Y, 0, 767, 2, 4);
+	input_set_abs_params(wdata->ir, ABS_HAT2X, 0, 1023, 2, 4);
+	input_set_abs_params(wdata->ir, ABS_HAT2Y, 0, 767, 2, 4);
+	input_set_abs_params(wdata->ir, ABS_HAT3X, 0, 1023, 2, 4);
+	input_set_abs_params(wdata->ir, ABS_HAT3Y, 0, 767, 2, 4);
+
 	spin_lock_init(&wdata->qlock);
 	INIT_WORK(&wdata->worker, wiimote_worker);
 
@@ -688,6 +738,8 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 
 	return wdata;
 
+err_ir:
+	input_free_device(wdata->accel);
 err_input:
 	input_free_device(wdata->input);
 err:
@@ -700,6 +752,7 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 	wiimote_leds_destroy(wdata);
 
 	input_unregister_device(wdata->accel);
+	input_unregister_device(wdata->ir);
 	input_unregister_device(wdata->input);
 	cancel_work_sync(&wdata->worker);
 	hid_hw_stop(wdata->hdev);
@@ -737,6 +790,12 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
+	ret = input_register_device(wdata->ir);
+	if (ret) {
+		hid_err(hdev, "Cannot register input device\n");
+		goto err_ir;
+	}
+
 	ret = input_register_device(wdata->input);
 	if (ret) {
 		hid_err(hdev, "Cannot register input device\n");
@@ -761,11 +820,15 @@ err_free:
 	return ret;
 
 err_input:
+	input_unregister_device(wdata->ir);
+	wdata->ir = NULL;
+err_ir:
 	input_unregister_device(wdata->accel);
 	wdata->accel = NULL;
 err_stop:
 	hid_hw_stop(hdev);
 err:
+	input_free_device(wdata->ir);
 	input_free_device(wdata->accel);
 	input_free_device(wdata->input);
 	kfree(wdata);
-- 
1.7.6.1

