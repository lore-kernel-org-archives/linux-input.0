Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72263DD52B
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249048; cv=none; b=PeC8yJ4HEZJyObMgmOY66qeWGJnfOXUnV5Q1LcqJVGDYHdwkCxvF7VLuXaDdVt4JNVKaIpNT4D8Pjg2JWeyQ6KfVqrZKNlnlzIg9XIQZRVoK+RfYwtS+ZdoHP0okjbOvgFQi+tvy4P8cr0F/1yHx0v0GgL+PyIwQS8sUOWHMM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249048; c=relaxed/simple;
	bh=brLuaCz4tG7g5I266nNqxm6IPkKRFu5uQhdh2hXzmqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/t5wFLDozgkM8PwkG2acUs7ja0a+/GwYcFuASQOoacaOWaw8tY5s28fhjIjxarNbjS0w4H388IvAT5LghAYmqBHzv7SWArwyHXZmiplPupIEVMxEZKOc2kIcCx6jbbbquOQ8PdvbHK16WzwPnwy5yL7/ZlbJrUJZwnrHs882b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlL4KU0/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlL4KU0/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b3e03939so5412045e9.1
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249045; x=1781853845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9lcTv4TvBeGoSmX2RK3FsqdY9z50fC+LqdPWC8A3lg=;
        b=FlL4KU0/rjn5rOLvZd/mq5QvuDEgYgw1nhcE14ltUPptokPufAYsIqo61ddGU9oOEp
         8T66GDUSc1gtBCssqwMQvX36Mso7/miZ4N+0WRrNN0Y/zDoTAW5UtQA2jBKx9LESYCyU
         XZEMfJ0JaSr7NXUENVIpLI1iLjl4v8b5uTgLo0myVfzoQ7pDsZjfMxelrzPEwSxQ/Ahp
         hkjrQB6GI35ex1CxprfxptKGa7ccgUOYqHLKUjw+/b35syXkbEtHtdEM5jzUI9Okqzbz
         REJJ7Yq9JF03AbMLUYlfXtjXTEKNECd7uDNyMxt1umtFDP+nUqnW/Vpti+rRy6HPS4pq
         q1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249045; x=1781853845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p9lcTv4TvBeGoSmX2RK3FsqdY9z50fC+LqdPWC8A3lg=;
        b=WnctP1eXw09d73d56ZQF9IWwLSP2HELhflxlEFLUCVVD2HZ1TMSNcvSyf0UykrSS7o
         SylT+sPZjhFBjNiGm5vWSLaMPNIIXAS/g+7lU0gM2cXcuw/T2lkdNOssrQeLQfBaNSJs
         yTkkuqsfX5dSQ+hueGl6cx2EVNN84YSgOrnH7jo/NPE9lepGEXs9PeCteXyOFC4/aWeQ
         t0lf6ZXmx7mnrQrskwmWHMKD6UKQRY9WuUEZ4d/skJih5d5w+CMz+CJ3CXzyXiuWJ70q
         M6SsTzwM/xInfrEIWD7SswKG/22rqrAMasiGPD7+SSQGjRa6NXphHPbhiXnSxnxc9oZn
         CibA==
X-Forwarded-Encrypted: i=1; AFNElJ9KGPJXV7+nW2mIbpxKok4hXFc0GWsADantBDq+AGj2Jm4dUO9khM3nGKdg+eSUHMRX+evb9vI2sFbknA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyQZnx+Vq1YB/EqwbVz9IcOU65CleBNnE6gnuUrIiVQGb1Msq
	3tHPK1wPazUbbjqWfnI2UJPX1hCkodnXrGsPAGNNYCBYVGEMcBCskBNH
X-Gm-Gg: Acq92OH7FqRbCLMfLLwxGXcp4O0meV0YddtT6D7Ko78MTNr9y0vvzjQfj2GouwnzE63
	/UjTpdfiRWG1J6mj4T3UqjpGUOgzPflZAN6Itubzwlmz4OTk6oquVnJxggT8PaZm9dlu7fFLe/c
	a4UMb/4iFt3UqSgHbU7qRNva7G2j7g+K2oPBudS6qXZpDAGx+knjnx9uIPA64qlL5JTCa90G2IO
	Ut3rR7s8l5FcNNPeB2lC1XXOjdHvuTe+CLJ31Ld37eBwq3xBtMsDXZm2a6IHpmuCGJxTt06brx0
	On0vpl+21ILGvCkK0QB6tdmhl3paZYTqCOj9Oormhnl7FG3nrgkPycFw6HS+g9b49SL+ShqZlK5
	pDLOPswFSSXVAKGCm7bcTLjF/SGt5Lb47QOPHPSAGCfp+gofTyIqg+G5NmnzeStMHt6ZTrkSf4V
	Nnf3xaFVA6FQoIV377TdjCii6Uz2E+78tzi/BSES8=
X-Received: by 2002:a05:600c:698c:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490ec4e9147mr12990265e9.16.1781249045047;
        Fri, 12 Jun 2026 00:24:05 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm28715245e9.2.2026.06.12.00.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:24:04 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] Input: cap11xx - add support for CAP1114
Date: Fri, 12 Jun 2026 15:22:15 +0800
Message-ID: <20260612072237.1177304-10-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612072237.1177304-1-jerrysteve1101@gmail.com>
References: <20260612072237.1177304-1-jerrysteve1101@gmail.com>
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
 drivers/input/keyboard/cap11xx.c | 74 ++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index d45bb231d7a1..e4da0e26c34a 100644
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
@@ -98,6 +105,9 @@ static const struct reg_default cap11xx_reg_defaults[] = {
 	{ CAP11XX_REG_SENSOR_THRESH(3),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(4),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(5),		0x40 },
+	{ CAP11XX_REG_SENSOR_THRESH(6),		0x40 },
+	{ CAP11XX_REG_SENSOR_THRESH(7),		0x40 },
+	{ CAP11XX_REG_SENSOR_THRESH(8),		0x40 },
 	{ CAP11XX_REG_CONFIG2,			0x40 },
 };
 
@@ -106,6 +116,12 @@ static bool cap11xx_volatile_reg(struct device *dev, unsigned int reg)
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
 
@@ -283,6 +299,17 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
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
@@ -311,6 +338,21 @@ static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
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
@@ -360,10 +402,16 @@ static int cap11xx_led_set(struct led_classdev *cdev,
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
@@ -394,6 +442,14 @@ static int cap11xx_init_leds(struct device *dev,
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
 
@@ -572,6 +628,14 @@ static const struct cap11xx_hw_model cap1106_model = {
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
@@ -628,6 +692,7 @@ static const struct cap11xx_hw_model cap1298_model = {
 
 static const struct of_device_id cap11xx_dt_ids[] = {
 	{ .compatible = "microchip,cap1106", .data = &cap1106_model },
+	{ .compatible = "microchip,cap1114", .data = &cap1114_model },
 	{ .compatible = "microchip,cap1126", .data = &cap1126_model },
 	{ .compatible = "microchip,cap1188", .data = &cap1188_model },
 	{ .compatible = "microchip,cap1203", .data = &cap1203_model },
@@ -640,6 +705,7 @@ MODULE_DEVICE_TABLE(of, cap11xx_dt_ids);
 
 static const struct i2c_device_id cap11xx_i2c_ids[] = {
 	{ .name = "cap1106", .driver_data = (kernel_ulong_t)&cap1106_model },
+	{ .name = "cap1114", .driver_data = (kernel_ulong_t)&cap1114_model },
 	{ .name = "cap1126", .driver_data = (kernel_ulong_t)&cap1126_model },
 	{ .name = "cap1188", .driver_data = (kernel_ulong_t)&cap1188_model },
 	{ .name = "cap1203", .driver_data = (kernel_ulong_t)&cap1203_model },
-- 
2.54.0

