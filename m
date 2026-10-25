Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972365;
	b=AaaQ5CzqZW8LpLwoAQOVuI0Sl7LIeK0F6WtV9MtWLrwYfookmmWizLcLFLSjxBDieYmD
	 0mErWu+SDR7KvbpWrUAtVH7Ks03Q+OGARokdMcyR8YW3cEt41a7Q1eTIlxcoQiljWzMYn
	 ZyrS88NWf80owK7XmS9RqstQJiyDOBsfI/VSXGlgIVQrOkL9CN5Rm+r7Dhd9AtqPK03LP
	 9i6DOPcrMJHJXTKR8oeiMUIFuCg2jc7ieewnW0xeljot9C/dcU1s6+R80EWDrS5MVntUr
	 QRffFjWepyOQPxMAjCLMNRcunE+j2OYKoW+4xjPZO0NaddnjnF4igl13gtPjH/KIg8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972365;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y8iJdGAatWjgpRJO+8h5VVsaP83hFzcrW5SWOMNwbCE=;
	b=ZgbY++Rj19TrXpfeZ5Z7W/FzR/qersw8sZzKyRgFe/sZxHGC6WSxX++FQ1jBJpkCLHo9
	 vXjugaGK7WHaaZzOwne8olmOeR7rQ/NkJlggijczZp/Qr4onuXnAjIGeeFQY64v8/A88S
	 2b6QF7muaBu/ZBjw+LMC04ou1S1GrJLrIF+QUO/wubFjqTOC/8Ehcoc9c51BVaEQWlYYt
	 vlD54eArfu5moazaGWMwbo3Nk3L+44xZuyT2CFEik4/ihhyCEB0X/+ggZqfLeLw9Soz/f
	 d3DVfrp9M3gQF1r/KoEYwhuwOmPd12ZCEUYT6B05fu5OySWD/Jx4+z+Gvzhque4OybA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WcpP8h1B;
	arc=none smtp.remote-ip=91.218.175.118
Received: from mta0.migadu.com (out-118.mta0.migadu.com [91.218.175.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C63606A322
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 23:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C63606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WcpP8h1B
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=psNnxLTySOqCEjNaTzVJLvFS/8U5Xgdfzw+U0sr0rVM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792972362; v=1; x=1793577162;
 b=WcpP8h1BuUar95r5XToV2Oa8YVq2h+KagR5mWtPOqTpYJCq09uQZHrFZYRDJss64woo6N+J7
 I0omJw1RRBIWf+ScZemuvjqFQdxQJ1wSXy8o6TFfxNkI73ufRxeXNTXZvcfBasLsMQv6D2M9BQu
 /P2yK3sykirudr7faOfYO+CA=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a2b6dce39c8a4154;
	Sun, 25 Oct 2026 23:52:42 +0000
X-Mizu-Trace-ID: a2b6dce39c8a4154
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
Subject: [PATCH v11 03/18] HID: asus: add vibration strength configuration
Date: Sun, 25 Oct 2026 23:52:16 +0000
Message-ID: <20261025235232.129945-4-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025235232.129945-1-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
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
Signed-off-by: Luke Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 199 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 6d1007433daa..0471e6263c24 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -213,6 +213,10 @@ struct ally_config {
 	u8 left_trigger_max;
 	u8 right_trigger_min;
 	u8 right_trigger_max;
+
+	/* Vibration settings */
+	u8 vibration_intensity_left;
+	u8 vibration_intensity_right;
 };
 
 /*
@@ -873,15 +877,197 @@ static ssize_t xbox_controller_store(struct device *dev,
 
 static DEVICE_ATTR_RW(xbox_controller);
 
+/**
+ * ally_set_vibration_intensity() - Set vibration intensity values
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @left: Left motor intensity (0-100)
+ * @right: Right motor intensity (0-100)
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_set_vibration_intensity(struct ally_handheld *ally,
+					struct hid_device *hdev, u8 left, u8 right)
+{
+	const u8 data[] = { left, right };
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_VIBRATION_INTENSITY, data, sizeof(data));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set vibration intensity: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t left_vibration_intensity_show(struct device *dev, struct device_attribute *attr,
+					     char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	return sysfs_emit(buf, "%u\n", cfg->vibration_intensity_left);
+}
+
+static ssize_t left_vibration_intensity_store(struct device *dev, struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+	u8 value;
+	int ret;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > 100)
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	ret = ally_set_vibration_intensity(ally, hdev, value,
+					   cfg->vibration_intensity_right);
+	if (ret < 0)
+		return ret;
+
+	cfg->vibration_intensity_left = value;
+
+	sysfs_notify(&dev->kobj, "left_vibration", "intensity");
+
+	return count;
+}
+
+static ssize_t left_vibration_intensity_range_show(struct device *dev,
+						   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0 100\n");
+}
+
+static ssize_t right_vibration_intensity_show(struct device *dev, struct device_attribute *attr,
+					      char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	return sysfs_emit(buf, "%u\n", cfg->vibration_intensity_right);
+}
+
+static ssize_t right_vibration_intensity_store(struct device *dev, struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+	u8 value;
+	int ret;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	ret = kstrtou8(buf, 10, &value);
+	if (ret || value > 100)
+		return -EINVAL;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	ret = ally_set_vibration_intensity(ally, hdev,
+					   cfg->vibration_intensity_left, value);
+	if (ret < 0)
+		return ret;
+
+	cfg->vibration_intensity_right = value;
+
+	sysfs_notify(&dev->kobj, "right_vibration", "intensity");
+
+	return count;
+}
+
+static ssize_t right_vibration_intensity_range_show(struct device *dev,
+						    struct device_attribute *attr, char *buf)
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
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
 	NULL
 };
 
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
 static const struct attribute_group ally_attr_groups[] = {
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
 
 /**
@@ -926,6 +1112,8 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 		cfg->left_outer_threshold = 90;
 		cfg->right_deadzone = 10;
 		cfg->right_outer_threshold = 90;
+		cfg->vibration_intensity_left = 100;
+		cfg->vibration_intensity_right = 100;
 	}
 
 	spin_lock_irqsave(&ally_data_lock, flags);
@@ -1259,6 +1447,17 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 				 ret);
 	}
 
+	/*
+	 * The MCU does not keep the vibration intensity across a reset:
+	 * send the recorded values again, whichever interface probed.
+	 */
+	ret = ally_set_vibration_intensity(ally, hdev,
+					   cfg->vibration_intensity_left,
+					   cfg->vibration_intensity_right);
+	if (ret < 0)
+		hid_warn(hdev, "Failed to restore vibration intensity: %d\n",
+			 ret);
+
 	return 0;
 }
 
-- 
2.47.3

