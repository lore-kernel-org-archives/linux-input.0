Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756472;
	b=N8IXUVBjxPTV2uvoH+5Pb1DEqp6XE+dZ9VDGSlO0J74ioERMl7vL1dvgHdh937LC6i+l
	 q4h1MRiaMpewOQorKud3YtzH07fCL+T2DdPoRMYoXwnCVC7ZbTWlOPjFPQosaJNeG0YTa
	 N018hrUmizHbAWVqdkGuTe2Aqjbju3iA1CturZODaY7EHLSukVC/lGCn724o+QofvVxr6
	 QyjvxQggFWgDlu7GieNbANskvKq5Wiqscr1weIRU/FFXizwZyXspO7QzTgyLo7UEYnDuL
	 hOLHSvDovPncuHN5VU/1+W0uil/M+grk/o99ypx/TN6QzmQP8SsuVnzzJwxiFCSq9GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756472;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ivzlBRDKCzJlMUOaYaHRu0UyIMwMgVIeYf1Ceyr8Gz8=;
	b=QHUryqPAB/VcSl38NC3A59x9SOm7+Gl5Vy+6zqMrRbw2XDTgmNDG7u3oUPM4oL+8XLLs
	 X/iRlYLcsWi5LSL5etrvMvLFAtSNHwp3VF0rOqGLtshr56HqB5ZqNlLA37ldxmjhalMdJ
	 NOLNFmj+olBUGIfTGfEDzulzx+3q4uUi8LJh8xgt/TWRZXPs99imhngAI9ocunUzJBklW
	 GrKzRsVFhJJ8/u/ZR+LfqqQebkCszf51CXFidUju3sD08m752+rEDXECwab9nAtOPMcMs
	 Xs6Cvsy4fcjNQNKyL0LY0/viCMJuINdvXLvencQ+C4y6Y9jKvKUu2eZUIobQdB0rNYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jdsyyzZv;
	arc=none smtp.remote-ip=95.215.58.164
Received: from mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79915606A339
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79915606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jdsyyzZv
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1UeZccYcwt91kU5bVhPYh/aeSlYwG1AN/VLAvDb2znc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793756469; v=1; x=1794361269;
 b=jdsyyzZviZ28AXj+MS/2G+d3FerenyanDUktgF5xFFVaoHQ0h9P9GFsziTkgx5jP4guKcyeM
 2RHffoJP4AZEwcOMxRbvthXuhYeg34KUh3ZBJrCzO/PzpFrcjMh5fLaJHMpBZc6hz0zN0UvJxuL
 VHaO8wkatEMkCCm7CnqnXAJI=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 793ee1f2a56d765b;
	Wed, 04 Nov 2026 01:41:09 +0000
X-Mizu-Trace-ID: 793ee1f2a56d765b
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
Subject: [PATCH v13 07/18] HID: asus: add joysticks anti-deadzone configuration
Date: Wed,  4 Nov 2026 01:39:24 +0000
Message-ID: <20261104013935.512713-8-denis.benato@linux.dev>
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

ROG Ally devices allow configuring the anti-deadzone parameter for
the resistive joysticks devices as over time those develops drift,
therefore allow userspace to configure the anti-deadzone by exposing
relevant sysfs attributes.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 157 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 8c49e9bdad50..344abf1510c4 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -106,6 +106,9 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ASUS_ALLY_INNER_THRESHOLD_MIN 0
 #define ASUS_ALLY_INNER_THRESHOLD_MAX 50
 
+#define ASUS_ALLY_ANTI_DEADZONE_MIN 0
+#define ASUS_ALLY_ANTI_DEADZONE_MAX 100
+
 #define ASUS_ALLY_TRIGGER_RANGE_LOWER_MIN 0
 #define ASUS_ALLY_TRIGGER_RANGE_LOWER_MAX 50
 #define ASUS_ALLY_TRIGGER_RANGE_UPPER_MIN 70
@@ -831,6 +834,9 @@ static struct ally_prefs {
 	u8 left_trigger_max;
 	u8 right_trigger_min;
 	u8 right_trigger_max;
+
+	u8 left_anti_deadzone;
+	u8 right_anti_deadzone;
 } ally_prefs = {
 	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
 };
@@ -1317,11 +1323,153 @@ static struct device_attribute dev_attr_right_joystick_outer_threshold =
 static struct device_attribute dev_attr_right_joystick_outer_threshold_range =
 	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_range_show, NULL);
 
+/**
+ * ally_set_anti_deadzone() - Send the joystick anti-deadzone values to the device
+ * @hdev: HID device the packet is sent on
+ * @left: Anti-deadzone of the left joystick
+ * @right: Anti-deadzone of the right joystick
+ *
+ * Context: Caller must hold ally_prefs.lock.
+ *
+ * Return: 0 on success, -%EOPNOTSUPP if the device does not support
+ * anti-deadzone, -%ENOMEM if the command buffer cannot be allocated, or a
+ * negative error code if sending the packet fails.
+ */
+static int ally_set_anti_deadzone(struct hid_device *hdev, u8 left, u8 right)
+{
+	const u8 payload[] = { left, right };
+	size_t buf_len;
+	int ret;
+
+	if (!ally_prefs.anti_deadzone_support) {
+		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_ANTI_DEADZONE,
+					       payload, sizeof(payload),
+					       &buf_len);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(hdev, buf, buf_len);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set anti-deadzone values: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Indices into ally_anti_deadzones[] */
+enum ally_joystick {
+	ALLY_LEFT_JOYSTICK,
+	ALLY_RIGHT_JOYSTICK,
+};
+
+static u8 *const ally_anti_deadzones[] = {
+	[ALLY_LEFT_JOYSTICK]  = &ally_prefs.left_anti_deadzone,
+	[ALLY_RIGHT_JOYSTICK] = &ally_prefs.right_anti_deadzone,
+};
+
+static ssize_t ally_anti_deadzone_show(struct device *dev, char *buf,
+				       enum ally_joystick which)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.anti_deadzone_support) {
+		hid_dbg(to_hid_device(dev), "Anti-deadzone not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	return sysfs_emit(buf, "%u\n", *ally_anti_deadzones[which]);
+}
+
+static ssize_t ally_anti_deadzone_store(struct device *dev, const char *buf,
+					size_t count, enum ally_joystick which,
+					const char *group)
+{
+	u8 value, dz[ARRAY_SIZE(ally_anti_deadzones)];
+	struct hid_device *hdev = to_hid_device(dev);
+	unsigned int i;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > ASUS_ALLY_ANTI_DEADZONE_MAX)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.anti_deadzone_support) {
+			hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
+			return -EOPNOTSUPP;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(dz); i++)
+			dz[i] = *ally_anti_deadzones[i];
+		dz[which] = value;
+
+		ret = ally_set_anti_deadzone(hdev, dz[ALLY_LEFT_JOYSTICK],
+					dz[ALLY_RIGHT_JOYSTICK]);
+		if (ret)
+			return ret;
+
+		*ally_anti_deadzones[which] = value;
+	}
+
+	sysfs_notify(&dev->kobj, group, "anti_deadzone");
+
+	return count;
+}
+
+/* Generates <side>_joystick_anti_deadzone_{show,store,range_show}. */
+#define ALLY_ANTI_DEADZONE_FUNCS(side, SIDE)						\
+static ssize_t side##_joystick_anti_deadzone_show(struct device *dev,			\
+						struct device_attribute *attr,		\
+						char *buf)				\
+{											\
+	return ally_anti_deadzone_show(dev, buf, ALLY_##SIDE##_JOYSTICK);		\
+}											\
+											\
+static ssize_t side##_joystick_anti_deadzone_store(struct device *dev,			\
+						struct device_attribute *attr,		\
+						const char *buf, size_t count)		\
+{											\
+	return ally_anti_deadzone_store(dev, buf, count, ALLY_##SIDE##_JOYSTICK,	\
+					#side "_joystick_axis");			\
+}											\
+											\
+static ssize_t side##_joystick_anti_deadzone_range_show(struct device *dev,		\
+							struct device_attribute *attr,	\
+							char *buf)			\
+{											\
+	return sysfs_emit(buf, "%u %u\n", ASUS_ALLY_ANTI_DEADZONE_MIN,			\
+			  ASUS_ALLY_ANTI_DEADZONE_MAX);					\
+}
+
+ALLY_ANTI_DEADZONE_FUNCS(left, LEFT)
+ALLY_ANTI_DEADZONE_FUNCS(right, RIGHT)
+
+static struct device_attribute dev_attr_left_joystick_anti_deadzone =
+	__ATTR(anti_deadzone, 0644, left_joystick_anti_deadzone_show,
+	       left_joystick_anti_deadzone_store);
+
+static struct device_attribute dev_attr_left_joystick_anti_deadzone_range =
+	__ATTR(anti_deadzone_range, 0444, left_joystick_anti_deadzone_range_show, NULL);
+
+static struct device_attribute dev_attr_right_joystick_anti_deadzone =
+	__ATTR(anti_deadzone, 0644, right_joystick_anti_deadzone_show,
+	       right_joystick_anti_deadzone_store);
+
+static struct device_attribute dev_attr_right_joystick_anti_deadzone_range =
+	__ATTR(anti_deadzone_range, 0444, right_joystick_anti_deadzone_range_show, NULL);
+
 static struct attribute *left_joystick_axis_attrs[] = {
 	&dev_attr_left_joystick_inner_threshold.attr,
 	&dev_attr_left_joystick_outer_threshold.attr,
 	&dev_attr_left_joystick_inner_threshold_range.attr,
 	&dev_attr_left_joystick_outer_threshold_range.attr,
+	&dev_attr_left_joystick_anti_deadzone.attr,
+	&dev_attr_left_joystick_anti_deadzone_range.attr,
 	NULL
 };
 
@@ -1330,6 +1478,8 @@ static struct attribute *right_joystick_axis_attrs[] = {
 	&dev_attr_right_joystick_outer_threshold.attr,
 	&dev_attr_right_joystick_inner_threshold_range.attr,
 	&dev_attr_right_joystick_outer_threshold_range.attr,
+	&dev_attr_right_joystick_anti_deadzone.attr,
+	&dev_attr_right_joystick_anti_deadzone_range.attr,
 	NULL
 };
 
@@ -1901,6 +2051,13 @@ static int hid_asus_ally_init(struct hid_device *hdev)
 			hid_warn(hdev, "Failed to restore trigger ranges: %d\n", ret);
 	}
 
+	if (ally_prefs.initialized && ally_prefs.anti_deadzone_support) {
+		ret = ally_set_anti_deadzone(hdev, ally_prefs.left_anti_deadzone,
+					     ally_prefs.right_anti_deadzone);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to restore anti-deadzone: %d\n", ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

