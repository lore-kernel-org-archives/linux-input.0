Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975077;
	b=XuAbTj91Ow0zkxKx5aAgPRX/na+6UCP+GhUiP3MptCIf61ni4KtNGzqQUKXoPEAeWDMk
	 RyvuHCEVALVJAJwIlWM5Vnj8+2ZHYWxxchbjFDZvJyjisgpvsOnhXt9mcd0DBIEqtQLdq
	 swoV3bsMCgkyjiJ8KIwo4aslSpQ9eCw0S/8FcJrRgKtpGkf8MM2RIKcjaADhdfTtMZabL
	 TDugdrRy5JGgES2BFUBu7xLLhQINPh07nBnjUcZN9XoFpDgC4VVXV3nJB1KSedDpK0Ha/
	 OJAFy+nvg85CcPfaU2YcBTaWQV9kofgLlcMlvbCZHpnkQ2Iey96P5rABfnTW6EGGAPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975077;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bxzTf6MygWr08YI7RSbjQyDD0U8ko9OexMLeFMys4Hc=;
	b=vfY6J0P7TZCD6A/6Wjqo6WSgA+CStFWzVWPQwWz5SanVTUePVHHYoWqdO3DtWebhlIDD
	 jRS4ugS9DT68yNQwVgNAz8k2IkIJTR58YrRUCdtG3S3GjUmbhEkfIb1ZxWfNj0ptNASvr
	 hwGBHnHWxGKPA8K1oQqLBpGpq9k4SHFFJ5tUj7MM+gV58WS8uVAyutHmBRSfHTYAnjqra
	 sBFIFIxKR0x4KfANjLaTM2rsL5Vc95Hfx9GHMADJ6Vd3Xh4jFfudRsHpM0PR56cQ6syEX
	 joNJXuSoLGtDdcWxh5ERvF5GfEb9GCPU22I2IjqTrMT9qfOTtab6b4Gbf/2nQbCQbOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uG2gFfwh;
	arc=none smtp.remote-ip=95.215.58.30
Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA5606A338
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFDA5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uG2gFfwh
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yhKURBW3o3Ft3/RB3INKvZB9QOhdmzNQwO1U5HB1rkQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793975074; v=1; x=1794579874;
 b=uG2gFfwhH2Mmqe16BoTc2yquFjV08/8zi/jVKnEU2/7lN8Ouwgye7CTUMoy/J8WQwpdNMCAZ
 C6MdMTnDt4rPG/qDvUhKCs7iF9zBSbjA2nksnZCJAYpRRDPH3BBgLwD0GgF0KWnXznIFey6Aj//
 a4nUUi9YidNz1UIO8HM4EpFo=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9cdd1eb03487b7bd;
	Fri, 06 Nov 2026 14:24:34 +0000
X-Mizu-Trace-ID: 9cdd1eb03487b7bd
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>,
	Khamunetri Clark <khamunetriclark@gmail.com>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v14 11/18] HID: asus: add support for turbo buttons
Date: Fri,  6 Nov 2026 14:23:27 +0000
Message-ID: <20261106142334.1881-12-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106142334.1881-1-denis.benato@linux.dev>
References: <20261106142334.1881-1-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ROG ally devices supports a feature called turbo buttons that allows
the user to quickly toggle button state by keeping a button pressed,
therefore allow userspace to configure the feature by exposing
relevant sysfs attributes.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/hid/hid-asus.c | 351 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index cf33ccefcc2b..c0c337a5fcba 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -239,6 +239,8 @@ struct ally_ff_report {
 	struct ally_ff_data ff;
 } __packed;
 
+struct ally_btn_sysfs_entry;
+
 struct ally_intf {
 	struct hid_device *hdev;
 	/* HID-core evdev of this interface. Reports for it land here. */
@@ -255,6 +257,7 @@ struct ally_intf {
 	 */
 	bool sysfs_live;
 	bool cal_sysfs_live;
+	struct ally_btn_sysfs_entry *button_entries;
 	struct {
 		/* Guards live, update, and packet. */
 		spinlock_t lock;
@@ -871,6 +874,80 @@ struct ally_joystick_resp_curve {
 	struct ally_joystick_resp_curve_param entry_4;
 } __packed;
 
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
+struct ally_btn_turbo_params {
+	u8 turbo;
+	u8 toggle;
+} __packed;
+
+#define ALLY_TURBO_PERIOD_MAX 20
+
+/* Payload order. Not the same order as enum ally_button_id. */
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
+	struct attribute *attrs[5];
+	enum ally_button_id btn;
+	struct device_attribute attr_turbo_period;
+	struct device_attribute attr_toggle_period;
+};
+
 /*
  * Settings that must survive the controller powering off and coming back.
  * No device or input pointers live here: every transfer uses the interface
@@ -918,6 +995,8 @@ static struct ally_prefs {
 
 	struct ally_joystick_resp_curve left_curve;
 	struct ally_joystick_resp_curve right_curve;
+
+	struct ally_turbo_config turbo;
 } ally_prefs = {
 	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
 };
@@ -2143,8 +2222,261 @@ static const struct attribute_group ally_attr_groups[] = {
 	},
 };
 
+static struct ally_btn_turbo_params *ally_btn_param(enum ally_button_id btn)
+{
+	struct ally_btn_turbo_params *table[ALLY_BTN_MAX] = {
+		[ALLY_BTN_A] = &ally_prefs.turbo.btn_a,
+		[ALLY_BTN_B] = &ally_prefs.turbo.btn_b,
+		[ALLY_BTN_X] = &ally_prefs.turbo.btn_x,
+		[ALLY_BTN_Y] = &ally_prefs.turbo.btn_y,
+		[ALLY_BTN_LB] = &ally_prefs.turbo.btn_lb,
+		[ALLY_BTN_RB] = &ally_prefs.turbo.btn_rb,
+		[ALLY_BTN_DU] = &ally_prefs.turbo.btn_du,
+		[ALLY_BTN_DD] = &ally_prefs.turbo.btn_dd,
+		[ALLY_BTN_DL] = &ally_prefs.turbo.btn_dl,
+		[ALLY_BTN_DR] = &ally_prefs.turbo.btn_dr,
+		[ALLY_BTN_J0B] = &ally_prefs.turbo.btn_j0b,
+		[ALLY_BTN_J1B] = &ally_prefs.turbo.btn_j1b,
+		[ALLY_BTN_MENU] = &ally_prefs.turbo.btn_menu,
+		[ALLY_BTN_VIEW] = &ally_prefs.turbo.btn_view,
+		[ALLY_BTN_M1] = &ally_prefs.turbo.btn_m1,
+		[ALLY_BTN_M2] = &ally_prefs.turbo.btn_m2,
+	};
+
+	if (btn >= ALLY_BTN_MAX)
+		return NULL;
+
+	return table[btn];
+}
+
+/**
+ * ally_set_turbo_params() - Set the turbo parameters
+ * @hdev: The HID device to send the packet to.
+ *
+ * Context: Caller holds ally_prefs.lock.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int ally_set_turbo_params(struct hid_device *hdev)
+{
+	struct ally_turbo_config *turbo = &ally_prefs.turbo;
+	size_t buf_len;
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_TURBO_PARAMS,
+					       (const u8 *)turbo, sizeof(*turbo),
+					       &buf_len);
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(hdev, buf, buf_len);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set turbo parameters: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Which per-button period a sysfs attribute operates on. */
+enum ally_btn_period {
+	ALLY_TURBO_PERIOD,
+	ALLY_TOGGLE_PERIOD,
+};
+
+static u8 *ally_btn_period_field(struct ally_btn_turbo_params *params,
+				 enum ally_btn_period which)
+{
+	return which == ALLY_TURBO_PERIOD ? &params->turbo : &params->toggle;
+}
+
+static ssize_t ally_btn_period_show(struct ally_btn_sysfs_entry *entry, char *buf,
+				    enum ally_btn_period which)
+{
+	struct ally_btn_turbo_params *params;
+	u8 value;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.turbo_support)
+			return -EOPNOTSUPP;
+
+		params = ally_btn_param(entry->btn);
+		if (!params)
+			return -ENODEV;
+
+		/*
+		 * Snapshot the field while holding the lock: the store
+		 * writes it in-place before the feature report transfer
+		 * and rolls it back on failure, so reading it unlocked
+		 * could observe a value that never took effect.
+		 */
+		value = *ally_btn_period_field(params, which);
+	}
+
+	return sysfs_emit(buf, "%hhu\n", value);
+}
+
+static ssize_t ally_btn_period_store(struct device *dev,
+				     struct ally_btn_sysfs_entry *entry,
+				     const char *buf, size_t count,
+				     enum ally_btn_period which, u8 max,
+				     const char *name)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct ally_btn_turbo_params *params;
+	u8 old_value, value, *field;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret)
+		return ret;
+	if (value > max)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.turbo_support)
+			return -EOPNOTSUPP;
+
+		params = ally_btn_param(entry->btn);
+		if (!params)
+			return -ENODEV;
+
+		field = ally_btn_period_field(params, which);
+		old_value = *field;
+		*field = value;
+
+		ret = ally_set_turbo_params(hdev);
+		if (ret) {
+			*field = old_value;
+			return ret;
+		}
+	}
+
+	sysfs_notify(&dev->kobj, entry->group.name, name);
+
+	return count;
+}
+
+/* Generates btn_<kind>_period_{show,store,range_show}. */
+#define ALLY_BTN_PERIOD_FUNCS(kind, KIND, max)						\
+static ssize_t btn_##kind##_period_show(struct device *dev,				\
+					struct device_attribute *attr, char *buf)	\
+{											\
+	struct ally_btn_sysfs_entry *entry = container_of(attr,				\
+		struct ally_btn_sysfs_entry, attr_##kind##_period);			\
+											\
+	return ally_btn_period_show(entry, buf, ALLY_##KIND##_PERIOD);			\
+}											\
+											\
+static ssize_t btn_##kind##_period_store(struct device *dev,				\
+					 struct device_attribute *attr,			\
+					 const char *buf, size_t count)			\
+{											\
+	struct ally_btn_sysfs_entry *entry = container_of(attr,				\
+		struct ally_btn_sysfs_entry, attr_##kind##_period);			\
+											\
+	return ally_btn_period_store(dev, entry, buf, count, ALLY_##KIND##_PERIOD,	\
+				     max, #kind "_period");				\
+}											\
+											\
+static ssize_t btn_##kind##_period_range_show(struct device *dev,			\
+					      struct device_attribute *attr,		\
+					      char *buf)				\
+{											\
+	return sysfs_emit(buf, "%u %u\n", 0, (unsigned int)(max));			\
+}
+
+ALLY_BTN_PERIOD_FUNCS(turbo,  TURBO,  ALLY_TURBO_PERIOD_MAX)
+ALLY_BTN_PERIOD_FUNCS(toggle, TOGGLE, U8_MAX)
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
+
+	entry->attrs[0] = &entry->attr_turbo_period.attr;
+	entry->attrs[1] = &entry->attr_toggle_period.attr;
+	entry->attrs[2] = &dev_attr_btn_turbo_period_range.attr;
+	entry->attrs[3] = &dev_attr_btn_toggle_period_range.attr;
+	entry->attrs[4] = NULL;
+}
+
+static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct hid_device *hdev)
+{
+	int i, ret;
+
+	scoped_guard(mutex, &ally_prefs.lock)
+		if (!ally_prefs.turbo_support)
+			return NULL;
+
+	struct ally_btn_sysfs_entry *entries __free(kfree) = kzalloc_objs(*entries, ALLY_BTN_MAX);
+	if (!entries)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < ALLY_BTN_MAX; i++) {
+		entries[i].btn = i;
+
+		if (!ally_btn_param(i)) {
+			hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
+			ret = -EINVAL;
+			goto ally_btn_err_cleanup;
+		}
+
+		ally_btn_turbo_init_attrs(&entries[i]);
+		entries[i].group.name = ally_button_names[i];
+		entries[i].group.attrs = entries[i].attrs;
+
+		ret = sysfs_create_group(&hdev->dev.kobj, &entries[i].group);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to create sysfs group for %s: %d\n",
+				ally_button_names[i], ret);
+			goto ally_btn_err_cleanup;
+		}
+	}
+
+	return no_free_ptr(entries);
+
+ally_btn_err_cleanup:
+	while (i--)
+		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
+
+	return ERR_PTR(ret);
+}
+
+static void ally_remove_button_attributes(struct hid_device *hdev,
+					  struct ally_btn_sysfs_entry *entries)
+{
+	int i;
+
+	if (!entries)
+		return;
+
+	for (i = 0; i < ALLY_BTN_MAX; i++) {
+		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
+	}
+
+	kfree(entries);
+}
+
 static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
 {
+	struct ally_btn_sysfs_entry *entries = NULL;
 	bool cal_live = false;
 	int ret, i, cal_n = 0;
 
@@ -2205,7 +2537,15 @@ static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
 		}
 	}
 
+	entries = ally_create_button_attributes(hdev);
+	if (IS_ERR(entries)) {
+		ret = PTR_ERR(entries);
+		hid_err(hdev, "Failed to create button attributes: %d\n", ret);
+		goto err_cal_groups;
+	}
+
 	scoped_guard(mutex, &ally_prefs.lock) {
+		intf->button_entries = entries;
 		intf->cal_sysfs_live = cal_live;
 		intf->sysfs_live = true;
 	}
@@ -2224,6 +2564,7 @@ static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
 
 static void ally_sysfs_remove(struct hid_device *hdev, struct ally_intf *intf)
 {
+	struct ally_btn_sysfs_entry *entries;
 	bool cal_live;
 	int i;
 
@@ -2238,10 +2579,14 @@ static void ally_sysfs_remove(struct hid_device *hdev, struct ally_intf *intf)
 			return;
 
 		intf->sysfs_live = false;
+		entries = intf->button_entries;
+		intf->button_entries = NULL;
 		cal_live = intf->cal_sysfs_live;
 		intf->cal_sysfs_live = false;
 	}
 
+	ally_remove_button_attributes(hdev, entries);
+
 	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
 		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
 
@@ -2601,6 +2946,12 @@ static int hid_asus_ally_init(struct hid_device *hdev)
 			hid_warn(hdev, "Failed to restore gamepad mode: %d\n", ret);
 	}
 
+	if (ally_prefs.initialized && ally_prefs.turbo_support) {
+		ret = ally_set_turbo_params(hdev);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to restore turbo parameters: %d\n", ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

