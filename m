Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217480;
	b=DbnKVOdrFqx0Nb2Sv2Wt8lgbqHESkmc2XiDEPvyhyCbXKSx0DYXMYaSiNzH/jXzdF1Oz
	 WDxJCJQbMRyKCZHrOhv4os5UFxoWR5zH06s2+q01pCI9AolwXrOFeg3b8hR6xs8ICKhzA
	 XUBfIJfWJgDqbH2eZKPfQ1fpc/FJ6wWOYR5c3TCpyGOs8nngD4jcark9MVKsfj47eDMkb
	 +dd6scAMPxgKeEFe4CsUnLze72pTZF2fOFEYletlcWJ8ps1MsNxCSnKB2kq6jDhlD7wqi
	 5KEGdjhIto/dUY+6dTB6EyXMahiIMSA4xQZYVB5F0tHiqNNB+H37uVyP7RUQi4Bpt5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Q+2ohc4Lxz21adQFaiVr9N7OyfmDicOr8rZAg8df0IE=;
	b=v2TRcm96HoJUa5wqo8nm9Wq6c/2QKEvRF6TpugjwJhTD+oJ/NelcxtvOaD/sWRNlmjrr
	 zrSh+lNt2aX9Y1MPCtey9C3SuVEeQJChqqgzBwkg+GVLcb76jGGq0pyfrSVc5LZwnbWKP
	 OfrycbKXRWI6+8OQ6bX6WlW/F+AfJ4/BN66LCkwZk8WkBtt2a6BTzTyRHr/kvrMzBkWMx
	 KaGcxRNPGLUlSRBRMDrSaUprZI3xHVLGcaOpKxDLXuYKLTK6Tfw6aPa3uTGi2aBZJe/Iu
	 xAQaqnAqHqh6EV8ft32P2PMyiPYTQ/uzGjW/ClMtzRlxtF5864dCCSGFurZ5qYCx7kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ym+iTu5m;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F7606A32A
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 09:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 626F7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ym+iTu5m
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso88361466b.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 01:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217479; x=1794822279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+2ohc4Lxz21adQFaiVr9N7OyfmDicOr8rZAg8df0IE=;
        b=Ym+iTu5mmYRwDT/GOtraohnsAgMgwXcVaYecAAg3pHKKKChHeVZFKArXxm88IXIN8q
         LXS0Riofu6QezvXanMrmJgytVbuSsEo9aBE32K9QjaVpeQL4u8yI+CnjXcvAKWPwi9il
         SvEDZBfRH3MDrkTf48Bf2nggsg3gP/y/oPhJEGETCbkfaJsnQ3IfrsQFXrWpER+iGElY
         3oeNXb4CXseA1mz1ArTCsF80zGHXtuXLcfjCOQkdQ0GHdw+neJmpy4EVY7twTyunb4n4
         2vbojrtoWfuiXuq/J9cFkTn6qqGqKkbnceGjO/N/7Dteu/KhLrqBu/O/yH5Kct7IC1z1
         Loyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217479; x=1794822279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+2ohc4Lxz21adQFaiVr9N7OyfmDicOr8rZAg8df0IE=;
        b=Di29xrkN58siVn46IpQ1vfV86n5BsNMV/SGUBF4BCRRHG6ClMPomFvnlGZobCw6qBA
         tVBARFxdCkSd/cAag6tFHK9ur8+16Z1Fr6NqigzCxqJGEfJNPW/ZowlnqfcxqEGRk5ma
         pkgtCudlJ6uHrGdWjSddpfu80PXUV/WsBpSG+etd7Ps8TYRlf4Ovx6/xVCQtTvxEktwh
         VbWGtghX/Sb0lhcwlbShjftxIsMUJ+ZCtcDwpMR0DffXXf1V2A5cH1kHTqLaSbX59uW3
         zoGM2od0wsS+pRyfsbRhlECEcfDH7Bt9AWx7MCNDLc34b8sMm67UFhK2leLUYa/vlU+h
         bsCQ==
X-Forwarded-Encrypted: i=1; AL+hErFKeNlFLgcH+uJhXzajc2IW17WAGt/7tVt44xTVuCaLS3N6AY6MprZNBOa2vAdrEsiP8NB9R9QEm9r+1w==@vger.kernel.org
X-Gm-Message-State: APuU4Z85oyHWJEIJzsa6zmsBOdK2mSAidxbqOcWvUHi8he3k15NxusXh
	BhzKnRUI4WC0HpxKUZI8lalTSULBtgmR14pQbelmp1/ibU899kpZrAP2
X-Gm-Gg: AYBFou2qpKydoRX2g9OSaNVelA5RrfNPIFUoKHELLV8bU1+TfzXf8k22hp94biZzRC4
	idhczugikSgu2w/xv5NEY7XmHYY/TJDHOUoHP82F1ZXhEAIUINVBeDSZH+LkpeKkdmPriKDsLh0
	vUbQCEtLcGgZ2869IKuD/5TnOQ9o61Vx6Qkn/tYLJps7Q5vcQdo4/0DXOylXzXC1uuQ78J/Qc21
	I3MAXgOfRQzgMFF6BpdooGE8TdT5aHgVxZgJq+jG8Z5IpGjGCbc71f4MRe977Xp+JwFoVJQEXsB
	CmPck6BYdfs3BNawqhVND1tHQMmSWwd18GmREjCcTHvBle8oj0XAkfRIDPIBqWzmPmNNjLq5zlm
	wyDdmzjm1BvRRer56Uq4hviPN1pZpusnht1COOoAowwhA8WdBDkspmgYYgVvXidQG8AoNF1NJea
	WK7FIgT8y6PR17KDirCKmQR8pGVVqsbSANTCe6u+MzjOe2fG3VNLwBNja9sc5cAPhIIufOXb68L
	XP1qEe+fMa0yuAgDlbwg5OOXLloYZ8KhQEC9ZIi86UuUcLTMTem52thQQWqKOxZLuJSOKgtF8X2
	1G1K1zevDp6YYNG3K6gK/y4AmYQ2IgEGRndgzqvzdcQSPeM3nUU0uEXd
X-Received: by 2002:a17:907:9490:b0:c4d:31ad:9de9 with SMTP id a640c23a62f3a-c4d6dd9c233mr316727566b.42.1794217478739;
        Mon, 09 Nov 2026 01:44:38 -0800 (PST)
Received: from torstein-desktop.internal ([2a01:799:3a1:9700:6e3a:d704:53e2:f00e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c4d6a4753aasm137786866b.45.2026.11.09.01.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:44:38 -0800 (PST)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] HID: lg-g15: add LCD contrast LED
Date: Mon,  9 Nov 2026 10:44:23 +0100
Message-ID: <20261109094426.1432465-2-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109094426.1432465-1-torsteine+linux@gmail.com>
References: <20261109094426.1432465-1-torsteine+linux@gmail.com>
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

Wire values ({2, 32, 129, value}) match libg15's setLCDContrast()
byte-for-byte.

Tested on Logitech G15v2.

Based on libg15.c.

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
Based-on-work-by: Philip Lawatsch <philip@lawatsch.at>
Based-on-work-by: Alex Ibrado <alex@ibrado.org>
Based-on-work-by: Anthony J. Mirabella <mirabeaj@gmail.com>
Based-on-work-by: Mike Lampard <mlampard@users.sourceforge.net>
Assisted-by: Claude:claude-sonnet-5
---
 drivers/hid/hid-lg-g15.c | 101 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index 02ef3e2094b4..50abe6c58b10 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -59,7 +59,16 @@ enum lg_g15_led_type {
 	LG_G15_MACRO_PRESET2,
 	LG_G15_MACRO_PRESET3,
 	LG_G15_MACRO_RECORD,
-	LG_G15_LED_MAX
+	LG_G15_LED_MAX,
+	/*
+	 * LCD contrast uses a different feature-report sub-format than the
+	 * brightness/macro fields above (see lg_g15_contrast_set()) and has
+	 * no hardware readback, so it lives outside [0, LG_G15_LED_MAX) to
+	 * avoid being swept into the G13/macro loops bounded by
+	 * LG_G15_LED_MAX. G15/G15 v2 only; registered explicitly.
+	 */
+	LG_G15_LCD_CONTRAST = LG_G15_LED_MAX,
+	LG_G15_LED_ARRAY_SIZE
 };
 
 struct g13_input_report {
@@ -89,9 +98,10 @@ struct lg_g15_data {
 	struct input_dev *input_js; /* Separate joystick device for G13. */
 	struct hid_device *hdev;
 	enum lg_g15_model model;
-	struct lg_g15_led leds[LG_G15_LED_MAX];
+	struct lg_g15_led leds[LG_G15_LED_ARRAY_SIZE];
 	bool game_mode_enabled;
 	bool backlight_disabled;	/* true == HW backlight toggled *OFF* */
+	bool lcd_contrast_set;		/* LCD contrast written at least once */
 };
 
 /********* G13 LED functions ***********/
@@ -365,6 +375,57 @@ static int lg_g15_led_set(struct led_classdev *led_cdev,
 	return ret;
 }
 
+/*
+ * LCD contrast, report 2 field 32: {2, 32, 129, value}, value in
+ * {18, 22, 26} for low/medium/high. Distinct sub-format from the
+ * brightness/macro fields (value sits in byte 3, not byte 2, and byte 2 is
+ * a fixed marker rather than the field selector) and has no GET_REPORT
+ * readback, so brightness_get just returns the last value we set.
+ */
+static int lg_g15_contrast_set(struct led_classdev *led_cdev,
+			       enum led_brightness brightness)
+{
+	struct lg_g15_led *g15_led =
+		container_of(led_cdev, struct lg_g15_led, cdev);
+	struct lg_g15_data *g15 = dev_get_drvdata(led_cdev->dev->parent);
+	static const u8 contrast_values[] = { 18, 22, 26 };
+	int ret;
+
+	if (led_cdev->flags & LED_UNREGISTERING)
+		return 0;
+
+	mutex_lock(&g15->mutex);
+
+	g15->transfer_buf[0] = LG_G15_FEATURE_REPORT;
+	g15->transfer_buf[1] = 32;
+	g15->transfer_buf[2] = 129;
+	g15->transfer_buf[3] = contrast_values[brightness];
+
+	ret = hid_hw_raw_request(g15->hdev, LG_G15_FEATURE_REPORT,
+				 g15->transfer_buf, 4,
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	if (ret == 4) {
+		g15_led->brightness = brightness;
+		g15->lcd_contrast_set = true;
+		ret = 0;
+	} else {
+		hid_err(g15->hdev, "Error setting LCD contrast: %d\n", ret);
+		ret = (ret < 0) ? ret : -EIO;
+	}
+
+	mutex_unlock(&g15->mutex);
+
+	return ret;
+}
+
+static enum led_brightness lg_g15_contrast_get(struct led_classdev *led_cdev)
+{
+	struct lg_g15_led *g15_led =
+		container_of(led_cdev, struct lg_g15_led, cdev);
+
+	return g15_led->brightness;
+}
+
 static void lg_g15_leds_changed_work(struct work_struct *work)
 {
 	struct lg_g15_data *g15 = container_of(work, struct lg_g15_data, work);
@@ -1017,6 +1078,13 @@ static int lg_g15_register_led(struct lg_g15_data *g15, int i, const char *name)
 		break;
 	case LG_G15:
 	case LG_G15_V2:
+		if (i == LG_G15_LCD_CONTRAST) {
+			g15->leds[i].cdev.brightness_set_blocking = lg_g15_contrast_set;
+			g15->leds[i].cdev.brightness_get = lg_g15_contrast_get;
+			g15->leds[i].cdev.max_brightness = 2;
+			ret = devm_led_classdev_register(&g15->hdev->dev, &g15->leds[i].cdev);
+			break;
+		}
 		g15->leds[i].cdev.brightness_get = lg_g15_led_get;
 		fallthrough;
 	case LG_Z10:
@@ -1333,6 +1401,14 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			goto error_hw_stop;
 	}
 
+	/* The G11 shares the LG_G15 model but has no LCD */
+	if ((g15->model == LG_G15 && hdev->product != USB_DEVICE_ID_LOGITECH_G11) ||
+	    g15->model == LG_G15_V2) {
+		ret = lg_g15_register_led(g15, LG_G15_LCD_CONTRAST, "g15::lcd_contrast");
+		if (ret)
+			goto error_hw_stop;
+	}
+
 	return 0;
 
 error_hw_stop:
@@ -1389,12 +1465,33 @@ static void lg_g15_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+/*
+ * The LCD does not retain its contrast across a USB reset or power loss;
+ * re-apply the last value userspace set, if any.
+ */
+static int lg_g15_resume(struct hid_device *hdev)
+{
+	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
+	struct lg_g15_led *contrast;
+
+	if (!g15)
+		return 0;
+
+	contrast = &g15->leds[LG_G15_LCD_CONTRAST];
+	if (contrast->cdev.dev && g15->lcd_contrast_set)
+		lg_g15_contrast_set(&contrast->cdev, contrast->brightness);
+
+	return 0;
+}
+
 static struct hid_driver lg_g15_driver = {
 	.name			= "lg-g15",
 	.id_table		= lg_g15_devices,
 	.raw_event		= lg_g15_raw_event,
 	.probe			= lg_g15_probe,
 	.remove			= lg_g15_remove,
+	.resume			= lg_g15_resume,
+	.reset_resume		= lg_g15_resume,
 };
 module_hid_driver(lg_g15_driver);
 
-- 
2.53.0

