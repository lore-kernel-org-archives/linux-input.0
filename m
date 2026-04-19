Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA32372EEA
	for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776572795; cv=none; b=los4s0yqHtK7++rjJSe3xjVSW4M5XhusPDznPfaPUq0vwrX8J92HigR9f9ssJEhNyMfmqNprxVajLGNNj79el2YjbobNPOb0sD5L7FS+0LCyGS+fEukNuq6znXvMUCauipi7JehFzFj5S2Np8xTECAUHyGqbvdQHTQQKzN6FGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776572795; c=relaxed/simple;
	bh=Vi9PqZV0aXECK80MyjVb3o/Dg8qbSiQd83dlKewCK2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPWDqx5t15c0ORXeSfSIUQszj5Pyj9kmjYSv5qpHchc1AzFdj8zCzA2ROfu2YYcjM81ZiNJOEdTOrt64hYLhtPihycHWSFscMDRX+DDbwil9ukl4SeZUgV3Wr1Ps9itnsikZHc3CLZyLjfnBUIfI2IL8RVWUB7GQU9AkTux3sr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jro1ctLi; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jro1ctLi"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2e221a71e19so1738437eec.0
        for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 21:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776572789; x=1777177589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1JsOiO2bFXAeWBZ1uKhtK3IbGV3pZa0fjeBJoVwYso=;
        b=jro1ctLiNMP24BXEBsaLeXFbaYxCGxAGYxjVlybS2VmUpYVBm/BNlA0RPnAkEexBdu
         582t8FNrLBbPL90Co+yynAIcOck1vTRA9/g9g7EZ1dwvtUGd0fahA97igJxCo+oL7Rru
         hqQM4rYod02yptnUJWXga8cXx5HSGBGcBU2anv9ruRyaP5STRFhQ6pYJCGfFXJMU7/ii
         6ZoNDor2nafNG4QNLU2lR3mDJrlQT3j9D6cJBx7ELIL0aZrxh8xudCn3IjMuuRmIQVs3
         S3Kk6D60s2yW/BjjFyWKuIYwKECHQ7Iofit+o4T2NRQRQyxMqQpie1oqh4JWMojDKyQ0
         y0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776572789; x=1777177589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g1JsOiO2bFXAeWBZ1uKhtK3IbGV3pZa0fjeBJoVwYso=;
        b=r1adx0nk/J87xYBpxEAvK78M1RoHfjZZO+oqAyI+/NkQOjjJoNWitM5GJrVP/mZBzc
         EtNzwd1OTEMpPDirrJMtCRAcAmJe4oCX8Ef53O3VEWBAuV+6Wgng8uppVb5os835VboJ
         cz3VE/7JXOtAgYEsOEf4FyUKDzFjV0qqP7cV42Y5LGJQASK+hglimEEOsWSlFa5d8ChD
         PoDr0ucAZFkBYLfA+wDgxApxnLNwPjFiYSPrTPFowTnrOnzdlHQIAlvMqbJ0wj0K/uVZ
         N73s42iABY32yBL8dVdO+N4fUps1pYUAaTujASZwUbplpM7Nx7d0pEHanOYz4e0myP04
         B48w==
X-Forwarded-Encrypted: i=1; AFNElJ8hB9XGq5YqS9e7gNY9vj/Ipsn7MdMVtoNBaxu+582b9obL0PS2AcFPfOb+UH8xFNco6Cwa0cVrDB8NdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xCu2OeHTX6UMs+MYfE3D5lUeLK8bjga+AusUas4V3iq7GfAs
	goYQzkgP2+Axvc2YteKPBLWAcHmdZVID1+Z9UfKdRPGk6IpDdpsNQ5kk
X-Gm-Gg: AeBDievjOd3swWCSM0yq8/eCsEqJGFzK9RbrzsZiRNz01jfHSbY6XlCb2pJiQn/46dz
	dq0XamOYy8Fo+NSweOxM+KTbCwoGrz+BR4ajq4uZmzztaRQt2zly8Du0tYUsX4GGepeRblAIg8U
	2CP5/x51dEtZWNluJ+kzeBZcSn97jkI8zTpjwbPtXlJ4zoPd4Rp4PE6WMXyuEFzHN4PeKytGJhh
	Uj7ZAk9nbuiCqMOTBhraPeTWvSezvBay/ptehDbOJXZMIrFElbSx8nXSNUEQh65oeNWENYeJV4r
	OHUH8UhDUTKrgC6vXF9aOo8twRI0gbwRW8ewxLMu5pEn0GJyto/Zl8dofKQKE7pa5GsoOP7+zVi
	1ZT4NB5U+Kj3LVAUXr8hUmXqYzZH1T16ntGPOQGn5UBnNz2Jswvhy05eCi2K2qz1bhU/dPvUkVD
	rmJfl7U+AYr2/b9hrA3LNJio8YI5rOmVGiW8xCZrszT+cGPJKk6EO/8NX3Mxk3ApA1KMzZc0Cmm
	Ki+D4n/eOfyAKVZKfpN3zI9bg==
X-Received: by 2002:a05:7301:d17:b0:2c5:50fe:c78f with SMTP id 5a478bee46e88-2e47816b33dmr3945383eec.12.1776572788578;
        Sat, 18 Apr 2026 21:26:28 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53dcb487bsm8796469eec.31.2026.04.18.21.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 21:26:28 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Lambert Fan <fanzhaoming@anopc.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] HID: hid-oxp: Add Second Generation Gamepad Mode Switch
Date: Sat, 18 Apr 2026 21:26:22 -0700
Message-ID: <20260419042624.625746-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419042624.625746-1-derekjohn.clark@gmail.com>
References: <20260419042624.625746-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds "gamepad_mode" attribute to second generation OneXPlayer
configuration HID devices. This attribute initiates a mode shift in the
device MCU that puts it into a state where all events are routed to an
hidraw interface instead of the xpad evdev interface. This allows for
debugging the hardware input mapping added in the next patch.

Reviewed-by: Zhouwang Huang <honjow311@gmail.com>
Tested-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v4:
  - Add oxp_mcu_init delayed work struct to drvdata & properly init,
    add cancel delayed work during remove.
v2:
  - Rename to gamepad_mode & show relevant gamepad modes instead of
    using a debug enable/disable paradigm, to match other drivers.
---
 drivers/hid/hid-oxp.c | 131 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 835de2118e3c..2504b56b8f8a 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -33,20 +33,33 @@
 enum oxp_function_index {
 	OXP_FID_GEN1_RGB_SET =		0x07,
 	OXP_FID_GEN1_RGB_REPLY =	0x0f,
+	OXP_FID_GEN2_TOGGLE_MODE =	0xb2,
 	OXP_FID_GEN2_STATUS_EVENT =	0xb8,
 };
 
 static struct oxp_hid_cfg {
 	struct delayed_work oxp_rgb_queue;
+	struct delayed_work oxp_mcu_init;
 	struct led_classdev_mc *led_mc;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
 	u8 rgb_brightness;
+	u8 gamepad_mode;
 	u8 rgb_effect;
 	u8 rgb_speed;
 	u8 rgb_en;
 } drvdata;
 
+enum oxp_gamepad_mode_index {
+	OXP_GP_MODE_XINPUT = 0x00,
+	OXP_GP_MODE_DEBUG = 0x03,
+};
+
+static const char *const oxp_gamepad_mode_text[] = {
+	[OXP_GP_MODE_XINPUT] = "xinput",
+	[OXP_GP_MODE_DEBUG] = "debug",
+};
+
 enum oxp_feature_en_index {
 	OXP_FEAT_DISABLED,
 	OXP_FEAT_ENABLED,
@@ -182,6 +195,30 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
 	return 0;
 }
 
+static int oxp_gen_2_property_out(enum oxp_function_index fid, u8 *data, u8 data_size);
+
+static void oxp_mcu_init_fn(struct work_struct *work)
+{
+	u8 gp_mode_data[3] = { OXP_GP_MODE_DEBUG, 0x01, 0x02 };
+	int ret;
+
+	/* Cycle the gamepad mode */
+	ret = oxp_gen_2_property_out(OXP_FID_GEN2_TOGGLE_MODE, gp_mode_data, 3);
+	if (ret)
+		dev_err(&drvdata.hdev->dev,
+			"Error: Failed to set gamepad mode: %i\n", ret);
+
+	/* Remainder only applies for xinput mode */
+	if (drvdata.gamepad_mode == OXP_GP_MODE_DEBUG)
+		return;
+
+	gp_mode_data[0] = OXP_GP_MODE_XINPUT;
+	ret = oxp_gen_2_property_out(OXP_FID_GEN2_TOGGLE_MODE, gp_mode_data, 3);
+	if (ret)
+		dev_err(&drvdata.hdev->dev,
+			"Error: Failed to set gamepad mode: %i\n", ret);
+}
+
 static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 				   struct hid_report *report, u8 *data,
 				   int size)
@@ -192,6 +229,14 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	if (data[0] != OXP_FID_GEN2_STATUS_EVENT)
 		return 0;
 
+	/* Sent ~6s after resume event, indicating the MCU has fully reset.
+	 * Re-apply our settings after this has been received.
+	 */
+	if (data[3] == OXP_EFFECT_MONO_TRUE) {
+		mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
+		return 0;
+	}
+
 	if (data[3] != OXP_GET_PROPERTY)
 		return 0;
 
@@ -289,6 +334,77 @@ static int oxp_gen_2_property_out(enum oxp_function_index fid, u8 *data,
 				footer_size);
 }
 
+static ssize_t gamepad_mode_store(struct device *dev,
+				  struct device_attribute *attr, const char *buf,
+				  size_t count)
+{
+	u16 up = get_usage_page(drvdata.hdev);
+	u8 data[3] = { 0x00, 0x01, 0x02 };
+	int ret = -EINVAL;
+	int i;
+
+	if (up != GEN2_USAGE_PAGE)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(oxp_gamepad_mode_text); i++) {
+		if (oxp_gamepad_mode_text[i] && sysfs_streq(buf, oxp_gamepad_mode_text[i])) {
+			ret = i;
+			break;
+		}
+	}
+	if (ret < 0)
+		return ret;
+
+	data[0] = ret;
+
+	ret = oxp_gen_2_property_out(OXP_FID_GEN2_TOGGLE_MODE, data, 3);
+	if (ret)
+		return ret;
+
+	drvdata.gamepad_mode = data[0];
+
+	return count;
+}
+
+static ssize_t gamepad_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", oxp_gamepad_mode_text[drvdata.gamepad_mode]);
+}
+static DEVICE_ATTR_RW(gamepad_mode);
+
+static ssize_t gamepad_mode_index_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	ssize_t count = 0;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(oxp_gamepad_mode_text); i++) {
+		if (!oxp_gamepad_mode_text[i] ||
+		    oxp_gamepad_mode_text[i][0] == '\0')
+			continue;
+
+		count += sysfs_emit_at(buf, count, "%s ", oxp_gamepad_mode_text[i]);
+	}
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(gamepad_mode_index);
+
+static struct attribute *oxp_cfg_attrs[] = {
+	&dev_attr_gamepad_mode.attr,
+	&dev_attr_gamepad_mode_index.attr,
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
@@ -733,7 +849,21 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 		dev_warn(drvdata.led_mc->led_cdev.dev,
 			 "Failed to query RGB initial state: %i\n", ret);
 
+	/* Below features are only implemented in gen 2 */
+	if (up != GEN2_USAGE_PAGE)
+		return 0;
+
 skip_rgb:
+	drvdata.gamepad_mode = OXP_GP_MODE_XINPUT;
+
+	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
+	mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
+
+	ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
+	if (ret)
+		return dev_err_probe(&hdev->dev, ret,
+				     "Failed to attach configuration attributes\n");
+
 	return 0;
 }
 
@@ -778,6 +908,7 @@ static int oxp_hid_probe(struct hid_device *hdev,
 static void oxp_hid_remove(struct hid_device *hdev)
 {
 	cancel_delayed_work(&drvdata.oxp_rgb_queue);
+	cancel_delayed_work(&drvdata.oxp_mcu_init);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }
-- 
2.53.0

