Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037748094E
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708648; cv=none; b=FaFOIJdKcBB6nkaj0CeC+b5G3QbDIGyNfPA4lRpWZTYUpTg+yTSvKkCHGV1RulyunOGMo0DZVJQ0nNLWbjLVR7a0Yh2Dgk/nf7SxvVlngU8IKveZzITzNcgp7Wj8SkgZLxaHKqTFcIjZccRMP81aK+xreIXeyo6YXG5Hm3Z4Sc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708648; c=relaxed/simple;
	bh=zNOpD/wRzwKVNbxBSxwV1LjW6Oj5E/ebK6eNpQ3MYuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b90/PR4d975NHeatHppXObhv7AMXEVvXUeJGzX9RoCPOpl1jR10uVsqUcKQqNlRM7sADOjIItQAn5e7R9X4sfM3HGuYC9DxswB8K4iiu6xbJhvafmTpxRSXB8vQ8f2jD+yi47/O8Xa5RD3zQuJ0nJ2xHPjPB3Z1NwTg8xRe2ePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7vEVCVS; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7vEVCVS"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-662ddac3174so393783d50.0
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708646; x=1782313446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFRBlbr8wUbT3bmJyvww3JgD2moWprJ0/TvqFpmrkVI=;
        b=C7vEVCVS7lHL71elNZpQBsrOwGi8HjQj+BOz1EhuFdE+hIufIyQje5z8Etk1lC3MrY
         7VWY0P7ZV2SNLD2NqvYbaD0FnujHRGYZXWo8k0biN0U8o6ydFUDw/vSz5FdQIsSffSdY
         8VmAx0j75yFU2zBby/0r+pn5oB7jv2icyvRQfHPLiZuyIZJ+dWCPlc6mFyPpRmW8BLDs
         ieRTcG2AUvMtOUUWkWNBPWYW4SwA9ug3cUs5iDov/YFEcy+DYP+RRqT8ckPGtTI12aoU
         R+WFcWhRTKMPJaWUfvUqUcSxQ6kRaT46TdKcuEcrmNrVs1DI0DOShpqOhd7Qe4x0JVE8
         5nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708646; x=1782313446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HFRBlbr8wUbT3bmJyvww3JgD2moWprJ0/TvqFpmrkVI=;
        b=l3TN2/zHsntZeNM0uPFCaagClDlbHZ9Z0793L/S1Z5E4IHxIR91rkGQgMg9Fx0Ik/8
         S5v+8GHjQ0lTM8Y4GEctwXfLaz89+0xH6lE4smBbcPPKQjIpEIpDRQr6SOhSX8EaE1T/
         N5orLgJlZ1H5mgelXihDtTKNKQxvr/nCxuJBcJbnyM3RiY38WeAA3M8lEN6MyFbdTrxP
         xCDLbUpNhLHAaYYtxEn0P+ulhLh4gqWWki1RMHE/dCp2jcqkUw5Sbm9jgZe9QrLYEqmn
         q4TM9RdIm2XpsjX0RxIYeepZ66DNt/T+4+LdUMnXg1aVPAR285XCD88whmzBb5MZfy36
         qJOg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZjNBIFao+SrmKRu5UDRf80AXGg83fasyz+NQZvNIFWMMvEDRDDrYIexbt7nNUtwB8CbaF1wAe6UlKbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXr50JV9e3agZQ6fak/tnzh9W863hWUPGfC+hLl6sQ4mDSa+p9
	CqPPRTtxWx5Uk88CLh+DnnNdMX+eaxrzJEAfVS7sDBrhy2+NbEGEGdYc
X-Gm-Gg: AfdE7clkdscpwzjMEMSutNVuUSwF105EmnGZnCCeFMtoyYFghmrmxBRcunC6JDh+oqH
	UBZlnSDFvkXDPk/ZvRcjAcit7W0XxfH+FEvPhcRZwlVHWuqDl7sFZM7eTawYZeM41MpGUivIdqK
	gCab/I93cI/jQF7nDL2WooUQ4O7R28A2Nl6tCeUOVH2mK9CcwNUGYTbJz5fswpShMd0RC+O8flZ
	27RCFjm89Bf8GzY+6WgM6pq6yJ03w4o58Kg4ULNB8kx+k2LZ+ofEkrf/ab5uFArGjVEF5SDOV+9
	qdGKcw+mDE86EEQzdsClEMkQqcFyi7aW7lDkC82nLDwp1OwGROq2v6qOV2PsDwbtCI3r7uypIZI
	NNBsw/09R1o5Nnr69UY8hpaXmxtmc6AObkAiGqIKWpijE6tfbpQz/bRe6w5b2mz9mfw5ltgA5Zg
	X4ZV1t5KbUeA==
X-Received: by 2002:a05:690e:12cc:b0:660:5c10:deed with SMTP id 956f58d0204a3-662cbc9db17mr3941324d50.55.1781708645682;
        Wed, 17 Jun 2026 08:04:05 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662b976e47csm4387677d50.20.2026.06.17.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:04:05 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/10] Input: cap11xx - add reset gpio support
Date: Wed, 17 Jun 2026 23:02:45 +0800
Message-ID: <20260617150318.753148-7-jerrysteve1101@gmail.com>
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

Some CAP11xx devices (CAP1126/CAP1188) have a dedicated RESET pin.
Add hardware reset operation to improve device reliability and
ensure proper initialization on probe.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index fae26f035186..1db4a9090705 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -5,6 +5,7 @@
  * (c) 2014 Daniel Mack <linux@zonque.org>
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -44,6 +45,9 @@
 
 #define CAP11XX_MANUFACTURER_ID	0x5d
 
+#define CAP11XX_T_RST_FILT_MIN_US	10000
+#define CAP11XX_T_RST_ON_MIN_MS		400
+
 #ifdef CONFIG_LEDS_CLASS
 struct cap11xx_led {
 	struct cap11xx_priv *priv;
@@ -56,6 +60,7 @@ struct cap11xx_priv {
 	struct regmap *regmap;
 	struct device *dev;
 	struct input_dev *idev;
+	struct gpio_desc *reset_gpio;
 	const struct cap11xx_hw_model *model;
 
 	struct cap11xx_led *leds;
@@ -459,6 +464,17 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
+	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
+				     "Failed to get 'reset' GPIO\n");
+
+	if (priv->reset_gpio) {
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

