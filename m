Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2A32692A
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348607; cv=none; b=BdTkc9nzlh+qyr+797NhyFtplLWuJmdL1xtiW1HBMr9qzVMWygNAoNxZS3Lrr8RExeNkbhYO2a+IojzyMZQqv905a5JXbNqS9f7TiksQz8EyKfS9p6G5YeVKkxQfvIbkozszLLAlCKnc5Hbv7El5JQoAsYGf6lJFYSWxO8RRaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348607; c=relaxed/simple;
	bh=/aEpFKjR+JV4pOYzDkZqOZgmIyIl0ijhVCjsZyzmokk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rB7XygHJiL5MMv+NRTooUZfgJOlR3+sPOEn2x5f2ofSG9mL+Rq7e7b50CW2FcoyfAFE5CSEZfsEuLrJGEwfJ5r0sFdEJbIoYsOzyfzp9dmYn/ZlWgjqNNLJqHWYwD3PJibUlSaegVUhQ/CkeMHnITmpSTOfreVFfisGzFwNw3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJKZ6RPz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJKZ6RPz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48049955f7fso30370365e9.0
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 05:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769348603; x=1769953403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRbIbMdeNel2KOGXl53uBpMxFpiNgiTsob/4xIgOxPM=;
        b=hJKZ6RPz2KF4dSi4muBoh04J8jp4n902LMDJU6Bm9LzmrfBn+Tgnpn4iXPextzPDaB
         VoVARJZQWu7lm1uc+82s+OiHJXG5H37tZlpj5zD8Zs3h3OJek/MnV4B7gCdU1fvrt++P
         YFI/h+3Jr1PmC3TzHfAqtGEeWVW1TSuyq2DGO8AleOvazzmc4h/4gQsrmaci9TUnUesZ
         UFMKx2mi8OPYF3oP1XyQVFWL0vkabqHVq91tgDURTCpuQ0C64eANCWJ2rzGGIzea8NHA
         E3V3TAeDS9r1OfHwab6dOQmDp2CrkgwmqlqlZZb83vaAVQo3Z+etUcPauKLP7+A52lmy
         rGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769348603; x=1769953403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRbIbMdeNel2KOGXl53uBpMxFpiNgiTsob/4xIgOxPM=;
        b=UgOiltk9D0upI8FbPipD2nOHR61BKrRjJiQOHELkLfbplVHHb3W2aO1bhWSLWZNHRe
         tseatkg4TUAKureTfRoVk7lcUo/BAgzfGC38oAVFh3vkBBpN6IzBjYZKLFEJS6bsD+q4
         luRJeiebI6+egcsSAx4wSD53u1sMaQvU8GVNVeZmTFO/jtdAcTc2YHYCljq9fvLsLxIw
         JfKTPhiNzWTEzpjWnPf53iHVaXWG9gdcft/1m5pfRFjO6SzPXtAWUoNpjJ6vKEGNJfE1
         X6JkCXf41LLDoOCPbQFx0lHbaZFMUPWeydtN1EVIHgbcgLerjgxsMXWJwubPrWSRdhqC
         dTBg==
X-Forwarded-Encrypted: i=1; AJvYcCXNYj8KFznp8Ej6vZjEaT6iUEhFzD6I86KFzDFCyBnkEpjy8hNyLWCyKTbilprEG3jrbsnqfsEIz92O8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysa7SoJB4ARRndzkagXVJUslm1anVw2RBS1b0IBvaftB4Z7151
	Ed67TPqIGjuoIm78tS+wAGw2AzTq4/oWxwiW+bu54eYyKP/tlY+xJouA
X-Gm-Gg: AZuq6aIV36UPKDBQt1kyYwX/g0bU4SK6x+ResySec1LZvHpEdPnCtKdpgVZx86GRZzn
	WrZUgQ/dHN4Cng+MgRmsPCcmu9BulTSxfxyPNHQBJATuOn6rzZ9CAz4rFfQxJv+KAU60aIJaGWc
	XSKFYKdtWWZCg8/AAiRtX5BIF0LLOoxcKo0sjoSkXBEHCLFonrfgpXbBP6TSCcJCRXVvKvAZHAO
	kgFFhQSHf354lJTRcDvGoEoLtKmwBbPm5ucgj9PbyWPToz2Zl3IRNNo93EtLuqa+qIfWiGqSKK5
	s7+zt6AynnEVJqLbSN/sAStGk12j9hWXAdHd8wzSJc641/MrgZ95oJpFm7/+KH0h6RfYIXgVQ8r
	UnnEAc7kvyiiHNyFsQsnOzhPinuJD4hrFZLCwPhMTYoptvO0o2VQMe942zge87e3RaggjYakFZm
	06
X-Received: by 2002:a05:6000:2512:b0:432:aa61:a06e with SMTP id ffacd0b85a97d-435ca1adefcmr2888121f8f.32.1769348602622;
        Sun, 25 Jan 2026 05:43:22 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v1 09/10] mfd: motorola-cpcap: diverge configuration per-board
Date: Sun, 25 Jan 2026 15:43:01 +0200
Message-ID: <20260125134302.45958-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125134302.45958-1-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MFD have rigid subdevice structure which does not allow flexible dynamic
subdevice linking. Address this by diverging CPCAP subdevice composition
to take into account board specific configuration.

Create a common default subdevice composition, rename existing subdevice
composition into cpcap_mapphone_mfd_devices since it targets mainly
Mapphone board.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/motorola-cpcap.c | 89 +++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index d8243b956f87..ebe525153c33 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 
@@ -24,10 +25,16 @@
 #define CPCAP_REGISTER_SIZE	4
 #define CPCAP_REGISTER_BITS	16
 
+struct cpcap_chip_data {
+	const struct mfd_cell *mfd_devices;
+	unsigned int num_devices;
+};
+
 struct cpcap_ddata {
 	struct spi_device *spi;
 	struct regmap_irq *irqs;
 	struct regmap_irq_chip_data *irqdata[CPCAP_NR_IRQ_CHIPS];
+	const struct cpcap_chip_data *cdata;
 	const struct regmap_config *regmap_conf;
 	struct regmap *regmap;
 };
@@ -195,16 +202,10 @@ static int cpcap_init_irq(struct cpcap_ddata *cpcap)
 	return 0;
 }
 
-static const struct of_device_id cpcap_of_match[] = {
-	{ .compatible = "motorola,cpcap", },
-	{ .compatible = "st,6556002", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, cpcap_of_match);
-
 static const struct spi_device_id cpcap_spi_ids[] = {
 	{ .name = "cpcap", },
 	{ .name = "6556002", },
+	{ .name = "mapphone-cpcap", },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
@@ -241,7 +242,56 @@ static int cpcap_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
 
-static const struct mfd_cell cpcap_mfd_devices[] = {
+static const struct mfd_cell cpcap_default_mfd_devices[] = {
+	{
+		.name          = "cpcap_adc",
+		.of_compatible = "motorola,cpcap-adc",
+	}, {
+		.name          = "cpcap_battery",
+		.of_compatible = "motorola,cpcap-battery",
+	}, {
+		.name          = "cpcap-regulator",
+		.of_compatible = "motorola,cpcap-regulator",
+	}, {
+		.name          = "cpcap-rtc",
+		.of_compatible = "motorola,cpcap-rtc",
+	}, {
+		.name          = "cpcap-pwrbutton",
+		.of_compatible = "motorola,cpcap-pwrbutton",
+	}, {
+		.name          = "cpcap-usb-phy",
+		.of_compatible = "motorola,cpcap-usb-phy",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 0,
+		.of_compatible = "motorola,cpcap-led-red",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 1,
+		.of_compatible = "motorola,cpcap-led-green",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 2,
+		.of_compatible = "motorola,cpcap-led-blue",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 3,
+		.of_compatible = "motorola,cpcap-led-adl",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 4,
+		.of_compatible = "motorola,cpcap-led-cp",
+	}, {
+		.name          = "cpcap-codec",
+	},
+};
+
+static const struct cpcap_chip_data cpcap_default_data = {
+	.mfd_devices = cpcap_default_mfd_devices,
+	.num_devices = ARRAY_SIZE(cpcap_default_mfd_devices),
+};
+
+static const struct mfd_cell cpcap_mapphone_mfd_devices[] = {
 	{
 		.name          = "cpcap_adc",
 		.of_compatible = "motorola,mapphone-cpcap-adc",
@@ -285,7 +335,12 @@ static const struct mfd_cell cpcap_mfd_devices[] = {
 		.of_compatible = "motorola,cpcap-led-cp",
 	}, {
 		.name          = "cpcap-codec",
-	}
+	},
+};
+
+static const struct cpcap_chip_data cpcap_mapphone_data = {
+	.mfd_devices = cpcap_mapphone_mfd_devices,
+	.num_devices = ARRAY_SIZE(cpcap_mapphone_mfd_devices),
 };
 
 static int cpcap_probe(struct spi_device *spi)
@@ -297,6 +352,10 @@ static int cpcap_probe(struct spi_device *spi)
 	if (!cpcap)
 		return -ENOMEM;
 
+	cpcap->cdata = of_device_get_match_data(&spi->dev);
+	if (!cpcap->cdata)
+		return -ENODEV;
+
 	cpcap->spi = spi;
 	spi_set_drvdata(spi, cpcap);
 
@@ -331,10 +390,18 @@ static int cpcap_probe(struct spi_device *spi)
 	spi->dev.coherent_dma_mask = 0;
 	spi->dev.dma_mask = &spi->dev.coherent_dma_mask;
 
-	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
-				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
+	return devm_mfd_add_devices(&spi->dev, 0, cpcap->cdata->mfd_devices,
+				    cpcap->cdata->num_devices, NULL, 0, NULL);
 }
 
+static const struct of_device_id cpcap_of_match[] = {
+	{ .compatible = "motorola,cpcap", .data = &cpcap_default_data },
+	{ .compatible = "st,6556002", .data = &cpcap_default_data },
+	{ .compatible = "motorola,mapphone-cpcap", .data = &cpcap_mapphone_data	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, cpcap_of_match);
+
 static struct spi_driver cpcap_driver = {
 	.driver = {
 		.name = "cpcap-core",
-- 
2.51.0

