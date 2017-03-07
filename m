From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH v4 02/12] HID: sony: Calibrate DS4 motion sensors
Date: Tue,  7 Mar 2017 15:45:01 -0800
Message-ID: <20170307234511.30380-3-roderick@gaikai.com>
References: <20170307234511.30380-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34616 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933249AbdCGXqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-pf0-f172.google.com with SMTP id v190so6659425pfb.1
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 15:45:17 -0800 (PST)
In-Reply-To: <20170307234511.30380-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The DS4 motion sensors require calibration for accurate operation.
This patch adds calibration for both the accelerometer and the
gyroscope. Calibration requires reading device specific scaling
factors and offsets. For precision reasons we store these values
as a numerator and denominator and apply the values when processing
the data.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 212 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 184 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f797f5e..1b933ef 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -768,6 +768,7 @@ struct motion_output_report_02 {
 };
 
 #define DS4_FEATURE_REPORT_0x02_SIZE 37
+#define DS4_FEATURE_REPORT_0x05_SIZE 41
 #define DS4_FEATURE_REPORT_0x81_SIZE 7
 #define DS4_INPUT_REPORT_0x11_SIZE 78
 #define DS4_OUTPUT_REPORT_0x05_SIZE 32
@@ -787,10 +788,25 @@ struct motion_output_report_02 {
 #define DS4_SENSOR_SUFFIX " Motion Sensors"
 #define DS4_TOUCHPAD_SUFFIX " Touchpad"
 
+#define DS4_GYRO_RES_PER_DEG_S 1024
+#define DS4_ACC_RES_PER_G      8192
+
 static DEFINE_SPINLOCK(sony_dev_list_lock);
 static LIST_HEAD(sony_device_list);
 static DEFINE_IDA(sony_device_id_allocator);
 
+/* Used for calibration of DS4 accelerometer and gyro. */
+struct ds4_calibration_data {
+	int abs_code;
+	short bias;
+	/* Calibration requires scaling against a sensitivity value, which is a
+	 * float. Store sensitivity as a fraction to limit floating point
+	 * calculations until final calibration.
+	 */
+	int sens_numer;
+	int sens_denom;
+};
+
 struct sony_sc {
 	spinlock_t lock;
 	struct list_head list_node;
@@ -822,6 +838,8 @@ struct sony_sc {
 	u8 led_delay_off[MAX_LEDS];
 	u8 led_count;
 	bool ds4_dongle_connected;
+	/* DS4 calibration data */
+	struct ds4_calibration_data ds4_calib_data[6];
 };
 
 static void sony_set_leds(struct sony_sc *sc);
@@ -1014,9 +1032,6 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	int n, m, offset, num_touch_data, max_touch_data;
 	u8 cable_state, battery_capacity, battery_charging;
 
-	/* Order of hw axes is gyro first, then accelerometer. */
-	int axes[6] = {ABS_RX, ABS_RY, ABS_RZ, ABS_X, ABS_Y, ABS_Z};
-
 	/* When using Bluetooth the header is 2 bytes longer, so skip these. */
 	int data_offset = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 0 : 2;
 
@@ -1025,10 +1040,22 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	input_report_key(sc->touchpad, BTN_LEFT, rd[offset+2] & 0x2);
 
 	offset = data_offset + DS4_INPUT_REPORT_GYRO_X_OFFSET;
-	for (n = 0; n < 6; n++, offset += 2) {
-		short value = get_unaligned_le16(&rd[offset]);
+	for (n = 0; n < 6; n++) {
+		/* Store data in int for more precision during mult_frac. */
+		int raw_data = (short)((rd[offset+1] << 8) | rd[offset]);
+		struct ds4_calibration_data *calib = &sc->ds4_calib_data[n];
+
+		/* High precision is needed during calibration, but the
+		 * calibrated values are within 32-bit.
+		 * Note: we swap numerator 'x' and 'numer' in mult_frac for
+		 *       precision reasons so we don't need 64-bit.
+		 */
+		int calib_data = mult_frac(calib->sens_numer,
+					   raw_data - calib->bias,
+					   calib->sens_denom);
 
-		input_report_abs(sc->sensor_dev, axes[n], value);
+		input_report_abs(sc->sensor_dev, calib->abs_code, calib_data);
+		offset += 2;
 	}
 	input_sync(sc->sensor_dev);
 
@@ -1315,6 +1342,7 @@ static int sony_register_sensors(struct sony_sc *sc)
 	size_t name_sz;
 	char *name;
 	int ret;
+	int range;
 
 	sc->sensor_dev = input_allocate_device();
 	if (!sc->sensor_dev)
@@ -1341,13 +1369,21 @@ static int sony_register_sensors(struct sony_sc *sc)
 	snprintf(name, name_sz, "%s" DS4_SENSOR_SUFFIX, sc->hdev->name);
 	sc->sensor_dev->name = name;
 
-	input_set_abs_params(sc->sensor_dev, ABS_X, -32768, 32767, 0, 0);
-	input_set_abs_params(sc->sensor_dev, ABS_Y, -32768, 32767, 0, 0);
-	input_set_abs_params(sc->sensor_dev, ABS_Z, -32768, 32767, 0, 0);
-
-	input_set_abs_params(sc->sensor_dev, ABS_RX, -32768, 32767, 0, 0);
-	input_set_abs_params(sc->sensor_dev, ABS_RY, -32768, 32767, 0, 0);
-	input_set_abs_params(sc->sensor_dev, ABS_RZ, -32768, 32767, 0, 0);
+	range = DS4_ACC_RES_PER_G*4;
+	input_set_abs_params(sc->sensor_dev, ABS_X, -range, range, 16, 0);
+	input_set_abs_params(sc->sensor_dev, ABS_Y, -range, range, 16, 0);
+	input_set_abs_params(sc->sensor_dev, ABS_Z, -range, range, 16, 0);
+	input_abs_set_res(sc->sensor_dev, ABS_X, DS4_ACC_RES_PER_G);
+	input_abs_set_res(sc->sensor_dev, ABS_Y, DS4_ACC_RES_PER_G);
+	input_abs_set_res(sc->sensor_dev, ABS_Z, DS4_ACC_RES_PER_G);
+
+	range = DS4_GYRO_RES_PER_DEG_S*2048;
+	input_set_abs_params(sc->sensor_dev, ABS_RX, -range, range, 16, 0);
+	input_set_abs_params(sc->sensor_dev, ABS_RY, -range, range, 16, 0);
+	input_set_abs_params(sc->sensor_dev, ABS_RZ, -range, range, 16, 0);
+	input_abs_set_res(sc->sensor_dev, ABS_RX, DS4_GYRO_RES_PER_DEG_S);
+	input_abs_set_res(sc->sensor_dev, ABS_RY, DS4_GYRO_RES_PER_DEG_S);
+	input_abs_set_res(sc->sensor_dev, ABS_RZ, DS4_GYRO_RES_PER_DEG_S);
 
 	__set_bit(INPUT_PROP_ACCELEROMETER, sc->sensor_dev->propbit);
 
@@ -1445,23 +1481,145 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
 }
 
 /*
- * Requesting feature report 0x02 in Bluetooth mode changes the state of the
- * controller so that it sends full input reports of type 0x11.
+ * Request DS4 calibration data for the motion sensors.
+ * For Bluetooth this also affects the operating mode (see below).
  */
-static int dualshock4_set_operational_bt(struct hid_device *hdev)
+static int dualshock4_get_calibration_data(struct sony_sc *sc)
 {
 	u8 *buf;
 	int ret;
+	short gyro_pitch_bias, gyro_pitch_plus, gyro_pitch_minus;
+	short gyro_yaw_bias, gyro_yaw_plus, gyro_yaw_minus;
+	short gyro_roll_bias, gyro_roll_plus, gyro_roll_minus;
+	short gyro_speed_plus, gyro_speed_minus;
+	short acc_x_plus, acc_x_minus;
+	short acc_y_plus, acc_y_minus;
+	short acc_z_plus, acc_z_minus;
+	int speed_2x;
+	int range_2g;
+
+	/* For Bluetooth we use a different request, which supports CRC.
+	 * Note: in Bluetooth mode feature report 0x02 also changes the state
+	 * of the controller, so that it sends input reports of type 0x11.
+	 */
+	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+		buf = kmalloc(DS4_FEATURE_REPORT_0x02_SIZE, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
 
-	buf = kmalloc(DS4_FEATURE_REPORT_0x02_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+		ret = hid_hw_raw_request(sc->hdev, 0x02, buf,
+					 DS4_FEATURE_REPORT_0x02_SIZE,
+					 HID_FEATURE_REPORT,
+					 HID_REQ_GET_REPORT);
+		if (ret < 0)
+			goto err_stop;
+	} else {
+		u8 bthdr = 0xA3;
+		u32 crc;
+		u32 report_crc;
+		int retries;
 
-	ret = hid_hw_raw_request(hdev, 0x02, buf, DS4_FEATURE_REPORT_0x02_SIZE,
-				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+		buf = kmalloc(DS4_FEATURE_REPORT_0x05_SIZE, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
 
-	kfree(buf);
+		for (retries = 0; retries < 3; retries++) {
+			ret = hid_hw_raw_request(sc->hdev, 0x05, buf,
+						 DS4_FEATURE_REPORT_0x05_SIZE,
+						 HID_FEATURE_REPORT,
+						 HID_REQ_GET_REPORT);
+			if (ret < 0)
+				goto err_stop;
 
+			/* CRC check */
+			crc = crc32_le(0xFFFFFFFF, &bthdr, 1);
+			crc = ~crc32_le(crc, buf, DS4_FEATURE_REPORT_0x05_SIZE-4);
+			report_crc = get_unaligned_le32(&buf[DS4_FEATURE_REPORT_0x05_SIZE-4]);
+			if (crc != report_crc) {
+				hid_warn(sc->hdev, "DualShock 4 calibration report's CRC check failed, received crc 0x%0x != 0x%0x\n",
+					report_crc, crc);
+				if (retries < 2) {
+					hid_warn(sc->hdev, "Retrying DualShock 4 get calibration report request\n");
+					continue;
+				} else {
+					ret = -EILSEQ;
+					goto err_stop;
+				}
+			} else {
+				break;
+			}
+		}
+	}
+
+	gyro_pitch_bias  = get_unaligned_le16(&buf[1]);
+	gyro_yaw_bias    = get_unaligned_le16(&buf[3]);
+	gyro_roll_bias   = get_unaligned_le16(&buf[5]);
+	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+		gyro_pitch_plus  = get_unaligned_le16(&buf[7]);
+		gyro_pitch_minus = get_unaligned_le16(&buf[9]);
+		gyro_yaw_plus    = get_unaligned_le16(&buf[11]);
+		gyro_yaw_minus   = get_unaligned_le16(&buf[13]);
+		gyro_roll_plus   = get_unaligned_le16(&buf[15]);
+		gyro_roll_minus  = get_unaligned_le16(&buf[17]);
+	} else {
+		gyro_pitch_plus  = get_unaligned_le16(&buf[7]);
+		gyro_yaw_plus    = get_unaligned_le16(&buf[9]);
+		gyro_roll_plus   = get_unaligned_le16(&buf[11]);
+		gyro_pitch_minus = get_unaligned_le16(&buf[13]);
+		gyro_yaw_minus   = get_unaligned_le16(&buf[15]);
+		gyro_roll_minus  = get_unaligned_le16(&buf[17]);
+	}
+	gyro_speed_plus  = get_unaligned_le16(&buf[19]);
+	gyro_speed_minus = get_unaligned_le16(&buf[21]);
+	acc_x_plus       = get_unaligned_le16(&buf[23]);
+	acc_x_minus      = get_unaligned_le16(&buf[25]);
+	acc_y_plus       = get_unaligned_le16(&buf[27]);
+	acc_y_minus      = get_unaligned_le16(&buf[29]);
+	acc_z_plus       = get_unaligned_le16(&buf[31]);
+	acc_z_minus      = get_unaligned_le16(&buf[33]);
+
+	/* Set gyroscope calibration and normalization parameters.
+	 * Data values will be normalized to 1/DS4_GYRO_RES_PER_DEG_S degree/s.
+	 */
+	speed_2x = (gyro_speed_plus + gyro_speed_minus);
+	sc->ds4_calib_data[0].abs_code = ABS_RX;
+	sc->ds4_calib_data[0].bias = gyro_pitch_bias;
+	sc->ds4_calib_data[0].sens_numer = speed_2x*DS4_GYRO_RES_PER_DEG_S;
+	sc->ds4_calib_data[0].sens_denom = gyro_pitch_plus - gyro_pitch_minus;
+
+	sc->ds4_calib_data[1].abs_code = ABS_RY;
+	sc->ds4_calib_data[1].bias = gyro_yaw_bias;
+	sc->ds4_calib_data[1].sens_numer = speed_2x*DS4_GYRO_RES_PER_DEG_S;
+	sc->ds4_calib_data[1].sens_denom = gyro_yaw_plus - gyro_yaw_minus;
+
+	sc->ds4_calib_data[2].abs_code = ABS_RZ;
+	sc->ds4_calib_data[2].bias = gyro_roll_bias;
+	sc->ds4_calib_data[2].sens_numer = speed_2x*DS4_GYRO_RES_PER_DEG_S;
+	sc->ds4_calib_data[2].sens_denom = gyro_roll_plus - gyro_roll_minus;
+
+	/* Set accelerometer calibration and normalization parameters.
+	 * Data values will be normalized to 1/DS4_ACC_RES_PER_G G.
+	 */
+	range_2g = acc_x_plus - acc_x_minus;
+	sc->ds4_calib_data[3].abs_code = ABS_X;
+	sc->ds4_calib_data[3].bias = acc_x_plus - range_2g / 2;
+	sc->ds4_calib_data[3].sens_numer = 2*DS4_ACC_RES_PER_G;
+	sc->ds4_calib_data[3].sens_denom = range_2g;
+
+	range_2g = acc_y_plus - acc_y_minus;
+	sc->ds4_calib_data[4].abs_code = ABS_Y;
+	sc->ds4_calib_data[4].bias = acc_y_plus - range_2g / 2;
+	sc->ds4_calib_data[4].sens_numer = 2*DS4_ACC_RES_PER_G;
+	sc->ds4_calib_data[4].sens_denom = range_2g;
+
+	range_2g = acc_z_plus - acc_z_minus;
+	sc->ds4_calib_data[5].abs_code = ABS_Z;
+	sc->ds4_calib_data[5].bias = acc_z_plus - range_2g / 2;
+	sc->ds4_calib_data[5].sens_numer = 2*DS4_ACC_RES_PER_G;
+	sc->ds4_calib_data[5].sens_denom = range_2g;
+
+err_stop:
+	kfree(buf);
 	return ret;
 }
 
@@ -2365,12 +2523,10 @@ static int sony_input_configured(struct hid_device *hdev,
 		ret = sixaxis_set_operational_bt(hdev);
 		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
-		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
-			ret = dualshock4_set_operational_bt(hdev);
-			if (ret < 0) {
-				hid_err(hdev, "failed to set the Dualshock 4 operational mode\n");
-				goto err_stop;
-			}
+		ret = dualshock4_get_calibration_data(sc);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to get calibration data from Dualshock 4\n");
+			goto err_stop;
 		}
 
 		/*
-- 
2.9.3

