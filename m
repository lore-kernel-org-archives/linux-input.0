Received: from mta0.migadu.com (out-68.mta0.migadu.com [91.218.175.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6C3D88E3
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169542; cv=none; b=Jtk3dhRDDlknKaYM5waYRRgA6JiyfCnA1MEfuae/fiVrBy4Q6HJm93EtmmtGFwEgYg5rh8VrT/Sv/AJG2WAnsRPa3LW3hykGYMH0rJ7vX1eFTELkezZ283nQFCneR9llhwMBvBSK8QH9YMBzfkoAYxXbcUnm1ifXHueGle2Cys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169542; c=relaxed/simple;
	bh=qtBP3ySmNSAo6FsCV/w2Ci2+KAvrVo6rczN3Ggl31rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR1ZdRLlaIaT5R1BtTz+UN5ZH9F1H7RUVYyPHs7l3cEu5IToHhL4nXYVI4TzEGIMQdJp5WSOPrTH8nfkk8LaIGM+mwvqjLwBYMr4eXSHKHvU1rPLfRd8tOlfXiuyrbi+sY9O/74vICUyEXr685d9zbIyztQSVh8MogWM21beH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gS/3veG4; arc=none smtp.client-ip=91.218.175.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gS/3veG4"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qtBP3ySmNSAo6FsCV/w2Ci2+KAvrVo6rczN3Ggl31rw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787169538; v=1; x=1787774338;
 b=gS/3veG4fXXZeTi5b+zHJhA8PzKVhuCTpcpf3WKxofhT+vJ3kexp+cwHeG8H727LLOrVxI/0
 8kxyQI+M10gWctZSJ9a4qobyYIBjZcPrgEPnHiyHekIwp6BKa0wYmXRipivb6XEY0v5VXAVckV9
 0UTFTRu/t+5spV7Lk2FqLfHY=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 0c77cd5d5c921457;
	Wed, 19 Aug 2026 19:58:58 +0000
X-Mizu-Trace-ID: 0c77cd5d5c921457
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
Subject: [PATCH v2 11/12] HID: asus: add support for turbo buttons
Date: Wed, 19 Aug 2026 19:58:34 +0000
Message-ID: <20260819195835.1649657-12-denis.benato@linux.dev>
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
---
 drivers/hid/hid-asus.c | 414 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 414 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 6be25cc022cb..d6ab906b7e78 100644
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
@@ -2456,6 +2552,311 @@ static const struct attribute_group ally_attr_groups[] = {
 	},
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
+	struct ally_btn_turbo_params *params = ally_btn_get_turbo_params(entry->cfg,
+									 entry->btn);
+
+	if (!params)
+		return -ENODEV;
+
+	scoped_guard(mutex, &entry->cfg->config_mutex)
+		return sysfs_emit(buf, "%hhu\n", params->turbo);
+}
+
+static ssize_t btn_turbo_period_store(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct ally_btn_sysfs_entry *entry = container_of(attr, struct ally_btn_sysfs_entry,
+							  attr_turbo_period);
+	struct ally_btn_turbo_params *params;
+	u8 value;
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
+	scoped_guard(mutex, &entry->cfg->config_mutex) {
+		params->turbo = value;
+		ret = ally_set_turbo_params(entry->ally, entry->hdev, entry->cfg);
+		if (ret)
+			return ret;
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
+	struct ally_btn_turbo_params *params = ally_btn_get_turbo_params(entry->cfg, entry->btn);
+
+	if (!params)
+		return -ENODEV;
+
+	scoped_guard(mutex, &entry->cfg->config_mutex)
+		return sysfs_emit(buf, "%hhu\n", params->toggle);
+}
+
+static ssize_t btn_toggle_period_store(struct device *dev, struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct ally_btn_sysfs_entry *entry = container_of(attr, struct ally_btn_sysfs_entry,
+							  attr_toggle_period);
+	struct ally_btn_turbo_params *params;
+	u8 value;
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
+	scoped_guard(mutex, &entry->cfg->config_mutex) {
+		params->toggle = value;
+		ret = ally_set_turbo_params(entry->ally, entry->hdev, entry->cfg);
+		if (ret)
+			return ret;
+	}
+
+	return count;
+}
+
+static ssize_t btn_turbo_period_range_show(struct device *dev,
+					    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0 20\n");
+}
+
+static ssize_t btn_toggle_period_range_show(struct device *dev,
+					     struct device_attribute *attr, char *buf)
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
+					struct ally_handheld *ally,
+					struct ally_config *cfg)
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
@@ -2489,6 +2890,14 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
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
@@ -2540,6 +2949,8 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 
 	return cfg;
 ally_config_create_sysfs_err:
+	if (cfg->turbo_support && cfg->button_entries)
+		ally_remove_button_attributes(hdev, cfg);
 ally_config_create_err:
 	devm_kfree(&hdev->dev, cfg);
 	return ERR_PTR(ret);
@@ -2556,6 +2967,9 @@ static void ally_config_remove(struct hid_device *hdev, struct ally_handheld *al
 
 	if (!cfg || !cfg->initialized)
 		return;
+
+	if (cfg->turbo_support && cfg->button_entries)
+		ally_remove_button_attributes(hdev, cfg);
 }
 
 /**
-- 
2.47.3

