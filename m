Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468542;
	b=l3Gs2rIOcWoCf0zBYOPPdUm1ervh+bmWbe4Y/oWUQlUwCPMx9JUFVNHzkJAmGqtQHK1Y
	 N+YgyudR0aVk02b6MShQQVniMne8dscy6xgUypzC/mz5H6drkL/px8mh8XoxC45ZopNjP
	 glU/IfwURH1tIDj+fQYssF83aD/xgNEwVMc6dhj6h3gHAK9OTFAKtdUQe8ShQh9O5FcTV
	 q0n+oSfzEi6LUE4iM4c21OlBIU9dSeRrApihnwMDwnFeG3yWnlMOQuFFN6IruhIjVS6w2
	 aPH3f4yaVsQ6hXSdCH5GPpUkEieNKXeVaKTQP6m003eWMnX7lSy6+QIEvMS3oifK/Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468542;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W+ZmKoQjIj5sNsHBjE0djVUL05eXYVSBLHQdmX/rlS4=;
	b=RnrPDXV0XUsxW/EiHS85YbMfpJeAkINVfwPBRrFJARQv9+oG6vgEldrHuMjtjbsr/h1I
	 6D/xSMPHmw3/iudHuuJ2HXXP2T9vkx6uAjItzEeE7MN507w1anGgPJSIXgANt5JL1Oc4H
	 LIfECetrwbysh2xTXjVSle692ga2nPpH86ELy+V06FfCIP34G9VqCmvQR0RwaMjHvruxx
	 ut5Hk0iZn/6JVmObTPSOXqg/t6J0O0nlTzOqYUnH/QxAU1QxjssAzpxXy154cHGT3SJLt
	 qcKjuaamgAooaf2xVo3gcA9GBGHbnuRrjqq4q+pHfq5d3fQSBWTck90wgTTI+5gxEaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MXbDwITs;
	arc=none smtp.remote-ip=95.215.58.34
Received: from mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BDF606A331
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15BDF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MXbDwITs
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0QMCUXD5GrNMXexwipfC33x1R+P4+SsYrFL0KbWon7c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793468539; v=1; x=1794073339;
 b=MXbDwITsiY9dgs7mxIEGKSxxcGcXveFvMB0D9IMXu+QGSnVayaKRzIhnhprj9ygkyqqMNnHz
 jBZqt8X10WXayYNrYfzjEep26X0ObpmShFeXPWrOjv1ollBRhQrZqGo4QkWK/yPvIJRKsdOXNPp
 sob4oVrPCtEcCQkU3uzHCXVE=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ac931fa86fca6637;
	Sat, 31 Oct 2026 17:42:19 +0000
X-Mizu-Trace-ID: ac931fa86fca6637
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
Subject: [PATCH v12 08/17] HID: asus: add support for response curve
Date: Sat, 31 Oct 2026 17:41:21 +0000
Message-ID: <20261031174130.208240-9-denis.benato@linux.dev>
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

ROG ally devices allows configuring the response curve of both joysticks,
therefore add the ability of userspace to modify the response curve by
exposing relevant sysfs attributes.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 277 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 275 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 9bfdde560834..783c78160277 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -24,6 +24,7 @@
 #include <linux/cleanup.h>
 #include <linux/compiler_attributes.h>
 #include <linux/container_of.h>
+#include <linux/ctype.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/hid.h>
@@ -753,6 +754,18 @@ static int ally_get_endpoint_address(struct hid_device *hdev)
  * once. The only way to see a second one is to emulate it with
  * uhid.
  */
+struct ally_joystick_resp_curve_param {
+	u8 move;
+	u8 resp;
+} __packed;
+
+struct ally_joystick_resp_curve {
+	struct ally_joystick_resp_curve_param entry_1;
+	struct ally_joystick_resp_curve_param entry_2;
+	struct ally_joystick_resp_curve_param entry_3;
+	struct ally_joystick_resp_curve_param entry_4;
+} __packed;
+
 static struct ally_prefs {
 	/* Guards every field below, including across the feature report. */
 	struct mutex lock;
@@ -787,6 +800,9 @@ static struct ally_prefs {
 
 	u8 left_anti_deadzone;
 	u8 right_anti_deadzone;
+
+	struct ally_joystick_resp_curve left_curve;
+	struct ally_joystick_resp_curve right_curve;
 } ally_prefs = {
 	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
 };
@@ -1463,6 +1479,239 @@ static struct device_attribute dev_attr_right_joystick_anti_deadzone =
 static struct device_attribute dev_attr_right_joystick_anti_deadzone_range =
 	__ATTR(anti_deadzone_range, 0444, right_joystick_anti_deadzone_range_show, NULL);
 
+enum ally_joystick_side {
+	JOYSTICK_LEFT = 0,
+	JOYSTICK_RIGHT,
+};
+
+/**
+ * ally_set_joystick_resp_curve() - Set a joystick response curve
+ * @hdev: HID device the command packet is sent on
+ * @side: joystick to program, %JOYSTICK_LEFT or %JOYSTICK_RIGHT
+ * @curve: response curve to apply
+ *
+ * Context: Caller holds ally_prefs.lock.
+ * Return: 0 on success, negative errno on failure.
+ */
+static int ally_set_joystick_resp_curve(struct hid_device *hdev,
+					enum ally_joystick_side side,
+					struct ally_joystick_resp_curve *curve)
+{
+	const u8 payload[] = {
+		side,
+		curve->entry_1.move, curve->entry_1.resp,
+		curve->entry_2.move, curve->entry_2.resp,
+		curve->entry_3.move, curve->entry_3.resp,
+		curve->entry_4.move, curve->entry_4.resp
+	};
+	size_t buf_len;
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_RESP_CURVE, payload,
+						sizeof(payload), &buf_len);
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(hdev, buf, buf_len);
+
+	/*
+	 * Previous function returns the number of bytes sent, or a negative error code.
+	 * From this function I only need either success or the failure.
+	 */
+	return ret < 0 ? ret : 0;
+}
+
+static bool ally_resp_curve_is_valid(const struct ally_joystick_resp_curve *curve)
+{
+	return curve->entry_1.move < curve->entry_2.move &&
+		curve->entry_2.move < curve->entry_3.move &&
+		curve->entry_3.move < curve->entry_4.move;
+}
+
+/* Linear curve. */
+static const struct ally_joystick_resp_curve ally_linear_curve = {
+	.entry_1 = { .move = 0,   .resp = 0 },
+	.entry_2 = { .move = 33,  .resp = 33 },
+	.entry_3 = { .move = 66,  .resp = 66 },
+	.entry_4 = { .move = 100, .resp = 100 },
+};
+
+static void ally_curve_defaults(void)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (ally_prefs.initialized)
+		return;
+
+	ally_prefs.left_curve = ally_linear_curve;
+	ally_prefs.right_curve = ally_linear_curve;
+}
+
+/* Indexed by enum ally_joystick_side */
+static struct ally_joystick_resp_curve * const ally_resp_curves[] = {
+	[JOYSTICK_LEFT]  = &ally_prefs.left_curve,
+	[JOYSTICK_RIGHT] = &ally_prefs.right_curve,
+};
+
+static ssize_t response_curve_show(enum ally_joystick_side side, char *buf)
+{
+	const struct ally_joystick_resp_curve *curve = ally_resp_curves[side];
+
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.resp_curve_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u %u %u %u %u %u %u %u\n",
+				curve->entry_1.move, curve->entry_1.resp,
+				curve->entry_2.move, curve->entry_2.resp,
+				curve->entry_3.move, curve->entry_3.resp,
+				curve->entry_4.move, curve->entry_4.resp);
+}
+
+/**
+ * ally_parse_u8_token() - Parse one decimal u8 from a sysfs write
+ * @buf: write buffer
+ * @count: number of bytes in @buf
+ * @pos: offset in @buf to start scanning at; on success it is advanced to
+ *       the first byte after the token
+ * @val: where the parsed value is stored; only written on success
+ *
+ * Skips leading whitespace, then parses an optional '+' followed by one or
+ * more decimal digits. The token, sign included, may be at most 15 characters
+ * long and its value must fit in a u8.
+ *
+ * The scan is bounded by @count, not by a terminating NUL, so an embedded NUL
+ * is a byte in the write, not the end of the buffer.
+ *
+ * Return: 0 on success, -%EINVAL if there is no number at @pos, the token is
+ * too long, or the value does not fit in a u8. On failure @pos is left at an
+ * unspecified offset.
+ */
+static int ally_parse_u8_token(const char *buf, size_t count, size_t *pos, u8 *val)
+{
+	char token[16];
+	size_t n = 0;
+
+	while (*pos < count && isspace((unsigned char)buf[*pos]))
+		(*pos)++;
+
+	if (*pos < count && buf[*pos] == '+')
+		token[n++] = buf[(*pos)++];
+
+	if (*pos >= count || !isdigit((unsigned char)buf[*pos]))
+		return -EINVAL;
+
+	while (*pos < count && isdigit((unsigned char)buf[*pos])) {
+		if (n >= sizeof(token) - 1)
+			return -EINVAL;
+		token[n++] = buf[(*pos)++];
+	}
+
+	token[n] = '\0';
+
+	return kstrtou8(token, 10, val) ? -EINVAL : 0;
+}
+
+static ssize_t response_curve_store(struct device *dev,
+					enum ally_joystick_side side,
+					const char *group, const char *buf,
+					size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct ally_joystick_resp_curve curve;
+	size_t pos = 0;
+	int ret, i;
+	u8 v[8];
+
+	/*
+	 * Parse and validate the whole curve before taking the lock: a
+	 * write is all-or-nothing and a rejected one must leave the
+	 * recorded curve untouched.
+	 */
+	for (i = 0; i < ARRAY_SIZE(v); i++) {
+		ret = ally_parse_u8_token(buf, count, &pos, &v[i]);
+		if (ret || v[i] > 100)
+			return -EINVAL;
+	}
+
+	for (; pos < count; pos++)
+		if (!isspace((unsigned char)buf[pos]))
+			return -EINVAL;
+
+	curve = (struct ally_joystick_resp_curve) {
+		.entry_1 = { .move = v[0], .resp = v[1] },
+		.entry_2 = { .move = v[2], .resp = v[3] },
+		.entry_3 = { .move = v[4], .resp = v[5] },
+		.entry_4 = { .move = v[6], .resp = v[7] },
+	};
+
+	if (!ally_resp_curve_is_valid(&curve))
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.resp_curve_support)
+			return -EOPNOTSUPP;
+
+		ret = ally_set_joystick_resp_curve(hdev, side, &curve);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to set joystick response curve: %d\n",
+				ret);
+			return ret;
+		}
+
+		*ally_resp_curves[side] = curve;
+	}
+
+	sysfs_notify(&dev->kobj, group, "response_curve");
+
+	return count;
+}
+
+/* Generates <side>_response_curve_{show,store}. */
+#define ALLY_RESP_CURVE_FUNCS(side, SIDE)						\
+static ssize_t side##_response_curve_show(struct device *dev,				\
+						struct device_attribute *attr,		\
+						char *buf)					\
+{											\
+	return response_curve_show(JOYSTICK_##SIDE, buf);				\
+}											\
+											\
+static ssize_t side##_response_curve_store(struct device *dev,				\
+						struct device_attribute *attr,		\
+						const char *buf, size_t count)		\
+{											\
+	return response_curve_store(dev, JOYSTICK_##SIDE,				\
+					#side "_joystick_axis", buf, count);		\
+}
+
+ALLY_RESP_CURVE_FUNCS(left, LEFT)
+ALLY_RESP_CURVE_FUNCS(right, RIGHT)
+
+static ssize_t response_curve_index_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf,
+			  "move_1 resp_1 move_2 resp_2 move_3 resp_3 move_4 resp_4\n"
+			  "\n"
+			  "move_N: joystick deflection percentage at which curve point N\n"
+			  "is placed (0-100, each move_N must be greater than the\n"
+			  "previous one). resp_N: response percentage applied from\n"
+			  "point N on (0-100).\n");
+}
+
+static struct device_attribute dev_attr_left_response_curve =
+	__ATTR(response_curve, 0644, left_response_curve_show,
+	       left_response_curve_store);
+static struct device_attribute dev_attr_right_response_curve =
+	__ATTR(response_curve, 0644, right_response_curve_show,
+	       right_response_curve_store);
+static struct device_attribute dev_attr_left_response_curve_index =
+	__ATTR(response_curve_index, 0444, response_curve_index_show, NULL);
+static struct device_attribute dev_attr_right_response_curve_index =
+	__ATTR(response_curve_index, 0444, response_curve_index_show, NULL);
+
 static struct attribute *left_joystick_axis_attrs[] = {
 	&dev_attr_left_joystick_inner_threshold.attr,
 	&dev_attr_left_joystick_outer_threshold.attr,
@@ -1470,6 +1719,8 @@ static struct attribute *left_joystick_axis_attrs[] = {
 	&dev_attr_left_joystick_outer_threshold_range.attr,
 	&dev_attr_left_joystick_anti_deadzone.attr,
 	&dev_attr_left_joystick_anti_deadzone_range.attr,
+	&dev_attr_left_response_curve.attr,
+	&dev_attr_left_response_curve_index.attr,
 	NULL
 };
 
@@ -1480,6 +1731,8 @@ static struct attribute *right_joystick_axis_attrs[] = {
 	&dev_attr_right_joystick_outer_threshold_range.attr,
 	&dev_attr_right_joystick_anti_deadzone.attr,
 	&dev_attr_right_joystick_anti_deadzone_range.attr,
+	&dev_attr_right_response_curve.attr,
+	&dev_attr_right_response_curve_index.attr,
 	NULL
 };
 
@@ -1724,6 +1977,7 @@ static int ally_prefs_setup(struct hid_device *hdev)
 	ally_vibration_defaults();
 	ally_joystick_defaults();
 	ally_trigger_defaults();
+	ally_curve_defaults();
 
 	guard(mutex)(&ally_prefs.lock);
 
@@ -1748,7 +2002,8 @@ static int ally_prefs_setup(struct hid_device *hdev)
 	}
 
 	/* Skip the calibration groups when the capability is missing. */
-	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support) {
+	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support ||
+	    ally_prefs.resp_curve_support) {
 		int cal_i;
 
 		for (cal_i = 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups); cal_i++) {
@@ -1789,7 +2044,8 @@ static void ally_sysfs_remove(struct hid_device *hdev)
 	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
 		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
 
-	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support) {
+	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support ||
+	    ally_prefs.resp_curve_support) {
 		for (i = 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
 			sysfs_remove_group(&hdev->dev.kobj, ally_cal_attr_groups[i]);
 	}
@@ -2023,6 +2279,23 @@ static int hid_asus_ally_init(struct hid_device *hdev)
 			hid_warn(hdev, "Failed to restore anti-deadzone: %d\n", ret);
 	}
 
+	/*
+	 * The MCU does not keep the response curve across a reset.
+	 * A sysfs write validates the curve before it is recorded, so the
+	 * cache always holds one the controller accepted.
+	 */
+	if (ally_prefs.initialized && ally_prefs.resp_curve_support) {
+		ret = ally_set_joystick_resp_curve(hdev, JOYSTICK_LEFT,
+						   &ally_prefs.left_curve);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to restore left response curve: %d\n", ret);
+
+		ret = ally_set_joystick_resp_curve(hdev, JOYSTICK_RIGHT,
+						   &ally_prefs.right_curve);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to restore right response curve: %d\n", ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

