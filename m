Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC29397930
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632472; cv=none; b=ETDDhnAF5gNZGRJxIIlrHAif9PNYBEZBW02/NSWFgKD2MnnyPdKivxhvUOlHda3jCOMvhz1O0jziYiwSOaZkg5whAgsFh3vsQjzLzbZEPC4ZdDQjXFJI0KFqz5xdXOVbPt2TRmtHi6GnDqIazatHdXFn9EsT9CR1/kN5z1QAbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632472; c=relaxed/simple;
	bh=jY6uMnydXj+xwOlApdT+OiOaQ2ULudcF/ky4VT9HY6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLUbx5erxKdMx1JoMOocmuuDWwbNovIq08uE2HdQpUEl1+L09Xjh8WoZwGy8UFWIrXpjnAPfA6bhPvj+02DGhSqNmDP76PE7nfzUBiySNIhf1wT4267qVHWtigt2ndZCQcdTc0T0+SL2P5F8PUiEpUjzz4a6yc/1WvUUBr5sfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SeRwGzwn; arc=none smtp.client-ip=91.218.175.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SeRwGzwn"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jY6uMnydXj+xwOlApdT+OiOaQ2ULudcF/ky4VT9HY6w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632465; v=1; x=1787237265;
 b=SeRwGzwnOF3B9XGXosGbGlNev0DJpiRgMOG9x4QyOEiKaXUtK1qWUb9dUdgqbgHCFsFw6mRT
 D2uohb2UwMskKQILHL+g9yd+f+FnwkpHVYfeb1IuZ1haCuh/qQr2JaNOrBEfPpoHZXbvt5g38Ou
 frw7smho3nMXYMOdXIeBYPbc=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 08bed4af982775f9;
	Thu, 13 Aug 2026 14:47:45 +0000
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
Subject: [PATCH 08/12] HID: asus: add support for response curve
Date: Thu, 13 Aug 2026 14:47:32 +0000
Message-ID: <20260813144736.2477941-9-denis.benato@linux.dev>
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

ROG ally devices allows configuring the response curve of both joysticks,
therefore add the ability of userspace to modify the response curve by
exposing relevant sysfs attributes.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 375 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 374 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 8ed10c5b22ab..8018e61cf026 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -137,7 +137,15 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 	struct device_attribute dev_attr_##_name = \
 		__ATTR(_sysfs_name, 0444, _name##_show, NULL)
 
-#define ALLY_DEVICE_CONST_ATTR_RO(fname, sysfs_name, value)			\
+#define ALLY_DEVICE_ATTR_WO(_name, _sysfs_name)			\
+	struct device_attribute dev_attr_##_name =			\
+		__ATTR(_sysfs_name, 0200, NULL, _name##_store)
+
+#define ALLY_DEVICE_ATTR_RW(_name, _sysfs_name)			\
+	struct device_attribute dev_attr_##_name =			\
+		__ATTR(_sysfs_name, 0644, _name##_show, _name##_store)
+
+#define ALLY_DEVICE_CONST_ATTR_RO(fname, sysfs_name, value)		\
 	static ssize_t fname##_show(struct device *dev,				\
 				   struct device_attribute *attr, char *buf)	\
 	{									\
@@ -190,6 +198,18 @@ struct asus_touchpad_info {
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
@@ -223,6 +243,9 @@ struct ally_config {
 	u8 vibration_intensity_left;
 	u8 vibration_intensity_right;
 	bool vibration_active;
+
+	struct ally_joystick_resp_curve left_curve;
+	struct ally_joystick_resp_curve right_curve;
 };
 
 struct ally_handheld {
@@ -1584,6 +1607,319 @@ static struct device_attribute dev_attr_right_trigger_range_upper_limit =
 static struct device_attribute dev_attr_right_trigger_range_upper_limit_range =
 	__ATTR(range_upper_limit_range, 0444, right_trigger_range_upper_limit_range_show, NULL);
 
+enum ally_joystick_side {
+	JOYSTICK_LEFT = 0,
+	JOYSTICK_RIGHT,
+};
+
+/**
+ * ally_set_joystick_resp_curve - Set joystick response curve parameters
+ * @hdev: HID device
+ * @side: Which joystick side (0=left, 1=right)
+ * @curve: Response curve parameter structure
+ *
+ * Return: 0 on success, negative on failure
+ */
+static int ally_set_joystick_resp_curve(struct hid_device *hdev, enum ally_joystick_side side,
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
+	ret = ally_dev_set_report(hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int response_curve_apply(struct hid_device *hdev, bool is_left)
+{
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *const ally = drvdata->rog_ally;
+	struct ally_config *cfg = ally->config;
+	struct ally_joystick_resp_curve curve;
+	int ret;
+
+	/*
+	 * Snapshot under the lock so a concurrent sysfs write cannot change an
+	 * entry between the monotonicity check and the packet being built.
+	 */
+	scoped_guard(mutex, &cfg->config_mutex)
+		curve = is_left ? cfg->left_curve : cfg->right_curve;
+
+	if (!(curve.entry_1.move < curve.entry_2.move &&
+	      curve.entry_2.move < curve.entry_3.move &&
+	      curve.entry_3.move < curve.entry_4.move))
+		return -EINVAL;
+
+	ret = ally_set_joystick_resp_curve(hdev,
+					    is_left ? JOYSTICK_LEFT : JOYSTICK_RIGHT,
+					    &curve);
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
+	bool apply;
+	int ret;
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	if (!ally->config->resp_curve_support)
+		return -EOPNOTSUPP;
+
+	ret = kstrtobool(buf, &apply);
+	if (ret)
+		return ret;
+
+	if (!apply)
+		return count;
+
+	ret = response_curve_apply(hdev, true);
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
+	bool apply;
+	int ret;
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	if (!ally->config->resp_curve_support)
+		return -EOPNOTSUPP;
+
+	ret = kstrtobool(buf, &apply);
+	if (ret)
+		return ret;
+
+	if (!apply)
+		return count;
+
+	ret = response_curve_apply(hdev, false);
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
+				       struct device_attribute *attr, char *buf,
+				       struct ally_joystick_resp_curve *curve,
+				       int idx)
+{
+	switch (idx) {
+	case 1: return sysfs_emit(buf, "%u\n", curve->entry_1.resp);
+	case 2: return sysfs_emit(buf, "%u\n", curve->entry_2.resp);
+	case 3: return sysfs_emit(buf, "%u\n", curve->entry_3.resp);
+	case 4: return sysfs_emit(buf, "%u\n", curve->entry_4.resp);
+	default: return -EINVAL;
+	}
+}
+
+static ssize_t response_curve_move_show(struct device *dev,
+					struct device_attribute *attr, char *buf,
+					struct ally_joystick_resp_curve *curve,
+					int idx)
+{
+	switch (idx) {
+	case 1: return sysfs_emit(buf, "%u\n", curve->entry_1.move);
+	case 2: return sysfs_emit(buf, "%u\n", curve->entry_2.move);
+	case 3: return sysfs_emit(buf, "%u\n", curve->entry_3.move);
+	case 4: return sysfs_emit(buf, "%u\n", curve->entry_4.move);
+	default: return -EINVAL;
+	}
+}
+
+static ssize_t response_curve_pct_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count,
+					bool is_left,
+					struct ally_handheld *ally, int idx)
+{
+	struct ally_config *cfg = ally->config;
+	struct ally_joystick_resp_curve *curve;
+	u8 value;
+	int ret;
+
+	if (!cfg->resp_curve_support)
+		return -EOPNOTSUPP;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value > 100)
+		return -EINVAL;
+
+	curve = is_left ? &cfg->left_curve : &cfg->right_curve;
+
+	scoped_guard(mutex, &cfg->config_mutex) {
+		switch (idx) {
+		case 1:
+			curve->entry_1.resp = value;
+			break;
+		case 2:
+			curve->entry_2.resp = value;
+			break;
+		case 3:
+			curve->entry_3.resp = value;
+			break;
+		case 4:
+			curve->entry_4.resp = value;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return count;
+}
+
+static ssize_t response_curve_move_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count,
+					 bool is_left,
+					 struct ally_handheld *ally, int idx)
+{
+	struct ally_config *cfg = ally->config;
+	struct ally_joystick_resp_curve *curve;
+	u8 value;
+	int ret;
+
+	if (!cfg->resp_curve_support)
+		return -EOPNOTSUPP;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value > 100)
+		return -EINVAL;
+
+	curve = is_left ? &cfg->left_curve : &cfg->right_curve;
+
+	scoped_guard(mutex, &cfg->config_mutex) {
+		switch (idx) {
+		case 1:
+			curve->entry_1.move = value;
+			break;
+		case 2:
+			curve->entry_2.move = value;
+			break;
+		case 3:
+			curve->entry_3.move = value;
+			break;
+		case 4:
+			curve->entry_4.move = value;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return count;
+}
+
+#define DEFINE_JS_CURVE_PCT_FOPS(region, side)					\
+	static ssize_t side##_response_curve_pct_##region##_show(		\
+		struct device *dev, struct device_attribute *attr, char *buf)	\
+	{									\
+		struct hid_device *hdev = to_hid_device(dev);			\
+		struct asus_drvdata *drvdata = hid_get_drvdata(hdev);		\
+		struct ally_handheld *ally = drvdata->rog_ally;			\
+		return response_curve_pct_show(					\
+			dev, attr, buf, &ally->config->side##_curve, region);\
+	}									\
+										\
+	static ssize_t side##_response_curve_pct_##region##_store(		\
+		struct device *dev, struct device_attribute *attr,		\
+		const char *buf, size_t count)					\
+	{									\
+		struct hid_device *hdev = to_hid_device(dev);			\
+		struct asus_drvdata *drvdata = hid_get_drvdata(hdev);		\
+		struct ally_handheld *ally = drvdata->rog_ally;			\
+		return response_curve_pct_store(dev, attr, buf, count,		\
+						side##_is_left, ally, region);	\
+	}
+
+#define DEFINE_JS_CURVE_MOVE_FOPS(region, side)					\
+	static ssize_t side##_response_curve_move_##region##_show(		\
+		struct device *dev, struct device_attribute *attr, char *buf)	\
+	{									\
+		struct hid_device *hdev = to_hid_device(dev);			\
+		struct asus_drvdata *drvdata = hid_get_drvdata(hdev);		\
+		struct ally_handheld *ally = drvdata->rog_ally;			\
+		return response_curve_move_show(					\
+			dev, attr, buf, &ally->config->side##_curve, region);\
+	}									\
+										\
+	static ssize_t side##_response_curve_move_##region##_store(		\
+		struct device *dev, struct device_attribute *attr,		\
+		const char *buf, size_t count)					\
+	{									\
+		struct hid_device *hdev = to_hid_device(dev);			\
+		struct asus_drvdata *drvdata = hid_get_drvdata(hdev);		\
+		struct ally_handheld *ally = drvdata->rog_ally;			\
+		return response_curve_move_store(dev, attr, buf, count,	        \
+						 side##_is_left, ally, region); \
+	}
+
+#define DEFINE_JS_CURVE_ATTRS(region, side)					\
+	DEFINE_JS_CURVE_PCT_FOPS(region, side)					\
+	DEFINE_JS_CURVE_MOVE_FOPS(region, side)					\
+	static ALLY_DEVICE_ATTR_RW(side##_response_curve_pct_##region,		\
+				   response_curve_pct_##region);		\
+	static ALLY_DEVICE_ATTR_RW(side##_response_curve_move_##region,		\
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
@@ -1608,6 +1944,15 @@ static struct attribute *left_joystick_axis_attrs[] = {
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
 
@@ -1618,6 +1963,15 @@ static struct attribute *right_joystick_axis_attrs[] = {
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
 
@@ -1711,6 +2065,25 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 	cfg->vibration_intensity_right = 100;
 	cfg->vibration_active = false;
 
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
 	/* So far the only hardware this is supported is the Ally 1 */
 	if (cfg->xbox_controller_support) {
 		ret = ally_set_xbox_controller(hdev, cfg, true);
-- 
2.47.3

