Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5E378826
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775535243; cv=none; b=Cri08axi/y6Yp/puUkZzZzsT2PopDJ/Eis068+AuNI+KrJMGPiENkVOBTlCvnf0AndIU2/lGApAgU4bjwPttQdH/F/N0HzOJtmiPKg9v0421wLiUti2ew3H5FPvMhbJZv5TAEVF4HAo/tjYvcC5rx2vMfbuKRWwyHfyhdoaeks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775535243; c=relaxed/simple;
	bh=Cla/z/B6my+ZQS1hti3wyKv25wrYIqurABwe3k0OtC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHaAnc8h3S7J1XhIdLL1B+8199hXL4LluqGUwA+G5KP138tLQNlxc2Bx6L0LXrPaYkyzNHcQaTnhT1ErmrZz244Xf+6Z3zxixH4jl4mCQkyGv2fOCjbu6YY1rJZawXKVEIDyoK02JcdPb5ziGAmUTjDAZ5NPjkiYxx6Ild7WAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOojSli+; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOojSli+"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732e6a123so2460611c88.1
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 21:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775535240; x=1776140040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88wfNytKmOqUD3hYL9QlOT4XMulvq8D+K4Wg910adVs=;
        b=JOojSli+vR7ZoxfHmDKIAfMGzvUXNmbuSsLfbxoSY8vU17oUTr5PM6cAKL4UcjO/9j
         kJdwBsnTQOPHh8RLmrW/MKYw3bZHGtG0hH3Y9w5yCSnoHQ5Hj/YoFab+euudzn9tI/gl
         gOvoAkNJGTy4Cd2mQ1q8p5Jk+mMMcaLztnA6W9Ko4b3l58n0iueA2RN/N/ZJzZAjyXHY
         7W+0JLoh6OuOQ1I1nRgdggIf8nhLz+hBhjMHRFuIo/tnIdDSmLKdBMLOo6uxkQizK8Vd
         QhxaSoOlSJs2tE0TSm0blgjVkYZPgNGC0+P4s8/SnAJSh85z33fzby/qGKxiZreWLuz+
         P0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775535240; x=1776140040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88wfNytKmOqUD3hYL9QlOT4XMulvq8D+K4Wg910adVs=;
        b=iRVOKJLFOwAzP9TW210ELkc3rjH/Tqzk4y2+K/TuulptQJ2LQgc6NDyYPbTiNaGkc2
         9rQueuhPAZnkTcpaG3JCYSmftFg6qJEb+fnMXm8UjOEYNHNIyLftdI1Riq7ZCNgVIbDq
         QR5EPkdrfkQCROZgPihSwS+LyBVBjvlRlagE09YDQfkINffcOgQoYYU3vPDnzoiLVi4S
         nM+ud8iG6AgoRr9rBdzcfG4gm3Ety1bTiop7kF3bs18Bt6D763PjEH/dIht3vcGOx9E+
         5qAxbdQeLcSzScZMSI7mZRdRlmTnKUluzNSJy8dz47cXl/8PuW+6i0cOy6kYVickD/+X
         7H9g==
X-Forwarded-Encrypted: i=1; AJvYcCWLFVEO0FUBWHDWMoFFye1VrfeSsMmQcmrDs/MLOjNgBMMDbO+EC3B7ANol6BMUL9yUuOCwAExCV9Mwqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0HQmKaTcEv5uSAiQxqfyBzD72YOvi34jJOM1xCR74gugqVx/V
	Yc7foHtMheSvymEL1QN6Vt97uYeuNB71YSXVa9FirZfB/KZFyMbY1EF/
X-Gm-Gg: AeBDiev+QwYA8bGpdf0lPaYrMqzw1c8NHYtWQCM8hWJJumGgfZZWf+8FoEChy0jW9n8
	+IqBIGZaVSSisWAzF82jnSKjha/HcvNHIpn8hzjH7GJ+nkPx9WNMThLYwcajJrjXoFo+bKMVu83
	FCfoEFcy1LISGUbPFmn+QDmNoT7Wdxg9/ivOM2Z+AguZOt4ep14Rl1hpeTV7SkwavWjBrg1B66l
	3opVpnmigsjOPt/0y8Wl5R9D+i7j7dzBlOO308m4lJ3yeUeDlNZgC+6W6wiMs1MiVC9zp9X2S3M
	jFrcdW0MnkcTsyjJtHygl9UORDX/b/o7fdCJ1dzEieIreDgXqO3e6hv4Tph2DnIvaZCt1EM5GAH
	qmlhMeqezZzbQlCJj0aOnosbiUV3tT+yqunLTnnW8Pq3wR6bm3yVO+ccThY+a8zbIc2vBun5rVa
	4y4kbt9Qp88LKDQrTBv3w/scO/DdjASocUOD2Sn7/NWDc1v+Pq/FzM5PfyQQh4pIZXiO66+DOVr
	MPi
X-Received: by 2002:a05:7022:ec17:b0:128:ca6f:adf2 with SMTP id a92af1059eb24-12bfb76c075mr8444829c88.32.1775535240444;
        Mon, 06 Apr 2026 21:14:00 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm18523808c88.0.2026.04.06.21.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:14:00 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Lambert Fan <fanzhaoming@anopc.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] HID: hid-oxp: Add Vibration Intensity Attributes
Date: Tue,  7 Apr 2026 04:13:54 +0000
Message-ID: <20260407041354.2283201-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407041354.2283201-1-derekjohn.clark@gmail.com>
References: <20260407041354.2283201-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds attribute for setting the rumble intensity level. This setting must
be re-applied after the gamepad mode is set as doing so resets this to
the default value.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-oxp.c | 80 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 1100f1f14f35..cad6973089a0 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -34,6 +34,7 @@ enum oxp_function_index {
 	OXP_FID_GEN1_RGB_SET =		0x07,
 	OXP_FID_GEN1_RGB_REPLY =	0x0f,
 	OXP_FID_GEN2_TOGGLE_MODE =	0xb2,
+	OXP_FID_GEN2_RUMBLE_SET =	0xb3,
 	OXP_FID_GEN2_KEY_STATE =	0xb4,
 	OXP_FID_GEN2_STATUS_EVENT =	0xb8,
 };
@@ -178,6 +179,7 @@ static struct oxp_hid_cfg {
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
 	u8 rgb_brightness;
 	u8 gamepad_mode;
+	u8 rumble_intensity;
 	u8 rgb_effect;
 	u8 rgb_speed;
 	u8 rgb_en;
@@ -263,6 +265,11 @@ static const char *const oxp_rgb_effect_text[] = {
 	[OXP_EFFECT_MONO_LIST] = "monocolor",
 };
 
+enum oxp_rumble_side_index {
+	OXP_RUMBLE_LEFT = 0x00,
+	OXP_RUMBLE_RIGHT,
+};
+
 struct oxp_gen_1_rgb_report {
 	u8 report_id;
 	u8 message_id;
@@ -338,6 +345,7 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
 
 static int oxp_gen_2_property_out(enum oxp_function_index fid, u8 *data, u8 data_size);
 static int oxp_set_buttons(void);
+static int oxp_rumble_intensity_set(u8 intensity);
 
 static void oxp_mcu_init_fn(struct work_struct *work)
 {
@@ -365,6 +373,12 @@ static void oxp_mcu_init_fn(struct work_struct *work)
 	if (ret)
 		dev_err(&drvdata.hdev->dev,
 			"Error: Failed to set gamepad mode: %i\n", ret);
+
+	/* Set vibration level */
+	ret = oxp_rumble_intensity_set(drvdata.rumble_intensity);
+	if (ret)
+		dev_err(&drvdata.hdev->dev,
+			"Error: Failed to set rumble intensity: %i\n", ret);
 }
 
 static DECLARE_DELAYED_WORK(oxp_mcu_init, oxp_mcu_init_fn);
@@ -513,6 +527,14 @@ static ssize_t gamepad_mode_store(struct device *dev,
 
 	drvdata.gamepad_mode = data[0];
 
+	if (drvdata.gamepad_mode == OXP_GP_MODE_DEBUG)
+		return count;
+
+	/* Re-apply rumble settings as switching gamepad mode will override */
+	ret = oxp_rumble_intensity_set(drvdata.rumble_intensity);
+	if (ret)
+		return ret;
+
 	return count;
 }
 
@@ -858,6 +880,59 @@ static ssize_t button_mapping_options_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(button_mapping_options);
 
+static int oxp_rumble_intensity_set(u8 intensity)
+{
+	u8 header[15] = { 0x02, 0x38, 0x02, 0xe3, 0x39, 0xe3, 0x39, 0xe3,
+			  0x39, 0x01, intensity, 0x05, 0xe3, 0x39, 0xe3 };
+	u8 footer[9] = { 0x39, 0xe3, 0x39, 0xe3, 0xe3, 0x02, 0x04, 0x39, 0x39 };
+	size_t footer_size = ARRAY_SIZE(footer);
+	size_t header_size = ARRAY_SIZE(header);
+	u8 data[59] = { 0x0 };
+	size_t data_size = ARRAY_SIZE(data);
+
+	memcpy(data, header, header_size);
+	memcpy(data + data_size - footer_size, footer, footer_size);
+
+	return oxp_gen_2_property_out(OXP_FID_GEN2_RUMBLE_SET, data, data_size);
+}
+
+static ssize_t rumble_intensity_store(struct device *dev,
+				      struct device_attribute *attr, const char *buf,
+				      size_t count)
+{
+	int ret;
+	u8 val;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val < 0 || val > 5)
+		return -EINVAL;
+
+	ret = oxp_rumble_intensity_set(val);
+	if (ret)
+		return ret;
+
+	drvdata.rumble_intensity = val;
+
+	return count;
+}
+
+static ssize_t rumble_intensity_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%i\n", drvdata.rumble_intensity);
+}
+static DEVICE_ATTR_RW(rumble_intensity);
+
+static ssize_t rumble_intensity_range_show(struct device *dev,
+					   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0-5\n");
+}
+static DEVICE_ATTR_RO(rumble_intensity_range);
+
 #define OXP_DEVICE_ATTR_RW(_name, _group)                                     \
 	static ssize_t _name##_store(struct device *dev,                      \
 				     struct device_attribute *attr,           \
@@ -949,6 +1024,8 @@ static struct attribute *oxp_cfg_attrs[] = {
 	&dev_attr_gamepad_mode.attr,
 	&dev_attr_gamepad_mode_index.attr,
 	&dev_attr_reset_buttons.attr,
+	&dev_attr_rumble_intensity.attr,
+	&dev_attr_rumble_intensity_range.attr,
 	NULL,
 };
 
@@ -1420,10 +1497,9 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 
 	drvdata.bmap_1 = bmap_1;
 	drvdata.bmap_2 = bmap_2;
+	drvdata.rumble_intensity = 5;
 	mod_delayed_work(system_wq, &oxp_mcu_init, msecs_to_jiffies(50));
 
-	drvdata.gamepad_mode = OXP_GP_MODE_XINPUT;
-
 	ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
 	if (ret)
 		return dev_err_probe(&hdev->dev, ret,
-- 
2.53.0

