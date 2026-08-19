Received: from mta0.migadu.com (out-52.mta0.migadu.com [91.218.175.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18E3D566B
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169536; cv=none; b=f7lECvxk4lQImtqXhhwZmRTaVGTLXeGTPpaabXOG5t8uR/lvz5Nu5vVTzUlVclfMWDIeGQXhx93JPFjjD/WemMUf5Jw9Q7txtH8kMmZeBlG8gGO/BJP55Nq94FtQd6QNYEp/nzSPjvCdVRQ1+GW9wWnC5NKxF6Ng2PGYaEE4BW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169536; c=relaxed/simple;
	bh=3q//mfKfaApC4RSozfzj01CI0XHWQ4Nuy97suXfuJRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7VwR9BkHd1dc02fRLuxyhF31EUpsr5P3M+HD7rhSaSYBQmRwaIYPLHtLJbUzlMQn9K7k1WWZ7yn+8hf3B40sfMiSIIrt/FLYZ4kowRQC2CxEBrdMMTZ4t1rOt9GcdzK50NmixzXwIfqj19I3Aeu5wEjcuOQDICXDJ2avm0P8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ajWtNo/g; arc=none smtp.client-ip=91.218.175.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ajWtNo/g"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3q//mfKfaApC4RSozfzj01CI0XHWQ4Nuy97suXfuJRc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787169530; v=1; x=1787774330;
 b=ajWtNo/gFZFaG2L91KssjEnC1JQKuFeLKHQj8Ik2fiyfEiFrgu9meviEFeCbfV1mKgLRkMQQ
 jkKWlJdESI7NwSh+RedckkZABgulM7BF6G5vOR+9c17ZOttPYmhdYVxAcDCFj3yCm801goAVJHk
 BPclSDy1hV3mQapW9+a9bM4k=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id bc662858264970f7;
	Wed, 19 Aug 2026 19:58:50 +0000
X-Mizu-Trace-ID: bc662858264970f7
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
Subject: [PATCH v2 06/12] HID: asus: add triggers inner and outer range configuration
Date: Wed, 19 Aug 2026 19:58:29 +0000
Message-ID: <20260819195835.1649657-7-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260819195835.1649657-1-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
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

Assisted-by: opencode:glm-5.2
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 345 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 345 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d028697f61bf..23a0cec2de15 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1247,6 +1247,323 @@ static struct device_attribute dev_attr_right_joystick_outer_threshold =
 static struct device_attribute dev_attr_right_joystick_outer_threshold_range =
 	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_range_show, NULL);
 
+/**
+ * ally_set_trigger_ranges() - Generic function to set triggers ranges
+ * @hdev: HID device
+ * @cfg: ally config
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
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	scoped_guard(mutex, &cfg->config_mutex)
+		return sysfs_emit(buf, "%u\n", cfg->left_trigger_min);
+}
+
+static ssize_t left_trigger_range_lower_limit_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
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
+	scoped_guard(mutex, &cfg->config_mutex) {
+		ret = ally_set_trigger_ranges(hdev, cfg,
+					      value,
+					      cfg->left_trigger_max,
+					      cfg->right_trigger_min,
+					      cfg->right_trigger_max);
+		if (ret)
+			return ret;
+
+		cfg->left_trigger_min = value;
+	}
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
+	scoped_guard(mutex, &cfg->config_mutex)
+		return sysfs_emit(buf, "%u\n", cfg->right_trigger_max);
+}
+
+static ssize_t right_trigger_range_upper_limit_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
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
+	scoped_guard(mutex, &cfg->config_mutex) {
+		ret = ally_set_trigger_ranges(hdev, cfg,
+					      cfg->left_trigger_min,
+					      cfg->left_trigger_max,
+					      cfg->right_trigger_min,
+					      value);
+		if (ret)
+			return ret;
+
+		cfg->right_trigger_max = value;
+	}
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
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	scoped_guard(mutex, &cfg->config_mutex)
+		return sysfs_emit(buf, "%u\n", cfg->right_trigger_min);
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
+	scoped_guard(mutex, &cfg->config_mutex) {
+		ret = ally_set_trigger_ranges(hdev, cfg,
+					      cfg->left_trigger_min,
+					      cfg->left_trigger_max,
+					      value,
+					      cfg->right_trigger_max);
+		if (ret)
+			return ret;
+
+		cfg->right_trigger_min = value;
+	}
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
+	scoped_guard(mutex, &cfg->config_mutex)
+		return sysfs_emit(buf, "%u\n", cfg->left_trigger_max);
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
+	scoped_guard(mutex, &cfg->config_mutex) {
+		ret = ally_set_trigger_ranges(hdev, cfg,
+					      cfg->left_trigger_min,
+					      value,
+					      cfg->right_trigger_min,
+					      cfg->right_trigger_max);
+		if (ret)
+			return ret;
+
+		cfg->left_trigger_max = value;
+	}
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
@@ -1280,6 +1597,22 @@ static struct attribute *right_joystick_axis_attrs[] = {
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
@@ -1300,6 +1633,14 @@ static const struct attribute_group ally_attr_groups[] = {
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
@@ -1340,6 +1681,10 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 	cfg->left_outer_threshold = 90;
 	cfg->right_deadzone = 10;
 	cfg->right_outer_threshold = 90;
+	cfg->left_trigger_min = 0;
+	cfg->left_trigger_max = 100;
+	cfg->right_trigger_min = 0;
+	cfg->right_trigger_max = 100;
 	cfg->vibration_intensity_left = 100;
 	cfg->vibration_intensity_right = 100;
 
-- 
2.47.3

