Received: from mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAFB481FBF
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632471; cv=none; b=aku83aHKahIrZgeBmf50BWvh0wyL7CXK3pBPCe4hMXRM7sPBOjGNvk4l+w0O/YUoVcVYdhKBXu9wNDW14fyfK72gaiMzPSFciOsxkQ4yrvu60spAnZJwIQs8qoWOcdNvuhN50gbet2ZEcTXkc8h41yfpMmXX2/ISEFxi+cW+CK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632471; c=relaxed/simple;
	bh=CcKCfuUSiYcltdyiO06m3LyDVZhPoUpXmzMlciHMuTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzQttmijGfh444WdqSWWE87uLzzkI9aNDcgDRj9Epd6zgipLVv4YKLT/U/S2YJUP6X+LwzdHFbnIykWMGMSZGmBGK1rvRXbvw5CWw5fVK1QyMKb++l4ijzNucG4gZoHXRUAXAK0vHfgIrtDKXKOsWmsPT4BrZfNNqAPNMUEEwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W8lIHSsq; arc=none smtp.client-ip=95.215.58.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W8lIHSsq"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CcKCfuUSiYcltdyiO06m3LyDVZhPoUpXmzMlciHMuTE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632464; v=1; x=1787237264;
 b=W8lIHSsqsg5enlC8O91om+51fW3pcySX4TMVc/48PaUltnTAUlfdPkxMek3Sq4DrBJuH6oN1
 aAZ+4bupHh5tnNsUNPNg9Hj8K+itGtzuu6EXqYZpittC3w4tTDlr26RpgUcngI77jJv34MYBUWf
 PvYXqOIGA9mqodFBIVl/O0vQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 0342368e285b731b;
	Thu, 13 Aug 2026 14:47:44 +0000
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
Subject: [PATCH 06/12] HID: asus: add triggers inner and outer range configuration
Date: Thu, 13 Aug 2026 14:47:30 +0000
Message-ID: <20260813144736.2477941-7-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813144736.2477941-1-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ROG Ally devices allows configuring inner and outer ranges for triggers
buttons on the back: allow userspace to configure the sesitivity by
exposing sysfs attributes.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 298 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 298 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 010b33533068..eb735ec8f065 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1155,6 +1155,276 @@ static struct device_attribute dev_attr_right_joystick_outer_threshold =
 static struct device_attribute dev_attr_right_joystick_outer_threshold_range =
 	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_range_show, NULL);
 
+/**
+ * ally_set_trigger_ranges() - Generic function to set triggers ranges
+ *
+ * This function send the command to set both inner and outer threshold for
+ * the left and right triggers.
+ *
+ * @hdev: HID device
+ * @cfg: Ally config
+ * @left_it: lower limit of the left trigger range (0-50)
+ * @left_ot: upper limit of the left trigger range (70-100)
+ * @right_it: lower limit of the right trigger range (0-50)
+ * @right_ot: upper limit of the right trigger range (70-100)
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+static int ally_set_trigger_ranges(struct hid_device *hdev, struct ally_config *cfg,
+				   u8 left_it, u8 left_ot, u8 right_it, u8 right_ot)
+{
+	const u8 payload[] = { left_it, left_ot, right_it, right_ot };
+	int ret;
+
+	if (!cfg->xbox_controller_support)
+		return -ENODEV;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_TRIGGER_RANGE, payload, sizeof(payload));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_dev_set_report(hdev, buf, ROG_ALLY_REPORT_SIZE);
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
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", ally->config->left_trigger_min);
+}
+
+static ssize_t left_trigger_range_lower_limit_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	u8 value;
+	int ret;
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > 50)
+		return -EINVAL;
+
+	ret = ally_set_trigger_ranges(hdev, ally->config,
+					   value,
+					   ally->config->left_trigger_max,
+					   ally->config->right_trigger_min,
+					   ally->config->right_trigger_max);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &ally->config->config_mutex)
+		ally->config->left_trigger_min = value;
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
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", ally->config->right_trigger_max);
+}
+
+static ssize_t right_trigger_range_upper_limit_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	u8 value;
+	int ret;
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value < 70 || value > 100)
+		return -EINVAL;
+
+	ret = ally_set_trigger_ranges(hdev, ally->config,
+					   ally->config->left_trigger_min,
+					   ally->config->left_trigger_max,
+					   ally->config->right_trigger_min,
+					   value);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &ally->config->config_mutex)
+		ally->config->right_trigger_max = value;
+
+	return count;
+}
+
+static ssize_t right_trigger_range_upper_limit_range_show(struct device *dev,
+							 struct device_attribute *attr,
+							 char *buf)
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
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", ally->config->right_trigger_min);
+}
+
+static ssize_t right_trigger_range_lower_limit_store(struct device *dev,
+						     struct device_attribute *attr,
+						     const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	u8 value;
+	int ret;
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > 50)
+		return -EINVAL;
+
+	ret = ally_set_trigger_ranges(hdev, ally->config,
+					   ally->config->left_trigger_min,
+					   ally->config->left_trigger_max,
+					   value,
+					   ally->config->right_trigger_max);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &ally->config->config_mutex)
+		ally->config->right_trigger_min = value;
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
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", ally->config->left_trigger_max);
+}
+
+static ssize_t left_trigger_range_upper_limit_store(struct device *dev,
+						    struct device_attribute *attr,
+						    const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	u8 value;
+	int ret;
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value < 70 || value > 100)
+		return -EINVAL;
+
+	ret = ally_set_trigger_ranges(hdev, ally->config,
+					   ally->config->left_trigger_min,
+					   value,
+					   ally->config->right_trigger_min,
+					   ally->config->right_trigger_max);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &ally->config->config_mutex)
+		ally->config->left_trigger_max = value;
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
@@ -1188,6 +1458,22 @@ static struct attribute *right_joystick_axis_attrs[] = {
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
@@ -1208,6 +1494,14 @@ static const struct attribute_group ally_attr_groups[] = {
 		.name = "right_joystick_axis",
 		.attrs = right_joystick_axis_attrs,
 	},
+	{
+		.name = "left_trigger",
+		.attrs = left_trigger_attrs,
+	},
+	{
+		.name = "right_trigger",
+		.attrs = right_trigger_attrs,
+	},
 };
 
 /**
@@ -1246,6 +1540,10 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 	cfg->left_outer_threshold = 90;
 	cfg->right_deadzone = 10;
 	cfg->right_outer_threshold = 90;
+	cfg->left_trigger_min = 0;
+	cfg->left_trigger_max = 100;
+	cfg->right_trigger_min = 0;
+	cfg->right_trigger_max = 100;
 	cfg->vibration_intensity_left = 100;
 	cfg->vibration_intensity_right = 100;
 	cfg->vibration_active = false;
-- 
2.47.3

