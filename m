Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CE373C1E
	for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776572795; cv=none; b=auNTorV95m8HGklmHya8E6muuT3R/XCTck4T0iY87LI9jQXSiwENTxFjnq2xf6IVkkjcNO4fibDWTtND+8ES3CeyMEIwYXs/VJPCDMdEXAoczPMLnuKxzMPgDGHkYUrzTTJqHfeD/VN8JlKrAjZAXnue+/M6cp6fvvTa1CjlcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776572795; c=relaxed/simple;
	bh=S508cP1yZslNSbKv0FAXNIDkX2zVJDf06fpTroAG+R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrQFR7EeQ6bBJamLlOIIYuPJTWjPuqtFDmQV+9ukAqZWPOe2uDj1LH3jdQP8FVovbJ9JvAwBonG/ulAGnggNLUMnHCrOzWP8Kkdz6fTzUav7mAWdRyujigX6kS543lFYwGKpReqq25pHm/LlhbB9ijoueql7OViXh5cYKn2jFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNzwooKU; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNzwooKU"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2d9916deb14so3759594eec.0
        for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 21:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776572790; x=1777177590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dns9bM6fc8u8pLco2XqNcLByz5759WEqyjVFudH5F6U=;
        b=oNzwooKU+U23CZQT43mPFlglQSgViP/ki+XiqMWgPx7J0bgPamiCZLwktXGmxAjAKm
         49nMHYxSrEoGPPLF5C3D9Bm055bxf6ArZxKFa5BUCDRjt1fkbfIQtRd0f5nyYi5aC0qI
         XG2atAfCnc424vvB6QeO4temjoXrqae9qqlEUSC1vWAinLcSe2Pebgak/b7PFZBPKvVc
         P3pn9HLgrM4wCkIKNbzAe92hvE2474u2yp3bmEzSmJioUhf6nH4MT0r5Hi+iR8sblDhJ
         V9+q7f8/JMaomOLw1eB4jnt1DWPl/wFA0Fu9+95sOmHYlWBlDTGAMPT7MWQ7AZjMqSHQ
         598A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776572790; x=1777177590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dns9bM6fc8u8pLco2XqNcLByz5759WEqyjVFudH5F6U=;
        b=SfArnc0+xNzn29sd2K0MJqGfoavPErfp9ghdga2l3X2eKZtfQSx47HWQif/HP/Lryg
         sctqj3Bd3Ge5eMuoHk2VVCWfzau0dhHBpRio70Wxx0mBnIdS+hUSrT2UJ7nzKxNrz9vx
         fPjP29yp0LceY5Qkz9AvsiA8Xcvk/SNgaV4LpdhPJaiyPi9Ei4N2dtXPZxwGL4TQWNcQ
         cJ3oVEF9Oymk3ZumssoBMT1W6OPPLcn+9zoSjkJvgEZTlzBVsyaKrC9jI6UuTcJq7Wpv
         U6gsza7sOWjKsUDbDcDE7SEN52rKMtGyo1bUT/Q4gGeOid/Ms9VHnjebeqIUgpV/Sjk+
         BVjA==
X-Forwarded-Encrypted: i=1; AFNElJ8IbAHny2KVPhOgwP9P5Hx/wHYkO0i1q2Q2ciXvhUtL/YFMm3182ZPIZX35+B3poH268AA8FjTlk+2F1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkj80B8o+/5oe69zLOo5DqXqdVGv4Nz/UCswqUlCqR7k2DQDD/
	DueCtwnJBmkmHRpiL3upne7Ki9FT7/fR6kDa7eJVk5QSn8MA2/pcXgwC
X-Gm-Gg: AeBDieuwMeQZe2yQT7L67ni91SOGEtFof+qAF1wCKn9pPhD+SPShKyJ/eBjjxxC+iQm
	0/9zcB9D3YXtqnc/kBlo0H4eZge4bXZaZiqPuUFfyZarQxpexIka1rHP/D2qLaT8iL7IsUXnsWG
	/PvyhTKi8qb40mXfrkkUcY1+0+Vm6i2fv4cB580YyHg63MDv5wAbaxjV8KASqltLQxfLy9Fr31s
	3J7/5ZR7b9UPwM1fyqExaF2MLrqmGTtfY7OyoCCPGBV301p17cRcTENoZY1EB0gh2lGLXVLXJ49
	7vBK2gjwP6Vm7XdbPHJpt3c7mAyg0GvpiAuMnesr9u7ODws4ArfB9azT2VP3FzJSg1V7a6tFOSm
	5KO1kf2+eJLot+zGKT4Lx6C554idxCqknbPC1Pbhi9Jygw1q2Rh0lDpEXoVfql4oWEft4v5sVYY
	R/VOcV8ZS5BpEL2sJZe/NA2Ryutp8Yz63X8AB5mg2RW2zg97Gxm4AvnxHQkGz9XPlqZoMRrsbBL
	6Z1rpcggqFyoFw=
X-Received: by 2002:a05:7300:d717:b0:2e2:a64b:63b5 with SMTP id 5a478bee46e88-2e479c08fa4mr5027351eec.18.1776572790122;
        Sat, 18 Apr 2026 21:26:30 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53dcb487bsm8796469eec.31.2026.04.18.21.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 21:26:29 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Lambert Fan <fanzhaoming@anopc.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] HID: hid-oxp: Add Vibration Intensity Attribute
Date: Sat, 18 Apr 2026 21:26:24 -0700
Message-ID: <20260419042624.625746-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419042624.625746-1-derekjohn.clark@gmail.com>
References: <20260419042624.625746-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds attribute for setting the rumble intensity level. This setting must
be re-applied after the gamepad mode is set as doing so resets this to
the default value.

Reviewed-by: Zhouwang Huang <honjow311@gmail.com>
Tested-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-oxp.c | 78 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 52002d4cbd0b..20a54f337220 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -34,6 +34,7 @@ enum oxp_function_index {
 	OXP_FID_GEN1_RGB_SET =		0x07,
 	OXP_FID_GEN1_RGB_REPLY =	0x0f,
 	OXP_FID_GEN2_TOGGLE_MODE =	0xb2,
+	OXP_FID_GEN2_RUMBLE_SET =	0xb3,
 	OXP_FID_GEN2_KEY_STATE =	0xb4,
 	OXP_FID_GEN2_STATUS_EVENT =	0xb8,
 };
@@ -181,6 +182,7 @@ static struct oxp_hid_cfg {
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
 	u8 rgb_brightness;
 	u8 gamepad_mode;
+	u8 rumble_intensity;
 	u8 rgb_effect;
 	u8 rgb_speed;
 	u8 rgb_en;
@@ -266,6 +268,11 @@ static const char *const oxp_rgb_effect_text[] = {
 	[OXP_EFFECT_MONO_LIST] = "monocolor",
 };
 
+enum oxp_rumble_side_index {
+	OXP_RUMBLE_LEFT = 0x00,
+	OXP_RUMBLE_RIGHT,
+};
+
 struct oxp_gen_1_rgb_report {
 	u8 report_id;
 	u8 message_id;
@@ -341,6 +348,7 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
 
 static int oxp_gen_2_property_out(enum oxp_function_index fid, u8 *data, u8 data_size);
 static int oxp_set_buttons(void);
+static int oxp_rumble_intensity_set(u8 intensity);
 
 static void oxp_mcu_init_fn(struct work_struct *work)
 {
@@ -368,6 +376,12 @@ static void oxp_mcu_init_fn(struct work_struct *work)
 	if (ret)
 		dev_err(&drvdata.hdev->dev,
 			"Error: Failed to set gamepad mode: %i\n", ret);
+
+	/* Set vibration level */
+	ret = oxp_rumble_intensity_set(drvdata.rumble_intensity);
+	if (ret)
+		dev_err(&drvdata.hdev->dev,
+			"Error: Failed to set rumble intensity: %i\n", ret);
 }
 
 static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
@@ -514,6 +528,14 @@ static ssize_t gamepad_mode_store(struct device *dev,
 
 	drvdata.gamepad_mode = data[0];
 
+	if (drvdata.gamepad_mode == OXP_GP_MODE_DEBUG)
+		return count;
+
+	/* Re-apply rumble settings as switching gamepad mode will override */
+	ret = oxp_rumble_intensity_set(drvdata.rumble_intensity);
+	if (ret)
+		return ret;
+
 	return count;
 }
 
@@ -857,6 +879,59 @@ static ssize_t button_mapping_options_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(button_mapping_options);
 
+static int oxp_rumble_intensity_set(u8 intensity)
+{
+	u8 header[15] = { 0x02, 0x38, 0x02, 0xe3, 0x39, 0xe3, 0x39, 0xe3,
+			  0x39, 0x01, intensity, 0x05, 0xe3, 0x39, 0xe3 };
+	u8 footer[9] = { 0x39, 0xe3, 0x39, 0xe3, 0xe3, 0x02, 0x04, 0x39, 0x39 };
+	size_t footer_size = ARRAY_SIZE(footer);
+	size_t header_size = ARRAY_SIZE(header);
+	u8 data[59] = { 0x0 };
+	size_t data_size = ARRAY_SIZE(data);
+
+	memcpy(data, header, header_size);
+	memcpy(data + data_size - footer_size, footer, footer_size);
+
+	return oxp_gen_2_property_out(OXP_FID_GEN2_RUMBLE_SET, data, data_size);
+}
+
+static ssize_t rumble_intensity_store(struct device *dev,
+				      struct device_attribute *attr, const char *buf,
+				      size_t count)
+{
+	int ret;
+	u8 val;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val < 0 || val > 5)
+		return -EINVAL;
+
+	ret = oxp_rumble_intensity_set(val);
+	if (ret)
+		return ret;
+
+	drvdata.rumble_intensity = val;
+
+	return count;
+}
+
+static ssize_t rumble_intensity_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%i\n", drvdata.rumble_intensity);
+}
+static DEVICE_ATTR_RW(rumble_intensity);
+
+static ssize_t rumble_intensity_range_show(struct device *dev,
+					   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0-5\n");
+}
+static DEVICE_ATTR_RO(rumble_intensity_range);
+
 #define OXP_DEVICE_ATTR_RW(_name, _group)                                     \
 	static ssize_t _name##_store(struct device *dev,                      \
 				     struct device_attribute *attr,           \
@@ -948,6 +1023,8 @@ static struct attribute *oxp_cfg_attrs[] = {
 	&dev_attr_gamepad_mode.attr,
 	&dev_attr_gamepad_mode_index.attr,
 	&dev_attr_reset_buttons.attr,
+	&dev_attr_rumble_intensity.attr,
+	&dev_attr_rumble_intensity_range.attr,
 	NULL,
 };
 
@@ -1422,6 +1499,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 	INIT_DELAYED_WORK(&drvdata.oxp_btn_queue, oxp_btn_queue_fn);
 
 	drvdata.gamepad_mode = OXP_GP_MODE_XINPUT;
+	drvdata.rumble_intensity = 5;
 
 	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
 	mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
-- 
2.53.0

