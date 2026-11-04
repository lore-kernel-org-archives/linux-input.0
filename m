Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756470;
	b=fr64bk0PGdwqZZ+Fb9r/QMMXE1RZ+ccZzmQRAeLj1JZvvhOMOGVOovhPiHmKtquQFvSR
	 XdYm8RE+G5VhoVwICmMzZ5SW/D712tvtcubByd/BIQTPO4QCnjTdgiGZC86qyluF50yMi
	 /M4xIRFMIMXrOgF/0PPOY6Dro2e7kJMQbUIoVNMtLq+4At0lDSTpo0Y22j0eF5Hh6k4Er
	 WWhx2sb8RliyLcNaFb+kwLW6tvVS/FN7Or1v544lCOoVcc5crvytAtWoPz3eCJ6T99c5v
	 9LFI3XELV+029ULGMBiqsg1xPCQveILgoFxXxvSDc9J3Gmvqslva+Uc6AKDz+yJMoUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756470;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rD5hxuogLg8krzvnIXXKjTtUerLiMuDdBNUMZWsOTQQ=;
	b=3//2mpyfPrMWH1OLN/lEq403v75+QEUqtyPym72kT6OEsaXpu8HFTF3SIuQJD0gtYo4k
	 v4EW7tnFqaCg4jygpfY9uoB6krE/jL/cNhhmcgWvB5axvsdI5ltj92Yi2xwt+BxBHl2Jm
	 P3AEX3kSYT49ohvB0keUGF1C4Pk9DtcRXs27mcARXAzQtvppQVNMxi5cOGyfBqi/ePggd
	 /T3ljop3JF1Xwl2ei2RzOMttuBG38mjGjjHihfCJ77bJHzKPjW4XRyQx9M5j/S4ZKRGl2
	 nH1XP2NsgJB50BvltA9j+f0ywfJn6z1eiBsOxecmFlPDha8hvjubE6LG62R6VMkbFjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BvsFaICM;
	arc=none smtp.remote-ip=95.215.58.156
Received: from mta1.migadu.com (out-156.mta1.migadu.com [95.215.58.156])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B00606A328
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B00606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BvsFaICM
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Cmn01Cqhuc3HyU9ffdmhxoU3Teo8JFn4qNtHpCEMZX4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793756468; v=1; x=1794361268;
 b=BvsFaICMra2NBMa2Y2rsXKSCQ5UYY167m40FoDOU/Reso9EXRpDSENUcc8+L5C2w4JTpT+ON
 LYguQ8ajQvXb20TZr/QpdAKcYShCzRnOl3GszfXaNhOo3mKZq21wWoDxwWVGsuq3ZsIcvlntEtt
 4GKHOWItPTc0c5GjYNmafqFk=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d7c28acbde1fd728;
	Wed, 04 Nov 2026 01:41:07 +0000
X-Mizu-Trace-ID: d7c28acbde1fd728
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
Subject: [PATCH v13 06/18] HID: asus: add triggers inner and outer range configuration
Date: Wed,  4 Nov 2026 01:39:23 +0000
Message-ID: <20261104013935.512713-7-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104013935.512713-1-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
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
index a89ce83ae93f..8c49e9bdad50 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -106,6 +106,11 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
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
@@ -821,6 +826,11 @@ static struct ally_prefs {
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
@@ -1337,9 +1347,213 @@ static const struct attribute_group ally_right_joystick_axis_group = {
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
@@ -1372,6 +1586,7 @@ static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
 
 	ally_vibration_defaults();
 	ally_joystick_defaults();
+	ally_trigger_defaults();
 
 	scoped_guard(mutex, &ally_prefs.lock) {
 		if (!ally_prefs.initialized) {
@@ -1676,6 +1891,16 @@ static int hid_asus_ally_init(struct hid_device *hdev)
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

