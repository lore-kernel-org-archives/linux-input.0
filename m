Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D153FB7E1
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533331; cv=none; b=Im3+QO1w7iO6Ps/S/yuHqFFdlG0a3MxAtibSKEcUhDAPVyn5MilL650LZHsjlltq2XlZLZjQPMbuKPi3OuT01zHwFzo0Q1Ux/FvXWQ+0pyDfsQGCuueCfagu9fRLcF8pMYpiCMpP+SP2Xd7ks3GFlLOsEzWpO1UwZK+iPV4hDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533331; c=relaxed/simple;
	bh=k4dHw+/Po3x9wsSDVnPMlPIamhpqhjNDNpXbagJiHMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVY4J+tmxVIsDfAFaVXCUDDmdWafE6+GapoxTrucgVa8NjE5OPect6wIbtImAePVSiWYfvQIKTF2oGlnqruKubC/pbhMv5r5vlTPouZdlOPq6Mt2vbnyqkaPFJE6Y1QuFq23BIgXgvxCFk64I12R22SrYALH/cAa/zsDN0hk/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMKN1nWD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMKN1nWD"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso2747128a91.1
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533327; x=1782138127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxVnZWCxxOews4BbfFbVhqTO+lFrEwCqaGSZwp09khE=;
        b=RMKN1nWDAQMzeH7UBwMDzNjfhvfBtH7HVjgtZgmHVKWi/iIzxxqGIx2gi98+FjbUWA
         ClPM4fhprspf79qKG8J6q1IiM9iFYhZBh/s3M0Uwy1a1IvwL5dvIjjDL0K637Gl+q8S1
         KUKvInkPCnIIli1O3vvNXZ4f9KDk0I8JdJnpHdQzD1oZte7/B23i9aA+r32mhEmOyLeS
         rX2b1piVBaM+fi7t+6WMQ1vHiV/fHgZBPa4W+7BGQGPSq62CUGashcsSOftTPlwObj4N
         C+U5gavVyCvjHFgPLOOWCGdJvx0EFe6gu9gbQP/9pNesM8/Z4ErW7LsqeCGkJXo9bLbJ
         hxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533327; x=1782138127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxVnZWCxxOews4BbfFbVhqTO+lFrEwCqaGSZwp09khE=;
        b=JNeshBtov6+ap0Lqt3dZqHSWkGCeEOBSrlvQdI3liZMMM0Zj3nLmD5v3y0LMpC/DsC
         c6Kqx113XNxkKwcUGvPu07Hca0H9xtvnXG/5ddIr4sVtVOANDDOXHDvRN6W9BxoXF2TI
         z/FpCribwQ6nHApcahzDR6zcEnaaS0G45Y/GwwuJdgLnLu+IIaecVFYbz7kp8K6hszjG
         uD5N3nI3Cg3lGA3tXD/3rmQ/kW6rPA9X9Y933kQjr2vbDb1H+EIeQYXLvHOY3VK9AaDv
         L1nslz9WfrfEy2Mq2YJ8GIV3nVYICztXKxvCubIPF5fpvAeQY+19ut8f3fGiZKGBrEE3
         XyaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bwNc+3uva5Q1uhvGn7YSOvPIBZeAL8HZzINF4sSR+ghPBlJeX5SeXm39PVYym8WC1wqSb+u1yDerB5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRWEPbq6U/Zxh7+c9EbxRRCVnR9SwS7KDUfNzmeYi1nvj6PpR
	NSZjpVGrqgOJOCR5xNcOplO4+gPR7fkFh5YHwgedFXfx5mO/Uh2+tqCS
X-Gm-Gg: Acq92OH1zVgjXfxdhwf31rlcgTrOt3hdTqNQ+t53q32GHyXxqZqSXZUdwSVn8F/NcV9
	s8iQ+k9N9Lm5zDINIqRiwxg+FoefkBliJC+5Udd7d4BGYxh+Lq1Q8slyOwxStNKdADzwdRq9m4J
	VsI3fjf5kzd41stPv1ORQFI4zhRaudpaYcT/TknayMgUcnjZlYy6RQaorYhWC/4UO/CbBX2GWEk
	K7zUPIK2ohCMy7VsQE4mYXCreCtgx4+Wexkx+eYY5s7ZPXbWeUAARM+AGfAMlJi0/dr0ni31hto
	MXwd+wor3Sye5DvyZ29NgGuuwYRV1uMjNm98V2xh+Fi+tM1HWgPa163mLTcm+po7I0JDdoAgaAM
	8iFH+VZQ8v3/Z6UTcRk6GoO75O/wyqYpOKLMsJ05m6mg97DUlcIyY6DAucbwVqRnlr/PxmLgWKH
	qBNaEv/624xxmnnuydErJ7
X-Received: by 2002:a17:90b:1d44:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-37c2bd49b00mr11352930a91.19.1781533327200;
        Mon, 15 Jun 2026 07:22:07 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7178233a91.2.2026.06.15.07.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:22:06 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/10] Input: cap11xx - add support for CAP1114
Date: Mon, 15 Jun 2026 22:20:36 +0800
Message-ID: <20260615142103.352163-11-jerrysteve1101@gmail.com>
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

CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
and hardware reset support.

The CAP1114 uses two control registers for LED output management and
requires two button status registers for touch input state reporting.

By default, channels CS8~CS14 operate as a single grouped block.
Set the corresponding register enable bit to enable these channels as
independent touch inputs. Note these channels share the input threshold
of the eighth entry, causing num_sensor_thresholds to differ from
num_channels.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 73 ++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index c48ee8520a27..187a212dfa8f 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -18,6 +18,12 @@
 #include <linux/gpio/consumer.h>
 #include <linux/bitfield.h>
 
+#define CAP1114_REG_BUTTON_STATUS1	0x03
+#define CAP1114_REG_BUTTON_STATUS2	0x04
+#define CAP1114_REG_CONFIG2			0x40
+#define CAP1114_REG_CONFIG2_VOL_UP_DOWN	BIT(1)
+#define CAP1114_REG_LED_OUTPUT_CONTROL1	0x73
+
 #define CAP11XX_REG_MAIN_CONTROL	0x00
 #define CAP11XX_REG_MAIN_CONTROL_GAIN_SHIFT	(6)
 #define CAP11XX_REG_MAIN_CONTROL_GAIN_MASK	(0xc0)
@@ -82,6 +88,7 @@ struct cap11xx_hw_model {
 	unsigned int num_leds;
 	unsigned int num_sensor_thresholds;
 	bool has_gain;
+	bool has_grouped_sensors;
 	bool has_irq_config;
 	bool has_repeat_en;
 	bool has_sensitivity_control;
@@ -98,6 +105,8 @@ static const struct reg_default cap11xx_reg_defaults[] = {
 	{ CAP11XX_REG_SENSOR_THRESH(3),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(4),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(5),		0x40 },
+	{ CAP11XX_REG_SENSOR_THRESH(6),		0x40 },
+	{ CAP11XX_REG_SENSOR_THRESH(7),		0x40 },
 	{ CAP11XX_REG_CONFIG2,			0x40 },
 };
 
@@ -106,6 +115,12 @@ static bool cap11xx_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case CAP11XX_REG_MAIN_CONTROL:
 	case CAP11XX_REG_SENSOR_INPUT:
+	/*
+	 * CAP1114_REG_BUTTON_STATUS1 (CAP11XX_REG_SENSOR_INPUT) and
+	 * CAP1114_REG_BUTTON_STATUS2 is volatile for the CAP1114,
+	 * which supports more than 8 touch channels.
+	 */
+	case CAP1114_REG_BUTTON_STATUS2:
 		return true;
 	}
 
@@ -285,6 +300,17 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 	of_property_read_u32_array(node, "linux,keycodes",
 				   priv->keycodes, priv->model->num_channels);
 
+	/*
+	 * CAP1114 needs dedicated configuration to split
+	 * grouped sensors into independent inputs.
+	 */
+	if (priv->model->has_grouped_sensors) {
+		error = regmap_set_bits(priv->regmap, CAP1114_REG_CONFIG2,
+					CAP1114_REG_CONFIG2_VOL_UP_DOWN);
+		if (error)
+			return error;
+	}
+
 	if (priv->model->has_repeat_en) {
 		/* Disable autorepeat. The Linux input system has its own handling. */
 		error = regmap_write(priv->regmap, CAP11XX_REG_REPEAT_RATE, 0);
@@ -313,6 +339,21 @@ static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
 	if (ret < 0)
 		goto out;
 
+	if (priv->model->num_channels > 8) {
+		unsigned int status2;
+
+		ret = regmap_read(priv->regmap, priv->model->sensor_input_reg_base + 1, &status2);
+		if (ret < 0)
+			goto out;
+
+		/*
+		 * CAP1114 STATUS1 register only contains data for the first 6 channels.
+		 * the remaining channels is stored in STATUS2.
+		 */
+		status &= GENMASK(5, 0);
+		status |= FIELD_PREP(GENMASK(13, 6), status2);
+	}
+
 	for (i = 0; i < priv->idev->keycodemax; i++)
 		input_report_key(priv->idev, priv->keycodes[i],
 				 status & (1 << i));
@@ -362,10 +403,16 @@ static int cap11xx_led_set(struct led_classdev *cdev,
 	 * limitation. Brightness levels per LED are either
 	 * 0 (OFF) and 1 (ON).
 	 */
-	return regmap_update_bits(priv->regmap,
-				  priv->model->led_output_control_reg_base,
-				  BIT(led->reg),
-				  value ? BIT(led->reg) : 0);
+	if (led->reg >= 8)
+		return regmap_update_bits(priv->regmap,
+					  priv->model->led_output_control_reg_base + 1,
+					  BIT(led->reg - 8),
+					  value ? BIT(led->reg - 8) : 0);
+	else
+		return regmap_update_bits(priv->regmap,
+					  priv->model->led_output_control_reg_base,
+					  BIT(led->reg),
+					  value ? BIT(led->reg) : 0);
 }
 
 static int cap11xx_init_leds(struct device *dev,
@@ -396,6 +443,14 @@ static int cap11xx_init_leds(struct device *dev,
 	if (error)
 		return error;
 
+	if (num_leds > 8) {
+		error = regmap_update_bits(priv->regmap,
+					   priv->model->led_output_control_reg_base + 1,
+					   GENMASK(num_leds - 8 - 1, 0), 0);
+		if (error)
+			return error;
+	}
+
 	duty_val = FIELD_PREP(CAP11XX_REG_LED_DUTY_MAX_MASK,
 			      CAP11XX_REG_LED_DUTY_MAX_VALUE);
 
@@ -573,6 +628,14 @@ static const struct cap11xx_hw_model cap1106_model = {
 	.has_repeat_en = true,
 };
 
+static const struct cap11xx_hw_model cap1114_model = {
+	.product_id = 0x3a,
+	.num_channels = 14, .num_leds = 11, .num_sensor_thresholds = 8,
+	.led_output_control_reg_base = CAP1114_REG_LED_OUTPUT_CONTROL1,
+	.sensor_input_reg_base = CAP1114_REG_BUTTON_STATUS1,
+	.has_grouped_sensors = true,
+};
+
 static const struct cap11xx_hw_model cap1126_model = {
 	.product_id = 0x53,
 	.num_channels = 6, .num_leds = 2, .num_sensor_thresholds = 6,
@@ -629,6 +692,7 @@ static const struct cap11xx_hw_model cap1298_model = {
 
 static const struct of_device_id cap11xx_dt_ids[] = {
 	{ .compatible = "microchip,cap1106", .data = &cap1106_model },
+	{ .compatible = "microchip,cap1114", .data = &cap1114_model },
 	{ .compatible = "microchip,cap1126", .data = &cap1126_model },
 	{ .compatible = "microchip,cap1188", .data = &cap1188_model },
 	{ .compatible = "microchip,cap1203", .data = &cap1203_model },
@@ -641,6 +705,7 @@ MODULE_DEVICE_TABLE(of, cap11xx_dt_ids);
 
 static const struct i2c_device_id cap11xx_i2c_ids[] = {
 	{ .name = "cap1106", .driver_data = (kernel_ulong_t)&cap1106_model },
+	{ .name = "cap1114", .driver_data = (kernel_ulong_t)&cap1114_model },
 	{ .name = "cap1126", .driver_data = (kernel_ulong_t)&cap1126_model },
 	{ .name = "cap1188", .driver_data = (kernel_ulong_t)&cap1188_model },
 	{ .name = "cap1203", .driver_data = (kernel_ulong_t)&cap1203_model },
-- 
2.54.0

