Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046521ADA4
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219366; cv=none; b=a10c2wOrIsDrRn6n9sPmXCC7bBhss2dOjztafnDaoEq3FH1Pn8hGJIDksU0oXt4oBHydchRVLZgKwaGhad0vc89L9c3NrgzYMsvm9eEl4jQRwpXkkwfPq4hdPcZ4VoDz4l2xE7Tmd+p/OR8dsFvLCejeUCxCO0SN9wmhaUBRd0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219366; c=relaxed/simple;
	bh=QL9vc8e/YZBsymktlWZAmFCbHpEawvytpOUcj2Dei2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9BnFsbbKd5kbWhlQ5BkE80gQeQNlpugqmlIM8rrsg4iOLZfzv91ZXmMcsaSssctYLI/x6rSYXwjWttU94zzeU8hILiXHt9nZiosIAAMEInkD76hU2VlPSCElGjR8Vch7uh7fyRH36/mVlHgD57Z1uRbsKpllktNcSQ74U5KxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwFgWQiI; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwFgWQiI"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b73112ab62so2050799eec.1
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 17:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219362; x=1769824162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmrXoMrk2AbEQp2wwyDd0rnL7z2sF3WkcSu+YIR47ZQ=;
        b=OwFgWQiI775LhsLdEHAQvq+wnuKR4S3IWIiovGfTx8WiZKooj9e3KnMK5344XgqJB8
         kVx+GXFQc2GyLL6PyuF3FzBIIN4S9qkgINd5XXzeO7hv60je7dnF7yF9NNmuTS9Q63ig
         FzArzn8EFL3QO/zdunZamsPrMYtSN2wMlPzQ+z6ctXVtxyaZHGKj6xs82p4Gaq4ln9KA
         Uf9DZPx5H2U1ihldXYsq5zNl8/1jhiEfIDklna33to+nOsJy216mQSaZwKOWT5JbuJoR
         zndcptv+DVBfoBgdq/xsUkNvY+ijbetIxeO6YJV+WlintGIbbg0vXlfQjJgfhfaLKYP5
         kopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219362; x=1769824162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmrXoMrk2AbEQp2wwyDd0rnL7z2sF3WkcSu+YIR47ZQ=;
        b=akEiDrTTUv/rfwLNvm5vSvthlRswo1Z9FyerZTwFxr+zTCFQEWAuwsPB7pzwAzR9jR
         yWgxcF1gHTJX83/qsgCsF/2IWdtRs4AjRGET8I+/7jUH/71ECbZ4tDqgPtTsBh84q4ev
         e5ZEuEZ2FgRbkYGUi1SOjueKcdznfoXrvoErCw6sbez7sMF266dLn40yrfNC9qT3/U4A
         X/Y3eYEcvzs7qOZScbMn+wRcJwpOA/2TtP0q3k8tW8DK+ZJT7t1ICCXVd9rzl95i0TqZ
         DddQKFKnRxpW4gEoqAzOMR0rpPKhAmLVeqbme4sKrbJYqEDruWC7La5eCa+o7Pl+B4RE
         H5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeJXLHfo+eRE3dCxP+Eb/s6j4ue6Ud58xts2FMLC1cnK3ElRNcn2X8Cz5TVY2xlqnSwzSNZ0Tcn7hRUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0rOtm/GY6KxxU711oJJ3cYtys3pZknpxsw7MyDmtcvBS3o8AC
	qqSZ6bSoUifg/4fuX0p82BvTe8UOEkP4o/lMwkeWkDmNsfKxABvYjAIU
X-Gm-Gg: AZuq6aI5i00AWteXiDilYZ8o7DqqufFhZIB2ibvw1uR3eh8maAFVNJs4HQOvVd23rsC
	OKRe0Tb1/Gn2V47Zuo42lKA/lvAKphUlZPYy4OiRBmik3ws2pvOthGu2B2fCHYVsDe2IQEtwPmm
	T0GxRRKjTZFITdQH8w0+nSyt46COnlFm/kYaDVdWGXrnB/amtx9VvBOyhDKrgvzZ1YZf1LqQlMU
	FQypNi/IbdV8oiSoUj4//mETa5VDp0cs9L6rpBThiLvJ0jpcYF6xMYmN4OgAfXNY9IBCB3JiZEk
	0dqRViWvk0jDki2HDYWz9vhVFJqFkW1LOtEyS+FYT2+j5Gw2vGLBkvggtgECKle9a412OiHw/8v
	vXCRzUiPpHdbbSSaDE2CzIfRmm5Nx78/QeyexU5sRW6bTPcux9Netxz9WbdRWdwdAsxJgSDTzhQ
	fA8mMr+aQGnFaZPgPwVXQiSEeygVoxJM1GJRDqwe81st4G1gc3dzeNMNNds9N3vP3Q665vmzyzv
	g==
X-Received: by 2002:a05:7301:578f:b0:2ac:21b5:f43c with SMTP id 5a478bee46e88-2b739b748c0mr2725549eec.20.1769219361808;
        Fri, 23 Jan 2026 17:49:21 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5160014eec.29.2026.01.23.17.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 17:49:21 -0800 (PST)
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
Subject: [PATCH v3 12/16] HID: hid-lenovo-go-s: Add Feature Status Attributes
Date: Sat, 24 Jan 2026 01:49:03 +0000
Message-ID: <20260124014907.991265-13-derekjohn.clark@gmail.com>
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

Adds features status attributes for the gamepad, MCU, touchpad/mouse,
and IMU devices.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 524 +++++++++++++++++++++++++++++++++-
 1 file changed, 523 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 36cee6c3d4cc..076afdaa9628 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/printk.h>
 #include <linux/string.h>
@@ -35,7 +36,17 @@ struct hid_gos_cfg {
 	struct completion send_cmd_complete;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	u8 gp_auto_sleep_time;
+	u8 gp_dpad_mode;
+	u8 gp_mode;
+	u8 gp_poll_rate;
+	u8 imu_bypass_en;
+	u8 imu_sensor_en;
 	u8 mcu_id[12];
+	u8 mouse_step;
+	u8 os_mode;
+	u8 rgb_en;
+	u8 tp_en;
 } drvdata;
 
 struct gos_cfg_attr {
@@ -66,7 +77,73 @@ enum mcu_command_index {
 	GET_PL_TEST = 0xdf,
 };
 
-#define FEATURE_NONE 0x00
+enum feature_enabled_index {
+	FEATURE_DISABLED,
+	FEATURE_ENABLED,
+};
+
+static const char *const feature_enabled_text[] = {
+	[FEATURE_DISABLED] = "false",
+	[FEATURE_ENABLED] = "true",
+};
+
+enum feature_status_index {
+	FEATURE_NONE = 0x00,
+	FEATURE_GAMEPAD_MODE = 0x01,
+	FEATURE_AUTO_SLEEP_TIME = 0x04,
+	FEATURE_IMU_BYPASS,
+	FEATURE_RGB_ENABLE,
+	FEATURE_IMU_ENABLE,
+	FEATURE_TOUCHPAD_ENABLE,
+	FEATURE_OS_MODE = 0x0A,
+	FEATURE_POLL_RATE = 0x10,
+	FEATURE_DPAD_MODE,
+	FEATURE_MOUSE_WHEEL_STEP,
+};
+
+enum gamepad_mode_index {
+	XINPUT,
+	DINPUT,
+};
+
+static const char *const gamepad_mode_text[] = {
+	[XINPUT] = "xinput",
+	[DINPUT] = "dinput",
+};
+
+enum os_type_index {
+	WINDOWS,
+	LINUX,
+};
+
+static const char *const os_type_text[] = {
+	[WINDOWS] = "windows",
+	[LINUX] = "linux",
+};
+
+enum poll_rate_index {
+	HZ125,
+	HZ250,
+	HZ500,
+	HZ1000,
+};
+
+static const char *const poll_rate_text[] = {
+	[HZ125] = "125",
+	[HZ250] = "250",
+	[HZ500] = "500",
+	[HZ1000] = "1000",
+};
+
+enum dpad_mode_index {
+	DIR8,
+	DIR4,
+};
+
+static const char *const dpad_mode_text[] = {
+	[DIR8] = "8-way",
+	[DIR4] = "4-way",
+};
 
 static int hid_gos_version_event(u8 *data)
 {
@@ -84,6 +161,57 @@ static int hid_gos_mcu_id_event(struct command_report *cmd_rep)
 	return 0;
 }
 
+static int hid_gos_gamepad_cfg_event(struct command_report *cmd_rep)
+{
+	int ret = 0;
+
+	switch (cmd_rep->sub_cmd) {
+	case FEATURE_GAMEPAD_MODE:
+		drvdata.gp_mode = cmd_rep->data[0];
+		break;
+	case FEATURE_AUTO_SLEEP_TIME:
+		drvdata.gp_auto_sleep_time = cmd_rep->data[0];
+		break;
+	case FEATURE_IMU_BYPASS:
+		drvdata.imu_bypass_en = cmd_rep->data[0];
+		break;
+	case FEATURE_RGB_ENABLE:
+		drvdata.rgb_en = cmd_rep->data[0];
+		break;
+	case FEATURE_IMU_ENABLE:
+		drvdata.imu_sensor_en = cmd_rep->data[0];
+		break;
+	case FEATURE_TOUCHPAD_ENABLE:
+		drvdata.tp_en = cmd_rep->data[0];
+		break;
+	case FEATURE_OS_MODE:
+		drvdata.os_mode = cmd_rep->data[0];
+		break;
+	case FEATURE_POLL_RATE:
+		drvdata.gp_poll_rate = cmd_rep->data[0];
+		break;
+	case FEATURE_DPAD_MODE:
+		drvdata.gp_dpad_mode = cmd_rep->data[0];
+		break;
+	case FEATURE_MOUSE_WHEEL_STEP:
+		drvdata.mouse_step = cmd_rep->data[0];
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int hid_gos_set_event_return(struct command_report *cmd_rep)
+{
+	if (cmd_rep->data[0] != 0)
+		return -EIO;
+
+	return 0;
+}
+
 static u8 get_endpoint_address(struct hid_device *hdev)
 {
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -120,6 +248,12 @@ static int hid_gos_raw_event(struct hid_device *hdev, struct hid_report *report,
 	case GET_MCU_ID:
 		ret = hid_gos_mcu_id_event(cmd_rep);
 		break;
+	case GET_GAMEPAD_CFG:
+		ret = hid_gos_gamepad_cfg_event(cmd_rep);
+		break;
+	case SET_GAMEPAD_CFG:
+		ret = hid_gos_set_event_return(cmd_rep);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -177,17 +311,333 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 	return ret;
 }
 
+static ssize_t gamepad_property_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count,
+				      enum feature_status_index index)
+{
+	size_t size = 1;
+	u8 val = 0;
+	int ret;
+
+	switch (index) {
+	case FEATURE_GAMEPAD_MODE:
+		ret = sysfs_match_string(gamepad_mode_text, buf);
+		if (ret < 0)
+			return ret;
+		val = ret;
+		break;
+	case FEATURE_AUTO_SLEEP_TIME:
+		ret = kstrtou8(buf, 10, &val);
+		if (ret)
+			return ret;
+
+		if (val < 0 || val > 255)
+			return -EINVAL;
+		break;
+	case FEATURE_IMU_ENABLE:
+		ret = sysfs_match_string(feature_enabled_text, buf);
+		if (ret < 0)
+			return ret;
+		val = ret;
+		break;
+	case FEATURE_IMU_BYPASS:
+		ret = sysfs_match_string(feature_enabled_text, buf);
+		if (ret < 0)
+			return ret;
+		val = ret;
+		break;
+	case FEATURE_RGB_ENABLE:
+		ret = sysfs_match_string(feature_enabled_text, buf);
+		if (ret < 0)
+			return ret;
+		val = ret;
+		break;
+	case FEATURE_TOUCHPAD_ENABLE:
+		ret = sysfs_match_string(feature_enabled_text, buf);
+		if (ret < 0)
+			return ret;
+		val = ret;
+		break;
+	case FEATURE_OS_MODE:
+		ret = sysfs_match_string(os_type_text, buf);
+		if (ret < 0)
+			return ret;
+		val = ret;
+		drvdata.os_mode = val;
+		break;
+	case FEATURE_POLL_RATE:
+		ret = sysfs_match_string(poll_rate_text, buf);
+		if (ret < 0)
+			return ret;
+		val = ret;
+		break;
+	case FEATURE_DPAD_MODE:
+		ret = sysfs_match_string(dpad_mode_text, buf);
+		if (ret < 0)
+			return ret;
+		val = ret;
+		break;
+	case FEATURE_MOUSE_WHEEL_STEP:
+		ret = kstrtou8(buf, 10, &val);
+		if (ret)
+			return ret;
+		if (val < 1 || val > 127)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!val)
+		size = 0;
+
+	ret = mcu_property_out(drvdata.hdev, SET_GAMEPAD_CFG, index, &val,
+			       size);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t gamepad_property_show(struct device *dev,
+				     struct device_attribute *attr, char *buf,
+				     enum feature_status_index index)
+{
+	size_t count = 0;
+	u8 i;
+
+	count = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, index, 0, 0);
+	if (count < 0)
+		return count;
+
+	switch (index) {
+	case FEATURE_GAMEPAD_MODE:
+		i = drvdata.gp_mode;
+		if (i >= ARRAY_SIZE(gamepad_mode_text))
+			return -EINVAL;
+		count = sysfs_emit(buf, "%s\n", gamepad_mode_text[i]);
+		break;
+	case FEATURE_AUTO_SLEEP_TIME:
+		count = sysfs_emit(buf, "%u\n", drvdata.gp_auto_sleep_time);
+		break;
+	case FEATURE_IMU_ENABLE:
+		i = drvdata.imu_sensor_en;
+		if (i >= ARRAY_SIZE(feature_enabled_text))
+			return -EINVAL;
+		count = sysfs_emit(buf, "%s\n", feature_enabled_text[i]);
+		break;
+	case FEATURE_IMU_BYPASS:
+		i = drvdata.imu_bypass_en;
+		if (i >= ARRAY_SIZE(feature_enabled_text))
+			return -EINVAL;
+		count = sysfs_emit(buf, "%s\n", feature_enabled_text[i]);
+		break;
+	case FEATURE_RGB_ENABLE:
+		i = drvdata.rgb_en;
+		if (i >= ARRAY_SIZE(feature_enabled_text))
+			return -EINVAL;
+		count = sysfs_emit(buf, "%s\n", feature_enabled_text[i]);
+		break;
+	case FEATURE_TOUCHPAD_ENABLE:
+		i = drvdata.tp_en;
+		if (i >= ARRAY_SIZE(feature_enabled_text))
+			return -EINVAL;
+		count = sysfs_emit(buf, "%s\n", feature_enabled_text[i]);
+		break;
+	case FEATURE_OS_MODE:
+		i = drvdata.os_mode;
+		if (i >= ARRAY_SIZE(os_type_text))
+			return -EINVAL;
+		count = sysfs_emit(buf, "%s\n", os_type_text[i]);
+		break;
+	case FEATURE_POLL_RATE:
+		i = drvdata.gp_poll_rate;
+		if (i >= ARRAY_SIZE(poll_rate_text))
+			return -EINVAL;
+		count = sysfs_emit(buf, "%s\n", poll_rate_text[i]);
+		break;
+	case FEATURE_DPAD_MODE:
+		i = drvdata.gp_dpad_mode;
+		if (i >= ARRAY_SIZE(dpad_mode_text))
+			return -EINVAL;
+		count = sysfs_emit(buf, "%s\n", dpad_mode_text[i]);
+		break;
+	case FEATURE_MOUSE_WHEEL_STEP:
+		i = drvdata.mouse_step;
+		if (i < 1 || i > 127)
+			return -EINVAL;
+		count = sysfs_emit(buf, "%u\n", i);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t gamepad_property_options(struct device *dev,
+					struct device_attribute *attr,
+					char *buf,
+					enum feature_status_index index)
+{
+	size_t count = 0;
+	unsigned int i;
+
+	switch (index) {
+	case FEATURE_GAMEPAD_MODE:
+		for (i = 0; i < ARRAY_SIZE(gamepad_mode_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       gamepad_mode_text[i]);
+		}
+		break;
+	case FEATURE_AUTO_SLEEP_TIME:
+		return sysfs_emit(buf, "0-255\n");
+	case FEATURE_IMU_ENABLE:
+		for (i = 0; i < ARRAY_SIZE(feature_enabled_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       feature_enabled_text[i]);
+		}
+		break;
+	case FEATURE_IMU_BYPASS:
+	case FEATURE_RGB_ENABLE:
+	case FEATURE_TOUCHPAD_ENABLE:
+		for (i = 0; i < ARRAY_SIZE(feature_enabled_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       feature_enabled_text[i]);
+		}
+		break;
+	case FEATURE_OS_MODE:
+		for (i = 0; i < ARRAY_SIZE(os_type_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       os_type_text[i]);
+		}
+		break;
+	case FEATURE_POLL_RATE:
+		for (i = 0; i < ARRAY_SIZE(poll_rate_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       poll_rate_text[i]);
+		}
+		break;
+	case FEATURE_DPAD_MODE:
+		for (i = 0; i < ARRAY_SIZE(dpad_mode_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       dpad_mode_text[i]);
+		}
+		break;
+	case FEATURE_MOUSE_WHEEL_STEP:
+		return sysfs_emit(buf, "1-127\n");
+	default:
+		return count;
+	}
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+
 static ssize_t mcu_id_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	return sysfs_emit(buf, "%*phN\n", 12, &drvdata.mcu_id);
 }
 
+#define LEGOS_DEVICE_ATTR_RW(_name, _attrname, _rtype, _group)                 \
+	static ssize_t _name##_store(struct device *dev,                       \
+				     struct device_attribute *attr,            \
+				     const char *buf, size_t count)            \
+	{                                                                      \
+		return _group##_property_store(dev, attr, buf, count,          \
+					       _name.index);                   \
+	}                                                                      \
+	static ssize_t _name##_show(struct device *dev,                        \
+				    struct device_attribute *attr, char *buf)  \
+	{                                                                      \
+		return _group##_property_show(dev, attr, buf, _name.index);    \
+	}                                                                      \
+	static ssize_t _name##_##_rtype##_show(                                \
+		struct device *dev, struct device_attribute *attr, char *buf)  \
+	{                                                                      \
+		return _group##_property_options(dev, attr, buf, _name.index); \
+	}                                                                      \
+	static DEVICE_ATTR_RW_NAMED(_name, _attrname)
+
+#define LEGOS_DEVICE_ATTR_RO(_name, _attrname, _group)                        \
+	static ssize_t _name##_show(struct device *dev,                       \
+				    struct device_attribute *attr, char *buf) \
+	{                                                                     \
+		return _group##_property_show(dev, attr, buf, _name.index);   \
+	}                                                                     \
+	static DEVICE_ATTR_RO_NAMED(_name, _attrname)
+
+/* Gamepad */
+struct gos_cfg_attr auto_sleep_time = { FEATURE_AUTO_SLEEP_TIME };
+LEGOS_DEVICE_ATTR_RW(auto_sleep_time, "auto_sleep_time", range, gamepad);
+static DEVICE_ATTR_RO(auto_sleep_time_range);
+
+struct gos_cfg_attr dpad_mode = { FEATURE_DPAD_MODE };
+LEGOS_DEVICE_ATTR_RW(dpad_mode, "dpad_mode", index, gamepad);
+static DEVICE_ATTR_RO(dpad_mode_index);
+
+struct gos_cfg_attr gamepad_mode = { FEATURE_GAMEPAD_MODE };
+LEGOS_DEVICE_ATTR_RW(gamepad_mode, "mode", index, gamepad);
+static DEVICE_ATTR_RO_NAMED(gamepad_mode_index, "mode_index");
+
+struct gos_cfg_attr gamepad_poll_rate = { FEATURE_POLL_RATE };
+LEGOS_DEVICE_ATTR_RW(gamepad_poll_rate, "poll_rate", index, gamepad);
+static DEVICE_ATTR_RO_NAMED(gamepad_poll_rate_index, "poll_rate_index");
+
+static struct attribute *legos_gamepad_attrs[] = {
+	&dev_attr_auto_sleep_time.attr,
+	&dev_attr_auto_sleep_time_range.attr,
+	&dev_attr_dpad_mode.attr,
+	&dev_attr_dpad_mode_index.attr,
+	&dev_attr_gamepad_mode.attr,
+	&dev_attr_gamepad_mode_index.attr,
+	&dev_attr_gamepad_poll_rate.attr,
+	&dev_attr_gamepad_poll_rate_index.attr,
+	NULL,
+};
+
+static const struct attribute_group gamepad_attr_group = {
+	.name = "gamepad",
+	.attrs = legos_gamepad_attrs,
+};
+
+/* IMU */
+struct gos_cfg_attr imu_bypass_enabled = { FEATURE_IMU_BYPASS };
+LEGOS_DEVICE_ATTR_RW(imu_bypass_enabled, "bypass_enabled", index, gamepad);
+static DEVICE_ATTR_RO_NAMED(imu_bypass_enabled_index, "bypass_enabled_index");
+
+struct gos_cfg_attr imu_sensor_enabled = { FEATURE_IMU_ENABLE };
+LEGOS_DEVICE_ATTR_RW(imu_sensor_enabled, "sensor_enabled", index, gamepad);
+static DEVICE_ATTR_RO_NAMED(imu_sensor_enabled_index, "sensor_enabled_index");
+
+static struct attribute *legos_imu_attrs[] = {
+	&dev_attr_imu_bypass_enabled.attr,
+	&dev_attr_imu_bypass_enabled_index.attr,
+	&dev_attr_imu_sensor_enabled.attr,
+	&dev_attr_imu_sensor_enabled_index.attr,
+	NULL,
+};
+
+static const struct attribute_group imu_attr_group = {
+	.name = "imu",
+	.attrs = legos_imu_attrs,
+};
+
 /* MCU */
 static DEVICE_ATTR_RO(mcu_id);
 
+struct gos_cfg_attr os_mode = { FEATURE_OS_MODE };
+LEGOS_DEVICE_ATTR_RW(os_mode, "os_mode", index, gamepad);
+static DEVICE_ATTR_RO(os_mode_index);
+
 static struct attribute *legos_mcu_attrs[] = {
 	&dev_attr_mcu_id.attr,
+	&dev_attr_os_mode.attr,
+	&dev_attr_os_mode_index.attr,
 	NULL,
 };
 
@@ -195,8 +645,44 @@ static const struct attribute_group mcu_attr_group = {
 	.attrs = legos_mcu_attrs,
 };
 
+/* Mouse */
+struct gos_cfg_attr mouse_wheel_step = { FEATURE_MOUSE_WHEEL_STEP };
+LEGOS_DEVICE_ATTR_RW(mouse_wheel_step, "step", range, gamepad);
+static DEVICE_ATTR_RO_NAMED(mouse_wheel_step_range, "step_range");
+
+static struct attribute *legos_mouse_attrs[] = {
+	&dev_attr_mouse_wheel_step.attr,
+	&dev_attr_mouse_wheel_step_range.attr,
+	NULL,
+};
+
+static const struct attribute_group mouse_attr_group = {
+	.name = "mouse",
+	.attrs = legos_mouse_attrs,
+};
+
+/* Touchpad */
+struct gos_cfg_attr touchpad_enabled = { FEATURE_TOUCHPAD_ENABLE };
+LEGOS_DEVICE_ATTR_RW(touchpad_enabled, "enabled", index, gamepad);
+static DEVICE_ATTR_RO_NAMED(touchpad_enabled_index, "enabled_index");
+
+static struct attribute *legos_touchpad_attrs[] = {
+	&dev_attr_touchpad_enabled.attr,
+	&dev_attr_touchpad_enabled_index.attr,
+	NULL,
+};
+
+static const struct attribute_group touchpad_attr_group = {
+	.name = "touchpad",
+	.attrs = legos_touchpad_attrs,
+};
+
 static const struct attribute_group *top_level_attr_groups[] = {
+	&gamepad_attr_group,
+	&imu_attr_group,
 	&mcu_attr_group,
+	&mouse_attr_group,
+	&touchpad_attr_group,
 	NULL,
 };
 
@@ -268,6 +754,27 @@ static void hid_gos_cfg_remove(struct hid_device *hdev)
 	hid_set_drvdata(hdev, NULL);
 }
 
+static int hid_gos_cfg_reset_resume(struct hid_device *hdev)
+{
+	u8 os_mode = drvdata.os_mode;
+	int ret;
+
+	ret = mcu_property_out(drvdata.hdev, SET_GAMEPAD_CFG, FEATURE_OS_MODE,
+			       &os_mode, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, FEATURE_OS_MODE, 0,
+			       0);
+	if (ret < 0)
+		return ret;
+
+	if (drvdata.os_mode != os_mode)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int hid_gos_probe(struct hid_device *hdev,
 			 const struct hid_device_id *id)
 {
@@ -326,6 +833,20 @@ static void hid_gos_remove(struct hid_device *hdev)
 	}
 }
 
+static int hid_gos_reset_resume(struct hid_device *hdev)
+{
+	int ep = get_endpoint_address(hdev);
+
+	switch (ep) {
+	case GO_S_CFG_INTF_IN:
+		return hid_gos_cfg_reset_resume(hdev);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct hid_device_id hid_gos_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QHE,
 			 USB_DEVICE_ID_LENOVO_LEGION_GO_S_XINPUT) },
@@ -340,6 +861,7 @@ static struct hid_driver hid_lenovo_go_s = {
 	.id_table = hid_gos_devices,
 	.probe = hid_gos_probe,
 	.remove = hid_gos_remove,
+	.reset_resume = hid_gos_reset_resume,
 	.raw_event = hid_gos_raw_event,
 };
 module_hid_driver(hid_lenovo_go_s);
-- 
2.52.0

