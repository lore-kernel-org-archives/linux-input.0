Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189412D0C9D
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290053; cv=none; b=ITCr9XO55J/nDifzJ1OogjqpZqOflh+K76wjHwDVQQLN8JaqGWPOxfFsOINaoh1fxFHnnmjaBRKbVi2dHoQjwBxsSEDMGgxa0gOQOMtpSICesNUXp97Zdc6j7kjCadH2sXNYF8dAEsidKSOj1GLVDNWi3F13T9RPwyo88RX9mE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290053; c=relaxed/simple;
	bh=dtYS6YH3TAuYUdmyjWKqQsPLMTHuzlLXm3Rp6nF0JB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSarmSNiw5p7AOnfJQvr1H9dWbjN87s446rIGFkAFtgpp8dsFl14PWcPqc0XNjYotEeHhWcOtiOSLra5q5sv+sJpnquWn0aXNH2KEvhUq+HbhhSmdD/tf37WnY4hfEhVTgjzRhPqE/5Pwqcea3siKG9WlIcBDg1Fo4l401v4Znk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=CPOepz3J; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="CPOepz3J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290045; bh=dtYS6YH3TAuYUdmyjWKqQsPLMTHuzlLXm3Rp6nF0JB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPOepz3JYcYZ7Wy3xbfFAagte6qkQJAUMntyiLSxaMZ8+RkGfh+60tDYkxgsRtUDV
	 GUMs3jpmVPV7yiRYHbvALCLM4zf/tsYPXoWKzhSWq7R4LlQJcETshLUR7eGrThyXvA
	 ZtdaJ0oKTCm+0fSD5hTA9DKGH2OZImwx1Zljdee0Pd6xCXgtaC7Josvhd4l1J4AR3h
	 VdO5n36oXOIGwFLfLRZjRa4jMOWqkilPouWfRTSulQ8B7MLJuzL6MsdeKyBffrNAow
	 81TAYPDIvsa3t1zzCLLaIkeWo2IRMfZog408sW6bzQ+CfcI9BdJIQ6DspuNKJgGnNn
	 NaIWLDa0SrPGA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 9A813A0AA;
	Tue, 28 Jul 2026 18:54:05 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v4 05/11] HID: steam: Add support for sensor events on the Steam Controller (2015)
Date: Tue, 28 Jul 2026 18:52:27 -0700
Message-ID: <20260729015243.1170573-6-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729015243.1170573-1-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
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
index 8bad79205b57..cabecd250072 100644
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
 
@@ -467,6 +499,38 @@ static int steam_get_serial(struct steam_device *steam)
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
@@ -625,6 +689,42 @@ static void steam_input_close(struct input_dev *dev)
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
@@ -838,9 +938,6 @@ static int steam_sensors_register(struct steam_device *steam)
 	struct input_dev *sensors;
 	int ret;
 
-	if (!(steam->quirks & STEAM_QUIRK_DECK))
-		return 0;
-
 	rcu_read_lock();
 	sensors = rcu_dereference(steam->sensors);
 	rcu_read_unlock();
@@ -855,8 +952,14 @@ static int steam_sensors_register(struct steam_device *steam)
 
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
@@ -868,25 +971,34 @@ static int steam_sensors_register(struct steam_device *steam)
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
@@ -917,9 +1029,6 @@ static void steam_sensors_unregister(struct steam_device *steam)
 {
 	struct input_dev *sensors;
 
-	if (!(steam->quirks & STEAM_QUIRK_DECK))
-		return;
-
 	rcu_read_lock();
 	sensors = rcu_dereference(steam->sensors);
 	rcu_read_unlock();
@@ -967,6 +1076,12 @@ static int steam_register(struct steam_device *steam)
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
 
@@ -1245,6 +1360,10 @@ static int steam_probe(struct hid_device *hdev,
 	INIT_LIST_HEAD(&steam->list);
 	INIT_WORK(&steam->rumble_work, steam_haptic_rumble_cb);
 	steam->sensor_timestamp_us = 0;
+	if (steam->quirks & STEAM_QUIRK_DECK)
+		steam->sensor_update_rate_us = 4000;
+	else
+		steam->sensor_update_rate_us = 9000;
 	INIT_WORK(&steam->unregister_work, steam_work_unregister_cb);
 
 	/*
@@ -1490,6 +1609,16 @@ static const struct steam_axis_mapping steam_controller_axis_mappings[] = {
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
@@ -1532,6 +1661,17 @@ static void steam_do_input_event(struct steam_device *steam,
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
@@ -1726,14 +1866,7 @@ static void steam_do_deck_input_event(struct steam_device *steam,
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
@@ -1818,6 +1951,9 @@ static int steam_raw_event(struct hid_device *hdev,
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

