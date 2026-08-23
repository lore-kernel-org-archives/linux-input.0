Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB43A48C5
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511557; cv=none; b=HEzjMt+Gf5gdha/Zsg91JW+t7eTV6mf3gJ+IjXVRIqCI0n6XA9CO6TAl+WZsYqxAup23I6XulBvAc7Q7Tc6rCrfRIxLmGVPXldMCzYZI+TfpMiE5Xht+nbYFp4+aCksZgQsGr+8dYWQc/+NHIbvAMyIE2HvDPxEbngo0CX+pzPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511557; c=relaxed/simple;
	bh=klLjReKzdJjR5AcxwYpoCXaP1I7Qe4hNSfVQhVGD+fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnI6DxkMJZhZcC0ekoMh8L/6CnAMGD0p/hZIVoaW2BpHl6F4qE21HGhqn59HQjKGFEzOOrRXNGyswP9pK5T5Wxsk3zwefIdeGn1xTUkidsgSdbdPXl0rzcU6N/8gZ3TarrYsBOvzSIM2cZaESRVCH/n3bX98+u89MLwuQNEAIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oq64IxVz; arc=none smtp.client-ip=91.218.175.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oq64IxVz"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=klLjReKzdJjR5AcxwYpoCXaP1I7Qe4hNSfVQhVGD+fY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787511552; v=1; x=1788116352;
 b=Oq64IxVzTyqObFGoNr/u3onYNpzgD9gK24TSCwJc8zAVPVjO3rJbDc+b22/zDwqYiPhb45D/
 t/6P42TRuukqlQIVI2NXUF8YNA0sI2e2QKSW6Uy/lwA3m+3mDiVchEhHO7VIJOwO4L6tQtGlKjf
 WD6n0vmRCaqWia9QviRQB7ck=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 183cc7b5c11efc9b;
	Sun, 23 Aug 2026 18:59:12 +0000
X-Mizu-Trace-ID: 183cc7b5c11efc9b
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
Subject: [PATCH v3 07/12] HID: asus: add joysticks anti-deadzone configuration
Date: Sun, 23 Aug 2026 18:58:44 +0000
Message-ID: <20260823185849.2478673-8-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260823185849.2478673-1-denis.benato@linux.dev>
References: <20260823185849.2478673-1-denis.benato@linux.dev>
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
 drivers/hid/hid-asus.c | 198 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index c9828a17e3c0..a4d829f6041c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1318,6 +1318,193 @@ static struct device_attribute dev_attr_right_joystick_outer_threshold =
 static struct device_attribute dev_attr_right_joystick_outer_threshold_range =
 	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_range_show, NULL);
 
+/**
+ * ally_set_anti_deadzone() - Set anti-deadzone values for joysticks
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @cfg: ally config
+ * @left_adz: left joystick anti-deadzone value (0-100)
+ * @right_adz: right joystick anti-deadzone value (0-100)
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_set_anti_deadzone(struct ally_handheld *ally,
+				  struct hid_device *hdev, struct ally_config *cfg,
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
+	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
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
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	return sysfs_emit(buf, "%u\n", cfg->left_anti_deadzone);
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
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = ally_set_anti_deadzone(ally, hdev, cfg, value, cfg->right_anti_deadzone);
+	if (ret)
+		return ret;
+
+	cfg->left_anti_deadzone = value;
+
+	return count;
+}
+
+static ssize_t left_joystick_anti_deadzone_range_show(struct device *dev,
+						      struct device_attribute *attr,
+						      char *buf)
+{
+	return sysfs_emit(buf, "0 100\n");
+}
+
+static ssize_t right_joystick_anti_deadzone_show(struct device *dev, struct device_attribute *attr,
+						 char *buf)
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
+	if (!cfg->anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	return sysfs_emit(buf, "%u\n", cfg->right_anti_deadzone);
+}
+
+static ssize_t right_joystick_anti_deadzone_store(struct device *dev, struct device_attribute *attr,
+						  const char *buf, size_t count)
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
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = ally_set_anti_deadzone(ally, hdev, cfg, cfg->left_anti_deadzone, value);
+	if (ret)
+		return ret;
+
+	cfg->right_anti_deadzone = value;
+
+	return count;
+}
+
+static ssize_t right_joystick_anti_deadzone_range_show(struct device *dev,
+						       struct device_attribute *attr,
+						       char *buf)
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
  * @ally: ally handheld structure
@@ -1684,6 +1871,8 @@ static struct attribute *left_joystick_axis_attrs[] = {
 	&dev_attr_left_joystick_outer_threshold.attr,
 	&dev_attr_left_joystick_inner_threshold_range.attr,
 	&dev_attr_left_joystick_outer_threshold_range.attr,
+	&dev_attr_left_joystick_anti_deadzone.attr,
+	&dev_attr_left_joystick_anti_deadzone_range.attr,
 	NULL
 };
 
@@ -1692,6 +1881,8 @@ static struct attribute *right_joystick_axis_attrs[] = {
 	&dev_attr_right_joystick_outer_threshold.attr,
 	&dev_attr_right_joystick_inner_threshold_range.attr,
 	&dev_attr_right_joystick_outer_threshold_range.attr,
+	&dev_attr_right_joystick_anti_deadzone.attr,
+	&dev_attr_right_joystick_anti_deadzone_range.attr,
 	NULL
 };
 
@@ -1792,8 +1983,11 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 		}
 	}
 
-	/* Skip the calibration groups when the capability is missing. */
-	if (cfg->user_cal_support) {
+	/*
+	 * Skip the calibration and anti-deadzone groups when none of the
+	 * features they expose is supported.
+	 */
+	if (cfg->user_cal_support || cfg->anti_deadzone_support) {
 		for (sysfs_i = 0; sysfs_i < ARRAY_SIZE(ally_cal_attr_groups); sysfs_i++) {
 			ret = devm_device_add_group(&hdev->dev,
 						    ally_cal_attr_groups[sysfs_i]);
-- 
2.47.3

