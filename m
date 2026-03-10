Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57B347FE1
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127790; cv=none; b=rnMGXcCMpKHXALewsdR5yd9MTzEguVWZzwH/N4XpevfityrvW2AwS6YkqKz+4wJu6Uhp9oewQA2eiyhaRFtsF6wZ/JmAQyXBJsTnAMxpOHQ4VKd9RhdC3pNK889VsDeemWeKDULgfSW2aCHAFCCgWInbcCZRTWL+ATP0lXtJ0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127790; c=relaxed/simple;
	bh=80w6mG1IPQ177/KHDFucfZXdnOAp1gg/NFfXxbSUOyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/Od90mor/ivDvuBvE4TuZnlZMLn3wZnA2JflNtjNQUjllHr/umODEXSSDhWsZWMWiKIC8o2DqtxO0LNFW0MKafH64RtpTj70UW8GaJHIeRfDF19isDD/kyDkuTlH6nAbP9Mc51CUx//6LHM/Rud1Sv6xsiBPphSwEQH4h0NhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsk9bMdE; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsk9bMdE"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4e9694so9560908c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127786; x=1773732586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCj6LfreKTRcKvUoolIEtLTQfVyiIzNQOsFJIkKznoE=;
        b=lsk9bMdExUkCjRvq/K513TPCz6xJLGvPOAMPhtK8lWWi2WmUMM/ah7gqGq46kWYi58
         Dyat9LFHpgX7Of2QQywNcRj8zTAOM7PW6Z/WyFMXSvhJyYCaknOs5k9xw5HcpC8kb7k8
         yFa3GbV4CeFguqWhk0geAQcrnQQeagnpNpiAIDrQFEqORQT6UVdpy2HNHAMADHU7YBNu
         SyBbcxmr6Ga2dEvWGeKePPRDUFwE1YydhlK8g3l2XAjKWApjsc8pNXjQkrEqH4EP7bS9
         meAZG+wEt4E6VQ1WWyunHZVQTCqg7IwJ/t1plETibjp1ZKCnIM2D3tPp5PU9V54rsk99
         0r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127786; x=1773732586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCj6LfreKTRcKvUoolIEtLTQfVyiIzNQOsFJIkKznoE=;
        b=AuXmGSFrQLcAw4nASEP7EU3ueO/bIMiKJAYxH8ufmNDkMf/yD0+nHFpCYr1AG9gpRf
         Hd2naF0T7LORCN0Ksf9SrYnF0BIYuZ+BQfswaSOxgWR13+xQdKkgcdwQsP/qqpWS8206
         2AEmF5NvpiK99QC0uUJ4947qh0thtYkCGfH2rMqDl/3f6UubriqBp86+4gfPoEsgo+0c
         4EiB93KFzYTv5B6nsfANgO+rcxtVAbt56krdDx5aBIXs1iWoprJfx3WPp6DvHIK3kDhE
         /E46oKg2WJ/DxuzSrWeXreXnPmp7BEzXCnPFaTXS9rSN+T+klgbQERE/j8Cq2xCPWHJd
         5KUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsgtnM5GnLUy3EWDIoGCKPz3Wh0KBf8tzpyD78es84vdz1WVFha/w2TfVwZ2s1mO8KuxmTrl3cEMascg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61OvY4JfGYpypAy67cn0XC7B+2xKg2QUTURFwL3zVnZCvZGDL
	JRLKVRcr2F7mYDJHdvvl7v74YVOkCf72IqgdO0eVSUU4bIH2lUOgHXgD
X-Gm-Gg: ATEYQzyQGTMSS5hyWzoqPYIB+TWYJtbFwEnjvN4Z8mhrFtJz22l6u8FETd7IZ3kYRUr
	gVmfvAzFf8P4CylqVVYisL2kenGkNbES6461T77DjB1t7XS5+1gJ8Mw0N5vFY9oHyK5Q490gNLP
	3WTbM427F/21YtETFvAsUtaDhx1NAD49W0pJPJ+gZgz+8j9IUBz3VLxtoHFXbj5kc10kVjqU1v1
	6ccLPYqkTB0sQKOd3PXS33SaD5fT+AVyd6CmVnnko8MFLCsrticEIsdCnXWbYyAkDeWpR6TcNXH
	oXAhFbAxmq3lwNg7/fbXKbUMOAj+dw9sAeffjCmgq3ZRp9mubNTephGSQpqE6WPKvX0H1u8E0Be
	qtVa/8bE+STRnOrQj9T8oJu4gR67zL5yHpMw9o0zvE2Zf5hzXw7XAzWnU9/nbmXxFcsUasmfHPX
	qwSodutRZbxN1pgO0+65HQTmeHm77Gm2yI2eLm6p5NNFcZMHfXxMYdnEs+/vSXQX7mRhzaJRF2u
	38R
X-Received: by 2002:a05:7022:698e:b0:128:d0b1:527 with SMTP id a92af1059eb24-128d0b10704mr4742244c88.36.1773127785784;
        Tue, 10 Mar 2026 00:29:45 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:45 -0700 (PDT)
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
Subject: [PATCH v6 06/19] HID: hid-lenovo-go: Add RGB LED control interface
Date: Tue, 10 Mar 2026 07:29:24 +0000
Message-ID: <20260310072937.3295875-7-derekjohn.clark@gmail.com>
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

Adds an LED multicolor class device and attribute group for controlling
the RGB of the Left and right handles. In addition to the standard
led_cdev attributes, additional attributes that allow for the control of
the effect (monocolor, breathe, rainbow, and chroma), speed of the
effect change, an enable toggle, and profile.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v6:
  - Invert the rgb_speed logic so larger number is faster.
  - Make local attributes static.
  - Use NULL instead of 0 in mcu_propery_out when there is no data.
v5:
  - Don't retrieve RGB state during delayed work.
---
 drivers/hid/hid-lenovo-go.c | 429 ++++++++++++++++++++++++++++++++++++
 1 file changed, 429 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 24f9444c93cd..ee7d4bf23a17 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -18,6 +18,7 @@
 #include <linux/hid.h>
 #include <linux/jiffies.h>
 #include <linux/kstrtox.h>
+#include <linux/led-class-multicolor.h>
 #include <linux/mutex.h>
 #include <linux/printk.h>
 #include <linux/sysfs.h>
@@ -37,6 +38,7 @@
 static struct hid_go_cfg {
 	struct delayed_work go_cfg_setup;
 	struct completion send_cmd_complete;
+	struct led_classdev *led_cdev;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
 	u8 fps_mode;
@@ -68,7 +70,11 @@ static struct hid_go_cfg {
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
@@ -223,6 +229,41 @@ static const char *const rumble_mode_text[] = {
 
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
@@ -440,6 +481,33 @@ static int hid_go_fps_dpi_event(struct command_report *cmd_rep)
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
+		drvdata.rgb_speed = 100 - cmd_rep->data[5];
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int hid_go_set_event_return(struct command_report *cmd_rep)
 {
 	if (cmd_rep->data[0] != 0)
@@ -493,9 +561,13 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
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
@@ -565,6 +637,12 @@ static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 			    enum dev_type device_type)
 {
 	ssize_t count = 0;
+	int ret;
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
+			       index, device_type, NULL, 0);
+	if (ret)
+		return ret;
 
 	switch (index) {
 	case PRODUCT_VERSION:
@@ -1079,6 +1157,277 @@ static ssize_t fps_mode_dpi_index_show(struct device *dev,
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
+	return rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, index, NULL, 0);
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
+	/* This is a delay setting, invert logic for consistency with other drivers */
+	val = 100 - val;
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
+	int ret, val;
+
+	ret = rgb_attr_show();
+	if (ret)
+		return ret;
+
+	if (drvdata.rgb_speed > 100)
+		return -EINVAL;
+
+	val = drvdata.rgb_speed;
+
+	return sysfs_emit(buf, "%hhu\n", val);
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
+	ret = rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, LIGHT_MODE_SEL, NULL, 0);
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
+	ret = rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, LIGHT_PROFILE_SEL, &val, size);
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
+	ret = rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, LIGHT_PROFILE_SEL, NULL, 0);
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
@@ -1389,6 +1738,71 @@ static const struct attribute_group *top_level_attr_groups[] = {
 	&touchpad_attr_group,	  NULL,
 };
 
+/* RGB */
+static struct go_cfg_attr rgb_enabled = { FEATURE_LIGHT_ENABLE };
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
+static struct mc_subled go_rgb_subled_info[] = {
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
+static struct led_classdev_mc go_cdev_rgb = {
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
 static void cfg_setup(struct work_struct *work)
 {
 	int ret;
@@ -1579,6 +1993,21 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
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
 
 	/* Executing calls prior to returning from probe will lock the MCU. Schedule
-- 
2.53.0

