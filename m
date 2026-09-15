Received: from mta0.migadu.com (out-113.mta0.migadu.com [91.218.175.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144E04C14EF
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503239; cv=none; b=MP1SbAtisaWfs8TrOL2V8AG6zKrSXRFHKwYG+4rovU4ivUKmsDwyGuSw0ChqvHNlLGLOd9jRvPs8e6omRjY0U0RdfjUAfQBYFkHotZCuM5pJHbpVxjP9AmDyxTuT4ktlmP0ecK/0eO4GaHjQsBgV1PA9olhxsIEMqhXhC47/c+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503239; c=relaxed/simple;
	bh=odBJYTT8WBv5GpvT8m1YswwMJ4uCdlKY6hYLqgteGcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuHrEtqAZTfPWE0nhsii1p0IpplqCHSvEQSM0PF2/bsRIyhwi51Aqg4pgBXPZOQ1Cow80OOmPqo4h4ra0o1jy/J2PmSfX/mGpdt+hF5NAXesg7E2zHaxmMQFHbTJSAi3BDUq4c6NAzzZ8TZSp5TCW/mm0CuClVz3uaorTZvMXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KuYXQpnq; arc=none smtp.client-ip=91.218.175.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KuYXQpnq"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=odBJYTT8WBv5GpvT8m1YswwMJ4uCdlKY6hYLqgteGcE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789503234; v=1; x=1790108034;
 b=KuYXQpnqjIg3sQAJ07JjVsM3W03y6ATTV/W5uGheXSPn1Ytmscxi37QVNzN0eKhN9rLxTMGJ
 CBZY6aCxqNzjoSPhNU3HeLzRKkeX7lqFfQJJbwzs0gMYdrF+wnYpZXGgOUZuW72o7wLt9Tsq7t2
 Igaff9KONgH+qul+IX+I0HcU=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 40756d333220a4ff;
	Tue, 15 Sep 2026 20:13:54 +0000
X-Mizu-Trace-ID: 40756d333220a4ff
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v7 07/12] HID: asus: add joysticks anti-deadzone configuration
Date: Tue, 15 Sep 2026 20:13:09 +0000
Message-ID: <20260915201314.28279-8-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915201314.28279-1-denis.benato@linux.dev>
References: <20260915201314.28279-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ROG Ally devices allow configuring the anti-deadzone parameter for
the resistive joysticks devices as over time those develops drift,
therefore allow userspace to configure the anti-deadzone by exposing
relevant sysfs attributes.

Assisted-by: opencode:glm-5.2
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 211 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 207 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 4bb1126c5358..b07f9d77103f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1360,6 +1360,193 @@ static struct device_attribute dev_attr_right_joystick_outer_threshold =
 static struct device_attribute dev_attr_right_joystick_outer_threshold_range =
 	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_range_show, NULL);
 
+/**
+ * ally_set_anti_deadzone() - Set anti-deadzone values for joysticks
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @cfg: ally config
+ * @left_adz: left joystick anti-deadzone value (0-100)
+ * @right_adz: right joystick anti-deadzone value (0-100)
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_set_anti_deadzone(struct ally_handheld *ally,
+				  struct hid_device *hdev, struct ally_config *cfg,
+				  u8 left_adz, u8 right_adz)
+{
+	const u8 payload[] = { left_adz, right_adz };
+	int ret;
+
+	if (!cfg->anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_ANTI_DEADZONE, payload, sizeof(payload));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set anti-deadzone values: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t left_joystick_anti_deadzone_show(struct device *dev, struct device_attribute *attr,
+						char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	return sysfs_emit(buf, "%u\n", cfg->left_anti_deadzone);
+}
+
+static ssize_t left_joystick_anti_deadzone_store(struct device *dev, struct device_attribute *attr,
+						 const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+	u8 value;
+	int ret;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > 100)
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = ally_set_anti_deadzone(ally, hdev, cfg, value, cfg->right_anti_deadzone);
+	if (ret)
+		return ret;
+
+	cfg->left_anti_deadzone = value;
+
+	return count;
+}
+
+static ssize_t left_joystick_anti_deadzone_range_show(struct device *dev,
+						      struct device_attribute *attr,
+						      char *buf)
+{
+	return sysfs_emit(buf, "0 100\n");
+}
+
+static ssize_t right_joystick_anti_deadzone_show(struct device *dev, struct device_attribute *attr,
+						 char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	return sysfs_emit(buf, "%u\n", cfg->right_anti_deadzone);
+}
+
+static ssize_t right_joystick_anti_deadzone_store(struct device *dev, struct device_attribute *attr,
+						  const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+	u8 value;
+	int ret;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > 100)
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = ally_set_anti_deadzone(ally, hdev, cfg, cfg->left_anti_deadzone, value);
+	if (ret)
+		return ret;
+
+	cfg->right_anti_deadzone = value;
+
+	return count;
+}
+
+static ssize_t right_joystick_anti_deadzone_range_show(struct device *dev,
+						       struct device_attribute *attr,
+						       char *buf)
+{
+	return sysfs_emit(buf, "0 100\n");
+}
+
+static struct device_attribute dev_attr_left_joystick_anti_deadzone =
+	__ATTR(anti_deadzone, 0644, left_joystick_anti_deadzone_show,
+	       left_joystick_anti_deadzone_store);
+
+static struct device_attribute dev_attr_left_joystick_anti_deadzone_range =
+	__ATTR(anti_deadzone_range, 0444, left_joystick_anti_deadzone_range_show, NULL);
+
+static struct device_attribute dev_attr_right_joystick_anti_deadzone =
+	__ATTR(anti_deadzone, 0644, right_joystick_anti_deadzone_show,
+	       right_joystick_anti_deadzone_store);
+
+static struct device_attribute dev_attr_right_joystick_anti_deadzone_range =
+	__ATTR(anti_deadzone_range, 0444, right_joystick_anti_deadzone_range_show, NULL);
+
 /**
  * ally_set_trigger_ranges() - Generic function to set triggers ranges
  * @ally: ally handheld structure
@@ -1725,6 +1912,8 @@ static struct attribute *left_joystick_axis_attrs[] = {
 	&dev_attr_left_joystick_outer_threshold.attr,
 	&dev_attr_left_joystick_inner_threshold_range.attr,
 	&dev_attr_left_joystick_outer_threshold_range.attr,
+	&dev_attr_left_joystick_anti_deadzone.attr,
+	&dev_attr_left_joystick_anti_deadzone_range.attr,
 	NULL
 };
 
@@ -1733,6 +1922,8 @@ static struct attribute *right_joystick_axis_attrs[] = {
 	&dev_attr_right_joystick_outer_threshold.attr,
 	&dev_attr_right_joystick_inner_threshold_range.attr,
 	&dev_attr_right_joystick_outer_threshold_range.attr,
+	&dev_attr_right_joystick_anti_deadzone.attr,
+	&dev_attr_right_joystick_anti_deadzone_range.attr,
 	NULL
 };
 
@@ -1864,8 +2055,11 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 		}
 	}
 
-	/* Skip the calibration groups when the capability is missing. */
-	if (cfg->user_cal_support) {
+	/*
+	 * Skip the calibration and anti-deadzone groups when none of the
+	 * features they expose is supported.
+	 */
+	if (cfg->user_cal_support || cfg->anti_deadzone_support) {
 		int cal_i;
 
 		for (cal_i = 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups);
@@ -1919,8 +2113,7 @@ static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
 	 * create them, so a device without those capabilities does not
 	 * trigger a "not found" warning.
 	 */
-	if (cfg->user_cal_support || cfg->anti_deadzone_support ||
-	    cfg->resp_curve_support) {
+	if (cfg->user_cal_support || cfg->anti_deadzone_support) {
 		for (i = 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
 			sysfs_remove_group(&hdev->dev.kobj,
 						   ally_cal_attr_groups[i]);
@@ -2245,6 +2438,16 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 					 ret);
 	}
 
+	if (cfg->anti_deadzone_support) {
+		ret = ally_set_anti_deadzone(ally, hdev, cfg,
+					     cfg->left_anti_deadzone,
+					     cfg->right_anti_deadzone);
+		if (ret < 0)
+			hid_warn(hdev,
+					 "Failed to restore anti-deadzone: %d\n",
+					 ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

