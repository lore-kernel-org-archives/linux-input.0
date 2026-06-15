Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1603FC5D6
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533316; cv=none; b=goa/bP76QLKlM4CbdSDRjg/XSPBh0vNkcSE1u+niZNAToJq9cLf4ayxoBnkrYSikfAxp8b/lFDYRr/brYF4bGFnqX8D4it6HOebySVohYdreQ095WT+i7THdaXUSckWtkxLJUqKiGUX/hq34jIxjMsVbEWvTefkRed9lPbNhHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533316; c=relaxed/simple;
	bh=JaKHwhukICyH5dPZSOiKrpwwVlE7rxuBQiRWxR43VdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxTL6J/yQQe2L9mcY8Iwh/Y1Tx7k3tb9K6fhPo5aYcIFDAAMztWh0x5jucexJJI0GFHzaWLZgtMqi+n/vR7GkC1IpRLSeXhggQTp3nJe3WTNwyIa8KzPuF5PVE6b0aGo1bevXddXV8YviDegU3cNGIvdWY0mzjcwpTne0kUnE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoGVhrvZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoGVhrvZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso2096592a91.0
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533308; x=1782138108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZ6t+vQ1N2wjeUqxYpz1OrcVr6JVQwoScA7P4UZko0E=;
        b=VoGVhrvZfDvC5KGlWPwO0TgoFGCOJFe1tf21RnZHlfHvWlLjS0Li1iYQU64z/aGrdG
         wylBqWAAac5EJgAImDScaj1lEIWt1L5d5kD5Ex9rliyvPWXTJjWG5H+zVsF4M4iuOM+N
         JH+Q4ghiFLNlxNZ9tOtNXH5WCb3qhox5sOhX3OMQgQYMzZJaYd8c/tktpHp7XckyfxkY
         t0U+AyOXqxyS27hV0l53yZY14Aw1m41QIgyBRN5qff0xQkUd8uAmlDdudtjH4oJCxEAT
         CBT3rL3X/9VG2OivaUypJ4i3YN4W7ICUEw2nZuYXIe0yXAgG2bjyZuPy8sBYwi2boA/C
         NRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533308; x=1782138108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZ6t+vQ1N2wjeUqxYpz1OrcVr6JVQwoScA7P4UZko0E=;
        b=UqN6LfSLp9MEmxPwZU84CkUhbNcNfJ/NeEZPIKUSZWPkEblA5qmSe/+77dmI2tGhUy
         Im8iHnJ7+oE7Ji6GDHmP+Kv0eFvcfPJDjkUahoF5UBnhSE5O5SW/338AOBiZMb845a0S
         JyMpZlrrEE610rqhmSs2cUohG7W591B+tCv8P4/azgbr2dzjtFi03V9ZoxB4fLQCJ3Rp
         9IxWeXO3h0HaROEBGNcOFpXYLPG4ltCBBU9y/UleSoYj1ugC3TFTq3fRQgUTtek+0i6R
         exJnFfAccDCRCqEmmm/1MZrAuNPfMAVPAKxJUxtH6GSTbW4gbu39MO1R8aZ8lm1K3s4F
         gkxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9E6B0NYlCtv+DlDae9HMRhTUdl9x2wFcZlW32MpsyxiX536sUtIoRrk4eUgyJOIHHwWS6c+GMeNphv8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVREcOR6NLihbEdoXM92sXK6MyJKyJ+adjxP+f0CUPcna3ZFD/
	sLwqXZl2x7Wef4LdGywLal6L4dh3D/DxHMLrA9hlBddpk0/bnrCgenXAHc/t6mV9wNTIgQ==
X-Gm-Gg: Acq92OFsGwe3XB23dnaStAAJSuO5QtagzEcDJ3fT1B+z+wXmrrXnEYbveudIlQU9RF6
	+HKpNpZJPduQMLwnr2SHK4D2Tc0m77UoXpwQEJ57k53wtbIQN0ditNt8YsCnAsa5vGPLU0B3SOs
	ODx65G2UsUNQJfdLb9m55iqxt8DFqd1B5CRUY3NyFpB+s+lxd/LiVvkoavL+GR/+B3mtlnFHOj5
	7C0UiHbUMt4pGo+JF1wCVgjiowLHF31p9ESTqK7P3SJiUSE/CZrIjr23CVXF9Xm88aNVdUnQ3I+
	JT6lFy571KDoqbkBbPOJzbtM+Jyu3NkdGLwLdEdH1iBWeNa50c9r9Yvf7uUXvGWB813sU3Z98Mf
	yE5AzNJ7KTY/dd+k5goRSBp/C4xZiIbHwyebQ9SQoHwdYZzvaztQdZA+PO9kankWKUMn2ysFLoO
	MK5Nlu4ytgmAO8qqqtKTxi
X-Received: by 2002:a17:90b:5806:b0:369:a9e8:dbf5 with SMTP id 98e67ed59e1d1-37a01e2f106mr15998613a91.3.1781533307961;
        Mon, 15 Jun 2026 07:21:47 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7178233a91.2.2026.06.15.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:21:47 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/10] Input: cap11xx - add reset gpio support
Date: Mon, 15 Jun 2026 22:20:32 +0800
Message-ID: <20260615142103.352163-7-jerrysteve1101@gmail.com>
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

Some CAP11xx devices (CAP1126/CAP1188) have a dedicated RESET pin.
Add hardware reset operation to improve device reliability and
ensure proper initialization on probe.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 686174722204..3d75c0f90752 100644
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
+#define CAP11XX_T_RST_ON_MIN_MS		400
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
@@ -452,6 +457,16 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
+	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
+				     "Failed to get 'reset' GPIO\n");
+	else if (priv->reset_gpio) {
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

