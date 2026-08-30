Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF936196A
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788133412; cv=none; b=b09Mpb/NrCUQYV5bma4K6Ns1+6OhCKT8hd8CX9RA6A5WLgc7bT7A9qJz77pzgkdS76ER8SavZ7MupLTWMobMVMqXQCgJ3WCqHiM8LirKAxH+riPQO+pRzsgtUo8kDVcGFC9MHzSbEsXtkd+76AUydlSrySpL5kRAnL0XhG6VJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788133412; c=relaxed/simple;
	bh=lOArBZ4SHpSPpfqb1U+Fn9BBtFa7NaAhnNuuCHRhUl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t71D+KKrlo39XmuhibUAq4984c4ECbBfbsgHj6xpN3mLK33LZGdtJodFVGkjKaObfZVlVDo7Hltu3+58F3EYvYDne/K8/YrpSyAUUHrr84PtpdukMiBqXZaEARIRN5/14/BPmAoAUzA0VMCBAPwqXJ2jWXCnptjJ+RXm1wk6Y0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sShRi5C1; arc=none smtp.client-ip=91.218.175.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sShRi5C1"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lOArBZ4SHpSPpfqb1U+Fn9BBtFa7NaAhnNuuCHRhUl0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788133408; v=1; x=1788738208;
 b=sShRi5C1iKGYN0dpP1Q9hqvJHwGk1XtGy4et8XaWKM4hvVf5vbDpuD6IEopaJ8u57X7E5qs1
 g4ex4MJaAXtX4Glah1vQKC8hQ/D4qtUw48uUe74HtT/oOWagYSsgi8BmoaNNC9neJ1RRCQnFoj3
 DKLwxJfHrYDifnn5TvEyRjhs=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7fa101e621775e1d;
	Sun, 30 Aug 2026 23:43:28 +0000
X-Mizu-Trace-ID: 7fa101e621775e1d
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
Subject: [PATCH v4 05/13] HID: asus: add vibration strength configuration
Date: Sun, 30 Aug 2026 23:43:12 +0000
Message-ID: <20260830234320.114356-6-denis.benato@linux.dev>
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

ASUS ROG Ally handhelds support the vibration strength to be configured:
add sysfs attributes to allow userspace configure motors vibration
intensity.

Assisted-by: opencode:glm-5.2
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 184 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 7fdb77432171..f825d650e1b7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -206,6 +206,10 @@ struct ally_config {
 	u8 left_trigger_max;
 	u8 right_trigger_min;
 	u8 right_trigger_max;
+
+	/* Vibration settings */
+	u8 vibration_intensity_left;
+	u8 vibration_intensity_right;
 };
 
 struct ally_handheld {
@@ -811,15 +815,193 @@ static ssize_t xbox_controller_store(struct device *dev,
 
 static DEVICE_ATTR_RW(xbox_controller);
 
+/**
+ * ally_set_vibration_intensity() - Set vibration intensity values
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @left: Left motor intensity (0-100)
+ * @right: Right motor intensity (0-100)
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_set_vibration_intensity(struct ally_handheld *ally,
+					struct hid_device *hdev, u8 left, u8 right)
+{
+	const u8 data[] = { left, right };
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_VIBRATION_INTENSITY, data, sizeof(data));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set vibration intensity: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t left_vibration_intensity_show(struct device *dev, struct device_attribute *attr,
+					     char *buf)
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
+	guard(mutex)(&cfg->config_mutex);
+
+	return sysfs_emit(buf, "%u\n", cfg->vibration_intensity_left);
+}
+
+static ssize_t left_vibration_intensity_store(struct device *dev, struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
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
+	ret = ally_set_vibration_intensity(ally, hdev, value,
+					   cfg->vibration_intensity_right);
+	if (ret < 0)
+		return ret;
+
+	cfg->vibration_intensity_left = value;
+
+	return count;
+}
+
+static ssize_t left_vibration_intensity_range_show(struct device *dev,
+						   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0 100\n");
+}
+
+static ssize_t right_vibration_intensity_show(struct device *dev, struct device_attribute *attr,
+					      char *buf)
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
+	guard(mutex)(&cfg->config_mutex);
+
+	return sysfs_emit(buf, "%u\n", cfg->vibration_intensity_right);
+}
+
+static ssize_t right_vibration_intensity_store(struct device *dev, struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
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
+	ret = ally_set_vibration_intensity(ally, hdev,
+					   cfg->vibration_intensity_left, value);
+	if (ret < 0)
+		return ret;
+
+	cfg->vibration_intensity_right = value;
+
+	return count;
+}
+
+static ssize_t right_vibration_intensity_range_show(struct device *dev,
+						    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0 100\n");
+}
+
+static struct device_attribute dev_attr_left_vibration_intensity =
+	__ATTR(intensity, 0644, left_vibration_intensity_show, left_vibration_intensity_store);
+
+static struct device_attribute dev_attr_left_vibration_intensity_range =
+	__ATTR(intensity_range, 0444, left_vibration_intensity_range_show, NULL);
+
+static struct device_attribute dev_attr_right_vibration_intensity =
+	__ATTR(intensity, 0644, right_vibration_intensity_show, right_vibration_intensity_store);
+
+static struct device_attribute dev_attr_right_vibration_intensity_range =
+	__ATTR(intensity_range, 0444, right_vibration_intensity_range_show, NULL);
+
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
 	NULL
 };
 
+static struct attribute *ally_left_vibration_attrs[] = {
+	&dev_attr_left_vibration_intensity.attr,
+	&dev_attr_left_vibration_intensity_range.attr,
+	NULL
+};
+
+static struct attribute *ally_right_vibration_attrs[] = {
+	&dev_attr_right_vibration_intensity.attr,
+	&dev_attr_right_vibration_intensity_range.attr,
+	NULL
+};
+
 static const struct attribute_group ally_attr_groups[] = {
 	{
 		.attrs = ally_config_attrs,
 	},
+	{
+		.name = "left_vibration",
+		.attrs = ally_left_vibration_attrs,
+	},
+	{
+		.name = "right_vibration",
+		.attrs = ally_right_vibration_attrs,
+	},
 };
 
 /**
@@ -851,6 +1033,8 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 	cfg->left_outer_threshold = 90;
 	cfg->right_deadzone = 10;
 	cfg->right_outer_threshold = 90;
+	cfg->vibration_intensity_left = 100;
+	cfg->vibration_intensity_right = 100;
 
 	for (sysfs_i = 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
 		ret = devm_device_add_group(&hdev->dev, &ally_attr_groups[sysfs_i]);
-- 
2.47.3

