Received: from mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581C563282
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118138; cv=none; b=TFylxyM7QRMSJ87CISMOGVID1fk1Jco/y7xpIc0RCUv9GSsazvjKqcbn8aidaoB/xAdLH7QF/fqBDHatGnHwriyvGWRZL/Mmgekxuhe1vLH+aA5tXwpMTDs/P2geqIvTotoybT6cyrVxxg43CPMY2piQFB2HBFMav7ii0+Gl2DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118138; c=relaxed/simple;
	bh=Z4Q38JeB6St4hArsI3Zzk1K/95oKNYz7ZFVaAOerUQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq/zkxEKrcWlqOPO4tChDHc7v4GtSU3EC8qgqCrcxagS3vQnsBplfZUCiv3angH7SJ7gC2nSOxjB1W38gcjEU+iWR3n5rdvGPJ2SJT9ugPSdzf7GVLGmxpN3tO9hnxrn40owFVJtrKRAPogckSMvERIeNn/s8zqZiYO55VWCXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fif4r4g0; arc=none smtp.client-ip=91.218.175.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fif4r4g0"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z4Q38JeB6St4hArsI3Zzk1K/95oKNYz7ZFVaAOerUQw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790118133; v=1; x=1790722933;
 b=fif4r4g062TWOh2+bwFQT93ANDpHI+HZpZo9WJyVj7914hvGyDfQaBfBx4HPOX3RzJx21jN7
 o+hqh3Awtsu0WDEQOciQyR6bp1KEeiz1F5DX+fbuGtUdYr+Moau/C9Q9EW7eZnPLrDizX0ZPNo1
 ZbuX8GydAIL6RzCfd+DMxcFU=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b676b71dfa5e1cae;
	Tue, 22 Sep 2026 23:02:13 +0000
X-Mizu-Trace-ID: b676b71dfa5e1cae
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
Subject: [PATCH v8 06/12] HID: asus: add triggers inner and outer range configuration
Date: Tue, 22 Sep 2026 23:01:59 +0000
Message-ID: <20260922230205.6847-7-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922230205.6847-1-denis.benato@linux.dev>
References: <20260922230205.6847-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ROG Ally devices allows configuring inner and outer ranges for triggers
buttons on the back: allow userspace to configure the sensitivity by
exposing sysfs attributes.

Assisted-by: opencode:glm-5.2
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 393 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 393 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 354579a11f60..3affb0e39e50 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1382,6 +1382,357 @@ static struct device_attribute dev_attr_right_joystick_outer_threshold =
 static struct device_attribute dev_attr_right_joystick_outer_threshold_range =
 	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_range_show, NULL);
 
+/**
+ * ally_set_trigger_ranges() - Generic function to set triggers ranges
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @left_it: lower limit of the left trigger range (0-50)
+ * @left_ot: upper limit of the left trigger range (70-100)
+ * @right_it: lower limit of the right trigger range (0-50)
+ * @right_ot: upper limit of the right trigger range (70-100)
+ *
+ * This function sends the command to set both inner and outer threshold
+ * for the left and right triggers.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_set_trigger_ranges(struct ally_handheld *ally,
+				   struct hid_device *hdev,
+				   u8 left_it, u8 left_ot, u8 right_it, u8 right_ot)
+{
+	const u8 payload[] = { left_it, left_ot, right_it, right_ot };
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_TRIGGER_RANGE, payload, sizeof(payload));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set trigger ranges: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t left_trigger_range_lower_limit_show(struct device *dev,
+						   struct device_attribute *attr, char *buf)
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
+	if (!cfg->user_cal_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", cfg->left_trigger_min);
+}
+
+static ssize_t left_trigger_range_lower_limit_store(struct device *dev,
+						    struct device_attribute *attr,
+						    const char *buf, size_t count)
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
+	if (ret || value > 50)
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->user_cal_support)
+		return -EOPNOTSUPP;
+
+	ret = ally_set_trigger_ranges(ally, hdev,
+				      value,
+				      cfg->left_trigger_max,
+				      cfg->right_trigger_min,
+				      cfg->right_trigger_max);
+	if (ret)
+		return ret;
+
+	cfg->left_trigger_min = value;
+
+	sysfs_notify(&dev->kobj, "left_trigger", "range_lower_limit");
+
+	return count;
+}
+
+static ssize_t left_trigger_range_lower_limit_range_show(struct device *dev,
+							 struct device_attribute *attr,
+							 char *buf)
+{
+	return sysfs_emit(buf, "0 50\n");
+}
+
+static ssize_t right_trigger_range_upper_limit_show(struct device *dev,
+						    struct device_attribute *attr, char *buf)
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
+	if (!cfg->user_cal_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", cfg->right_trigger_max);
+}
+
+static ssize_t right_trigger_range_upper_limit_store(struct device *dev,
+						     struct device_attribute *attr,
+						     const char *buf, size_t count)
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
+	if (ret || value < 70 || value > 100)
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->user_cal_support)
+		return -EOPNOTSUPP;
+
+	ret = ally_set_trigger_ranges(ally, hdev,
+				      cfg->left_trigger_min,
+				      cfg->left_trigger_max,
+				      cfg->right_trigger_min,
+				      value);
+	if (ret)
+		return ret;
+
+	cfg->right_trigger_max = value;
+
+	sysfs_notify(&dev->kobj, "right_trigger", "range_upper_limit");
+
+	return count;
+}
+
+static ssize_t right_trigger_range_upper_limit_range_show(struct device *dev,
+							  struct device_attribute *attr,
+							  char *buf)
+{
+	return sysfs_emit(buf, "70 100\n");
+}
+
+static ssize_t right_trigger_range_lower_limit_show(struct device *dev,
+						    struct device_attribute *attr, char *buf)
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
+	if (!cfg->user_cal_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", cfg->right_trigger_min);
+}
+
+static ssize_t right_trigger_range_lower_limit_store(struct device *dev,
+						     struct device_attribute *attr,
+						     const char *buf, size_t count)
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
+	if (ret || value > 50)
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->user_cal_support)
+		return -EOPNOTSUPP;
+
+	ret = ally_set_trigger_ranges(ally, hdev,
+				      cfg->left_trigger_min,
+				      cfg->left_trigger_max,
+				      value,
+				      cfg->right_trigger_max);
+	if (ret)
+		return ret;
+
+	cfg->right_trigger_min = value;
+
+	sysfs_notify(&dev->kobj, "right_trigger", "range_lower_limit");
+
+	return count;
+}
+
+static ssize_t right_trigger_range_lower_limit_range_show(struct device *dev,
+							  struct device_attribute *attr,
+							  char *buf)
+{
+	return sysfs_emit(buf, "0 50\n");
+}
+
+static ssize_t left_trigger_range_upper_limit_show(struct device *dev,
+						   struct device_attribute *attr,
+						   char *buf)
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
+	if (!cfg->user_cal_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", cfg->left_trigger_max);
+}
+
+static ssize_t left_trigger_range_upper_limit_store(struct device *dev,
+						    struct device_attribute *attr,
+						    const char *buf, size_t count)
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
+	if (ret || value < 70 || value > 100)
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->user_cal_support)
+		return -EOPNOTSUPP;
+
+	ret = ally_set_trigger_ranges(ally, hdev,
+				      cfg->left_trigger_min,
+				      value,
+				      cfg->right_trigger_min,
+				      cfg->right_trigger_max);
+	if (ret)
+		return ret;
+
+	cfg->left_trigger_max = value;
+
+	sysfs_notify(&dev->kobj, "left_trigger", "range_upper_limit");
+
+	return count;
+}
+
+static ssize_t left_trigger_range_upper_limit_range_show(struct device *dev,
+							 struct device_attribute *attr,
+							 char *buf)
+{
+	return sysfs_emit(buf, "70 100\n");
+}
+
+static struct device_attribute dev_attr_left_trigger_range_lower_limit =
+	__ATTR(range_lower_limit, 0644, left_trigger_range_lower_limit_show,
+	       left_trigger_range_lower_limit_store);
+
+static struct device_attribute dev_attr_left_trigger_range_lower_limit_range =
+	__ATTR(range_lower_limit_range, 0444, left_trigger_range_lower_limit_range_show, NULL);
+
+static struct device_attribute dev_attr_left_trigger_range_upper_limit =
+	__ATTR(range_upper_limit, 0644, left_trigger_range_upper_limit_show,
+	       left_trigger_range_upper_limit_store);
+
+static struct device_attribute dev_attr_left_trigger_range_upper_limit_range =
+	__ATTR(range_upper_limit_range, 0444, left_trigger_range_upper_limit_range_show, NULL);
+
+static struct device_attribute dev_attr_right_trigger_range_lower_limit =
+	__ATTR(range_lower_limit, 0644, right_trigger_range_lower_limit_show,
+	       right_trigger_range_lower_limit_store);
+
+static struct device_attribute dev_attr_right_trigger_range_lower_limit_range =
+	__ATTR(range_lower_limit_range, 0444, right_trigger_range_lower_limit_range_show, NULL);
+
+static struct device_attribute dev_attr_right_trigger_range_upper_limit =
+	__ATTR(range_upper_limit, 0644, right_trigger_range_upper_limit_show,
+	       right_trigger_range_upper_limit_store);
+
+static struct device_attribute dev_attr_right_trigger_range_upper_limit_range =
+	__ATTR(range_upper_limit_range, 0444, right_trigger_range_upper_limit_range_show, NULL);
+
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
 	NULL
@@ -1415,6 +1766,22 @@ static struct attribute *right_joystick_axis_attrs[] = {
 	NULL
 };
 
+static struct attribute *left_trigger_attrs[] = {
+	&dev_attr_left_trigger_range_lower_limit.attr,
+	&dev_attr_left_trigger_range_upper_limit.attr,
+	&dev_attr_left_trigger_range_lower_limit_range.attr,
+	&dev_attr_left_trigger_range_upper_limit_range.attr,
+	NULL
+};
+
+static struct attribute *right_trigger_attrs[] = {
+	&dev_attr_right_trigger_range_lower_limit.attr,
+	&dev_attr_right_trigger_range_upper_limit.attr,
+	&dev_attr_right_trigger_range_lower_limit_range.attr,
+	&dev_attr_right_trigger_range_upper_limit_range.attr,
+	NULL
+};
+
 static const struct attribute_group ally_attr_groups[] = {
 	{
 		.attrs = ally_config_attrs,
@@ -1446,9 +1813,21 @@ static const struct attribute_group ally_right_joystick_axis_group = {
 	.attrs = right_joystick_axis_attrs,
 };
 
+static const struct attribute_group ally_left_trigger_group = {
+	.name = "left_trigger",
+	.attrs = left_trigger_attrs,
+};
+
+static const struct attribute_group ally_right_trigger_group = {
+	.name = "right_trigger",
+	.attrs = right_trigger_attrs,
+};
+
 static const struct attribute_group *const ally_cal_attr_groups[] = {
 	&ally_left_joystick_axis_group,
 	&ally_right_joystick_axis_group,
+	&ally_left_trigger_group,
+	&ally_right_trigger_group,
 };
 
 /**
@@ -1493,6 +1872,10 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 		cfg->left_outer_threshold = 90;
 		cfg->right_deadzone = 10;
 		cfg->right_outer_threshold = 90;
+		cfg->left_trigger_min = 0;
+		cfg->left_trigger_max = 100;
+		cfg->right_trigger_min = 0;
+		cfg->right_trigger_max = 100;
 		cfg->vibration_intensity_left = 100;
 		cfg->vibration_intensity_right = 100;
 	}
@@ -1880,6 +2263,16 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 			hid_warn(hdev,
 					 "Failed to restore joystick thresholds: %d\n",
 					 ret);
+
+		ret = ally_set_trigger_ranges(ally, hdev,
+					      cfg->left_trigger_min,
+					      cfg->left_trigger_max,
+					      cfg->right_trigger_min,
+					      cfg->right_trigger_max);
+		if (ret < 0)
+			hid_warn(hdev,
+					 "Failed to restore trigger ranges: %d\n",
+					 ret);
 	}
 
 	return 0;
-- 
2.47.3

