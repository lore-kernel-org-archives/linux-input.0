Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C947C110
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033930; cv=none; b=H+ms/G/yKmIeWu/v9EM1ZJ0TCyELM/MYPiIHI4rLCtMaxIfygdbk6NLUUIuTDAT3+wVmKzmqWzgFzCn+wF4hnKfZQf9zRgY/L8cTORm7Wa7U0BKxdxANTfeqv2ypXaucd8J6mBA3gTUKAM4k6ErGAVWIB84yXW7JKxNHkzq0pX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033930; c=relaxed/simple;
	bh=rqsVU2v75gkxGRrnA6Kd+sFAIvpgo1eLDpFSS5L1wHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJF7hd/pAkK8vBz2rzrfyGze4rN5IsL5Fp0s0imQ+UUfIF6jm3Ndcfpx6P7eXKmIv1F/XvXDGnOWJT2IhQlJ682yIf7u3nP70NI5dH1gyIOEA0Wb+mvhrIgOmCu5eh5bIzWx9SQ/ut/xuB1MwAd5n/AQ1EfuQEJmHfP/0oJzkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKtI1cK5; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKtI1cK5"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3965b08a327so31559a91.1
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790033928; x=1790638728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wrl+Ko54P3dzRH5UdtfwfMkqTLgyfcZTLYflkHj53O4=;
        b=SKtI1cK5r0ff+fOsTUvQCZk4Rf2B3C7N2A3aazDVSKgfVoOpysMecQI8gxKz265/2U
         07fxqKIWqVzfdoV3JX4UidhpLeru8yvk7U3N7kWNmcfKjSsL0q+gPHW9OYeWzQWd1Nod
         skOeiLmL/6adoEoD322Xj0N07QHW5X1VRMauEXK4LYP64rMpEPxKatGY5/ZFyg+xNh/i
         VKvPRlP/K+L3yMZxI0uMV6iL/KC8lUcssFPwSOec5p5e5bY2mKLHtYuPJ8nvedDgXlJp
         dyUyluRPB7dh4GkmJC97RhILyijEqFWUV+GXEu7qyE80WywLAMzrI6W9d605yM/1Pnf2
         UHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790033928; x=1790638728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wrl+Ko54P3dzRH5UdtfwfMkqTLgyfcZTLYflkHj53O4=;
        b=v1NUbRQysVSQkuZuoiyk2P80EbQ6c3j1fxBknLxlPZBnerfm9sX01N7XL5mSTzAFKQ
         rzsC6xVBN+bJ4TZ4b7WTAJEfLoN0nspi2kjAZGaWqhT5V5cg+kFLz12Pavl2fkBpTmFy
         FBbOCEUc7TDByktgx+0y+xyg2ivfmh0OJ+1zSZOidszwY7x2X7n/kNRacoHLjwLUhSmm
         11pl/ZWQE12F92zvVv29bb19fWCXO4Gme4/6zwi3d3Nc8m6xS8h7flVZvHB1STx4HBBQ
         bzLkXozujopMU4DCckCZaGoBmVHuIrNhurl4ey8AQb6zccMfesA26uQxh6603D/jy4f4
         hGbw==
X-Gm-Message-State: AFuF++k35oTmPJ9kEjdcybAd9onHXWJ1Y89Q/Dtd3zkIQSED8KcT3hG4
	QrUlvxtA/iCZhakSuM5vyOcQ4pKaqAGkQxsTOBMOUo1xX+EZFsvOfWpekN6kjmdUidJULOqB
X-Gm-Gg: AYBFou3BZRdEfSRyGdNkAGgeTSyNtdcr6hc+N9Tkg2CILKxUvBbGnh2efCB7gNhZHFo
	8p22ecd5iHkuGaF7QtC+7wY5CpBYUXIo9QdR62/GdcrRKLWfmpIaDK2IV8dPtxf5aZGfkF0Be8N
	bkzaJnNgviDTgnTl5DUaytEFboMdxkbdxOkpr6Kxo8vMHWg9L3fjh1DFzx5KORhIAIsQNsEucRB
	j0x7M3YJIkaOGchIBZjzOqWO+EoXChirVwsU81p4rM962lWtvlZcva5daR8J+Cc/6zhZT+M7S6E
	nxjrYA5xvjlZ/tsblG5RDCxwH+AEoupa82p85MXDBo6EB4YhPMA6dbkGMPE44i0WD3lzFGrjahl
	+RFu3iqs6KrBbOdEWddrP4PRrfEqSCpV9LwAW5fq2+AuYwaQJED8c8w4OCddbCJoYos34jmbunQ
	KnWvdcZbFGpcVG60JxQ93mpjQqLzbKXodimA1nSxRLeEUTmwKoikwMBWt2sWGVLMTBzezsB3W3s
	amaosWslZF0PQ==
X-Received: by 2002:a17:90a:1507:b0:3a0:238b:db4d with SMTP id 98e67ed59e1d1-3a0238bdf68mr10936600a91.5.1790033928004;
        Mon, 21 Sep 2026 16:38:48 -0700 (PDT)
Received: from erdos ([71.89.197.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674c321dsm1361490a91.14.2026.09.21.16.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 16:38:47 -0700 (PDT)
From: Aoto <aoto.tokizawa@gmail.com>
To: linux-input@vger.kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: Aoto Tokizawa <aoto.tokizawa@gmail.com>
Subject: [PATCH] HID: asus: support the Zenbook A14 (UX3407QA) keyboard
Date: Mon, 21 Sep 2026 16:37:29 -0700
Message-ID: <20260921233729.1286-1-aoto.tokizawa@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aoto Tokizawa <aoto.tokizawa@gmail.com>

Signed-off-by: Aoto Tokizawa <aoto.tokizawa@gmail.com>
---
 drivers/hid/hid-asus.c | 48 ++++++++++++++++++++++++++++++++++++------
 drivers/hid/hid-ids.h  |  1 +
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index c38a2b3b33d9..5e068d0668fe 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -100,6 +100,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
 #define QUIRK_HID_FN_LOCK		BIT(14)
 #define QUIRK_FILTER_CAMERA_COMPANION	BIT(15)
+#define QUIRK_NO_KBD_INIT	BIT(16)
+#define QUIRK_A14_KEYBOARD	BIT(17)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -169,6 +171,7 @@ struct asus_drvdata {
 	bool battery_in_query;
 	unsigned long battery_next_query;
 	struct asus_hid_listener listener;
+	struct led_classdev kbd_backlight;
 	bool fn_lock;
 };
 
@@ -939,6 +942,16 @@ static bool asus_has_report_id(struct hid_device *hdev, u16 report_id)
 	return false;
 }
 
+static int asus_kbd_backlight_set_blocking(struct led_classdev *led,
+		enum led_brightness brightness)
+{
+	struct asus_drvdata *drvdata =
+		container_of(led, struct asus_drvdata, kbd_backlight);
+
+	asus_kbd_set_brightness(drvdata->hdev, brightness);
+	return 0;
+}
+
 static int asus_kbd_register_leds(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -969,6 +982,24 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			le16_to_cpu(udev->descriptor.idProduct));
 	}
 
+	if ((drvdata->quirks & QUIRK_A14_KEYBOARD)) {
+		const u8 buf[FEATURE_KBD_REPORT_SIZE] = {
+			FEATURE_KBD_REPORT_ID, 0xd0, 0x8f, 0x01
+		};
+
+		ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
+		if (ret < 0)
+			return ret;
+
+		drvdata->kbd_backlight.name = "asus::kbd_backlight";
+		drvdata->kbd_backlight.max_brightness = 3;
+		drvdata->kbd_backlight.brightness_set_blocking =
+			asus_kbd_backlight_set_blocking;
+
+		return devm_led_classdev_register(&hdev->dev,
+						  &drvdata->kbd_backlight);
+	}
+
 	drvdata->listener.brightness_set = asus_kbd_backlight_set;
 	ret = asus_hid_register_listener(&drvdata->listener);
 	if (ret < 0) {
@@ -1493,12 +1524,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
-		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
-			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
-			if (ret < 0)
-				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
-					 asus_report_id_init[r], ret);
+	if (!(drvdata->quirks & QUIRK_NO_KBD_INIT)) {
+		for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
+			if (asus_has_report_id(hdev, asus_report_id_init[r])) {
+				ret = asus_kbd_init(hdev, asus_report_id_init[r]);
+				if (ret < 0)
+					hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
+						 asus_report_id_init[r], ret);
+			}
 		}
 	}
 
@@ -1670,6 +1703,9 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 static const struct hid_device_id asus_devices[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD), I2C_KEYBOARD_QUIRKS},
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_A14_KEYBOARD),
+	  QUIRK_NO_KBD_INIT | QUIRK_USE_KBD_BACKLIGHT | QUIRK_A14_KEYBOARD },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD),
 	  I2C_KEYBOARD_QUIRKS | QUIRK_FILTER_CAMERA_COMPANION },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b3aca5aa9176..a665863b11b8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -219,6 +219,7 @@
 #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
 #define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD	0x183d
 #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
+#define USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_A14_KEYBOARD	0x0220
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD	0x4b42
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
-- 
2.55.0

