Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8038D6A4
	for <linux-input@vger.kernel.org>; Tue, 26 May 2026 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815373; cv=none; b=VWLhxUPU2ayMFZWwfo3xZ9oBBKeaYpRu/gTXgdA7zgD8FgIryAOtENSrKsAPdJ3XLeI6BTuLSvy4ptY+uDjcgWg75fFWP1mVuZXAeSSxgmxcBhVyyEyfivLedIaCSCh4wwDI57FusbuW2pVyN2CU1wqunEVeRpZm0tnssqCtils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815373; c=relaxed/simple;
	bh=VzJHzFzg/1E60g4KLQswhGSbY+hcwu7QxBloRiNs6F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lZ/T7f/faSVwkpdls/7THNX2jWEhFUaRQtoC50OfAad7+5WA1xwAMPXFYAbT0Pjqjz0qdEkOwboMJCo6BUtjEvj18mWWAbsxcDSKtW0ltn6+fHUT3LNPolRWE+abjt0MWQjlunT81yZ+GewsReDV4NkzOP466POJbFiu624OTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hectorzelaya.dev; spf=none smtp.mailfrom=hectorzelaya.dev; dkim=pass (2048-bit key) header.d=hectorzelaya.dev header.i=@hectorzelaya.dev header.b=LDEEE4vx; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hectorzelaya.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hectorzelaya.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hectorzelaya.dev header.i=@hectorzelaya.dev header.b="LDEEE4vx"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bd5c773ef3so100255457b3.1
        for <linux-input@vger.kernel.org>; Tue, 26 May 2026 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hectorzelaya.dev; s=google; t=1779815369; x=1780420169; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+u0T7GXJrDM0Fqjd6+HyunZNurtk9AZexLWmxHsqJUc=;
        b=LDEEE4vxLK1KajiPC8GdDLq/mzJ1GCRGVKaWux1msOdGKp8wRpPqj/CQeChxvaqGGp
         StEtK9HNLSOc4YRaHgeqm0Yikb96Lr2s4SVcMXnV0aeueP/2CJbu5GoDZgVxiVkJfm2+
         J1Zm+54Q81GlWMU6o6+mvpAIItqB0HUKhuR7zHSS5PBe747daltj3Q3qCD84bLWOSA+s
         +ZXORPYaeXn6Mhvqk71uAYXmC+PTfN27ejA+lIczrKmRPFX3Hgkv58AaooubmVjDL/FE
         Y8qDp3pmPKwr005zxxh4mZTini7gBjEEkW880vbZK6VgMgRTVdczSmv12u1Mxct9kuip
         IxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815369; x=1780420169;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u0T7GXJrDM0Fqjd6+HyunZNurtk9AZexLWmxHsqJUc=;
        b=Apc7IjIqZSpgn8fs/JR1J4065TDq3a7QacfB85WsG/wvX6lp2O3IMr7Lpl+PTpo9ym
         EavX/2XwBSRUc4ErSbMoMTqZf2K/d13pMfdBOmCZpTNAQi2ftyMDEsKx9RizKY9z6fET
         0NnW6mqfKdQLRjxaGK/D1eLxoAXdYve4/Aklx/g3ZkNuy7ZiQWHA8WVWpDaumt3aLFPY
         08whaIahHif324geND4n9ZlB3ipE3lGj0M9xQdi9K34Ku/AvzwjR+JSuI5mZ31H6ChSB
         I0jtqygMd+E+kUwTkoesYr0ogbcA81efTBifowxwJp5khMgLUKQO9DBj83F6PuRzgidV
         hNNA==
X-Gm-Message-State: AOJu0YyBI+B7B7/rl6XuyLR8Tw/JG3oTOGvJ0myuV+bcjS7uyRYZix0p
	64TePAj4SPj+FTafpSV7vB4FsYCtM8bi1pAkRzbkdEQvZA74IZHOBQamTEjCK8rPFX13
X-Gm-Gg: Acq92OE3+QOhOWFT64EWexKDPwDeKf+hNfV3aRMbGp0b7xeqAmD5uKG966MTyvnB7sB
	YFBHBT1BnibptX+s6FQBC6vKE+BJovcXbOd6uQEireA4Biynim3y2hMtg0EpZO5715BfO6tRyi1
	s6t7GcQScQqb4G/naOcaBMAXsH4eARaQUEXuA4gS9pN3sNsVcPyEs+bmYH+n+8jRwsDL94uQnDw
	bDsEfy/IBbNgBuVM9lcs196DFVt1DbkrNbMQPxWEK9IByBSCmkcgCr9J+Sb3MPWSd8Sb87FLii+
	py531UnWlGptn0N+qvtiDHLGToIHFj0DGqAqQGHTvBnoNWlri0QIfhiOPBjkkqxesxjc4/yhvOX
	zpv6qGXp6MwD7Jp/kAaCpEboTL2AYSyCU3vqj1lHYqKHKIwuLn7eiwu73CnWC7h7/tp9MOJzyHK
	nr+HkyTPQcrs+QcyrcgD7+v0AmrS/x5I4maE45cAM=
X-Received: by 2002:a05:690c:d8f:b0:7ba:f3a8:7a87 with SMTP id 00721157ae682-7d3361bc2f6mr197969997b3.40.1779815369328;
        Tue, 26 May 2026 10:09:29 -0700 (PDT)
Received: from [127.0.0.2] ([190.150.67.183])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389e10546sm63777987b3.19.2026.05.26.10.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:09:28 -0700 (PDT)
From: Hector Zelaya <hector@hectorzelaya.dev>
Date: Tue, 26 May 2026 11:08:59 -0600
Subject: [PATCH] HID: nintendo: add support for HORI Wireless Switch Pad
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-hori-support-v1-1-1861c0abc2e0@hectorzelaya.dev>
X-B4-Tracking: v=1; b=H4sIAKrTFWoC/yXMQQ5AMBCF4avIrDWphkZcRSyooWOhzQwiEXdXJ
 G/zLd5/gSATCjTZBYwHCYU1ocgzcL5fZ1Q0JoPRxurKWOUDk5I9xsCb0vWQ5vpSjzWkS2Sc6Px
 ybfdb9mFBt70NuO8HymfvjnAAAAA=
X-Change-ID: 20260526-hori-support-08b08bca40d8
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 "Daniel J. Ogorchock" <djogorchock@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hector Zelaya <hector@hectorzelaya.dev>
X-Mailer: b4 0.15.2

Add support for the HORI Wireless Switch Pad (vendor 0x0f0d, product
0x00f6), a licensed third-party Nintendo Switch Pro Controller.

The controller reports controller type 0x06 (vs 0x03 for first-party
Pro Controllers) and has the following quirks:

 - SPI flash calibration data is incompatible; use default stick
   calibration values instead.
 - X and Y button bits are swapped compared to first-party controllers;
   add a dedicated button mapping table.
 - Rumble and IMU enable may timeout (no vibration motor in hardware);
   treat as non-fatal for licensed controllers.

Tested over Bluetooth on NixOS with kernel 7.0.5 and 7.0.10:
 - All 14 buttons map correctly
 - Player LED sets on connect
 - Sticks report correctly with default calibration
 - IMU/gyro data streams at 60Hz
 - D-pad reports on ABS_HAT0X/HAT0Y

Device information:
  Bluetooth name: Lic Pro Controller
  Bluetooth HID:  0005:0F0D:00F6

Assisted-by: Kiro:Auto [Amazon Kiro IDE]
Signed-off-by: Hector Zelaya <hector@hectorzelaya.dev>
---
 drivers/hid/hid-ids.h      |  3 ++
 drivers/hid/hid-nintendo.c | 78 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a1cfa436344a..3b0767cc47fd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -683,6 +683,9 @@
 #define USB_DEVICE_ID_HARMONIX_WII_RB3_KEYBOARD	        0x3330
 #define USB_DEVICE_ID_HARMONIX_WII_RB3_MPA_KEYBOARD_MODE	0x3338
 
+#define USB_VENDOR_ID_HORI			0x0f0d
+#define USB_DEVICE_ID_HORI_WIRELESS_SWITCH_PAD	0x00f6
+
 #define USB_VENDOR_ID_HP		0x03f0
 #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 29008c2cc530..b5e799ace249 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -316,6 +316,7 @@ enum joycon_ctlr_type {
 	JOYCON_CTLR_TYPE_JCL  = 0x01,
 	JOYCON_CTLR_TYPE_JCR  = 0x02,
 	JOYCON_CTLR_TYPE_PRO  = 0x03,
+	JOYCON_CTLR_TYPE_LIC_PRO = 0x06,
 	JOYCON_CTLR_TYPE_NESL = 0x09,
 	JOYCON_CTLR_TYPE_NESR = 0x0A,
 	JOYCON_CTLR_TYPE_SNES = 0x0B,
@@ -433,6 +434,25 @@ static const struct joycon_ctlr_button_mapping procon_button_mappings[] = {
 	{ /* sentinel */ },
 };
 
+/* Licensed Pro Controllers (e.g. HORI) swap X/Y bits in the report */
+static const struct joycon_ctlr_button_mapping lic_procon_button_mappings[] = {
+	{ BTN_EAST,	JC_BTN_A,	},
+	{ BTN_SOUTH,	JC_BTN_B,	},
+	{ BTN_NORTH,	JC_BTN_Y,	},
+	{ BTN_WEST,	JC_BTN_X,	},
+	{ BTN_TL,	JC_BTN_L,	},
+	{ BTN_TR,	JC_BTN_R,	},
+	{ BTN_TL2,	JC_BTN_ZL,	},
+	{ BTN_TR2,	JC_BTN_ZR,	},
+	{ BTN_SELECT,	JC_BTN_MINUS,	},
+	{ BTN_START,	JC_BTN_PLUS,	},
+	{ BTN_THUMBL,	JC_BTN_LSTICK,	},
+	{ BTN_THUMBR,	JC_BTN_RSTICK,	},
+	{ BTN_MODE,	JC_BTN_HOME,	},
+	{ BTN_Z,	JC_BTN_CAP,	},
+	{ /* sentinel */ },
+};
+
 static const struct joycon_ctlr_button_mapping nescon_button_mappings[] = {
 	{ BTN_SOUTH,	JC_BTN_A,	},
 	{ BTN_EAST,	JC_BTN_B,	},
@@ -695,7 +715,8 @@ static inline bool joycon_type_is_right_joycon(struct joycon_ctlr *ctlr)
 
 static inline bool joycon_type_is_procon(struct joycon_ctlr *ctlr)
 {
-	return ctlr->ctlr_type == JOYCON_CTLR_TYPE_PRO;
+	return ctlr->ctlr_type == JOYCON_CTLR_TYPE_PRO ||
+	       ctlr->ctlr_type == JOYCON_CTLR_TYPE_LIC_PRO;
 }
 
 static inline bool joycon_type_is_snescon(struct joycon_ctlr *ctlr)
@@ -1710,7 +1731,10 @@ static void joycon_parse_report(struct joycon_ctlr *ctlr,
 		joycon_report_left_stick(ctlr, rep);
 		joycon_report_right_stick(ctlr, rep);
 		joycon_report_dpad(ctlr, rep);
-		joycon_report_buttons(ctlr, rep, procon_button_mappings);
+		if (ctlr->ctlr_type == JOYCON_CTLR_TYPE_LIC_PRO)
+			joycon_report_buttons(ctlr, rep, lic_procon_button_mappings);
+		else
+			joycon_report_buttons(ctlr, rep, procon_button_mappings);
 	} else if (joycon_type_is_any_nescon(ctlr)) {
 		joycon_report_dpad(ctlr, rep);
 		joycon_report_buttons(ctlr, rep, nescon_button_mappings);
@@ -2156,7 +2180,10 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 		joycon_config_left_stick(ctlr->input);
 		joycon_config_right_stick(ctlr->input);
 		joycon_config_dpad(ctlr->input);
-		joycon_config_buttons(ctlr->input, procon_button_mappings);
+		if (ctlr->ctlr_type == JOYCON_CTLR_TYPE_LIC_PRO)
+			joycon_config_buttons(ctlr->input, lic_procon_button_mappings);
+		else
+			joycon_config_buttons(ctlr->input, procon_button_mappings);
 	} else if (joycon_type_is_any_nescon(ctlr)) {
 		joycon_config_dpad(ctlr->input);
 		joycon_config_buttons(ctlr->input, nescon_button_mappings);
@@ -2503,13 +2530,30 @@ static int joycon_init(struct hid_device *hdev)
 
 	if (joycon_has_joysticks(ctlr)) {
 		/* get controller calibration data, and parse it */
-		ret = joycon_request_calibration(ctlr);
-		if (ret) {
+		if (ctlr->ctlr_type == JOYCON_CTLR_TYPE_LIC_PRO) {
 			/*
-			 * We can function with default calibration, but it may be
-			 * inaccurate. Provide a warning, and continue on.
+			 * Licensed controllers may have incompatible SPI flash
+			 * layouts. Use default calibration values.
 			 */
-			hid_warn(hdev, "Analog stick positions may be inaccurate\n");
+			hid_info(hdev, "using default cal for licensed controller\n");
+			joycon_use_default_calibration(hdev,
+						       &ctlr->left_stick_cal_x,
+						       &ctlr->left_stick_cal_y,
+						       "left", 0);
+			joycon_use_default_calibration(hdev,
+						       &ctlr->right_stick_cal_x,
+						       &ctlr->right_stick_cal_y,
+						       "right", 0);
+		} else {
+			ret = joycon_request_calibration(ctlr);
+			if (ret) {
+				/*
+				 * We can function with default calibration, but
+				 * it may be inaccurate. Provide a warning, and
+				 * continue on.
+				 */
+				hid_warn(hdev, "Analog stick positions may be inaccurate\n");
+			}
 		}
 	}
 
@@ -2527,8 +2571,12 @@ static int joycon_init(struct hid_device *hdev)
 		/* Enable the IMU */
 		ret = joycon_enable_imu(ctlr);
 		if (ret) {
-			hid_err(hdev, "Failed to enable the IMU; ret=%d\n", ret);
-			goto out_unlock;
+			if (ctlr->ctlr_type == JOYCON_CTLR_TYPE_LIC_PRO) {
+				hid_dbg(hdev, "IMU enable failed for licensed controller, continuing\n");
+			} else {
+				hid_err(hdev, "Failed to enable the IMU; ret=%d\n", ret);
+				goto out_unlock;
+			}
 		}
 	}
 
@@ -2543,8 +2591,12 @@ static int joycon_init(struct hid_device *hdev)
 		/* Enable rumble */
 		ret = joycon_enable_rumble(ctlr);
 		if (ret) {
-			hid_err(hdev, "Failed to enable rumble; ret=%d\n", ret);
-			goto out_unlock;
+			if (ctlr->ctlr_type == JOYCON_CTLR_TYPE_LIC_PRO) {
+				hid_dbg(hdev, "rumble enable failed for licensed controller, continuing\n");
+			} else {
+				hid_err(hdev, "Failed to enable rumble; ret=%d\n", ret);
+				goto out_unlock;
+			}
 		}
 	}
 
@@ -2813,6 +2865,8 @@ static const struct hid_device_id nintendo_hid_devices[] = {
 			 USB_DEVICE_ID_NINTENDO_GENCON) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
 			 USB_DEVICE_ID_NINTENDO_N64CON) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_HORI,
+			 USB_DEVICE_ID_HORI_WIRELESS_SWITCH_PAD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, nintendo_hid_devices);

---
base-commit: e71bac24ec1f517f399a9eb471255b8f1c330b93
change-id: 20260526-hori-support-08b08bca40d8

Best regards,
--  
Hector Zelaya <hector@hectorzelaya.dev>

