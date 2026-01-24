Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473BA213E89
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219358; cv=none; b=b8uytMpO2R7RBCk1IqvrhlnFWadYpo00BFGBReU2ZcIYhbxu4Fy5GNRlzi41vEd6NwcyWnFvurgQLz5DOHlu5cf/8UFiTK24gm6sj3ABEyiXW6atTSWqg6nF9xl3xD6gpL8lmaoPpwjBe8RU2udASPDwOxrqIuOBBDofp9cGJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219358; c=relaxed/simple;
	bh=yNRYzCUvw7h/24TV4k/FTIrRtyG1qVaH9Te99Pv3tzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3XV3Lb40fZPaxddJ8rwiiYay+XHeWKkxvvqaDnKHJk3leDwACM3sOA5oa+vLqjHwyiF/5HzvkWwZUZ6eJPGGsTaqxqJyTt/xFv3sqR3fRELmxt+CRCCq9W5/q8X1PrkwFtZWD34uReGATTMvkgbfr0alWElDKdveq+d77a0zJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZg/TZj4; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZg/TZj4"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b72e49776eso4455668eec.1
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 17:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219355; x=1769824155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deL+GFbShaY/PU1BGtjyGIzsYhM8+/qKKNNQ78FbRiE=;
        b=mZg/TZj4opmfwZHLRxtXtCZ/HiNpzFRspZmDRkbCLJGTmDnWEQjN6/CDyxU/1xXblm
         WCYzuNxDMs2SfaMHC7oNg/qGchb621xq5AJT50wNHW4SPUe4gO8L/juq3YU/p26+h+84
         ecGe+HZyIbazdleA3ksKdfG8GmgbBDd41GeQYENhUT3HwxrgzZsu7GAacf2JMjflDLnH
         1O53BK/R96B7/OeBz+IE47R8pu2AnshhrJDQy+3zWfHsoF0paHtUJXUbth5yyrskLJvK
         kRekwHThD+4T18zC1vLgQTtsMKBOG01/Z7Mz9vN5Icw1m5IyInhqWlrpER968vbzvEmS
         gAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219355; x=1769824155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=deL+GFbShaY/PU1BGtjyGIzsYhM8+/qKKNNQ78FbRiE=;
        b=aN5Exa7jx7TMARUDTlCpmQwiqSG43RwTiApEG8lI8Aax9r6JjBfMZ/wzBLtupIU0MV
         3EOoUiy4BCnpZu7QsXCXJ1GfVZnsuxX4P6dEp7yJRBopb/YGDLnCU+PzBhv3X1ES1cwQ
         rdvTjWu0p/0ldcF66rj8Wk0yhHw7bHNIYRWP+35MuGApVs24nDZ11/ErDwNBWmueKIUs
         BM2/MJyTMdSisysKRnVRNJa0PvtMMtP5DSYM6LqKZMtC7fxepXWGOgQ6zjGdD+2TchRt
         iCS7fc071I9RoLj0/V2Fqs96b1ubQksFuJqVHUcS0B7Zf3u4QBJlg7BIw7JPjGROuDeZ
         VZTg==
X-Forwarded-Encrypted: i=1; AJvYcCXouNt1XQJeZmPaWi75SpDmAL7JPUzdo5ohq6TaQdxxSb+bzokr6/yf4eRmBk4jrL5lanukPjj2ZPnNPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLKoTUAZrtDJUQ+c8jF5zyPFAgHygAzXQLU6bVA4BTib7tUDL
	5/WbPL6ET/usNyIi45IDxTCcgYzmlaK5x8i69AyQmy9MrwJPcq4pG72GTbYD7Q==
X-Gm-Gg: AZuq6aL79B6I9WYeSnZWuaMIJtJKQ6BRXLBLmJ3MANCbTGs3rUmN9OaQKUcMokuYL+F
	wZmhel64KDveRHNfPOljar+5hD6a7SlHvh+BQ4bz3hWZ0b0kSXQjBcZGx0FmY4iVodiivhEWrgf
	Zy8YwY+gvlX0DGmcTiCAITVl+D6p1vnC0JWJn7OYwc8qFsQ7mwt2UlXQlA/iu7yUhEaisDVqmr6
	jtdoNOEx3hWzASjHq7xNr5UTyu6n1LjxRpJBsjUaOdFVdP1Lm90QgGHKGSmHASBjvYvF3tT4vp1
	ZQ0qm23CYCW4O9qXa9COtWRuLWcS0a007AZkuQTOq74djlPwVIqRsa114LA7v55ODMvgINlRPCw
	WZ29oMRs0z6nwcePCsxutU+lw8cDYueyX8a8jwzDU4rTX0QGT42F51P6gp5028qN8hMgXrPhCqK
	lfT2LSbFyNXn9mNmsCrZh+deqNjDdnAFLO8BLEEL2072/H2hatnanH+0EAqBC66ig=
X-Received: by 2002:a05:7300:f10a:b0:2b7:359b:188f with SMTP id 5a478bee46e88-2b739b8d1e9mr3245418eec.25.1769219355351;
        Fri, 23 Jan 2026 17:49:15 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5160014eec.29.2026.01.23.17.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 17:49:15 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/16] HID: hid-lenovo-go: Add Rumble and Haptic Settings
Date: Sat, 24 Jan 2026 01:48:55 +0000
Message-ID: <20260124014907.991265-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124014907.991265-1-derekjohn.clark@gmail.com>
References: <20260124014907.991265-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds attributes that control the handles rumble mode and intensity, as
well as touchpad haptic feedback settings.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
V3:
 - Remove erroneous renaming of enabled -> enable for some left & right
   handle attributes.
---
 drivers/hid/hid-lenovo-go.c | 312 ++++++++++++++++++++++++++++++++++++
 1 file changed, 312 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 681791f119d1..fe39a2b38f38 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -38,6 +38,8 @@ struct hid_go_cfg {
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
 	u8 fps_mode;
 	u8 gp_left_auto_sleep_time;
+	u8 gp_left_notify_en;
+	u8 gp_left_rumble_mode;
 	u32 gp_left_version_firmware;
 	u8 gp_left_version_gen;
 	u32 gp_left_version_hardware;
@@ -45,11 +47,14 @@ struct hid_go_cfg {
 	u32 gp_left_version_protocol;
 	u8 gp_mode;
 	u8 gp_right_auto_sleep_time;
+	u8 gp_right_notify_en;
+	u8 gp_right_rumble_mode;
 	u32 gp_right_version_firmware;
 	u8 gp_right_version_gen;
 	u32 gp_right_version_hardware;
 	u32 gp_right_version_product;
 	u32 gp_right_version_protocol;
+	u8 gp_rumble_intensity;
 	u8 imu_left_bypass_en;
 	u8 imu_left_sensor_en;
 	u8 imu_right_bypass_en;
@@ -61,6 +66,8 @@ struct hid_go_cfg {
 	u32 mcu_version_protocol;
 	u8 rgb_en;
 	u8 tp_en;
+	u8 tp_vibration_en;
+	u8 tp_vibration_intensity;
 	u32 tx_dongle_version_firmware;
 	u8 tx_dongle_version_gen;
 	u32 tx_dongle_version_hardware;
@@ -167,6 +174,49 @@ static const char *const gamepad_mode_text[] = {
 	[DINPUT] = "dinput",
 };
 
+enum motor_cfg_index {
+	MOTOR_CFG_ALL = 0x01,
+	MOTOR_INTENSITY,
+	VIBRATION_NOTIFY_ENABLE,
+	RUMBLE_MODE,
+	TP_VIBRATION_ENABLE,
+	TP_VIBRATION_INTENSITY,
+};
+
+enum intensity_index {
+	INTENSITY_UNKNOWN,
+	INTENSITY_OFF,
+	INTENSITY_LOW,
+	INTENSITY_MEDIUM,
+	INTENSITY_HIGH,
+};
+
+static const char *const intensity_text[] = {
+	[INTENSITY_UNKNOWN] = "unknown",
+	[INTENSITY_OFF] = "off",
+	[INTENSITY_LOW] = "low",
+	[INTENSITY_MEDIUM] = "medium",
+	[INTENSITY_HIGH] = "high",
+};
+
+enum rumble_mode_index {
+	RUMBLE_MODE_UNKNOWN,
+	RUMBLE_MODE_FPS,
+	RUMBLE_MODE_RACE,
+	RUMBLE_MODE_AVERAGE,
+	RUMBLE_MODE_SPG,
+	RUMBLE_MODE_RPG,
+};
+
+static const char *const rumble_mode_text[] = {
+	[RUMBLE_MODE_UNKNOWN] = "unknown",
+	[RUMBLE_MODE_FPS] = "fps",
+	[RUMBLE_MODE_RACE] = "racing",
+	[RUMBLE_MODE_AVERAGE] = "standard",
+	[RUMBLE_MODE_SPG] = "spg",
+	[RUMBLE_MODE_RPG] = "rpg",
+};
+
 static int hid_go_version_event(struct command_report *cmd_rep)
 {
 	switch (cmd_rep->sub_cmd) {
@@ -333,6 +383,47 @@ static int hid_go_feature_status_event(struct command_report *cmd_rep)
 	}
 }
 
+static int hid_go_motor_event(struct command_report *cmd_rep)
+{
+	switch (cmd_rep->sub_cmd) {
+	case MOTOR_CFG_ALL:
+		return -EINVAL;
+	case MOTOR_INTENSITY:
+		drvdata.gp_rumble_intensity = cmd_rep->data[0];
+		return 0;
+	case VIBRATION_NOTIFY_ENABLE:
+		switch (cmd_rep->device_type) {
+		case LEFT_CONTROLLER:
+			drvdata.gp_left_notify_en = cmd_rep->data[0];
+			return 0;
+		case RIGHT_CONTROLLER:
+			drvdata.gp_right_notify_en = cmd_rep->data[0];
+			return 0;
+		default:
+			return -EINVAL;
+		};
+		break;
+	case RUMBLE_MODE:
+		switch (cmd_rep->device_type) {
+		case LEFT_CONTROLLER:
+			drvdata.gp_left_rumble_mode = cmd_rep->data[0];
+			return 0;
+		case RIGHT_CONTROLLER:
+			drvdata.gp_right_rumble_mode = cmd_rep->data[0];
+			return 0;
+		default:
+			return -EINVAL;
+		};
+	case TP_VIBRATION_ENABLE:
+		drvdata.tp_vibration_en = cmd_rep->data[0];
+		return 0;
+	case TP_VIBRATION_INTENSITY:
+		drvdata.tp_vibration_intensity = cmd_rep->data[0];
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static int hid_go_set_event_return(struct command_report *cmd_rep)
 {
 	if (cmd_rep->data[0] != 0)
@@ -380,7 +471,11 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 		case GET_FEATURE_STATUS:
 			ret = hid_go_feature_status_event(cmd_rep);
 			break;
+		case GET_MOTOR_CFG:
+			ret = hid_go_motor_event(cmd_rep);
+			break;
 		case SET_FEATURE_STATUS:
+		case SET_MOTOR_CFG:
 			ret = hid_go_set_event_return(cmd_rep);
 			break;
 		default:
@@ -757,6 +852,168 @@ static ssize_t feature_status_options(struct device *dev,
 	return count;
 }
 
+static ssize_t motor_config_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count,
+				  enum motor_cfg_index index,
+				  enum dev_type device_type)
+{
+	size_t size = 1;
+	u8 val = 0;
+	int ret;
+
+	switch (index) {
+	case MOTOR_CFG_ALL:
+		return -EINVAL;
+	case MOTOR_INTENSITY:
+		ret = sysfs_match_string(intensity_text, buf);
+		val = ret;
+		break;
+	case VIBRATION_NOTIFY_ENABLE:
+		ret = sysfs_match_string(enabled_status_text, buf);
+		val = ret;
+		break;
+	case RUMBLE_MODE:
+		ret = sysfs_match_string(rumble_mode_text, buf);
+		val = ret;
+		break;
+	case TP_VIBRATION_ENABLE:
+		ret = sysfs_match_string(enabled_status_text, buf);
+		val = ret;
+		break;
+	case TP_VIBRATION_INTENSITY:
+		ret = sysfs_match_string(intensity_text, buf);
+		val = ret;
+		break;
+	};
+
+	if (ret < 0)
+		return ret;
+
+	if (!val)
+		size = 0;
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, SET_MOTOR_CFG,
+			       index, device_type, &val, size);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t motor_config_show(struct device *dev,
+				 struct device_attribute *attr, char *buf,
+				 enum motor_cfg_index index,
+				 enum dev_type device_type)
+{
+	ssize_t count = 0;
+	int ret;
+	u8 i;
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_MOTOR_CFG,
+			       index, device_type, 0, 0);
+	if (ret)
+		return ret;
+
+	switch (index) {
+	case MOTOR_CFG_ALL:
+		return -EINVAL;
+	case MOTOR_INTENSITY:
+		i = drvdata.gp_rumble_intensity;
+		if (i >= ARRAY_SIZE(intensity_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", intensity_text[i]);
+		break;
+	case VIBRATION_NOTIFY_ENABLE:
+		switch (device_type) {
+		case LEFT_CONTROLLER:
+			i = drvdata.gp_left_notify_en;
+			break;
+		case RIGHT_CONTROLLER:
+			i = drvdata.gp_right_notify_en;
+			break;
+		default:
+			return -EINVAL;
+		};
+		if (i >= ARRAY_SIZE(enabled_status_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", enabled_status_text[i]);
+		break;
+	case RUMBLE_MODE:
+		switch (device_type) {
+		case LEFT_CONTROLLER:
+			i = drvdata.gp_left_rumble_mode;
+			break;
+		case RIGHT_CONTROLLER:
+			i = drvdata.gp_right_rumble_mode;
+			break;
+		default:
+			return -EINVAL;
+		};
+		if (i >= ARRAY_SIZE(rumble_mode_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", rumble_mode_text[i]);
+		break;
+	case TP_VIBRATION_ENABLE:
+		i = drvdata.tp_vibration_en;
+		if (i >= ARRAY_SIZE(enabled_status_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", enabled_status_text[i]);
+		break;
+	case TP_VIBRATION_INTENSITY:
+		i = drvdata.tp_vibration_intensity;
+		if (i >= ARRAY_SIZE(intensity_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", intensity_text[i]);
+		break;
+	};
+
+	return count;
+}
+
+static ssize_t motor_config_options(struct device *dev,
+				    struct device_attribute *attr, char *buf,
+				    enum motor_cfg_index index)
+{
+	ssize_t count = 0;
+	unsigned int i;
+
+	switch (index) {
+	case MOTOR_CFG_ALL:
+		break;
+	case RUMBLE_MODE:
+		for (i = 1; i < ARRAY_SIZE(rumble_mode_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       rumble_mode_text[i]);
+		}
+		break;
+	case MOTOR_INTENSITY:
+	case TP_VIBRATION_INTENSITY:
+		for (i = 1; i < ARRAY_SIZE(intensity_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       intensity_text[i]);
+		}
+		break;
+	case VIBRATION_NOTIFY_ENABLE:
+	case TP_VIBRATION_ENABLE:
+		for (i = 1; i < ARRAY_SIZE(enabled_status_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       enabled_status_text[i]);
+		}
+		break;
+	};
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+
 #define LEGO_DEVICE_ATTR_RW(_name, _attrname, _dtype, _rtype, _group)         \
 	static ssize_t _name##_store(struct device *dev,                      \
 				     struct device_attribute *attr,           \
@@ -822,10 +1079,18 @@ static DEVICE_ATTR_RO_NAMED(gamepad_mode_index, "mode_index");
 struct go_cfg_attr reset_mcu = { FEATURE_RESET_GAMEPAD };
 LEGO_DEVICE_ATTR_WO(reset_mcu, "reset_mcu", USB_MCU, feature_status);
 
+struct go_cfg_attr gamepad_rumble_intensity = { MOTOR_INTENSITY };
+LEGO_DEVICE_ATTR_RW(gamepad_rumble_intensity, "rumble_intensity", UNSPECIFIED,
+		    index, motor_config);
+static DEVICE_ATTR_RO_NAMED(gamepad_rumble_intensity_index,
+			    "rumble_intensity_index");
+
 static struct attribute *mcu_attrs[] = {
 	&dev_attr_fps_switch_status.attr,
 	&dev_attr_gamepad_mode.attr,
 	&dev_attr_gamepad_mode_index.attr,
+	&dev_attr_gamepad_rumble_intensity.attr,
+	&dev_attr_gamepad_rumble_intensity_index.attr,
 	&dev_attr_reset_mcu.attr,
 	&dev_attr_version_firmware_mcu.attr,
 	&dev_attr_version_gen_mcu.attr,
@@ -908,6 +1173,17 @@ static DEVICE_ATTR_RO_NAMED(imu_enabled_left_index, "imu_enabled_index");
 struct go_cfg_attr reset_left = { FEATURE_RESET_GAMEPAD };
 LEGO_DEVICE_ATTR_WO(reset_left, "reset", LEFT_CONTROLLER, feature_status);
 
+struct go_cfg_attr rumble_mode_left = { RUMBLE_MODE };
+LEGO_DEVICE_ATTR_RW(rumble_mode_left, "rumble_mode", LEFT_CONTROLLER, index,
+		    motor_config);
+static DEVICE_ATTR_RO_NAMED(rumble_mode_left_index, "rumble_mode_index");
+
+struct go_cfg_attr rumble_notification_left = { VIBRATION_NOTIFY_ENABLE };
+LEGO_DEVICE_ATTR_RW(rumble_notification_left, "rumble_notification",
+		    LEFT_CONTROLLER, index, motor_config);
+static DEVICE_ATTR_RO_NAMED(rumble_notification_left_index,
+			    "rumble_notification_index");
+
 static struct attribute *left_gamepad_attrs[] = {
 	&dev_attr_auto_sleep_time_left.attr,
 	&dev_attr_auto_sleep_time_left_range.attr,
@@ -916,6 +1192,10 @@ static struct attribute *left_gamepad_attrs[] = {
 	&dev_attr_imu_enabled_left.attr,
 	&dev_attr_imu_enabled_left_index.attr,
 	&dev_attr_reset_left.attr,
+	&dev_attr_rumble_mode_left.attr,
+	&dev_attr_rumble_mode_left_index.attr,
+	&dev_attr_rumble_notification_left.attr,
+	&dev_attr_rumble_notification_left_index.attr,
 	&dev_attr_version_hardware_left.attr,
 	&dev_attr_version_firmware_left.attr,
 	&dev_attr_version_gen_left.attr,
@@ -964,6 +1244,17 @@ static DEVICE_ATTR_RO_NAMED(imu_enabled_right_index, "imu_enabled_index");
 struct go_cfg_attr reset_right = { FEATURE_RESET_GAMEPAD };
 LEGO_DEVICE_ATTR_WO(reset_right, "reset", LEFT_CONTROLLER, feature_status);
 
+struct go_cfg_attr rumble_mode_right = { RUMBLE_MODE };
+LEGO_DEVICE_ATTR_RW(rumble_mode_right, "rumble_mode", RIGHT_CONTROLLER, index,
+		    motor_config);
+static DEVICE_ATTR_RO_NAMED(rumble_mode_right_index, "rumble_mode_index");
+
+struct go_cfg_attr rumble_notification_right = { VIBRATION_NOTIFY_ENABLE };
+LEGO_DEVICE_ATTR_RW(rumble_notification_right, "rumble_notification",
+		    RIGHT_CONTROLLER, index, motor_config);
+static DEVICE_ATTR_RO_NAMED(rumble_notification_right_index,
+			    "rumble_notification_index");
+
 static struct attribute *right_gamepad_attrs[] = {
 	&dev_attr_auto_sleep_time_right.attr,
 	&dev_attr_auto_sleep_time_right_range.attr,
@@ -972,6 +1263,10 @@ static struct attribute *right_gamepad_attrs[] = {
 	&dev_attr_imu_enabled_right.attr,
 	&dev_attr_imu_enabled_right_index.attr,
 	&dev_attr_reset_right.attr,
+	&dev_attr_rumble_mode_right.attr,
+	&dev_attr_rumble_mode_right_index.attr,
+	&dev_attr_rumble_notification_right.attr,
+	&dev_attr_rumble_notification_right_index.attr,
 	&dev_attr_version_hardware_right.attr,
 	&dev_attr_version_firmware_right.attr,
 	&dev_attr_version_gen_right.attr,
@@ -991,9 +1286,26 @@ LEGO_DEVICE_ATTR_RW(touchpad_enabled, "enabled", UNSPECIFIED, index,
 		    feature_status);
 static DEVICE_ATTR_RO_NAMED(touchpad_enabled_index, "enabled_index");
 
+struct go_cfg_attr touchpad_vibration_enabled = { TP_VIBRATION_ENABLE };
+LEGO_DEVICE_ATTR_RW(touchpad_vibration_enabled, "vibration_enabled", UNSPECIFIED,
+		    index, motor_config);
+static DEVICE_ATTR_RO_NAMED(touchpad_vibration_enabled_index,
+			    "vibration_enabled_index");
+
+struct go_cfg_attr touchpad_vibration_intensity = { TP_VIBRATION_INTENSITY };
+LEGO_DEVICE_ATTR_RW(touchpad_vibration_intensity, "vibration_intensity",
+		    UNSPECIFIED, index, motor_config);
+static DEVICE_ATTR_RO_NAMED(touchpad_vibration_intensity_index,
+			    "vibration_intensity_index");
+
 static struct attribute *touchpad_attrs[] = {
 	&dev_attr_touchpad_enabled.attr,
 	&dev_attr_touchpad_enabled_index.attr,
+	&dev_attr_touchpad_vibration_enabled.attr,
+	&dev_attr_touchpad_vibration_enabled_index.attr,
+	&dev_attr_touchpad_vibration_intensity.attr,
+	&dev_attr_touchpad_vibration_intensity_index.attr,
+	NULL,
 };
 
 static const struct attribute_group touchpad_attr_group = {
-- 
2.52.0

