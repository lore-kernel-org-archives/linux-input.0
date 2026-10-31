Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468528;
	b=vLNKKkuYplKiMLWei4BMOazbHPtza7Gc6xpojJfEHXh3LUyiADyaitEVsoP9tnE2XJFQ
	 Mjzn35l4FFg9WE+aHNOcvyCIO22vPCLhN7MWQM+0q308tqJO8KTrOMdQ8veVWq9g95sct
	 P/7gKZ+QXdoIQRX09rsrET4eeEnL/yLtq0uULX16TTUd3DINEagxgWQiSk0bf4x4YbbtP
	 IV6EXQEORPXxMysZf3ry9XqIqf/A3Cnbd2xCwqbNlYnXVBJzPQ17oXAYAtE4tVSJdRpV/
	 tLwYpzlasz9ELUyJScueuOSOmfA32rF7SWWk9oOS2psPTQ4RClxRoVETlydp+1aJS8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468528;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fqDrVzaSOb4x7AJlMtQC6XmDOxAL1mNqQs0gTWzGUtc=;
	b=l/MQUzG/NyPqTQlOPxOn5Ji194LfiCc+7vmAP3jxVv6RN3kaBRWamEPzzrVC3/gt5+G7
	 9GQKUPEdZDmvZ31qpaUmyLq7LBKpRd7+xCkyaiHFnAGioU+4dXhFPvU3tAc4xFXZPn+8L
	 Bv0U9vOVUFQTtmAXU1nMxy1CKJ5S01nBv2M1h0xLJysFA3o3DGoEuFcNfFICrkEOe6zZ1
	 XYO+Uh3YWiqGq1Eu/bT9wpxnbFj8ZwY1d9IsXQu8QywiKbgl5+ArZ3H4Xskeisn+7eqxs
	 AS2+qEhzUbyrV6wGMHNrqb2GFhw1TUt3aFO/AuG7sF3gKWsEHFyt3VXrxD3+RWI3lEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FE1Jq9oc;
	arc=none smtp.remote-ip=95.215.58.6
Received: from mta1.migadu.com (out-6.mta1.migadu.com [95.215.58.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2E606A31D
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD2E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FE1Jq9oc
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UGguSQbCNc2x9Oz4b2c5biG5fJS7AN3RrTMioLciyl4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793468526; v=1; x=1794073326;
 b=FE1Jq9occ79rh5jnxrVPeLIjbSyc3vWDqvUUl2b6eKvZ5cYUl02rtTnpq5MD5hTnLHbbWXba
 TIKSN7TlpKn92GUcB+7OYiZddDcxMdtFB93q4kIF5GtEtP8+FGwcxExX+FSaziADNuHo39MNEpH
 pZ3RCYYire2EAzb6y/aIVjGE=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f3d6621346159e54;
	Sat, 31 Oct 2026 17:42:05 +0000
X-Mizu-Trace-ID: f3d6621346159e54
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
Subject: [PATCH v12 05/17] HID: asus: add joysticks inner and outer range configuration
Date: Sat, 31 Oct 2026 17:41:18 +0000
Message-ID: <20261031174130.208240-6-denis.benato@linux.dev>
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

ROG Ally devices supports configuring joysticks inner and outer range:
add sysfs attributes to allow userspace modifying the sensitivity
of those controllers.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 354 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 348 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index fe2008f9d51d..50b0e6040595 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -98,6 +98,9 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define ASUS_HID_INPUT_KBD_REPORT_ID 0x01
 
+#define ASUS_ALLY_OUTER_THRESHOLD_MIN 70
+#define ASUS_ALLY_OUTER_THRESHOLD_MAX 100
+
 /* Spurious HID codes sent by QUIRK_ROG_NKEY_KEYBOARD devices */
 #define ASUS_SPURIOUS_CODE_0XEA 0xea
 #define ASUS_SPURIOUS_CODE_0XEC 0xec
@@ -767,6 +770,11 @@ static struct ally_prefs {
 
 	u8 vibration_intensity_left;
 	u8 vibration_intensity_right;
+
+	u8 left_deadzone;
+	u8 left_outer_threshold;
+	u8 right_deadzone;
+	u8 right_outer_threshold;
 } ally_prefs = {
 	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
 };
@@ -826,7 +834,6 @@ static int ally_detect_capabilities(struct hid_device *hdev)
 	return 0;
 }
 
-/* Caller holds ally_prefs.lock. The packet is sent on @hdev. */
 static int ally_set_xbox_controller(struct hid_device *hdev, bool enabled)
 {
 	const u8 payload[] = { enabled ?
@@ -1042,6 +1049,304 @@ static struct attribute *ally_right_vibration_attrs[] = {
 	NULL
 };
 
+static int ally_set_joystick_thresholds(struct hid_device *hdev, u8 left_it,
+					u8 left_ot, u8 right_it, u8 right_ot)
+{
+	const u8 payload[] = { left_it, left_ot, right_it, right_ot };
+	size_t buf_len;
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_JOYSTICK_DEADZONE,
+					       payload, sizeof(payload),
+					       &buf_len);
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(hdev, buf, buf_len);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set joystick ranges: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ally_joystick_defaults(void)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (ally_prefs.initialized)
+		return;
+
+	ally_prefs.left_deadzone = 10;
+	ally_prefs.left_outer_threshold = 90;
+	ally_prefs.right_deadzone = 10;
+	ally_prefs.right_outer_threshold = 90;
+}
+
+static ssize_t left_joystick_inner_threshold_show(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.user_cal_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", ally_prefs.left_deadzone);
+}
+
+static ssize_t left_joystick_inner_threshold_store(struct device *dev,
+						   struct device_attribute *attr,
+						   const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	u8 value;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > 50)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.user_cal_support)
+			return -EOPNOTSUPP;
+
+		ret = ally_set_joystick_thresholds(hdev, value,
+						   ally_prefs.left_outer_threshold,
+						   ally_prefs.right_deadzone,
+						   ally_prefs.right_outer_threshold);
+		if (ret)
+			return ret;
+
+		ally_prefs.left_deadzone = value;
+	}
+
+	sysfs_notify(&dev->kobj, "left_joystick_axis", "inner_threshold");
+
+	return count;
+}
+
+static ssize_t left_joystick_inner_threshold_range_show(struct device *dev,
+							struct device_attribute *attr,
+							char *buf)
+{
+	return sysfs_emit(buf, "0 50\n");
+}
+
+static ssize_t left_joystick_outer_threshold_show(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.user_cal_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", ally_prefs.left_outer_threshold);
+}
+
+static ssize_t left_joystick_outer_threshold_store(struct device *dev,
+						   struct device_attribute *attr,
+						   const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	u8 value;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value < 70 || value > 100)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.user_cal_support)
+			return -EOPNOTSUPP;
+
+		ret = ally_set_joystick_thresholds(hdev, ally_prefs.left_deadzone,
+						   value, ally_prefs.right_deadzone,
+						   ally_prefs.right_outer_threshold);
+		if (ret)
+			return ret;
+
+		ally_prefs.left_outer_threshold = value;
+	}
+
+	sysfs_notify(&dev->kobj, "left_joystick_axis", "outer_threshold");
+
+	return count;
+}
+
+static ssize_t left_joystick_outer_threshold_range_show(struct device *dev,
+							struct device_attribute *attr,
+							char *buf)
+{
+	return sysfs_emit(buf, "70 100\n");
+}
+
+static ssize_t right_joystick_inner_threshold_show(struct device *dev,
+						   struct device_attribute *attr,
+						   char *buf)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.user_cal_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", ally_prefs.right_deadzone);
+}
+
+static ssize_t right_joystick_inner_threshold_store(struct device *dev,
+						    struct device_attribute *attr,
+						    const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	u8 value;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > 50)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.user_cal_support)
+			return -EOPNOTSUPP;
+
+		ret = ally_set_joystick_thresholds(hdev, ally_prefs.left_deadzone,
+						   ally_prefs.left_outer_threshold,
+						   value,
+						   ally_prefs.right_outer_threshold);
+		if (ret)
+			return ret;
+
+		ally_prefs.right_deadzone = value;
+	}
+
+	sysfs_notify(&dev->kobj, "right_joystick_axis", "inner_threshold");
+
+	return count;
+}
+
+static ssize_t right_joystick_inner_threshold_range_show(struct device *dev,
+							 struct device_attribute *attr,
+							 char *buf)
+{
+	return sysfs_emit(buf, "0 50\n");
+}
+
+static ssize_t right_joystick_outer_threshold_show(struct device *dev,
+						   struct device_attribute *attr,
+						   char *buf)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.user_cal_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", ally_prefs.right_outer_threshold);
+}
+
+static ssize_t right_joystick_outer_threshold_store(struct device *dev,
+						    struct device_attribute *attr,
+						    const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	u8 value;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value < ASUS_ALLY_OUTER_THRESHOLD_MIN || value > ASUS_ALLY_OUTER_THRESHOLD_MAX)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.user_cal_support)
+			return -EOPNOTSUPP;
+
+		ret = ally_set_joystick_thresholds(hdev, ally_prefs.left_deadzone,
+						ally_prefs.left_outer_threshold,
+						ally_prefs.right_deadzone, value);
+		if (ret)
+			return ret;
+
+		ally_prefs.right_outer_threshold = value;
+	}
+
+	sysfs_notify(&dev->kobj, "right_joystick_axis", "outer_threshold");
+
+	return count;
+}
+
+static ssize_t right_joystick_outer_threshold_range_show(struct device *dev,
+							 struct device_attribute *attr,
+							 char *buf)
+{
+	return sysfs_emit(buf, "%u %u\n", ASUS_ALLY_OUTER_THRESHOLD_MIN,
+			  ASUS_ALLY_OUTER_THRESHOLD_MAX);
+}
+
+static struct device_attribute dev_attr_left_joystick_inner_threshold =
+	__ATTR(inner_threshold, 0644, left_joystick_inner_threshold_show,
+	       left_joystick_inner_threshold_store);
+
+static struct device_attribute dev_attr_left_joystick_inner_threshold_range =
+	__ATTR(inner_threshold_range, 0444, left_joystick_inner_threshold_range_show, NULL);
+
+static struct device_attribute dev_attr_left_joystick_outer_threshold =
+	__ATTR(outer_threshold, 0644, left_joystick_outer_threshold_show,
+	       left_joystick_outer_threshold_store);
+
+static struct device_attribute dev_attr_left_joystick_outer_threshold_range =
+	__ATTR(outer_threshold_range, 0444, left_joystick_outer_threshold_range_show, NULL);
+
+static struct device_attribute dev_attr_right_joystick_inner_threshold =
+	__ATTR(inner_threshold, 0644, right_joystick_inner_threshold_show,
+	       right_joystick_inner_threshold_store);
+
+static struct device_attribute dev_attr_right_joystick_inner_threshold_range =
+	__ATTR(inner_threshold_range, 0444, right_joystick_inner_threshold_range_show, NULL);
+
+static struct device_attribute dev_attr_right_joystick_outer_threshold =
+	__ATTR(outer_threshold, 0644, right_joystick_outer_threshold_show,
+	       right_joystick_outer_threshold_store);
+
+static struct device_attribute dev_attr_right_joystick_outer_threshold_range =
+	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_range_show, NULL);
+
+static struct attribute *left_joystick_axis_attrs[] = {
+	&dev_attr_left_joystick_inner_threshold.attr,
+	&dev_attr_left_joystick_outer_threshold.attr,
+	&dev_attr_left_joystick_inner_threshold_range.attr,
+	&dev_attr_left_joystick_outer_threshold_range.attr,
+	NULL
+};
+
+static struct attribute *right_joystick_axis_attrs[] = {
+	&dev_attr_right_joystick_inner_threshold.attr,
+	&dev_attr_right_joystick_outer_threshold.attr,
+	&dev_attr_right_joystick_inner_threshold_range.attr,
+	&dev_attr_right_joystick_outer_threshold_range.attr,
+	NULL
+};
+
+/*
+ * Registered only when the device can configure these parameters. The
+ * callbacks still reject a missing capability.
+ */
+static const struct attribute_group ally_left_joystick_axis_group = {
+	.name = "left_joystick_axis",
+	.attrs = left_joystick_axis_attrs,
+};
+
+static const struct attribute_group ally_right_joystick_axis_group = {
+	.name = "right_joystick_axis",
+	.attrs = right_joystick_axis_attrs,
+};
+
+static const struct attribute_group *const ally_cal_attr_groups[] = {
+	&ally_left_joystick_axis_group,
+	&ally_right_joystick_axis_group,
+};
+
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
 	NULL
@@ -1070,6 +1375,7 @@ static int ally_prefs_setup(struct hid_device *hdev)
 		return ret;
 
 	ally_vibration_defaults();
+	ally_joystick_defaults();
 
 	guard(mutex)(&ally_prefs.lock);
 
@@ -1093,6 +1399,27 @@ static int ally_prefs_setup(struct hid_device *hdev)
 		}
 	}
 
+	/* Skip the calibration groups when the capability is missing. */
+	if (ally_prefs.user_cal_support) {
+		int cal_i;
+
+		for (cal_i = 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups); cal_i++) {
+			ret = sysfs_create_group(&hdev->dev.kobj,
+						 ally_cal_attr_groups[cal_i]);
+			if (ret) {
+				hid_err(hdev, "Failed to create Ally sysfs group '%s': %d\n",
+					ally_cal_attr_groups[cal_i]->name, ret);
+				while (cal_i--)
+					sysfs_remove_group(&hdev->dev.kobj,
+							   ally_cal_attr_groups[cal_i]);
+				for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
+					sysfs_remove_group(&hdev->dev.kobj,
+							   &ally_attr_groups[i]);
+				return ret;
+			}
+		}
+	}
+
 	ally_prefs.sysfs_live = true;
 	return 0;
 }
@@ -1104,15 +1431,21 @@ static void ally_sysfs_remove(struct hid_device *hdev)
 	if (ally_get_endpoint_address(hdev) != HID_ALLY_INTF_CFG_IN)
 		return;
 
-	scoped_guard(mutex, &ally_prefs.lock) {
-		if (!ally_prefs.sysfs_live)
-			return;
+	guard(mutex)(&ally_prefs.lock);
 
-		ally_prefs.sysfs_live = false;
-	}
+	if (!ally_prefs.sysfs_live)
+		return;
+
+	ally_prefs.sysfs_live = false;
 
 	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
 		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
+
+	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support ||
+	    ally_prefs.resp_curve_support) {
+		for (i = 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
+			sysfs_remove_group(&hdev->dev.kobj, ally_cal_attr_groups[i]);
+	}
 }
 
 struct ally_x_input_report {
@@ -1317,6 +1650,15 @@ static int hid_asus_ally_init(struct hid_device *hdev)
 			hid_warn(hdev, "Failed to restore vibration intensity: %d\n", ret);
 	}
 
+	if (ally_prefs.initialized && ally_prefs.user_cal_support) {
+		ret = ally_set_joystick_thresholds(hdev, ally_prefs.left_deadzone,
+						   ally_prefs.left_outer_threshold,
+						   ally_prefs.right_deadzone,
+						   ally_prefs.right_outer_threshold);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to restore joystick thresholds: %d\n", ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

