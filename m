Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC067330668
	for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571162; cv=none; b=iI1Pbn77hgBhMukwbaBagLp/r+0x1b5BXH6FB8OXvzhSxpTtcpMIvBfbNaTO4KGidVfN3bNIMnIbAjj0sHg2Fq9Zsq83RNIL6DAZBQfzZJLqyucyxQo24FiDtUi6iwIcl8l+SlfBkdumZ/f4Mukz4/plo3Ftd9ReIZhiLZ6GUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571162; c=relaxed/simple;
	bh=qSQwRYItgVMi3wY3B4B828Qul/NMS1RjkdsJQqRWAXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AS2CRqYATn8v7Di/FJHHbtRUFSLdKJ99DaxL2n8XEEQZ0dojdturoWw/aDJEJiEOrJeTCAV2UZBCO7h/Dq04xLqUxlZoa4sv3NjoRq87FTAVnN6lawKBbBtf5FZM++l/LL94OpOZOno5xrhMiJHFHSV3b3OQYC0EcpsJ0CvGuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKsFZMfV; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKsFZMfV"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso1855836eec.1
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 23:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771571160; x=1772175960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYLPU24pjTvBDvHxIyOgyVH+aGVKK2c1KDnSBknwkng=;
        b=SKsFZMfVpV7rSklgvNp7hr1W9F8Cm3azQmoylEpPhIvEZRdOhK/686jA5iHKYHvKAF
         UVu8n4cwxnDy00JFND486zu7QclTpdSlqOYvtwUyeUpBP2+R+ptC7m9h17Gbfy8O2OMY
         yVZDwckefg/Vfx0G4STT8MyYRsiR4PhE4lnyljmBNRWq3DPPLi8j/rGTd/nL0nHaE8qX
         XeirWPvP0uHGx4tadMWX0ZykzA5jguiUfi1CzoYH8wF/H3lDAC3w17BQdR73pdc2nRn6
         yZx3G6KPTrZL2qdoC+acSMDbZNmGfbuU5H4UK7mcvhV+6nExZz/DPFm2rcc9d/+F/rr/
         6CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771571160; x=1772175960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYLPU24pjTvBDvHxIyOgyVH+aGVKK2c1KDnSBknwkng=;
        b=bou3bBOWnBBS0lyAF/uNTh4YKkdkNxNwDplR4qJ8Tzd/ymo/dXhr8l/CQysbrT5MBL
         U7ue5M+6YLSU1vylTIEyifaXDBDp4fGqdniyBwPLx5xV0cA9XeIs3VDj+IntORft99mz
         eApKexAL0LiGLbIQyL9nLIBurP12wdGgDLQz8HOom9K8GoHAqP5ZpkfB9LCJY4exwYIC
         3wFu9OF5V2AWhscxpwmA58l2o+EBivgVN1hK3/xjUP5/fToRk7z8fJCT2Q1hbSJNbm1z
         9RXGlPHQF/LgFC7QssP1ZZ+d0IfctfiaUjsUslppCJsBRDCeoEXTDGBtQBm8jG53KYR4
         dH2g==
X-Forwarded-Encrypted: i=1; AJvYcCVhF3XqjqCDThuv0Gl0vcm+BA4CXBTCLFNTUmhDzFv0OqQ125UjsVpe6MvjfRQwX7YqaNoUC2a9knm0Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzohyXvwWnNM7jrhyH/+EbrUZ4tmQodhbHJksmbtaJYb92RAovv
	WD7sRxhssQdRUF4XpJRBTmEc5jAWtRrmGKPRvuVLTs3RexXdAsLIYWG2
X-Gm-Gg: AZuq6aIyakMYK4b//zMBEZYKopwbnbsB5FAqIPufPnN5hatjpJihsoTipi9Snefd2XV
	rdadd7CTHHMd03WsNuMU4cNAsJiYo2JTI753I7NIOh32g3KrH1Mow+EyHY0sTyst//rOD1MfvY6
	kUQ61KINa5lgT84ZF3hiSi/AbGH6OGfeHmp1nZsWdGhNXLMUTQlS+1YmIN3X0de9yu5cuPRrpln
	2thjzcG4FV+J69kfyUaTbf1Ut26FesigMJS9BDLbjYasSXQ3DaobkxautCcDEF0+D5db6MLrwSs
	sMEJ3Sf7VuOvua2MwUrbR7W98CZHhFlFMQJMqOgiSZZCgSPPQVveH02IfsI5SOqdPv0MzyPZD48
	+ZBDw2QH1kBGjgz4WrQZpaVDFVPK+XUM/4VDV+DI6QTPNvnoa67U56CDhvhubIMKNiCLkscPmdL
	fOz4kVOVCw1rIUjP11eF9UHWU/9PqAy29Vm1RaLnxcrpI9U063mAoEej4LSvZkRbTgnYW6NaFuF
	oev25MSrydwDA==
X-Received: by 2002:a05:7300:d513:b0:2ba:9115:2fab with SMTP id 5a478bee46e88-2bac9356416mr7433934eec.12.1771571159922;
        Thu, 19 Feb 2026 23:05:59 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb669f7dsm22163335eec.23.2026.02.19.23.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 23:05:59 -0800 (PST)
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
Subject: [PATCH v4 03/16] HID: hid-lenovo-go: Add Feature Status Attributes
Date: Fri, 20 Feb 2026 07:05:16 +0000
Message-ID: <20260220070533.4083667-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
References: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds various feature status indicators and toggles to hid-lenovo-go,
including the FPS mode switch setting, touchpad enable toggle, handle
automatic sleep timer, etc.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 396 +++++++++++++++++++++++++++++++++++-
 1 file changed, 395 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 8a9f8063ee738..308a544c3c911 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -36,21 +36,31 @@ struct hid_go_cfg {
 	struct completion send_cmd_complete;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	u8 fps_mode;
+	u8 gp_left_auto_sleep_time;
 	u32 gp_left_version_firmware;
 	u8 gp_left_version_gen;
 	u32 gp_left_version_hardware;
 	u32 gp_left_version_product;
 	u32 gp_left_version_protocol;
+	u8 gp_mode;
+	u8 gp_right_auto_sleep_time;
 	u32 gp_right_version_firmware;
 	u8 gp_right_version_gen;
 	u32 gp_right_version_hardware;
 	u32 gp_right_version_product;
 	u32 gp_right_version_protocol;
+	u8 imu_left_bypass_en;
+	u8 imu_left_sensor_en;
+	u8 imu_right_bypass_en;
+	u8 imu_right_sensor_en;
 	u32 mcu_version_firmware;
 	u8 mcu_version_gen;
 	u32 mcu_version_hardware;
 	u32 mcu_version_product;
 	u32 mcu_version_protocol;
+	u8 rgb_en;
+	u8 tp_en;
 	u32 tx_dongle_version_firmware;
 	u8 tx_dongle_version_gen;
 	u32 tx_dongle_version_hardware;
@@ -102,6 +112,18 @@ enum dev_type {
 	RIGHT_CONTROLLER,
 };
 
+enum enabled_status_index {
+	FEATURE_UNKNOWN,
+	FEATURE_ENABLED,
+	FEATURE_DISABLED,
+};
+
+static const char *const enabled_status_text[] = {
+	[FEATURE_UNKNOWN] = "unknown",
+	[FEATURE_ENABLED] = "true",
+	[FEATURE_DISABLED] = "false",
+};
+
 enum version_data_index {
 	PRODUCT_VERSION = 0x02,
 	PROTOCOL_VERSION,
@@ -110,6 +132,41 @@ enum version_data_index {
 	HARDWARE_GENERATION,
 };
 
+enum feature_status_index {
+	FEATURE_RESET_GAMEPAD = 0x02,
+	FEATURE_IMU_BYPASS,
+	FEATURE_IMU_ENABLE = 0x05,
+	FEATURE_TOUCHPAD_ENABLE = 0x07,
+	FEATURE_LIGHT_ENABLE,
+	FEATURE_AUTO_SLEEP_TIME,
+	FEATURE_FPS_SWITCH_STATUS = 0x0b,
+	FEATURE_GAMEPAD_MODE = 0x0e,
+};
+
+enum fps_switch_status_index {
+	FPS_STATUS_UNKNOWN,
+	GAMEPAD,
+	FPS,
+};
+
+static const char *const fps_switch_text[] = {
+	[FPS_STATUS_UNKNOWN] = "unknown",
+	[GAMEPAD] = "gamepad",
+	[FPS] = "fps",
+};
+
+enum gamepad_mode_index {
+	GAMEPAD_MODE_UNKNOWN,
+	XINPUT,
+	DINPUT,
+};
+
+static const char *const gamepad_mode_text[] = {
+	[GAMEPAD_MODE_UNKNOWN] = "unknown",
+	[XINPUT] = "xinput",
+	[DINPUT] = "dinput",
+};
+
 static int hid_go_version_event(struct command_report *cmd_rep)
 {
 	switch (cmd_rep->sub_cmd) {
@@ -219,6 +276,71 @@ static int hid_go_version_event(struct command_report *cmd_rep)
 	}
 }
 
+static int hid_go_feature_status_event(struct command_report *cmd_rep)
+{
+	switch (cmd_rep->sub_cmd) {
+	case FEATURE_RESET_GAMEPAD:
+		return 0;
+	case FEATURE_IMU_ENABLE:
+		switch (cmd_rep->device_type) {
+		case LEFT_CONTROLLER:
+			drvdata.imu_left_sensor_en = cmd_rep->data[0];
+			return 0;
+		case RIGHT_CONTROLLER:
+			drvdata.imu_right_sensor_en = cmd_rep->data[0];
+			return 0;
+		default:
+			return -EINVAL;
+		};
+	case FEATURE_IMU_BYPASS:
+		switch (cmd_rep->device_type) {
+		case LEFT_CONTROLLER:
+			drvdata.imu_left_bypass_en = cmd_rep->data[0];
+			return 0;
+		case RIGHT_CONTROLLER:
+			drvdata.imu_right_bypass_en = cmd_rep->data[0];
+			return 0;
+		default:
+			return -EINVAL;
+		};
+		break;
+	case FEATURE_LIGHT_ENABLE:
+		drvdata.rgb_en = cmd_rep->data[0];
+		return 0;
+	case FEATURE_AUTO_SLEEP_TIME:
+		switch (cmd_rep->device_type) {
+		case LEFT_CONTROLLER:
+			drvdata.gp_left_auto_sleep_time = cmd_rep->data[0];
+			return 0;
+		case RIGHT_CONTROLLER:
+			drvdata.gp_right_auto_sleep_time = cmd_rep->data[0];
+			return 0;
+		default:
+			return -EINVAL;
+		};
+		break;
+	case FEATURE_TOUCHPAD_ENABLE:
+		drvdata.tp_en = cmd_rep->data[0];
+		return 0;
+	case FEATURE_GAMEPAD_MODE:
+		drvdata.gp_mode = cmd_rep->data[0];
+		return 0;
+	case FEATURE_FPS_SWITCH_STATUS:
+		drvdata.fps_mode = cmd_rep->data[0];
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hid_go_set_event_return(struct command_report *cmd_rep)
+{
+	if (cmd_rep->data[0] != 0)
+		return -EIO;
+
+	return 0;
+}
+
 static int get_endpoint_address(struct hid_device *hdev)
 {
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -255,6 +377,12 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 		case GET_VERSION_DATA:
 			ret = hid_go_version_event(cmd_rep);
 			break;
+		case GET_FEATURE_STATUS:
+			ret = hid_go_feature_status_event(cmd_rep);
+			break;
+		case SET_FEATURE_STATUS:
+			ret = hid_go_set_event_return(cmd_rep);
+			break;
 		default:
 			ret = -EINVAL;
 			break;
@@ -445,6 +573,195 @@ static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static ssize_t feature_status_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count,
+				    enum feature_status_index index,
+				    enum dev_type device_type)
+{
+	size_t size = 1;
+	u8 val = 0;
+	int ret;
+
+	switch (index) {
+	case FEATURE_IMU_ENABLE:
+	case FEATURE_IMU_BYPASS:
+	case FEATURE_LIGHT_ENABLE:
+	case FEATURE_TOUCHPAD_ENABLE:
+		ret = sysfs_match_string(enabled_status_text, buf);
+		val = ret;
+		break;
+	case FEATURE_AUTO_SLEEP_TIME:
+		ret = kstrtou8(buf, 10, &val);
+		break;
+	case FEATURE_RESET_GAMEPAD:
+		ret = kstrtou8(buf, 10, &val);
+		if (val != GO_GP_RESET_SUCCESS)
+			return -EINVAL;
+		break;
+	case FEATURE_FPS_SWITCH_STATUS:
+		ret = sysfs_match_string(fps_switch_text, buf);
+		val = ret;
+		break;
+	case FEATURE_GAMEPAD_MODE:
+		ret = sysfs_match_string(gamepad_mode_text, buf);
+		val = ret;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	if (ret < 0)
+		return ret;
+
+	if (!val)
+		size = 0;
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA,
+			       SET_FEATURE_STATUS, index, device_type, &val,
+			       size);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t feature_status_show(struct device *dev,
+				   struct device_attribute *attr, char *buf,
+				   enum feature_status_index index,
+				   enum dev_type device_type)
+{
+	ssize_t count = 0;
+	int ret;
+	u8 i;
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA,
+			       GET_FEATURE_STATUS, index, device_type, 0, 0);
+	if (ret)
+		return ret;
+
+	switch (index) {
+	case FEATURE_IMU_ENABLE:
+		switch (device_type) {
+		case LEFT_CONTROLLER:
+			i = drvdata.imu_left_sensor_en;
+			break;
+		case RIGHT_CONTROLLER:
+			i = drvdata.imu_right_sensor_en;
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (i >= ARRAY_SIZE(enabled_status_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", enabled_status_text[i]);
+		break;
+	case FEATURE_IMU_BYPASS:
+		switch (device_type) {
+		case LEFT_CONTROLLER:
+			i = drvdata.imu_left_bypass_en;
+			break;
+		case RIGHT_CONTROLLER:
+			i = drvdata.imu_right_bypass_en;
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (i >= ARRAY_SIZE(enabled_status_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", enabled_status_text[i]);
+		break;
+	case FEATURE_LIGHT_ENABLE:
+		i = drvdata.rgb_en;
+		if (i >= ARRAY_SIZE(enabled_status_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", enabled_status_text[i]);
+		break;
+	case FEATURE_TOUCHPAD_ENABLE:
+		i = drvdata.tp_en;
+		if (i >= ARRAY_SIZE(enabled_status_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", enabled_status_text[i]);
+		break;
+	case FEATURE_AUTO_SLEEP_TIME:
+		switch (device_type) {
+		case LEFT_CONTROLLER:
+			i = drvdata.gp_left_auto_sleep_time;
+			break;
+		case RIGHT_CONTROLLER:
+			i = drvdata.gp_right_auto_sleep_time;
+			break;
+		default:
+			return -EINVAL;
+		};
+		count = sysfs_emit(buf, "%u\n", i);
+		break;
+	case FEATURE_FPS_SWITCH_STATUS:
+		i = drvdata.fps_mode;
+		if (i >= ARRAY_SIZE(fps_switch_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", fps_switch_text[i]);
+		break;
+	case FEATURE_GAMEPAD_MODE:
+		i = drvdata.gp_mode;
+		if (i >= ARRAY_SIZE(gamepad_mode_text))
+			return -EINVAL;
+
+		count = sysfs_emit(buf, "%s\n", gamepad_mode_text[i]);
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	return count;
+}
+
+static ssize_t feature_status_options(struct device *dev,
+				      struct device_attribute *attr, char *buf,
+				      enum feature_status_index index)
+{
+	ssize_t count = 0;
+	unsigned int i;
+
+	switch (index) {
+	case FEATURE_IMU_ENABLE:
+	case FEATURE_IMU_BYPASS:
+	case FEATURE_LIGHT_ENABLE:
+	case FEATURE_TOUCHPAD_ENABLE:
+		for (i = 1; i < ARRAY_SIZE(enabled_status_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       enabled_status_text[i]);
+		}
+		break;
+	case FEATURE_AUTO_SLEEP_TIME:
+		return sysfs_emit(buf, "0-255\n");
+	case FEATURE_FPS_SWITCH_STATUS:
+		for (i = 1; i < ARRAY_SIZE(fps_switch_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       fps_switch_text[i]);
+		}
+		break;
+	case FEATURE_GAMEPAD_MODE:
+		for (i = 1; i < ARRAY_SIZE(gamepad_mode_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       gamepad_mode_text[i]);
+		}
+		break;
+	default:
+		return -EINVAL;
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
@@ -499,7 +816,22 @@ LEGO_DEVICE_ATTR_RO(version_hardware_mcu, "hardware_version", USB_MCU, version);
 struct go_cfg_attr version_gen_mcu = { HARDWARE_GENERATION };
 LEGO_DEVICE_ATTR_RO(version_gen_mcu, "hardware_generation", USB_MCU, version);
 
+struct go_cfg_attr fps_switch_status = { FEATURE_FPS_SWITCH_STATUS };
+LEGO_DEVICE_ATTR_RO(fps_switch_status, "fps_switch_status", UNSPECIFIED,
+		    feature_status);
+
+struct go_cfg_attr gamepad_mode = { FEATURE_GAMEPAD_MODE };
+LEGO_DEVICE_ATTR_RW(gamepad_mode, "mode", UNSPECIFIED, index, feature_status);
+static DEVICE_ATTR_RO_NAMED(gamepad_mode_index, "mode_index");
+
+struct go_cfg_attr reset_mcu = { FEATURE_RESET_GAMEPAD };
+LEGO_DEVICE_ATTR_WO(reset_mcu, "reset_mcu", USB_MCU, feature_status);
+
 static struct attribute *mcu_attrs[] = {
+	&dev_attr_fps_switch_status.attr,
+	&dev_attr_gamepad_mode.attr,
+	&dev_attr_gamepad_mode_index.attr,
+	&dev_attr_reset_mcu.attr,
 	&dev_attr_version_firmware_mcu.attr,
 	&dev_attr_version_gen_mcu.attr,
 	&dev_attr_version_hardware_mcu.attr,
@@ -528,7 +860,11 @@ LEGO_DEVICE_ATTR_RO(version_hardware_tx_dongle, "hardware_version", TX_DONGLE, v
 struct go_cfg_attr version_gen_tx_dongle = { HARDWARE_GENERATION };
 LEGO_DEVICE_ATTR_RO(version_gen_tx_dongle, "hardware_generation", TX_DONGLE, version);
 
+struct go_cfg_attr reset_tx_dongle = { FEATURE_RESET_GAMEPAD };
+LEGO_DEVICE_ATTR_RO(reset_tx_dongle, "reset", TX_DONGLE, feature_status);
+
 static struct attribute *tx_dongle_attrs[] = {
+	&dev_attr_reset_tx_dongle.attr,
 	&dev_attr_version_hardware_tx_dongle.attr,
 	&dev_attr_version_firmware_tx_dongle.attr,
 	&dev_attr_version_gen_tx_dongle.attr,
@@ -558,7 +894,33 @@ LEGO_DEVICE_ATTR_RO(version_hardware_left, "hardware_version", LEFT_CONTROLLER,
 struct go_cfg_attr version_gen_left = { HARDWARE_GENERATION };
 LEGO_DEVICE_ATTR_RO(version_gen_left, "hardware_generation", LEFT_CONTROLLER, version);
 
+struct go_cfg_attr auto_sleep_time_left = { FEATURE_AUTO_SLEEP_TIME };
+LEGO_DEVICE_ATTR_RW(auto_sleep_time_left, "auto_sleep_time", LEFT_CONTROLLER,
+		    range, feature_status);
+static DEVICE_ATTR_RO_NAMED(auto_sleep_time_left_range,
+			    "auto_sleep_time_range");
+
+struct go_cfg_attr imu_bypass_left = { FEATURE_IMU_BYPASS };
+LEGO_DEVICE_ATTR_RW(imu_bypass_left, "imu_bypass_enabled", LEFT_CONTROLLER,
+		    index, feature_status);
+static DEVICE_ATTR_RO_NAMED(imu_bypass_left_index, "imu_bypass_enabled_index");
+
+struct go_cfg_attr imu_enabled_left = { FEATURE_IMU_ENABLE };
+LEGO_DEVICE_ATTR_RW(imu_enabled_left, "imu_enabled", LEFT_CONTROLLER, index,
+		    feature_status);
+static DEVICE_ATTR_RO_NAMED(imu_enabled_left_index, "imu_enabled_index");
+
+struct go_cfg_attr reset_left = { FEATURE_RESET_GAMEPAD };
+LEGO_DEVICE_ATTR_WO(reset_left, "reset", LEFT_CONTROLLER, feature_status);
+
 static struct attribute *left_gamepad_attrs[] = {
+	&dev_attr_auto_sleep_time_left.attr,
+	&dev_attr_auto_sleep_time_left_range.attr,
+	&dev_attr_imu_bypass_left.attr,
+	&dev_attr_imu_bypass_left_index.attr,
+	&dev_attr_imu_enabled_left.attr,
+	&dev_attr_imu_enabled_left_index.attr,
+	&dev_attr_reset_left.attr,
 	&dev_attr_version_hardware_left.attr,
 	&dev_attr_version_firmware_left.attr,
 	&dev_attr_version_gen_left.attr,
@@ -588,7 +950,33 @@ LEGO_DEVICE_ATTR_RO(version_hardware_right, "hardware_version", RIGHT_CONTROLLER
 struct go_cfg_attr version_gen_right = { HARDWARE_GENERATION };
 LEGO_DEVICE_ATTR_RO(version_gen_right, "hardware_generation", RIGHT_CONTROLLER, version);
 
+struct go_cfg_attr auto_sleep_time_right = { FEATURE_AUTO_SLEEP_TIME };
+LEGO_DEVICE_ATTR_RW(auto_sleep_time_right, "auto_sleep_time", RIGHT_CONTROLLER,
+		    range, feature_status);
+static DEVICE_ATTR_RO_NAMED(auto_sleep_time_right_range,
+			    "auto_sleep_time_range");
+
+struct go_cfg_attr imu_bypass_right = { FEATURE_IMU_BYPASS };
+LEGO_DEVICE_ATTR_RW(imu_bypass_right, "imu_bypass_enabled", RIGHT_CONTROLLER,
+		    index, feature_status);
+static DEVICE_ATTR_RO_NAMED(imu_bypass_right_index, "imu_bypass_enabled_index");
+
+struct go_cfg_attr imu_enabled_right = { FEATURE_IMU_BYPASS };
+LEGO_DEVICE_ATTR_RW(imu_enabled_right, "imu_enabled", RIGHT_CONTROLLER, index,
+		    feature_status);
+static DEVICE_ATTR_RO_NAMED(imu_enabled_right_index, "imu_enabled_index");
+
+struct go_cfg_attr reset_right = { FEATURE_RESET_GAMEPAD };
+LEGO_DEVICE_ATTR_WO(reset_right, "reset", LEFT_CONTROLLER, feature_status);
+
 static struct attribute *right_gamepad_attrs[] = {
+	&dev_attr_auto_sleep_time_right.attr,
+	&dev_attr_auto_sleep_time_right_range.attr,
+	&dev_attr_imu_bypass_right.attr,
+	&dev_attr_imu_bypass_right_index.attr,
+	&dev_attr_imu_enabled_right.attr,
+	&dev_attr_imu_enabled_right_index.attr,
+	&dev_attr_reset_right.attr,
 	&dev_attr_version_hardware_right.attr,
 	&dev_attr_version_firmware_right.attr,
 	&dev_attr_version_gen_right.attr,
@@ -603,8 +991,14 @@ static const struct attribute_group right_gamepad_attr_group = {
 };
 
 /* Touchpad */
+struct go_cfg_attr touchpad_enabled = { FEATURE_TOUCHPAD_ENABLE };
+LEGO_DEVICE_ATTR_RW(touchpad_enabled, "enabled", UNSPECIFIED, index,
+		    feature_status);
+static DEVICE_ATTR_RO_NAMED(touchpad_enabled_index, "enabled_index");
+
 static struct attribute *touchpad_attrs[] = {
-	NULL,
+	&dev_attr_touchpad_enabled.attr,
+	&dev_attr_touchpad_enabled_index.attr,
 };
 
 static const struct attribute_group touchpad_attr_group = {
-- 
2.52.0

