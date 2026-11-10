Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276057;
	b=24OyEOWbADQdRoY+0DnHA2Erf726Rgnq/8pV0dV9UhXPYJrhrquNrA+34YEOrIgF0kHo
	 l8R2UoaLkGYKMrOxf6WB0Ybs+wBO3GPkcX3jovIi1vgraSkfTU6DEY78E3eM4DoaBEVx8
	 eNMZ2Ip5JkjztstMh2zQceKz7qhHVS0nHptYZiTQuCS+c+oXhFqJY/XHdVRG6tUjdVCYf
	 DYl7kJSSO9KoRb5lt5cHTHbZVqMHmk+gAcWgbPlSXukxOTu7Vfix5crhJRLBTGQHONxDI
	 2uZGX/oVQ7R+e8hMdwC62dzzJhYylPfGhkXyc2yBnxeBqNkD3fHs4oyTQSLxHPkDpAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276057;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WqvT28WV+anyotgW8PNughiin9p9xfa/cUTdf5pWpM4=;
	b=v9INTshFHrWhguqtKRNmdMZn1c2tfviD19W+tEVOLyZurS33Z/y0W4Udr7KEejgP4eqc
	 o0p6sWDUr0Rr7X+5i/Pm/oufDxpmQI1/yhnVlpNMDvNCZHUQ/vMnp9ULRbT4KrcO5uVAn
	 sp/GcpkD+s+HrrGyCwej37bVxk1ZEGvc6oSDFuQvVCXhK2+NkZA3FMXdA4vpnn9aP00ZU
	 6Rgdjn3cD2Es9zqbkXg1mxWJdqpjmpXyLjr8J9zjMIEcs6xEp6R4HmTLzmwbPs1vjO53E
	 WhYJ2yBXr+tWzxmMe00ZMpgpJ0+oJUvwp0mlnuQoNK3cTtxlj9+AxoohlbFWkrrCzzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=t5NjQWFB;
	arc=none smtp.remote-ip=91.218.175.148
Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523060A2634
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B523060A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=t5NjQWFB
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xi/JqNHaosZLgG2wfQoXZL/6tVxJn7Tx4Z7pJb2AWx0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794276054; v=1; x=1794880854;
 b=t5NjQWFBDF24Xn93JcElvGneDwENNNL3be/zhLYo11Gb0GM90RzxAFxypDJa9nC3wZI8J2gR
 u6lg2IiHRNTJG0MpuATDILudA8wf3ISszxbKKVdVadmWuj8Z1jL9yb4YcqAAuy1xbVwgfiSHQhx
 JKRZPmSSETPU+TYu4NFP04IQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id efe4117b172e351d;
	Tue, 10 Nov 2026 02:00:54 +0000
X-Mizu-Trace-ID: efe4117b172e351d
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
Subject: [PATCH v15 06/18] HID: asus: add triggers inner and outer range configuration
Date: Tue, 10 Nov 2026 02:00:24 +0000
Message-ID: <20261110020036.112884-7-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110020036.112884-1-denis.benato@linux.dev>
References: <20261110020036.112884-1-denis.benato@linux.dev>
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

ROG Ally devices allows configuring inner and outer ranges for triggers
buttons on the back: allow userspace to configure the sensitivity by
exposing sysfs attributes.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 225 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 225 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index b3edb5731c06..5b8b4e2a901e 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -107,6 +107,11 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ASUS_ALLY_INNER_THRESHOLD_MIN 0
 #define ASUS_ALLY_INNER_THRESHOLD_MAX 50
 
+#define ASUS_ALLY_TRIGGER_RANGE_LOWER_MIN 0
+#define ASUS_ALLY_TRIGGER_RANGE_LOWER_MAX 50
+#define ASUS_ALLY_TRIGGER_RANGE_UPPER_MIN 70
+#define ASUS_ALLY_TRIGGER_RANGE_UPPER_MAX 100
+
 /* Spurious HID codes sent by QUIRK_ROG_NKEY_KEYBOARD devices */
 #define ASUS_SPURIOUS_CODE_0XEA 0xea
 #define ASUS_SPURIOUS_CODE_0XEC 0xec
@@ -841,6 +846,11 @@ static struct ally_prefs {
 	u8 left_outer_threshold;
 	u8 right_deadzone;
 	u8 right_outer_threshold;
+
+	u8 left_trigger_min;
+	u8 left_trigger_max;
+	u8 right_trigger_min;
+	u8 right_trigger_max;
 } ally_prefs = {
 	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
 };
@@ -1354,9 +1364,213 @@ static const struct attribute_group ally_right_joystick_axis_group = {
 	.attrs = right_joystick_axis_attrs,
 };
 
+/**
+ * ally_set_trigger_ranges() - Set the gamepad trigger travel ranges
+ * @hdev: HID device the command packet is sent on
+ * @left_min: left trigger minimum (start of travel)
+ * @left_max: left trigger maximum (end of travel)
+ * @right_min: right trigger minimum (start of travel)
+ * @right_max: right trigger maximum (end of travel)
+ *
+ * Context: Caller holds ally_prefs.lock.
+ * Return: 0 on success, -ENOMEM if the command buffer cannot be allocated,
+ * or a negative errno if sending the packet fails.
+ */
+static int ally_set_trigger_ranges(struct hid_device *hdev, u8 left_min, u8 left_max,
+				   u8 right_min, u8 right_max)
+{
+	const u8 payload[] = { left_min, left_max, right_min, right_max };
+	size_t buf_len;
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_TRIGGER_RANGE,
+					       payload, sizeof(payload),
+					       &buf_len);
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(hdev, buf, buf_len);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set trigger ranges: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ally_trigger_defaults(void)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (ally_prefs.initialized)
+		return;
+
+	ally_prefs.left_trigger_min = ASUS_ALLY_TRIGGER_RANGE_LOWER_MIN;
+	ally_prefs.left_trigger_max = ASUS_ALLY_TRIGGER_RANGE_UPPER_MAX;
+	ally_prefs.right_trigger_min = ASUS_ALLY_TRIGGER_RANGE_LOWER_MIN;
+	ally_prefs.right_trigger_max = ASUS_ALLY_TRIGGER_RANGE_UPPER_MAX;
+}
+
+/* Indices into ally_trigger_limits[] */
+enum ally_trigger_limit {
+	ALLY_LEFT_MIN,
+	ALLY_LEFT_MAX,
+	ALLY_RIGHT_MIN,
+	ALLY_RIGHT_MAX,
+};
+
+static u8 * const ally_trigger_limits[] = {
+	[ALLY_LEFT_MIN]  = &ally_prefs.left_trigger_min,
+	[ALLY_LEFT_MAX]  = &ally_prefs.left_trigger_max,
+	[ALLY_RIGHT_MIN] = &ally_prefs.right_trigger_min,
+	[ALLY_RIGHT_MAX] = &ally_prefs.right_trigger_max,
+};
+
+static ssize_t ally_trigger_limit_show(char *buf, enum ally_trigger_limit which)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.user_cal_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", *ally_trigger_limits[which]);
+}
+
+static ssize_t ally_trigger_limit_store(struct device *dev, const char *buf,
+					size_t count,
+					enum ally_trigger_limit which,
+					int lo, int hi,
+					const char *group, const char *name)
+{
+	u8 value, v[ARRAY_SIZE(ally_trigger_limits)];
+	struct hid_device *hdev = to_hid_device(dev);
+	size_t i;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value < lo || value > hi)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.user_cal_support)
+			return -EOPNOTSUPP;
+
+		for (i = 0; i < ARRAY_SIZE(v); i++)
+			v[i] = *ally_trigger_limits[i];
+		v[which] = value;
+
+		ret = ally_set_trigger_ranges(hdev, v[ALLY_LEFT_MIN], v[ALLY_LEFT_MAX],
+					      v[ALLY_RIGHT_MIN], v[ALLY_RIGHT_MAX]);
+		if (ret)
+			return ret;
+
+		*ally_trigger_limits[which] = value;
+	}
+
+	sysfs_notify(&dev->kobj, group, name);
+
+	return count;
+}
+
+/*
+ * Generates <side>_trigger_range_<limit>_limit_{show,store,range_show}.
+ * @lo is the lowest value the store accepts; it is 0 (no check) for the
+ * "lower" limits, matching the original code, which only checked the maximum.
+ */
+#define ALLY_TRIGGER_LIMIT_FUNCS(side, limit, LIMIT, which, lo)					\
+static ssize_t side##_trigger_range_##limit##_limit_show(struct device *dev,			\
+							 struct device_attribute *attr,		\
+							 char *buf)				\
+{												\
+	return ally_trigger_limit_show(buf, which);						\
+}												\
+												\
+static ssize_t side##_trigger_range_##limit##_limit_store(struct device *dev,			\
+							  struct device_attribute *attr,	\
+							  const char *buf,			\
+							  size_t count)				\
+{												\
+	return ally_trigger_limit_store(dev, buf, count, which, lo,				\
+					ASUS_ALLY_TRIGGER_RANGE_##LIMIT##_MAX,			\
+					#side "_trigger", "range_" #limit "_limit");		\
+}												\
+												\
+static ssize_t side##_trigger_range_##limit##_limit_range_show(struct device *dev,		\
+							       struct device_attribute *attr,	\
+							       char *buf)			\
+{												\
+	return sysfs_emit(buf, "%u %u\n", ASUS_ALLY_TRIGGER_RANGE_##LIMIT##_MIN,		\
+			  ASUS_ALLY_TRIGGER_RANGE_##LIMIT##_MAX);				\
+}
+
+ALLY_TRIGGER_LIMIT_FUNCS(left,  lower, LOWER, ALLY_LEFT_MIN,  0)
+ALLY_TRIGGER_LIMIT_FUNCS(left,  upper, UPPER, ALLY_LEFT_MAX,  ASUS_ALLY_TRIGGER_RANGE_UPPER_MIN)
+ALLY_TRIGGER_LIMIT_FUNCS(right, lower, LOWER, ALLY_RIGHT_MIN, 0)
+ALLY_TRIGGER_LIMIT_FUNCS(right, upper, UPPER, ALLY_RIGHT_MAX, ASUS_ALLY_TRIGGER_RANGE_UPPER_MIN)
+
+static struct device_attribute dev_attr_left_trigger_range_lower_limit =
+	__ATTR(range_lower_limit, 0644, left_trigger_range_lower_limit_show,
+	       left_trigger_range_lower_limit_store);
+
+static struct device_attribute dev_attr_left_trigger_range_lower_limit_range =
+	__ATTR(range_lower_limit_range, 0444,
+	       left_trigger_range_lower_limit_range_show, NULL);
+
+static struct device_attribute dev_attr_left_trigger_range_upper_limit =
+	__ATTR(range_upper_limit, 0644, left_trigger_range_upper_limit_show,
+	       left_trigger_range_upper_limit_store);
+
+static struct device_attribute dev_attr_left_trigger_range_upper_limit_range =
+	__ATTR(range_upper_limit_range, 0444,
+	       left_trigger_range_upper_limit_range_show, NULL);
+
+static struct device_attribute dev_attr_right_trigger_range_lower_limit =
+	__ATTR(range_lower_limit, 0644, right_trigger_range_lower_limit_show,
+	       right_trigger_range_lower_limit_store);
+
+static struct device_attribute dev_attr_right_trigger_range_lower_limit_range =
+	__ATTR(range_lower_limit_range, 0444,
+	       right_trigger_range_lower_limit_range_show, NULL);
+
+static struct device_attribute dev_attr_right_trigger_range_upper_limit =
+	__ATTR(range_upper_limit, 0644, right_trigger_range_upper_limit_show,
+	       right_trigger_range_upper_limit_store);
+
+static struct device_attribute dev_attr_right_trigger_range_upper_limit_range =
+	__ATTR(range_upper_limit_range, 0444,
+	       right_trigger_range_upper_limit_range_show, NULL);
+
+static struct attribute *left_trigger_attrs[] = {
+	&dev_attr_left_trigger_range_lower_limit.attr,
+	&dev_attr_left_trigger_range_upper_limit.attr,
+	&dev_attr_left_trigger_range_lower_limit_range.attr,
+	&dev_attr_left_trigger_range_upper_limit_range.attr,
+	NULL
+};
+
+static struct attribute *right_trigger_attrs[] = {
+	&dev_attr_right_trigger_range_lower_limit.attr,
+	&dev_attr_right_trigger_range_upper_limit.attr,
+	&dev_attr_right_trigger_range_lower_limit_range.attr,
+	&dev_attr_right_trigger_range_upper_limit_range.attr,
+	NULL
+};
+
+static const struct attribute_group ally_left_trigger_group = {
+	.name = "left_trigger",
+	.attrs = left_trigger_attrs,
+};
+
+static const struct attribute_group ally_right_trigger_group = {
+	.name = "right_trigger",
+	.attrs = right_trigger_attrs,
+};
 static const struct attribute_group *const ally_cal_attr_groups[] = {
 	&ally_left_joystick_axis_group,
 	&ally_right_joystick_axis_group,
+	&ally_left_trigger_group,
+	&ally_right_trigger_group,
 };
 
 static struct attribute *ally_config_attrs[] = {
@@ -1391,6 +1605,7 @@ static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
 
 	ally_vibration_defaults();
 	ally_joystick_defaults();
+	ally_trigger_defaults();
 
 	scoped_guard(mutex, &ally_prefs.lock) {
 		if (!ally_prefs.initialized) {
@@ -1700,6 +1915,16 @@ static int hid_asus_ally_init(struct hid_device *hdev)
 			hid_warn(hdev, "Failed to restore joystick thresholds: %d\n", ret);
 	}
 
+	if (ally_prefs.initialized && ally_prefs.user_cal_support) {
+		ret = ally_set_trigger_ranges(hdev,
+					      ally_prefs.left_trigger_min,
+					      ally_prefs.left_trigger_max,
+					      ally_prefs.right_trigger_min,
+					      ally_prefs.right_trigger_max);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to restore trigger ranges: %d\n", ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

