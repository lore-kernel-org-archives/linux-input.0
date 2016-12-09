From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 6/7] HID: sony: Report hardware timestamp for DS4 sensor values
Date: Thu,  8 Dec 2016 19:09:55 -0800
Message-ID: <1481252996-25288-7-git-send-email-roderick@gaikai.com>
References: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33547 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932573AbcLIDKt (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Dec 2016 22:10:49 -0500
Received: by mail-pf0-f182.google.com with SMTP id d2so1248150pfd.0
        for <linux-input@vger.kernel.org>; Thu, 08 Dec 2016 19:10:48 -0800 (PST)
In-Reply-To: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Report the hardware timestamp inside each HID report through
MSC_TIMESTAMP for motion sensor values.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index a7a3692..9f79d1b 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -781,6 +781,7 @@ struct motion_output_report_02 {
  * additional +2.
  */
 #define DS4_INPUT_REPORT_BUTTON_OFFSET    5
+#define DS4_INPUT_REPORT_TIMESTAMP_OFFSET 10
 #define DS4_INPUT_REPORT_GYRO_X_OFFSET   13
 #define DS4_INPUT_REPORT_BATTERY_OFFSET  30
 #define DS4_INPUT_REPORT_TOUCHPAD_OFFSET 33
@@ -838,6 +839,11 @@ struct sony_sc {
 	u8 led_delay_on[MAX_LEDS];
 	u8 led_delay_off[MAX_LEDS];
 	u8 led_count;
+
+	bool timestamp_initialized;
+	u16 prev_timestamp;
+	unsigned int timestamp_us;
+
 	bool ds4_dongle_connected;
 	/* DS4 calibration data */
 	struct ds4_calibration_data ds4_calib_data[6];
@@ -1032,6 +1038,7 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	unsigned long flags;
 	int n, m, offset, num_touch_data, max_touch_data;
 	u8 cable_state, battery_capacity, battery_charging;
+	u16 timestamp;
 
 	/* When using Bluetooth the header is 2 bytes longer, so skip these. */
 	int data_offset = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 0 : 2;
@@ -1040,6 +1047,24 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	offset = data_offset + DS4_INPUT_REPORT_BUTTON_OFFSET;
 	input_report_key(sc->touchpad, BTN_LEFT, rd[offset+2] & 0x2);
 
+	/* Convert timestamp (in 5.33us unit) to timestamp_us */
+	offset = data_offset + DS4_INPUT_REPORT_TIMESTAMP_OFFSET;
+	timestamp = get_unaligned_le16(&rd[offset]);
+	if (!sc->timestamp_initialized) {
+		sc->timestamp_us = ((unsigned int)timestamp * 16) / 3;
+		sc->timestamp_initialized = true;
+	} else {
+		u16 delta;
+
+		if (sc->prev_timestamp > timestamp)
+			delta = (U16_MAX - sc->prev_timestamp + timestamp + 1);
+		else
+			delta = timestamp - sc->prev_timestamp;
+		sc->timestamp_us += (delta * 16) / 3;
+	}
+	sc->prev_timestamp = timestamp;
+	input_event(sc->sensor_dev, EV_MSC, MSC_TIMESTAMP, sc->timestamp_us);
+
 	offset = data_offset + DS4_INPUT_REPORT_GYRO_X_OFFSET;
 	for (n = 0; n < 6; n++) {
 		/* Store data in int for more precision during mult_frac. */
@@ -1386,6 +1411,8 @@ static int sony_register_sensors(struct sony_sc *sc)
 	input_abs_set_res(sc->sensor_dev, ABS_RY, DS4_GYRO_RES_PER_DEG_S);
 	input_abs_set_res(sc->sensor_dev, ABS_RZ, DS4_GYRO_RES_PER_DEG_S);
 
+	__set_bit(EV_MSC, sc->sensor_dev->evbit);
+	__set_bit(MSC_TIMESTAMP, sc->sensor_dev->mscbit);
 	__set_bit(INPUT_PROP_ACCELEROMETER, sc->sensor_dev->propbit);
 
 	ret = input_register_device(sc->sensor_dev);
-- 
2.7.4

