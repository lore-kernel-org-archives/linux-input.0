Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647C480356
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708675; cv=none; b=tFw+MXacdJcM2Mh1bKgIDd3fa3X375MXI0QqJmzjJq120BexQnZcTzelhG/Kf2+7ZGynPPGf8T8f40wIGYeFz6xy3K+6Jyz2ek/11Y6gIu2mz9e8C8N38DoPgjXGN+MtdjFUVWyR9/xIYaCfcV7PZu8PdSFn5vs+jRirvVh0FY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708675; c=relaxed/simple;
	bh=5BpVJoy+1TyfvgwcVXtEkGTGeTYH28meSXz9w/scfFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIEZQxReC2muZD2yDoluaGp3sI5VHr//cgikHzugVLZdWxq7CRPGIuw74HSQ4smb8/R1oI7HM22UeqXp5e5ox+4kwMrcq4BO9cffpsut+DPZ0tUa7Lx/GfW4/3WosL+OFbnZLhkpR9QAtLKJjExA+3S6C3TYi6+/fQNe0suejJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9B/jkbI; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9B/jkbI"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66077e888b2so5087786d50.3
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708673; x=1782313473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRAP1SSlllYedJDNQVmn5K2Zt/wBEvaP3ONEb268jPU=;
        b=q9B/jkbIniiiaK9BGct+DTh7l/dDG5jr9NAEf+uYFdVrtDu1Xfalj0+0ad5cCOabua
         EeQnwmK0G1LlrEmJ3TeANLad7ABczeOjQ3psFyIJ4BIMivF6X2aCbm5GCqglFyzcKQJI
         hDnfJ8YnxpyxIEzVtXmu+wiU2m8dhd2fAhnnWhhVLxI2EC+eRapEXLvyV2I5QIjPjYb0
         +/FvwZmuROBzFyjb9faYFTo+IHAwdK4hgkH8oTuZ+Go2GjxXVylHuuxN8wzKWKxSzEMo
         Mf6In0J60PUiKCNUW7qlDqsWYQlWs1Ue4qX/fG4aALZ4TBo4gDus95LHaOsb6XU0mtgT
         kyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708673; x=1782313473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRAP1SSlllYedJDNQVmn5K2Zt/wBEvaP3ONEb268jPU=;
        b=Inj7wP7IuFrcWJFjhOjzw3IhGS0i0peH+Grrlc2DzR7xcmB8esyDc9AiwmEo97M/cE
         O6h+DgnWiJlYLuxfq2RaKFjR4T2qIodHJfMAG7RFZ3j8kj3+wTi0HStpiyYO1eybx2Kw
         oe5/aDKXov5VM3A1gKtRnfULterpp3eNv1vLJGfGoQEf9AG9/SySukGaycN0cV5qSCsa
         kuXJnUPk0PKUBNOw81Q/IalRP+D10UNPptGybM+xzh/nudlCPqaTw1g6nUjOuBI4xmdg
         zcHhGEvccQlYkhsMuasgWmblh6Ish49XK+l8l6sgcousKh+VUad3XVFLDzh8CRuZsNco
         iSIg==
X-Forwarded-Encrypted: i=1; AFNElJ+OVgEKij/t3q2jUHPfoAsphzSBoJAdGOp7Vx9mZeoYtYBz0dURi6x6hClaLB1ucrMQIm4ggbhLt8/sTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rOehOOYX7ArTVT4fpdZuZwlkMWVOWQfd6p+mIx2yY2JrfwsW
	EeV7HJMRLF4JKP9QPNOp+mTtDzWIe5dbS0fHJr84uXRvtlfy4TjyN+As
X-Gm-Gg: AfdE7ckcE5oQ8AQmtXXvXFDmikSrbG3YvQCn3I5Pc3SiWGTjtgXWVaMwh6kigK1snZT
	0+DmcpD6GxiTM2Sw2c8O+nh2dJRC4gExeiL63zs90il1WCBkKEnxRoI2hrAp1h13ldk5fFltldN
	EVPX3I7dBE/q6FchNtUV239AF6CkpY90Skm8PbspD5eFuVZtWDh3kF2r1gzNspqsrvRxauJBPVG
	gt8QT5vOBiKnA0xmVrWY+RHPgB4Dn4mOBW+Yr46eDLOhf3JQT1TMMFJQZWXT+BIjZUSbWAmc4xz
	YnIOjJv2eYYDTmG0xXJFRErZQzGCEfdvgqQ+9ympvuYDVXyvHFga8ZobPwWkTkti2eBBfDiga3w
	u6q3reQ7alDUPNmXdbNExidkJ+QFlZQqEaKCad+YV2QPWZ0Gd3rgkDeIexBbFyEKcsoBJFCLF5n
	cbtN2CdDaeiQ==
X-Received: by 2002:a05:690e:dcc:b0:65e:20b1:e963 with SMTP id 956f58d0204a3-662cd79dad4mr3428592d50.34.1781708672954;
        Wed, 17 Jun 2026 08:04:32 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662b976e47csm4387677d50.20.2026.06.17.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:04:32 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/10] Input: cap11xx - add support for CAP1114
Date: Wed, 17 Jun 2026 23:02:49 +0800
Message-ID: <20260617150318.753148-11-jerrysteve1101@gmail.com>
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
index 275eb79a7193..865c58533eb9 100644
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
@@ -83,6 +89,7 @@ struct cap11xx_hw_model {
 	unsigned int num_leds;
 	unsigned int num_sensor_thresholds;
 	bool has_gain;
+	bool has_grouped_sensors;
 	bool has_irq_config;
 	bool has_repeat_en;
 	bool has_sensitivity_control;
@@ -99,6 +106,8 @@ static const struct reg_default cap11xx_reg_defaults[] = {
 	{ CAP11XX_REG_SENSOR_THRESH(3),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(4),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(5),		0x40 },
+	{ CAP11XX_REG_SENSOR_THRESH(6),		0x40 },
+	{ CAP11XX_REG_SENSOR_THRESH(7),		0x40 },
 	{ CAP11XX_REG_CONFIG2,			0x40 },
 };
 
@@ -107,6 +116,12 @@ static bool cap11xx_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case CAP11XX_REG_MAIN_CONTROL:
 	case CAP11XX_REG_SENSOR_INPUT:
+	/*
+	 * CAP1114_REG_BUTTON_STATUS1 (CAP11XX_REG_SENSOR_INPUT) and
+	 * CAP1114_REG_BUTTON_STATUS2 is volatile for the CAP1114,
+	 * which supports more than 8 touch channels.
+	 */
+	case CAP1114_REG_BUTTON_STATUS2:
 	case CAP11XX_REG_SENOR_DELTA(0):
 	case CAP11XX_REG_SENOR_DELTA(1):
 	case CAP11XX_REG_SENOR_DELTA(2):
@@ -292,6 +307,17 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
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
@@ -320,6 +346,21 @@ static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
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
@@ -369,10 +410,16 @@ static int cap11xx_led_set(struct led_classdev *cdev,
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
@@ -403,6 +450,14 @@ static int cap11xx_init_leds(struct device *dev,
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
 
@@ -581,6 +636,14 @@ static const struct cap11xx_hw_model cap1106_model = {
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
@@ -637,6 +700,7 @@ static const struct cap11xx_hw_model cap1298_model = {
 
 static const struct of_device_id cap11xx_dt_ids[] = {
 	{ .compatible = "microchip,cap1106", .data = &cap1106_model },
+	{ .compatible = "microchip,cap1114", .data = &cap1114_model },
 	{ .compatible = "microchip,cap1126", .data = &cap1126_model },
 	{ .compatible = "microchip,cap1188", .data = &cap1188_model },
 	{ .compatible = "microchip,cap1203", .data = &cap1203_model },
@@ -649,6 +713,7 @@ MODULE_DEVICE_TABLE(of, cap11xx_dt_ids);
 
 static const struct i2c_device_id cap11xx_i2c_ids[] = {
 	{ .name = "cap1106", .driver_data = (kernel_ulong_t)&cap1106_model },
+	{ .name = "cap1114", .driver_data = (kernel_ulong_t)&cap1114_model },
 	{ .name = "cap1126", .driver_data = (kernel_ulong_t)&cap1126_model },
 	{ .name = "cap1188", .driver_data = (kernel_ulong_t)&cap1188_model },
 	{ .name = "cap1203", .driver_data = (kernel_ulong_t)&cap1203_model },
-- 
2.54.0

