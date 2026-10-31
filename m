Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468522;
	b=uVc6Qmk61/USxoHHR2CdFpYftCP8eP5T1HWjMr/0tGJqyGOQVrSoFOH3Iok4bmdUH1mD
	 7qE9LzytBaXfpal7EMPjWtdd9my7J8wyUkqGVIu+DnuL0zKfAq7f28CD7Cs8iCnQF1+F9
	 FE2/WROQdcO++cpBuNw120aVay3Xa00z+5FAF38EefcuZnuStObVLnmn8ZXeJ4sVMEQY4
	 9L/r8VxruOSS9BWUrJl5bj8EmTj8gjOv/VJVOsESPqpCJzx2+MMgyZPE9wKC6ryjG1dEv
	 JU8au/u+ZC/UwIuALYFL0nqWI8hnyfjCPq+LIr/GFbZyapL+l3Ckr2FCEJ1B31/GAIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468522;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fnglHdL92d7me25ljOOzRkWIOVcn2BKelrtZ2QHAtoc=;
	b=c6N9XvTVZXZNLCuPfCm6fMU1fhYX+pNj/DRlMeTNvncuDF8p8Kj9AZq64dAj2vLUY6I2
	 XpgHsrZUFpY4iWG/fvPzkjx4G9npid8SAZwjvrXVE6YDI0Tz/peQsxF+wmKox3lfiA9BA
	 j4NBQzvBsvAfQrscFUNNz6zyEvs/DyDykS/es6lV3L2DZNY8Nbyds54TtUKPSa3Ok++uy
	 8q+1ZpBer3XxVXSo6oHQkkitNZgnMKtRdGIBIG22E258y9VJ0m4sdaH5AwzGJw8+2wGT5
	 q/alW2XuFwsBaBxtVjxN0JU0GMo13xbTEDQWrjGSC64YWcI1kuQp+UWSH04PrqSBV1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="MnFma1/B";
	arc=none smtp.remote-ip=95.215.58.251
Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A91606A321
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07A91606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MnFma1/B
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=k4UjJr4bkwrIwXAGO2C5sjzpBE0ObNx0lNhoPFFFlCk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793468520; v=1; x=1794073320;
 b=MnFma1/BoTfQJst8rNWftuTS1FtxWtBHD+At85I9cLp0fRJ+2B7rHCvaLXbjEp0rCpl7/+Ce
 rWxYT503DZPcYfsJh9XbPUYitsB8YFHMA6tICttD0BRuTKOykO8aGjajfTr9komymmHuxCBsIVM
 HrFQD4THVJuMFDlKVxKsZchk=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 81ba42ac1b05ef11;
	Sat, 31 Oct 2026 17:42:00 +0000
X-Mizu-Trace-ID: 81ba42ac1b05ef11
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
Subject: [PATCH v12 04/17] HID: asus: add vibration strength configuration
Date: Sat, 31 Oct 2026 17:41:17 +0000
Message-ID: <20261031174130.208240-5-denis.benato@linux.dev>
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

ASUS ROG Ally handhelds support the vibration strength to be configured:
add sysfs attributes to allow userspace configure motors vibration
intensity.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 173 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 5f5393ea92b7..fe2008f9d51d 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -764,6 +764,9 @@ static struct ally_prefs {
 
 	bool xbox_controller_enabled;
 	u8 gamepad_mode;
+
+	u8 vibration_intensity_left;
+	u8 vibration_intensity_right;
 } ally_prefs = {
 	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
 };
@@ -891,6 +894,154 @@ static ssize_t xbox_controller_store(struct device *dev,
 
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
+static ssize_t left_vibration_intensity_show(struct device *dev,
+					     struct device_attribute *attr, char *buf)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	return sysfs_emit(buf, "%u\n", ally_prefs.vibration_intensity_left);
+}
+
+static ssize_t left_vibration_intensity_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	u8 value;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > 100)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		ret = ally_set_vibration_intensity(hdev, value,
+						   ally_prefs.vibration_intensity_right);
+		if (ret < 0)
+			return ret;
+
+		ally_prefs.vibration_intensity_left = value;
+	}
+
+	sysfs_notify(&dev->kobj, "left_vibration", "intensity");
+
+	return count;
+}
+
+static ssize_t left_vibration_intensity_range_show(struct device *dev,
+						   struct device_attribute *attr,
+						   char *buf)
+{
+	return sysfs_emit(buf, "0 100\n");
+}
+
+static ssize_t right_vibration_intensity_show(struct device *dev,
+					      struct device_attribute *attr, char *buf)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	return sysfs_emit(buf, "%u\n", ally_prefs.vibration_intensity_right);
+}
+
+static ssize_t right_vibration_intensity_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	u8 value;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > 100)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		ret = ally_set_vibration_intensity(hdev,
+						   ally_prefs.vibration_intensity_left,
+						   value);
+		if (ret < 0)
+			return ret;
+
+		ally_prefs.vibration_intensity_right = value;
+	}
+
+	sysfs_notify(&dev->kobj, "right_vibration", "intensity");
+
+	return count;
+}
+
+static ssize_t right_vibration_intensity_range_show(struct device *dev,
+						    struct device_attribute *attr,
+						    char *buf)
+{
+	return sysfs_emit(buf, "0 100\n");
+}
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
@@ -900,6 +1051,14 @@ static const struct attribute_group ally_attr_groups[] = {
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
 
 static int ally_prefs_setup(struct hid_device *hdev)
@@ -910,6 +1069,8 @@ static int ally_prefs_setup(struct hid_device *hdev)
 	if (ret)
 		return ret;
 
+	ally_vibration_defaults();
+
 	guard(mutex)(&ally_prefs.lock);
 
 	if (!ally_prefs.initialized) {
@@ -1144,6 +1305,18 @@ static int hid_asus_ally_init(struct hid_device *hdev)
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

