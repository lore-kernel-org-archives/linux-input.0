Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEE27816C
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896755; cv=none; b=sepyQIlOYm0m61vOC64s6fawVEnsOnyUammwQgyhmRn47AuWN/0IJ+HpsuovZio9gQXsbvkLcFmEI+XnyCMY5YFIBLD8c+eqrwmLg6VMiBnf8+G2WVhXImXzVJvkwIhb1REX0Ws9VoDNY5ZiPy2tf9oFoq0gBn1dQzVOUAS7Zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896755; c=relaxed/simple;
	bh=kKo57/qpn9G9kAv0pqAfm+T5erqaX9vMRm38d+AbtfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWISuEm+UhISNy87jMf+NFk5u9M/dwKYstQfBxiJHU7Xk3VWDX7HqAq6rDZ09qfYecMrBD9CDa5852Ksq6K/toYYvwfVNwcnRsYV73yvk1XrVZIQfTGNaEfK+Z6xF8HONDHiaYODay98k2Y8Anu1cBvRw27le7CYiRjHMIhnOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqZHASkf; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqZHASkf"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba94dbf739so5433114eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771896751; x=1772501551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6d5nja03SDJDQnEPmaYXPLNWDtnRUu0bXtP4VIKDMc=;
        b=BqZHASkfJbMxrE5RVKOzMavzpFI0emgYvVwn3VWxDd3IckWQycyMEulaZBtYB54axg
         fzEYGhOuZzF8JgnXa4GEVz8qhjfJr/nmKtZ/MDq8f60nR4fDTLlHAZ4Fp4O9gmGPggzI
         KDmoGvK6dedkWt+19Na+8RlwHwcvFnpAyf96T/E8a/Agz61tm9N4BH2PvWCpOuvVY7Cs
         Wu3V4YiqBnfX9S0M+Nn9s08atxfQDcXZa/F+MNUMbqxG0PZuYHYqOwv4N4DoC+7WGMh+
         jXTLyf47cyzh4DwfCvtOWmBErJ7TYMPqvJjdAUdx6fea3TAOm3O4AghxL0n/yAacSRHs
         B8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771896751; x=1772501551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6d5nja03SDJDQnEPmaYXPLNWDtnRUu0bXtP4VIKDMc=;
        b=ih8GIo3mLSr8k/PesZ9r976lZBGXWSity91uNWoBakglzWj8xjBUPmDqG8x76kN9q7
         M1epQl0VzWjT7TKVqDPFYC1maem4Y6uC0jtaoRwwXJ6ZVzcEPMmXtECgdoRGf9W200LM
         CBIDPIPyAlz5WKMyC4qG8dggWsVd1ZNB416vTuTVRphwBVi764jZH98TAElU8syrnWg/
         NB+ffysGvkzK73jOFZKD5X+mI6ffFwGH7z6QYymX+aOMCwouygPkELXZGfA/rj0+CwbW
         HJADSppUtfQ7mEoAQojQa+edR4HRXRlacwBdJrA3BPIE9t2YpvtVq80AfmBzo3HhhkZz
         498g==
X-Forwarded-Encrypted: i=1; AJvYcCW6PdvnZUNthFYQq0hfh2O848dkA9adp9zt8s+swA//lgMKawgC3pMPd6tVQ9boHv4SE/g7koBYfPWxtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2U0R4O7jsanHUx9mptYF3iCsYVaIywZhwe3ltIUhSMvkrjXCS
	BX3U/az4GRTgASOM9Pjbq8V3iOlxokI9LSAA7Ahl87kWBWYL4mFnhKKD
X-Gm-Gg: ATEYQzwpJz7aJBeJu+XZsvsI/+vzGt5lPY5lM7svv+eYvjPVPs+E+EdV33k5tH7O1AM
	ivXHlH/YUWBbfivWpKiRc5BUx/+usQljCCyJTn2IVhUsY5jFjCcKM0HbNar+gF1FcxYbtRGlkI8
	uu4gG22nstUtFLIL+aj8nm/pgwkIMwdUES5RRGZA/YBx63BfX6DJz3QUulRtHdwsbv+ejHgFpwk
	RvABk0AQ8WTBUxkg26m9vixqnwoV5NAFJqDYz73nhiTq/RrKlfG0JL0hQ1sioJLZxFq0xXlEaJ/
	GcPA//8oNYOiTmVFN+UOg8rzy21Mbi3WaZLnovrNauhP/a5GMNj/mOR1o6kEhrLxRkMImma1C05
	u3NnRgXBZPuV6FRaN5EntLpEZNchLTU1kafgWAPeiOve5XDNMxN3jjm89+TWlYpA0zZGtE94O2B
	faAycBiKebsDSyknFHleo5Zx5Q2tGrQK+NQOj2a2FLzlBpoABaIMJF9F8wAlSKVJ8QIndkXhx17
	z+Cm0g0qnOfww==
X-Received: by 2002:a05:7300:6144:b0:2ba:8961:e1a1 with SMTP id 5a478bee46e88-2bd7bd0470amr5225762eec.22.1771896751387;
        Mon, 23 Feb 2026 17:32:31 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa027fsm6485015eec.9.2026.02.23.17.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:32:31 -0800 (PST)
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
Subject: [PATCH v5 12/16] HID: hid-lenovo-go-s: Add Feature Status Attributes
Date: Tue, 24 Feb 2026 01:32:13 +0000
Message-ID: <20260224013217.1363996-13-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
References: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds features status attributes for the gamepad, MCU, touchpad/mouse,
and IMU devices.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v4:
  - Cleaner formatting on debug message.
---
 drivers/hid/hid-lenovo-go-s.c | 487 +++++++++++++++++++++++++++++++++-
 1 file changed, 486 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index cea015330c2b6..423b64cd02902 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -15,6 +15,7 @@
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
@@ -174,17 +308,332 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 	return 0;
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
 
@@ -192,8 +641,44 @@ static const struct attribute_group mcu_attr_group = {
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
 
-- 
2.52.0

