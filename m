From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 12/26] HID: wiimote: convert IR to module
Date: Sun,  5 May 2013 23:12:56 +0200
Message-ID: <1367788390-29835-13-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:58092 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab3EEVOD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:14:03 -0400
Received: by mail-bk0-f54.google.com with SMTP id y8so1335837bkt.41
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:14:01 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

IR is the last piece that still is handled natively. This patch converts
it into a sub-device module like all other sub-devices. It mainly moves
code and doesn't change semantics.

We also implicitly sync IR data on ir_to_input3 now so the explicit
input_sync() calls are no longer needed.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    | 233 +++------------------------------
 drivers/hid/hid-wiimote-modules.c | 263 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   3 +
 3 files changed, 287 insertions(+), 212 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 7c703e1..1ea70c8 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -250,7 +250,7 @@ void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel)
 	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
 }
 
-static void wiiproto_req_ir1(struct wiimote_data *wdata, __u8 flags)
+void wiiproto_req_ir1(struct wiimote_data *wdata, __u8 flags)
 {
 	__u8 cmd[2];
 
@@ -261,7 +261,7 @@ static void wiiproto_req_ir1(struct wiimote_data *wdata, __u8 flags)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
-static void wiiproto_req_ir2(struct wiimote_data *wdata, __u8 flags)
+void wiiproto_req_ir2(struct wiimote_data *wdata, __u8 flags)
 {
 	__u8 cmd[2];
 
@@ -416,132 +416,6 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata)
 	return WIIMOTE_EXT_UNKNOWN;
 }
 
-static int wiimote_init_ir(struct wiimote_data *wdata, __u16 mode)
-{
-	int ret;
-	unsigned long flags;
-	__u8 format = 0;
-	static const __u8 data_enable[] = { 0x01 };
-	static const __u8 data_sens1[] = { 0x02, 0x00, 0x00, 0x71, 0x01,
-						0x00, 0xaa, 0x00, 0x64 };
-	static const __u8 data_sens2[] = { 0x63, 0x03 };
-	static const __u8 data_fin[] = { 0x08 };
-
-	spin_lock_irqsave(&wdata->state.lock, flags);
-
-	if (mode == (wdata->state.flags & WIIPROTO_FLAGS_IR)) {
-		spin_unlock_irqrestore(&wdata->state.lock, flags);
-		return 0;
-	}
-
-	if (mode == 0) {
-		wdata->state.flags &= ~WIIPROTO_FLAGS_IR;
-		wiiproto_req_ir1(wdata, 0);
-		wiiproto_req_ir2(wdata, 0);
-		wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
-		spin_unlock_irqrestore(&wdata->state.lock, flags);
-		return 0;
-	}
-
-	spin_unlock_irqrestore(&wdata->state.lock, flags);
-
-	ret = wiimote_cmd_acquire(wdata);
-	if (ret)
-		return ret;
-
-	/* send PIXEL CLOCK ENABLE cmd first */
-	spin_lock_irqsave(&wdata->state.lock, flags);
-	wiimote_cmd_set(wdata, WIIPROTO_REQ_IR1, 0);
-	wiiproto_req_ir1(wdata, 0x06);
-	spin_unlock_irqrestore(&wdata->state.lock, flags);
-
-	ret = wiimote_cmd_wait(wdata);
-	if (ret)
-		goto unlock;
-	if (wdata->state.cmd_err) {
-		ret = -EIO;
-		goto unlock;
-	}
-
-	/* enable IR LOGIC */
-	spin_lock_irqsave(&wdata->state.lock, flags);
-	wiimote_cmd_set(wdata, WIIPROTO_REQ_IR2, 0);
-	wiiproto_req_ir2(wdata, 0x06);
-	spin_unlock_irqrestore(&wdata->state.lock, flags);
-
-	ret = wiimote_cmd_wait(wdata);
-	if (ret)
-		goto unlock;
-	if (wdata->state.cmd_err) {
-		ret = -EIO;
-		goto unlock;
-	}
-
-	/* enable IR cam but do not make it send data, yet */
-	ret = wiimote_cmd_write(wdata, 0xb00030, data_enable,
-							sizeof(data_enable));
-	if (ret)
-		goto unlock;
-
-	/* write first sensitivity block */
-	ret = wiimote_cmd_write(wdata, 0xb00000, data_sens1,
-							sizeof(data_sens1));
-	if (ret)
-		goto unlock;
-
-	/* write second sensitivity block */
-	ret = wiimote_cmd_write(wdata, 0xb0001a, data_sens2,
-							sizeof(data_sens2));
-	if (ret)
-		goto unlock;
-
-	/* put IR cam into desired state */
-	switch (mode) {
-		case WIIPROTO_FLAG_IR_FULL:
-			format = 5;
-			break;
-		case WIIPROTO_FLAG_IR_EXT:
-			format = 3;
-			break;
-		case WIIPROTO_FLAG_IR_BASIC:
-			format = 1;
-			break;
-	}
-	ret = wiimote_cmd_write(wdata, 0xb00033, &format, sizeof(format));
-	if (ret)
-		goto unlock;
-
-	/* make IR cam send data */
-	ret = wiimote_cmd_write(wdata, 0xb00030, data_fin, sizeof(data_fin));
-	if (ret)
-		goto unlock;
-
-	/* request new DRM mode compatible to IR mode */
-	spin_lock_irqsave(&wdata->state.lock, flags);
-	wdata->state.flags &= ~WIIPROTO_FLAGS_IR;
-	wdata->state.flags |= mode & WIIPROTO_FLAGS_IR;
-	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
-	spin_unlock_irqrestore(&wdata->state.lock, flags);
-
-unlock:
-	wiimote_cmd_release(wdata);
-	return ret;
-}
-
-static int wiimote_ir_open(struct input_dev *dev)
-{
-	struct wiimote_data *wdata = input_get_drvdata(dev);
-
-	return wiimote_init_ir(wdata, WIIPROTO_FLAG_IR_BASIC);
-}
-
-static void wiimote_ir_close(struct input_dev *dev)
-{
-	struct wiimote_data *wdata = input_get_drvdata(dev);
-
-	wiimote_init_ir(wdata, 0);
-}
-
 /* device module handling */
 
 static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
@@ -560,6 +434,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_LED3,
 		WIIMOD_LED4,
 		WIIMOD_ACCEL,
+		WIIMOD_IR,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN10] = (const __u8[]){
@@ -571,6 +446,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_LED3,
 		WIIMOD_LED4,
 		WIIMOD_ACCEL,
+		WIIMOD_IR,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GEN20] = (const __u8[]){
@@ -582,6 +458,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_LED3,
 		WIIMOD_LED4,
 		WIIMOD_ACCEL,
+		WIIMOD_IR,
 		WIIMOD_NULL,
 	},
 };
@@ -812,43 +689,25 @@ static void handler_accel(struct wiimote_data *wdata, const __u8 *payload)
 	}
 }
 
-#define ir_to_input0(wdata, ir, packed) __ir_to_input((wdata), (ir), (packed), \
-							ABS_HAT0X, ABS_HAT0Y)
-#define ir_to_input1(wdata, ir, packed) __ir_to_input((wdata), (ir), (packed), \
-							ABS_HAT1X, ABS_HAT1Y)
-#define ir_to_input2(wdata, ir, packed) __ir_to_input((wdata), (ir), (packed), \
-							ABS_HAT2X, ABS_HAT2Y)
-#define ir_to_input3(wdata, ir, packed) __ir_to_input((wdata), (ir), (packed), \
-							ABS_HAT3X, ABS_HAT3Y)
-
-static void __ir_to_input(struct wiimote_data *wdata, const __u8 *ir,
-						bool packed, __u8 xid, __u8 yid)
-{
-	__u16 x, y;
-
-	if (!(wdata->state.flags & WIIPROTO_FLAGS_IR))
-		return;
+#define ir_to_input0(wdata, ir, packed) handler_ir((wdata), (ir), (packed), 0)
+#define ir_to_input1(wdata, ir, packed) handler_ir((wdata), (ir), (packed), 1)
+#define ir_to_input2(wdata, ir, packed) handler_ir((wdata), (ir), (packed), 2)
+#define ir_to_input3(wdata, ir, packed) handler_ir((wdata), (ir), (packed), 3)
 
-	/*
-	 * Basic IR data is encoded into 3 bytes. The first two bytes are the
-	 * lower 8 bit of the X/Y data, the 3rd byte contains the upper 2 bits
-	 * of both.
-	 * If data is packed, then the 3rd byte is put first and slightly
-	 * reordered. This allows to interleave packed and non-packed data to
-	 * have two IR sets in 5 bytes instead of 6.
-	 * The resulting 10bit X/Y values are passed to the ABS_HATXY input dev.
-	 */
+static void handler_ir(struct wiimote_data *wdata, const __u8 *payload,
+		       bool packed, unsigned int id)
+{
+	const __u8 *iter, *mods;
+	const struct wiimod_ops *ops;
 
-	if (packed) {
-		x = ir[1] | ((ir[0] & 0x03) << 8);
-		y = ir[2] | ((ir[0] & 0x0c) << 6);
-	} else {
-		x = ir[0] | ((ir[2] & 0x30) << 4);
-		y = ir[1] | ((ir[2] & 0xc0) << 2);
+	mods = wiimote_devtype_mods[wdata->state.devtype];
+	for (iter = mods; *iter != WIIMOD_NULL; ++iter) {
+		ops = wiimod_table[*iter];
+		if (ops->in_ir) {
+			ops->in_ir(wdata, payload, packed, id);
+			break;
+		}
 	}
-
-	input_report_abs(wdata->ir, xid, x);
-	input_report_abs(wdata->ir, yid, y);
 }
 
 /* reduced status report with "BB BB" key data only */
@@ -943,7 +802,6 @@ static void handler_drm_KAI(struct wiimote_data *wdata, const __u8 *payload)
 	ir_to_input1(wdata, &payload[8], false);
 	ir_to_input2(wdata, &payload[11], false);
 	ir_to_input3(wdata, &payload[14], false);
-	input_sync(wdata->ir);
 }
 
 static void handler_drm_KEE(struct wiimote_data *wdata, const __u8 *payload)
@@ -959,7 +817,6 @@ static void handler_drm_KIE(struct wiimote_data *wdata, const __u8 *payload)
 	ir_to_input1(wdata, &payload[4], true);
 	ir_to_input2(wdata, &payload[7], false);
 	ir_to_input3(wdata, &payload[9], true);
-	input_sync(wdata->ir);
 	wiiext_handle(wdata, &payload[12]);
 }
 
@@ -978,7 +835,6 @@ static void handler_drm_KAIE(struct wiimote_data *wdata, const __u8 *payload)
 	ir_to_input1(wdata, &payload[7], true);
 	ir_to_input2(wdata, &payload[10], false);
 	ir_to_input3(wdata, &payload[12], true);
-	input_sync(wdata->ir);
 	wiiext_handle(wdata, &payload[15]);
 }
 
@@ -997,7 +853,6 @@ static void handler_drm_SKAI1(struct wiimote_data *wdata, const __u8 *payload)
 
 	ir_to_input0(wdata, &payload[3], false);
 	ir_to_input1(wdata, &payload[12], false);
-	input_sync(wdata->ir);
 }
 
 static void handler_drm_SKAI2(struct wiimote_data *wdata, const __u8 *payload)
@@ -1018,7 +873,6 @@ static void handler_drm_SKAI2(struct wiimote_data *wdata, const __u8 *payload)
 
 	ir_to_input2(wdata, &payload[3], false);
 	ir_to_input3(wdata, &payload[12], false);
-	input_sync(wdata->ir);
 }
 
 struct wiiproto_handler {
@@ -1096,38 +950,6 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	wdata->hdev = hdev;
 	hid_set_drvdata(hdev, wdata);
 
-	wdata->ir = input_allocate_device();
-	if (!wdata->ir)
-		goto err;
-
-	input_set_drvdata(wdata->ir, wdata);
-	wdata->ir->open = wiimote_ir_open;
-	wdata->ir->close = wiimote_ir_close;
-	wdata->ir->dev.parent = &wdata->hdev->dev;
-	wdata->ir->id.bustype = wdata->hdev->bus;
-	wdata->ir->id.vendor = wdata->hdev->vendor;
-	wdata->ir->id.product = wdata->hdev->product;
-	wdata->ir->id.version = wdata->hdev->version;
-	wdata->ir->name = WIIMOTE_NAME " IR";
-
-	set_bit(EV_ABS, wdata->ir->evbit);
-	set_bit(ABS_HAT0X, wdata->ir->absbit);
-	set_bit(ABS_HAT0Y, wdata->ir->absbit);
-	set_bit(ABS_HAT1X, wdata->ir->absbit);
-	set_bit(ABS_HAT1Y, wdata->ir->absbit);
-	set_bit(ABS_HAT2X, wdata->ir->absbit);
-	set_bit(ABS_HAT2Y, wdata->ir->absbit);
-	set_bit(ABS_HAT3X, wdata->ir->absbit);
-	set_bit(ABS_HAT3Y, wdata->ir->absbit);
-	input_set_abs_params(wdata->ir, ABS_HAT0X, 0, 1023, 2, 4);
-	input_set_abs_params(wdata->ir, ABS_HAT0Y, 0, 767, 2, 4);
-	input_set_abs_params(wdata->ir, ABS_HAT1X, 0, 1023, 2, 4);
-	input_set_abs_params(wdata->ir, ABS_HAT1Y, 0, 767, 2, 4);
-	input_set_abs_params(wdata->ir, ABS_HAT2X, 0, 1023, 2, 4);
-	input_set_abs_params(wdata->ir, ABS_HAT2Y, 0, 767, 2, 4);
-	input_set_abs_params(wdata->ir, ABS_HAT3X, 0, 1023, 2, 4);
-	input_set_abs_params(wdata->ir, ABS_HAT3Y, 0, 767, 2, 4);
-
 	spin_lock_init(&wdata->queue.lock);
 	INIT_WORK(&wdata->queue.worker, wiimote_queue_worker);
 
@@ -1140,10 +962,6 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	INIT_WORK(&wdata->init_worker, wiimote_init_worker);
 
 	return wdata;
-
-err:
-	kfree(wdata);
-	return NULL;
 }
 
 static void wiimote_destroy(struct wiimote_data *wdata)
@@ -1153,7 +971,6 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 
 	cancel_work_sync(&wdata->init_worker);
 	wiimote_modules_unload(wdata);
-	input_unregister_device(wdata->ir);
 	cancel_work_sync(&wdata->queue.worker);
 	hid_hw_close(wdata->hdev);
 	hid_hw_stop(wdata->hdev);
@@ -1193,12 +1010,6 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
-	ret = input_register_device(wdata->ir);
-	if (ret) {
-		hid_err(hdev, "Cannot register input device\n");
-		goto err_ir;
-	}
-
 	ret = wiiext_init(wdata);
 	if (ret)
 		goto err_free;
@@ -1218,8 +1029,6 @@ err_free:
 	wiimote_destroy(wdata);
 	return ret;
 
-err_ir:
-	hid_hw_close(hdev);
 err_stop:
 	hid_hw_stop(hdev);
 err:
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index fbc09c8..5cc593a 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -526,6 +526,268 @@ static const struct wiimod_ops wiimod_accel = {
 	.in_accel = wiimod_accel_in_accel,
 };
 
+/*
+ * IR Cam
+ * Up to 4 IR sources can be tracked by a normal Wii Remote. The IR cam needs
+ * to be initialized with a fairly complex procedure and consumes a lot of
+ * power. Therefore, as long as no application uses the IR input device, it is
+ * kept offline.
+ * Nearly no other device than the normal Wii Remotes supports the IR cam so
+ * you can disable this module for these devices.
+ */
+
+static void wiimod_ir_in_ir(struct wiimote_data *wdata, const __u8 *ir,
+			    bool packed, unsigned int id)
+{
+	__u16 x, y;
+	__u8 xid, yid;
+	bool sync = false;
+
+	if (!(wdata->state.flags & WIIPROTO_FLAGS_IR))
+		return;
+
+	switch (id) {
+	case 0:
+		xid = ABS_HAT0X;
+		yid = ABS_HAT0Y;
+		break;
+	case 1:
+		xid = ABS_HAT1X;
+		yid = ABS_HAT1Y;
+		break;
+	case 2:
+		xid = ABS_HAT2X;
+		yid = ABS_HAT2Y;
+		break;
+	case 3:
+		xid = ABS_HAT3X;
+		yid = ABS_HAT3Y;
+		sync = true;
+		break;
+	default:
+		return;
+	};
+
+	/*
+	 * Basic IR data is encoded into 3 bytes. The first two bytes are the
+	 * lower 8 bit of the X/Y data, the 3rd byte contains the upper 2 bits
+	 * of both.
+	 * If data is packed, then the 3rd byte is put first and slightly
+	 * reordered. This allows to interleave packed and non-packed data to
+	 * have two IR sets in 5 bytes instead of 6.
+	 * The resulting 10bit X/Y values are passed to the ABS_HAT? input dev.
+	 */
+
+	if (packed) {
+		x = ir[1] | ((ir[0] & 0x03) << 8);
+		y = ir[2] | ((ir[0] & 0x0c) << 6);
+	} else {
+		x = ir[0] | ((ir[2] & 0x30) << 4);
+		y = ir[1] | ((ir[2] & 0xc0) << 2);
+	}
+
+	input_report_abs(wdata->ir, xid, x);
+	input_report_abs(wdata->ir, yid, y);
+
+	if (sync)
+		input_sync(wdata->ir);
+}
+
+static int wiimod_ir_change(struct wiimote_data *wdata, __u16 mode)
+{
+	int ret;
+	unsigned long flags;
+	__u8 format = 0;
+	static const __u8 data_enable[] = { 0x01 };
+	static const __u8 data_sens1[] = { 0x02, 0x00, 0x00, 0x71, 0x01,
+						0x00, 0xaa, 0x00, 0x64 };
+	static const __u8 data_sens2[] = { 0x63, 0x03 };
+	static const __u8 data_fin[] = { 0x08 };
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+
+	if (mode == (wdata->state.flags & WIIPROTO_FLAGS_IR)) {
+		spin_unlock_irqrestore(&wdata->state.lock, flags);
+		return 0;
+	}
+
+	if (mode == 0) {
+		wdata->state.flags &= ~WIIPROTO_FLAGS_IR;
+		wiiproto_req_ir1(wdata, 0);
+		wiiproto_req_ir2(wdata, 0);
+		wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+		spin_unlock_irqrestore(&wdata->state.lock, flags);
+		return 0;
+	}
+
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	ret = wiimote_cmd_acquire(wdata);
+	if (ret)
+		return ret;
+
+	/* send PIXEL CLOCK ENABLE cmd first */
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiimote_cmd_set(wdata, WIIPROTO_REQ_IR1, 0);
+	wiiproto_req_ir1(wdata, 0x06);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	ret = wiimote_cmd_wait(wdata);
+	if (ret)
+		goto unlock;
+	if (wdata->state.cmd_err) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	/* enable IR LOGIC */
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiimote_cmd_set(wdata, WIIPROTO_REQ_IR2, 0);
+	wiiproto_req_ir2(wdata, 0x06);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	ret = wiimote_cmd_wait(wdata);
+	if (ret)
+		goto unlock;
+	if (wdata->state.cmd_err) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	/* enable IR cam but do not make it send data, yet */
+	ret = wiimote_cmd_write(wdata, 0xb00030, data_enable,
+							sizeof(data_enable));
+	if (ret)
+		goto unlock;
+
+	/* write first sensitivity block */
+	ret = wiimote_cmd_write(wdata, 0xb00000, data_sens1,
+							sizeof(data_sens1));
+	if (ret)
+		goto unlock;
+
+	/* write second sensitivity block */
+	ret = wiimote_cmd_write(wdata, 0xb0001a, data_sens2,
+							sizeof(data_sens2));
+	if (ret)
+		goto unlock;
+
+	/* put IR cam into desired state */
+	switch (mode) {
+		case WIIPROTO_FLAG_IR_FULL:
+			format = 5;
+			break;
+		case WIIPROTO_FLAG_IR_EXT:
+			format = 3;
+			break;
+		case WIIPROTO_FLAG_IR_BASIC:
+			format = 1;
+			break;
+	}
+	ret = wiimote_cmd_write(wdata, 0xb00033, &format, sizeof(format));
+	if (ret)
+		goto unlock;
+
+	/* make IR cam send data */
+	ret = wiimote_cmd_write(wdata, 0xb00030, data_fin, sizeof(data_fin));
+	if (ret)
+		goto unlock;
+
+	/* request new DRM mode compatible to IR mode */
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags &= ~WIIPROTO_FLAGS_IR;
+	wdata->state.flags |= mode & WIIPROTO_FLAGS_IR;
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+unlock:
+	wiimote_cmd_release(wdata);
+	return ret;
+}
+
+static int wiimod_ir_open(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+
+	return wiimod_ir_change(wdata, WIIPROTO_FLAG_IR_BASIC);
+}
+
+static void wiimod_ir_close(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+
+	wiimod_ir_change(wdata, 0);
+}
+
+static int wiimod_ir_probe(const struct wiimod_ops *ops,
+			   struct wiimote_data *wdata)
+{
+	int ret;
+
+	wdata->ir = input_allocate_device();
+	if (!wdata->ir)
+		return -ENOMEM;
+
+	input_set_drvdata(wdata->ir, wdata);
+	wdata->ir->open = wiimod_ir_open;
+	wdata->ir->close = wiimod_ir_close;
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
+	ret = input_register_device(wdata->ir);
+	if (ret) {
+		hid_err(wdata->hdev, "cannot register input device\n");
+		goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	input_free_device(wdata->ir);
+	wdata->ir = NULL;
+	return ret;
+}
+
+static void wiimod_ir_remove(const struct wiimod_ops *ops,
+			     struct wiimote_data *wdata)
+{
+	if (!wdata->ir)
+		return;
+
+	input_unregister_device(wdata->ir);
+	wdata->ir = NULL;
+}
+
+static const struct wiimod_ops wiimod_ir = {
+	.flags = 0,
+	.arg = 0,
+	.probe = wiimod_ir_probe,
+	.remove = wiimod_ir_remove,
+	.in_ir = wiimod_ir_in_ir,
+};
+
 /* module table */
 
 const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
@@ -537,4 +799,5 @@ const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
 	[WIIMOD_LED3] = &wiimod_leds[2],
 	[WIIMOD_LED4] = &wiimod_leds[3],
 	[WIIMOD_ACCEL] = &wiimod_accel,
+	[WIIMOD_IR] = &wiimod_ir,
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 8c242e6..3a2d3a1 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -134,6 +134,7 @@ enum wiimod_module {
 	WIIMOD_LED3,
 	WIIMOD_LED4,
 	WIIMOD_ACCEL,
+	WIIMOD_IR,
 	WIIMOD_NUM,
 	WIIMOD_NULL = WIIMOD_NUM,
 };
@@ -193,6 +194,8 @@ extern void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble);
 extern void wiiproto_req_leds(struct wiimote_data *wdata, int leds);
 extern void wiiproto_req_status(struct wiimote_data *wdata);
 extern void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel);
+extern void wiiproto_req_ir1(struct wiimote_data *wdata, __u8 flags);
+extern void wiiproto_req_ir2(struct wiimote_data *wdata, __u8 flags);
 extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 						const __u8 *wmem, __u8 size);
 extern ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset,
-- 
1.8.2.2

