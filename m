Received: from mta0.migadu.com (out-109.mta0.migadu.com [91.218.175.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88474B04AF
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503238; cv=none; b=i93E9T1iBXegtwBRneLSLOOgqQbNBkhJVcaA38HydUAc8VH78ULAITUFP56PhPCMOIqDglSypKtPWRYwiDMT8LMwYgAVdMNRG8irsbk4mmjo35ChInDzVmh7wd3iKG4P0F/D8/0r5trhOBqw4I8O631T8mG6CMcHvXJ0Cq1K0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503238; c=relaxed/simple;
	bh=MPnjeuLtkQdWAxblm1GBwf6w+yKYeE8O5+Q/uDueeLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akhwATnLpQyedZhgHv6dm+EKcXYMG336aCBhu8yymuIlj+r9lRdo0EvyeMWkIP9Jucv6uzvOfhq5Chuesx6nhRsvlnoOfbp8A9m/lRonNNfqeHASuW/Y4OfI/+cC1PS5we1UduqiqEJk3WdfrLb4RvDzm4zyt1/lLyryOhJjbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UYhx5zjw; arc=none smtp.client-ip=91.218.175.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UYhx5zjw"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MPnjeuLtkQdWAxblm1GBwf6w+yKYeE8O5+Q/uDueeLo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789503234; v=1; x=1790108034;
 b=UYhx5zjwTAB86bvKoyQOebGcBn/LS4B1B43J2SdFlt4iwAJXTjpJNF7S9Kxu4YaFYxOekkYT
 +BcPx2QFfbfPhFg3qY3PNwLu23metwt6FsYCD2r2E33b2FsdjgAeKIMQ2zQLR377SYGY3Xb4y8j
 G5UQV5+ORls/B/F6yfSSu14U=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a33ca7eb93f79ad6;
	Tue, 15 Sep 2026 20:13:53 +0000
X-Mizu-Trace-ID: a33ca7eb93f79ad6
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
Subject: [PATCH v7 06/12] HID: asus: add triggers inner and outer range configuration
Date: Tue, 15 Sep 2026 20:13:08 +0000
Message-ID: <20260915201314.28279-7-denis.benato@linux.dev>
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

ROG Ally devices allows configuring inner and outer ranges for triggers
buttons on the back: allow userspace to configure the sensitivity by
exposing sysfs attributes.

Assisted-by: opencode:glm-5.2
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 385 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 385 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 9af289905ada..4bb1126c5358 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1360,6 +1360,349 @@ static struct device_attribute dev_attr_right_joystick_outer_threshold =
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
@@ -1393,6 +1736,22 @@ static struct attribute *right_joystick_axis_attrs[] = {
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
@@ -1424,9 +1783,21 @@ static const struct attribute_group ally_right_joystick_axis_group = {
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
@@ -1471,6 +1842,10 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
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
@@ -1858,6 +2233,16 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
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

