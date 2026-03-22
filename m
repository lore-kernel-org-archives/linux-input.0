Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40484221FDE
	for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774149382; cv=none; b=lshjULVKAXay9Y0tzqe018iD01tuif66al+/rQ7hFgYEPB9qkTSOoiAksd/KXk0j6uJohPGRqaWxUbMwnv1UI59y9uwVdYq5hQ5sxX8NGR3oN5WdVtObA4c7LvlSDtgpan8/9pv9HXK4Ife2AylPeSByV6lKXkY4LNjzTCfCMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774149382; c=relaxed/simple;
	bh=PAz+jORhNkt0zBVszAhrT9bv/0URLsybiRVH5ZrKrkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UO1P9MFpuBbmf0lCwjN2iR8WJLzODwIuPzYYIwPy6iL76SAZugvnamg7kC8X4WVIoey25ZdeMF37/tT3DoL3GqyILwRBECPF9cmF2VCk+fj0B4HEYZOkx+38EoPPvArVJGlGDwbjyVWz9XJJtRp7K95jPy9Z/9Yo1s4bwYX0Xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvNt8u9C; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvNt8u9C"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c0ecaae7dfso5344174eec.1
        for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 20:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774149380; x=1774754180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b6kol1RuqZ0ewRBN2du10oKoyZWNZPlgpHx1CYYLuk=;
        b=IvNt8u9CPp4zI3Ha09F5n4PcyPJzYe0SyHs0Mi4+uBrkwO9RdX9YDDlEtVA3m5jFiy
         ZXRrLYhQg2U6uGn8EqIcMPL3rOvEikWftuOsGcjzdrltJS7zdPoDyirJq4LPtr0ldjKM
         bVA7G63jOdEBqTU/81Pq5ASKk2ECuX2tKapQZ9mBapYvzt66SmIuG1FB8o26LrhUBz1S
         qRlDzR4iUxkycRFA+Wk4FJRDowU9tjXCBZrAjG0ImEVr5V70kowWnlPk6vNYPr14qH41
         z7Ba4TAAIARqULXX2S+bo1iAdyMofC8PN+CKWNYj8ARhI2fZga8AI+aJSnJNCfOwrgsL
         ur0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774149380; x=1774754180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2b6kol1RuqZ0ewRBN2du10oKoyZWNZPlgpHx1CYYLuk=;
        b=GRDzeBYY4fDGeS7/jFJOUkWRwikx4dvZokX69+2s2APy06oEEFA9ChlRqtEHV/CPtN
         WwMXv/03qHkiK6xunsfL3RBgmzmbo31/mLZVTGLeVUn25/geCB6/P6shIGWK5R46trEl
         nR5mH5I4k2+tNyjHnDAvygbYrvBdVkO/7DjrhlpzoqVaJpyPfjfeXzMKA2BrFn4mCPIO
         x33r5LUHjvrkTKNkBtoTlhKlgMTc03SS2SIVHin/r7TTk+4xj1IM9A4wQchqOOCNhKQU
         cqw5N3HWVm3+F+1MdC7NP+KI4dWJurMyOEB18J84kdtwLurb9gvdWzc1fS/i2hIyABt6
         L/SA==
X-Forwarded-Encrypted: i=1; AJvYcCUd6R9VD58C7yE4u9RUKNDHdPAvbEbbmCqSVghCK1NFgyfzo1tF3c6zJKTZxAlFCmmHfTEYZM/FebG6MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoR4dAB/BFd2m5Pa+PlqI1MuK0FaKPovYh3zrmH+Qne+oYCLs8
	t3hvGDSOA4RQHUAKD4O7IsA52Vvu9mFAu73LWsKWmbRdS5PC272f08kc
X-Gm-Gg: ATEYQzzlmgDXRmEPR2NvgdSK7Esp4Pv1dWiIojOU0oObvNkuDMW1ocCwfW34ko69Hqj
	P35hLEGUFLrTKKxBMgXQS1YUNex757df2J5J7mlPUYqAVWwxyeiS2Ihf4bpOOR6WrTjh/mc2u10
	ZUvQVkpRTTE57tMHAQZ3woiv9TvBE7y/5NMJVkjiCJcDw67zxpjbt9j6F/Jr4zRtcAaLd9soERg
	ZIZZAKtO/PgkKe9NKBkPm+FGbuLaAWfjctEceepxk1hcWCDZAaqY7AStVfGFEstRxY0hEeuAKeH
	Q8bc1b5ATQ5SZSeFBC98+tkW1/d7JJGY1nrYy9sSf2+QI71PC2ZSymxSvdBEw+TZkP1tYfz3sEQ
	oZ1Cb0Xe8E8arkBPG8q2mK0/ENmtILls3nPP+6AIAfVBbMm+J43NUN62EVftcBzm5xXkKJamiyY
	/KJKLmdr+8adVM//IpT9FsZBHFrz+U9Qwhzn1TvTIbKLupFnKLbnWdz8YY2w5Gtw8dcv7Rwtj8p
	wYq
X-Received: by 2002:a05:7301:2f86:b0:2c0:ae1b:4568 with SMTP id 5a478bee46e88-2c1095684fdmr3703901eec.7.1774149380263;
        Sat, 21 Mar 2026 20:16:20 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31bef1sm11220460eec.26.2026.03.21.20.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 20:16:20 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Lambert Fan <fanzhaoming@anopc.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] HID: hid-oxp: Add Second Generation Takeover Mode
Date: Sun, 22 Mar 2026 03:16:14 +0000
Message-ID: <20260322031615.1524307-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322031615.1524307-1-derekjohn.clark@gmail.com>
References: <20260322031615.1524307-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds "takeover_enabled" attribute to second generation OneXPlayer
configuration HID devices. This attribute initiates a mode shift in the
device MCU that puts it into a state where all events are routed to an
hidraw interface instead of the xpad evdev interface. This allows for
debugging the hardware input mapping, and allows some userspace tools to
consume the interface to add support for features that are unable to be
exposed through the evdev, such as treating the M1 and M2 accessory
buttons as unique inputs.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-oxp.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 587e0d57c85f..5fed2799a2ad 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -32,6 +32,7 @@
 enum oxp_function_index {
 	OXP_FID_GEN1_RGB_SET =		0x07,
 	OXP_FID_GEN1_RGB_REPLY =	0x0f,
+	OXP_FID_GEN2_TOGGLE_MODE =	0xb2,
 	OXP_FID_GEN2_RGB_EVENT =	0xb8,
 };
 
@@ -39,12 +40,15 @@ static struct oxp_hid_cfg {
 	struct led_classdev_mc *led_mc;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	u8 takeover_enabled;
 	u8 rgb_brightness;
 	u8 rgb_effect;
 	u8 rgb_speed;
 	u8 rgb_en;
 } drvdata;
 
+#define OXP_TAKEOVER_ENABLED_TRUE 0x03
+
 enum oxp_feature_en_index {
 	OXP_FEAT_DISABLED,
 	OXP_FEAT_ENABLED,
@@ -289,6 +293,74 @@ static int oxp_gen_2_property_out(enum oxp_function_index fid, u8 *data,
 				footer_size);
 }
 
+static ssize_t button_takeover_store(struct device *dev,
+				     struct device_attribute *attr, const char *buf,
+				     size_t count)
+{
+	u16 up = get_usage_page(drvdata.hdev);
+	u8 data[3] = { 0x00, 0x01, 0x02 };
+	u8 val = 0;
+	int ret;
+
+	if (up != GEN2_USAGE_PAGE)
+		return -EINVAL;
+
+	ret = sysfs_match_string(oxp_feature_en_text, buf);
+	if (ret < 0)
+		return ret;
+	val = ret;
+
+	switch (val) {
+	case OXP_FEAT_DISABLED:
+		break;
+	case OXP_FEAT_ENABLED:
+		data[0] = OXP_TAKEOVER_ENABLED_TRUE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = oxp_gen_2_property_out(OXP_FID_GEN2_TOGGLE_MODE, data, 3);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t button_takeover_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", oxp_feature_en_text[drvdata.takeover_enabled]);
+}
+static DEVICE_ATTR_RW(button_takeover);
+
+static ssize_t button_takeover_index_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	ssize_t count = 0;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(oxp_feature_en_text); i++)
+		count += sysfs_emit_at(buf, count, "%s ", oxp_feature_en_text[i]);
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(button_takeover_index);
+
+static struct attribute *oxp_cfg_attrs[] = {
+	&dev_attr_button_takeover.attr,
+	&dev_attr_button_takeover_index.attr,
+	NULL,
+};
+
+static const struct attribute_group oxp_cfg_attrs_group = {
+	.attrs = oxp_cfg_attrs,
+};
+
 static int oxp_rgb_status_store(u8 enabled, u8 speed, u8 brightness)
 {
 	u16 up = get_usage_page(drvdata.hdev);
@@ -680,6 +752,15 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 		dev_warn(drvdata.led_mc->led_cdev.dev,
 			 "Failed to query RGB initial state: %i\n", ret);
 
+	/* Below features are only implemented in gen 2 */
+	if (up != GEN2_USAGE_PAGE)
+		return 0;
+
+	ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
+	if (ret)
+		return dev_err_probe(&hdev->dev, ret,
+				     "Failed to attach configuration attributes\n");
+
 	return 0;
 }
 
-- 
2.53.0

