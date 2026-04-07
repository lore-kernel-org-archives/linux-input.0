Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF734F255
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 04:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775535242; cv=none; b=qFskL8M1l7yh6jpJ7ccLzKJ90Eylwg0PtEsxWtwP6XwRi0Zo4/7TE1WZ0nL/fcvj0hPxX9LWe6DXI+7p1cmPaDQC+6CiC5dLsCNXGj178ePyLHyf5z5l5hUBfwb4Pii7Gcqqa/EeLT6XL0gt0sDQsxNDBarwbT7sZ9LzWKOPfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775535242; c=relaxed/simple;
	bh=pH1X0aQzXpB3SyOTJrmNhcXASyFLtui/zFbVD/xGlF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAsQgAlDvFCoAuk7LifClwHtuW5n1tZpiGozIswy5KVByUZaFidyF/QZtENwdAVRMo8Q0iNGyN/7eFND2HbchaelTdwju7cFPSpnoJn/JZN+NC8TB0CO397MOn1owSWyiWTnoRVHIuhWm0XjpjCC+Oliw1NTYfAuOJjDEvpUKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of/NfMa8; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of/NfMa8"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-128e4d0cc48so4795118c88.1
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 21:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775535239; x=1776140039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejgiW/r7pVVUy8vt9xK36NMd3PA7PnFF5ux4KM88uHM=;
        b=Of/NfMa8lSvWoS/flPyC6WLzjsNffRU/gbzsWCQxto3BO1PdeyqP0+mUu73QyeAaFM
         uao/gDLxEls/zgDEZBqdC70YAxwtdMkU+MKehADsn8MqyJTqzA7+LDOG/rTRzrzTHkbf
         NtqC6t2zZN/8JtoE3l2DuWt/q9hih5O0JPUYCDEHrTBjW7FI5BCQL8vtyPWimeq0x1Nn
         JwPCMK57yrBWIUUasvKCDkMvzwWJVBqGTY1+d1HQsJG/Lyjb2xEA07m71P9kzxtUdx8f
         W3NJWL/KBo4OMGILFbrI5ELEmDKf9TbgWBfTAxyWvphsBblcUiyc6jzYhukhqdJ7RM5/
         cagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775535239; x=1776140039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ejgiW/r7pVVUy8vt9xK36NMd3PA7PnFF5ux4KM88uHM=;
        b=gDuf+Zby+46Uha8HZ+tPLMLdaVPHEpxNjEB69KTc/TGifwe71HDmBtwD/NBE8CeZzw
         bzHuNrp35HI6OP6X4c7+6eD3u1G+Ucp9enpgOSLJtuZltQknlKL8z5JDWcZjfOWwc72i
         MLgKA8tUhTmr35sVgZNHYjgnljEOXB+jnJr7Q6OD/3dyvWzEaf2/XMKQe7qBhxCCpegR
         Tk0lGZptBVEkhachCpnQRH+XEeY2iOgIf4RjsZ/es3w5XPmOSnuKJ+nPwPvOkvE900H4
         nnSygfLGGo15cI/K26chdRlN4OL8We+Xb+zw9CWEQOXVl6rQ8VXSJu02eOxkemQ6Eeue
         N6HA==
X-Forwarded-Encrypted: i=1; AJvYcCU8HB4EcxL7C4TKGJou/67QwhzKUBiA3j9Iiedqo0kZXGJ5OOClnQN3Iu+V0qaB8ed0wO5oD/OjzEgS4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq/jQTdSIsDMeju+s5O2uACQnoSirg8onNRMGxQeFCtxjXAiQa
	iFX0VhL/waV87FJBmRzajNFRXXSvk0YBO0VpG9xzBCIhnzTuI6Y7x68j
X-Gm-Gg: AeBDievYdb2ViET8mtqBM0UDZGTM357J6gafM7knS0qXlOBEJWXOUKfHVfXXGjZbCkP
	0Fvk7/g7wN3y/Ttk1+46qqvDDgFmSHez1PN+iPnsMrqkw+LbZv7ABpqzD3l8OiPUit/wdMAiA6t
	CXWvfBXgPHtPY04qwHvoAv7kUP4WHaeBvOH4WDWSNMZKPOlZB3sHf7OJqH7V0EkAY6mhF3+tk6W
	OZniXqiLZzWdt6o8LIhnDZUOShwsdWDxaO2FEZ+kCndmIh7Y+fw3oMPFZFFQit41QP6wjVqaOgS
	M8rUXg3xWFQ+3lERiNNjmqdtEGmvauUkPpEjpQrovVwYdJEtCh6a1o15OYWuk0/pzPH3BCmUL5o
	Sw4PgxLCTYcmThpiBbxDz1gyfMOSscVKqL7eLzY/ThCLuKBj5O7jlQNMVmST/bYbRa6ee7vM5qt
	rjJlq4tbPGgQYKjVDLeXoet36A6uOIwu4u2vTKC9bCjNs0bKzumYc8z+btVyQ8bWwp9tQyHHEyu
	p3X
X-Received: by 2002:a05:7022:e09:b0:11a:342e:8a98 with SMTP id a92af1059eb24-12bfb63267fmr7475760c88.0.1775535239212;
        Mon, 06 Apr 2026 21:13:59 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm18523808c88.0.2026.04.06.21.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:13:58 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Lambert Fan <fanzhaoming@anopc.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] HID: hid-oxp: Add Second Generation Gamepad Mode Switch
Date: Tue,  7 Apr 2026 04:13:52 +0000
Message-ID: <20260407041354.2283201-4-derekjohn.clark@gmail.com>
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

Adds "gamepad_mode" attribute to second generation OneXPlayer
configuration HID devices. This attribute initiates a mode shift in the
device MCU that puts it into a state where all events are routed to an
hidraw interface instead of the xpad evdev interface. This allows for
debugging the hardware input mapping added in the next patch.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v2:
  - Rename to gamepad_mode & show relevant gamepad modes instead of
    using a debug enable/disable paradigm, to match other drivers.
---
 drivers/hid/hid-oxp.c | 130 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 25214356163e..c62952537d98 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -33,6 +33,7 @@
 enum oxp_function_index {
 	OXP_FID_GEN1_RGB_SET =		0x07,
 	OXP_FID_GEN1_RGB_REPLY =	0x0f,
+	OXP_FID_GEN2_TOGGLE_MODE =	0xb2,
 	OXP_FID_GEN2_STATUS_EVENT =	0xb8,
 };
 
@@ -41,11 +42,22 @@ static struct oxp_hid_cfg {
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
@@ -181,6 +193,32 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
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
+static DECLARE_DELAYED_WORK(oxp_mcu_init, oxp_mcu_init_fn);
+
 static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 				   struct hid_report *report, u8 *data,
 				   int size)
@@ -191,6 +229,14 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	if (data[0] != OXP_FID_GEN2_STATUS_EVENT)
 		return 0;
 
+	/* Sent ~6s after resume event, indicating the MCU has fully reset.
+	 * Re-apply our settings after this has been received.
+	 */
+	if (data[3] == OXP_EFFECT_MONO_TRUE) {
+		mod_delayed_work(system_wq, &oxp_mcu_init, msecs_to_jiffies(50));
+		return 0;
+	}
+
 	if (data[3] != OXP_GET_PROPERTY)
 		return 0;
 
@@ -288,6 +334,77 @@ static int oxp_gen_2_property_out(enum oxp_function_index fid, u8 *data,
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
@@ -733,7 +850,20 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 		dev_warn(drvdata.led_mc->led_cdev.dev,
 			 "Failed to query RGB initial state: %i\n", ret);
 
+	/* Below features are only implemented in gen 2 */
+	if (up != GEN2_USAGE_PAGE)
+		return 0;
+
 skip_rgb:
+	mod_delayed_work(system_wq, &oxp_mcu_init, msecs_to_jiffies(50));
+
+	drvdata.gamepad_mode = OXP_GP_MODE_XINPUT;
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

