Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80E35AC00
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548936; cv=none; b=hJtZkNtcLebVhG9pzMLxOpUWNuI+QEnUhSWInmYqzjCN7pXa5Arjbtuh+Kn971EEW/GZLH6hgzgQJClwEz6b0xjba9kIKzWU/T5LYG253SP2n1wDIppVqS6SbT7gXfql9XVi2r+lwiVg7oGZz3BG17b8DzK3RJqtni+DZY3InIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548936; c=relaxed/simple;
	bh=6k0sV5YX4VpKE/W3p816sQvAOh0mnz88B08AUslT3Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D66qWGw8VWetv87S6Pvh8nrqiWuRo+FHI669HHfj+B5QoAQu2zQK40KfYpkhGfWSjv+PVVBanWiCZcR5WHgretOsZhPN/mukxVjJTno/2yhhGcY3HkIFdzWwMjcIVKaYTXl7K0MfCwhlfmk/sk0sQd0g+RnbaD20YTLwpeKQ3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jbl9vdSw; arc=none smtp.client-ip=91.218.175.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jbl9vdSw"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6k0sV5YX4VpKE/W3p816sQvAOh0mnz88B08AUslT3Do=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791548927; v=1; x=1792153727;
 b=jbl9vdSwXWEvqff+1WzJA9sypvTCek56QRihlFDLz1ceYW3CG5kWn1VsX33j4iGO1Bi/PAFf
 Tj8x6kqyUFKSLn8DAJCCvKaEOEaNZYiKIKa+t+u113OdTZheHbew+YVtPDpR6rvhSYzNz79QZH/
 8TEeIZda9YnyX2e0eMTlnDdk=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8c1ecc4d42e64cc5;
	Fri, 09 Oct 2026 12:28:46 +0000
X-Mizu-Trace-ID: 8c1ecc4d42e64cc5
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v9 08/12] HID: asus: add support for response curve
Date: Fri,  9 Oct 2026 12:28:16 +0000
Message-ID: <20261009122820.7603-9-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009122820.7603-1-denis.benato@linux.dev>
References: <20261009122820.7603-1-denis.benato@linux.dev>
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
 drivers/hid/hid-asus.c | 298 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 295 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 7911f510466d..3d0c3530753c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -22,6 +22,7 @@
 
 #include <linux/acpi.h>
 #include <linux/cleanup.h>
+#include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/hid.h>
@@ -178,6 +179,18 @@ struct asus_touchpad_info {
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
@@ -210,6 +223,9 @@ struct ally_config {
 	/* Vibration settings */
 	u8 vibration_intensity_left;
 	u8 vibration_intensity_right;
+
+	struct ally_joystick_resp_curve left_curve;
+	struct ally_joystick_resp_curve right_curve;
 };
 
 /*
@@ -1924,6 +1940,236 @@ static struct device_attribute dev_attr_right_trigger_range_upper_limit =
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
+/**
+ * ally_resp_curve_is_valid() - Check that a response curve is valid
+ * @curve: response curve parameter structure
+ *
+ * Return: true if the curve is valid, false otherwise
+ */
+static bool ally_resp_curve_is_valid(const struct ally_joystick_resp_curve *curve)
+{
+	return curve->entry_1.move < curve->entry_2.move &&
+	       curve->entry_2.move < curve->entry_3.move &&
+	       curve->entry_3.move < curve->entry_4.move;
+}
+
+static ssize_t response_curve_show(struct ally_config *cfg, bool is_left, char *buf)
+{
+	const struct ally_joystick_resp_curve *curve;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->resp_curve_support)
+		return -EOPNOTSUPP;
+
+	curve = is_left ? &cfg->left_curve : &cfg->right_curve;
+
+	return sysfs_emit(buf, "%u %u %u %u %u %u %u %u\n",
+			  curve->entry_1.move, curve->entry_1.resp,
+			  curve->entry_2.move, curve->entry_2.resp,
+			  curve->entry_3.move, curve->entry_3.resp,
+			  curve->entry_4.move, curve->entry_4.resp);
+}
+
+static ssize_t response_curve_store(struct device *dev, struct ally_handheld *ally,
+				    struct hid_device *hdev, struct ally_config *cfg,
+				    bool is_left, const char *buf, size_t count)
+{
+	struct ally_joystick_resp_curve curve;
+	struct ally_joystick_resp_curve *cached;
+	unsigned int v[8];
+	int used = 0;
+	int ret, i;
+
+	/*
+	 * Parse and validate the whole curve before taking the lock: a
+	 * write is all-or-nothing and a rejected one must leave the
+	 * recorded curve untouched.
+	 */
+	ret = sscanf(buf, "%u %u %u %u %u %u %u %u%n",
+		     &v[0], &v[1], &v[2], &v[3], &v[4], &v[5], &v[6], &v[7], &used);
+	if (ret != 8)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(v); i++) {
+		if (v[i] > 100)
+			return -EINVAL;
+	}
+
+	for (; buf[used]; used++) {
+		if (!isspace(buf[used]))
+			return -EINVAL;
+	}
+
+	curve.entry_1.move = v[0];
+	curve.entry_1.resp = v[1];
+	curve.entry_2.move = v[2];
+	curve.entry_2.resp = v[3];
+	curve.entry_3.move = v[4];
+	curve.entry_3.resp = v[5];
+	curve.entry_4.move = v[6];
+	curve.entry_4.resp = v[7];
+
+	if (!ally_resp_curve_is_valid(&curve))
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->resp_curve_support)
+		return -EOPNOTSUPP;
+
+	ret = ally_set_joystick_resp_curve(ally, hdev,
+					   is_left ? JOYSTICK_LEFT : JOYSTICK_RIGHT,
+					   &curve);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set joystick response curve: %d\n", ret);
+		return ret;
+	}
+
+	/* Only a curve the controller accepted becomes the recorded one. */
+	cached = is_left ? &cfg->left_curve : &cfg->right_curve;
+	*cached = curve;
+
+	sysfs_notify(&dev->kobj,
+		     is_left ? "left_joystick_axis" : "right_joystick_axis",
+		     "response_curve");
+
+	return count;
+}
+
+static ssize_t left_response_curve_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	return response_curve_show(cfg, true, buf);
+}
+
+static ssize_t left_response_curve_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	return response_curve_store(dev, ally, hdev, cfg, true, buf, count);
+}
+
+static ssize_t right_response_curve_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	return response_curve_show(cfg, false, buf);
+}
+
+static ssize_t right_response_curve_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	return response_curve_store(dev, ally, hdev, cfg, false, buf, count);
+}
+
+static ssize_t response_curve_index_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf,
+			  "move_1 resp_1 move_2 resp_2 move_3 resp_3 move_4 resp_4\n"
+			  "\n"
+			  "move_N: joystick deflection percentage at which curve point N\n"
+			  "is placed (0-100, each move_N must be greater than the\n"
+			  "previous one). resp_N: response percentage applied from\n"
+			  "point N on (0-100).\n");
+}
+
+static struct device_attribute dev_attr_left_response_curve =
+	__ATTR(response_curve, 0644, left_response_curve_show, left_response_curve_store);
+static struct device_attribute dev_attr_right_response_curve =
+	__ATTR(response_curve, 0644, right_response_curve_show, right_response_curve_store);
+static struct device_attribute dev_attr_left_response_curve_index =
+	__ATTR(response_curve_index, 0444, response_curve_index_show, NULL);
+static struct device_attribute dev_attr_right_response_curve_index =
+	__ATTR(response_curve_index, 0444, response_curve_index_show, NULL);
+
+
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
 	NULL
@@ -1948,6 +2194,8 @@ static struct attribute *left_joystick_axis_attrs[] = {
 	&dev_attr_left_joystick_outer_threshold_range.attr,
 	&dev_attr_left_joystick_anti_deadzone.attr,
 	&dev_attr_left_joystick_anti_deadzone_range.attr,
+	&dev_attr_left_response_curve.attr,
+	&dev_attr_left_response_curve_index.attr,
 	NULL
 };
 
@@ -1958,6 +2206,8 @@ static struct attribute *right_joystick_axis_attrs[] = {
 	&dev_attr_right_joystick_outer_threshold_range.attr,
 	&dev_attr_right_joystick_anti_deadzone.attr,
 	&dev_attr_right_joystick_anti_deadzone_range.attr,
+	&dev_attr_right_response_curve.attr,
+	&dev_attr_right_response_curve_index.attr,
 	NULL
 };
 
@@ -2073,6 +2323,25 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 		cfg->right_trigger_max = 100;
 		cfg->vibration_intensity_left = 100;
 		cfg->vibration_intensity_right = 100;
+
+		/* Initialize default response curve values (linear) */
+		cfg->left_curve.entry_1.move = 0;
+		cfg->left_curve.entry_1.resp = 0;
+		cfg->left_curve.entry_2.move = 33;
+		cfg->left_curve.entry_2.resp = 33;
+		cfg->left_curve.entry_3.move = 66;
+		cfg->left_curve.entry_3.resp = 66;
+		cfg->left_curve.entry_4.move = 100;
+		cfg->left_curve.entry_4.resp = 100;
+
+		cfg->right_curve.entry_1.move = 0;
+		cfg->right_curve.entry_1.resp = 0;
+		cfg->right_curve.entry_2.move = 33;
+		cfg->right_curve.entry_2.resp = 33;
+		cfg->right_curve.entry_3.move = 66;
+		cfg->right_curve.entry_3.resp = 66;
+		cfg->right_curve.entry_4.move = 100;
+		cfg->right_curve.entry_4.resp = 100;
 	}
 
 	spin_lock_irqsave(&ally_data_lock, flags);
@@ -2090,10 +2359,11 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
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
 		int cal_i;
 
 		for (cal_i = 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups);
@@ -2482,6 +2752,28 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 					 ret);
 	}
 
+	if (cfg->resp_curve_support) {
+		/*
+		 * The MCU does not keep the response curve across a reset:
+		 * send the recorded curves again. A write to the sysfs
+		 * attribute validates and applies the curve atomically, so
+		 * the cache always holds one the controller accepted.
+		 */
+		ret = ally_set_joystick_resp_curve(ally, hdev, JOYSTICK_LEFT,
+						   &cfg->left_curve);
+		if (ret < 0)
+			hid_warn(hdev,
+				 "Failed to restore left response curve: %d\n",
+				 ret);
+
+		ret = ally_set_joystick_resp_curve(ally, hdev, JOYSTICK_RIGHT,
+						   &cfg->right_curve);
+		if (ret < 0)
+			hid_warn(hdev,
+				 "Failed to restore right response curve: %d\n",
+				 ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

