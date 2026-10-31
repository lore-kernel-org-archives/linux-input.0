Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468552;
	b=aqV0ofOqQ+VWzrB1TpyOIMIoVVySZHzlRfmu5FxPsClUd5qPyVLZY66WtadwReMcSkU9
	 8LsQYq43AOfaw0bgvfdIwemDJTkx8msVpYQQ8t4nYsOaJe7E5YtQ45UWjrS4w2DE1O3ED
	 N4bypjxmcs+8cCCcWBwL+eCxxu7+URUilHhgMS2OKXdKofIW+a1iLLIT2/CAtse1O+aB2
	 XmotvR7Y2S61s5Sn9l4xeqAc66m7scfb0nSsHINGLr8CQ2wQaC9g+6YOjaNxUwcyoXEeW
	 DQMpXTSpnwnMEGeU7Zy3WFpWJyT+XL+QjsEJLJmk0xZvBLSBPUNO4bKAO+c0NRZ/8pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468552;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TQYpSXQFikAud30hjUdD7I/LcJb2vOgbO5VU4H+KldE=;
	b=1dunrXeUqVxcnu+TP+J8uXuwt1CcWl8+RfFfJC/GtIhDMPduIoBCYKH8rveqf3h6+YdT
	 VJf8B//FQ6TJAfWnLuhGsKF6Bt99940PUTmr2IpfsBYh0TTc7YxdMDqY+xWO7jxhtiGrq
	 TX2VkjlTPsvS8nAD4TaI2NRvM/yfyiBGnRyPs0k0Mj45WcA9w9vffOAJ9rY7DU8wFT5He
	 991n5xAHybjM9pfxKjNm+w+B1LWbfiYn3fN62rQhYtB7qD/Syu3dTTzwfZddPtyYZvQb2
	 SV7xqfBzVYpYhTkB4o9gh7IssXWNUY/hQSBqHfiG54OppF5WBQS3LibYB9kk/1kQogw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Fi9NGWIp;
	arc=none smtp.remote-ip=91.218.175.11
Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA77606A32E
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA77606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Fi9NGWIp
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YxtHzfSsUsax4NIaC+HJCSQpX7cDUECIMfa91k63bSE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793468550; v=1; x=1794073350;
 b=Fi9NGWIp/o67OeRBzg3ZFeu53v/SLtryMgyid4bnICziwupj01TCbxHZ+UC8Es36qOpwUFoU
 nKa6eRgCmeY2MqWeyMxgTM1L00Ul1X7tan4MjLSReNafamqx0QpwGT4lATig5svIw+OolSkPkn2
 +YIqvIXhrvo5UUXzMHpmDyPY=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6c70f8add809064f;
	Sat, 31 Oct 2026 17:42:30 +0000
X-Mizu-Trace-ID: 6c70f8add809064f
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Joshua Leivenzon" <hacker1024@users.sourceforge.net>,
	"Nathan Chancellor" <nathan@kernel.org>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	"Ivan Levchenko" <me@livan.pro>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v12 11/17] HID: asus: add support for turbo buttons
Date: Sat, 31 Oct 2026 17:41:24 +0000
Message-ID: <20261031174130.208240-12-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031174130.208240-1-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
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
 drivers/hid/hid-asus.c | 410 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 397 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3e58c5ca0cbd..d20e433af574 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -812,6 +812,80 @@ struct ally_joystick_resp_curve {
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
 static struct ally_prefs {
 	/* Guards every field below, including across the feature report. */
 	struct mutex lock;
@@ -849,6 +923,9 @@ static struct ally_prefs {
 
 	struct ally_joystick_resp_curve left_curve;
 	struct ally_joystick_resp_curve right_curve;
+
+	struct ally_turbo_config turbo;
+	struct ally_btn_sysfs_entry *button_entries;
 } ally_prefs = {
 	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
 };
@@ -2120,9 +2197,297 @@ static const struct attribute_group ally_attr_groups[] = {
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
+/** ally_set_turbo_params() - Set the turbo parameters
+ *
+ * Caller holds ally_prefs.lock.
+ *
+ * @hdev: The HID device to send the packet to.
+ * Return: 0 on success, negative error code on failure.
+ */
+static int ally_set_turbo_params(struct hid_device *hdev)
+{
+	struct ally_turbo_config *turbo = &ally_prefs.turbo;
+	const u8 payload[] = {
+		turbo->btn_du.turbo, turbo->btn_du.toggle,
+		turbo->btn_dd.turbo, turbo->btn_dd.toggle,
+		turbo->btn_dl.turbo, turbo->btn_dl.toggle,
+		turbo->btn_dr.turbo, turbo->btn_dr.toggle,
+		turbo->btn_j0b.turbo, turbo->btn_j0b.toggle,
+		turbo->btn_j1b.turbo, turbo->btn_j1b.toggle,
+		turbo->btn_lb.turbo, turbo->btn_lb.toggle,
+		turbo->btn_rb.turbo, turbo->btn_rb.toggle,
+		turbo->btn_a.turbo, turbo->btn_a.toggle,
+		turbo->btn_b.turbo, turbo->btn_b.toggle,
+		turbo->btn_x.turbo, turbo->btn_x.toggle,
+		turbo->btn_y.turbo, turbo->btn_y.toggle,
+		turbo->btn_view.turbo, turbo->btn_view.toggle,
+		turbo->btn_menu.turbo, turbo->btn_menu.toggle,
+		turbo->btn_m2.turbo, turbo->btn_m2.toggle,
+		turbo->btn_m1.turbo, turbo->btn_m1.toggle,
+	};
+	size_t buf_len;
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_TURBO_PARAMS, payload,
+					       sizeof(payload), &buf_len);
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
+static ssize_t btn_turbo_period_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct ally_btn_sysfs_entry *entry;
+	struct ally_btn_turbo_params *params;
+
+	entry = container_of(attr, struct ally_btn_sysfs_entry, attr_turbo_period);
+
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.turbo_support)
+		return -EOPNOTSUPP;
+
+	params = ally_btn_param(entry->btn);
+	if (!params)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%hhu\n", params->turbo);
+}
+
+static ssize_t btn_turbo_period_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct ally_btn_sysfs_entry *entry;
+	struct hid_device *hdev = to_hid_device(dev);
+	struct ally_btn_turbo_params *params;
+	u8 old_value, value;
+	int ret;
+
+	entry = container_of(attr, struct ally_btn_sysfs_entry, attr_turbo_period);
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > ALLY_TURBO_PERIOD_MAX)
+		return ret ? ret : -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.turbo_support)
+			return -EOPNOTSUPP;
+
+		params = ally_btn_param(entry->btn);
+		if (!params)
+			return -ENODEV;
+
+		old_value = params->turbo;
+		params->turbo = value;
+		ret = ally_set_turbo_params(hdev);
+		if (ret) {
+			params->turbo = old_value;
+			return ret;
+		}
+	}
+
+	sysfs_notify(&dev->kobj, entry->group.name, "turbo_period");
+
+	return count;
+}
+
+static ssize_t btn_toggle_period_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct ally_btn_sysfs_entry *entry;
+	struct ally_btn_turbo_params *params;
+
+	entry = container_of(attr, struct ally_btn_sysfs_entry, attr_toggle_period);
+
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.turbo_support)
+		return -EOPNOTSUPP;
+
+	params = ally_btn_param(entry->btn);
+	if (!params)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%hhu\n", params->toggle);
+}
+
+static ssize_t btn_toggle_period_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct ally_btn_sysfs_entry *entry;
+	struct hid_device *hdev = to_hid_device(dev);
+	struct ally_btn_turbo_params *params;
+	u8 old_value, value;
+	int ret;
+
+	entry = container_of(attr, struct ally_btn_sysfs_entry, attr_toggle_period);
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.turbo_support)
+			return -EOPNOTSUPP;
+
+		params = ally_btn_param(entry->btn);
+		if (!params)
+			return -ENODEV;
+
+		old_value = params->toggle;
+		params->toggle = value;
+		ret = ally_set_turbo_params(hdev);
+		if (ret) {
+			params->toggle = old_value;
+			return ret;
+		}
+	}
+
+	sysfs_notify(&dev->kobj, entry->group.name, "toggle_period");
+
+	return count;
+}
+
+static ssize_t btn_turbo_period_range_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return sysfs_emit(buf, "0 20\n");
+}
+
+static ssize_t btn_toggle_period_range_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
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
+	if (!ally_prefs.turbo_support)
+		return NULL;
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
+static void ally_remove_button_attributes(struct hid_device *hdev)
+{
+	struct ally_btn_sysfs_entry *entries;
+	int i;
+
+	entries = ally_prefs.button_entries;
+	if (!entries)
+		return;
+
+	for (i = 0; i < ALLY_BTN_MAX; i++)
+		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
+
+	kfree(entries);
+	ally_prefs.button_entries = NULL;
+}
+
 static int ally_prefs_setup(struct hid_device *hdev)
 {
-	int ret, i;
+	struct ally_btn_sysfs_entry *entries = NULL;
+	int ret, i, cal_n = 0;
 
 	ret = ally_detect_capabilities(hdev);
 	if (ret)
@@ -2158,27 +2523,38 @@ static int ally_prefs_setup(struct hid_device *hdev)
 	/* Skip the calibration groups when the capability is missing. */
 	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support ||
 	    ally_prefs.resp_curve_support) {
-		int cal_i;
-
-		for (cal_i = 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups); cal_i++) {
+		for (; cal_n < ARRAY_SIZE(ally_cal_attr_groups); cal_n++) {
 			ret = sysfs_create_group(&hdev->dev.kobj,
-						 ally_cal_attr_groups[cal_i]);
+						ally_cal_attr_groups[cal_n]);
 			if (ret) {
 				hid_err(hdev, "Failed to create Ally sysfs group '%s': %d\n",
-					ally_cal_attr_groups[cal_i]->name, ret);
-				while (cal_i--)
-					sysfs_remove_group(&hdev->dev.kobj,
-							   ally_cal_attr_groups[cal_i]);
-				for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
-					sysfs_remove_group(&hdev->dev.kobj,
-							   &ally_attr_groups[i]);
-				return ret;
+					ally_cal_attr_groups[cal_n]->name, ret);
+				goto err_cal_groups;
 			}
 		}
 	}
 
+	if (ally_prefs.turbo_support) {
+		entries = ally_create_button_attributes(hdev);
+		if (IS_ERR(entries)) {
+			ret = PTR_ERR(entries);
+			hid_err(hdev, "Failed to create button attributes: %d\n", ret);
+			goto err_cal_groups;
+		}
+	}
+
+	ally_prefs.button_entries = entries;
 	ally_prefs.sysfs_live = true;
 	return 0;
+
+err_cal_groups:
+	while (cal_n--)
+		sysfs_remove_group(&hdev->dev.kobj, ally_cal_attr_groups[cal_n]);
+
+	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
+		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
+
+	return ret;
 }
 
 static void ally_sysfs_remove(struct hid_device *hdev)
@@ -2195,6 +2571,8 @@ static void ally_sysfs_remove(struct hid_device *hdev)
 
 	ally_prefs.sysfs_live = false;
 
+	ally_remove_button_attributes(hdev);
+
 	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
 		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
 
@@ -2550,6 +2928,12 @@ static int hid_asus_ally_init(struct hid_device *hdev)
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

