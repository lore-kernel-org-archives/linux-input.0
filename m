Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7411BD9C9
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511569; cv=none; b=MP5wg0q4cnz4Xf+tTazeIywcEtsRxtUYpknAwGJnClsTIYCJM7D1V90jayPEaj1hObFsWfCedxBQNlmLmwLdvO4rM4os0dv7pSFcSJgeFK9WtYEoWmkcaE3JNmKRBflZ3ETkz63YrHmzkJ/xiKHb2q1rRy8D3GqhdpPUFqoeSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511569; c=relaxed/simple;
	bh=0FUVwcYa5idPQZVLqzitt5ofAJHuKoalvxB4LenBLf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHSUbbejKsgqGHtuf9am4BM8MzjIotKAlVIcpGsHFJjrChpu9wQFR8rfOIL6v5+LzQ3CqfgZMokNRu+MSTUBYs12U1vuJr/R1eFF0HYnFqSBFwCRQX8GX0ncC6wBWBhSeHaQCQVprbUNOJH+3vXrIakD+BaMYuKQp1YqO2WaZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uiDL6O8/; arc=none smtp.client-ip=91.218.175.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uiDL6O8/"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0FUVwcYa5idPQZVLqzitt5ofAJHuKoalvxB4LenBLf8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787511564; v=1; x=1788116364;
 b=uiDL6O8/9MKiQTOImBCpRVHpJY+wv9T9OyNQBR80YUId/NRrlSgWXnYwC9bBwcvlY+SgnHMd
 9XGtYi8gv7mTdGn0k9Ghoq3A3SaWm4f6w63lamfMMyDw8QV60fSHo8Ju3usbBcdr1qjoQ1SLXkn
 fTnUsIKQRnBYCPIVN+Sg2rUE=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 011ea33fe7188fdd;
	Sun, 23 Aug 2026 18:59:24 +0000
X-Mizu-Trace-ID: 011ea33fe7188fdd
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
Subject: [PATCH v3 11/12] HID: asus: add support for turbo buttons
Date: Sun, 23 Aug 2026 18:58:48 +0000
Message-ID: <20260823185849.2478673-12-denis.benato@linux.dev>
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

ROG ally devices supports a feature called turbo buttons that allows
the user to quickly toggle button state by keeping a button pressed,
therefore allow userspace to configure the feature by exposing
relevant sysfs attributes.

Assisted-by: opencode:glm-5.2
Assisted-by: Claude:claude-fable-5
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>

# Conflicts:
#	drivers/hid/hid-asus.c
---
 drivers/hid/hid-asus.c | 472 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 464 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 258d63f4233e..241f27511deb 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -198,6 +198,99 @@ struct ally_joystick_resp_curve {
 	struct ally_joystick_resp_curve_param entry_4;
 } __packed;
 
+/* Button identifiers for the turbo attribute system */
+enum ally_button_id {
+	ALLY_BTN_A,
+	ALLY_BTN_B,
+	ALLY_BTN_X,
+	ALLY_BTN_Y,
+	ALLY_BTN_LB,
+	ALLY_BTN_RB,
+	ALLY_BTN_DU,
+	ALLY_BTN_DD,
+	ALLY_BTN_DL,
+	ALLY_BTN_DR,
+	ALLY_BTN_J0B,
+	ALLY_BTN_J1B,
+	ALLY_BTN_MENU,
+	ALLY_BTN_VIEW,
+	ALLY_BTN_M1,
+	ALLY_BTN_M2,
+	ALLY_BTN_MAX
+};
+
+/* Names for the button directories in sysfs */
+static const char *const ally_button_names[ALLY_BTN_MAX] = {
+	[ALLY_BTN_A] = "btn_a",
+	[ALLY_BTN_B] = "btn_b",
+	[ALLY_BTN_X] = "btn_x",
+	[ALLY_BTN_Y] = "btn_y",
+	[ALLY_BTN_LB] = "btn_lb",
+	[ALLY_BTN_RB] = "btn_rb",
+	[ALLY_BTN_DU] = "dpad_up",
+	[ALLY_BTN_DD] = "dpad_down",
+	[ALLY_BTN_DL] = "dpad_left",
+	[ALLY_BTN_DR] = "dpad_right",
+	[ALLY_BTN_J0B] = "btn_l3",
+	[ALLY_BTN_J1B] = "btn_r3",
+	[ALLY_BTN_MENU] = "btn_menu",
+	[ALLY_BTN_VIEW] = "btn_view",
+	[ALLY_BTN_M1] = "btn_m1",
+	[ALLY_BTN_M2] = "btn_m2",
+};
+
+/*
+ * Button turbo parameters structure
+ * Each button can have:
+ * - turbo: Turbo press interval in multiples of 50ms (0 = disabled, 1-20 = 50ms-1000ms)
+ * - toggle: Toggle interval (0 = disabled)
+ */
+struct ally_btn_turbo_params {
+	u8 turbo;
+	u8 toggle;
+} __packed;
+
+#define ALLY_TURBO_PERIOD_MIN 0
+#define ALLY_TURBO_PERIOD_MAX 20
+#define ALLY_TOGGLE_PERIOD_MIN 0
+#define ALLY_TOGGLE_PERIOD_MAX 255
+
+/* Collection of all button turbo settings */
+struct ally_turbo_config {
+	struct ally_btn_turbo_params btn_du;
+	struct ally_btn_turbo_params btn_dd;
+	struct ally_btn_turbo_params btn_dl;
+	struct ally_btn_turbo_params btn_dr;
+	struct ally_btn_turbo_params btn_j0b;
+	struct ally_btn_turbo_params btn_j1b;
+	struct ally_btn_turbo_params btn_lb;
+	struct ally_btn_turbo_params btn_rb;
+	struct ally_btn_turbo_params btn_a;
+	struct ally_btn_turbo_params btn_b;
+	struct ally_btn_turbo_params btn_x;
+	struct ally_btn_turbo_params btn_y;
+	struct ally_btn_turbo_params btn_view;
+	struct ally_btn_turbo_params btn_menu;
+	struct ally_btn_turbo_params btn_m2;
+	struct ally_btn_turbo_params btn_m1;
+};
+
+struct ally_btn_sysfs_entry {
+	struct attribute_group group;
+	struct attribute *attrs[5]; /* turbo_period + toggle_period + ranges + NULL */
+	/*
+	 * The entries are created while hid_asus_ally_probe() is still running,
+	 * before asus_probe() publishes drvdata->rog_ally: carrying the shared
+	 * state pointer here avoids dereferencing that not-yet-assigned field.
+	 */
+	struct ally_handheld *ally;
+	struct ally_config *cfg;
+	struct hid_device *hdev;
+	enum ally_button_id btn;
+	struct device_attribute attr_turbo_period;
+	struct device_attribute attr_toggle_period;
+};
+
 struct ally_config {
 	/* Must be locked if the data is being changed */
 	struct mutex config_mutex;
@@ -231,6 +324,9 @@ struct ally_config {
 	u8 vibration_intensity_left;
 	u8 vibration_intensity_right;
 
+	struct ally_turbo_config turbo;
+	struct ally_btn_sysfs_entry *button_entries;
+
 	struct ally_joystick_resp_curve left_curve;
 	struct ally_joystick_resp_curve right_curve;
 };
@@ -2583,6 +2679,336 @@ static const struct attribute_group *const ally_cal_attr_groups[] = {
 	&ally_right_trigger_group,
 };
 
+/**
+ * ally_set_turbo_params() - Set turbo parameters for all buttons
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @cfg: ally config structure
+ *
+ * The payload mirrors the whole per-button turbo configuration, so the
+ * caller must hold cfg->config_mutex: building it locklessly could send a
+ * mix of parameters from concurrent sysfs writes to the hardware.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_set_turbo_params(struct ally_handheld *ally,
+				 struct hid_device *hdev,
+				 struct ally_config *cfg)
+{
+	struct ally_turbo_config *turbo = &cfg->turbo;
+	const u8 payload[] = {
+		turbo->btn_du.turbo,
+		turbo->btn_du.toggle,
+		turbo->btn_dd.turbo,
+		turbo->btn_dd.toggle,
+		turbo->btn_dl.turbo,
+		turbo->btn_dl.toggle,
+		turbo->btn_dr.turbo,
+		turbo->btn_dr.toggle,
+		turbo->btn_j0b.turbo,
+		turbo->btn_j0b.toggle,
+		turbo->btn_j1b.turbo,
+		turbo->btn_j1b.toggle,
+		turbo->btn_lb.turbo,
+		turbo->btn_lb.toggle,
+		turbo->btn_rb.turbo,
+		turbo->btn_rb.toggle,
+		turbo->btn_a.turbo,
+		turbo->btn_a.toggle,
+		turbo->btn_b.turbo,
+		turbo->btn_b.toggle,
+		turbo->btn_x.turbo,
+		turbo->btn_x.toggle,
+		turbo->btn_y.turbo,
+		turbo->btn_y.toggle,
+		turbo->btn_view.turbo,
+		turbo->btn_view.toggle,
+		turbo->btn_menu.turbo,
+		turbo->btn_menu.toggle,
+		turbo->btn_m2.turbo,
+		turbo->btn_m2.toggle,
+		turbo->btn_m1.turbo,
+		turbo->btn_m1.toggle,
+	};
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_TURBO_PARAMS, payload, sizeof(payload));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set turbo parameters: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct ally_btn_turbo_params *ally_btn_get_turbo_params(struct ally_config *cfg,
+							       enum ally_button_id btn)
+{
+	switch (btn) {
+	case ALLY_BTN_DU: return &cfg->turbo.btn_du;
+	case ALLY_BTN_DD: return &cfg->turbo.btn_dd;
+	case ALLY_BTN_DL: return &cfg->turbo.btn_dl;
+	case ALLY_BTN_DR: return &cfg->turbo.btn_dr;
+	case ALLY_BTN_J0B: return &cfg->turbo.btn_j0b;
+	case ALLY_BTN_J1B: return &cfg->turbo.btn_j1b;
+	case ALLY_BTN_LB: return &cfg->turbo.btn_lb;
+	case ALLY_BTN_RB: return &cfg->turbo.btn_rb;
+	case ALLY_BTN_A: return &cfg->turbo.btn_a;
+	case ALLY_BTN_B: return &cfg->turbo.btn_b;
+	case ALLY_BTN_X: return &cfg->turbo.btn_x;
+	case ALLY_BTN_Y: return &cfg->turbo.btn_y;
+	case ALLY_BTN_VIEW: return &cfg->turbo.btn_view;
+	case ALLY_BTN_MENU: return &cfg->turbo.btn_menu;
+	case ALLY_BTN_M2: return &cfg->turbo.btn_m2;
+	case ALLY_BTN_M1: return &cfg->turbo.btn_m1;
+	default: return NULL;
+	}
+}
+
+static ssize_t btn_turbo_period_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct ally_btn_sysfs_entry *entry = container_of(attr, struct ally_btn_sysfs_entry,
+							  attr_turbo_period);
+	struct ally_btn_turbo_params *params;
+
+	if (!entry->cfg->turbo_support)
+		return -EOPNOTSUPP;
+
+	params = ally_btn_get_turbo_params(entry->cfg, entry->btn);
+	if (!params)
+		return -ENODEV;
+
+	guard(mutex)(&entry->cfg->config_mutex);
+
+	return sysfs_emit(buf, "%hhu\n", params->turbo);
+}
+
+static ssize_t btn_turbo_period_store(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct ally_btn_sysfs_entry *entry = container_of(attr, struct ally_btn_sysfs_entry,
+							  attr_turbo_period);
+	struct ally_btn_turbo_params *params;
+	u8 old_value, value;
+	int ret;
+
+	if (!entry->cfg->turbo_support)
+		return -EOPNOTSUPP;
+
+	params = ally_btn_get_turbo_params(entry->cfg, entry->btn);
+	if (!params)
+		return -ENODEV;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value < ALLY_TURBO_PERIOD_MIN || value > ALLY_TURBO_PERIOD_MAX)
+		return -EINVAL;
+
+	guard(mutex)(&entry->cfg->config_mutex);
+
+	old_value = params->turbo;
+	params->turbo = value;
+	ret = ally_set_turbo_params(entry->ally, entry->hdev, entry->cfg);
+	if (ret) {
+		/*
+		 * The hardware rejected the update: restore the old
+		 * value or a later write to another button would
+		 * flush this stale one to the device.
+		 */
+		params->turbo = old_value;
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t btn_toggle_period_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct ally_btn_sysfs_entry *entry = container_of(attr, struct ally_btn_sysfs_entry,
+							  attr_toggle_period);
+	struct ally_btn_turbo_params *params;
+
+	if (!entry->cfg->turbo_support)
+		return -EOPNOTSUPP;
+
+	params = ally_btn_get_turbo_params(entry->cfg, entry->btn);
+	if (!params)
+		return -ENODEV;
+
+	guard(mutex)(&entry->cfg->config_mutex);
+
+	return sysfs_emit(buf, "%hhu\n", params->toggle);
+}
+
+static ssize_t btn_toggle_period_store(struct device *dev, struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct ally_btn_sysfs_entry *entry = container_of(attr, struct ally_btn_sysfs_entry,
+							  attr_toggle_period);
+	struct ally_btn_turbo_params *params;
+	u8 old_value, value;
+	int ret;
+
+	if (!entry->cfg->turbo_support)
+		return -EOPNOTSUPP;
+
+	params = ally_btn_get_turbo_params(entry->cfg, entry->btn);
+	if (!params)
+		return -ENODEV;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value < ALLY_TOGGLE_PERIOD_MIN || value > ALLY_TOGGLE_PERIOD_MAX)
+		return -EINVAL;
+
+	guard(mutex)(&entry->cfg->config_mutex);
+
+	old_value = params->toggle;
+	params->toggle = value;
+	ret = ally_set_turbo_params(entry->ally, entry->hdev, entry->cfg);
+	if (ret) {
+		/*
+		 * The hardware rejected the update: restore the old
+		 * value or a later write to another button would
+		 * flush this stale one to the device.
+		 */
+		params->toggle = old_value;
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t btn_turbo_period_range_show(struct device *dev,
+					   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0 20\n");
+}
+
+static ssize_t btn_toggle_period_range_show(struct device *dev,
+					    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0 255\n");
+}
+
+static struct device_attribute dev_attr_btn_turbo_period_range =
+	__ATTR(turbo_period_range, 0444, btn_turbo_period_range_show, NULL);
+
+static struct device_attribute dev_attr_btn_toggle_period_range =
+	__ATTR(toggle_period_range, 0444, btn_toggle_period_range_show, NULL);
+
+static void ally_btn_turbo_init_attrs(struct ally_btn_sysfs_entry *entry)
+{
+	sysfs_attr_init(&entry->attr_turbo_period.attr);
+	entry->attr_turbo_period.attr.name = "turbo_period";
+	entry->attr_turbo_period.attr.mode = 0644;
+	entry->attr_turbo_period.show = btn_turbo_period_show;
+	entry->attr_turbo_period.store = btn_turbo_period_store;
+
+	sysfs_attr_init(&entry->attr_toggle_period.attr);
+	entry->attr_toggle_period.attr.name = "toggle_period";
+	entry->attr_toggle_period.attr.mode = 0644;
+	entry->attr_toggle_period.show = btn_toggle_period_show;
+	entry->attr_toggle_period.store = btn_toggle_period_store;
+	entry->attrs[0] = &entry->attr_turbo_period.attr;
+	entry->attrs[1] = &entry->attr_toggle_period.attr;
+	entry->attrs[2] = &dev_attr_btn_turbo_period_range.attr;
+	entry->attrs[3] = &dev_attr_btn_toggle_period_range.attr;
+	entry->attrs[4] = NULL;
+}
+
+/**
+ * ally_create_button_attributes() - Create turbo button attributes
+ * @hdev: HID device
+ * @ally: ally handheld structure
+ * @cfg: ally config structure
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_create_button_attributes(struct hid_device *hdev,
+					 struct ally_handheld *ally,
+					 struct ally_config *cfg)
+{
+	struct ally_btn_sysfs_entry *entries;
+	int i, ret;
+
+	if (!cfg->turbo_support)
+		return 0;
+
+	entries = devm_kcalloc(&hdev->dev, ALLY_BTN_MAX, sizeof(*entries), GFP_KERNEL);
+	if (!entries)
+		return -ENOMEM;
+
+	cfg->button_entries = entries;
+
+	for (i = 0; i < ALLY_BTN_MAX; i++) {
+		entries[i].ally = ally;
+		entries[i].cfg = cfg;
+		entries[i].hdev = hdev;
+		entries[i].btn = i;
+
+		if (!ally_btn_get_turbo_params(cfg, i)) {
+			hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
+			ret = -EINVAL;
+			goto err_cleanup;
+		}
+
+		ally_btn_turbo_init_attrs(&entries[i]);
+
+		entries[i].group.name = ally_button_names[i];
+		entries[i].group.attrs = entries[i].attrs;
+
+		ret = sysfs_create_group(&hdev->dev.kobj, &entries[i].group);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to create sysfs group for %s: %d\n",
+				ally_button_names[i], ret);
+			goto err_cleanup;
+		}
+	}
+
+	return 0;
+
+err_cleanup:
+	/* Only groups [0, i) were registered; the failure happened at i. */
+	while (--i >= 0)
+		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
+
+	cfg->button_entries = NULL;
+
+	return ret;
+}
+
+/**
+ * ally_remove_button_attributes() - Remove turbo button attributes
+ * @hdev: HID device
+ * @cfg: ally config structure
+ */
+static void ally_remove_button_attributes(struct hid_device *hdev, struct ally_config *cfg)
+{
+	struct ally_btn_sysfs_entry *entries;
+	int i;
+
+	if (!cfg || !cfg->button_entries)
+		return;
+
+	entries = cfg->button_entries;
+
+	for (i = 0; i < ALLY_BTN_MAX; i++)
+		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
+
+	cfg->button_entries = NULL;
+}
+
 /**
  * ally_config_create() - Initialize configuration and create sysfs entries
  * @hdev: HID device
@@ -2633,6 +3059,14 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 		}
 	}
 
+	if (cfg->turbo_support) {
+		ret = ally_create_button_attributes(hdev, ally, cfg);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to create button attributes: %d\n", ret);
+			goto ally_config_create_sysfs_err;
+		}
+	}
+
 	cfg->gamepad_mode = ALLY_GAMEPAD_MODE_GAMEPAD;
 	cfg->left_deadzone = 10;
 	cfg->left_outer_threshold = 90;
@@ -2684,6 +3118,8 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 
 	return cfg;
 ally_config_create_sysfs_err:
+	if (cfg->turbo_support && cfg->button_entries)
+		ally_remove_button_attributes(hdev, cfg);
 ally_config_create_err:
 	devm_kfree(&hdev->dev, cfg);
 	return ERR_PTR(ret);
@@ -2692,14 +3128,18 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 /**
  * ally_config_remove() - Clean up configuration resources
  * @hdev: HID device
- * @ally: Non-NULL Ally device data
+ * @cfg: ally config to clean up, may be NULL
+ *
+ * Must be called in process context: it removes sysfs groups and takes
+ * sleeping locks.
  */
-static void ally_config_remove(struct hid_device *hdev, struct ally_handheld *ally)
+static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
 {
-	struct ally_config *cfg = ally->config;
-
 	if (!cfg || !cfg->initialized)
 		return;
+
+	if (cfg->turbo_support && cfg->button_entries)
+		ally_remove_button_attributes(hdev, cfg);
 }
 
 /**
@@ -3278,7 +3718,12 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 
 		ret = hid_asus_ally_init(hdev, &ally_drvdata);
 		if (ret < 0) {
-			ally_config_remove(hdev, &ally_drvdata);
+			/*
+			 * Pass the config directly: ally_drvdata.config is
+			 * not published yet, and the button sysfs groups
+			 * must be removed before devres frees the config.
+			 */
+			ally_config_remove(hdev, ally_cfg);
 			ally_put_udev_if_orphaned();
 			return ERR_PTR(ret);
 		}
@@ -3326,7 +3771,8 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *ally)
 {
 	unsigned long flags;
-	bool owns_xpad;
+	bool owns_xpad, owns_cfg;
+	struct ally_config *cfg = NULL;
 
 	if (!ally)
 		return;
@@ -3385,13 +3831,23 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
 		ally->keyboard_hdev = NULL;
 	}
 
-	if (ally->cfg_hdev == hdev) {
-		ally_config_remove(hdev, ally);
+	owns_cfg = ally->cfg_hdev == hdev;
+	if (owns_cfg) {
+		cfg = ally->config;
 		ally->cfg_hdev = NULL;
 		ally->config = NULL;
 	}
 	spin_unlock_irqrestore(&ally_data_lock, flags);
 
+	/*
+	 * The config teardown removes sysfs groups and takes sleeping locks:
+	 * it must not run under ally_data_lock. The config pointer has been
+	 * unpublished above, so no new sysfs callback can find it while the
+	 * groups are being removed.
+	 */
+	if (owns_cfg)
+		ally_config_remove(hdev, cfg);
+
 	/*
 	 * Drop the recorded USB device when the last interface of the
 	 * controller has been unbound: the driver is then ready to accept
-- 
2.47.3

