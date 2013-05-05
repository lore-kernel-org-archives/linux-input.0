From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 04/26] HID: wiimote: add device detection
Date: Sun,  5 May 2013 23:12:48 +0200
Message-ID: <1367788390-29835-5-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:54187 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab3EEVNt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:13:49 -0400
Received: by mail-bk0-f42.google.com with SMTP id j4so1353297bkw.1
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:13:47 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Nintendo produced many different devices that are internally based on the
Wii Remote protocol but provide different peripherals. To support these
devices, we need to schedule a device detection during initialization.

Device detection includes requesting a status report, reading extension
information and then evaluating which device we may be dealing with.

We currently detect gen1 and gen2 Wii Remote devices. All other devices
are marked as generic devices. More detections will be added later.

In followup patches we will be using these device IDs to control which
peripherals to initialize. For instance if a device is known to have no IR
camera, there is no need to provide the IR input device nor trying to
access IR registers. In fact, there are 3rd party devices that break if we
try things like this (hurray!).

The init_worker will be scheduled whenever we get hotplug events. This
isn't implemented, yet and will be added later. However, we need to make
sure that this worker can be called multiple times.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 153 ++++++++++++++++++++++++++++++++++++++++-
 drivers/hid/hid-wiimote.h      |  37 +++++++++-
 2 files changed, 188 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 02656a8..76d2c73 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -399,6 +399,45 @@ ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset, __u8 *rmem,
 	return ret;
 }
 
+/* requires the cmd-mutex to be held */
+static int wiimote_cmd_init_ext(struct wiimote_data *wdata)
+{
+	__u8 wmem;
+	int ret;
+
+	/* initialize extension */
+	wmem = 0x55;
+	ret = wiimote_cmd_write(wdata, 0xa400f0, &wmem, sizeof(wmem));
+	if (ret)
+		return ret;
+
+	/* disable default encryption */
+	wmem = 0x0;
+	ret = wiimote_cmd_write(wdata, 0xa400fb, &wmem, sizeof(wmem));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* requires the cmd-mutex to be held */
+static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata)
+{
+	__u8 rmem[6];
+	int ret;
+
+	/* read extension ID */
+	ret = wiimote_cmd_read(wdata, 0xa400fa, rmem, 6);
+	if (ret != 6)
+		return WIIMOTE_EXT_NONE;
+
+	if (rmem[0] == 0xff && rmem[1] == 0xff && rmem[2] == 0xff &&
+	    rmem[3] == 0xff && rmem[4] == 0xff && rmem[5] == 0xff)
+		return WIIMOTE_EXT_NONE;
+
+	return WIIMOTE_EXT_UNKNOWN;
+}
+
 static int wiimote_battery_get_property(struct power_supply *psy,
 						enum power_supply_property psp,
 						union power_supply_propval *val)
@@ -662,6 +701,105 @@ static void wiimote_ir_close(struct input_dev *dev)
 	wiimote_init_ir(wdata, 0);
 }
 
+/* device (re-)initialization and detection */
+
+static const char *wiimote_devtype_names[WIIMOTE_DEV_NUM] = {
+	[WIIMOTE_DEV_PENDING] = "Pending",
+	[WIIMOTE_DEV_UNKNOWN] = "Unknown",
+	[WIIMOTE_DEV_GENERIC] = "Generic",
+	[WIIMOTE_DEV_GEN10] = "Nintendo Wii Remote (Gen 1)",
+	[WIIMOTE_DEV_GEN20] = "Nintendo Wii Remote Plus (Gen 2)",
+};
+
+/* Try to guess the device type based on all collected information. We
+ * first try to detect by static extension types, then VID/PID and the
+ * device name. If we cannot detect the device, we use
+ * WIIMOTE_DEV_GENERIC so all modules will get probed on the device. */
+static void wiimote_init_set_type(struct wiimote_data *wdata,
+				  __u8 exttype)
+{
+	__u8 devtype = WIIMOTE_DEV_GENERIC;
+	__u16 vendor, product;
+	const char *name;
+
+	vendor = wdata->hdev->vendor;
+	product = wdata->hdev->product;
+	name = wdata->hdev->name;
+
+	if (!strcmp(name, "Nintendo RVL-CNT-01")) {
+		devtype = WIIMOTE_DEV_GEN10;
+		goto done;
+	} else if (!strcmp(name, "Nintendo RVL-CNT-01-TR")) {
+		devtype = WIIMOTE_DEV_GEN20;
+		goto done;
+	}
+
+	if (vendor == USB_VENDOR_ID_NINTENDO) {
+		if (product == USB_DEVICE_ID_NINTENDO_WIIMOTE) {
+			devtype = WIIMOTE_DEV_GEN10;
+			goto done;
+		} else if (product == USB_DEVICE_ID_NINTENDO_WIIMOTE2) {
+			devtype = WIIMOTE_DEV_GEN20;
+			goto done;
+		}
+	}
+
+done:
+	if (devtype == WIIMOTE_DEV_GENERIC)
+		hid_info(wdata->hdev, "cannot detect device; NAME: %s VID: %04x PID: %04x EXT: %04x\n",
+			name, vendor, product, exttype);
+	else
+		hid_info(wdata->hdev, "detected device: %s\n",
+			 wiimote_devtype_names[devtype]);
+
+	spin_lock_irq(&wdata->state.lock);
+	wdata->state.devtype = devtype;
+	spin_unlock_irq(&wdata->state.lock);
+}
+
+static void wiimote_init_detect(struct wiimote_data *wdata)
+{
+	__u8 exttype = WIIMOTE_EXT_NONE;
+	bool ext;
+	int ret;
+
+	wiimote_cmd_acquire_noint(wdata);
+
+	spin_lock_irq(&wdata->state.lock);
+	wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
+	wiiproto_req_status(wdata);
+	spin_unlock_irq(&wdata->state.lock);
+
+	ret = wiimote_cmd_wait_noint(wdata);
+	if (ret)
+		goto out_release;
+
+	spin_lock_irq(&wdata->state.lock);
+	ext = wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED;
+	spin_unlock_irq(&wdata->state.lock);
+
+	if (!ext)
+		goto out_release;
+
+	wiimote_cmd_init_ext(wdata);
+	exttype = wiimote_cmd_read_ext(wdata);
+
+out_release:
+	wiimote_cmd_release(wdata);
+	wiimote_init_set_type(wdata, exttype);
+}
+
+static void wiimote_init_worker(struct work_struct *work)
+{
+	struct wiimote_data *wdata = container_of(work, struct wiimote_data,
+						  init_worker);
+
+	if (wdata->state.devtype == WIIMOTE_DEV_PENDING)
+		wiimote_init_detect(wdata);
+}
+
+/* protocol handlers */
+
 static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 {
 	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_LEFT],
@@ -776,7 +914,14 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_status_K(wdata, payload);
 
-	wiiext_event(wdata, payload[2] & 0x02);
+	/* update extension status */
+	if (payload[2] & 0x02) {
+		wdata->state.flags |= WIIPROTO_FLAG_EXT_PLUGGED;
+		wiiext_event(wdata, true);
+	} else {
+		wdata->state.flags &= ~WIIPROTO_FLAG_EXT_PLUGGED;
+		wiiext_event(wdata, false);
+	}
 
 	if (wiimote_cmd_pending(wdata, WIIPROTO_REQ_SREQ, 0)) {
 		wdata->state.cmd_battery = payload[5];
@@ -1135,6 +1280,8 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	mutex_init(&wdata->state.sync);
 	wdata->state.drm = WIIPROTO_REQ_DRM_K;
 
+	INIT_WORK(&wdata->init_worker, wiimote_init_worker);
+
 	return wdata;
 
 err_ir:
@@ -1157,6 +1304,7 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 	input_unregister_device(wdata->accel);
 	input_unregister_device(wdata->ir);
 	input_unregister_device(wdata->input);
+	cancel_work_sync(&wdata->init_worker);
 	cancel_work_sync(&wdata->queue.worker);
 	hid_hw_close(wdata->hdev);
 	hid_hw_stop(wdata->hdev);
@@ -1253,6 +1401,9 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
 	spin_unlock_irq(&wdata->state.lock);
 
+	/* schedule device detection */
+	schedule_work(&wdata->init_worker);
+
 	return 0;
 
 err_free:
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 2700d47..301607d 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -35,6 +35,8 @@
 #define WIIPROTO_FLAG_IR_BASIC		0x40
 #define WIIPROTO_FLAG_IR_EXT		0x80
 #define WIIPROTO_FLAG_IR_FULL		0xc0 /* IR_BASIC | IR_EXT */
+#define WIIPROTO_FLAG_EXT_PLUGGED	0x0100
+
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
 #define WIIPROTO_FLAGS_IR (WIIPROTO_FLAG_IR_BASIC | WIIPROTO_FLAG_IR_EXT | \
@@ -43,6 +45,21 @@
 /* return flag for led \num */
 #define WIIPROTO_FLAG_LED(num) (WIIPROTO_FLAG_LED1 << (num - 1))
 
+enum wiimote_devtype {
+	WIIMOTE_DEV_PENDING,
+	WIIMOTE_DEV_UNKNOWN,
+	WIIMOTE_DEV_GENERIC,
+	WIIMOTE_DEV_GEN10,
+	WIIMOTE_DEV_GEN20,
+	WIIMOTE_DEV_NUM,
+};
+
+enum wiimote_exttype {
+	WIIMOTE_EXT_NONE,
+	WIIMOTE_EXT_UNKNOWN,
+	WIIMOTE_EXT_NUM,
+};
+
 struct wiimote_buf {
 	__u8 data[HID_MAX_BUFFER_SIZE];
 	size_t size;
@@ -58,9 +75,10 @@ struct wiimote_queue {
 
 struct wiimote_state {
 	spinlock_t lock;
-	__u8 flags;
+	__u32 flags;
 	__u8 accel_split[2];
 	__u8 drm;
+	__u8 devtype;
 
 	/* synchronous cmd requests */
 	struct mutex sync;
@@ -87,6 +105,7 @@ struct wiimote_data {
 
 	struct wiimote_queue queue;
 	struct wiimote_state state;
+	struct work_struct init_worker;
 };
 
 enum wiiproto_reqs {
@@ -181,6 +200,11 @@ static inline int wiimote_cmd_acquire(struct wiimote_data *wdata)
 	return mutex_lock_interruptible(&wdata->state.sync) ? -ERESTARTSYS : 0;
 }
 
+static inline void wiimote_cmd_acquire_noint(struct wiimote_data *wdata)
+{
+	mutex_lock(&wdata->state.sync);
+}
+
 /* requires the state.lock spinlock to be held */
 static inline void wiimote_cmd_set(struct wiimote_data *wdata, int cmd,
 								__u32 opt)
@@ -208,4 +232,15 @@ static inline int wiimote_cmd_wait(struct wiimote_data *wdata)
 		return 0;
 }
 
+static inline int wiimote_cmd_wait_noint(struct wiimote_data *wdata)
+{
+	unsigned long ret;
+
+	ret = wait_for_completion_timeout(&wdata->state.ready, HZ);
+	if (!ret)
+		return -EIO;
+	else
+		return 0;
+}
+
 #endif
-- 
1.8.2.2

