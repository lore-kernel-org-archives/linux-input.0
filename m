Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62887426EA0
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398965; cv=none; b=Jca0pVH4z6TTv7Ju5tX97siFQPbJ7cGrIQ65ZMrsWnAMIDtsNKXLpjcj7u4ZAXmaDHnNvvsmJ+t0W9DvDlh83Q7BuxcNUhMiK88nj4sZ+db6J7I90uVrxapJXIpGlpPUbEyvf53JOlxwy+u/Xk85wp+m2FVVmbQ86FUoF65ryvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398965; c=relaxed/simple;
	bh=8nK7uVl6v+pSmrvFya7GHw/59U+WVNcg+DflWmg+eco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEN+aNhBdMQx4vqsJ9CIVIyM6Y/L4NLIv7mjV2oi/vjFA9bPEkTWPpqxCmOH3Xx7bRkRFpCijKtidhfoPzUnTDp6TkFz2DQ/U976SQIrZRw6ZUFcnYC1b8QmtZ/bo0gEXbcbqr4kNwzMxdZXDjHmumJdGZghfY7QKWFPuqZW2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7zx6xc9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7zx6xc9"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4362d18bb65so562792f8f.2
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2026 09:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398964; x=1771003764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ScHHa9sLB0EQxzl6BiuNkW2/FL+7zrYJQ/WJF4R+IU=;
        b=X7zx6xc9O7rzlZ9m0CQEKBgUYeuXWvRK3C5HgLT/s7eiSp8NUm/mJ4CQ1IgVMQ6VuR
         15yF41RjNRwdRyPvm0Z0fsjQrD3ypRnpSA2UTBWdWmxUw4nueWmcuC7TXBPUsLy9Ix5n
         dRO6oQTMcFLJ1ILlRZ8p//izANEovb/0RzPnm3CvNmPYLnztS8+UivYdeYMVHjKatN/r
         NscAg1/ciyUd4bR/Zd/bQVIWlKbHeAhispSpsT3j5QljZuoItgdWoQZR4HlTZTK6RLzr
         GNj05LcmYCjVek3Iy7pD4YWZ4hJ3ZqEb2XTxSwsWDxWNGxHkzn7xx+G6cpthn571whC6
         5prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398964; x=1771003764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ScHHa9sLB0EQxzl6BiuNkW2/FL+7zrYJQ/WJF4R+IU=;
        b=dYr6f1pWVPJcMpUUFhukD331IJYzmvfoiDKvNoGdDxNEWoSde/bOskernMInH2iyNp
         +sosvwiOdL7bUN8Qq3ogemcdc98BHZVFEQg8oOdI78XuER3+Sl2+psva2RVszz5s8sVO
         ZxK25lFz+tDraiKmJfWvigIRbZXvEYWWe2pd3ccsglQ1skVlJkQNpIvvKS85s5TifiUi
         pGEnfcjmKszVy72zTPESKkNDN+irCYGf1XbhV/PHa7dYs2/GSUR79sl6i4AFrHOc3Qru
         HlH7aoiw4WEkDnI6ltYk2vz/b/tKG7Emf8HvDXORKbZr1JMXpEYe/pcMkfOszpyAEsQk
         NeOw==
X-Forwarded-Encrypted: i=1; AJvYcCUERNiL7Fdn/P0dHPFKGKA+lTiNYw6+uOk69IbG9VP6bBAB9gJOW4T478h+8fMB4hTFDoQQGyzzRFyLLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynIALtb02nLadsD2XX2jTgk+Mj9AAadrCwnvbWQU4XUA7lCw/J
	cjPdLyAgwRBYxFnTYGiZPWDdzjQU3PEN3hCTkmfwTZOz4wbcNxLI0w1I
X-Gm-Gg: AZuq6aKufG6/BSG7tLXTMjmuN9QC5ym+ulrUNM4U24wa3Eudl776ytuIcKyUG8Ti1R/
	rQpeYEeZ/wk5/P3UOykDuCuESTTC4AcWPlKNyvgbCsiJ809X5oUHgQhSoLGAv5IBC6h3seFDVjr
	xkpLuTB35yMKRfpVgvLcamTsGbn2vCuz6QMKQcwP1oHktM+Xola7tfgBg5sNIx7ctLeBOsxK8io
	7chP053jsVIXSW8AIryTmtOs5Qfy6lH2IT6cejcUWU+vR3JvNujyXdyTP6Imbjvm362EO4+5Ebx
	wzGtnlnX+YxhzN4mI8IO8aWQkb9GMo7oLkGWK9fGFi9qFoI92rojCfaXw1BevGXVzjknOt6Vp3h
	Wm+iwCaybZjcXZX5X3DxfCG7qXUR9ptd8+1jWcGZ9COqKDfyQmQ2ieOq7sjnTltUE5fl2Tczixe
	8t
X-Received: by 2002:a05:6000:18a6:b0:435:e47b:e746 with SMTP id ffacd0b85a97d-43629378231mr5523391f8f.36.1770398963681;
        Fri, 06 Feb 2026 09:29:23 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:23 -0800 (PST)
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
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 10/11] mfd: motorola-cpcap: diverge configuration per-board
Date: Fri,  6 Feb 2026 19:28:44 +0200
Message-ID: <20260206172845.145407-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172845.145407-1-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
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
index d8243b956f87..bea11868e823 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
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
 
+	cpcap->cdata = device_get_match_data(&spi->dev);
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
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cpcap_of_match);
+
 static struct spi_driver cpcap_driver = {
 	.driver = {
 		.name = "cpcap-core",
-- 
2.51.0

