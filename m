Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975055;
	b=uRZoDZzdB9xJeLe7F7NroI7UcWR008TUrIXiFSkuqlC9NhnAYdWo9giIdvd3bcU+XyDk
	 Bsb9XoqU5BBaIKbkJMRrkwVaHQjyq0PsYkH/gCri/ARFOf3LQ3/lav8ATfidJTSM3qq9t
	 BEIonVtXuMJWwaKKqa4SwWPubR8XECMH7cGNaExcH7INX/3N2D7kWw8iV4fktl1BUCbhF
	 MucN2AJzWWA0V3+DaZU28Cjjuzq7lDVoKQPO2/rMGFrZURSxNkcld24reE9DyfPZ5GSEN
	 FgECBkCEnMi8QU1JWqghz2oEgnkLDeqGLENSaVccSkDo/+Z/u8KQMsAMyXY04Z44kaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975055;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hbTiMvo6KR1Q6h0ONCEi+GuKX9JxsvVdDMi/r5WQR7w=;
	b=yYuDsJnD1pTfZ/8IumpGb/CSgqco3OTsLpKyW65qODpJEYA/G8iLX9wykcWkk+jEiSOL
	 tD9Fdv8gXpeMZuaX7Z8dFuBFJU96TdaqGwzGLFZjF1QmIi+ymhkA7GAtFl8vTnXEp+NBK
	 CEuaFezdZjI1QpPIMeDYw6h7NZo5rGA5D7N3GoLXWpusmbgwV2yqkOqYvx4lFFCO/jLRF
	 LoXL60VVV+D/7VA9T45vwjScbMJPrYQyF4TKY9YVxYXk/iE7nxoBlsECzA6SvAdahJhO1
	 q/gIk7HjUTaj9wbOkDyLMSbzInEUdX2C9pJ1FluXWG3RILJf/SygWuvBx69+NdKFdMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DpDYztsu;
	arc=none smtp.remote-ip=91.218.175.184
Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D497606A32F
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D497606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DpDYztsu
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ulT64lBJp7hgXQWyeRaksMaqKoykDHgNsLmTtvbmPPQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793975051; v=1; x=1794579851;
 b=DpDYztsu52iCGxV3EPtG8bZ7fj4f4UbVGgsyFN3yQ+OTImIQKE2fhyuY+Goi9pVO57C6y0m+
 KSX5xfdLswMsR0szFKlClfu7yIgaXoiu+TFQcO8Ss0AV6nxOl/mgbz6tdJG5h6dUcGraYlTgBQ+
 xodGNp0F4GfR4Jg8aUE1b+yE=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7c0891af8744621e;
	Fri, 06 Nov 2026 14:24:11 +0000
X-Mizu-Trace-ID: 7c0891af8744621e
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
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v14 05/18] HID: asus: add joysticks inner and outer range configuration
Date: Fri,  6 Nov 2026 14:23:21 +0000
Message-ID: <20261106142334.1881-6-denis.benato@linux.dev>
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

ROG Ally devices supports configuring joysticks inner and outer range:
add sysfs attributes to allow userspace modifying the sensitivity
of those controllers.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 266 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 265 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 09b1ec4bae25..fcf025d701c3 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -101,6 +101,12 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ASUS_ALLY_VIBRATION_INTENSITY_MIN 0
 #define ASUS_ALLY_VIBRATION_INTENSITY_MAX 100
 
+#define ASUS_ALLY_OUTER_THRESHOLD_MIN 70
+#define ASUS_ALLY_OUTER_THRESHOLD_MAX 100
+
+#define ASUS_ALLY_INNER_THRESHOLD_MIN 0
+#define ASUS_ALLY_INNER_THRESHOLD_MAX 50
+
 /* Spurious HID codes sent by QUIRK_ROG_NKEY_KEYBOARD devices */
 #define ASUS_SPURIOUS_CODE_0XEA 0xea
 #define ASUS_SPURIOUS_CODE_0XEC 0xec
@@ -829,6 +835,11 @@ static struct ally_prefs {
 
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
@@ -1141,6 +1152,212 @@ static struct attribute *ally_right_vibration_attrs[] = {
 	NULL
 };
 
+/**
+ * ally_set_joystick_thresholds() - Set the joystick inner and outer thresholds
+ * @hdev: HID device the command packet is sent on
+ * @left_it: left joystick inner threshold (deadzone)
+ * @left_ot: left joystick outer threshold
+ * @right_it: right joystick inner threshold (deadzone)
+ * @right_ot: right joystick outer threshold
+ *
+ * Context: Caller holds ally_prefs.lock.
+ * Return: 0 on success, -ENOMEM if the command buffer cannot be allocated,
+ * or a negative errno if sending the packet fails.
+ */
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
+/* Indices into ally_thresholds[], in the order the MCU packet takes them. */
+enum ally_threshold {
+	ALLY_LEFT_INNER,
+	ALLY_LEFT_OUTER,
+	ALLY_RIGHT_INNER,
+	ALLY_RIGHT_OUTER,
+};
+
+static u8 *const ally_thresholds[] = {
+	[ALLY_LEFT_INNER]  = &ally_prefs.left_deadzone,
+	[ALLY_LEFT_OUTER]  = &ally_prefs.left_outer_threshold,
+	[ALLY_RIGHT_INNER] = &ally_prefs.right_deadzone,
+	[ALLY_RIGHT_OUTER] = &ally_prefs.right_outer_threshold,
+};
+
+static ssize_t ally_threshold_show(char *buf, enum ally_threshold which)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.user_cal_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", *ally_thresholds[which]);
+}
+
+static ssize_t ally_threshold_store(struct device *dev, const char *buf,
+				    size_t count, enum ally_threshold which,
+				    int lo, int hi,
+				    const char *group, const char *name)
+{
+	u8 value, v[ARRAY_SIZE(ally_thresholds)];
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
+			v[i] = *ally_thresholds[i];
+		v[which] = value;
+
+		ret = ally_set_joystick_thresholds(hdev,
+						   v[ALLY_LEFT_INNER],
+						   v[ALLY_LEFT_OUTER],
+						   v[ALLY_RIGHT_INNER],
+						   v[ALLY_RIGHT_OUTER]);
+		if (ret)
+			return ret;
+
+		*ally_thresholds[which] = value;
+	}
+
+	sysfs_notify(&dev->kobj, group, name);
+
+	return count;
+}
+
+/* Generates <side>_joystick_<kind>_threshold_{show,store,range_show}. */
+#define ALLY_THRESHOLD_FUNCS(side, SIDE, kind, KIND)						\
+static ssize_t side##_joystick_##kind##_threshold_show(struct device *dev,			\
+						       struct device_attribute *attr,		\
+						       char *buf)				\
+{												\
+	return ally_threshold_show(buf, ALLY_##SIDE##_##KIND);					\
+}												\
+												\
+static ssize_t side##_joystick_##kind##_threshold_store(struct device *dev,			\
+							struct device_attribute *attr,		\
+							const char *buf, size_t count)		\
+{												\
+	return ally_threshold_store(dev, buf, count, ALLY_##SIDE##_##KIND,			\
+				    ASUS_ALLY_##KIND##_THRESHOLD_MIN,				\
+				    ASUS_ALLY_##KIND##_THRESHOLD_MAX,				\
+				    #side "_joystick_axis", #kind "_threshold");		\
+}												\
+												\
+static ssize_t side##_joystick_##kind##_threshold_range_show(struct device *dev,		\
+							     struct device_attribute *attr,	\
+							     char *buf)				\
+{												\
+	return sysfs_emit(buf, "%u %u\n", ASUS_ALLY_##KIND##_THRESHOLD_MIN,			\
+			  ASUS_ALLY_##KIND##_THRESHOLD_MAX);					\
+}
+
+ALLY_THRESHOLD_FUNCS(left,  LEFT,  inner, INNER)
+ALLY_THRESHOLD_FUNCS(left,  LEFT,  outer, OUTER)
+ALLY_THRESHOLD_FUNCS(right, RIGHT, inner, INNER)
+ALLY_THRESHOLD_FUNCS(right, RIGHT, outer, OUTER)
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
@@ -1162,7 +1379,8 @@ static const struct attribute_group ally_attr_groups[] = {
 
 static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
 {
-	int ret, i;
+	bool cal_live = false;
+	int ret, i, cal_n = 0;
 
 	ret = ally_detect_capabilities(hdev);
 	if (ret) {
@@ -1171,6 +1389,7 @@ static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
 	}
 
 	ally_vibration_defaults();
+	ally_joystick_defaults();
 
 	scoped_guard(mutex, &ally_prefs.lock) {
 		if (!ally_prefs.initialized) {
@@ -1200,15 +1419,44 @@ static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
 		}
 	}
 
+	scoped_guard(mutex, &ally_prefs.lock)
+		cal_live = ally_prefs.user_cal_support ||
+			ally_prefs.anti_deadzone_support ||
+			ally_prefs.resp_curve_support;
+
+	/* Skip the calibration groups when the capability is missing. */
+	if (cal_live) {
+		for (; cal_n < ARRAY_SIZE(ally_cal_attr_groups); cal_n++) {
+			ret = sysfs_create_group(&hdev->dev.kobj,
+						ally_cal_attr_groups[cal_n]);
+			if (ret) {
+				hid_err(hdev, "Failed to create Ally sysfs group '%s': %d\n",
+					ally_cal_attr_groups[cal_n]->name, ret);
+				goto err_cal_groups;
+			}
+		}
+	}
+
 	scoped_guard(mutex, &ally_prefs.lock) {
+		intf->cal_sysfs_live = cal_live;
 		intf->sysfs_live = true;
 	}
 
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
 
 static void ally_sysfs_remove(struct hid_device *hdev, struct ally_intf *intf)
 {
+	bool cal_live;
 	int i;
 
 	if (!intf)
@@ -1222,10 +1470,17 @@ static void ally_sysfs_remove(struct hid_device *hdev, struct ally_intf *intf)
 			return;
 
 		intf->sysfs_live = false;
+		cal_live = intf->cal_sysfs_live;
+		intf->cal_sysfs_live = false;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
 		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
+
+	if (cal_live) {
+		for (i = 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
+			sysfs_remove_group(&hdev->dev.kobj, ally_cal_attr_groups[i]);
+	}
 }
 
 struct ally_x_input_report {
@@ -1435,6 +1690,15 @@ static int hid_asus_ally_init(struct hid_device *hdev)
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

