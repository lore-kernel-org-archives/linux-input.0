From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 14/21] HID: wiimote: add Balance Board support
Date: Sat, 13 Apr 2013 12:47:55 +0200
Message-ID: <1365850082-3585-15-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:64238 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab3DMKsw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:52 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so1553802eek.4
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:50 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

This adds Nintendo Wii Balance Board support to the new HOTPLUG capable
wiimote core. It is mostly copied from the old extension.

This also adds Balance Board device detection. Whenever we find a device
that supports the balance-board extension, we assume that it is a real
balance board and disable unsupported hardward like accelerometer, IR,
rumble and more.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    |  23 +++++
 drivers/hid/hid-wiimote-modules.c | 211 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   9 ++
 3 files changed, 243 insertions(+)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 1f7a550..573f439 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -198,6 +198,14 @@ static __u8 select_drm(struct wiimote_data *wdata)
 	ext = (wdata->state.flags & WIIPROTO_FLAG_EXT_USED) ||
 	      (wdata->state.flags & WIIPROTO_FLAG_MP_USED);
 
+	/* some 3rd-party balance-boards are hard-coded to KEE, *sigh* */
+	if (wdata->state.devtype == WIIMOTE_DEV_BALANCE_BOARD) {
+		if (ext)
+			return WIIPROTO_REQ_DRM_KEE;
+		else
+			return WIIPROTO_REQ_DRM_K;
+	}
+
 	if (ir == WIIPROTO_FLAG_IR_BASIC) {
 		if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
 			return WIIPROTO_REQ_DRM_KAIE;
@@ -425,6 +433,9 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata, __u8 *rmem)
 	    rmem[3] == 0xff && rmem[4] == 0xff && rmem[5] == 0xff)
 		return WIIMOTE_EXT_NONE;
 
+	if (rmem[4] == 0x04 && rmem[5] == 0x02)
+		return WIIMOTE_EXT_BALANCE_BOARD;
+
 	return WIIMOTE_EXT_UNKNOWN;
 }
 
@@ -556,6 +567,11 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_IR,
 		WIIMOD_NULL,
 	},
+	[WIIMOTE_DEV_BALANCE_BOARD] = (const __u8[]) {
+		WIIMOD_BATTERY,
+		WIIMOD_LED1,
+		WIIMOD_NULL,
+	},
 };
 
 static void wiimote_modules_load(struct wiimote_data *wdata,
@@ -739,6 +755,7 @@ static const char *wiimote_devtype_names[WIIMOTE_DEV_NUM] = {
 	[WIIMOTE_DEV_GENERIC] = "Generic",
 	[WIIMOTE_DEV_GEN10] = "Nintendo Wii Remote (Gen 1)",
 	[WIIMOTE_DEV_GEN20] = "Nintendo Wii Remote Plus (Gen 2)",
+	[WIIMOTE_DEV_BALANCE_BOARD] = "Nintendo Wii Balance Board",
 };
 
 /* Try to guess the device type based on all collected information. We
@@ -756,6 +773,11 @@ static void wiimote_init_set_type(struct wiimote_data *wdata,
 	product = wdata->hdev->product;
 	name = wdata->hdev->name;
 
+	if (exttype == WIIMOTE_EXT_BALANCE_BOARD) {
+		devtype = WIIMOTE_DEV_BALANCE_BOARD;
+		goto done;
+	}
+
 	if (vendor == USB_VENDOR_ID_NINTENDO) {
 		if (product == USB_DEVICE_ID_NINTENDO_WIIMOTE) {
 			devtype = WIIMOTE_DEV_GEN10;
@@ -984,6 +1006,7 @@ out_release:
 static const char *wiimote_exttype_names[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_NONE] = "None",
 	[WIIMOTE_EXT_UNKNOWN] = "Unknown",
+	[WIIMOTE_EXT_BALANCE_BOARD] = "Nintendo Wii Balance Board",
 };
 
 /*
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index d3eef77..6239cd8 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -789,6 +789,216 @@ static const struct wiimod_ops wiimod_ir = {
 };
 
 /*
+ * Balance Board Extension
+ * The Nintendo Wii Balance Board provides four hardware weight sensor plus a
+ * single push button. No other peripherals are available. However, the
+ * balance-board data is sent via a standard Wii Remote extension. All other
+ * data for non-present hardware is zeroed out.
+ * Some 3rd party devices react allergic if we try to access normal Wii Remote
+ * hardware, so this extension module should be the only module that is loaded
+ * on balance boards.
+ * The balance board needs 8 bytes extension data instead of basic 6 bytes so
+ * it needs the WIIMOD_FLAG_EXT8 flag.
+ */
+
+static void wiimod_bboard_in_keys(struct wiimote_data *wdata, const __u8 *keys)
+{
+	input_report_key(wdata->extension.input, BTN_A,
+			 !!(keys[1] & 0x08));
+	input_sync(wdata->extension.input);
+}
+
+static void wiimod_bboard_in_ext(struct wiimote_data *wdata,
+				 const __u8 *ext)
+{
+	__s32 val[4], tmp, div;
+	unsigned int i;
+	struct wiimote_state *s = &wdata->state;
+
+	/*
+	 * Balance board data layout:
+	 *
+	 *   Byte |  8  7  6  5  4  3  2  1  |
+	 *   -----+--------------------------+
+	 *    1   |    Top Right <15:8>      |
+	 *    2   |    Top Right  <7:0>      |
+	 *   -----+--------------------------+
+	 *    3   | Bottom Right <15:8>      |
+	 *    4   | Bottom Right  <7:0>      |
+	 *   -----+--------------------------+
+	 *    5   |     Top Left <15:8>      |
+	 *    6   |     Top Left  <7:0>      |
+	 *   -----+--------------------------+
+	 *    7   |  Bottom Left <15:8>      |
+	 *    8   |  Bottom Left  <7:0>      |
+	 *   -----+--------------------------+
+	 *
+	 * These values represent the weight-measurements of the Wii-balance
+	 * board with 16bit precision.
+	 *
+	 * The balance-board is never reported interleaved with motionp.
+	 */
+
+	val[0] = ext[0];
+	val[0] <<= 8;
+	val[0] |= ext[1];
+
+	val[1] = ext[2];
+	val[1] <<= 8;
+	val[1] |= ext[3];
+
+	val[2] = ext[4];
+	val[2] <<= 8;
+	val[2] |= ext[5];
+
+	val[3] = ext[6];
+	val[3] <<= 8;
+	val[3] |= ext[7];
+
+	/* apply calibration data */
+	for (i = 0; i < 4; i++) {
+		if (val[i] <= s->calib_bboard[i][0]) {
+			tmp = 0;
+		} else if (val[i] < s->calib_bboard[i][1]) {
+			tmp = val[i] - s->calib_bboard[i][0];
+			tmp *= 1700;
+			div = s->calib_bboard[i][1] - s->calib_bboard[i][0];
+			tmp /= div ? div : 1;
+		} else {
+			tmp = val[i] - s->calib_bboard[i][1];
+			tmp *= 1700;
+			div = s->calib_bboard[i][2] - s->calib_bboard[i][1];
+			tmp /= div ? div : 1;
+			tmp += 1700;
+		}
+		val[i] = tmp;
+	}
+
+	input_report_abs(wdata->extension.input, ABS_HAT0X, val[0]);
+	input_report_abs(wdata->extension.input, ABS_HAT0Y, val[1]);
+	input_report_abs(wdata->extension.input, ABS_HAT1X, val[2]);
+	input_report_abs(wdata->extension.input, ABS_HAT1Y, val[3]);
+	input_sync(wdata->extension.input);
+}
+
+static int wiimod_bboard_open(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags |= WIIPROTO_FLAG_EXT_USED;
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static void wiimod_bboard_close(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags &= ~WIIPROTO_FLAG_EXT_USED;
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static int wiimod_bboard_probe(const struct wiimod_ops *ops,
+			       struct wiimote_data *wdata)
+{
+	int ret, i, j;
+	__u8 buf[24], offs;
+
+	wiimote_cmd_acquire_noint(wdata);
+
+	ret = wiimote_cmd_read(wdata, 0xa40024, buf, 12);
+	if (ret != 12) {
+		wiimote_cmd_release(wdata);
+		return ret < 0 ? ret : -EIO;
+	}
+	ret = wiimote_cmd_read(wdata, 0xa40024 + 12, buf + 12, 12);
+	if (ret != 12) {
+		wiimote_cmd_release(wdata);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	wiimote_cmd_release(wdata);
+
+	offs = 0;
+	for (i = 0; i < 3; ++i) {
+		for (j = 0; j < 4; ++j) {
+			wdata->state.calib_bboard[j][i] = buf[offs];
+			wdata->state.calib_bboard[j][i] <<= 8;
+			wdata->state.calib_bboard[j][i] |= buf[offs + 1];
+			offs += 2;
+		}
+	}
+
+	wdata->extension.input = input_allocate_device();
+	if (!wdata->extension.input)
+		return -ENOMEM;
+
+	input_set_drvdata(wdata->extension.input, wdata);
+	wdata->extension.input->open = wiimod_bboard_open;
+	wdata->extension.input->close = wiimod_bboard_close;
+	wdata->extension.input->dev.parent = &wdata->hdev->dev;
+	wdata->extension.input->id.bustype = wdata->hdev->bus;
+	wdata->extension.input->id.vendor = wdata->hdev->vendor;
+	wdata->extension.input->id.product = wdata->hdev->product;
+	wdata->extension.input->id.version = wdata->hdev->version;
+	wdata->extension.input->name = WIIMOTE_NAME " Balance Board";
+
+	set_bit(EV_KEY, wdata->extension.input->evbit);
+	set_bit(BTN_A, wdata->extension.input->keybit);
+
+	set_bit(EV_ABS, wdata->extension.input->evbit);
+	set_bit(ABS_HAT0X, wdata->extension.input->absbit);
+	set_bit(ABS_HAT0Y, wdata->extension.input->absbit);
+	set_bit(ABS_HAT1X, wdata->extension.input->absbit);
+	set_bit(ABS_HAT1Y, wdata->extension.input->absbit);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT0X, 0, 65535, 2, 4);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT0Y, 0, 65535, 2, 4);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT1X, 0, 65535, 2, 4);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT1Y, 0, 65535, 2, 4);
+
+	ret = input_register_device(wdata->extension.input);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	input_free_device(wdata->extension.input);
+	wdata->extension.input = NULL;
+	return ret;
+}
+
+static void wiimod_bboard_remove(const struct wiimod_ops *ops,
+				 struct wiimote_data *wdata)
+{
+	if (!wdata->extension.input)
+		return;
+
+	input_unregister_device(wdata->extension.input);
+	wdata->extension.input = NULL;
+}
+
+static const struct wiimod_ops wiimod_bboard = {
+	.flags = WIIMOD_FLAG_EXT8,
+	.arg = 0,
+	.probe = wiimod_bboard_probe,
+	.remove = wiimod_bboard_remove,
+	.in_keys = wiimod_bboard_in_keys,
+	.in_ext = wiimod_bboard_in_ext,
+};
+
+/*
  * Motion Plus
  */
 
@@ -816,4 +1026,5 @@ const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
 const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_NONE] = &wiimod_dummy,
 	[WIIMOTE_EXT_UNKNOWN] = &wiimod_dummy,
+	[WIIMOTE_EXT_BALANCE_BOARD] = &wiimod_bboard,
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 2b0d00c..79dbeac 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -73,12 +73,14 @@ enum wiimote_devtype {
 	WIIMOTE_DEV_GENERIC,
 	WIIMOTE_DEV_GEN10,
 	WIIMOTE_DEV_GEN20,
+	WIIMOTE_DEV_BALANCE_BOARD,
 	WIIMOTE_DEV_NUM,
 };
 
 enum wiimote_exttype {
 	WIIMOTE_EXT_NONE,
 	WIIMOTE_EXT_UNKNOWN,
+	WIIMOTE_EXT_BALANCE_BOARD,
 	WIIMOTE_EXT_NUM,
 };
 
@@ -123,6 +125,9 @@ struct wiimote_state {
 	__u8 cmd_err;
 	__u8 *cmd_read_buf;
 	__u8 cmd_read_size;
+
+	/* calibration data */
+	__u16 calib_bboard[4][3];
 };
 
 struct wiimote_data {
@@ -136,6 +141,10 @@ struct wiimote_data {
 	struct wiimote_ext *ext;
 	struct wiimote_debug *debug;
 
+	union {
+		struct input_dev *input;
+	} extension;
+
 	struct wiimote_queue queue;
 	struct wiimote_state state;
 	struct work_struct init_worker;
-- 
1.8.2.1

