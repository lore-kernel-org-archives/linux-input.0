Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4247F2FB
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708654; cv=none; b=WBWAtF74mv3OLS11vjgviNF0kWbveUMnDJoy1Jn5mQtSPjgUkvKwOAYTemrVmmE/Gn6NSroguk51dLhnOGbRng9M80K5WAcfWpdvNNviBn4pJZG5Lotivsct2UQUDzvRC375xgvElpIRZkR/bX4wNxfXou1qnEvM1xbMyVyuB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708654; c=relaxed/simple;
	bh=m4CmA91diHfu5RQdzmJWrSyYddAprpH+MrakQ4+IiR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er1U3gN2T3bJoZ3dTbqXrKL+R4SxjfF+fCAi3H0o1R1/t6I2CqdJTCD36JMrIhKZJXBK/oSRCoLo/EqOrYhVgK/+vjli2Hw/97Q82YQ3k9ympFUPlQlSyZQ36ACjaz5TBdpsFhQJzSGBHi4IjWylSSuJAqVR2htKokPtQ+WcVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaZVtjUR; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaZVtjUR"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-662dd616cdbso422864d50.1
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708652; x=1782313452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nfUJI5PgMZL2Vorhas9Kozi5Xqa/3mRVb5pBY1dDbk=;
        b=WaZVtjUREQyWwclxqhi8w/QL9rHyHmdDmJLDF00vO5KpcPik/YjTVVxdNzUe/LnpTp
         cvNhXl+v05dFfm3+KNfPojBQkkrrNb8gfzkgtGZYR+5srfAIpRbjEHFho0TVfctDoZtp
         CBNizzvqFJdhBOWXdtcib92ClHpgT2XvpkIqHVtuP1mF9biHnLE115vUmamJq+VW6CDe
         Z4mIThFFli3nGfafTYJbJFoeeyui0J4Af+QMALoSEdR7iRV8QbEfHLhTqzhCjdzJ9jhD
         reLVDOx5OolW1cnj4n6Ou24V1czQsWw32X7fUnbp5pZIj/yv28zrluZONMXWXr9kqOql
         bY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708652; x=1782313452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9nfUJI5PgMZL2Vorhas9Kozi5Xqa/3mRVb5pBY1dDbk=;
        b=OKnTLurRUTAEH1DUf2vpC3pGFELq9vx4aYTepXjha+xsyd/eYdKz90APQ/KdiPrTiL
         whgOvpxFh5uAIxQf8GT9sfHaTLMrfrqYdwVviYPmP2eDUq/k+1W0M0SWwwBIs3o4VsoG
         Mh9ACXlZFkmj0KxLKWHco1Px4MVjqJuYloi88svvtOBycRT3DOKXGhljr5tfTp7NepNJ
         Tc5hR0AH7ANj8HsHar44sGtYDIuOqfgJxejl8S4QVkniDeg6fImSId/jWaRyUemklUa7
         dZ1mXP9JoMdtZwo9EqlC/9oGehEPZmccLbPIyWp3VC7kmZO9h0BtR2SJNz9ryLwzPqqH
         YTsA==
X-Forwarded-Encrypted: i=1; AFNElJ9DWNW6DsVf0TMIAHC3wxs0Va+RfslkO8xu1kHBTsMPtF5WxWXsgzFGQzM1VlpxWhELTHavB5T3nB0Zkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAEVSo6xjgJDiblvifOL055vxRmTozZwG6FyXcV9haAKBD3KI
	sCfXF6g01Wj+wk99tygw6ggRj/+LrwOPDCksmO0/QGFxOiZH2Vi10UDG
X-Gm-Gg: AfdE7ck/gzv3VkfYUrLJFUzwfqHF2KIQuKEufawW6SMtzuxDOCrw7CKvn6Nj5MmxQD9
	LI9jA9NDb/yIvaasuwUkJXjXtPh8mhWrAr+0Bu9MbhlcOh6cKSAZYSm6nQtJ3e4qOZyxao/AqlF
	NAYDmMeeLWuwmTNrlAbJnig7+rflZ5r6FYqapYqGC6JNkHCOg3dkfnHUGn2kg9TNhzUUL83jryh
	kuJocue98Q9/a5luVDzpJDCUDkPK/ECMUxm8roJdsqExyqI0gT8TmkoqCPTi+TZMi6jGaaREg8o
	ZDYFkAKJXqeZzirXW+t0PKvDVPBTNctpENH6qb3e9foWuHlATOWCpXWeadxnN04xTDTm+PwmbV1
	U1Z6ve36Vi/IzkZiGKKp6dkphTRCxtHhl2wD2cld2e42xT8pqVokMDtHgmxr3/+oMqvEYFqgS3k
	vaL/6B+viadQ==
X-Received: by 2002:a05:690e:1343:b0:660:109:b90f with SMTP id 956f58d0204a3-662cbcb84bcmr3775703d50.56.1781708651979;
        Wed, 17 Jun 2026 08:04:11 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662b976e47csm4387677d50.20.2026.06.17.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:04:11 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/10] Input: cap11xx - refactor code for better CAP1114 support.
Date: Wed, 17 Jun 2026 23:02:46 +0800
Message-ID: <20260617150318.753148-8-jerrysteve1101@gmail.com>
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

Extend cap11xx_hw_model structure to support CAP1114 with
different register offsets and hardware characteristics:

- led_output_control_reg_base: different address on CAP1114
- sensor_input_reg_base: different address on CAP1114
- num_sensor_thresholds: separate value from num_channels for CAP1114
- has_repeat_en: repeat enable support, disabled by default on CAP1114

Include linux/bits.h, update the register operations related to LEDs.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 73 +++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 1db4a9090705..0f19ee036e78 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -5,6 +5,7 @@
  * (c) 2014 Daniel Mack <linux@zonque.org>
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -36,7 +37,6 @@
 #define CAP11XX_REG_LED_DUTY_CYCLE_4	0x93
 
 #define CAP11XX_REG_LED_DUTY_MAX_MASK	(0xf0)
-#define CAP11XX_REG_LED_DUTY_MAX_MASK_SHIFT	(4)
 #define CAP11XX_REG_LED_DUTY_MAX_VALUE	(15)
 
 #define CAP11XX_REG_PRODUCT_ID		0xfd
@@ -77,10 +77,14 @@ struct cap11xx_priv {
 
 struct cap11xx_hw_model {
 	u8 product_id;
+	u8 led_output_control_reg_base;
+	u8 sensor_input_reg_base;
 	unsigned int num_channels;
 	unsigned int num_leds;
+	unsigned int num_sensor_thresholds;
 	bool has_gain;
 	bool has_irq_config;
+	bool has_repeat_en;
 	bool has_sensitivity_control;
 	bool has_signal_guard;
 };
@@ -211,8 +215,8 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 	}
 
 	if (!of_property_read_u32_array(node, "microchip,input-threshold",
-					priv->thresholds, priv->model->num_channels)) {
-		for (i = 0; i < priv->model->num_channels; i++) {
+					priv->thresholds, priv->model->num_sensor_thresholds)) {
+		for (i = 0; i < priv->model->num_sensor_thresholds; i++) {
 			if (priv->thresholds[i] > 127) {
 				dev_err(dev, "Invalid input-threshold value %u\n",
 					priv->thresholds[i]);
@@ -286,10 +290,12 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 	of_property_read_u32_array(node, "linux,keycodes",
 				   priv->keycodes, priv->model->num_channels);
 
-	/* Disable autorepeat. The Linux input system has its own handling. */
-	error = regmap_write(priv->regmap, CAP11XX_REG_REPEAT_RATE, 0);
-	if (error)
-		return error;
+	if (priv->model->has_repeat_en) {
+		/* Disable autorepeat. The Linux input system has its own handling. */
+		error = regmap_write(priv->regmap, CAP11XX_REG_REPEAT_RATE, 0);
+		if (error)
+			return error;
+	}
 
 	return 0;
 }
@@ -308,7 +314,7 @@ static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_read(priv->regmap, CAP11XX_REG_SENSOR_INPUT, &status);
+	ret = regmap_read(priv->regmap, priv->model->sensor_input_reg_base, &status);
 	if (ret < 0)
 		goto out;
 
@@ -362,7 +368,7 @@ static int cap11xx_led_set(struct led_classdev *cdev,
 	 * 0 (OFF) and 1 (ON).
 	 */
 	return regmap_update_bits(priv->regmap,
-				  CAP11XX_REG_LED_OUTPUT_CONTROL,
+				  priv->model->led_output_control_reg_base,
 				  BIT(led->reg),
 				  value ? BIT(led->reg) : 0);
 }
@@ -374,6 +380,7 @@ static int cap11xx_init_leds(struct device *dev,
 	struct cap11xx_led *led;
 	int cnt = of_get_child_count(node);
 	int error;
+	u32 duty_val;
 
 	if (!num_leds || !cnt)
 		return 0;
@@ -387,15 +394,18 @@ static int cap11xx_init_leds(struct device *dev,
 
 	priv->leds = led;
 
+	/* Set all LEDs to off */
 	error = regmap_update_bits(priv->regmap,
-				CAP11XX_REG_LED_OUTPUT_CONTROL, 0xff, 0);
+				   priv->model->led_output_control_reg_base,
+				   GENMASK(min(num_leds, 8) - 1, 0), 0);
 	if (error)
 		return error;
 
+	duty_val = FIELD_PREP(CAP11XX_REG_LED_DUTY_MAX_MASK,
+			      CAP11XX_REG_LED_DUTY_MAX_VALUE);
+
 	error = regmap_update_bits(priv->regmap, CAP11XX_REG_LED_DUTY_CYCLE_4,
-				CAP11XX_REG_LED_DUTY_MAX_MASK,
-				CAP11XX_REG_LED_DUTY_MAX_VALUE <<
-				CAP11XX_REG_LED_DUTY_MAX_MASK_SHIFT);
+				   CAP11XX_REG_LED_DUTY_MAX_MASK, duty_val);
 	if (error)
 		return error;
 
@@ -561,41 +571,64 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 }
 
 static const struct cap11xx_hw_model cap1106_model = {
-	.product_id = 0x55, .num_channels = 6, .num_leds = 0,
+	.product_id = 0x55,
+	.num_channels = 6, .num_leds = 0, .num_sensor_thresholds = 6,
+	.sensor_input_reg_base = CAP11XX_REG_SENSOR_INPUT,
 	.has_gain = true,
 	.has_irq_config = true,
+	.has_repeat_en = true,
 };
 
 static const struct cap11xx_hw_model cap1126_model = {
-	.product_id = 0x53, .num_channels = 6, .num_leds = 2,
+	.product_id = 0x53,
+	.num_channels = 6, .num_leds = 2, .num_sensor_thresholds = 6,
+	.led_output_control_reg_base = CAP11XX_REG_LED_OUTPUT_CONTROL,
+	.sensor_input_reg_base = CAP11XX_REG_SENSOR_INPUT,
 	.has_gain = true,
 	.has_irq_config = true,
+	.has_repeat_en = true,
 };
 
 static const struct cap11xx_hw_model cap1188_model = {
-	.product_id = 0x50, .num_channels = 8, .num_leds = 8,
+	.product_id = 0x50,
+	.num_channels = 8, .num_leds = 8, .num_sensor_thresholds = 8,
+	.led_output_control_reg_base = CAP11XX_REG_LED_OUTPUT_CONTROL,
+	.sensor_input_reg_base = CAP11XX_REG_SENSOR_INPUT,
 	.has_gain = true,
 	.has_irq_config = true,
+	.has_repeat_en = true,
 };
 
 static const struct cap11xx_hw_model cap1203_model = {
-	.product_id = 0x6d, .num_channels = 3, .num_leds = 0,
+	.product_id = 0x6d,
+	.num_channels = 3, .num_leds = 0, .num_sensor_thresholds = 3,
+	.sensor_input_reg_base = CAP11XX_REG_SENSOR_INPUT,
+	.has_repeat_en = true,
 };
 
 static const struct cap11xx_hw_model cap1206_model = {
-	.product_id = 0x67, .num_channels = 6, .num_leds = 0,
+	.product_id = 0x67,
+	.num_channels = 6, .num_leds = 0, .num_sensor_thresholds = 6,
+	.sensor_input_reg_base = CAP11XX_REG_SENSOR_INPUT,
+	.has_repeat_en = true,
 };
 
 static const struct cap11xx_hw_model cap1293_model = {
-	.product_id = 0x6f, .num_channels = 3, .num_leds = 0,
+	.product_id = 0x6f,
+	.num_channels = 3, .num_leds = 0, .num_sensor_thresholds = 3,
+	.sensor_input_reg_base = CAP11XX_REG_SENSOR_INPUT,
 	.has_gain = true,
+	.has_repeat_en = true,
 	.has_sensitivity_control = true,
 	.has_signal_guard = true,
 };
 
 static const struct cap11xx_hw_model cap1298_model = {
-	.product_id = 0x71, .num_channels = 8, .num_leds = 0,
+	.product_id = 0x71,
+	.num_channels = 8, .num_leds = 0, .num_sensor_thresholds = 8,
+	.sensor_input_reg_base = CAP11XX_REG_SENSOR_INPUT,
 	.has_gain = true,
+	.has_repeat_en = true,
 	.has_sensitivity_control = true,
 	.has_signal_guard = true,
 };
-- 
2.54.0

