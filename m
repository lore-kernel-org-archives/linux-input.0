Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36188410D36
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127796; cv=none; b=FTLFgWxgvmzdAl2mVZ97iiUweFHLvYuyUrm3FvStZR4MRKBwy2CoR+SG0BJV2WIXqGifl314COQ3Tw0OxPMSzdHeGczzRL5DpBoCnqMUsisVhEzU3er2ER1vTSzVIy0eksZ2moXTs9IH5m+gflaQItJbi98VAckymS04ohWmv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127796; c=relaxed/simple;
	bh=31RASrZgzJyk2MSTHxv8uLXms4mbg9GhAuwpXPNdv9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ik2WL/O4Iep3fbtHLpsd41AYYj+nu9benoE+1pfELlFazOkBTTmf47UpqSyoeUPf9HHf6fifBfV8AB7V32lr4pmPDfhHO3n+1dRl+74nzwxi+qdYJN7bf2nnXSypf7nAqq71DhXag40EoY/8v0W1bCJxHhb9cXk3+eS+4gtlLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5UiUChw; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5UiUChw"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2be26842fd5so4130618eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127793; x=1773732593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HYa6ycaKvi1sWbnN46hq7wdNbqGIWJQ59Ad+I4hx/o=;
        b=H5UiUChwsjZ5Qgp0jY0oZlSxuyX9tmwT+ADAeHIeYC7664FCBpqBFC4jV1U/RgEN76
         EMk6N0hGZ3/kKC0EWkJdulaYAmq2HEYubMyqvOreG0PrrrL55AgnzOFWwf4vcQI6HdBQ
         /6l1OazW8v6CnymV0141aVXWBg+m9nStjzBPtvBwk6IqnGIUjHJ4FE+/ZBMYfBLHx62o
         gst6DYSPHd5FAIxb3tEjVeeuFS0mdE+CQMxNNUkArDG0AA7NXxEheX6vUpB32sV/rxbt
         mzvf7Hc8xZl7vmdQ9UAFLHvjXM6q8uGHkHlWdch1IDe6EHl++CQe5kdc9eP+IlGJdr9g
         xuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127793; x=1773732593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HYa6ycaKvi1sWbnN46hq7wdNbqGIWJQ59Ad+I4hx/o=;
        b=MJn7kcctv6INnJnPogW7NNJ6Xf3TnvWpmK7cwQIRb0Xr4GwKQVHrLkL4uCfPU1Q02+
         cqTUUp/njkoPtaNjk1gBSK7jwQFhTNvND1YyTzDap91KMqDZ4eNC5WFcTgIemgws3XEk
         D4SrgeB1TVW6MkCVTfKHnU5XDKYTB8DNxs3l/iQF//hN8qqbuKdHX43lRMki2VG9rhcB
         zxZeqYJbZIRNpXzo9wJFAUjbeovSRfHChzJjOxnzAdv9nLaQ6kScU/uKB+Z5F1EszVPz
         9LvVQeudp+4TR5RZkgKBX7zzDur865p6N8Cs1zWzJ+wLp+mmW4UoDdi300jiVXxqAMfl
         4bkA==
X-Forwarded-Encrypted: i=1; AJvYcCUTu0xydC9v784lR1JsJiSf6yRBxv4G/l7ZgjiGj1Z9kygzz/Su615SsBaDAjAdtfRDMK4UGEUEt13G1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl06SZ+/BFc9r5WjJNoi8e0GE6p+fM+qJrMehsffY3RryFVnWD
	V7hM1xieu35W73Ww6eEFcpOTWgmRA2WCD3wy8JgGgpGQ8Z2Gbh6AMIJaB/obgw==
X-Gm-Gg: ATEYQzwp2k0Q3eQhrrnoj0m/uC5ubO6bp2DhPMXKHjA5fU1siMJ9PRLEY9usBoTSq1s
	/j7BpE8d1h+B314ZT0BPqCxmCKkHfMlSFbw0c3gez+vcKhjb2m9YW1X6NFA5K0AVr1a1y9CKYDU
	PTcfh/Z04/5DG9pki1mF5FKgOG2byeCj9wqgP2G9sBduN9IcerHwipaMAoI1a2x3gjPW1u34KaX
	iQ3QN2TjhfHYshW/75q5yYA8k8e/mgxXyc3zWkj0wVY8CmFm+oDRURSRXaKFyO6CegLHvAgP1hc
	lAYw8OU4n1HAiroiilhU76/W3uPON//YGE9AlSpVfz7RtQQdwh5wyraHKtYfT1lx4sZD86rpbWl
	xKVCLZS8jChpR2KaB2wNbw0gAhWR51QICTgJoiY+POtV/JOoeSGiJyhMJSOFI/OMcm14uMEWFfE
	Tpmlv8WdemRYoXHBM/chEVLdXuiX62rXCJpEo+dslRHqB3m0rSLXS5YdMf7fbeA/ppmidahrBsh
	46K
X-Received: by 2002:a05:7300:bc97:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2be7a123402mr897945eec.14.1773127793162;
        Tue, 10 Mar 2026 00:29:53 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:52 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v6 12/19] HID: hid-lenovo-go-s: Add Feature Status Attributes
Date: Tue, 10 Mar 2026 07:29:30 +0000
Message-ID: <20260310072937.3295875-13-derekjohn.clark@gmail.com>
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

Adds features status attributes for the gamepad, MCU, touchpad/mouse,
and IMU devices.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Co-developed-by: Ethan Tidmore <ethantidmore06@gmail.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v6:
  - Include positive promotion bug fix from Ethan Tidmore.
  - Include impossible condition bug fix from Ethan Tidmore.
  - Make local attributes static.
  - Use NULL instead of 0 in mcu_propery_out when there is no data.
v4:
  - Cleaner formatting on debug message.
---
 drivers/hid/hid-lenovo-go-s.c | 484 +++++++++++++++++++++++++++++++++-
 1 file changed, 483 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 8ee75f724b5b..97c572cfe66c 100644
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
@@ -35,7 +36,17 @@ static struct hid_gos_cfg {
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
 static int get_endpoint_address(struct hid_device *hdev)
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
@@ -174,17 +308,329 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
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
+	ssize_t count = 0;
+	u8 i;
+
+	count = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, index, NULL, 0);
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
+static struct gos_cfg_attr auto_sleep_time = { FEATURE_AUTO_SLEEP_TIME };
+LEGOS_DEVICE_ATTR_RW(auto_sleep_time, "auto_sleep_time", range, gamepad);
+static DEVICE_ATTR_RO(auto_sleep_time_range);
+
+static struct gos_cfg_attr dpad_mode = { FEATURE_DPAD_MODE };
+LEGOS_DEVICE_ATTR_RW(dpad_mode, "dpad_mode", index, gamepad);
+static DEVICE_ATTR_RO(dpad_mode_index);
+
+static struct gos_cfg_attr gamepad_mode = { FEATURE_GAMEPAD_MODE };
+LEGOS_DEVICE_ATTR_RW(gamepad_mode, "mode", index, gamepad);
+static DEVICE_ATTR_RO_NAMED(gamepad_mode_index, "mode_index");
+
+static struct gos_cfg_attr gamepad_poll_rate = { FEATURE_POLL_RATE };
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
+static struct gos_cfg_attr imu_bypass_enabled = { FEATURE_IMU_BYPASS };
+LEGOS_DEVICE_ATTR_RW(imu_bypass_enabled, "bypass_enabled", index, gamepad);
+static DEVICE_ATTR_RO_NAMED(imu_bypass_enabled_index, "bypass_enabled_index");
+
+static struct gos_cfg_attr imu_sensor_enabled = { FEATURE_IMU_ENABLE };
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
 
+static struct gos_cfg_attr os_mode = { FEATURE_OS_MODE };
+LEGOS_DEVICE_ATTR_RW(os_mode, "os_mode", index, gamepad);
+static DEVICE_ATTR_RO(os_mode_index);
+
 static struct attribute *legos_mcu_attrs[] = {
 	&dev_attr_mcu_id.attr,
+	&dev_attr_os_mode.attr,
+	&dev_attr_os_mode_index.attr,
 	NULL,
 };
 
@@ -192,8 +638,44 @@ static const struct attribute_group mcu_attr_group = {
 	.attrs = legos_mcu_attrs,
 };
 
+/* Mouse */
+static struct gos_cfg_attr mouse_wheel_step = { FEATURE_MOUSE_WHEEL_STEP };
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
+static struct gos_cfg_attr touchpad_enabled = { FEATURE_TOUCHPAD_ENABLE };
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
2.53.0

