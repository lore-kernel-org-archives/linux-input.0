Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A63FB060
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533297; cv=none; b=ZpeySaYfmZ3DaDMHUcKzzhrU3ZAtkv/j2rj4uxjHS31dYZTjRKcmjaNMG2aMWwqlHgHBexqMtyiBuEPdZDC7MfiDzevu9DBLJBWiWG329sZM7urAucxoxHl4o78nsIW+dSXSPkaVfouDKzBNRvKP+5lRLBTgwrebQpjX7Htc3Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533297; c=relaxed/simple;
	bh=BaV5O758oRar5RTUsmj9w+tUOf355SflKEzM/C3X95Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1Qf/OaNx/b3RvvGIX71fawYYLIjiDGEpdxdqa65SDcd0Ag6ggDaNlYwsKeFRrOagMOYtT4QyAUL3bXlCCkN1CPMVq9TBCt0mtKGUIXUhX8AYs6OYs5Eq88JiWPX0beXV3VTXGLcRPc/i7hPEUr4PoZVx7nsbTRV319IZbYfIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLhzHecY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLhzHecY"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso2395816a91.2
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533289; x=1782138089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T1d1Epw5U6/dAcfuifWImjl16XZ+3Fa2sK3u067DnI=;
        b=YLhzHecYVhRIWT0unLqVS2mkhudh/NwamoNCAWXfHCZ+JQa0CToJYpKcBtLE1tGA1D
         Smxwsjnh6ySETgnEXuAQmRVPSVdWJYvt3aOAs/ekls7yFyWvj0DoY9Kkk6aWQD4gTW3w
         vxzIbBrZ4yJL9o5LOCZ81FAI8EEsjsgsj/SVNY8JrSt8T9K8OGakd6iQtX6l0ZYrTNjo
         DryervYaLvs2PKHbSWt2oMOWiyVqZo9LifEkGe6o2JU7g5UiJ6sgLDyn1JSMrezhvCPL
         9GnFCc1OQtaMpAW1Rmvn0DFbkPVizrVPZ4OKSgHnrxbYOQ4CbVkmVtHE7q+37StAmf6/
         Tojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533289; x=1782138089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8T1d1Epw5U6/dAcfuifWImjl16XZ+3Fa2sK3u067DnI=;
        b=rdtHzBRoGwR0mS6euk1FQUPpYR50oidfTpro+zAFEIrNVogzUvhVuKcDLzRV709rd/
         KkBEH6T7V1An4lvoxaDQI/Kp5CzaCKISdUaguQCsUaAgMiVd3hGuuOHthW4zlo2C1prI
         oTFzwQ9UNAjJq1Aw1G8MOvvA+znd4AHGK7KzktVPDqFdH6M1IBpbJ25+l6wyDUExfho1
         6kJ89AKV4RorYrWvIpJmAooQnuROVlunP3O5KozkDW3KBUcE/zyzW4AIy1RabUsyYHEU
         7HpWKGBYPcTPAXo7/7Ui1IRZFX6JtrV+ok+6ukTTxkt2DonDFeGDGgPKtuInw/ljUrE3
         aTjA==
X-Forwarded-Encrypted: i=1; AFNElJ+EW1rcLEE9MdKmLZb4lKsFzexREwjk2/fk/PX6bcYSOcDSqlcl14kNUcPuNvGMv1gC0b44Zb0pXPjT/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvAX54pk9rEqMo6pJq//ZIgz7XsxmhnojE38VcgWTTdg94EZ+
	HlWm/Qyh+sTqmJ1ZGqG4OipLaEIw/lgMtRgCSNY4oujpJyYzr8oStejy
X-Gm-Gg: Acq92OHQQzHpjXuhGiNjhb5xWWNz4QZHuTNDSAFA6mf7bk89K89Ksg29koYIvHqPDpv
	c4WDW6lKTS/JTvDFf/Vox0bwscdxxnHDIaKwZbxCfflSJKV6a1+A0f/IAKcmb7ATluJxXjxDfMj
	fygGTA8tEkKyhnaf+pmsc4OZEVqU9kK/PvAM7RR7GWdEvlRxOErDTqhHGkQG24MqhkkCSQ4en3Z
	BLjFdTQGX6VTChE4Fo+BK3HDRBMNyTzmE6dijOJuSb3tiiWkf4Z9C+zjL7+izVHUy5zJ498qjFQ
	hnuJWO45yISiorUsISUuD4R/s+nrkrPdMJhMll+qqvVpM94PIpyZxqmxWXMuNzIXvk2Hcpgj9VS
	iG6XwLRul55W+Kl86D3FmBZzgHkSpesgYKKhhWoGrRN1hcMpgJS4Jv8+5Dd86as5FBvG3fJlpz8
	+DraEkI94OMIoyMf2SByvs
X-Received: by 2002:a17:90b:380f:b0:36a:5d1f:7ac with SMTP id 98e67ed59e1d1-37c2bc6ed5amr11702127a91.3.1781533288862;
        Mon, 15 Jun 2026 07:21:28 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7178233a91.2.2026.06.15.07.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:21:28 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] Input: cap11xx - remove unused register macros
Date: Mon, 15 Jun 2026 22:20:28 +0800
Message-ID: <20260615142103.352163-3-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615142103.352163-1-jerrysteve1101@gmail.com>
References: <20260615142103.352163-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused register address macros and unused definitions in
the cap11xx_reg_defaults array and cap11xx_volatile_reg.

This cleanup reduces code clutter and makes the driver easier to
maintain without affecting functionality.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 58 --------------------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 485d8ba97723..686174722204 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -20,53 +20,23 @@
 #define CAP11XX_REG_MAIN_CONTROL_GAIN_SHIFT	(6)
 #define CAP11XX_REG_MAIN_CONTROL_GAIN_MASK	(0xc0)
 #define CAP11XX_REG_MAIN_CONTROL_DLSEEP		BIT(4)
-#define CAP11XX_REG_GENERAL_STATUS	0x02
 #define CAP11XX_REG_SENSOR_INPUT	0x03
-#define CAP11XX_REG_NOISE_FLAG_STATUS	0x0a
-#define CAP11XX_REG_SENOR_DELTA(X)	(0x10 + (X))
 #define CAP11XX_REG_SENSITIVITY_CONTROL	0x1f
 #define CAP11XX_REG_SENSITIVITY_CONTROL_DELTA_SENSE_MASK	0x70
-#define CAP11XX_REG_CONFIG		0x20
-#define CAP11XX_REG_SENSOR_ENABLE	0x21
-#define CAP11XX_REG_SENSOR_CONFIG	0x22
-#define CAP11XX_REG_SENSOR_CONFIG2	0x23
-#define CAP11XX_REG_SAMPLING_CONFIG	0x24
-#define CAP11XX_REG_CALIBRATION		0x26
-#define CAP11XX_REG_INT_ENABLE		0x27
 #define CAP11XX_REG_REPEAT_RATE		0x28
 #define CAP11XX_REG_SIGNAL_GUARD_ENABLE	0x29
-#define CAP11XX_REG_MT_CONFIG		0x2a
-#define CAP11XX_REG_MT_PATTERN_CONFIG	0x2b
-#define CAP11XX_REG_MT_PATTERN		0x2d
-#define CAP11XX_REG_RECALIB_CONFIG	0x2f
 #define CAP11XX_REG_SENSOR_THRESH(X)	(0x30 + (X))
-#define CAP11XX_REG_SENSOR_NOISE_THRESH	0x38
-#define CAP11XX_REG_STANDBY_CHANNEL	0x40
-#define CAP11XX_REG_STANDBY_CONFIG	0x41
-#define CAP11XX_REG_STANDBY_SENSITIVITY	0x42
-#define CAP11XX_REG_STANDBY_THRESH	0x43
 #define CAP11XX_REG_CONFIG2		0x44
 #define CAP11XX_REG_CONFIG2_ALT_POL	BIT(6)
-#define CAP11XX_REG_SENSOR_BASE_CNT(X)	(0x50 + (X))
-#define CAP11XX_REG_LED_POLARITY	0x73
 #define CAP11XX_REG_LED_OUTPUT_CONTROL	0x74
 #define CAP11XX_REG_CALIB_SENSITIVITY_CONFIG	0x80
 #define CAP11XX_REG_CALIB_SENSITIVITY_CONFIG2	0x81
-
-#define CAP11XX_REG_LED_DUTY_CYCLE_1	0x90
-#define CAP11XX_REG_LED_DUTY_CYCLE_2	0x91
-#define CAP11XX_REG_LED_DUTY_CYCLE_3	0x92
 #define CAP11XX_REG_LED_DUTY_CYCLE_4	0x93
 
-#define CAP11XX_REG_LED_DUTY_MIN_MASK	(0x0f)
-#define CAP11XX_REG_LED_DUTY_MIN_MASK_SHIFT	(0)
 #define CAP11XX_REG_LED_DUTY_MAX_MASK	(0xf0)
 #define CAP11XX_REG_LED_DUTY_MAX_MASK_SHIFT	(4)
 #define CAP11XX_REG_LED_DUTY_MAX_VALUE	(15)
 
-#define CAP11XX_REG_SENSOR_CALIB	(0xb1 + (X))
-#define CAP11XX_REG_SENSOR_CALIB_LSB1	0xb9
-#define CAP11XX_REG_SENSOR_CALIB_LSB2	0xba
 #define CAP11XX_REG_PRODUCT_ID		0xfd
 #define CAP11XX_REG_MANUFACTURER_ID	0xfe
 #define CAP11XX_REG_REVISION		0xff
@@ -111,37 +81,15 @@ struct cap11xx_hw_model {
 
 static const struct reg_default cap11xx_reg_defaults[] = {
 	{ CAP11XX_REG_MAIN_CONTROL,		0x00 },
-	{ CAP11XX_REG_GENERAL_STATUS,		0x00 },
-	{ CAP11XX_REG_SENSOR_INPUT,		0x00 },
-	{ CAP11XX_REG_NOISE_FLAG_STATUS,	0x00 },
 	{ CAP11XX_REG_SENSITIVITY_CONTROL,	0x2f },
-	{ CAP11XX_REG_CONFIG,			0x20 },
-	{ CAP11XX_REG_SENSOR_ENABLE,		0x3f },
-	{ CAP11XX_REG_SENSOR_CONFIG,		0xa4 },
-	{ CAP11XX_REG_SENSOR_CONFIG2,		0x07 },
-	{ CAP11XX_REG_SAMPLING_CONFIG,		0x39 },
-	{ CAP11XX_REG_CALIBRATION,		0x00 },
-	{ CAP11XX_REG_INT_ENABLE,		0x3f },
 	{ CAP11XX_REG_REPEAT_RATE,		0x3f },
-	{ CAP11XX_REG_MT_CONFIG,		0x80 },
-	{ CAP11XX_REG_MT_PATTERN_CONFIG,	0x00 },
-	{ CAP11XX_REG_MT_PATTERN,		0x3f },
-	{ CAP11XX_REG_RECALIB_CONFIG,		0x8a },
 	{ CAP11XX_REG_SENSOR_THRESH(0),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(1),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(2),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(3),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(4),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(5),		0x40 },
-	{ CAP11XX_REG_SENSOR_NOISE_THRESH,	0x01 },
-	{ CAP11XX_REG_STANDBY_CHANNEL,		0x00 },
-	{ CAP11XX_REG_STANDBY_CONFIG,		0x39 },
-	{ CAP11XX_REG_STANDBY_SENSITIVITY,	0x02 },
-	{ CAP11XX_REG_STANDBY_THRESH,		0x40 },
 	{ CAP11XX_REG_CONFIG2,			0x40 },
-	{ CAP11XX_REG_LED_POLARITY,		0x00 },
-	{ CAP11XX_REG_SENSOR_CALIB_LSB1,	0x00 },
-	{ CAP11XX_REG_SENSOR_CALIB_LSB2,	0x00 },
 };
 
 static bool cap11xx_volatile_reg(struct device *dev, unsigned int reg)
@@ -149,12 +97,6 @@ static bool cap11xx_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case CAP11XX_REG_MAIN_CONTROL:
 	case CAP11XX_REG_SENSOR_INPUT:
-	case CAP11XX_REG_SENOR_DELTA(0):
-	case CAP11XX_REG_SENOR_DELTA(1):
-	case CAP11XX_REG_SENOR_DELTA(2):
-	case CAP11XX_REG_SENOR_DELTA(3):
-	case CAP11XX_REG_SENOR_DELTA(4):
-	case CAP11XX_REG_SENOR_DELTA(5):
 		return true;
 	}
 
-- 
2.54.0

