Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F821B191
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219360; cv=none; b=Mylck9P4J20bx8iKWOXnzCE2Ys1zas5VRj7zurhU+bbGRozdagYSf8Hl6ydt7t+SdznVeIwi9vR1+Ol/OM1QWaBf6feIOBB88hJd5x9XeeXZkRUkpEgEUz3cwC3JWegXnx6NeTa+4Rmy2XoTAbafeyZZVvVCPdLEDK56MOJFJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219360; c=relaxed/simple;
	bh=54h2ZD6ERLfG5uQrF4ZQMbWKIWD4Jp6Lb/w83rKlAAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbIF/Rjj3WZCRqiiQbit65sjFzX4UzvJXamIQQgm17x3e8chGf0c287hBkG5xYXBfzarYmJPJcyeDPbHehzPBOWCV1+VcLyeThNCJcxW9cXHPRzrPrqXRCh08wpmb9d+TWy8yfLJayfEe2Xq8+zxM+LyVyykM6Az9LzlP1DW5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjrqeHwx; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjrqeHwx"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b7070acfdcso3094339eec.0
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 17:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219357; x=1769824157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sPu0k/HdGfAXuimtmNIyvKYNOTKDWTwAhrJ0MS9oKA=;
        b=MjrqeHwxI+urleJ7QzGrtcHCqshDqMIPdvXq3LZPBO1mMYFEdPUH+1vuCM5ykxtUyG
         E4C8az4Jc8W946Iwm3oGRIdzsLSYIlvWgBBq525Fj9s6n15JDoUVkQpT0nIiZiMlAyhw
         TCVi/5b0SaFmtyyPzI3eQP4+oeEjet8L0v2y5mgOXEASjH9Ud45WBZFviNBjdU/lZj3t
         F85nTJ74rSfzylKL8THInECMYVEvbH4QT5cjqiOOq1SIV2zyV0cd6y5UNiL6VPYTINHz
         w08qYBIjoWdHxAcKiK1a1NRIxlJnlPcvCTiLqhjB07Sm7AK+zGCHGxC5ZW+/5euJLrwM
         AFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219357; x=1769824157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8sPu0k/HdGfAXuimtmNIyvKYNOTKDWTwAhrJ0MS9oKA=;
        b=q6uu07QXaH58gA5fkTL9Ytx0GV6pj4WdS04BijgYbclKHrgaVGU6Bw1LTZviTpMHcx
         ZPnZDbZtGpTucEhOUj//dLFTXYp2xrnbQeUUnJ/ybEotwK6b+IhCr7PnqxsJdUDnMVAw
         CwIHaEkT+pkz/hZXXR7ZgQyHscQsR8ixXgOqBGl8eiPZQIksxo8YuSRXdJArPcGPA0hC
         se4s70KVpNYjhGql/tOkGoqpY5qDx6/QDEm4xyEXJf9BlyMvAaLZr+fatyTVUgkcHHsb
         t5AdOtLf+VZfXIVYF7oRjfHuS/LAe5IYnOs7Ai+R/i0PT0yVE8T4V1jCEZHjrGlEzW0y
         Y9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVdix/UhwmWLPQ+NppetT90r+ARLu4AWrw/UJN43zEKR05fPItiffeYZyE2U+O+CVLWfTkdtpA0jnq8MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1c/AKMMl4Mr1Tim+Jnc3Da2sVJrO2R49uF2w85RFRZI36z/h
	OKUMztpIvlrosyFQ6w/wRpk7K3BlBj9rU9vP4/Ey977whygyUbx7Xf+x
X-Gm-Gg: AZuq6aJ9w+zceatp8C1GmW24l2pxJB3FETX3xg5E9Y7nkpCUuOlxg7MWVkMD4W/u4bx
	Be7K9jSoAbEmof4WstaZ54r+virCzXBYPC/qF9omEG1pXNWhob+5UF6fsRj9AgYkDUAYoieYzNl
	zU6QVNgrQ4uDkRY8ZqWR8wQZ1C840ue/cQJ6X5YsOlN50+Z0YwhmOT6t9tJVyQWY7NMdNlREhQh
	VNU3ELmqIIsMeUOtRszjxMAUK+yUriz05r/Io1yRZkg6TLqXQg42+yEd/iNkdn6jb3HDzRvxSp1
	Cv7YzFgcGTf6uRFA6eFWw0LmzggJegeciqf1emJMMHoVpzHPHX/nDXtZsyr9C7BicUZBu2gKqa0
	Fcrc+ZchFBkxHg8E5XwyQpn4p04HlnNh+cb9o5dfVk8/Y2E/ILkeNf1ZaJske4ulX1uDZVhvYh4
	CemELgLt6uG0GlM8yeMtKdhi0ODduOAinXmNDmm79mqokkdi9negeMxcYCk3yPdPo=
X-Received: by 2002:a05:7301:9f18:b0:2b7:3678:2d17 with SMTP id 5a478bee46e88-2b739c21b5fmr2429576eec.41.1769219357028;
        Fri, 23 Jan 2026 17:49:17 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5160014eec.29.2026.01.23.17.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 17:49:16 -0800 (PST)
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
Subject: [PATCH v3 06/16] HID: hid-lenovo-go: Add RGB LED control interface
Date: Sat, 24 Jan 2026 01:48:57 +0000
Message-ID: <20260124014907.991265-7-derekjohn.clark@gmail.com>
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

Adds an LED multicolor class device and attribute group for controlling
the RGB of the Left and right handles. In addition to the standard
led_cdev attributes, additional attributes that allow for the control of
the effect (monocolor, breathe, rainbow, and chroma), speed of the
effect change, an enable toggle, and profile.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 472 ++++++++++++++++++++++++++++++++++++
 1 file changed, 472 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 5d454cd2cdae..91eb61037a2c 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -17,12 +17,15 @@
 #include <linux/hid.h>
 #include <linux/jiffies.h>
 #include <linux/kstrtox.h>
+#include <linux/led-class-multicolor.h>
 #include <linux/mutex.h>
 #include <linux/printk.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 #include <linux/usb.h>
+#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 #include "hid-ids.h"
 
@@ -33,7 +36,9 @@
 
 struct hid_go_cfg {
 	unsigned char *buf;
+	struct delayed_work go_cfg_setup;
 	struct completion send_cmd_complete;
+	struct led_classdev *led_cdev;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
 	u8 fps_mode;
@@ -65,7 +70,11 @@ struct hid_go_cfg {
 	u32 mcu_version_product;
 	u32 mcu_version_protocol;
 	u32 mouse_dpi;
+	u8 rgb_effect;
 	u8 rgb_en;
+	u8 rgb_mode;
+	u8 rgb_profile;
+	u8 rgb_speed;
 	u8 tp_en;
 	u8 tp_vibration_en;
 	u8 tp_vibration_intensity;
@@ -220,6 +229,41 @@ static const char *const rumble_mode_text[] = {
 
 #define FPS_MODE_DPI           0x02
 
+enum rgb_config_index {
+	LIGHT_CFG_ALL = 0x01,
+	LIGHT_MODE_SEL,
+	LIGHT_PROFILE_SEL,
+	USR_LIGHT_PROFILE_1,
+	USR_LIGHT_PROFILE_2,
+	USR_LIGHT_PROFILE_3,
+};
+
+enum rgb_mode_index {
+	RGB_MODE_UNKNOWN,
+	RGB_MODE_DYNAMIC,
+	RGB_MODE_CUSTOM,
+};
+
+static const char *const rgb_mode_text[] = {
+	[RGB_MODE_UNKNOWN] = "unknown",
+	[RGB_MODE_DYNAMIC] = "dynamic",
+	[RGB_MODE_CUSTOM] = "custom",
+};
+
+enum rgb_effect_index {
+	RGB_EFFECT_MONO,
+	RGB_EFFECT_BREATHE,
+	RGB_EFFECT_CHROMA,
+	RGB_EFFECT_RAINBOW,
+};
+
+static const char *const rgb_effect_text[] = {
+	[RGB_EFFECT_MONO] = "monocolor",
+	[RGB_EFFECT_BREATHE] = "breathe",
+	[RGB_EFFECT_CHROMA] = "chroma",
+	[RGB_EFFECT_RAINBOW] = "rainbow",
+};
+
 static int hid_go_version_event(struct command_report *cmd_rep)
 {
 	switch (cmd_rep->sub_cmd) {
@@ -437,6 +481,33 @@ static int hid_go_fps_dpi_event(struct command_report *cmd_rep)
 	return 0;
 }
 
+static int hid_go_light_event(struct command_report *cmd_rep)
+{
+	struct led_classdev_mc *mc_cdev;
+
+	switch (cmd_rep->sub_cmd) {
+	case LIGHT_MODE_SEL:
+		drvdata.rgb_mode = cmd_rep->data[0];
+		return 0;
+	case LIGHT_PROFILE_SEL:
+		drvdata.rgb_profile = cmd_rep->data[0];
+		return 0;
+	case USR_LIGHT_PROFILE_1:
+	case USR_LIGHT_PROFILE_2:
+	case USR_LIGHT_PROFILE_3:
+		mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+		drvdata.rgb_effect = cmd_rep->data[0];
+		mc_cdev->subled_info[0].intensity = cmd_rep->data[1];
+		mc_cdev->subled_info[1].intensity = cmd_rep->data[2];
+		mc_cdev->subled_info[2].intensity = cmd_rep->data[3];
+		drvdata.led_cdev->brightness = cmd_rep->data[4];
+		drvdata.rgb_speed = cmd_rep->data[5];
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int hid_go_set_event_return(struct command_report *cmd_rep)
 {
 	if (cmd_rep->data[0] != 0)
@@ -490,9 +561,13 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 		case GET_DPI_CFG:
 			ret = hid_go_fps_dpi_event(cmd_rep);
 			break;
+		case GET_RGB_CFG:
+			ret = hid_go_light_event(cmd_rep);
+			break;
 		case SET_FEATURE_STATUS:
 		case SET_MOTOR_CFG:
 		case SET_DPI_CFG:
+		case SET_RGB_CFG:
 			ret = hid_go_set_event_return(cmd_rep);
 			break;
 		default:
@@ -1077,6 +1152,274 @@ static ssize_t fps_mode_dpi_index_show(struct device *dev,
 	return sysfs_emit(buf, "500 800 1200 1800\n");
 }
 
+static int rgb_cfg_call(struct hid_device *hdev, enum mcu_command_index cmd,
+			enum rgb_config_index index, u8 *val, size_t size)
+{
+	if (cmd != SET_RGB_CFG && cmd != GET_RGB_CFG)
+		return -EINVAL;
+
+	if (index < LIGHT_CFG_ALL || index > USR_LIGHT_PROFILE_3)
+		return -EINVAL;
+
+	return mcu_property_out(hdev, MCU_CONFIG_DATA, cmd, index, UNSPECIFIED,
+				val, size);
+}
+
+static int rgb_attr_show(void)
+{
+	enum rgb_config_index index;
+
+	index = drvdata.rgb_profile + 3;
+
+	return rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, index, 0, 0);
+};
+
+static ssize_t rgb_effect_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+	enum rgb_config_index index;
+	u8 effect;
+	int ret;
+
+	ret = sysfs_match_string(rgb_effect_text, buf);
+	if (ret < 0)
+		return ret;
+
+	effect = ret;
+	index = drvdata.rgb_profile + 3;
+	u8 rgb_profile[6] = { effect,
+			      mc_cdev->subled_info[0].intensity,
+			      mc_cdev->subled_info[1].intensity,
+			      mc_cdev->subled_info[2].intensity,
+			      drvdata.led_cdev->brightness,
+			      drvdata.rgb_speed };
+
+	ret = rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
+	if (ret)
+		return ret;
+
+	drvdata.rgb_effect = effect;
+	return count;
+};
+
+static ssize_t rgb_effect_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int ret;
+
+	ret = rgb_attr_show();
+	if (ret)
+		return ret;
+
+	if (drvdata.rgb_effect >= ARRAY_SIZE(rgb_effect_text))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", rgb_effect_text[drvdata.rgb_effect]);
+}
+
+static ssize_t rgb_effect_index_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	ssize_t count = 0;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(rgb_effect_text); i++)
+		count += sysfs_emit_at(buf, count, "%s ", rgb_effect_text[i]);
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+
+static ssize_t rgb_speed_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+	enum rgb_config_index index;
+	int val = 0;
+	int ret;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val < 0 || val > 100)
+		return -EINVAL;
+
+	index = drvdata.rgb_profile + 3;
+	u8 rgb_profile[6] = { drvdata.rgb_effect,
+			      mc_cdev->subled_info[0].intensity,
+			      mc_cdev->subled_info[1].intensity,
+			      mc_cdev->subled_info[2].intensity,
+			      drvdata.led_cdev->brightness,
+			      val };
+
+	ret = rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
+	if (ret)
+		return ret;
+
+	drvdata.rgb_speed = val;
+
+	return count;
+};
+
+static ssize_t rgb_speed_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	int ret;
+
+	ret = rgb_attr_show();
+	if (ret)
+		return ret;
+
+	if (drvdata.rgb_speed > 100)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%hhu\n", drvdata.rgb_speed);
+}
+
+static ssize_t rgb_speed_range_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0-100\n");
+}
+
+static ssize_t rgb_mode_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	int ret;
+	u8 val;
+
+	ret = sysfs_match_string(rgb_mode_text, buf);
+	if (ret <= 0)
+		return ret;
+
+	val = ret;
+
+	ret = rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, LIGHT_MODE_SEL, &val, 1);
+	if (ret)
+		return ret;
+
+	drvdata.rgb_mode = val;
+
+	return count;
+};
+
+static ssize_t rgb_mode_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	int ret;
+
+	ret = rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, LIGHT_MODE_SEL, 0, 0);
+	if (ret)
+		return ret;
+
+	if (drvdata.rgb_mode >= ARRAY_SIZE(rgb_mode_text))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", rgb_mode_text[drvdata.rgb_mode]);
+};
+
+static ssize_t rgb_mode_index_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	ssize_t count = 0;
+	unsigned int i;
+
+	for (i = 1; i < ARRAY_SIZE(rgb_mode_text); i++)
+		count += sysfs_emit_at(buf, count, "%s ", rgb_mode_text[i]);
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+
+static ssize_t rgb_profile_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	size_t size = 1;
+	int ret;
+	u8 val;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val < 1 || val > 3)
+		return -EINVAL;
+
+	ret = rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, LIGHT_PROFILE_SEL, &val,
+			   size);
+	if (ret)
+		return ret;
+
+	drvdata.rgb_profile = val;
+
+	return count;
+};
+
+static ssize_t rgb_profile_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int ret;
+
+	ret = rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, LIGHT_PROFILE_SEL, 0,
+			   0);
+	if (ret)
+		return ret;
+
+	if (drvdata.rgb_profile < 1 || drvdata.rgb_profile > 3)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%hhu\n", drvdata.rgb_profile);
+};
+
+static ssize_t rgb_profile_range_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "1-3\n");
+}
+
+static void hid_go_brightness_set(struct led_classdev *led_cdev,
+				  enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+	enum rgb_config_index index;
+	int ret;
+
+	if (brightness > led_cdev->max_brightness) {
+		dev_err(led_cdev->dev, "Invalid argument\n");
+		return;
+	}
+
+	index = drvdata.rgb_profile + 3;
+	u8 rgb_profile[6] = { drvdata.rgb_effect,
+			      mc_cdev->subled_info[0].intensity,
+			      mc_cdev->subled_info[1].intensity,
+			      mc_cdev->subled_info[2].intensity,
+			      brightness,
+			      drvdata.rgb_speed };
+
+	ret = rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
+	switch (ret) {
+	case 0:
+		led_cdev->brightness = brightness;
+		break;
+	case -ENODEV: /* during switch to IAP -ENODEV is expected */
+	case -ENOSYS: /* during rmmod -ENOSYS is expected */
+		dev_dbg(led_cdev->dev, "Failed to write RGB profile: %i\n", ret);
+		break;
+	default:
+		dev_err(led_cdev->dev, "Failed to write RGB profile: %i\n", ret);
+	};
+}
+
 #define LEGO_DEVICE_ATTR_RW(_name, _attrname, _dtype, _rtype, _group)         \
 	static ssize_t _name##_store(struct device *dev,                      \
 				     struct device_attribute *attr,           \
@@ -1387,6 +1730,109 @@ static const struct attribute_group *top_level_attr_groups[] = {
 	&touchpad_attr_group,	  NULL,
 };
 
+/* RGB */
+struct go_cfg_attr rgb_enabled = { FEATURE_LIGHT_ENABLE };
+
+LEGO_DEVICE_ATTR_RW(rgb_enabled, "enabled", UNSPECIFIED, index, feature_status);
+static DEVICE_ATTR_RO_NAMED(rgb_effect_index, "effect_index");
+static DEVICE_ATTR_RO_NAMED(rgb_enabled_index, "enabled_index");
+static DEVICE_ATTR_RO_NAMED(rgb_mode_index, "mode_index");
+static DEVICE_ATTR_RO_NAMED(rgb_profile_range, "profile_range");
+static DEVICE_ATTR_RO_NAMED(rgb_speed_range, "speed_range");
+static DEVICE_ATTR_RW_NAMED(rgb_effect, "effect");
+static DEVICE_ATTR_RW_NAMED(rgb_mode, "mode");
+static DEVICE_ATTR_RW_NAMED(rgb_profile, "profile");
+static DEVICE_ATTR_RW_NAMED(rgb_speed, "speed");
+
+static struct attribute *go_rgb_attrs[] = {
+	&dev_attr_rgb_effect.attr,
+	&dev_attr_rgb_effect_index.attr,
+	&dev_attr_rgb_enabled.attr,
+	&dev_attr_rgb_enabled_index.attr,
+	&dev_attr_rgb_mode.attr,
+	&dev_attr_rgb_mode_index.attr,
+	&dev_attr_rgb_profile.attr,
+	&dev_attr_rgb_profile_range.attr,
+	&dev_attr_rgb_speed.attr,
+	&dev_attr_rgb_speed_range.attr,
+	NULL,
+};
+
+static struct attribute_group rgb_attr_group = {
+	.attrs = go_rgb_attrs,
+};
+
+struct mc_subled go_rgb_subled_info[] = {
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.brightness = 0x50,
+		.intensity = 0x24,
+		.channel = 0x1,
+	},
+	{
+		.color_index = LED_COLOR_ID_GREEN,
+		.brightness = 0x50,
+		.intensity = 0x22,
+		.channel = 0x2,
+	},
+	{
+		.color_index = LED_COLOR_ID_BLUE,
+		.brightness = 0x50,
+		.intensity = 0x99,
+		.channel = 0x3,
+	},
+};
+
+struct led_classdev_mc go_cdev_rgb = {
+	.led_cdev = {
+		.name = "go:rgb:joystick_rings",
+		.color = LED_COLOR_ID_RGB,
+		.brightness = 0x50,
+		.max_brightness = 0x64,
+		.brightness_set = hid_go_brightness_set,
+	},
+	.num_colors = ARRAY_SIZE(go_rgb_subled_info),
+	.subled_info = go_rgb_subled_info,
+};
+
+static void cfg_setup(struct work_struct *work)
+{
+	int ret;
+
+	/* RGB */
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA,
+			       GET_FEATURE_STATUS, FEATURE_LIGHT_ENABLE,
+			       UNSPECIFIED, 0, 0);
+	if (ret < 0) {
+		dev_err(drvdata.led_cdev->dev,
+			"Failed to retrieve RGB enabled: %i\n", ret);
+		return;
+	}
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_RGB_CFG,
+			       LIGHT_MODE_SEL, UNSPECIFIED, 0, 0);
+	if (ret < 0) {
+		dev_err(drvdata.led_cdev->dev,
+			"Failed to retrieve RGB Mode: %i\n", ret);
+		return;
+	}
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_RGB_CFG,
+			       LIGHT_PROFILE_SEL, UNSPECIFIED, 0, 0);
+	if (ret < 0) {
+		dev_err(drvdata.led_cdev->dev,
+			"Failed to retrieve RGB Profile: %i\n", ret);
+		return;
+	}
+
+	ret = rgb_attr_show();
+	if (ret < 0) {
+		dev_err(drvdata.led_cdev->dev,
+			"Failed to retrieve RGB Profile Data: %i\n", ret);
+		return;
+	}
+}
+
 static int hid_go_cfg_probe(struct hid_device *hdev,
 			    const struct hid_device_id *_id)
 {
@@ -1409,14 +1855,40 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
 		return ret;
 	}
 
+	ret = devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
+	if (ret) {
+		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
+		return ret;
+	}
+
+	ret = devm_device_add_group(go_cdev_rgb.led_cdev.dev, &rgb_attr_group);
+	if (ret) {
+		dev_err_probe(&hdev->dev, ret,
+			      "Failed to create RGB configuration attributes\n");
+		return ret;
+	}
+
+	drvdata.led_cdev = &go_cdev_rgb.led_cdev;
+
 	init_completion(&drvdata.send_cmd_complete);
 
+	/* Executing calls prior to returning from probe will lock the MCU. Schedule
+	 * initial data call after probe has completed and MCU can accept calls.
+	 */
+	INIT_DELAYED_WORK(&drvdata.go_cfg_setup, &cfg_setup);
+	ret = schedule_delayed_work(&drvdata.go_cfg_setup, msecs_to_jiffies(2));
+	if (!ret) {
+		dev_err(&hdev->dev,
+			"Failed to schedule startup delayed work\n");
+		return -ENODEV;
+	}
 	return 0;
 }
 
 static void hid_go_cfg_remove(struct hid_device *hdev)
 {
 	guard(mutex)(&drvdata.cfg_mutex);
+	cancel_delayed_work_sync(&drvdata.go_cfg_setup);
 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
-- 
2.52.0

