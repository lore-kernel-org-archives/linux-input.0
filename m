Received: from mta0.migadu.com (out-55.mta0.migadu.com [91.218.175.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF063D5C2C
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169536; cv=none; b=FjCZi5Lu9DDolXR3xdXv8R3MN1Kv5HlaIzvso1LVA9uRpTIZPm8zIiOSaauzOZvcKYs890Es/AVXnvCgkV5VxCUxjgXEjF5TVBh7C4TWftX8xZzaRtwNitPo+4kVV2MfB1Uu/T2upXiwVnZ2gjGyqcqhwnXUjGZVieGO5rrKosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169536; c=relaxed/simple;
	bh=6W5dQYLYq8qhAyR9kgA0YDP+18qCGfzEf1JbSUw8hy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHEJ5IiBH6ZP0nv1TzQuAgOL+GstMwVj1ej4gnzUIJtkxhhWdJp7Kb40LJIs73FDim6AQF3gnLXv4sDFBgrzVDMqb+CmfewXwvpyZDz2eGykC54EG1ZeeT0+OyVBiYaeTCXep+NGh+S+XzC0bmlBId5Z51CPojwOCEylBQLkGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F99OWK/j; arc=none smtp.client-ip=91.218.175.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F99OWK/j"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6W5dQYLYq8qhAyR9kgA0YDP+18qCGfzEf1JbSUw8hy4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787169531; v=1; x=1787774331;
 b=F99OWK/jhuxNbL1/IGCoErrrdv2/CZwX7U3KQ09NyQYKlgahjC7LeQfXxZSZribHY9HwjYSX
 +NyXTTkdtAfyyP/X3M6gVqcgQCgaCRWFNuKtAMdrXb+mBbHJnAMMfFPdY6cf/UwkhW9BYn+iuRG
 boLLS0xpCXqOHJWxKjBoQUL8=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id c2be8fcfb74c65c6;
	Wed, 19 Aug 2026 19:58:51 +0000
X-Mizu-Trace-ID: c2be8fcfb74c65c6
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
Subject: [PATCH v2 07/12] HID: asus: add joysticks anti-deadzone configuration
Date: Wed, 19 Aug 2026 19:58:30 +0000
Message-ID: <20260819195835.1649657-8-denis.benato@linux.dev>
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

ROG Ally devices allow configuring the anti-deadzone parameter for
the resistive joysticks devices as over time those develops drift,
therefore allow userspace to configure the anti-deadzone by exposing
relevant sysfs attributes.

Assisted-by: opencode:glm-5.2
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 189 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 23a0cec2de15..050d979f4315 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1247,6 +1247,191 @@ static struct device_attribute dev_attr_right_joystick_outer_threshold =
 static struct device_attribute dev_attr_right_joystick_outer_threshold_range =
 	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_range_show, NULL);
 
+/**
+ * ally_set_anti_deadzone() - Set anti-deadzone values for joysticks
+ * @hdev: HID device
+ * @cfg: ally config
+ * @left_adz: left joystick anti-deadzone value (0-100)
+ * @right_adz: right joystick anti-deadzone value (0-100)
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_set_anti_deadzone(struct hid_device *hdev, struct ally_config *cfg,
+				  u8 left_adz, u8 right_adz)
+{
+	const u8 payload[] = { left_adz, right_adz };
+	int ret;
+
+	if (!cfg->anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_ANTI_DEADZONE, payload, sizeof(payload));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_dev_set_report(hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set anti-deadzone values: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t left_joystick_anti_deadzone_show(struct device *dev, struct device_attribute *attr,
+						char *buf)
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
+	scoped_guard(mutex, &cfg->config_mutex) {
+		if (!cfg->anti_deadzone_support) {
+			hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+			return -EOPNOTSUPP;
+		}
+
+		return sysfs_emit(buf, "%u\n", cfg->left_anti_deadzone);
+	}
+}
+
+static ssize_t left_joystick_anti_deadzone_store(struct device *dev, struct device_attribute *attr,
+						 const char *buf, size_t count)
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
+	if (ret || value > 100)
+		return -EINVAL;
+
+	scoped_guard(mutex, &cfg->config_mutex) {
+		if (!cfg->anti_deadzone_support) {
+			hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+			return -EOPNOTSUPP;
+		}
+
+		ret = ally_set_anti_deadzone(hdev, cfg, value, cfg->right_anti_deadzone);
+		if (ret)
+			return ret;
+
+		cfg->left_anti_deadzone = value;
+	}
+
+	return count;
+}
+
+static ssize_t left_joystick_anti_deadzone_range_show(struct device *dev,
+						       struct device_attribute *attr,
+						       char *buf)
+{
+	return sysfs_emit(buf, "0 100\n");
+}
+
+static ssize_t right_joystick_anti_deadzone_show(struct device *dev, struct device_attribute *attr,
+						char *buf)
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
+	scoped_guard(mutex, &cfg->config_mutex) {
+		if (!cfg->anti_deadzone_support) {
+			hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+			return -EOPNOTSUPP;
+		}
+
+		return sysfs_emit(buf, "%u\n", cfg->right_anti_deadzone);
+	}
+}
+
+static ssize_t right_joystick_anti_deadzone_store(struct device *dev, struct device_attribute *attr,
+						 const char *buf, size_t count)
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
+	if (ret || value > 100)
+		return -EINVAL;
+
+	scoped_guard(mutex, &cfg->config_mutex) {
+		if (!cfg->anti_deadzone_support) {
+			hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+			return -EOPNOTSUPP;
+		}
+
+		ret = ally_set_anti_deadzone(hdev, cfg, cfg->left_anti_deadzone, value);
+		if (ret)
+			return ret;
+
+		cfg->right_anti_deadzone = value;
+	}
+
+	return count;
+}
+
+static ssize_t right_joystick_anti_deadzone_range_show(struct device *dev,
+							struct device_attribute *attr,
+							char *buf)
+{
+	return sysfs_emit(buf, "0 100\n");
+}
+
+static struct device_attribute dev_attr_left_joystick_anti_deadzone =
+	__ATTR(anti_deadzone, 0644, left_joystick_anti_deadzone_show,
+	       left_joystick_anti_deadzone_store);
+
+static struct device_attribute dev_attr_left_joystick_anti_deadzone_range =
+	__ATTR(anti_deadzone_range, 0444, left_joystick_anti_deadzone_range_show, NULL);
+
+static struct device_attribute dev_attr_right_joystick_anti_deadzone =
+	__ATTR(anti_deadzone, 0644, right_joystick_anti_deadzone_show,
+	       right_joystick_anti_deadzone_store);
+
+static struct device_attribute dev_attr_right_joystick_anti_deadzone_range =
+	__ATTR(anti_deadzone_range, 0444, right_joystick_anti_deadzone_range_show, NULL);
+
 /**
  * ally_set_trigger_ranges() - Generic function to set triggers ranges
  * @hdev: HID device
@@ -1586,6 +1771,8 @@ static struct attribute *left_joystick_axis_attrs[] = {
 	&dev_attr_left_joystick_outer_threshold.attr,
 	&dev_attr_left_joystick_inner_threshold_range.attr,
 	&dev_attr_left_joystick_outer_threshold_range.attr,
+	&dev_attr_left_joystick_anti_deadzone.attr,
+	&dev_attr_left_joystick_anti_deadzone_range.attr,
 	NULL
 };
 
@@ -1594,6 +1781,8 @@ static struct attribute *right_joystick_axis_attrs[] = {
 	&dev_attr_right_joystick_outer_threshold.attr,
 	&dev_attr_right_joystick_inner_threshold_range.attr,
 	&dev_attr_right_joystick_outer_threshold_range.attr,
+	&dev_attr_right_joystick_anti_deadzone.attr,
+	&dev_attr_right_joystick_anti_deadzone_range.attr,
 	NULL
 };
 
-- 
2.47.3

