Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711EF426688
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127799; cv=none; b=Q6pISKibMSyJ24fO/0lg2Jf5PB6fjGBCF+zQernHUL8v/g2xJu2YmVkKKNP1dAzfSF3JD6FYbzZOCN/A/YqABUjzPZMntIiGOMyX2ciDUK1rcp3L4RyDyhQZ0jpzbVrCcTc806JrqFzs9QSSwHIT5MLLLmADunFmwN850BZRdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127799; c=relaxed/simple;
	bh=ByTxEpcE9fDsHD0eoQcjY11ZtAGzAn9gzw0tgVTUTks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YygSSLp93ZN1Xnlo1jPl9Yaexjs60wgatd4tLX+tY2repZ8b9nAiduabRaQc0cfkk/51OokiTYnjv98cjV5YXJ5D4VvoJ9WOvwoUXN/C0DytUjBooOx0ffZCrGgeb7Tsn8qhlnjx638z9ursubfvMY7w9LiTZaFCEw4i8V6jvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTLoqNbL; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTLoqNbL"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2be26842fd5so4130641eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127795; x=1773732595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvS66gYJU0TWNIg1a0u1KW72qS57RtywXG3sPMwlyUY=;
        b=RTLoqNbLFXPEOwOmbS+IjUN1SrcWETG2haSHPnvNssNow8+8hWpUaMYCNiaMc96jGS
         pSti1HduSsrif5HccjyAW2WHEbyi+L6ZopMwu/GIQX1R6Sgm/wzu9uDkMDqGnqCwWBBv
         IKbFPY1U4MvqwapaOE+b0bE8DPImnpowVTPmfSyeuMsYcBNRgjZ9i8E18dFzSc/UYhgt
         6F6mwbgY4SPB88J3E4DUzlqvAwNHRH++uQn0/6B4kHbTcgFrMbN8Tt8mYB865CzHvUCR
         tP1tb7qiKq8PyF81p/NxeSDGeOtWAFBXN7cYRMra1mSsUNWLpzM5grq8mzb7Swyvik7o
         ez0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127795; x=1773732595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XvS66gYJU0TWNIg1a0u1KW72qS57RtywXG3sPMwlyUY=;
        b=j6TodAot1NtuSUI7QK+wZYeX/RuN+YtGRIoqbYEC4nQ6Zi0Say97qWLxdkk2UGoq9B
         rZGWw6+2Xq1QrUGoWPF3wceQ+2QvZikDP26ygZwtfKEyIKWZ60A3VAAzXJO5eb74+kQj
         XUgphaSH20+9g8btjNlbc8DWdepToCJxbgqA2hD6/I5eeFcg1qU2D4E6Vmz4THq6T379
         seOGVl1YGeZSBpPV/XcShtQmLXkrOuAmsAbPz32+xGNuVVPG71Hh/iEKoQKUKZLBTuZ1
         oM0haV9k5OgZwkF01+vB7FzyDj7YXs/dZ/Rn4+Jo+ig3Ebs+/yVmuwZDTsHlBMKDEruw
         kFyw==
X-Forwarded-Encrypted: i=1; AJvYcCVmEaZETEto4HXpvZmp93/TgIWBKLF9yfEKILi4LQ3/hJQWlV9HvCSH6eP0ayjuIrBYk5h1tpe6zF/ptQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHySXIRiRRRdH8qouanRLbDqEFkb9cCDORfFTiHC+Sh+oSvRh
	SUbTTo8gxAugcOecriKAPXGejrqJHkEayG0xwTVmgQF26Rq2PSI6HeP7
X-Gm-Gg: ATEYQzxg/dVoqH221VuDiB8uLt2bKC7oJFx2/6cBTFNoUv945STcFe8C4oz7Zmij47E
	ksTp+OWeJB9OqDsjYLu6992/+8LocyyJo90UiB32ilm47c5ElSR+5Z/epfURr9MqZAqBloK0oQc
	Ckt6DSK/7pS8zM8Ve/uEQyJr4k51IQtmMpaHzf0hl887iwCtKiRoVdRT55TnAeVHK0h+WlLbJD1
	bU3a4LgB5nEy2rCCkBUWZ6UIDVIDM2xBLCu16mQJno0bfM1BWOXcJgxr+g/dpft50NfE7GFXi3q
	eVtS9xScaXIWOL1TGUZP4Y4x9zAXSP149u4MQi/Y7feVqMQvP9CngzRLaGK7BBRsYpGXuxeJ9BA
	vIr+3tSMrD9F7Wa+kj7qqxz6JR5AdjX09OBPeJnBYA8fMgNzuM5q5i+VYQ6LqtXA6V9r3etL3Pb
	CdXnSRIObbguu3Qkpye7d7Js7IxMWK49CWspndf6+e2bapl1lk+VwZNaWpxh7v6g+WTFgi8Q1JZ
	2dU
X-Received: by 2002:a05:693c:60ce:b0:2be:6693:9b4d with SMTP id 5a478bee46e88-2be7a0dbcd1mr722850eec.9.1773127795462;
        Tue, 10 Mar 2026 00:29:55 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:55 -0700 (PDT)
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
Subject: [PATCH v6 15/19] HID: hid-lenovo-go-s: Add IMU and Touchpad RO Attributes
Date: Tue, 10 Mar 2026 07:29:33 +0000
Message-ID: <20260310072937.3295875-16-derekjohn.clark@gmail.com>
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

Adds attributes for reporting the touchpad manufacturer, version, and
IMU manufacturer.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v6:
  - Make local attributes static.
  - Use NULL instead of 0 in mcu_propery_out when there is no data.
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
index 0123c4b03cf4..431fffde4695 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -43,6 +43,7 @@ static struct hid_gos_cfg {
 	u8 gp_mode;
 	u8 gp_poll_rate;
 	u8 imu_bypass_en;
+	u8 imu_manufacturer;
 	u8 imu_sensor_en;
 	u8 mcu_id[12];
 	u8 mouse_step;
@@ -55,6 +56,8 @@ static struct hid_gos_cfg {
 	u8 tp_en;
 	u8 tp_linux_mode;
 	u8 tp_windows_mode;
+	u8 tp_version;
+	u8 tp_manufacturer;
 } drvdata;
 
 struct gos_cfg_attr {
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
@@ -735,6 +795,37 @@ static ssize_t touchpad_property_options(struct device *dev,
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
@@ -1076,6 +1167,9 @@ static struct gos_cfg_attr imu_bypass_enabled = { FEATURE_IMU_BYPASS };
 LEGOS_DEVICE_ATTR_RW(imu_bypass_enabled, "bypass_enabled", index, gamepad);
 static DEVICE_ATTR_RO_NAMED(imu_bypass_enabled_index, "bypass_enabled_index");
 
+static struct gos_cfg_attr imu_manufacturer = { TEST_IMU_MFR };
+LEGOS_DEVICE_ATTR_RO(imu_manufacturer, "manufacturer", test);
+
 static struct gos_cfg_attr imu_sensor_enabled = { FEATURE_IMU_ENABLE };
 LEGOS_DEVICE_ATTR_RW(imu_sensor_enabled, "sensor_enabled", index, gamepad);
 static DEVICE_ATTR_RO_NAMED(imu_sensor_enabled_index, "sensor_enabled_index");
@@ -1083,6 +1177,7 @@ static DEVICE_ATTR_RO_NAMED(imu_sensor_enabled_index, "sensor_enabled_index");
 static struct attribute *legos_imu_attrs[] = {
 	&dev_attr_imu_bypass_enabled.attr,
 	&dev_attr_imu_bypass_enabled_index.attr,
+	&dev_attr_imu_manufacturer.attr,
 	&dev_attr_imu_sensor_enabled.attr,
 	&dev_attr_imu_sensor_enabled_index.attr,
 	NULL,
@@ -1136,6 +1231,12 @@ static struct gos_cfg_attr touchpad_linux_mode = { CFG_LINUX_MODE };
 LEGOS_DEVICE_ATTR_RW(touchpad_linux_mode, "linux_mode", index, touchpad);
 static DEVICE_ATTR_RO_NAMED(touchpad_linux_mode_index, "linux_mode_index");
 
+static struct gos_cfg_attr touchpad_manufacturer = { TEST_TP_MFR };
+LEGOS_DEVICE_ATTR_RO(touchpad_manufacturer, "manufacturer", test);
+
+static struct gos_cfg_attr touchpad_version = { TEST_TP_VER };
+LEGOS_DEVICE_ATTR_RO(touchpad_version, "version", test);
+
 static struct gos_cfg_attr touchpad_windows_mode = { CFG_WINDOWS_MODE };
 LEGOS_DEVICE_ATTR_RW(touchpad_windows_mode, "windows_mode", index, touchpad);
 static DEVICE_ATTR_RO_NAMED(touchpad_windows_mode_index, "windows_mode_index");
@@ -1145,6 +1246,8 @@ static struct attribute *legos_touchpad_attrs[] = {
 	&dev_attr_touchpad_enabled_index.attr,
 	&dev_attr_touchpad_linux_mode.attr,
 	&dev_attr_touchpad_linux_mode_index.attr,
+	&dev_attr_touchpad_manufacturer.attr,
+	&dev_attr_touchpad_version.attr,
 	&dev_attr_touchpad_windows_mode.attr,
 	&dev_attr_touchpad_windows_mode_index.attr,
 	NULL,
@@ -1245,6 +1348,27 @@ static void cfg_setup(struct work_struct *work)
 		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU Version: %i\n", ret);
 		return;
 	}
+
+	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_TP_MFR, NULL, 0);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to retrieve Touchpad Manufacturer: %i\n", ret);
+		return;
+	}
+
+	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_TP_VER, NULL, 0);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to retrieve Touchpad Firmware Version: %i\n", ret);
+		return;
+	}
+
+	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_IMU_MFR, NULL, 0);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to retrieve IMU Manufacturer: %i\n", ret);
+		return;
+	}
 }
 
 static int hid_gos_cfg_probe(struct hid_device *hdev,
-- 
2.53.0

