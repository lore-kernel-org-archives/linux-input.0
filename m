Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB9237757D
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897743; cv=none; b=hCY3dHUsgi8fBv5b7lb/Q35McXTLYIvVngmWXcpgfyjy56EI6m5EDC0dnsVGGxLD/Pr3NP7bPYGMfHUbRzFm4OAUqhIWkB9kpVoVICSw9aOeh8QpDGMgqmLeYOSqZw0M230GVeAYe82hZA9IH0Upg852E5MnkqseCd/6qvWvohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897743; c=relaxed/simple;
	bh=hPbkxEPsLQNL0Mx05iqP8Ul/D5nEMWOuY0GVzpSSKV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dh49toHmFaj1we1CqUVUsBcv1ILyBVf83k1fT/aN3ZFl/88bvNtYSup8A+mQ9Gk+Pejp5HfsbWbzaz2rPQvwAl99lIAwtEOp5YMRnFfkClvfgvzZrQUEU6MArltu6bfCNQcrxO25pnobEXs6cWoIq9OGIwTkyd0DDLNbtyjx6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hectorzelaya.dev; spf=none smtp.mailfrom=hectorzelaya.dev; dkim=pass (2048-bit key) header.d=hectorzelaya.dev header.i=@hectorzelaya.dev header.b=c5ZirpaD; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hectorzelaya.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hectorzelaya.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hectorzelaya.dev header.i=@hectorzelaya.dev header.b="c5ZirpaD"
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-5752b27958fso4048514e0c.1
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hectorzelaya.dev; s=google; t=1779897741; x=1780502541; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wgdYARPJ/fdedNZjsQGQkNvoyDqNmjFg1FjkoyjLQM=;
        b=c5ZirpaDQL5ioAHOwDsoD1H25PYjWdMyvJA+50ZJJkk4oEpQNTVBlzvGuEzq8zvsR0
         LhX2Ks4AsP+Fpeyh7k1yOwtJFeSNkGpqDe7J00TKqblg/IRyZMWwbrhNY2n4RvSKhp8d
         msP1RvsrSXndPwrRodsbg7VhYudxerYgViz2P/Dm2QyYLP+K3W7+99+cXjZG2XFkDCEk
         7OFMHjzf9N9d8mwjEQiX44cUi0XVZLH4vE+lmWKyFnRA6JQF073UxGQsZKVvgom5dgtz
         f4RyD0bxSxlC38X/f8HmYXJIuSZSRog3v5fo0rl5+2UHj/tF+0uyRQvv6MnBlUAvY28a
         9gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897741; x=1780502541;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wgdYARPJ/fdedNZjsQGQkNvoyDqNmjFg1FjkoyjLQM=;
        b=Ahu7OM7Z6W0KMjfAHgq8o2KJZ22Ny11FsQMg4W4YjJwMt2coV9z9BraixCTKwwM/Az
         VdISw3aStEm+M9ME1i32wj9Ux95FD8xOPpPyXEVL3pe3bJrInJEtskhYv7SdBw6JqV+6
         R3TOrawC5pf1Eip3n57dEcZVn0VMPzXefTfepaeyW7fW3bLS23kP+w3+lqx1+hNSl3PY
         yxyL6GyS7SGJft+dqLkARMKq6a314x7pBtcE1KvlArnjNuc4kxWUeP5r0DWHz0RFrITW
         weAaZHcniR7y3KsVL67H6iW+T/poZ+vTbsS71IXGV9hhlW9vqhVZxfmNEqZ9LknCvXY9
         9DIw==
X-Gm-Message-State: AOJu0YydPtrvDUSDmzT94X1DVzx7oqgD+KIjudYUjA27u7+Sd3Pb0pjT
	ofmeMM5wj+SRyFCT5YSF4yMaQHYgVaPxN+qePsVLaKI5dXWs4iJa+S5U+O3ZO7jdaXne
X-Gm-Gg: Acq92OGYciaq+yso1jPmLUMfo+jvMoey7jG/d+GAbrNbIviL0JUaHCZg1qk88vVMqTX
	1GEl7w8YNKOb+RxdWa1EETScPMIPFQHc85V/b2BWvP5xsy9Ki16m+PKuWrEF4qUN5ERgK7aXw43
	cG+2gzka9HDghdtijl8eYPKBCDJAyB813nhBMaUc8Ta663o1RFv6hsAkBc2yUkigRVLCykGLkaj
	kAKP/8XZ2nN+B1efgtO4nYdARnS2ihEPcT8rMjIRGFBzUtUVjSpeOXa0Sj0IQbo1i5jMa1cKSWb
	sq+1Q/6SRCnRk+5UeaPthJlcQK1ej9FMK+gSOR6J1os/OAUBfzIwq4PJp/qmw/4XzceaQV0ofa5
	3pW2L5VS2h0MNoFO9UEMZpsWSrggdlUQyyVKWKRLu/q+3O8YuNv7+wPrZ99BQL5B6QxIjA/BPEd
	98swz6hn40UEIt42D2qMs/PbH587ywj8r57eW2QPXeBC7Ul4PcBg==
X-Received: by 2002:a05:6122:2407:b0:575:e9eb:d879 with SMTP id 71dfb90a1353d-58659010a93mr11862865e0c.0.1779897739402;
        Wed, 27 May 2026 09:02:19 -0700 (PDT)
Received: from [127.0.0.2] ([190.150.67.183])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96196396953sm12635348241.1.2026.05.27.09.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:02:18 -0700 (PDT)
From: Hector Zelaya <hector@hectorzelaya.dev>
Date: Wed, 27 May 2026 10:01:32 -0600
Subject: [PATCH v2] HID: nintendo: add support for HORI Wireless Switch Pad
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-hori-support-v2-1-195c2f832112@hectorzelaya.dev>
X-B4-Tracking: v=1; b=H4sIAFsVF2oC/3WNQQrCMBBFr1JmbSQNGoor7yFdpMloRqQpkzZYS
 +5uUtcyf/Pg/zcbRGTCCJdmA8ZEkcJYQB0asN6MDxTkCoOSSsuz0sIHJhGXaQo8C9kNJdacpOu
 gTCbGO7133a3/cVyGJ9q5OmrDU5wDr/u/1NbeH3VqRblOt1aawSqUV180gT/4Mqs5OkzQ55y/o
 /RMgcEAAAA=
X-Change-ID: 20260526-hori-support-08b08bca40d8
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 "Daniel J. Ogorchock" <djogorchock@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hector Zelaya <hector@hectorzelaya.dev>, 
 Joshua Peisach <jpeisach@ubuntu.com>
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
Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
---
Changes in v2:
- Clear ret = 0 after non-fatal IMU/rumble timeouts to prevent
  unintentional probe failure.
- Link to v1: https://patch.msgid.link/20260526-hori-support-v1-1-1861c0abc2e0@hectorzelaya.dev

To: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
To: "Daniel J. Ogorchock" <djogorchock@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/hid/hid-ids.h      |  3 ++
 drivers/hid/hid-nintendo.c | 80 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 71 insertions(+), 12 deletions(-)

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
index 29008c2cc530..2d37ddeffdb6 100644
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
 
@@ -2527,8 +2571,13 @@ static int joycon_init(struct hid_device *hdev)
 		/* Enable the IMU */
 		ret = joycon_enable_imu(ctlr);
 		if (ret) {
-			hid_err(hdev, "Failed to enable the IMU; ret=%d\n", ret);
-			goto out_unlock;
+			if (ctlr->ctlr_type == JOYCON_CTLR_TYPE_LIC_PRO) {
+				hid_dbg(hdev, "IMU enable failed for licensed controller, continuing\n");
+				ret = 0;
+			} else {
+				hid_err(hdev, "Failed to enable the IMU; ret=%d\n", ret);
+				goto out_unlock;
+			}
 		}
 	}
 
@@ -2543,8 +2592,13 @@ static int joycon_init(struct hid_device *hdev)
 		/* Enable rumble */
 		ret = joycon_enable_rumble(ctlr);
 		if (ret) {
-			hid_err(hdev, "Failed to enable rumble; ret=%d\n", ret);
-			goto out_unlock;
+			if (ctlr->ctlr_type == JOYCON_CTLR_TYPE_LIC_PRO) {
+				hid_dbg(hdev, "rumble enable failed for licensed controller, continuing\n");
+				ret = 0;
+			} else {
+				hid_err(hdev, "Failed to enable rumble; ret=%d\n", ret);
+				goto out_unlock;
+			}
 		}
 	}
 
@@ -2813,6 +2867,8 @@ static const struct hid_device_id nintendo_hid_devices[] = {
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

