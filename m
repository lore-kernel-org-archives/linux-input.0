Received: from mta1.migadu.com (out-103.mta1.migadu.com [95.215.58.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702724F052D
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534099; cv=none; b=Uo+skzuMTHvV3YZkCH5M7sWy3sbTmFM1Phfo45sJiSPZjubIHqFXe5fg2v5kYGXSSm4iBRoAWndjovqzKPzYFPYB4yZ5apWOdNNBNhIczypbwRuoJE/B6V8gkyJc9lvQBO0W2RnCES6SHggSuCZd34/M2gWdJRADrxhMNoLIcGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534099; c=relaxed/simple;
	bh=cxXfcJqzEiJZIw9GQIV22yh3bvN4t6fzXZJUWQdYOVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDrcLyrnen87Q5phLlh7JXQzkcynkybOLwsRCKzFpiia/jUBsZdO+75N3vUgCfo9Dbol19fJdQOn5DF3WwoeMCWXtpw8e341oMWZ1NGxwR75V7x5z+LnR7XZ2tVvBL1HPZ9VQ4126APLWXAgoaDGc5lPCLqub8r78rAgumlyqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFUojHB1; arc=none smtp.client-ip=95.215.58.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZFUojHB1"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cxXfcJqzEiJZIw9GQIV22yh3bvN4t6fzXZJUWQdYOVY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788534095; v=1; x=1789138895;
 b=ZFUojHB17O6kbWX5rE5BIPBSPz/mbsOoHj9KFYu6CAr2/tTJ4c3fcR1nMSss3WvWDLQU4+sH
 heg0X30WglaNyov4UVXzotGDbH1QfjUjS0CafwNvJ88iej0+YaTK1uN1FsGapb2YWxBmthv0zfl
 WJlGtUs8JM4768uSPEudqNfA=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c907d75ed213aa48;
	Fri, 04 Sep 2026 15:01:35 +0000
X-Mizu-Trace-ID: c907d75ed213aa48
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
Subject: [PATCH v5 06/13] HID: asus: add joysticks inner and outer range configuration
Date: Fri,  4 Sep 2026 14:58:37 +0000
Message-ID: <20260904145845.184887-7-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904145845.184887-1-denis.benato@linux.dev>
References: <20260904145845.184887-1-denis.benato@linux.dev>
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

Assisted-by: opencode:glm-5.2
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 426 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 426 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 659956ebaefc..8b9ab5f7931c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -991,6 +991,351 @@ static struct device_attribute dev_attr_right_vibration_intensity =
 static struct device_attribute dev_attr_right_vibration_intensity_range =
 	__ATTR(intensity_range, 0444, right_vibration_intensity_range_show, NULL);
 
+/**
+ * ally_set_joystick_thresholds() - Generic function to set joystick ranges
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @cfg: ally config
+ * @left_it: inner threshold (deadzone) of the left stick (0-50)
+ * @left_ot: outer threshold of the left stick (70-100)
+ * @right_it: inner threshold (deadzone) of the right stick (0-50)
+ * @right_ot: outer threshold of the right stick (70-100)
+ *
+ * This function sends the command to set both inner and outer threshold
+ * for the left and right joysticks.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_set_joystick_thresholds(struct ally_handheld *ally,
+					struct hid_device *hdev, struct ally_config *cfg,
+					u8 left_it, u8 left_ot, u8 right_it, u8 right_ot)
+{
+	const u8 payload[] = { left_it, left_ot, right_it, right_ot };
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_JOYSTICK_DEADZONE, payload, sizeof(payload));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set joystick ranges: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t left_joystick_inner_threshold_show(struct device *dev, struct device_attribute *attr,
+						  char *buf)
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
+	return sysfs_emit(buf, "%u\n", cfg->left_deadzone);
+}
+
+static ssize_t left_joystick_inner_threshold_store(struct device *dev,
+						   struct device_attribute *attr,
+						   const char *buf, size_t count)
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
+	ret = ally_set_joystick_thresholds(ally, hdev, cfg,
+					   value,
+					   cfg->left_outer_threshold,
+					   cfg->right_deadzone,
+					   cfg->right_outer_threshold);
+	if (ret)
+		return ret;
+
+	cfg->left_deadzone = value;
+
+	return count;
+}
+
+static ssize_t left_joystick_inner_threshold_range_show(struct device *dev,
+							struct device_attribute *attr,
+							char *buf)
+{
+	return sysfs_emit(buf, "0 50\n");
+}
+
+static ssize_t left_joystick_outer_threshold_show(struct device *dev, struct device_attribute *attr,
+						  char *buf)
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
+	return sysfs_emit(buf, "%u\n", cfg->left_outer_threshold);
+}
+
+static ssize_t left_joystick_outer_threshold_store(struct device *dev,
+						   struct device_attribute *attr,
+						   const char *buf, size_t count)
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
+	ret = ally_set_joystick_thresholds(ally, hdev, cfg,
+					   cfg->left_deadzone,
+					   value,
+					   cfg->right_deadzone,
+					   cfg->right_outer_threshold);
+	if (ret)
+		return ret;
+
+	cfg->left_outer_threshold = value;
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
+	return sysfs_emit(buf, "%u\n", cfg->right_deadzone);
+}
+
+static ssize_t right_joystick_inner_threshold_store(struct device *dev,
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
+	ret = ally_set_joystick_thresholds(ally, hdev, cfg,
+					   cfg->left_deadzone,
+					   cfg->left_outer_threshold,
+					   value,
+					   cfg->right_outer_threshold);
+	if (ret)
+		return ret;
+
+	cfg->right_deadzone = value;
+
+	return count;
+}
+
+static ssize_t right_joystick_inner_threshold_range_show(struct device *dev,
+							 struct device_attribute *attr,
+							 char *buf)
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
+	return sysfs_emit(buf, "%u\n", cfg->right_outer_threshold);
+}
+
+static ssize_t right_joystick_outer_threshold_store(struct device *dev,
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
+	ret = ally_set_joystick_thresholds(ally, hdev, cfg,
+					   cfg->left_deadzone,
+					   cfg->left_outer_threshold,
+					   cfg->right_deadzone,
+					   value);
+	if (ret)
+		return ret;
+
+	cfg->right_outer_threshold = value;
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
@@ -1008,6 +1353,22 @@ static struct attribute *ally_right_vibration_attrs[] = {
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
@@ -1022,6 +1383,28 @@ static const struct attribute_group ally_attr_groups[] = {
 	},
 };
 
+/*
+ * The joystick and trigger range calibration attributes are tied to the
+ * user-calibration capability: their sysfs groups are registered only
+ * when the device supports configuring those parameters, and the show
+ * and store callbacks reject accesses with -EOPNOTSUPP regardless, in
+ * case the groups are registered for another supported feature.
+ */
+static const struct attribute_group ally_left_joystick_axis_group = {
+	.name = "left_joystick_axis",
+	.attrs = left_joystick_axis_attrs,
+};
+
+static const struct attribute_group ally_right_joystick_axis_group = {
+	.name = "right_joystick_axis",
+	.attrs = right_joystick_axis_attrs,
+};
+
+static const struct attribute_group *const ally_cal_attr_groups[] = {
+	&ally_left_joystick_axis_group,
+	&ally_right_joystick_axis_group,
+};
+
 /**
  * ally_config_create() - Initialize configuration and create sysfs entries
  * @hdev: HID device
@@ -1076,6 +1459,25 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 		}
 	}
 
+	/* Skip the calibration groups when the capability is missing. */
+	if (cfg->user_cal_support) {
+		int cal_i;
+
+		for (cal_i = 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups);
+		     cal_i++) {
+			ret = sysfs_create_group(&hdev->dev.kobj,
+						 ally_cal_attr_groups[cal_i]);
+			if (ret < 0) {
+				hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
+					ally_cal_attr_groups[cal_i]->name, ret);
+				while (cal_i-- > 0)
+					sysfs_remove_group(&hdev->dev.kobj,
+							   ally_cal_attr_groups[cal_i]);
+				goto ally_config_create_sysfs_err;
+			}
+		}
+	}
+
 	/* So far the only hardware this is supported is the Ally 1 */
 	if (cfg->xbox_controller_support) {
 		ret = ally_set_xbox_controller(hdev, ally, cfg, true);
@@ -1110,6 +1512,18 @@ static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
 
 	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
 		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
+
+	/*
+	 * The calibration groups are removed with the same gating used to
+	 * create them, so a device without those capabilities does not
+	 * trigger a "not found" warning.
+	 */
+	if (cfg->user_cal_support || cfg->anti_deadzone_support ||
+	    cfg->resp_curve_support) {
+		for (i = 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
+			sysfs_remove_group(&hdev->dev.kobj,
+						   ally_cal_attr_groups[i]);
+	}
 }
 
 /**
@@ -1410,6 +1824,18 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 		hid_warn(hdev, "Failed to restore vibration intensity: %d\n",
 			 ret);
 
+	if (cfg->user_cal_support) {
+		ret = ally_set_joystick_thresholds(ally, hdev, cfg,
+						   cfg->left_deadzone,
+						   cfg->left_outer_threshold,
+						   cfg->right_deadzone,
+						   cfg->right_outer_threshold);
+		if (ret < 0)
+			hid_warn(hdev,
+					 "Failed to restore joystick thresholds: %d\n",
+					 ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

