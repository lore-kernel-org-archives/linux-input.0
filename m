Received: from mta1.migadu.com (out-43.mta1.migadu.com [95.215.58.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55846483BE3
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632467; cv=none; b=O0yk/SLhpwzvGPsiW6to/BmyGZ7UfXI9eXkNCajZTxlGOhz62l0/eSnfbQZxg01Ui4KGWyvczBudKDKAbhMjFJ/lw27VDEaSAW78pVQZnd+UiVdiqiO8YdIQVOl78Z5Q4vGeuhQcC/fJLqt2KRRUhcNqXRzZbDY/A8W+9i+mayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632467; c=relaxed/simple;
	bh=2X+3Vhue1vhYXfofRj485PDSP80mWTcJTx8ugrr1wZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlE4D/F0t38rL6zJXB9MsiSZkAi+v5MkwWM1zdo8vViJlDJAJEn1Jje/PS2AsFgjBbRdW4O6pa+ZBm2xKGk7zqIoReSCe3cEqBNEFr8RQrpW/i7qdrERT+rQH16FweHHX1E412Mfk6ZWd7AWPdaNhp5XLyNlYDjrTJswN/S7oxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wK9bSpgm; arc=none smtp.client-ip=95.215.58.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wK9bSpgm"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2X+3Vhue1vhYXfofRj485PDSP80mWTcJTx8ugrr1wZk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632463; v=1; x=1787237263;
 b=wK9bSpgmLv+l+5IIFdz5MgeRr476rB0J3sCe9fsYovsxMlrUYPVZBl1SicQBm1nI294mQTng
 EapHQ18On6aohrGYwbagzpnzWn3bEinRHX6TcQapGCqwtDApS0LbnP294WW5q8AtMHjFmu6Q1oj
 nfpaASsCBkg6GrgG2d+j1FtY=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id bd65f4c68b344aa3;
	Thu, 13 Aug 2026 14:47:43 +0000
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
Subject: [PATCH 05/12] HID: asus: add joysticks inner and outer range configuration
Date: Thu, 13 Aug 2026 14:47:29 +0000
Message-ID: <20260813144736.2477941-6-denis.benato@linux.dev>
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

ROG Ally devices supports configuring joysticks inner and outer range:
add sysfs attributes to allow userspace modifying the sensitivity
of those controllers.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 308 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 308 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 48cc867aeea8..010b33533068 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -133,6 +133,19 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
 
+#define ALLY_DEVICE_ATTR_RO(_name, _sysfs_name)    \
+	struct device_attribute dev_attr_##_name = \
+		__ATTR(_sysfs_name, 0444, _name##_show, NULL)
+
+#define ALLY_DEVICE_CONST_ATTR_RO(fname, sysfs_name, value)			\
+	static ssize_t fname##_show(struct device *dev,				\
+				   struct device_attribute *attr, char *buf)	\
+	{									\
+		return sysfs_emit(buf, value);					\
+	}									\
+	struct device_attribute dev_attr_##fname =				\
+		__ATTR(sysfs_name, 0444, fname##_show, NULL)
+
 enum asus_work_action_type {
 	FN_LOCK_SYNC,
 	BRIGHTNESS_SET,
@@ -871,6 +884,277 @@ static struct device_attribute dev_attr_right_vibration_intensity =
 static struct device_attribute dev_attr_right_vibration_intensity_range =
 	__ATTR(intensity_range, 0444, right_vibration_intensity_range_show, NULL);
 
+/**
+ * ally_set_joystick_thresholds() - Generic function to set joystick ranges
+ *
+ * This function send the command to set both inner and outer threshold for
+ * the left and right joysticks.
+ *
+ * @hdev: HID device
+ * @cfg: Ally config
+ * @left_it: inner threshold (deadzone) of the left stick (0-50)
+ * @left_ot: outer threshold of the left stick (70-100)
+ * @right_it: inner threshold (deadzone) of the right stick (0-50)
+ * @right_ot: outer threshold of the right stick (70-100)
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+static int ally_set_joystick_thresholds(struct hid_device *hdev, struct ally_config *cfg,
+					u8 left_it, u8 left_ot, u8 right_it, u8 right_ot)
+{
+	u8 payload[] = { left_it, left_ot, right_it, right_ot };
+	int ret;
+
+	if (!cfg->xbox_controller_support)
+		return -ENODEV;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_JOYSTICK_DEADZONE, payload, sizeof(payload));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_dev_set_report(hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set joystick ranges: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t left_joystick_inner_threshold_show(struct device *dev, struct device_attribute *attr,
+				      char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", ally->config->left_deadzone);
+}
+
+static ssize_t left_joystick_inner_threshold_store(struct device *dev,
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
+	ret = ally_set_joystick_thresholds(hdev, ally->config,
+					   value,
+					   ally->config->left_outer_threshold,
+					   ally->config->right_deadzone,
+					   ally->config->right_outer_threshold);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &ally->config->config_mutex)
+		ally->config->left_deadzone = value;
+
+	return count;
+}
+
+static ssize_t left_joystick_inner_threshold_range_show(struct device *dev,
+							 struct device_attribute *attr,
+							 char *buf)
+{
+	return sysfs_emit(buf, "0 50\n");
+}
+
+static ssize_t left_joystick_outer_threshold_show(struct device *dev, struct device_attribute *attr,
+				      char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", ally->config->left_outer_threshold);
+}
+
+static ssize_t left_joystick_outer_threshold_store(struct device *dev,
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
+	ret = ally_set_joystick_thresholds(hdev, ally->config,
+					   ally->config->left_deadzone,
+					   value,
+					   ally->config->right_deadzone,
+					   ally->config->right_outer_threshold);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &ally->config->config_mutex)
+		ally->config->left_outer_threshold = value;
+
+	return count;
+}
+
+static ssize_t left_joystick_outer_threshold_range_show(struct device *dev,
+							struct device_attribute *attr,
+							char *buf)
+{
+	return sysfs_emit(buf, "70 100\n");
+}
+
+static ssize_t right_joystick_inner_threshold_show(struct device *dev,
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
+	return sysfs_emit(buf, "%u\n", ally->config->right_deadzone);
+}
+
+static ssize_t right_joystick_inner_threshold_store(struct device *dev,
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
+	ret = ally_set_joystick_thresholds(hdev, ally->config,
+					   ally->config->left_deadzone,
+					   ally->config->left_outer_threshold,
+					   value,
+					   ally->config->right_outer_threshold);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &ally->config->config_mutex)
+		ally->config->right_deadzone = value;
+
+	return count;
+}
+
+static ssize_t right_joystick_inner_threshold_range_show(struct device *dev,
+							  struct device_attribute *attr,
+							  char *buf)
+{
+	return sysfs_emit(buf, "0 50\n");
+}
+
+static ssize_t right_joystick_outer_threshold_show(struct device *dev,
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
+	return sysfs_emit(buf, "%u\n", ally->config->right_outer_threshold);
+}
+
+static ssize_t right_joystick_outer_threshold_store(struct device *dev,
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
+	ret = ally_set_joystick_thresholds(hdev, ally->config,
+					   ally->config->left_deadzone,
+					   ally->config->left_outer_threshold,
+					   ally->config->right_deadzone,
+					   value);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &ally->config->config_mutex)
+		ally->config->right_outer_threshold = value;
+
+	return count;
+}
+
+static ssize_t right_joystick_outer_threshold_range_show(struct device *dev,
+							 struct device_attribute *attr,
+							 char *buf)
+{
+	return sysfs_emit(buf, "70 100\n");
+}
+
+static struct device_attribute dev_attr_left_joystick_inner_threshold =
+	__ATTR(inner_threshold, 0644, left_joystick_inner_threshold_show,
+	       left_joystick_inner_threshold_store);
+
+static struct device_attribute dev_attr_left_joystick_inner_threshold_range =
+	__ATTR(inner_threshold_range, 0444, left_joystick_inner_threshold_range_show, NULL);
+
+static struct device_attribute dev_attr_left_joystick_outer_threshold =
+	__ATTR(outer_threshold, 0644, left_joystick_outer_threshold_show,
+	       left_joystick_outer_threshold_store);
+
+static struct device_attribute dev_attr_left_joystick_outer_threshold_range =
+	__ATTR(outer_threshold_range, 0444, left_joystick_outer_threshold_range_show, NULL);
+
+static struct device_attribute dev_attr_right_joystick_inner_threshold =
+	__ATTR(inner_threshold, 0644, right_joystick_inner_threshold_show,
+	       right_joystick_inner_threshold_store);
+
+static struct device_attribute dev_attr_right_joystick_inner_threshold_range =
+	__ATTR(inner_threshold_range, 0444, right_joystick_inner_threshold_range_show, NULL);
+
+static struct device_attribute dev_attr_right_joystick_outer_threshold =
+	__ATTR(outer_threshold, 0644, right_joystick_outer_threshold_show,
+	       right_joystick_outer_threshold_store);
+
+static struct device_attribute dev_attr_right_joystick_outer_threshold_range =
+	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_range_show, NULL);
+
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
 	NULL
@@ -888,6 +1172,22 @@ static struct attribute *ally_right_vibration_attrs[] = {
 	NULL
 };
 
+static struct attribute *left_joystick_axis_attrs[] = {
+	&dev_attr_left_joystick_inner_threshold.attr,
+	&dev_attr_left_joystick_outer_threshold.attr,
+	&dev_attr_left_joystick_inner_threshold_range.attr,
+	&dev_attr_left_joystick_outer_threshold_range.attr,
+	NULL
+};
+
+static struct attribute *right_joystick_axis_attrs[] = {
+	&dev_attr_right_joystick_inner_threshold.attr,
+	&dev_attr_right_joystick_outer_threshold.attr,
+	&dev_attr_right_joystick_inner_threshold_range.attr,
+	&dev_attr_right_joystick_outer_threshold_range.attr,
+	NULL
+};
+
 static const struct attribute_group ally_attr_groups[] = {
 	{
 		.attrs = ally_config_attrs,
@@ -900,6 +1200,14 @@ static const struct attribute_group ally_attr_groups[] = {
 		.name = "right_vibration",
 		.attrs = ally_right_vibration_attrs,
 	},
+	{
+		.name = "left_joystick_axis",
+		.attrs = left_joystick_axis_attrs,
+	},
+	{
+		.name = "right_joystick_axis",
+		.attrs = right_joystick_axis_attrs,
+	},
 };
 
 /**
-- 
2.47.3

