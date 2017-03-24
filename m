From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 5/6] HID: sony: Make DS4 bt poll interval adjustable
Date: Fri, 24 Mar 2017 15:17:49 -0700
Message-ID: <20170324221750.19543-6-roderick@gaikai.com>
References: <20170324221750.19543-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36239 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754936AbdCXWSC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 18:18:02 -0400
Received: by mail-it0-f49.google.com with SMTP id w124so22701540itb.1
        for <linux-input@vger.kernel.org>; Fri, 24 Mar 2017 15:18:01 -0700 (PDT)
In-Reply-To: <20170324221750.19543-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

By default when using bluetooth the DS4 reports data at about 1kHz,
which is quite fast especially on weak devices. We now make the
device use the USB poll interval, which is a fixed 4ms. In addition
we make the value adjustable through sysfs.

The error handling in sony_input_configured is a little tricky. It
is not easy to add other goto's as not all codepaths have logic
for adding this attribute. Luckily we are setting the value for the
attribute to a default value, so we can use that to detect if we need
to remove the file.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 79 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2429c0e..cf534a9 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -493,6 +493,9 @@ struct motion_output_report_02 {
 #define SENSOR_SUFFIX " Motion Sensors"
 #define DS4_TOUCHPAD_SUFFIX " Touchpad"
 
+/* Default to 4ms poll interval, which is same as USB (not adjustable). */
+#define DS4_BT_DEFAULT_POLL_INTERVAL_MS 4
+#define DS4_BT_MAX_POLL_INTERVAL_MS 62
 #define DS4_GYRO_RES_PER_DEG_S 1024
 #define DS4_ACC_RES_PER_G      8192
 
@@ -564,6 +567,7 @@ struct sony_sc {
 	u16 prev_timestamp;
 	unsigned int timestamp_us;
 
+	u8 ds4_bt_poll_interval;
 	enum ds4_dongle_state ds4_dongle_state;
 	/* DS4 calibration data */
 	struct ds4_calibration_data ds4_calib_data[6];
@@ -586,6 +590,44 @@ static inline void sony_schedule_work(struct sony_sc *sc,
 	}
 }
 
+static ssize_t ds4_show_poll_interval(struct device *dev,
+				struct device_attribute
+				*attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+
+	return snprintf(buf, PAGE_SIZE, "%i\n", sc->ds4_bt_poll_interval);
+}
+
+static ssize_t ds4_store_poll_interval(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+	unsigned long flags;
+	u8 interval;
+
+	if (kstrtou8(buf, 0, &interval))
+		return -EINVAL;
+
+	if (interval > DS4_BT_MAX_POLL_INTERVAL_MS)
+		return -EINVAL;
+
+	spin_lock_irqsave(&sc->lock, flags);
+	sc->ds4_bt_poll_interval = interval;
+	spin_unlock_irqrestore(&sc->lock, flags);
+
+	sony_schedule_work(sc, SONY_WORKER_STATE);
+
+	return count;
+}
+
+static DEVICE_ATTR(bt_poll_interval, 0644, ds4_show_poll_interval,
+		ds4_store_poll_interval);
+
+
 static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
 			     unsigned int *rsize)
 {
@@ -1985,15 +2027,13 @@ static void dualshock4_send_output_report(struct sony_sc *sc)
 	int offset;
 
 	/*
-	 * NOTE: The buf[1] field of the Bluetooth report controls
-	 * the Dualshock 4 reporting rate.
-	 *
-	 * Known values include:
-	 *
-	 * 0x80 - 1000hz (full speed)
-	 * 0xA0 - 31hz
-	 * 0xB0 - 20hz
-	 * 0xD0 - 66hz
+	 * NOTE: The lower 6 bits of buf[1] field of the Bluetooth report
+	 * control the interval at which Dualshock 4 reports data:
+	 * 0x00 - 1ms
+	 * 0x01 - 1ms
+	 * 0x02 - 2ms
+	 * 0x3E - 62ms
+	 * 0x3F - disabled
 	 */
 	if (sc->quirks & (DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_DONGLE)) {
 		memset(buf, 0, DS4_OUTPUT_REPORT_0x05_SIZE);
@@ -2003,7 +2043,7 @@ static void dualshock4_send_output_report(struct sony_sc *sc)
 	} else {
 		memset(buf, 0, DS4_OUTPUT_REPORT_0x11_SIZE);
 		buf[0] = 0x11;
-		buf[1] = 0xC0; /* HID + CRC */
+		buf[1] = 0xC0 /* HID + CRC */ | sc->ds4_bt_poll_interval;
 		buf[3] = 0x07; /* blink + LEDs + motor */
 		offset = 6;
 	}
@@ -2454,6 +2494,7 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
 		cancel_work_sync(&sc->state_worker);
 }
 
+
 static int sony_input_configured(struct hid_device *hdev,
 					struct hid_input *hidinput)
 {
@@ -2591,6 +2632,15 @@ static int sony_input_configured(struct hid_device *hdev,
 			goto err_stop;
 		}
 
+		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
+			sc->ds4_bt_poll_interval = DS4_BT_DEFAULT_POLL_INTERVAL_MS;
+			ret = device_create_file(&sc->hdev->dev, &dev_attr_bt_poll_interval);
+			if (ret)
+				hid_warn(sc->hdev,
+				 "can't create sysfs bt_poll_interval attribute err: %d\n",
+				 ret);
+		}
+
 		if (sc->quirks & DUALSHOCK4_DONGLE) {
 			INIT_WORK(&sc->hotplug_worker, dualshock4_calibration_work);
 			sc->hotplug_worker_initialized = 1;
@@ -2636,6 +2686,12 @@ static int sony_input_configured(struct hid_device *hdev,
 err_close:
 	hid_hw_close(hdev);
 err_stop:
+	/* Piggy back on the default ds4_bt_ poll_interval to determine
+	 * if we need to remove the file as we don't know for sure if we
+	 * executed that logic.
+	 */
+	if (sc->ds4_bt_poll_interval)
+		device_remove_file(&sc->hdev->dev, &dev_attr_bt_poll_interval);
 	if (sc->quirks & SONY_LED_SUPPORT)
 		sony_leds_remove(sc);
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
@@ -2735,6 +2791,9 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->sensor_dev)
 		sony_unregister_sensors(sc);
 
+	if (sc->quirks & DUALSHOCK4_CONTROLLER_BT)
+		device_remove_file(&sc->hdev->dev, &dev_attr_bt_poll_interval);
+
 	sony_cancel_work_sync(sc);
 
 	kfree(sc->output_report_dmabuf);
-- 
2.9.3

