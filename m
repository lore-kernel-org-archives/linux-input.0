Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E09472795
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708622; cv=none; b=sx4f7ZZgSEJJB+esmQiK5emty3vov8qH5qEBFPRDoq3qoJ3Svh6X8ERg0xsLatqN1qImpzRIYDREjKww7RDcuK1FMQ6AJCxYIQkPDfWhDkNZVC/i2Fjph65OyjoD2DCBqc96eHelkl5dHr6wTfNMGXlaBOAs70stoz9mSmMxb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708622; c=relaxed/simple;
	bh=DqRv+I+XSRqQYw0ltR/7lFfcN7xYQWl56UPQ/s6rQ9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPmPOUEeME4sV7xIZO9zZRwwkjQ87lMhtPpVrjdZeoNxv2jKPCyvDtVkZ7z8+Rdg2xSJtjj98y4mUledwMZy7Bp4AE7MzD7Acn8ZUD8SxMCz5RFKBJH+Svj+Y76P4OFbVkyXUNPSEOnbukLoUcv5nJIobsW/XTTHGGtsJa29teA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwx0Ewz2; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwx0Ewz2"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66067da0638so3214349d50.0
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708620; x=1782313420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ImxLXi6c5I7Yj52h3xJyNttJlQp/SiANwB9lru/2M8=;
        b=Kwx0Ewz2F4DppHqgtTOMpOE9peBMW3GkyB3diKzeVWv413+STLWg4iGjxJSLbf9OC2
         ll6TSI0QGCpTbwNVmYf3aykDbV2Q97J3jYhp8S4aen8zLJnN3WyJB/Ae73yKQhtlTCK4
         vG7GliDSxa+3LIqshdazBBrAG3Kc6cM6rCEeE34bGrU0aoAjjPFsc0LY31J3bCEOE73/
         Jk7aL7mhemeORhFQw3DF2UVsqYjBz+LHNqosCqAqIQVqf17hgRnAkwVdd5ypIhRlwFFm
         q3feS7F3az1D2JDLbRdUkwi5qCOhMqoDQKHusYEZI4nWnheZN4+1CrfYYmDHw003f6jO
         oj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708620; x=1782313420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ImxLXi6c5I7Yj52h3xJyNttJlQp/SiANwB9lru/2M8=;
        b=AV1lqR347okMYZHhT+mt3TzVRRd2NR21ex0kotYhoan0DGfdxwHr/4x1OigIDHxxLu
         HPl1OpoAVGMrRzFOAjW1ca2/VAmYNdk4xa+IGcQmJYmG6W9DAzwYi+kArA+6H+qzwBAv
         D1ujnnJy14yQe2ST7jyrXRhm24UNFNd87cmUhtfIATfx67i7xiOYeYxAb7+m9P2YNtrG
         EyKEmLxGQx5AKJvkIL7h29V1XRCY0UNZawP++TzVwmQCzVZLBZ30O+H0QL/uOyEoFWBX
         PN2ulvbVKx9eqSIPB42HPpYb+0SEELzXjkw9R0UPkRKFefj5kmOdhDRRtJAg/ZKctMTv
         cmxw==
X-Forwarded-Encrypted: i=1; AFNElJ9UdgP0eJf/ANYAz5t2uYAAhem4+bc04liMuMe9H2oQmgmBWs3VRbh9ypw6B4ZMbhLrOsKl53M+yZNHtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQVbOXnLJr/W5/eup1+MQUZU2ftwJ/a0jXFgvZL6nlMh6/XRd
	1wfhXu/A6GR5819YKeopIkxh1cnTNSHBtKdnZB2nBxm84QgI+FnFNgoD
X-Gm-Gg: AfdE7ck5ipn7HHkAe5JSG8gD28ZzuCGOw5uPFpmUMStQLsPoT2BidLrL0QeV1Q8oILn
	YDuG8rZ/rqSy5Xk/o5ksvbckLzqdeiubFOzoByn5xcq0WtKV6U4W3aGibKO1Zkw9Spjq6fe4AG2
	0IAFy3CIDYsp1HHJN/kzqvrsYA6/S8gO1tP+WS7mYiIxHFI17snp/uy8LBWhqlCXNimg0bjIsHl
	Jn8jUxUHskfFE7DSxj1fzkl/3K+oPQytiurrgnCWibs+ann3dWOdRtq4VEriB6PL4kvpSkBWlE2
	P50PN1oj6G2Vo0PIebYH26x7k8TeYItNSsyPuHjGjx/dTtWW0OHUtksMufutoTjEabPICdyBJ9M
	2kV7SfHtIFPYWYDgYWwWtysXYgeE/wMhyHSMi+LzMOMiUO76jB7wmidX2LZi58iUVaUA0fHCYsb
	dIAGuHY90kOw==
X-Received: by 2002:a53:acd1:0:20b0:65c:5fdb:e97e with SMTP id 956f58d0204a3-662cb8894camr3157630d50.11.1781708619561;
        Wed, 17 Jun 2026 08:03:39 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662b976e47csm4387677d50.20.2026.06.17.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:03:39 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/10] Input: cap11xx - remove unused register macros
Date: Wed, 17 Jun 2026 23:02:41 +0800
Message-ID: <20260617150318.753148-3-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617150318.753148-1-jerrysteve1101@gmail.com>
References: <20260617150318.753148-1-jerrysteve1101@gmail.com>
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
 drivers/input/keyboard/cap11xx.c | 51 --------------------------------
 1 file changed, 51 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 485d8ba97723..fae26f035186 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -20,53 +20,24 @@
 #define CAP11XX_REG_MAIN_CONTROL_GAIN_SHIFT	(6)
 #define CAP11XX_REG_MAIN_CONTROL_GAIN_MASK	(0xc0)
 #define CAP11XX_REG_MAIN_CONTROL_DLSEEP		BIT(4)
-#define CAP11XX_REG_GENERAL_STATUS	0x02
 #define CAP11XX_REG_SENSOR_INPUT	0x03
-#define CAP11XX_REG_NOISE_FLAG_STATUS	0x0a
 #define CAP11XX_REG_SENOR_DELTA(X)	(0x10 + (X))
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
@@ -111,37 +82,15 @@ struct cap11xx_hw_model {
 
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
-- 
2.54.0

