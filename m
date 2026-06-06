Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1631A567
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780758401; cv=none; b=RJO1mPs5okbvT4/RrZNKrYcdyJK60BujgqG49iHSw24NrCHFe6M1VQLk42yyBZG8cMgxzGLMwDwUveK2HcvK3FMQETrfSC5YuWbYtXPX16S+csmtLKfhnmY6oGwaEzVGxW2aQpzvtFT+1N8WJKFxbYBijjMWj1zuYeELhK7qW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780758401; c=relaxed/simple;
	bh=/iq/pKUcLd2+ZjphyoeKuDnlDKhdvKBfSeOZb+ir2LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6f4fbkJvRhYpH4cXLTF6dlD91Y3UURNnljtWGO0nwpjXNORngqKjZbRJfifkxwzPYSnIlW0P3SRT8dBRxuz8ysP5LfDO4w1URK8auvd4wV4AUa1Z2Tk1nWH1qXs1+32SUSNLKJc+b9vxTrQwOzxhWhgVNb55vIuVXt99e3Ftrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3wFSyWm; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3wFSyWm"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13807d2f898so1617255c88.0
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780758400; x=1781363200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjiWtAz+aQ4k3cgwyCNnyCozbPzrXU6EPLyKwpTDaVY=;
        b=O3wFSyWmHKGIGAhRL8b7BYYLOhWgzib+nVF6ZTUUygNRwPyrQi/D753GTP3uRivRWH
         NO1UiPN4BzdJCTWb6FVsqgN7PNNUxTT7i11twcMOxaxzvzU/FUdi6u0LM5UUimFdRsn2
         OhmmgBlGHv4Y/ALzzjIGC5Tkse7u1RlMctpi6Lmt4kiTkj9+P7lhMmd5amzxSqF+rfXV
         zxeDE9SsLbPePB520J/VGSmJBpfoSM12Ep/ohcmQj69Ta9GWdyjc9lY/kmGqpLEaBjJO
         Vd03JfAbuFw5IPpZT2biUWnxequMYYWUeW1+xX5jZOgJzdDAwPQ9CD+NF+BZDcUqakIn
         Hp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780758400; x=1781363200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TjiWtAz+aQ4k3cgwyCNnyCozbPzrXU6EPLyKwpTDaVY=;
        b=cZVR2XnsZwXkLM8eHY6ziCUSUOqnvDBvqlu0RVjFXoXJp+hKNY5ZGuEJTLw4kIF3i0
         Zi3TBehrATh3C4WENAfdWP6cRI649XobCwWVN/e5DloKzvnjcvpIaPkpF1OH2etToMNe
         iptimW+GL3E6j4qjTcf+P5gD2axJRP2vyceiEhtmh1faq1xgXpvr1GWUrgZZJedeK9fq
         y0lt418+hPmkvOG993p8JZ/ObhlZUxykZlXepSt6SOQxEpTnXhF9U7+VObJXebFQ0AEd
         t+tZVbzwvcQAJWmyCJ0R5738O7vmDhalZGPyu74ncEBLumUd/Xq4Jmqbc2RugrSptf3k
         wtPw==
X-Forwarded-Encrypted: i=1; AFNElJ8hJqQJbhLVgXtZoTR0UHfOe0DQUNOUaZcgzo63bEiCsJt0tuvF7Tkxng9W3/75XEphkaLVT+MhI40CUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhgMKgvqWIz8WAEQ+OZZdBYbxrc98CcBjmL7gaw1u6K4G7TWg
	ipQf5AlPA/pScocrhVtCmTnx9FiBm/lTZFtXjWcyk9+pa2TpOynwlrOs
X-Gm-Gg: Acq92OGnhakTeIfhhrSM9yUv60sQfmSTHe1KVbIAXgQvtFq2GKlLayyd+/Gxy0bV4ih
	32mDxJWLInXxkMlDYvQRkrDBmJmvz5Kaz5CwqaiMgzM4/rG/wgOkS0XoMon+RxSkB2dOCqrIK5L
	lHjCxu01I8zb/ob0jdJAq/YciQzyfWDKUooivON8M/y5cFZtNSz1C27yeZdkRH7aZfqzdePGVqc
	2cd7UrNCQHc4flYor8udTd2UHoGQ781qSZnmvEBVpEgWUdLp/JugTspxSiFl4BvzZCm4H0gjLPF
	NT0qo37UxNba43MK4PRaI0E8qgpL/qMIeiz1K6Ky+RxmDcfNXn8TfFqEso7T4X9oTbtibFut02S
	+YnQhVxaB2jty95SdMU1EVubz0nosdwC44iiPzji40cdSzFuM6pnVbHIDvA4BbglRkq3CjQCymE
	0Zos7kFJRorMKqbNzOSiaXkFDPX18X5tZw1iOqh6RD848HeWUlBq2siJhKc4Xu
X-Received: by 2002:a05:7022:7a5:b0:137:6781:7dd4 with SMTP id a92af1059eb24-138066b5982mr4256600c88.8.1780758399496;
        Sat, 06 Jun 2026 08:06:39 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539035sm8415607c88.11.2026.06.06.08.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:06:39 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] Input: cap11xx - add support for CAP1114
Date: Sat,  6 Jun 2026 23:04:01 +0800
Message-ID: <20260606150458.250606-9-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606150458.250606-1-jerrysteve1101@gmail.com>
References: <20260606150458.250606-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
and hardware reset support.

The CAP1114 uses two separate control registers for LED output
management and requires two button status registers for touch input
state reporting.

By default, channels CS8~CS14 operate as a single grouped block.
Set the corresponding register enable bit to enable these channels as
independent touch inputs. Note these channels share the input threshold
of the eighth entry, causing num_sensor_thresholds to differ from
num_channels.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 65 +++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 408880cf6516..2aba3b508947 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -17,6 +17,12 @@
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
 
@@ -283,6 +299,16 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 	of_property_read_u32_array(node, "linux,keycodes",
 				   priv->keycodes, priv->model->num_channels);
 
+	/*
+	 * CAP1114 needs dedicated configuration to split grouped sensors into independent inputs.
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
@@ -311,6 +337,20 @@ static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
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
+		status |= FIELD_PREP(GENMASK(13, 6), status2);
+	}
+
 	for (i = 0; i < priv->idev->keycodemax; i++)
 		input_report_key(priv->idev, priv->keycodes[i],
 				 status & (1 << i));
@@ -360,7 +400,13 @@ static int cap11xx_led_set(struct led_classdev *cdev,
 	 * limitation. Brightness levels per LED are either
 	 * 0 (OFF) and 1 (ON).
 	 */
-	return regmap_update_bits(priv->regmap,
+	if (led->reg >= 8)
+		return regmap_update_bits(priv->regmap,
+					priv->model->led_output_control_reg_base + 1,
+					BIT(led->reg - 8),
+					value ? BIT(led->reg - 8) : 0);
+	else
+		return regmap_update_bits(priv->regmap,
 				  priv->model->led_output_control_reg_base,
 				  BIT(led->reg),
 				  value ? BIT(led->reg) : 0);
@@ -393,6 +439,13 @@ static int cap11xx_init_leds(struct device *dev,
 					GENMASK(num_leds - 1, 0), 0);
 	if (error)
 		return error;
+	if (num_leds > 8) {
+		error = regmap_update_bits(priv->regmap,
+						priv->model->led_output_control_reg_base + 1,
+						GENMASK(num_leds - 8 - 1, 0), 0);
+		if (error)
+			return error;
+	}
 
 	duty_val = FIELD_PREP(CAP11XX_REG_LED_DUTY_MAX_MASK,
 			     CAP11XX_REG_LED_DUTY_MAX_VALUE);
@@ -572,6 +625,14 @@ static const struct cap11xx_hw_model cap1106_model = {
 	.has_repeat_en = true,
 };
 
+static const struct cap11xx_hw_model cap1114_model = {
+	.product_id = 0x3a,
+	.led_output_control_reg_base = CAP1114_REG_LED_OUTPUT_CONTROL1,
+	.sensor_input_reg_base = CAP1114_REG_BUTTON_STATUS1,
+	.num_channels = 14, .num_leds = 11, .num_sensor_thresholds = 8,
+	.has_grouped_sensors = true,
+};
+
 static const struct cap11xx_hw_model cap1126_model = {
 	.product_id = 0x53,
 	.led_output_control_reg_base = CAP11XX_REG_LED_OUTPUT_CONTROL,
@@ -628,6 +689,7 @@ static const struct cap11xx_hw_model cap1298_model = {
 
 static const struct of_device_id cap11xx_dt_ids[] = {
 	{ .compatible = "microchip,cap1106", .data = &cap1106_model },
+	{ .compatible = "microchip,cap1114", .data = &cap1114_model },
 	{ .compatible = "microchip,cap1126", .data = &cap1126_model },
 	{ .compatible = "microchip,cap1188", .data = &cap1188_model },
 	{ .compatible = "microchip,cap1203", .data = &cap1203_model },
@@ -640,6 +702,7 @@ MODULE_DEVICE_TABLE(of, cap11xx_dt_ids);
 
 static const struct i2c_device_id cap11xx_i2c_ids[] = {
 	{ .name = "cap1106", .driver_data = (kernel_ulong_t)&cap1106_model },
+	{ .name = "cap1114", .driver_data = (kernel_ulong_t)&cap1114_model },
 	{ .name = "cap1126", .driver_data = (kernel_ulong_t)&cap1126_model },
 	{ .name = "cap1188", .driver_data = (kernel_ulong_t)&cap1188_model },
 	{ .name = "cap1203", .driver_data = (kernel_ulong_t)&cap1203_model },
-- 
2.54.0

