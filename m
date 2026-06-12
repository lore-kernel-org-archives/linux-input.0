Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CBA3D9665
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249031; cv=none; b=cLS7OmfZlYOyiaYrk7ixWVjH6IrazF2kuTWDvBHLpDc2vav6vU7D5GDY2OcvgBLwNcsH9zQiocBLxfvkPoPnxJiqJ6fmYPWVh2o0eczboGnANSyn0s+mLLeiMy/Sll1IepgDU+pGVWjtsFGCPYVJsZvKyc1YG65dm3l6GlH4F8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249031; c=relaxed/simple;
	bh=Fc/+4PqdwGhtdBZ7m3zBLmuP7DAFo9dmycNQByTX8RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIcl2anQ/1BmVto9kIP2Bjojdbr96pXiWKdFghGAdosbmVN8aW9ek5Tk7n/7YffqyZm94hSV679n/N7mUdZgfVb57DIsLjohcEaal/x2xk5TmZLGlqmGk6z7MCyc4vv47vWPAz+ZZ4wYkG9fyZJIUohlp2Ds1epCRYxIwi69TnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGJeb+iW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGJeb+iW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso5786265e9.3
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249029; x=1781853829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZsvn1rVbWMhVrGc64ydePYbA7CJBVEGhkA4pGax+L8=;
        b=MGJeb+iWPFWuFtfgeq78VVCzm0niD4USor098HSfYRH6i6LUjZuU6Zb3SJpDbPK5eJ
         5YyQk6exJP9DWKDgyLRVUq/3IoZEfLmUcgywPI01j7tjf1KR3sAYyGK9Dpd22CQwax7k
         qwD9RV0thDbDq3AGALfq+zsuJU/LaTAkR36slhVmQ7l8T6iJ2QwRAc6u1F/k12RP+xFh
         ut8y/UIyuxMcDF0I6qE2ytnMXHPZiVqL3colyxQ4ZoUqgkv1oQ7PMxiRLjPPeiTsO2tp
         gXNWLfd8M8EmjU0u0LjbGLdNhn4f3Ug4Z2sfXgM3n5EKQadwvBzHeCA4xRHrnxAtc6I2
         O3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249029; x=1781853829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EZsvn1rVbWMhVrGc64ydePYbA7CJBVEGhkA4pGax+L8=;
        b=DiWdgZKfMZ8BVMXVMBcnBnrc+X6oK4rJCNZ5oanzy4KsrQrU2/6Llr8+rt06CpAknw
         W27LigXINV6VUOr1ULkru2tBbWMOjZtmoDHwI6FBbG+oDZuax6lXhvsmK1FWVnBB+sET
         a+qPXyP01Ca2WfJ35a3moxbbdw7iad6lNQYNOLLrmrjNh5CMWg6Q7uXTnn2DDl56cLN9
         tvRd1Mb9nyXxk1jdRTnemWIcNVGtJ1aoio8GV/Z/XUTOO1qImKtQHG57oImCaqKP1TvV
         3Xktd2uVdAEWZr0g+7z9uNitBjD89nLJN27SLPBFEyzgl1tXcAgaACvDGk/k5G9bj+z3
         fhaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/eWe1TcHX/xdE1kOlr72nYfh1JpXyWlXVHGpb1DK4laiWZSgduL9N5xN27OZzrdAPmSKMjWS+bnaWOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXViFB+n3WMXGbxXkhovuXmo4jYYN8wkONy1ZwPQF9YdO7tw5B
	N0/9ZZJbkunCVQPm8JtEm8jZrS2o+HTRZp+BSQxbO85+TpFwb7wBZfFJ
X-Gm-Gg: Acq92OHHiHj90yklBODPcquvsRUNpYYmZ0fMIDm+3OzPk5ccDRWs3kEyBodRaIaSFR9
	ZC2j86N76J6mY1Pt/wk1wq1+VZWnw9EPSx0HNp33INAspjmwMzxZT11cBSbzAcG8TqFaVCMPgPs
	wrYHQqE3rtzzR+wR2CunC6lspcORI+Yqs1MENsMOyO48C/15Usyn3SIqvg3pHhg0/AAq2riknmz
	oLaW6A6/TB5gxWlaRkSBt9FnI0RaKejmRupy+BNskIoAT6zooxymQfdZCtNhhUuhXuW54Lxlk6/
	QFwjVceo0YwWdkqzbTUtnhIGTrxSCbIYe92gAWyH1e+O4KAJ9h5BQE+yJCpcv9io+7Qt5xfrV5i
	kWjJPdvO7f7Z+KopdG5Fthr3rNvaPX+X1KXTlFgMNtg4d3RbNRerbarC5iF7dDc+/jBsNfECivZ
	RNasUjlQO66PicvCbu9wIHPC1W4NeSs28q5jZvqnjiadCvqrHtHw==
X-Received: by 2002:a05:600d:6446:20b0:490:4ee0:82ff with SMTP id 5b1f17b1804b1-490ec4fe6ddmr11905945e9.27.1781249028985;
        Fri, 12 Jun 2026 00:23:48 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm28715245e9.2.2026.06.12.00.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:23:48 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] Input: cap11xx - add reset gpio support
Date: Fri, 12 Jun 2026 15:22:12 +0800
Message-ID: <20260612072237.1177304-7-jerrysteve1101@gmail.com>
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

Some CAP11xx devices (CAP1126/CAP1188) have a dedicated RESET pin.
Add hardware reset operation to improve device reliability and
ensure proper initialization on probe.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 686174722204..75746a8a2233 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -5,6 +5,7 @@
  * (c) 2014 Daniel Mack <linux@zonque.org>
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -43,6 +44,9 @@
 
 #define CAP11XX_MANUFACTURER_ID	0x5d
 
+#define CAP11XX_T_RST_FILT_MIN_US	10000
+#define CAP11XX_T_RST_ON_MIN_MS	400
+
 #ifdef CONFIG_LEDS_CLASS
 struct cap11xx_led {
 	struct cap11xx_priv *priv;
@@ -55,6 +59,7 @@ struct cap11xx_priv {
 	struct regmap *regmap;
 	struct device *dev;
 	struct input_dev *idev;
+	struct gpio_desc *reset_gpio;
 	const struct cap11xx_hw_model *model;
 
 	struct cap11xx_led *leds;
@@ -452,6 +457,17 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
+	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
+				     "Failed to get 'reset' GPIO\n");
+	if (priv->reset_gpio) {
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
+		usleep_range(CAP11XX_T_RST_FILT_MIN_US, CAP11XX_T_RST_FILT_MIN_US * 2);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
+		msleep(CAP11XX_T_RST_ON_MIN_MS);
+	}
+
 	error = regmap_read(priv->regmap, CAP11XX_REG_PRODUCT_ID, &val);
 	if (error)
 		return dev_err_probe(dev, error, "Failed to read product ID\n");
-- 
2.54.0

