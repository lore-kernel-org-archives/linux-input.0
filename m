Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460F3E9F95
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127790; cv=none; b=M5E6uO80HHIfjB0FFlc2otlnkTc6Dv22V9YO8ESNALe1thuoxFYKFLUMpQGCp3SvjIZa9ZGaLj/5Z3vawqXdr94rbwoTYDOf8MYzP21P+hq9hVryP9qftaQgiYSC9dC8m4LOn8yUy/tf/fE14h9x6ZIY0iZicwPw+RdU7KDUV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127790; c=relaxed/simple;
	bh=0mNJFd+AQj98fZ3tSWfz7Z0My8xqM5TJXmPndGQ3Ljs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/f32PCmBDbHkVTbtuLNRj92jAgd1M3XL6P/0CIkTIXmQbOxMSLyRxbuJHZUbCXkcD0ub94bqWiRJyWnfYvs1KQ0Ydooiz4m9Xzb3RFmyjT1TvRKzHDRGoBj6B40h6cWSAeZ6Zs6rxmgTb5lH0R2nBf9lDVsUrLiJGFF6/fj+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PP5lpB+t; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP5lpB+t"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bdfc4b191fso7907004eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127787; x=1773732587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3hV8OG4iuTgSfSheXl6jgANZDKZZJT6Bsk+J0pI0/g=;
        b=PP5lpB+tyxTzDV5g9vj+Tpb24cDLUAvLcVM7Z2Xmo6Nfnk7Y4ykjF3Gm+k5Fc/nBbt
         7IohIxJkF8yCcm0QA8z8CIP0PHIdwlsU/8sEWRkkSdOh0IBGh8awzwe029vwK3I5ZYzA
         LupXSrTYTxImJ3kFVdpiupFI9N8xmB+R0LuewHBGbmEbi3bwBRS+fgtrrwDIAiqGGZ2d
         mP5mtMXgJgBJio/+x6Q+doYWyd3VoCYGvPVD+c/ghVf8n0o46EinA+JLgrL+VOcFBZ+N
         z2QcDWrJbyVjZvGVjlVl7o4/8O1MpggISaAAV/Y40jMUQoCfFuF/Kn6wAX3ncQl/OrWf
         04RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127787; x=1773732587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3hV8OG4iuTgSfSheXl6jgANZDKZZJT6Bsk+J0pI0/g=;
        b=XC0KwdZDzVNI+TGAQSnwWrqx4+zOdrWO3gCCiQmlMvxavLDhLbRktpzUKJs4ujS7J3
         HM76JQw6WBEs1aAfIifxv+2xAOM90dO1r00mhVUYkXJHuxj3IMS7IFB8uM6RDsg0lgPO
         8JSUSFl2ykjhen+N4V/sFtXLVpgNkEcB5IYKxdE/qQKTKp3Aa8mo/Ud77ifuCueyesVV
         1cXISPIJWSsAMFv78exXUxJGgxAXk3XUmkTnR/d+GMxu5uajpQfVa0i98WU1RwuGdZ32
         UvWz8M/0YGh05ZPbes5mGc6ejqpsG0zMuOdZ2YwPXtu5u8In6MpMeJ8jzEdSmYGr7yh1
         z3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdDpk3gTjvwf+fnR+1/UkAahfiK3gTl6vP7uharPpM0c1r9UwM0K1+LRwV/SWBsQDGbXNNhuWZ4CmXag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KCU6JJ01ArgRvxOqElXa+WLBxHVHfiu8/KLn0uJc9DFBCF4w
	IUX0w4hEv6AJ6D9ctDGX7OEmyElB034R+H1DIki8Jct+0lC72hSI4Lt1
X-Gm-Gg: ATEYQzzs36ogdwoH5wAOXHjrkfBLHuVpo5yAUUKdpwAmK0FAyGSYZSWesUxUGcZm4j/
	CJ/3gNUWkktvAn6smoeyQw4rnuz4dDc5GUMhhRzVwmfkvQCWF/LF6XRTN7QCK8Yog6hnpqePZGk
	nwI4PE8JnfyQ0tjxkY9aSLvbTl4913r/9M6b0f56eikFZT8qp6L0jV8c/+6XS+bAdgoR+HX+Y56
	WZW+VTya8+8W+2PSNreOyocUK4v3bGoeg4LwEfatO/uSjjwVHxP1gOgAGGfBEYzD/pKeqh9g5Wq
	rQfQ8an9z85RQIKXNt0/0pqMEAFMa0HS7avItKtaJzfAS/PPJnTI8brjGuiXF2BK5tF0jfefl1A
	oIed8eTnG+53HhbBCxwb+Jdyri3lsXtSCG+jppBov6lRzBrua+t34bQUaWcQjZMMPxGDZLWJU98
	f/oIn/Vshfmqjbf+ICWAFS6z8jTqlUWaTRqZnB1/yas4H5VIGWI6jP/UNDXQDWRG/hGdDy2hRUf
	9w3
X-Received: by 2002:a05:7300:fd03:b0:2ba:9835:1113 with SMTP id 5a478bee46e88-2be4e090029mr5561249eec.36.1773127786591;
        Tue, 10 Mar 2026 00:29:46 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:46 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/19] HID: hid-lenovo-go: Add Calibration Settings
Date: Tue, 10 Mar 2026 07:29:25 +0000
Message-ID: <20260310072937.3295875-8-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
References: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds calibration enable and last calibration status indicators for the
triggers, joysticks, and handle gyros.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v6:
  - Make local attributes static.
---
 drivers/hid/hid-lenovo-go.c | 284 +++++++++++++++++++++++++++++++++++-
 1 file changed, 283 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index ee7d4bf23a17..082d1b85d679 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -43,8 +43,11 @@ static struct hid_go_cfg {
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
 	u8 fps_mode;
 	u8 gp_left_auto_sleep_time;
+	u8 gp_left_gyro_cal_status;
+	u8 gp_left_joy_cal_status;
 	u8 gp_left_notify_en;
 	u8 gp_left_rumble_mode;
+	u8 gp_left_trigg_cal_status;
 	u32 gp_left_version_firmware;
 	u8 gp_left_version_gen;
 	u32 gp_left_version_hardware;
@@ -52,8 +55,11 @@ static struct hid_go_cfg {
 	u32 gp_left_version_protocol;
 	u8 gp_mode;
 	u8 gp_right_auto_sleep_time;
+	u8 gp_right_gyro_cal_status;
+	u8 gp_right_joy_cal_status;
 	u8 gp_right_notify_en;
 	u8 gp_right_rumble_mode;
+	u8 gp_right_trigg_cal_status;
 	u32 gp_right_version_firmware;
 	u8 gp_right_version_gen;
 	u32 gp_right_version_hardware;
@@ -227,7 +233,41 @@ static const char *const rumble_mode_text[] = {
 	[RUMBLE_MODE_RPG] = "rpg",
 };
 
-#define FPS_MODE_DPI           0x02
+#define FPS_MODE_DPI		0x02
+#define TRIGGER_CALIBRATE	0x04
+#define JOYSTICK_CALIBRATE	0x04
+#define GYRO_CALIBRATE		0x06
+
+enum cal_device_type {
+	CALDEV_GYROSCOPE = 0x01,
+	CALDEV_JOYSTICK,
+	CALDEV_TRIGGER,
+	CALDEV_JOY_TRIGGER,
+};
+
+enum cal_enable {
+	CAL_UNKNOWN,
+	CAL_START,
+	CAL_STOP,
+};
+
+static const char *const cal_enabled_text[] = {
+	[CAL_UNKNOWN] = "unknown",
+	[CAL_START] = "start",
+	[CAL_STOP] = "stop",
+};
+
+enum cal_status_index {
+	CAL_STAT_UNKNOWN,
+	CAL_STAT_SUCCESS,
+	CAL_STAT_FAILURE,
+};
+
+static const char *const cal_status_text[] = {
+	[CAL_STAT_UNKNOWN] = "unknown",
+	[CAL_STAT_SUCCESS] = "success",
+	[CAL_STAT_FAILURE] = "failure",
+};
 
 enum rgb_config_index {
 	LIGHT_CFG_ALL = 0x01,
@@ -264,6 +304,13 @@ static const char *const rgb_effect_text[] = {
 	[RGB_EFFECT_RAINBOW] = "rainbow",
 };
 
+enum device_status_index {
+	GET_CAL_STATUS = 0x02,
+	GET_UPGRADE_STATUS,
+	GET_MACRO_REC_STATUS,
+	GET_HOTKEY_TRIGG_STATUS,
+};
+
 static int hid_go_version_event(struct command_report *cmd_rep)
 {
 	switch (cmd_rep->sub_cmd) {
@@ -508,6 +555,44 @@ static int hid_go_light_event(struct command_report *cmd_rep)
 	}
 }
 
+static int hid_go_device_status_event(struct command_report *cmd_rep)
+{
+	switch (cmd_rep->device_type) {
+	case LEFT_CONTROLLER:
+		switch (cmd_rep->data[0]) {
+		case CALDEV_GYROSCOPE:
+			drvdata.gp_left_gyro_cal_status = cmd_rep->data[1];
+			return 0;
+		case CALDEV_JOYSTICK:
+			drvdata.gp_left_joy_cal_status = cmd_rep->data[1];
+			return 0;
+		case CALDEV_TRIGGER:
+			drvdata.gp_left_trigg_cal_status = cmd_rep->data[1];
+			return 0;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case RIGHT_CONTROLLER:
+		switch (cmd_rep->data[0]) {
+		case CALDEV_GYROSCOPE:
+			drvdata.gp_right_gyro_cal_status = cmd_rep->data[1];
+			return 0;
+		case CALDEV_JOYSTICK:
+			drvdata.gp_right_joy_cal_status = cmd_rep->data[1];
+			return 0;
+		case CALDEV_TRIGGER:
+			drvdata.gp_right_trigg_cal_status = cmd_rep->data[1];
+			return 0;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int hid_go_set_event_return(struct command_report *cmd_rep)
 {
 	if (cmd_rep->data[0] != 0)
@@ -564,10 +649,16 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 		case GET_RGB_CFG:
 			ret = hid_go_light_event(cmd_rep);
 			break;
+		case GET_DEVICE_STATUS:
+			ret = hid_go_device_status_event(cmd_rep);
+			break;
 		case SET_FEATURE_STATUS:
 		case SET_MOTOR_CFG:
 		case SET_DPI_CFG:
 		case SET_RGB_CFG:
+		case SET_TRIGGER_CFG:
+		case SET_JOYSTICK_CFG:
+		case SET_GYRO_CFG:
 			ret = hid_go_set_event_return(cmd_rep);
 			break;
 		default:
@@ -1157,6 +1248,101 @@ static ssize_t fps_mode_dpi_index_show(struct device *dev,
 	return sysfs_emit(buf, "500 800 1200 1800\n");
 }
 
+static ssize_t device_status_show(struct device *dev,
+				  struct device_attribute *attr, char *buf,
+				  enum device_status_index index,
+				  enum dev_type device_type,
+				  enum cal_device_type cal_type)
+{
+	u8 i;
+
+	switch (index) {
+	case GET_CAL_STATUS:
+		switch (device_type) {
+		case LEFT_CONTROLLER:
+			switch (cal_type) {
+			case CALDEV_GYROSCOPE:
+				i = drvdata.gp_left_gyro_cal_status;
+				break;
+			case CALDEV_JOYSTICK:
+				i = drvdata.gp_left_joy_cal_status;
+				break;
+			case CALDEV_TRIGGER:
+				i = drvdata.gp_left_trigg_cal_status;
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case RIGHT_CONTROLLER:
+			switch (cal_type) {
+			case CALDEV_GYROSCOPE:
+				i = drvdata.gp_right_gyro_cal_status;
+				break;
+			case CALDEV_JOYSTICK:
+				i = drvdata.gp_right_joy_cal_status;
+				break;
+			case CALDEV_TRIGGER:
+				i = drvdata.gp_right_trigg_cal_status;
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	if (i >= ARRAY_SIZE(cal_status_text))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", cal_status_text[i]);
+}
+
+static ssize_t calibrate_config_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, u8 cmd, u8 sub_cmd,
+				      size_t count, enum dev_type device_type)
+{
+	size_t size = 1;
+	u8 val = 0;
+	int ret;
+
+	ret = sysfs_match_string(cal_enabled_text, buf);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+	if (!val)
+		size = 0;
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, cmd, sub_cmd,
+			       device_type, &val, size);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t calibrate_config_options(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	ssize_t count = 0;
+	unsigned int i;
+
+	for (i = 1; i < ARRAY_SIZE(cal_enabled_text); i++)
+		count += sysfs_emit_at(buf, count, "%s ", cal_enabled_text[i]);
+
+	buf[count - 1] = '\n';
+
+	return count;
+}
+
 static int rgb_cfg_call(struct hid_device *hdev, enum mcu_command_index cmd,
 			enum rgb_config_index index, u8 *val, size_t size)
 {
@@ -1466,6 +1652,30 @@ static void hid_go_brightness_set(struct led_classdev *led_cdev,
 	}                                                                     \
 	static DEVICE_ATTR_RO_NAMED(_name, _attrname)
 
+#define LEGO_CAL_DEVICE_ATTR(_name, _attrname, _scmd, _dtype, _rtype)         \
+	static ssize_t _name##_store(struct device *dev,                      \
+				     struct device_attribute *attr,           \
+				     const char *buf, size_t count)           \
+	{                                                                     \
+		return calibrate_config_store(dev, attr, buf, _name.index,    \
+					      _scmd, count, _dtype);          \
+	}                                                                     \
+	static ssize_t _name##_##_rtype##_show(                               \
+		struct device *dev, struct device_attribute *attr, char *buf) \
+	{                                                                     \
+		return calibrate_config_options(dev, attr, buf);              \
+	}                                                                     \
+	static DEVICE_ATTR_WO_NAMED(_name, _attrname)
+
+#define LEGO_DEVICE_STATUS_ATTR(_name, _attrname, _scmd, _dtype)              \
+	static ssize_t _name##_show(struct device *dev,                       \
+				    struct device_attribute *attr, char *buf) \
+	{                                                                     \
+		return device_status_show(dev, attr, buf, _name.index, _scmd, \
+					  _dtype);                            \
+	}                                                                     \
+	static DEVICE_ATTR_RO_NAMED(_name, _attrname)
+
 /* Gamepad - MCU */
 static struct go_cfg_attr version_product_mcu = { PRODUCT_VERSION };
 LEGO_DEVICE_ATTR_RO(version_product_mcu, "product_version", USB_MCU, version);
@@ -1603,9 +1813,45 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_left, "rumble_notification",
 static DEVICE_ATTR_RO_NAMED(rumble_notification_left_index,
 			    "rumble_notification_index");
 
+static struct go_cfg_attr cal_trigg_left = { TRIGGER_CALIBRATE };
+LEGO_CAL_DEVICE_ATTR(cal_trigg_left, "calibrate_trigger", SET_TRIGGER_CFG,
+		     LEFT_CONTROLLER, index);
+static DEVICE_ATTR_RO_NAMED(cal_trigg_left_index, "calibrate_trigger_index");
+
+static struct go_cfg_attr cal_joy_left = { JOYSTICK_CALIBRATE };
+LEGO_CAL_DEVICE_ATTR(cal_joy_left, "calibrate_joystick", SET_JOYSTICK_CFG,
+		     LEFT_CONTROLLER, index);
+static DEVICE_ATTR_RO_NAMED(cal_joy_left_index, "calibrate_joystick_index");
+
+static struct go_cfg_attr cal_gyro_left = { GYRO_CALIBRATE };
+LEGO_CAL_DEVICE_ATTR(cal_gyro_left, "calibrate_gyro", SET_GYRO_CFG,
+		     LEFT_CONTROLLER, index);
+static DEVICE_ATTR_RO_NAMED(cal_gyro_left_index, "calibrate_gyro_index");
+
+static struct go_cfg_attr cal_trigg_left_status = { GET_CAL_STATUS };
+LEGO_DEVICE_STATUS_ATTR(cal_trigg_left_status, "calibrate_trigger_status",
+			LEFT_CONTROLLER, CALDEV_TRIGGER);
+
+static struct go_cfg_attr cal_joy_left_status = { GET_CAL_STATUS };
+LEGO_DEVICE_STATUS_ATTR(cal_joy_left_status, "calibrate_joystick_status",
+			LEFT_CONTROLLER, CALDEV_JOYSTICK);
+
+static struct go_cfg_attr cal_gyro_left_status = { GET_CAL_STATUS };
+LEGO_DEVICE_STATUS_ATTR(cal_gyro_left_status, "calibrate_gyro_status",
+			LEFT_CONTROLLER, CALDEV_GYROSCOPE);
+
 static struct attribute *left_gamepad_attrs[] = {
 	&dev_attr_auto_sleep_time_left.attr,
 	&dev_attr_auto_sleep_time_left_range.attr,
+	&dev_attr_cal_gyro_left.attr,
+	&dev_attr_cal_gyro_left_index.attr,
+	&dev_attr_cal_gyro_left_status.attr,
+	&dev_attr_cal_joy_left.attr,
+	&dev_attr_cal_joy_left_index.attr,
+	&dev_attr_cal_joy_left_status.attr,
+	&dev_attr_cal_trigg_left.attr,
+	&dev_attr_cal_trigg_left_index.attr,
+	&dev_attr_cal_trigg_left_status.attr,
 	&dev_attr_imu_bypass_left.attr,
 	&dev_attr_imu_bypass_left_index.attr,
 	&dev_attr_imu_enabled_left.attr,
@@ -1674,9 +1920,45 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_right, "rumble_notification",
 static DEVICE_ATTR_RO_NAMED(rumble_notification_right_index,
 			    "rumble_notification_index");
 
+static struct go_cfg_attr cal_trigg_right = { TRIGGER_CALIBRATE };
+LEGO_CAL_DEVICE_ATTR(cal_trigg_right, "calibrate_trigger", SET_TRIGGER_CFG,
+		     RIGHT_CONTROLLER, index);
+static DEVICE_ATTR_RO_NAMED(cal_trigg_right_index, "calibrate_trigger_index");
+
+static struct go_cfg_attr cal_joy_right = { JOYSTICK_CALIBRATE };
+LEGO_CAL_DEVICE_ATTR(cal_joy_right, "calibrate_joystick", SET_JOYSTICK_CFG,
+		     RIGHT_CONTROLLER, index);
+static DEVICE_ATTR_RO_NAMED(cal_joy_right_index, "calibrate_joystick_index");
+
+static struct go_cfg_attr cal_gyro_right = { GYRO_CALIBRATE };
+LEGO_CAL_DEVICE_ATTR(cal_gyro_right, "calibrate_gyro", SET_GYRO_CFG,
+		     RIGHT_CONTROLLER, index);
+static DEVICE_ATTR_RO_NAMED(cal_gyro_right_index, "calibrate_gyro_index");
+
+static struct go_cfg_attr cal_trigg_right_status = { GET_CAL_STATUS };
+LEGO_DEVICE_STATUS_ATTR(cal_trigg_right_status, "calibrate_trigger_status",
+			RIGHT_CONTROLLER, CALDEV_TRIGGER);
+
+static struct go_cfg_attr cal_joy_right_status = { GET_CAL_STATUS };
+LEGO_DEVICE_STATUS_ATTR(cal_joy_right_status, "calibrate_joystick_status",
+			RIGHT_CONTROLLER, CALDEV_JOYSTICK);
+
+static struct go_cfg_attr cal_gyro_right_status = { GET_CAL_STATUS };
+LEGO_DEVICE_STATUS_ATTR(cal_gyro_right_status, "calibrate_gyro_status",
+			RIGHT_CONTROLLER, CALDEV_GYROSCOPE);
+
 static struct attribute *right_gamepad_attrs[] = {
 	&dev_attr_auto_sleep_time_right.attr,
 	&dev_attr_auto_sleep_time_right_range.attr,
+	&dev_attr_cal_gyro_right.attr,
+	&dev_attr_cal_gyro_right_index.attr,
+	&dev_attr_cal_gyro_right_status.attr,
+	&dev_attr_cal_joy_right.attr,
+	&dev_attr_cal_joy_right_index.attr,
+	&dev_attr_cal_joy_right_status.attr,
+	&dev_attr_cal_trigg_right.attr,
+	&dev_attr_cal_trigg_right_index.attr,
+	&dev_attr_cal_trigg_right_status.attr,
 	&dev_attr_imu_bypass_right.attr,
 	&dev_attr_imu_bypass_right_index.attr,
 	&dev_attr_imu_enabled_right.attr,
-- 
2.53.0

