Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02E38E8AB
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384875; cv=none; b=pPSYFf4jeczUpG2Gs9/9T9LbnzgvzsdFo3qLVU8euPIJ9AiIOTiUPwZYoFJdHUL9ATXyNodumuOjfIYb/6q/8crKvLWWlCpOPZMPuPl6Krn6LGwRgMPNMrql4sJRys8BrPEcRRPPF1O0pjQzgGgpOzXRGPRggioLD/9hEVnvKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384875; c=relaxed/simple;
	bh=UHQ2I3QYSQkW8dIY2kPmLIO0+atS8B0FeDKkMpRAtXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfsNofN7qdv8Mu0lFIoq5HhZ1S4enr9ejob6OQLvMP4ozEmdm5BllCOfXnbTrYAQa18JJYh8SuJAjGAyqVez+v643t6WyVbGfR/DuIrRUGlYzRDehDbAzVTpfywff+Ip1K04eOVomj95tvB8G8FNzHDFhQhsMUN22K/4avbt1b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=GmzOOSDE; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="GmzOOSDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384867; bh=UHQ2I3QYSQkW8dIY2kPmLIO0+atS8B0FeDKkMpRAtXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GmzOOSDEDEMr/+Mi7ZJYhU8YDij4ilAtjk2VNAvWEA0ap5HH00Q3nB1q41jS8/wLr
	 bCIOjoCK6Jn4+vmv/ejESvToyPp2tMREdTuS/YBqKmYXYjHiTIq6Kd81n73aCuwoBv
	 6GHJY3lcZNsUH+WkIK7Vt11KMs9XIVPoPEc6Qoq6NOMZjiGIw5e69S4GXkDTh5mKHe
	 AEgYfpUj2n76fKTwMVV0qYi5MB0EstbXiOAJ4QcgoCwE8di3Dc8eLNkQwrpvVUSEWZ
	 OK1KeZiuPa52EKL5B8FI7jGsQuTaG4/15sdeL3dGfq+yTpAaaP6W2hRc6PWghUSMT2
	 jSqHudrDAyNGQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 2915E132033;
	Wed, 29 Jul 2026 21:14:27 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v5 04/11] HID: steam: Add support for sensor events on the Steam Controller (2015)
Date: Wed, 29 Jul 2026 21:12:27 -0700
Message-ID: <20260730041251.1659029-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730041251.1659029-1-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sensor support was added for the Steam Deck previously, but Steam
Controller sensor events were never added. This adds that missing support,
bringing Steam Controller support much closer to feature parity with things
like SDL and Steam itself.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 214 ++++++++++++++++++++++++++++++++--------
 1 file changed, 175 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 983d18d1de4f..1ceb044e170b 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -70,13 +70,14 @@ static LIST_HEAD(steam_devices);
 /* Joystick runs are about 5 mm and 32768 units */
 #define STEAM_DECK_JOYSTICK_RESOLUTION 6553
 /* Accelerometer has 16 bit resolution and a range of +/- 2g */
-#define STEAM_DECK_ACCEL_RES_PER_G 16384
-#define STEAM_DECK_ACCEL_RANGE 32768
+#define STEAM_ACCEL_RES_PER_G 16384
+#define STEAM_ACCEL_RANGE 32768
+#define STEAM_ACCEL_FUZZ 128
 #define STEAM_DECK_ACCEL_FUZZ 32
 /* Gyroscope has 16 bit resolution and a range of +/- 2000 dps */
-#define STEAM_DECK_GYRO_RES_PER_DPS 16
-#define STEAM_DECK_GYRO_RANGE 32768
-#define STEAM_DECK_GYRO_FUZZ 1
+#define STEAM_GYRO_RES_PER_DPS 16
+#define STEAM_GYRO_RANGE 32768
+#define STEAM_GYRO_FUZZ 0
 
 #define STEAM_PAD_FUZZ 256
 
@@ -255,6 +256,31 @@ enum
 	ID_CONTROLLER_DECK_STATE = 9
 };
 
+/* Read-only attributes */
+enum {
+	ATTRIB_UNIQUE_ID, // deprecated
+	ATTRIB_PRODUCT_ID,
+	ATTRIB_PRODUCT_REVISON, // deprecated
+	ATTRIB_CAPABILITIES = ATTRIB_PRODUCT_REVISON, // intentional aliasing
+	ATTRIB_FIRMWARE_VERSION, // deprecated
+	ATTRIB_FIRMWARE_BUILD_TIME,
+	ATTRIB_RADIO_FIRMWARE_BUILD_TIME,
+	ATTRIB_RADIO_DEVICE_ID0,
+	ATTRIB_RADIO_DEVICE_ID1,
+	ATTRIB_DONGLE_FIRMWARE_BUILD_TIME,
+	ATTRIB_HW_ID, // AKA BOARD_REVISION,
+	ATTRIB_BOOTLOADER_BUILD_TIME,
+	ATTRIB_CONNECTION_INTERVAL_IN_US,
+	ATTRIB_SECONDARY_FIRMWARE_BUILD_TIME,
+	ATTRIB_SECONDARY_BOOTLOADER_BUILD_TIME,
+	ATTRIB_SECONDARY_HW_ID, // AKA BOARD_REVISION,
+	ATTRIB_STREAMING,
+	ATTRIB_TRACKPAD_ID,
+	ATTRIB_SECONDARY_TRACKPAD_ID,
+
+	ATTRIB_COUNT
+};
+
 /* String attribute identifiers */
 enum {
 	ATTRIB_STR_BOARD_SERIAL,
@@ -284,6 +310,11 @@ enum {
 	TRACKPAD_GESTURE_KEYBOARD,
 };
 
+struct steam_controller_attribute {
+	unsigned char tag;
+	__le32 value;
+} __packed;
+
 /* Pad identifiers for the deck */
 #define STEAM_PAD_LEFT 0
 #define STEAM_PAD_RIGHT 1
@@ -315,6 +346,7 @@ struct steam_device {
 	u16 rumble_left;
 	u16 rumble_right;
 	unsigned int sensor_timestamp_us;
+	unsigned int sensor_update_rate_us;
 	struct work_struct unregister_work;
 };
 
@@ -468,6 +500,38 @@ static int steam_get_serial(struct steam_device *steam)
 	return ret;
 }
 
+static int steam_get_attributes(struct steam_device *steam)
+{
+	int ret = 0;
+	u8 cmd[] = {ID_GET_ATTRIBUTES_VALUES, 0};
+	u8 reply[64] = {};
+	u8 size;
+	int i;
+	struct steam_controller_attribute *attr;
+
+	guard(mutex)(&steam->report_mutex);
+	ret = steam_send_report(steam, cmd, sizeof(cmd));
+	if (ret < 0)
+		return ret;
+	ret = steam_recv_report(steam, reply, sizeof(reply));
+	if (ret < 0)
+		return ret;
+	if (reply[0] != ID_GET_ATTRIBUTES_VALUES || reply[1] < 2)
+		return -EIO;
+
+	size = min(reply[1], sizeof(reply) - 2);
+	for (i = 0; i + sizeof(*attr) <= size; i += sizeof(*attr)) {
+		attr = (struct steam_controller_attribute *)&reply[i + 2];
+		if (attr->tag == ATTRIB_CONNECTION_INTERVAL_IN_US) {
+			steam->sensor_update_rate_us = get_unaligned_le32(&attr->value);
+			hid_dbg(steam->hdev, "Sensor update rate: %uus\n",
+				steam->sensor_update_rate_us);
+		}
+	}
+
+	return 0;
+}
+
 /*
  * This command requests the wireless adaptor to post an event
  * with the connection status. Useful if this driver is loaded when
@@ -626,6 +690,42 @@ static void steam_input_close(struct input_dev *dev)
 	}
 }
 
+static int steam_sensor_open(struct input_dev *dev)
+{
+	struct steam_device *steam = input_get_drvdata(dev);
+	unsigned long flags;
+	bool client_opened;
+
+	spin_lock_irqsave(&steam->lock, flags);
+	client_opened = steam->client_opened;
+	spin_unlock_irqrestore(&steam->lock, flags);
+	if (client_opened)
+		return 0;
+
+	guard(mutex)(&steam->report_mutex);
+	steam_write_settings(steam, SETTING_IMU_MODE,
+			SETTING_IMU_MODE_SEND_RAW_ACCEL | SETTING_IMU_MODE_SEND_RAW_GYRO,
+			0);
+
+	return 0;
+}
+
+static void steam_sensor_close(struct input_dev *dev)
+{
+	struct steam_device *steam = input_get_drvdata(dev);
+	unsigned long flags;
+	bool client_opened;
+
+	spin_lock_irqsave(&steam->lock, flags);
+	client_opened = steam->client_opened;
+	spin_unlock_irqrestore(&steam->lock, flags);
+	if (client_opened)
+		return;
+
+	guard(mutex)(&steam->report_mutex);
+	steam_write_settings(steam, SETTING_IMU_MODE, 0, 0);
+}
+
 static enum power_supply_property steam_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_SCOPE,
@@ -839,9 +939,6 @@ static int steam_sensors_register(struct steam_device *steam)
 	struct input_dev *sensors;
 	int ret;
 
-	if (!(steam->quirks & STEAM_QUIRK_DECK))
-		return 0;
-
 	rcu_read_lock();
 	sensors = rcu_dereference(steam->sensors);
 	rcu_read_unlock();
@@ -856,8 +953,14 @@ static int steam_sensors_register(struct steam_device *steam)
 
 	input_set_drvdata(sensors, steam);
 	sensors->dev.parent = &hdev->dev;
+	if (!(steam->quirks & STEAM_QUIRK_DECK)) {
+		sensors->open = steam_sensor_open;
+		sensors->close = steam_sensor_close;
+	}
 
-	sensors->name = "Steam Deck Motion Sensors";
+	sensors->name = steam->quirks & STEAM_QUIRK_DECK ?
+		"Steam Deck Motion Sensors" :
+		"Steam Controller Motion Sensors";
 	sensors->phys = hdev->phys;
 	sensors->uniq = steam->serial_no;
 	sensors->id.bustype = hdev->bus;
@@ -869,25 +972,34 @@ static int steam_sensors_register(struct steam_device *steam)
 	__set_bit(EV_MSC, sensors->evbit);
 	__set_bit(MSC_TIMESTAMP, sensors->mscbit);
 
-	input_set_abs_params(sensors, ABS_X, -STEAM_DECK_ACCEL_RANGE,
-			STEAM_DECK_ACCEL_RANGE, STEAM_DECK_ACCEL_FUZZ, 0);
-	input_set_abs_params(sensors, ABS_Y, -STEAM_DECK_ACCEL_RANGE,
-			STEAM_DECK_ACCEL_RANGE, STEAM_DECK_ACCEL_FUZZ, 0);
-	input_set_abs_params(sensors, ABS_Z, -STEAM_DECK_ACCEL_RANGE,
-			STEAM_DECK_ACCEL_RANGE, STEAM_DECK_ACCEL_FUZZ, 0);
-	input_abs_set_res(sensors, ABS_X, STEAM_DECK_ACCEL_RES_PER_G);
-	input_abs_set_res(sensors, ABS_Y, STEAM_DECK_ACCEL_RES_PER_G);
-	input_abs_set_res(sensors, ABS_Z, STEAM_DECK_ACCEL_RES_PER_G);
-
-	input_set_abs_params(sensors, ABS_RX, -STEAM_DECK_GYRO_RANGE,
-			STEAM_DECK_GYRO_RANGE, STEAM_DECK_GYRO_FUZZ, 0);
-	input_set_abs_params(sensors, ABS_RY, -STEAM_DECK_GYRO_RANGE,
-			STEAM_DECK_GYRO_RANGE, STEAM_DECK_GYRO_FUZZ, 0);
-	input_set_abs_params(sensors, ABS_RZ, -STEAM_DECK_GYRO_RANGE,
-			STEAM_DECK_GYRO_RANGE, STEAM_DECK_GYRO_FUZZ, 0);
-	input_abs_set_res(sensors, ABS_RX, STEAM_DECK_GYRO_RES_PER_DPS);
-	input_abs_set_res(sensors, ABS_RY, STEAM_DECK_GYRO_RES_PER_DPS);
-	input_abs_set_res(sensors, ABS_RZ, STEAM_DECK_GYRO_RES_PER_DPS);
+	if (steam->quirks & STEAM_QUIRK_DECK) {
+		input_set_abs_params(sensors, ABS_X, -STEAM_ACCEL_RANGE,
+				STEAM_ACCEL_RANGE, STEAM_DECK_ACCEL_FUZZ, 0);
+		input_set_abs_params(sensors, ABS_Y, -STEAM_ACCEL_RANGE,
+				STEAM_ACCEL_RANGE, STEAM_DECK_ACCEL_FUZZ, 0);
+		input_set_abs_params(sensors, ABS_Z, -STEAM_ACCEL_RANGE,
+				STEAM_ACCEL_RANGE, STEAM_DECK_ACCEL_FUZZ, 0);
+	} else {
+		input_set_abs_params(sensors, ABS_X, -STEAM_ACCEL_RANGE,
+				STEAM_ACCEL_RANGE, STEAM_ACCEL_FUZZ, 0);
+		input_set_abs_params(sensors, ABS_Y, -STEAM_ACCEL_RANGE,
+				STEAM_ACCEL_RANGE, STEAM_ACCEL_FUZZ, 0);
+		input_set_abs_params(sensors, ABS_Z, -STEAM_ACCEL_RANGE,
+				STEAM_ACCEL_RANGE, STEAM_ACCEL_FUZZ, 0);
+	}
+	input_abs_set_res(sensors, ABS_X, STEAM_ACCEL_RES_PER_G);
+	input_abs_set_res(sensors, ABS_Y, STEAM_ACCEL_RES_PER_G);
+	input_abs_set_res(sensors, ABS_Z, STEAM_ACCEL_RES_PER_G);
+
+	input_set_abs_params(sensors, ABS_RX, -STEAM_GYRO_RANGE,
+			STEAM_GYRO_RANGE, STEAM_GYRO_FUZZ, 0);
+	input_set_abs_params(sensors, ABS_RY, -STEAM_GYRO_RANGE,
+			STEAM_GYRO_RANGE, STEAM_GYRO_FUZZ, 0);
+	input_set_abs_params(sensors, ABS_RZ, -STEAM_GYRO_RANGE,
+			STEAM_GYRO_RANGE, STEAM_GYRO_FUZZ, 0);
+	input_abs_set_res(sensors, ABS_RX, STEAM_GYRO_RES_PER_DPS);
+	input_abs_set_res(sensors, ABS_RY, STEAM_GYRO_RES_PER_DPS);
+	input_abs_set_res(sensors, ABS_RZ, STEAM_GYRO_RES_PER_DPS);
 
 	ret = input_register_device(sensors);
 	if (ret)
@@ -918,9 +1030,6 @@ static void steam_sensors_unregister(struct steam_device *steam)
 {
 	struct input_dev *sensors;
 
-	if (!(steam->quirks & STEAM_QUIRK_DECK))
-		return;
-
 	rcu_read_lock();
 	sensors = rcu_dereference(steam->sensors);
 	rcu_read_unlock();
@@ -968,6 +1077,12 @@ static int steam_register(struct steam_device *steam)
 			strscpy(steam->serial_no, "XXXXXXXXXX",
 					sizeof(steam->serial_no));
 
+		ret = steam_get_attributes(steam);
+		if (ret < 0)
+			hid_err(steam->hdev,
+				"%s:steam_get_attributes failed with error %d\n",
+				__func__, ret);
+
 		hid_info(steam->hdev, "Steam Controller '%s' connected",
 				steam->serial_no);
 
@@ -1246,6 +1361,10 @@ static int steam_probe(struct hid_device *hdev,
 	INIT_LIST_HEAD(&steam->list);
 	INIT_WORK(&steam->rumble_work, steam_haptic_rumble_cb);
 	steam->sensor_timestamp_us = 0;
+	if (steam->quirks & STEAM_QUIRK_DECK)
+		steam->sensor_update_rate_us = 4000;
+	else
+		steam->sensor_update_rate_us = 9000;
 	INIT_WORK(&steam->unregister_work, steam_work_unregister_cb);
 
 	/*
@@ -1491,6 +1610,16 @@ static const struct steam_axis_mapping steam_controller_axis_mappings[] = {
 	{ /* sentinel */ },
 };
 
+static const struct steam_axis_mapping steam_controller_imu_mappings[] = {
+	{ ABS_X,   1, 28 },
+	{ ABS_Z,  -1, 30 },
+	{ ABS_Y,   1, 32 },
+	{ ABS_RX,  1, 34 },
+	{ ABS_RZ,  1, 36 },
+	{ ABS_RY,  1, 38 },
+	{ /* sentinel */ },
+};
+
 static void steam_do_input_event(struct steam_device *steam,
 		struct input_dev *input, u8 *data)
 {
@@ -1533,6 +1662,17 @@ static void steam_do_input_event(struct steam_device *steam,
 	input_sync(input);
 }
 
+static void steam_do_sensors_event(struct steam_device *steam,
+		struct input_dev *sensors, u8 *data)
+{
+	steam->sensor_timestamp_us += steam->sensor_update_rate_us;
+
+	input_event(sensors, EV_MSC, MSC_TIMESTAMP, steam->sensor_timestamp_us);
+	steam_map_axes(sensors, steam_controller_imu_mappings, data);
+
+	input_sync(sensors);
+}
+
 /*
  * The size for this message payload is 56.
  * The known values are:
@@ -1727,14 +1867,7 @@ static void steam_do_deck_input_event(struct steam_device *steam,
 static void steam_do_deck_sensors_event(struct steam_device *steam,
 		struct input_dev *sensors, u8 *data)
 {
-	/*
-	 * The deck input report is received every 4 ms on average,
-	 * with a jitter of +/- 4 ms even though the USB descriptor claims
-	 * that it uses 1 kHz.
-	 * Since the HID report does not include a sensor timestamp,
-	 * use a fixed increment here.
-	 */
-	steam->sensor_timestamp_us += 4000;
+	steam->sensor_timestamp_us += steam->sensor_update_rate_us;
 
 	if (!steam->gamepad_mode && lizard_mode)
 		return;
@@ -1819,6 +1952,9 @@ static int steam_raw_event(struct hid_device *hdev,
 		input = rcu_dereference(steam->input);
 		if (likely(input))
 			steam_do_input_event(steam, input, data);
+		sensors = rcu_dereference(steam->sensors);
+		if (likely(sensors))
+			steam_do_sensors_event(steam, sensors, data);
 		rcu_read_unlock();
 		break;
 	case ID_CONTROLLER_DECK_STATE:
-- 
2.54.0

