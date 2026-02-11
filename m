Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4EB358D10
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854352; cv=none; b=CBXskbDPXFu3J5URqZCuCp4XkQ872n1Dy6jsKhQah7IprnD05zQA4oqGAo5A8QkI2dMid79bqsouFrk72P7cjNDvzzUW9yHkVOaOZ/qP43FxOexO2LfIwtg0plKzKFI2elWx0ZFrnzmr49kfx7oy3sl1q2CoNgq2cRz6KK4Sd/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854352; c=relaxed/simple;
	bh=smluiKN0BkBroKTrz9m4N5dTCm1X0SdUjjPl/n1Uyc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2PZkSWunZORXAPe4LozFRUpZq6koEQh91ZhDq2ByGRfX8nTSYII0ZBkrbqkv6P1UscHGxVtD3pYdU/tO6z67fGr70hlJMSRYiSi/ETZSSaA5l76q0aRyGg2hyGf9bwTAqseQGvDTuKDy8neaAaQYhkWOn7ESoqaqs3j2kHJF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m01kCn1C; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m01kCn1C"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b884a84e622so1220594366b.1
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 15:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770854349; x=1771459149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X/CoeoR4EIyjXF/K1ZQwyzuFMjwYwOYvrjbMFyMNYI=;
        b=m01kCn1CtwlslteuEN1aY8tEWAroSf6HSUnNLhIhecpwqwseAoK956jyh1W6UGzY0a
         aU7JwRBdpexoGDoSwQbym0KfjiNERP+NfYqRefcjK3NvbXRN3OVglfpMCbvk+xGrNZMi
         uRuNGzLIjXa+CZGQn3RxCIKGlapz35LCW8BCgv6imo69KIAOVxTYS7mhxHXrxhTXAyaN
         kh4+jDO0FHrscXqb8mhKfIWKwLevdRHY5JV51D0uOFoGXvh7TnXWtfny92r2RtUjHZvK
         09ODQAyciQ0OkV81vPJGUAl51iZyiWaytPBDLkU+7MvxgJm3B+4D3DyAIdzCJGhxOx7J
         Crpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770854349; x=1771459149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9X/CoeoR4EIyjXF/K1ZQwyzuFMjwYwOYvrjbMFyMNYI=;
        b=wqhEwE3LG/5ZSckyJcqsgLXp4Y1Fb3qzmzp2Z/Qu175i3n5b9KVjuzyOH+VcfiR2sZ
         9J5GcRNJ3od8pyj1g1Iq1BQZD5745cY6vEZCw0mvHt4I2awRFxenfS1uzw4ym3wYa+U9
         khyqjiaUXUQEG4Ea3K7WNpLUa7VAM4bsQe+zQi44s5LIfUfLFiDdJfA/9nsqQx3fD2Wm
         KGecL8VeiHRQCcI4/CbZ9otVvEwbeIheHwWTic9+O2MBHCWM6dBSku8gbKtd61HRm68f
         qEXcby4z1e5MIFEfivP8g1dQ5r6RQ3cmuxaoL2DaURrHyTEEC3pNYCmh8M0TgI0dM70z
         m85A==
X-Forwarded-Encrypted: i=1; AJvYcCWYfdFMgCym2cb4IMh5EZJFQz9OQ6L3RsfthA6llYUV7d4lHRpJRJT/nf7ht/R0LULwU+ZBdVI51cLx0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkwMPVdDIIziEnd4urexN70OSgJy6WHddqfmBg6fghWnpWyZe
	WzHXIzApw1UgUdj/x9r+XJNAjp8WpYMolALsjkYi408ZA0atXdrf71q0
X-Gm-Gg: AZuq6aIcBYqd/QZvrbtYWuJViZo0zdrRHPn5Q9ImcV/3xpdWnm31Oqr6TfN1jIOKN38
	YSxK8XLf2hZcwDW0yfyXTHRKlY4zdWJO6ZXr0MN0Gt2r/cJ50OdiS2YC0Lzu3itSEaL80/OOgX0
	lDzuhTbhC6/NlAsXjE4pVj9aisM4MTOOxypIGJN8Var+ml/NsgIdVjUBeIDGk9uPTDKmcw9qQ41
	grznrOF+Rtb14t+6Jyev65nxtdqQlbYkPFjachEyj1HEJamlMKlRtmE7e6tCVCr6xT5BhFJ0NjW
	zcEHYTzVXIpj7pVxSDbtHretcjL4PEmy2hBcOG6GiM7AQoajZfAMgMAa8m9uya9FvH3asIlx6s6
	3pUDFil/rUhqfXwh0PpMSsMrg15hspaNcDg9BBdh2Rg+hGvZZnV0ey/Fpiin0zFwwSvFk+NBduE
	5a5FO6WZ9xlYvMng==
X-Received: by 2002:a17:907:e158:b0:b8f:93cc:ff05 with SMTP id a640c23a62f3a-b8f93cd31f3mr6187866b.60.1770854348635;
        Wed, 11 Feb 2026 15:59:08 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f9561f722sm1593466b.10.2026.02.11.15.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 15:59:08 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 2/5] input: drv260x: Add support for ACPI-enumerated devices
Date: Thu, 12 Feb 2026 01:46:52 +0200
Message-ID: <20260211235902.4156624-3-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211235902.4156624-1-jekhor@gmail.com>
References: <20260211235902.4156624-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ACPI ids and GPIO lookup mapping for drv2604 haptics device.
Found in Lenovo Yoga Book YB1-X91L tablet.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/input/misc/drv260x.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 18360bdfe877..f613c81fa2ba 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
+#include <linux/acpi.h>
 
 #include <dt-bindings/input/ti-drv260x.h>
 
@@ -419,6 +420,12 @@ static const struct regmap_config drv260x_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
+static const struct acpi_gpio_params enable_gpio = { 0, 0, false };
+static const struct acpi_gpio_mapping acpi_drv260x_default_gpios[] = {
+	{ "enable-gpio", &enable_gpio, 1 },
+	{ }
+};
+
 static int drv260x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -426,6 +433,14 @@ static int drv260x_probe(struct i2c_client *client)
 	u32 voltage;
 	int error;
 
+	if (has_acpi_companion(dev)) {
+		error = devm_acpi_dev_add_driver_gpios(dev, acpi_drv260x_default_gpios);
+		if (error) {
+			dev_err(dev, "can't add GPIO ACPI mapping\n");
+			return error;
+		}
+	}
+
 	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
 	if (!haptics)
 		return -ENOMEM;
@@ -484,8 +499,10 @@ static int drv260x_probe(struct i2c_client *client)
 		return error;
 	}
 
-	haptics->enable_gpio = devm_gpiod_get_optional(dev, "enable",
-						       GPIOD_OUT_HIGH);
+	haptics->enable_gpio = devm_gpiod_get_optional(dev,
+			"enable", GPIOD_OUT_HIGH);
+
+	dev_dbg(dev, "Enable gpio = 0x%p\n", haptics->enable_gpio);
 	if (IS_ERR(haptics->enable_gpio))
 		return PTR_ERR(haptics->enable_gpio);
 
@@ -606,6 +623,14 @@ static const struct i2c_device_id drv260x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, drv260x_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id drv260x_acpi_match[] = {
+	{ "DRV2604", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, drv260x_acpi_match);
+#endif
+
 static const struct of_device_id drv260x_of_match[] = {
 	{ .compatible = "ti,drv2604", },
 	{ .compatible = "ti,drv2604l", },
@@ -621,6 +646,7 @@ static struct i2c_driver drv260x_driver = {
 		.name	= "drv260x-haptics",
 		.of_match_table = drv260x_of_match,
 		.pm	= pm_sleep_ptr(&drv260x_pm_ops),
+		.acpi_match_table = ACPI_PTR(drv260x_acpi_match),
 	},
 	.id_table = drv260x_id,
 };
-- 
2.51.0

