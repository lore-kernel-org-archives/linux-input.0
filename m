Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E5238C3B
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896758; cv=none; b=jnUMnaxKhJ/j8KWvl1ETmjU5C1NuRz6GzThm+kiMcKWb1cWmOi6XFlwEyKIb7tOJ8r2dR3B6cmgSqbD9zc2ekVuLXx05/6oYVA9LtOsb5ye4PRpwD4ynKPsgRoze4XrNU/1CwDYCjhOuyQQGxUU15o6P9+AcBL8IEZVreDBZrwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896758; c=relaxed/simple;
	bh=5zmvhCSzVKQWVeJpV+JzldP6eTSHbWR27bfvIBMbw0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWigH9miGU8wxrTKiDZsb2lEcWKEUnuPPwc6UZLIsNmTUOJ/JHoyTB/fg1gC/5nhgP2rg1tGEnE+nYavvy+f17W4LdSouCqYj6LRrB0VCkUxGl/XP6hyD6bK/1JYdminYEIMK2fhcgghnlUtGxXERGH6H4edQR630XNFnR6Eylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc265SNE; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc265SNE"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so2892123eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771896755; x=1772501555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3T3rfbgMgRdQYOQhjLjrm8BnZ1KC4f94qtU1Sqe8xM=;
        b=Qc265SNEeFBsmlKb60u8+lf7Qz4qogoBdURgRExEU7dUplCPIgfpFdv/yzOVpwvdAI
         7wqOLf/nTMGWQbrhirsDnxFF19FS+L86w9puwFbSrFh3Eku5Y9HXAKHHT5btESWPJ16v
         lORh2EuiCFT83rlWVkOm+MzzkvpN4dGfc4dJ0J6HmxLnE8pJWhTFM3HhhQdcKk0ffnnF
         xRIF/JYaGgmGB19jsKvcmfpQ86LJin5WcnePm7VcJskDqgGFjeD+Hg6ykPQPVPEgyXtD
         UaN5uOgqWw8PNgYmVe0yC8Elmb644MJv6nuqAjoZKdChOKXYfHsMv2QpTZc213S5MuAG
         8NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771896755; x=1772501555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r3T3rfbgMgRdQYOQhjLjrm8BnZ1KC4f94qtU1Sqe8xM=;
        b=vpdOziYK4qKT4nw1aAUMCIe4Kvhviq1eadq1asY/ZAfELenEfzQl6CKmbb4lpNfSXS
         sr3517bwKoYTPAB9vQgKm3X7RyCfipC1uaR/pCTac6yqWVUN/koBUfsQo9lpv+EkG9q9
         Eg8i09kz1dWvCgHAItCiHwLDpBtis8MqLu7jKwtp6z1UzeBKTXMBnIRvOgVMSc/eQKYx
         JOqSxuJwzjlyzcwV80gvr8wIcI0jkPuLJHtHZZao3q6OAIjoRNkkpQPrujbg0flRuuVS
         8elv4/NS56aYOHBlPaSGdn3kSWrp1OBQwNBsGCAtCgRikNHd5qR2vVSrHO94b4FfwQL2
         Ylvw==
X-Forwarded-Encrypted: i=1; AJvYcCWVx85GZYFebbO2MmeTPlOZha0fk1FCdDWo27oF+4rPXEYcNbMQPcrJn1LRIIJpAkZHKuoayu2Je6nSfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAPzLa/Fpzix8lxDfTBNwJLFwDuH7NyZqJK7CRT8EmusixTEx
	yM/n2zvnwHri/Lfcp8vpqcGAt2GPBeSn43935nCiIeW3bS9ORrByEwUA
X-Gm-Gg: ATEYQzzotwDDlucYhCIj1ZKiKzk5owzpmb1hA8xfL08eoDLCMYgLxwDGa5XC8IikkyI
	53yCEubLrZPzjb5Z9mSjhjYkDtR1iivBJY4jq2PQ5jU2bu1NVh6sVGqg01CcPMH3risPUy4NHaL
	dpc3tTDK60ZcbtTepUJeblAoQco7LFS9mjaUWcGO0BUaCXJ1bMQX/SEyc+uyW7/U/2vFem1XOz0
	gOmel10YrvOOdJZyIO3MVX4Hosm9PyAfPzgzE2+307tEQNorjyB7E+oRFqWLTzIXiFrdu3SHjpu
	fwhFrU2tO6Y6zeBGJOt2eFFgSTPkcrSv6VKrLZyfwb1IHN/w7SQve8g3T4S69EGm4KfzO5+uw8A
	B49WPucBS+XKzAytMOhBaXuzI9/X7oa0as5fFwoCrhuT2jbDOs0tIySVKsM8Eob9vgLKOx+gMua
	NCUnUiYissXao2FPB1EAlxgNLL5UeioKGRvwGnrGpAxKBxI2m/QgDPFOhUrxFOO8p4Ka/uhfgg1
	1kCSz+g/7ZT0w==
X-Received: by 2002:a05:7301:6085:b0:2ba:72b1:40c7 with SMTP id 5a478bee46e88-2bd7b9f0874mr4662027eec.4.1771896754966;
        Mon, 23 Feb 2026 17:32:34 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa027fsm6485015eec.9.2026.02.23.17.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:32:34 -0800 (PST)
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
Subject: [PATCH v5 15/16] HID: hid-lenovo-go-s: Add IMU and Touchpad RO Attributes
Date: Tue, 24 Feb 2026 01:32:16 +0000
Message-ID: <20260224013217.1363996-16-derekjohn.clark@gmail.com>
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

Adds attributes for reporting the touchpad manufacturer, version, and
IMU manufacturer.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v4:
 - Cache RO values at probe instead of calling them at request. Values
   don't change and reading the touchpad data is slow.
v3:
 - Fix bug where the touchpad attributes were assigned to the touchpad
   _show function instead of the test _show function.
---
 drivers/hid/hid-lenovo-go-s.c | 124 ++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 1a7de95e2a065..cacc5bd5ed2b6 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -43,6 +43,7 @@ struct hid_gos_cfg {
 	u8 gp_mode;
 	u8 gp_poll_rate;
 	u8 imu_bypass_en;
+	u8 imu_manufacturer;
 	u8 imu_sensor_en;
 	u8 mcu_id[12];
 	u8 mouse_step;
@@ -54,6 +55,8 @@ struct hid_gos_cfg {
 	u8 rgb_speed;
 	u8 tp_en;
 	u8 tp_linux_mode;
+	u8 tp_manufacturer;
+	u8 tp_version;
 	u8 tp_windows_mode;
 } drvdata;
 
@@ -201,6 +204,36 @@ enum rgb_config_index {
 	USR_LIGHT_PROFILE_3,
 };
 
+enum test_command_index {
+	TEST_TP_MFR = 0x02,
+	TEST_IMU_MFR,
+	TEST_TP_VER,
+};
+
+enum tp_mfr_index {
+	TP_NONE,
+	TP_BETTERLIFE,
+	TP_SIPO,
+};
+
+static const char *const touchpad_manufacturer_text[] = {
+	[TP_NONE] = "none",
+	[TP_BETTERLIFE] = "BetterLife",
+	[TP_SIPO] = "SIPO",
+};
+
+enum imu_mfr_index {
+	IMU_NONE,
+	IMU_BOSCH,
+	IMU_ST,
+};
+
+static const char *const imu_manufacturer_text[] = {
+	[IMU_NONE] = "none",
+	[IMU_BOSCH] = "Bosch",
+	[IMU_ST] = "ST",
+};
+
 static int hid_gos_version_event(u8 *data)
 {
 	struct version_report *ver_rep = (struct version_report *)data;
@@ -279,6 +312,30 @@ static int hid_gos_touchpad_event(struct command_report *cmd_rep)
 	return ret;
 }
 
+static int hid_gos_pl_test_event(struct command_report *cmd_rep)
+{
+	int ret = 0;
+
+	switch (cmd_rep->sub_cmd) {
+	case TEST_TP_MFR:
+		drvdata.tp_manufacturer = cmd_rep->data[0];
+		ret = 0;
+		break;
+	case TEST_IMU_MFR:
+		drvdata.imu_manufacturer = cmd_rep->data[0];
+		ret = 0;
+		break;
+	case TEST_TP_VER:
+		drvdata.tp_version = cmd_rep->data[0];
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 static int hid_gos_light_event(struct command_report *cmd_rep)
 {
 	struct led_classdev_mc *mc_cdev;
@@ -362,6 +419,9 @@ static int hid_gos_raw_event(struct hid_device *hdev, struct hid_report *report,
 	case GET_TP_PARAM:
 		ret = hid_gos_touchpad_event(cmd_rep);
 		break;
+	case GET_PL_TEST:
+		ret = hid_gos_pl_test_event(cmd_rep);
+		break;
 	case GET_RGB_CFG:
 		ret = hid_gos_light_event(cmd_rep);
 		break;
@@ -738,6 +798,37 @@ static ssize_t touchpad_property_options(struct device *dev,
 	return count;
 }
 
+static ssize_t test_property_show(struct device *dev,
+				  struct device_attribute *attr, char *buf,
+				  enum test_command_index index)
+{
+	size_t count = 0;
+	u8 i;
+
+	switch (index) {
+	case TEST_TP_MFR:
+		i = drvdata.tp_manufacturer;
+		if (i >= ARRAY_SIZE(touchpad_manufacturer_text))
+			return -EINVAL;
+		count = sysfs_emit(buf, "%s\n", touchpad_manufacturer_text[i]);
+		break;
+	case TEST_IMU_MFR:
+		i = drvdata.imu_manufacturer;
+		if (i >= ARRAY_SIZE(imu_manufacturer_text))
+			return -EINVAL;
+		count = sysfs_emit(buf, "%s\n", imu_manufacturer_text[i]);
+		break;
+	case TEST_TP_VER:
+		count = sysfs_emit(buf, "%u\n", drvdata.tp_version);
+		break;
+	default:
+		count = -EINVAL;
+		break;
+	}
+
+	return count;
+}
+
 static ssize_t mcu_id_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -1081,6 +1172,9 @@ struct gos_cfg_attr imu_bypass_enabled = { FEATURE_IMU_BYPASS };
 LEGOS_DEVICE_ATTR_RW(imu_bypass_enabled, "bypass_enabled", index, gamepad);
 static DEVICE_ATTR_RO_NAMED(imu_bypass_enabled_index, "bypass_enabled_index");
 
+struct gos_cfg_attr imu_manufacturer = { TEST_IMU_MFR };
+LEGOS_DEVICE_ATTR_RO(imu_manufacturer, "manufacturer", test);
+
 struct gos_cfg_attr imu_sensor_enabled = { FEATURE_IMU_ENABLE };
 LEGOS_DEVICE_ATTR_RW(imu_sensor_enabled, "sensor_enabled", index, gamepad);
 static DEVICE_ATTR_RO_NAMED(imu_sensor_enabled_index, "sensor_enabled_index");
@@ -1088,6 +1182,7 @@ static DEVICE_ATTR_RO_NAMED(imu_sensor_enabled_index, "sensor_enabled_index");
 static struct attribute *legos_imu_attrs[] = {
 	&dev_attr_imu_bypass_enabled.attr,
 	&dev_attr_imu_bypass_enabled_index.attr,
+	&dev_attr_imu_manufacturer.attr,
 	&dev_attr_imu_sensor_enabled.attr,
 	&dev_attr_imu_sensor_enabled_index.attr,
 	NULL,
@@ -1141,6 +1236,12 @@ struct gos_cfg_attr touchpad_linux_mode = { CFG_LINUX_MODE };
 LEGOS_DEVICE_ATTR_RW(touchpad_linux_mode, "linux_mode", index, touchpad);
 static DEVICE_ATTR_RO_NAMED(touchpad_linux_mode_index, "linux_mode_index");
 
+struct gos_cfg_attr touchpad_manufacturer = { TEST_TP_MFR };
+LEGOS_DEVICE_ATTR_RO(touchpad_manufacturer, "manufacturer", test);
+
+struct gos_cfg_attr touchpad_version = { TEST_TP_VER };
+LEGOS_DEVICE_ATTR_RO(touchpad_version, "version", test);
+
 struct gos_cfg_attr touchpad_windows_mode = { CFG_WINDOWS_MODE };
 LEGOS_DEVICE_ATTR_RW(touchpad_windows_mode, "windows_mode", index, touchpad);
 static DEVICE_ATTR_RO_NAMED(touchpad_windows_mode_index, "windows_mode_index");
@@ -1150,6 +1251,8 @@ static struct attribute *legos_touchpad_attrs[] = {
 	&dev_attr_touchpad_enabled_index.attr,
 	&dev_attr_touchpad_linux_mode.attr,
 	&dev_attr_touchpad_linux_mode_index.attr,
+	&dev_attr_touchpad_manufacturer.attr,
+	&dev_attr_touchpad_version.attr,
 	&dev_attr_touchpad_windows_mode.attr,
 	&dev_attr_touchpad_windows_mode_index.attr,
 	NULL,
@@ -1250,6 +1353,27 @@ static void cfg_setup(struct work_struct *work)
 		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU Version: %i\n", ret);
 		return;
 	}
+
+	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_TP_MFR, 0, 0);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to retrieve Touchpad Manufacturer: %i\n", ret);
+		return;
+	}
+
+	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_TP_VER, 0, 0);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to retrieve Touchpad Firmware Version: %i\n", ret);
+		return;
+	}
+
+	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_IMU_MFR, 0, 0);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to retrieve IMU Manufacturer: %i\n", ret);
+		return;
+	}
 }
 
 static int hid_gos_cfg_probe(struct hid_device *hdev,
-- 
2.52.0

