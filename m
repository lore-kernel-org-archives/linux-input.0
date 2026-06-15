Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC23FCB17
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533320; cv=none; b=Ag0B7CkBexJERWKJ6jZrXgdQPNWal+OX9HuLwo2tlIBAXBRtPetUf56rJSGOVNLswR2HSyIZIG3e55UBsFWzhU+OMt79dbPDnUai0CqTdZv7HlQIHJpDy89GW1wgWYbS5NbRGRgtLl/iOU8mvJ7qa6kjpL+DiBocLJz0dD7Q++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533320; c=relaxed/simple;
	bh=qfK3SKX6U5kDYSvYsmzi2QUd5YPBvw5DVn0OKZsUIIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayQDOMHCCwOroPKRQxE8TtEAgbr8v8eJrqjV0hQD9FjebV9e+enoiMCKWS970EAfhcZrdVcdj/dBK3jHZsKvmixJaT/whq4LrscRtmC2Rzi9Es26URcdhvaZSn1+y4Bk97/d52Jl5hrWGWkYD53HGrGIH4NYgdUiqcjSi3UjZKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI5qDT09; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI5qDT09"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36da151a152so2395168a91.1
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533313; x=1782138113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+lG/D10H+WbBBEJPWpqjE1Xy7NGrC7DoYpfX8RmnS0=;
        b=iI5qDT091vFfqdtnVDzBsZnwNP4YaCkVkjvE5t6XRNenHEeNo3rKOk9NQ16xZY8rEU
         cnkRk/zW0T7pDKVhEupveOkFErUqJ1lbUoxORf5Rd2wR6Tjh6uUT4IZt04ldo/XcOlM1
         vf4Teyiy8gBrc1EQ6poS8GYVequId1xz5xFLDTXm37gzIfHMQAx2dnQTNcluuxWFLftF
         eBFCMn+qJSg94F8rHEZJwomSWB/KvUMyUlIvXxcXfJz2CUzF5vLfjiAKEuhripFRIhrd
         c/cr8ZnIJ9EV39Cl15jRO2eBSxDKFVRFrddgyI6pLbY8xYlGAILznR0JnJGLTFCdFxBb
         ud7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533313; x=1782138113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+lG/D10H+WbBBEJPWpqjE1Xy7NGrC7DoYpfX8RmnS0=;
        b=aUm59lnCGYnVWfsFEzTjZ2LMIfTqxC3yLGlqLfOtKmQk8xcS3Y8b1TPqD1XBRBcRFH
         XJJhOOTA+l6SrJ6M2hl8o27Wl3byl594dT4M2O47Ao52jTtFlZGrzh+JeGSa1VTTQIWo
         zCC/aHMZkChsiimFu7OBUB1iOcLxU6A6YkN4zFk5AbeVBpMgWgsAOMkhnY4ABj5bWz9L
         LKydUzQvY0vztx0VN1oeAqGirSmhXOED5Qe7OgdTR1g5/D3g0rZ0+bDkvMtKiYRlClQr
         feaiJl6uTp1OorCyRo79Xt3/C1MM7iLAMEH5r2zOcXoXfYWqegtWzbHdvwfOriCT1Cb4
         FXHg==
X-Forwarded-Encrypted: i=1; AFNElJ96XkiLyW1Lvg5iUFoRsBoMoUb3olTzMegTNsbJl3CZPNbe1Yn/duJnQwuuhScCMMXKOzLwHii9VfFWaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRmIl7S0JtkfpYLFKlwyPAH692mcZOtiICNow2FQStRHml8oY
	ioagfPLjQ5JhyAKsriUtUdZdpd0RqxWt8J2PzTX8gyVO4RMlEFPPjKP+
X-Gm-Gg: Acq92OFJhRlnlkwx5P/xGYthZAXIAmz4w48qLLTORmZTmB3qWUwo75ROFg4i+Py06fC
	z2m9jq6KbCeTYQxorUgGKMr2jjywBMfvh3zm1KL2jgzBaYPbHDi6f2eYGRv/9kSrrfiJtf0ps6b
	hoLRP9tC2V/wyF1fXAz1rkM7kwKvxGifWNEIW7BLw+eZQVT6iN+ZZN2JXtgF9YSzX31cT3MqVZD
	ccwNh4P38KrjGVY+HSwFSqvbEk1DKqcd+2mSzbp+HXepU+/vylDgGppYbhlGlrn0klOjSa67zlu
	3/nlDTDxuQHMD9/mXWwQrZhnAqJuUzjHt/jolKV3wmp/b/Yd8LMwOQfz9hlZMtD3wuIuBpzkF2j
	WZX41PWtrMGwzN9iToXodqCXy9i/B16wvMWxa30lVOwclrcpm7NMR90LlZq8CbBJcU/oncq/JGp
	fJZBGgd+NCLjUPGTwAgZl1
X-Received: by 2002:a17:90a:e70d:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-37c2bc73c79mr11726358a91.8.1781533312731;
        Mon, 15 Jun 2026 07:21:52 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7178233a91.2.2026.06.15.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:21:52 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] Input: cap11xx - refactor code for better CAP1114 support.
Date: Mon, 15 Jun 2026 22:20:33 +0800
Message-ID: <20260615142103.352163-8-jerrysteve1101@gmail.com>
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
index 3d75c0f90752..2e9382a721e9 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -5,6 +5,7 @@
  * (c) 2014 Daniel Mack <linux@zonque.org>
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -35,7 +36,6 @@
 #define CAP11XX_REG_LED_DUTY_CYCLE_4	0x93
 
 #define CAP11XX_REG_LED_DUTY_MAX_MASK	(0xf0)
-#define CAP11XX_REG_LED_DUTY_MAX_MASK_SHIFT	(4)
 #define CAP11XX_REG_LED_DUTY_MAX_VALUE	(15)
 
 #define CAP11XX_REG_PRODUCT_ID		0xfd
@@ -76,10 +76,14 @@ struct cap11xx_priv {
 
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
@@ -204,8 +208,8 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 	}
 
 	if (!of_property_read_u32_array(node, "microchip,input-threshold",
-					priv->thresholds, priv->model->num_channels)) {
-		for (i = 0; i < priv->model->num_channels; i++) {
+					priv->thresholds, priv->model->num_sensor_thresholds)) {
+		for (i = 0; i < priv->model->num_sensor_thresholds; i++) {
 			if (priv->thresholds[i] > 127) {
 				dev_err(dev, "Invalid input-threshold value %u\n",
 					priv->thresholds[i]);
@@ -279,10 +283,12 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
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
@@ -301,7 +307,7 @@ static irqreturn_t cap11xx_thread_func(int irq_num, void *data)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_read(priv->regmap, CAP11XX_REG_SENSOR_INPUT, &status);
+	ret = regmap_read(priv->regmap, priv->model->sensor_input_reg_base, &status);
 	if (ret < 0)
 		goto out;
 
@@ -355,7 +361,7 @@ static int cap11xx_led_set(struct led_classdev *cdev,
 	 * 0 (OFF) and 1 (ON).
 	 */
 	return regmap_update_bits(priv->regmap,
-				  CAP11XX_REG_LED_OUTPUT_CONTROL,
+				  priv->model->led_output_control_reg_base,
 				  BIT(led->reg),
 				  value ? BIT(led->reg) : 0);
 }
@@ -367,6 +373,7 @@ static int cap11xx_init_leds(struct device *dev,
 	struct cap11xx_led *led;
 	int cnt = of_get_child_count(node);
 	int error;
+	u32 duty_val;
 
 	if (!num_leds || !cnt)
 		return 0;
@@ -380,15 +387,18 @@ static int cap11xx_init_leds(struct device *dev,
 
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
 
@@ -553,41 +563,64 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
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

