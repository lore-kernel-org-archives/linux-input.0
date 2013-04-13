From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 11/21] HID: wiimote: convert ACCEL to module
Date: Sat, 13 Apr 2013 12:47:52 +0200
Message-ID: <1365850082-3585-12-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:64700 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3DMKsq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:46 -0400
Received: by mail-ea0-f179.google.com with SMTP id f15so1526498eak.38
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:45 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Accelerometer data is very similar to KEYS handling. Therefore, convert
all ACCEL related handling into a sub-device module similar to KEYS.

This doesn't change any semantics but only moves code over to
wiimote-modules.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    | 101 +++++--------------------------
 drivers/hid/hid-wiimote-modules.c | 123 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   2 +
 3 files changed, 140 insertions(+), 86 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index f0a1d32..d17dd3b 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -236,7 +236,7 @@ void wiiproto_req_status(struct wiimote_data *wdata)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
-static void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel)
+void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel)
 {
 	accel = !!accel;
 	if (accel == !!(wdata->state.flags & WIIPROTO_FLAG_ACCEL))
@@ -528,28 +528,6 @@ unlock:
 	return ret;
 }
 
-static int wiimote_accel_open(struct input_dev *dev)
-{
-	struct wiimote_data *wdata = input_get_drvdata(dev);
-	unsigned long flags;
-
-	spin_lock_irqsave(&wdata->state.lock, flags);
-	wiiproto_req_accel(wdata, true);
-	spin_unlock_irqrestore(&wdata->state.lock, flags);
-
-	return 0;
-}
-
-static void wiimote_accel_close(struct input_dev *dev)
-{
-	struct wiimote_data *wdata = input_get_drvdata(dev);
-	unsigned long flags;
-
-	spin_lock_irqsave(&wdata->state.lock, flags);
-	wiiproto_req_accel(wdata, false);
-	spin_unlock_irqrestore(&wdata->state.lock, flags);
-}
-
 static int wiimote_ir_open(struct input_dev *dev)
 {
 	struct wiimote_data *wdata = input_get_drvdata(dev);
@@ -581,6 +559,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_LED2,
 		WIIMOD_LED3,
 		WIIMOD_LED4,
+		WIIMOD_ACCEL,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN10] = (const __u8[]){
@@ -591,6 +570,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_LED2,
 		WIIMOD_LED3,
 		WIIMOD_LED4,
+		WIIMOD_ACCEL,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN20] = (const __u8[]){
@@ -601,6 +581,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_LED2,
 		WIIMOD_LED3,
 		WIIMOD_LED4,
+		WIIMOD_ACCEL,
 		WIIMOD_NULL,
 	},
 };
@@ -818,35 +799,17 @@ static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 
 static void handler_accel(struct wiimote_data *wdata, const __u8 *payload)
 {
-	__u16 x, y, z;
-
-	if (!(wdata->state.flags & WIIPROTO_FLAG_ACCEL))
-		return;
-
-	/*
-	 * payload is: BB BB XX YY ZZ
-	 * Accelerometer data is encoded into 3 10bit values. XX, YY and ZZ
-	 * contain the upper 8 bits of each value. The lower 2 bits are
-	 * contained in the buttons data BB BB.
-	 * Bits 6 and 7 of the first buttons byte BB is the lower 2 bits of the
-	 * X accel value. Bit 5 of the second buttons byte is the 2nd bit of Y
-	 * accel value and bit 6 is the second bit of the Z value.
-	 * The first bit of Y and Z values is not available and always set to 0.
-	 * 0x200 is returned on no movement.
-	 */
-
-	x = payload[2] << 2;
-	y = payload[3] << 2;
-	z = payload[4] << 2;
-
-	x |= (payload[0] >> 5) & 0x3;
-	y |= (payload[1] >> 4) & 0x2;
-	z |= (payload[1] >> 5) & 0x2;
+	const __u8 *iter, *mods;
+	const struct wiimod_ops *ops;
 
-	input_report_abs(wdata->accel, ABS_RX, x - 0x200);
-	input_report_abs(wdata->accel, ABS_RY, y - 0x200);
-	input_report_abs(wdata->accel, ABS_RZ, z - 0x200);
-	input_sync(wdata->accel);
+	mods = wiimote_devtype_mods[wdata->state.devtype];
+	for (iter = mods; *iter != WIIMOD_NULL; ++iter) {
+		ops = wiimod_table[*iter];
+		if (ops->in_accel) {
+			ops->in_accel(wdata, payload);
+			break;
+		}
+	}
 }
 
 #define ir_to_input0(wdata, ir, packed) __ir_to_input((wdata), (ir), (packed), \
@@ -1133,31 +1096,9 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	wdata->hdev = hdev;
 	hid_set_drvdata(hdev, wdata);
 
-	wdata->accel = input_allocate_device();
-	if (!wdata->accel)
-		goto err;
-
-	input_set_drvdata(wdata->accel, wdata);
-	wdata->accel->open = wiimote_accel_open;
-	wdata->accel->close = wiimote_accel_close;
-	wdata->accel->dev.parent = &wdata->hdev->dev;
-	wdata->accel->id.bustype = wdata->hdev->bus;
-	wdata->accel->id.vendor = wdata->hdev->vendor;
-	wdata->accel->id.product = wdata->hdev->product;
-	wdata->accel->id.version = wdata->hdev->version;
-	wdata->accel->name = WIIMOTE_NAME " Accelerometer";
-
-	set_bit(EV_ABS, wdata->accel->evbit);
-	set_bit(ABS_RX, wdata->accel->absbit);
-	set_bit(ABS_RY, wdata->accel->absbit);
-	set_bit(ABS_RZ, wdata->accel->absbit);
-	input_set_abs_params(wdata->accel, ABS_RX, -500, 500, 2, 4);
-	input_set_abs_params(wdata->accel, ABS_RY, -500, 500, 2, 4);
-	input_set_abs_params(wdata->accel, ABS_RZ, -500, 500, 2, 4);
-
 	wdata->ir = input_allocate_device();
 	if (!wdata->ir)
-		goto err_ir;
+		goto err;
 
 	input_set_drvdata(wdata->ir, wdata);
 	wdata->ir->open = wiimote_ir_open;
@@ -1200,8 +1141,6 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 
 	return wdata;
 
-err_ir:
-	input_free_device(wdata->accel);
 err:
 	kfree(wdata);
 	return NULL;
@@ -1214,7 +1153,6 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 
 	cancel_work_sync(&wdata->init_worker);
 	wiimote_modules_unload(wdata);
-	input_unregister_device(wdata->accel);
 	input_unregister_device(wdata->ir);
 	cancel_work_sync(&wdata->queue.worker);
 	hid_hw_close(wdata->hdev);
@@ -1255,12 +1193,6 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
-	ret = input_register_device(wdata->accel);
-	if (ret) {
-		hid_err(hdev, "Cannot register input device\n");
-		goto err_close;
-	}
-
 	ret = input_register_device(wdata->ir);
 	if (ret) {
 		hid_err(hdev, "Cannot register input device\n");
@@ -1287,9 +1219,6 @@ err_free:
 	return ret;
 
 err_ir:
-	input_unregister_device(wdata->accel);
-	wdata->accel = NULL;
-err_close:
 	hid_hw_close(hdev);
 err_stop:
 	hid_hw_stop(hdev);
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index f96de15..fbc09c8 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -404,6 +404,128 @@ static const struct wiimod_ops wiimod_leds[4] = {
 	},
 };
 
+/*
+ * Accelerometer
+ * 3 axis accelerometer data is part of nearly all DRMs. If not supported by a
+ * device, it's mostly cleared to 0. This module parses this data and provides
+ * it via a separate input device.
+ */
+
+static void wiimod_accel_in_accel(struct wiimote_data *wdata,
+				  const __u8 *accel)
+{
+	__u16 x, y, z;
+
+	if (!(wdata->state.flags & WIIPROTO_FLAG_ACCEL))
+		return;
+
+	/*
+	 * payload is: BB BB XX YY ZZ
+	 * Accelerometer data is encoded into 3 10bit values. XX, YY and ZZ
+	 * contain the upper 8 bits of each value. The lower 2 bits are
+	 * contained in the buttons data BB BB.
+	 * Bits 6 and 7 of the first buttons byte BB is the lower 2 bits of the
+	 * X accel value. Bit 5 of the second buttons byte is the 2nd bit of Y
+	 * accel value and bit 6 is the second bit of the Z value.
+	 * The first bit of Y and Z values is not available and always set to 0.
+	 * 0x200 is returned on no movement.
+	 */
+
+	x = accel[2] << 2;
+	y = accel[3] << 2;
+	z = accel[4] << 2;
+
+	x |= (accel[0] >> 5) & 0x3;
+	y |= (accel[1] >> 4) & 0x2;
+	z |= (accel[1] >> 5) & 0x2;
+
+	input_report_abs(wdata->accel, ABS_RX, x - 0x200);
+	input_report_abs(wdata->accel, ABS_RY, y - 0x200);
+	input_report_abs(wdata->accel, ABS_RZ, z - 0x200);
+	input_sync(wdata->accel);
+}
+
+static int wiimod_accel_open(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiiproto_req_accel(wdata, true);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static void wiimod_accel_close(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiiproto_req_accel(wdata, false);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static int wiimod_accel_probe(const struct wiimod_ops *ops,
+			      struct wiimote_data *wdata)
+{
+	int ret;
+
+	wdata->accel = input_allocate_device();
+	if (!wdata->accel)
+		return -ENOMEM;
+
+	input_set_drvdata(wdata->accel, wdata);
+	wdata->accel->open = wiimod_accel_open;
+	wdata->accel->close = wiimod_accel_close;
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
+
+	ret = input_register_device(wdata->accel);
+	if (ret) {
+		hid_err(wdata->hdev, "cannot register input device\n");
+		goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	input_free_device(wdata->accel);
+	wdata->accel = NULL;
+	return ret;
+}
+
+static void wiimod_accel_remove(const struct wiimod_ops *ops,
+				struct wiimote_data *wdata)
+{
+	if (!wdata->accel)
+		return;
+
+	input_unregister_device(wdata->accel);
+	wdata->accel = NULL;
+}
+
+static const struct wiimod_ops wiimod_accel = {
+	.flags = 0,
+	.arg = 0,
+	.probe = wiimod_accel_probe,
+	.remove = wiimod_accel_remove,
+	.in_accel = wiimod_accel_in_accel,
+};
+
 /* module table */
 
 const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
@@ -414,4 +536,5 @@ const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
 	[WIIMOD_LED2] = &wiimod_leds[1],
 	[WIIMOD_LED3] = &wiimod_leds[2],
 	[WIIMOD_LED4] = &wiimod_leds[3],
+	[WIIMOD_ACCEL] = &wiimod_accel,
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index aef78cb..b787145 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -133,6 +133,7 @@ enum wiimod_module {
 	WIIMOD_LED2,
 	WIIMOD_LED3,
 	WIIMOD_LED4,
+	WIIMOD_ACCEL,
 	WIIMOD_NUM,
 	WIIMOD_NULL = WIIMOD_NUM,
 };
@@ -191,6 +192,7 @@ extern void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm);
 extern void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble);
 extern void wiiproto_req_leds(struct wiimote_data *wdata, int leds);
 extern void wiiproto_req_status(struct wiimote_data *wdata);
+extern void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel);
 extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 						const __u8 *wmem, __u8 size);
 extern ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset,
-- 
1.8.2.1

