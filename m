Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276059;
	b=R3+aRd/0qSt/Q5Q1lKmRa7XlIqrvj3YNAf1mhKuCcC6MZsOWgZ6HKRXkt40avYHj0B9k
	 eD5SKJLf4L4OZsVzCXoJtRu0bSjV5i+w+BUaQLwwYUZynK6QvpOvX5e99t3KB9N0sKPXU
	 fwIqn1lIdYOk/v8O+SGIca0NpxFZ+QdMT4IfGHCE+CimltAP2OLlyyXFHbfdLFzZvl6mq
	 d55tGsm/DbPBJPobXUPiNmoQ3jFR+92klDOSD6xq9hCy5wuaqRos39VhzaGqrlYRvpu8h
	 2h9yb6UI0cG2k+Tn7MKB1B8cHhs0KfZwjjzarlPh7N7d2nJC1tX2un1GipO89G+PurQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276059;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=71jfInJAfqGddTmlcqspLcvQb53FSaxHHvRNhKnpa5Y=;
	b=E7FOSV71viIER4T101fW2cTM8pGP35X4BryLfhiyAmA1IxWbys64YdhcYkmtB+42LzFb
	 NCKXz2++Tl84Knnjsv1yjotgn9lJ/yJ+xIJ2gWNNc4rGVqEZF5tNglhwo9IvPF67jVGuP
	 n2aELO3NQ/Ju/JP+ct8virmHQDDtxnLXvlXrTC5Maw6O6GNsg1ePNg6cN8DCF7gYefyta
	 EudnCzDVYg7i5BBhEzPEKXwZiUUe19cLp1r8DKO57BMygnmeV1tzKTwxkrq5TEAN61xwy
	 T9wZKvoNrr7CjgBHhLHWcByCc6y7GWRKkUjldlGMRNTmF87SQRnzKwVDm8hxP4DHCEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="WZSun4/p";
	arc=none smtp.remote-ip=91.218.175.154
Received: from mta0.migadu.com (out-154.mta0.migadu.com [91.218.175.154])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C45060A263D
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C45060A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WZSun4/p
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ia9qdnGNxDyWihbRRSTSL01OFvsSZ5uOk0ivQVJMF84=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794276056; v=1; x=1794880856;
 b=WZSun4/pBV7jLodFUlzfLUdn3WFlijEN9bmUC5n+HyEF5pDW9rZaPVh1E0CsRXcY1ZVwUQaj
 98pYh1hjzyjpp5saDAsdXX+IYwmzCTmjRMJD9U8dLLPtD/aZ+9gA/bB0wYxYMXar/47bpXpMilk
 CsGlOpJZcTUp2GJRCni1JPdU=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c896d28349870a5a;
	Tue, 10 Nov 2026 02:00:56 +0000
X-Mizu-Trace-ID: c896d28349870a5a
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
Subject: [PATCH v15 07/18] HID: asus: add joysticks anti-deadzone configuration
Date: Tue, 10 Nov 2026 02:00:25 +0000
Message-ID: <20261110020036.112884-8-denis.benato@linux.dev>
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
index 5b8b4e2a901e..85641e36c922 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -107,6 +107,9 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ASUS_ALLY_INNER_THRESHOLD_MIN 0
 #define ASUS_ALLY_INNER_THRESHOLD_MAX 50
 
+#define ASUS_ALLY_ANTI_DEADZONE_MIN 0
+#define ASUS_ALLY_ANTI_DEADZONE_MAX 100
+
 #define ASUS_ALLY_TRIGGER_RANGE_LOWER_MIN 0
 #define ASUS_ALLY_TRIGGER_RANGE_LOWER_MAX 50
 #define ASUS_ALLY_TRIGGER_RANGE_UPPER_MIN 70
@@ -851,6 +854,9 @@ static struct ally_prefs {
 	u8 left_trigger_max;
 	u8 right_trigger_min;
 	u8 right_trigger_max;
+
+	u8 left_anti_deadzone;
+	u8 right_anti_deadzone;
 } ally_prefs = {
 	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
 };
@@ -1334,11 +1340,153 @@ static struct device_attribute dev_attr_right_joystick_outer_threshold =
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
 
@@ -1347,6 +1495,8 @@ static struct attribute *right_joystick_axis_attrs[] = {
 	&dev_attr_right_joystick_outer_threshold.attr,
 	&dev_attr_right_joystick_inner_threshold_range.attr,
 	&dev_attr_right_joystick_outer_threshold_range.attr,
+	&dev_attr_right_joystick_anti_deadzone.attr,
+	&dev_attr_right_joystick_anti_deadzone_range.attr,
 	NULL
 };
 
@@ -1925,6 +2075,13 @@ static int hid_asus_ally_init(struct hid_device *hdev)
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

