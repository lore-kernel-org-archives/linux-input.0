Received: from mta1.migadu.com (out-84.mta1.migadu.com [95.215.58.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837494D955C
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548947; cv=none; b=aMMhnUVPzis2Y7+C28sLjPS2v4RLUA2eoYPwnlcc9jLOl6FHCvW6A/+4S0UXgP8/zR/P2dnwcNueyJWDQWX3cTsuHdeNyr72nc8meRLehl4tP+PTIK90n+ETDgDBBeNSuQpYzEBi40oz4sRtubqfVyqWDttPE5px/IuU/0SNr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548947; c=relaxed/simple;
	bh=oxS5Qk2zyriecvsrMRot4UHBCMch8iWKDSa3Gg61o50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zbi70+kKsqTY4BAUoUxjxbYPKCFfnaVwYI3s6fZ0h/sbWnaVcjMV7vz9G7ksGOCxMWC1RCZgVbFCARaDJtpv/A5BaDlCCtF9JVCJqqHmobZDselEo4LcJ7xYGC9rqi2qebPVHfMaAzdHO5v8hQwimK/io6Pu0KgrJzHjk562Qwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gFilPHy+; arc=none smtp.client-ip=95.215.58.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gFilPHy+"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oxS5Qk2zyriecvsrMRot4UHBCMch8iWKDSa3Gg61o50=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791548933; v=1; x=1792153733;
 b=gFilPHy+rKCn51D4vwjOhM5REeyeU7US9WNCkN+cLhVFqiNz4SCiT6SxrueKORnoyWqok5Td
 ipVfbJLWAwETUJ+V/coFe8glI6s1bhmX6oNjC1Ggo46pza3vish3bVirn170VhnKhv2qeA7GI14
 3rd8I7R+sFqs3Kse2m7W6cLs=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c75c356ac7c28dac;
	Fri, 09 Oct 2026 12:28:53 +0000
X-Mizu-Trace-ID: c75c356ac7c28dac
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>,
	Khamunetri Clark <khamunetriclark@gmail.com>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v9 11/12] HID: asus: add support for turbo buttons
Date: Fri,  9 Oct 2026 12:28:19 +0000
Message-ID: <20261009122820.7603-12-denis.benato@linux.dev>
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
 drivers/hid/hid-asus.c | 463 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 463 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index b38293505327..686c9a2a8ca7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -191,6 +191,99 @@ struct ally_joystick_resp_curve {
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
 enum ally_gamepad_mode_index {
 	ALLY_GAMEPAD_MODE_GAMEPAD = 0x01,
 	ALLY_GAMEPAD_MODE_KEYBOARD = 0x02,
@@ -229,6 +322,9 @@ struct ally_config {
 	u8 vibration_intensity_left;
 	u8 vibration_intensity_right;
 
+	struct ally_turbo_config turbo;
+	struct ally_btn_sysfs_entry *button_entries;
+
 	struct ally_joystick_resp_curve left_curve;
 	struct ally_joystick_resp_curve right_curve;
 };
@@ -2458,6 +2554,343 @@ static const struct attribute_group *const ally_cal_attr_groups[] = {
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
+		sysfs_notify(&entry->hdev->dev.kobj, entry->group.name, "turbo_period");
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
+		sysfs_notify(&entry->hdev->dev.kobj, entry->group.name, "toggle_period");
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
+	entries = kcalloc(ALLY_BTN_MAX, sizeof(*entries), GFP_KERNEL);
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
+	while (--i >= 0)
+		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
+
+	kfree(entries);
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
+	kfree(entries);
+
+	cfg->button_entries = NULL;
+}
+
 /**
  * ally_config_create() - Initialize configuration and create sysfs entries
  * @hdev: HID device
@@ -2469,6 +2902,7 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 {
 	struct ally_config *cfg;
 	unsigned long flags;
+	int cal_created = 0;
 	int ret, sysfs_i;
 
 	/*
@@ -2562,12 +2996,30 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 				goto ally_config_create_sysfs_err;
 			}
 		}
+
+		/* All the groups exist now: the error path must remove them. */
+		cal_created = ARRAY_SIZE(ally_cal_attr_groups);
+	}
+
+	if (cfg->turbo_support) {
+		ret = ally_create_button_attributes(hdev, ally, cfg);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to create button attributes: %d\n", ret);
+			goto ally_config_create_sysfs_err;
+		}
 	}
 
 	cfg->initialized = true;
 
 	return cfg;
 ally_config_create_sysfs_err:
+	if (cfg->button_entries)
+		ally_remove_button_attributes(hdev, cfg);
+
+	while (cal_created-- > 0)
+		sysfs_remove_group(&hdev->dev.kobj,
+				   ally_cal_attr_groups[cal_created]);
+
 	spin_lock_irqsave(&ally_data_lock, flags);
 	ally->config = NULL;
 	spin_unlock_irqrestore(&ally_data_lock, flags);
@@ -2592,6 +3044,9 @@ static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
 	if (!cfg || !cfg->initialized)
 		return;
 
+	if (cfg->button_entries)
+		ally_remove_button_attributes(hdev, cfg);
+
 	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
 		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
 
@@ -3138,6 +3593,14 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 				 ret);
 	}
 
+	if (cfg->turbo_support) {
+		ret = ally_set_turbo_params(ally, hdev, cfg);
+		if (ret < 0)
+			hid_warn(hdev,
+				 "Failed to restore turbo parameters: %d\n",
+				 ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

