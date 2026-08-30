Received: from mta1.migadu.com (out-141.mta1.migadu.com [95.215.58.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2D35A385
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788133418; cv=none; b=d16kcJ7R/flwQMN38c9nLOI2oqOFujMLdxZigqCQQZ4TUiIWuHFAKVmyXmwMnlKmSVahVbXHhyhsJrTcdazemU9F8YHbjXLrBrS6BBxVhz0DnqHW5BYSeuIw+SeWVsC2fjRJPSceyOHojUFBLwPaR6tikQnPjNNOu1JyKmNWJcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788133418; c=relaxed/simple;
	bh=s/JspewPS9Ad0IuN4owZ8+u21gQc8/VouJtgchCHdSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJ4tNi+xg30l5wfldr+ccrfuttd38RDplm0FvDXnx05eU7x8wy2dJk8LsjqEE6ZAdybtClFCIPaWdwvCi7BjKso9kc6Y9VP9xhoxc34comnzXQKj+FVVfEvUAMryZ6Wd+Pj4DbgiOmEnSP9WRk+2PdI/PhZKv+gC38ATToyVANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IukyURB7; arc=none smtp.client-ip=95.215.58.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IukyURB7"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s/JspewPS9Ad0IuN4owZ8+u21gQc8/VouJtgchCHdSY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788133412; v=1; x=1788738212;
 b=IukyURB7dUezb2qzNCiMpeP8IDnUjGcdkcBjGj6VMIE1r6jtUyGIS3uXVajZcu0pZELeUrRo
 RzA4fTuyfn1qTgcmNb6HjFpWgOdy2uOAUwJNMUsbDvWzKz+8EK5RTWWziSvBRdN4RPXVBEYJpv9
 0fOZLLuqIYd2eSPR6zR012hw=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c95fd2f1a0c653e8;
	Sun, 30 Aug 2026 23:43:32 +0000
X-Mizu-Trace-ID: c95fd2f1a0c653e8
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
Subject: [PATCH v4 09/13] HID: asus: add support for response curve
Date: Sun, 30 Aug 2026 23:43:16 +0000
Message-ID: <20260830234320.114356-10-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830234320.114356-1-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ROG ally devices allows configuring the response curve of both joysticks,
therefore add the ability of userspace to modify the response curve by
exposing relevant sysfs attributes.

Assisted-by: opencode:glm-5.2
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 461 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 458 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index c365b96d4486..bd488acdb5d4 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -134,6 +134,14 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
 
+#define ALLY_DEVICE_ATTR_WO(_name, _sysfs_name)				\
+	struct device_attribute dev_attr_##_name =				\
+		__ATTR(_sysfs_name, 0200, NULL, _name##_store)
+
+#define ALLY_DEVICE_ATTR_RW(_name, _sysfs_name)				\
+	struct device_attribute dev_attr_##_name =				\
+		__ATTR(_sysfs_name, 0644, _name##_show, _name##_store)
+
 enum asus_work_action_type {
 	FN_LOCK_SYNC,
 	BRIGHTNESS_SET,
@@ -178,6 +186,18 @@ struct asus_touchpad_info {
 	int report_size;
 };
 
+struct ally_joystick_resp_curve_param {
+	u8 move;
+	u8 resp;
+} __packed;
+
+struct ally_joystick_resp_curve {
+	struct ally_joystick_resp_curve_param entry_1;
+	struct ally_joystick_resp_curve_param entry_2;
+	struct ally_joystick_resp_curve_param entry_3;
+	struct ally_joystick_resp_curve_param entry_4;
+} __packed;
+
 struct ally_config {
 	/* Must be locked if the data is being changed */
 	struct mutex config_mutex;
@@ -210,6 +230,9 @@ struct ally_config {
 	/* Vibration settings */
 	u8 vibration_intensity_left;
 	u8 vibration_intensity_right;
+
+	struct ally_joystick_resp_curve left_curve;
+	struct ally_joystick_resp_curve right_curve;
 };
 
 struct ally_handheld {
@@ -1849,6 +1872,400 @@ static struct device_attribute dev_attr_right_trigger_range_upper_limit =
 static struct device_attribute dev_attr_right_trigger_range_upper_limit_range =
 	__ATTR(range_upper_limit_range, 0444, right_trigger_range_upper_limit_range_show, NULL);
 
+enum ally_joystick_side {
+	JOYSTICK_LEFT = 0,
+	JOYSTICK_RIGHT,
+};
+
+/**
+ * ally_set_joystick_resp_curve() - Set joystick response curve parameters
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @side: which joystick side (0=left, 1=right)
+ * @curve: response curve parameter structure
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_set_joystick_resp_curve(struct ally_handheld *ally,
+					struct hid_device *hdev, enum ally_joystick_side side,
+					struct ally_joystick_resp_curve *curve)
+{
+	const u8 payload[] = { side,
+		curve->entry_1.move, curve->entry_1.resp,
+		curve->entry_2.move, curve->entry_2.resp,
+		curve->entry_3.move, curve->entry_3.resp,
+		curve->entry_4.move, curve->entry_4.resp
+	};
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_RESP_CURVE, payload, sizeof(payload));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int response_curve_apply(struct ally_handheld *ally,
+				struct hid_device *hdev,
+				struct ally_config *cfg, bool is_left)
+{
+	struct ally_joystick_resp_curve curve;
+	int ret;
+
+	/*
+	 * Snapshot under the lock so a concurrent sysfs write cannot change an
+	 * entry between the monotonicity check and the packet being built.
+	 */
+	scoped_guard(mutex, &cfg->config_mutex) {
+		if (!cfg->resp_curve_support)
+			return -EOPNOTSUPP;
+
+		curve = is_left ? cfg->left_curve : cfg->right_curve;
+	}
+
+	if (!(curve.entry_1.move < curve.entry_2.move &&
+	      curve.entry_2.move < curve.entry_3.move &&
+	      curve.entry_3.move < curve.entry_4.move))
+		return -EINVAL;
+
+	ret = ally_set_joystick_resp_curve(ally, hdev,
+					   is_left ? JOYSTICK_LEFT : JOYSTICK_RIGHT,
+					   &curve);
+	if (ret) {
+		hid_err(hdev, "Failed to set joystick response curve: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t left_response_curve_apply_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+	bool apply;
+	int ret;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	ret = kstrtobool(buf, &apply);
+	if (ret)
+		return ret;
+
+	if (!apply)
+		return count;
+
+	ret = response_curve_apply(ally, hdev, cfg, true);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t right_response_curve_apply_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+	bool apply;
+	int ret;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	ret = kstrtobool(buf, &apply);
+	if (ret)
+		return ret;
+
+	if (!apply)
+		return count;
+
+	ret = response_curve_apply(ally, hdev, cfg, false);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ALLY_DEVICE_ATTR_WO(left_response_curve_apply, response_curve_apply);
+static ALLY_DEVICE_ATTR_WO(right_response_curve_apply, response_curve_apply);
+
+static ssize_t response_curve_pct_show(struct device *dev,
+				       char *buf,
+				       struct ally_config *cfg, bool is_left,
+				       unsigned int idx)
+{
+	struct ally_joystick_resp_curve *curve;
+	int ret = -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->resp_curve_support)
+		return -EOPNOTSUPP;
+
+	curve = is_left ? &cfg->left_curve : &cfg->right_curve;
+
+	switch (idx) {
+	case 1:
+		ret = sysfs_emit(buf, "%u\n", curve->entry_1.resp);
+		break;
+	case 2:
+		ret = sysfs_emit(buf, "%u\n", curve->entry_2.resp);
+		break;
+	case 3:
+		ret = sysfs_emit(buf, "%u\n", curve->entry_3.resp);
+		break;
+	case 4:
+		ret = sysfs_emit(buf, "%u\n", curve->entry_4.resp);
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t response_curve_move_show(struct device *dev,
+					char *buf,
+					struct ally_config *cfg, bool is_left,
+					unsigned int idx)
+{
+	struct ally_joystick_resp_curve *curve;
+	int ret = -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->resp_curve_support)
+		return -EOPNOTSUPP;
+
+	curve = is_left ? &cfg->left_curve : &cfg->right_curve;
+
+	switch (idx) {
+	case 1:
+		ret = sysfs_emit(buf, "%u\n", curve->entry_1.move);
+		break;
+	case 2:
+		ret = sysfs_emit(buf, "%u\n", curve->entry_2.move);
+		break;
+	case 3:
+		ret = sysfs_emit(buf, "%u\n", curve->entry_3.move);
+		break;
+	case 4:
+		ret = sysfs_emit(buf, "%u\n", curve->entry_4.move);
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t response_curve_pct_store(struct device *dev,
+					const char *buf, size_t count,
+					struct ally_config *cfg, bool is_left,
+					unsigned int idx)
+{
+	struct ally_joystick_resp_curve *curve;
+	u8 value;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value > 100)
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->resp_curve_support)
+		return -EOPNOTSUPP;
+
+	curve = is_left ? &cfg->left_curve : &cfg->right_curve;
+
+	switch (idx) {
+	case 1:
+		curve->entry_1.resp = value;
+		break;
+	case 2:
+		curve->entry_2.resp = value;
+		break;
+	case 3:
+		curve->entry_3.resp = value;
+		break;
+	case 4:
+		curve->entry_4.resp = value;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t response_curve_move_store(struct device *dev,
+					 const char *buf, size_t count,
+					 struct ally_config *cfg, bool is_left,
+					 unsigned int idx)
+{
+	struct ally_joystick_resp_curve *curve;
+	u8 value;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value > 100)
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->resp_curve_support)
+		return -EOPNOTSUPP;
+
+	curve = is_left ? &cfg->left_curve : &cfg->right_curve;
+
+	switch (idx) {
+	case 1:
+		curve->entry_1.move = value;
+		break;
+	case 2:
+		curve->entry_2.move = value;
+		break;
+	case 3:
+		curve->entry_3.move = value;
+		break;
+	case 4:
+		curve->entry_4.move = value;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+#define DEFINE_JS_CURVE_PCT_FOPS(region, side)				\
+	static ssize_t side##_response_curve_pct_##region##_show(	\
+		struct device *dev, struct device_attribute *attr,	\
+		char *buf)						\
+	{								\
+		struct hid_device *hdev = to_hid_device(dev);		\
+		struct asus_drvdata *drvdata = hid_get_drvdata(hdev);	\
+		struct ally_handheld *ally = drvdata->rog_ally;		\
+		struct ally_config *cfg;				\
+									\
+		if (!ally)						\
+			return -ENODEV;				\
+									\
+		cfg = ally_get_config(ally);				\
+		if (!cfg)						\
+			return -ENODEV;				\
+									\
+		return response_curve_pct_show(dev, buf, cfg,		\
+					       side##_is_left, region);\
+	}								\
+									\
+	static ssize_t side##_response_curve_pct_##region##_store(	\
+		struct device *dev, struct device_attribute *attr,	\
+		const char *buf, size_t count)				\
+	{								\
+		struct hid_device *hdev = to_hid_device(dev);		\
+		struct asus_drvdata *drvdata = hid_get_drvdata(hdev);	\
+		struct ally_handheld *ally = drvdata->rog_ally;		\
+		struct ally_config *cfg;				\
+									\
+		if (!ally)						\
+			return -ENODEV;				\
+									\
+		cfg = ally_get_config(ally);				\
+		if (!cfg)						\
+			return -ENODEV;				\
+									\
+		return response_curve_pct_store(dev, buf, count, cfg,	\
+						side##_is_left, region);\
+	}
+
+#define DEFINE_JS_CURVE_MOVE_FOPS(region, side)				\
+	static ssize_t side##_response_curve_move_##region##_show(	\
+		struct device *dev, struct device_attribute *attr,	\
+		char *buf)						\
+	{								\
+		struct hid_device *hdev = to_hid_device(dev);		\
+		struct asus_drvdata *drvdata = hid_get_drvdata(hdev);	\
+		struct ally_handheld *ally = drvdata->rog_ally;		\
+		struct ally_config *cfg;				\
+									\
+		if (!ally)						\
+			return -ENODEV;				\
+									\
+		cfg = ally_get_config(ally);				\
+		if (!cfg)						\
+			return -ENODEV;				\
+									\
+		return response_curve_move_show(dev, buf, cfg,		\
+						side##_is_left, region);\
+	}								\
+									\
+	static ssize_t side##_response_curve_move_##region##_store(	\
+		struct device *dev, struct device_attribute *attr,	\
+		const char *buf, size_t count)				\
+	{								\
+		struct hid_device *hdev = to_hid_device(dev);		\
+		struct asus_drvdata *drvdata = hid_get_drvdata(hdev);	\
+		struct ally_handheld *ally = drvdata->rog_ally;		\
+		struct ally_config *cfg;				\
+									\
+		if (!ally)						\
+			return -ENODEV;				\
+									\
+		cfg = ally_get_config(ally);				\
+		if (!cfg)						\
+			return -ENODEV;				\
+									\
+		return response_curve_move_store(dev, buf, count, cfg,	\
+						 side##_is_left, region);\
+	}
+
+#define DEFINE_JS_CURVE_ATTRS(region, side)				\
+	DEFINE_JS_CURVE_PCT_FOPS(region, side)				\
+	DEFINE_JS_CURVE_MOVE_FOPS(region, side)				\
+	static ALLY_DEVICE_ATTR_RW(side##_response_curve_pct_##region,	\
+				   response_curve_pct_##region);	\
+	static ALLY_DEVICE_ATTR_RW(side##_response_curve_move_##region,	\
+				   response_curve_move_##region)
+
+/* Helper defines for "is_left" parameter in DEFINE_JS_CURVE_ATTRS macros */
+#define left_is_left true
+#define right_is_left false
+
+DEFINE_JS_CURVE_ATTRS(1, left);
+DEFINE_JS_CURVE_ATTRS(2, left);
+DEFINE_JS_CURVE_ATTRS(3, left);
+DEFINE_JS_CURVE_ATTRS(4, left);
+
+DEFINE_JS_CURVE_ATTRS(1, right);
+DEFINE_JS_CURVE_ATTRS(2, right);
+DEFINE_JS_CURVE_ATTRS(3, right);
+DEFINE_JS_CURVE_ATTRS(4, right);
+
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
 	NULL
@@ -1873,6 +2290,15 @@ static struct attribute *left_joystick_axis_attrs[] = {
 	&dev_attr_left_joystick_outer_threshold_range.attr,
 	&dev_attr_left_joystick_anti_deadzone.attr,
 	&dev_attr_left_joystick_anti_deadzone_range.attr,
+	&dev_attr_left_response_curve_pct_1.attr,
+	&dev_attr_left_response_curve_pct_2.attr,
+	&dev_attr_left_response_curve_pct_3.attr,
+	&dev_attr_left_response_curve_pct_4.attr,
+	&dev_attr_left_response_curve_move_1.attr,
+	&dev_attr_left_response_curve_move_2.attr,
+	&dev_attr_left_response_curve_move_3.attr,
+	&dev_attr_left_response_curve_move_4.attr,
+	&dev_attr_left_response_curve_apply.attr,
 	NULL
 };
 
@@ -1883,6 +2309,15 @@ static struct attribute *right_joystick_axis_attrs[] = {
 	&dev_attr_right_joystick_outer_threshold_range.attr,
 	&dev_attr_right_joystick_anti_deadzone.attr,
 	&dev_attr_right_joystick_anti_deadzone_range.attr,
+	&dev_attr_right_response_curve_pct_1.attr,
+	&dev_attr_right_response_curve_pct_2.attr,
+	&dev_attr_right_response_curve_pct_3.attr,
+	&dev_attr_right_response_curve_pct_4.attr,
+	&dev_attr_right_response_curve_move_1.attr,
+	&dev_attr_right_response_curve_move_2.attr,
+	&dev_attr_right_response_curve_move_3.attr,
+	&dev_attr_right_response_curve_move_4.attr,
+	&dev_attr_right_response_curve_apply.attr,
 	NULL
 };
 
@@ -1975,10 +2410,11 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 	}
 
 	/*
-	 * Skip the calibration and anti-deadzone groups when none of the
-	 * features they expose is supported.
+	 * Skip the calibration, anti-deadzone and response curve groups when
+	 * none of the features they expose is supported.
 	 */
-	if (cfg->user_cal_support || cfg->anti_deadzone_support) {
+	if (cfg->user_cal_support || cfg->anti_deadzone_support ||
+	    cfg->resp_curve_support) {
 		for (sysfs_i = 0; sysfs_i < ARRAY_SIZE(ally_cal_attr_groups); sysfs_i++) {
 			ret = devm_device_add_group(&hdev->dev,
 						    ally_cal_attr_groups[sysfs_i]);
@@ -2002,6 +2438,25 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 	cfg->vibration_intensity_left = 100;
 	cfg->vibration_intensity_right = 100;
 
+	/* Initialize default response curve values (linear) */
+	cfg->left_curve.entry_1.move = 0;
+	cfg->left_curve.entry_1.resp = 0;
+	cfg->left_curve.entry_2.move = 33;
+	cfg->left_curve.entry_2.resp = 33;
+	cfg->left_curve.entry_3.move = 66;
+	cfg->left_curve.entry_3.resp = 66;
+	cfg->left_curve.entry_4.move = 100;
+	cfg->left_curve.entry_4.resp = 100;
+
+	cfg->right_curve.entry_1.move = 0;
+	cfg->right_curve.entry_1.resp = 0;
+	cfg->right_curve.entry_2.move = 33;
+	cfg->right_curve.entry_2.resp = 33;
+	cfg->right_curve.entry_3.move = 66;
+	cfg->right_curve.entry_3.resp = 66;
+	cfg->right_curve.entry_4.move = 100;
+	cfg->right_curve.entry_4.resp = 100;
+
 	for (sysfs_i = 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
 		ret = devm_device_add_group(&hdev->dev, &ally_attr_groups[sysfs_i]);
 		if (ret < 0) {
-- 
2.47.3

