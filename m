From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 11/12] HID: sony: Expose DS3 motion sensors through separate device
Date: Tue,  7 Mar 2017 15:45:10 -0800
Message-ID: <20170307234511.30380-12-roderick@gaikai.com>
References: <20170307234511.30380-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33345 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933283AbdCGXqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-pf0-f173.google.com with SMTP id w189so6663912pfb.0
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 15:45:26 -0800 (PST)
In-Reply-To: <20170307234511.30380-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

This patch adds a separate evdev node for the DS3 its motion
sensors. We only expose the accelerometers as the gyroscope
is extremely difficult to manage and behavior varies a lot
between hardware revisions.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 130 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 105 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b82d05c..f8c4835 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -547,12 +547,15 @@ struct motion_output_report_02 {
 #define DS4_INPUT_REPORT_BATTERY_OFFSET  30
 #define DS4_INPUT_REPORT_TOUCHPAD_OFFSET 33
 
-#define DS4_SENSOR_SUFFIX " Motion Sensors"
+#define SENSOR_SUFFIX " Motion Sensors"
 #define DS4_TOUCHPAD_SUFFIX " Touchpad"
 
 #define DS4_GYRO_RES_PER_DEG_S 1024
 #define DS4_ACC_RES_PER_G      8192
 
+#define SIXAXIS_INPUT_REPORT_ACC_X_OFFSET 41
+#define SIXAXIS_ACC_RES_PER_G 113
+
 static DEFINE_SPINLOCK(sony_dev_list_lock);
 static LIST_HEAD(sony_device_list);
 static DEFINE_IDA(sony_device_id_allocator);
@@ -841,6 +844,23 @@ static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	sc->battery_capacity = battery_capacity;
 	sc->battery_charging = battery_charging;
 	spin_unlock_irqrestore(&sc->lock, flags);
+
+	if (sc->quirks & SIXAXIS_CONTROLLER) {
+		int val;
+
+		offset = SIXAXIS_INPUT_REPORT_ACC_X_OFFSET;
+		val = ((rd[offset+1] << 8) | rd[offset]) - 511;
+		input_report_abs(sc->sensor_dev, ABS_X, val);
+
+		/* Y and Z are swapped and inversed */
+		val = 511 - ((rd[offset+5] << 8) | rd[offset+4]);
+		input_report_abs(sc->sensor_dev, ABS_Y, val);
+
+		val = 511 - ((rd[offset+3] << 8) | rd[offset+2]);
+		input_report_abs(sc->sensor_dev, ABS_Z, val);
+
+		input_sync(sc->sensor_dev);
+	}
 }
 
 static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
@@ -1285,33 +1305,49 @@ static int sony_register_sensors(struct sony_sc *sc)
 	/* Append a suffix to the controller name as there are various
 	 * DS4 compatible non-Sony devices with different names.
 	 */
-	name_sz = strlen(sc->hdev->name) + sizeof(DS4_SENSOR_SUFFIX);
+	name_sz = strlen(sc->hdev->name) + sizeof(SENSOR_SUFFIX);
 	name = kzalloc(name_sz, GFP_KERNEL);
 	if (!name) {
 		ret = -ENOMEM;
 		goto err;
 	}
-	snprintf(name, name_sz, "%s" DS4_SENSOR_SUFFIX, sc->hdev->name);
+	snprintf(name, name_sz, "%s" SENSOR_SUFFIX, sc->hdev->name);
 	sc->sensor_dev->name = name;
 
-	range = DS4_ACC_RES_PER_G*4;
-	input_set_abs_params(sc->sensor_dev, ABS_X, -range, range, 16, 0);
-	input_set_abs_params(sc->sensor_dev, ABS_Y, -range, range, 16, 0);
-	input_set_abs_params(sc->sensor_dev, ABS_Z, -range, range, 16, 0);
-	input_abs_set_res(sc->sensor_dev, ABS_X, DS4_ACC_RES_PER_G);
-	input_abs_set_res(sc->sensor_dev, ABS_Y, DS4_ACC_RES_PER_G);
-	input_abs_set_res(sc->sensor_dev, ABS_Z, DS4_ACC_RES_PER_G);
-
-	range = DS4_GYRO_RES_PER_DEG_S*2048;
-	input_set_abs_params(sc->sensor_dev, ABS_RX, -range, range, 16, 0);
-	input_set_abs_params(sc->sensor_dev, ABS_RY, -range, range, 16, 0);
-	input_set_abs_params(sc->sensor_dev, ABS_RZ, -range, range, 16, 0);
-	input_abs_set_res(sc->sensor_dev, ABS_RX, DS4_GYRO_RES_PER_DEG_S);
-	input_abs_set_res(sc->sensor_dev, ABS_RY, DS4_GYRO_RES_PER_DEG_S);
-	input_abs_set_res(sc->sensor_dev, ABS_RZ, DS4_GYRO_RES_PER_DEG_S);
-
-	__set_bit(EV_MSC, sc->sensor_dev->evbit);
-	__set_bit(MSC_TIMESTAMP, sc->sensor_dev->mscbit);
+	if (sc->quirks & SIXAXIS_CONTROLLER) {
+		/* For the DS3 we only support the accelerometer, which works
+		 * quite well even without calibration. The device also has
+		 * a 1-axis gyro, but it is very difficult to manage from within
+		 * the driver even to get data, the sensor is inaccurate and
+		 * the behavior is very different between hardware revisions.
+		 */
+		input_set_abs_params(sc->sensor_dev, ABS_X, -512, 511, 4, 0);
+		input_set_abs_params(sc->sensor_dev, ABS_Y, -512, 511, 4, 0);
+		input_set_abs_params(sc->sensor_dev, ABS_Z, -512, 511, 4, 0);
+		input_abs_set_res(sc->sensor_dev, ABS_X, SIXAXIS_ACC_RES_PER_G);
+		input_abs_set_res(sc->sensor_dev, ABS_Y, SIXAXIS_ACC_RES_PER_G);
+		input_abs_set_res(sc->sensor_dev, ABS_Z, SIXAXIS_ACC_RES_PER_G);
+	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
+		range = DS4_ACC_RES_PER_G*4;
+		input_set_abs_params(sc->sensor_dev, ABS_X, -range, range, 16, 0);
+		input_set_abs_params(sc->sensor_dev, ABS_Y, -range, range, 16, 0);
+		input_set_abs_params(sc->sensor_dev, ABS_Z, -range, range, 16, 0);
+		input_abs_set_res(sc->sensor_dev, ABS_X, DS4_ACC_RES_PER_G);
+		input_abs_set_res(sc->sensor_dev, ABS_Y, DS4_ACC_RES_PER_G);
+		input_abs_set_res(sc->sensor_dev, ABS_Z, DS4_ACC_RES_PER_G);
+
+		range = DS4_GYRO_RES_PER_DEG_S*2048;
+		input_set_abs_params(sc->sensor_dev, ABS_RX, -range, range, 16, 0);
+		input_set_abs_params(sc->sensor_dev, ABS_RY, -range, range, 16, 0);
+		input_set_abs_params(sc->sensor_dev, ABS_RZ, -range, range, 16, 0);
+		input_abs_set_res(sc->sensor_dev, ABS_RX, DS4_GYRO_RES_PER_DEG_S);
+		input_abs_set_res(sc->sensor_dev, ABS_RY, DS4_GYRO_RES_PER_DEG_S);
+		input_abs_set_res(sc->sensor_dev, ABS_RZ, DS4_GYRO_RES_PER_DEG_S);
+
+		__set_bit(EV_MSC, sc->sensor_dev->evbit);
+		__set_bit(MSC_TIMESTAMP, sc->sensor_dev->mscbit);
+	}
+
 	__set_bit(INPUT_PROP_ACCELEROMETER, sc->sensor_dev->propbit);
 
 	ret = input_register_device(sc->sensor_dev);
@@ -2447,8 +2483,7 @@ static int sony_input_configured(struct hid_device *hdev,
 		goto err_stop;
 	}
 
-	if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
-			(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
+	if (sc->quirks & NAVIGATION_CONTROLLER_USB) {
 		/*
 		 * The Sony Sixaxis does not handle HID Output Reports on the
 		 * Interrupt EP like it could, so we need to force HID Output
@@ -2476,8 +2511,46 @@ static int sony_input_configured(struct hid_device *hdev,
 		}
 
 		sony_init_output_report(sc, sixaxis_send_output_report);
-	} else if ((sc->quirks & SIXAXIS_CONTROLLER_BT) ||
-			(sc->quirks & NAVIGATION_CONTROLLER_BT)) {
+	} else if (sc->quirks & NAVIGATION_CONTROLLER_BT) {
+		/*
+		 * The Navigation controller wants output reports sent on the ctrl
+		 * endpoint when connected via Bluetooth.
+		 */
+		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
+
+		ret = sixaxis_set_operational_bt(hdev);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to set controller into operational mode\n");
+			goto err_stop;
+		}
+
+		sony_init_output_report(sc, sixaxis_send_output_report);
+	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
+		/*
+		 * The Sony Sixaxis does not handle HID Output Reports on the
+		 * Interrupt EP and the device only becomes active when the
+		 * PS button is pressed. See comment for Navigation controller
+		 * above for more details.
+		 */
+		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
+		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
+		sc->defer_initialization = 1;
+
+		ret = sixaxis_set_operational_usb(hdev);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to set controller into operational mode\n");
+			goto err_stop;
+		}
+
+		ret = sony_register_sensors(sc);
+		if (ret) {
+			hid_err(sc->hdev,
+			"Unable to initialize motion sensors: %d\n", ret);
+			goto err_stop;
+		}
+
+		sony_init_output_report(sc, sixaxis_send_output_report);
+	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
 		/*
 		 * The Sixaxis wants output reports sent on the ctrl endpoint
 		 * when connected via Bluetooth.
@@ -2490,6 +2563,13 @@ static int sony_input_configured(struct hid_device *hdev,
 			goto err_stop;
 		}
 
+		ret = sony_register_sensors(sc);
+		if (ret) {
+			hid_err(sc->hdev,
+			"Unable to initialize motion sensors: %d\n", ret);
+			goto err_stop;
+		}
+
 		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		ret = dualshock4_get_calibration_data(sc);
-- 
2.9.3

