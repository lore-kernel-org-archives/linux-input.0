Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756461;
	b=G3zyey3wo38SIo29QiWB2qP+DNhmTpz+VfPDR+V8q15e9qOkYtMEYDEEs7Z2oSifKL5c
	 zc3tdGfhUkst6RMQEnogvwRLmfV41FFC6I/6eGKT3Ly8t0l2FchN0iV4oJYee5nl3s5Dz
	 C3kLkXZ6z9DD6Oq2qwn/ATyIb9ZoHBPWdwPxWKHqZfFosMNC3VxXMZGAMuoiSIFXdhK1y
	 OynnNwl2zlvbbzqRILBQAS/fkA6EGPHIRKRuQGBa7yNeWe93p7F4qgEbr6QjpsXTKQtFT
	 rgmcLhcdr8o5aeKf4sBbNk5vqUsxxPBAIMsFPgq4vmuqPqprutI/xdA2UcqfPlPmJ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756461;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9y/OYJVvR1ZK72AOPVnCTo+rH5WbhzCRWRIsNCUvJmA=;
	b=HhvKAETDzs8x83TChvJeeYEXV0RQflq+QKZyWsweqhfDQHkF4Ah/tTfAeEjrV908eAKn
	 C2gY8wYevemxrNZzXTGfk6X83Ib0RWWs/SDVUEJXOdApERKyDg1CZy71RUs/Pq7h2Frza
	 x7M45FUKeWTBcaGmGyf6+Jf81K5GLpkPSGEEtaFV8QLoC9f3woxYI4B9z3jU/BjVQ/KS7
	 BrcRvUF2izodW9lsQ5Z49CS0E5MCgTfpg1+LHNl1NdPdyXo+UIgi+qhR60CSHO2U33VoB
	 ZoAMUxdyCxzXPo2NGM9Hqsg205tdp6pvspBSUKjekBcsE7oJ9ozMLJyWqnRC1tIOfNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TjpK+kOk;
	arc=none smtp.remote-ip=91.218.175.213
Received: from mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE71606A335
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE71606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TjpK+kOk
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lBD6C0Ltcl/IDnAMLgAYg+Cqj/9NK4tBXWlo+zqBRxc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793756458; v=1; x=1794361258;
 b=TjpK+kOk7v+astahsKIKFKXwTQ90ecWeUgcD29wU9ZhasG5h3cR2OWpGpABub4Q/Tm/oe+1j
 dbzi/+vGHVinCFPRUoGdc8NRLSH23+6Pz5hpqB0dgHW4aDzBPEgbUcJ1LLnV14ueP2jQa8Wl8fp
 e9me01XUATDoRLAdg4F/gO9M=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fcd6b58eca597db7;
	Wed, 04 Nov 2026 01:40:58 +0000
X-Mizu-Trace-ID: fcd6b58eca597db7
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
Subject: [PATCH v13 04/18] HID: asus: add vibration strength configuration
Date: Wed,  4 Nov 2026 01:39:21 +0000
Message-ID: <20261104013935.512713-5-denis.benato@linux.dev>
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

ASUS ROG Ally handhelds support the vibration strength to be configured:
add sysfs attributes to allow userspace configure motors vibration
intensity.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 171 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 8277d7108bb9..459061391c37 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -97,6 +97,9 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define ASUS_HID_INPUT_KBD_REPORT_ID 0x01
 
+#define ASUS_ALLY_VIBRATION_INTENSITY_MIN 0
+#define ASUS_ALLY_VIBRATION_INTENSITY_MAX 100
+
 /* Spurious HID codes sent by QUIRK_ROG_NKEY_KEYBOARD devices */
 #define ASUS_SPURIOUS_CODE_0XEA 0xea
 #define ASUS_SPURIOUS_CODE_0XEC 0xec
@@ -804,6 +807,9 @@ static struct ally_prefs {
 
 	bool xbox_controller_enabled;
 	u8 gamepad_mode;
+
+	u8 vibration_intensity_left;
+	u8 vibration_intensity_right;
 } ally_prefs = {
 	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
 };
@@ -976,6 +982,149 @@ static ssize_t xbox_controller_store(struct device *dev,
 
 static DEVICE_ATTR_RW(xbox_controller);
 
+/**
+ * ally_set_vibration_intensity() - Set the gamepad vibration intensity
+ * @hdev: HID device the command packet is sent on
+ * @left: left motor intensity
+ * @right: right motor intensity
+ *
+ * Context: Caller holds ally_prefs.lock.
+ * Return: 0 on success, negative errno on failure.
+ */
+static int ally_set_vibration_intensity(struct hid_device *hdev, u8 left, u8 right)
+{
+	const u8 data[] = { left, right };
+	size_t buf_len;
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_VIBRATION_INTENSITY,
+					       data, sizeof(data), &buf_len);
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(hdev, buf, buf_len);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set vibration intensity: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ally_vibration_defaults(void)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (ally_prefs.initialized)
+		return;
+
+	ally_prefs.vibration_intensity_left = 100;
+	ally_prefs.vibration_intensity_right = 100;
+}
+
+/* Indices into ally_vibration[], in the order ally_set_vibration_intensity() takes them. */
+enum ally_vibration {
+	ALLY_VIBRATION_LEFT,
+	ALLY_VIBRATION_RIGHT,
+};
+
+static u8 *const ally_vibration[] = {
+	[ALLY_VIBRATION_LEFT]  = &ally_prefs.vibration_intensity_left,
+	[ALLY_VIBRATION_RIGHT] = &ally_prefs.vibration_intensity_right,
+};
+
+static ssize_t ally_vibration_intensity_show(char *buf, enum ally_vibration which)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	return sysfs_emit(buf, "%u\n", *ally_vibration[which]);
+}
+
+static ssize_t ally_vibration_intensity_store(struct device *dev, const char *buf,
+					      size_t count, enum ally_vibration which,
+					      const char *group)
+{
+	u8 value, v[ARRAY_SIZE(ally_vibration)];
+	struct hid_device *hdev = to_hid_device(dev);
+	size_t i;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > ASUS_ALLY_VIBRATION_INTENSITY_MAX)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		for (i = 0; i < ARRAY_SIZE(v); i++)
+			v[i] = *ally_vibration[i];
+		v[which] = value;
+
+		ret = ally_set_vibration_intensity(hdev,
+						   v[ALLY_VIBRATION_LEFT],
+						   v[ALLY_VIBRATION_RIGHT]);
+		if (ret < 0)
+			return ret;
+
+		*ally_vibration[which] = value;
+	}
+
+	sysfs_notify(&dev->kobj, group, "intensity");
+
+	return count;
+}
+
+/* Generates <side>_vibration_intensity_{show,store,range_show}. */
+#define ALLY_VIBRATION_FUNCS(side, SIDE)						\
+static ssize_t side##_vibration_intensity_show(struct device *dev,			\
+					       struct device_attribute *attr,		\
+					       char *buf)				\
+{											\
+	return ally_vibration_intensity_show(buf, ALLY_VIBRATION_##SIDE);		\
+}											\
+											\
+static ssize_t side##_vibration_intensity_store(struct device *dev,			\
+						struct device_attribute *attr,		\
+						const char *buf, size_t count)		\
+{											\
+	return ally_vibration_intensity_store(dev, buf, count, ALLY_VIBRATION_##SIDE,	\
+					      #side "_vibration");			\
+}											\
+											\
+static ssize_t side##_vibration_intensity_range_show(struct device *dev,		\
+						     struct device_attribute *attr,	\
+						     char *buf)				\
+{											\
+	return sysfs_emit(buf, "%u %u\n", ASUS_ALLY_VIBRATION_INTENSITY_MIN,		\
+			  ASUS_ALLY_VIBRATION_INTENSITY_MAX);				\
+}
+
+ALLY_VIBRATION_FUNCS(left,  LEFT)
+ALLY_VIBRATION_FUNCS(right, RIGHT)
+
+static struct device_attribute dev_attr_left_vibration_intensity =
+	__ATTR(intensity, 0644, left_vibration_intensity_show, left_vibration_intensity_store);
+
+static struct device_attribute dev_attr_left_vibration_intensity_range =
+	__ATTR(intensity_range, 0444, left_vibration_intensity_range_show, NULL);
+
+static struct device_attribute dev_attr_right_vibration_intensity =
+	__ATTR(intensity, 0644, right_vibration_intensity_show, right_vibration_intensity_store);
+
+static struct device_attribute dev_attr_right_vibration_intensity_range =
+	__ATTR(intensity_range, 0444, right_vibration_intensity_range_show, NULL);
+
+static struct attribute *ally_left_vibration_attrs[] = {
+	&dev_attr_left_vibration_intensity.attr,
+	&dev_attr_left_vibration_intensity_range.attr,
+	NULL
+};
+
+static struct attribute *ally_right_vibration_attrs[] = {
+	&dev_attr_right_vibration_intensity.attr,
+	&dev_attr_right_vibration_intensity_range.attr,
+	NULL
+};
+
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
 	NULL
@@ -985,6 +1134,14 @@ static const struct attribute_group ally_attr_groups[] = {
 	{
 		.attrs = ally_config_attrs,
 	},
+	{
+		.name = "left_vibration",
+		.attrs = ally_left_vibration_attrs,
+	},
+	{
+		.name = "right_vibration",
+		.attrs = ally_right_vibration_attrs,
+	},
 };
 
 static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
@@ -995,6 +1152,8 @@ static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
 	if (ret)
 		return ret;
 
+	ally_vibration_defaults();
+
 	scoped_guard(mutex, &ally_prefs.lock) {
 		if (!ally_prefs.initialized) {
 			ally_prefs.gamepad_mode = 0x01;
@@ -1241,6 +1400,18 @@ static int hid_asus_ally_init(struct hid_device *hdev)
 			hid_warn(hdev, "Failed to apply Xbox controller mode: %d\n", ret);
 	}
 
+	/*
+	 * The MCU does not keep the vibration intensity across a reset:
+	 * send the recorded values again.
+	 */
+	if (ally_prefs.initialized) {
+		ret = ally_set_vibration_intensity(hdev,
+						   ally_prefs.vibration_intensity_left,
+						   ally_prefs.vibration_intensity_right);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to restore vibration intensity: %d\n", ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

