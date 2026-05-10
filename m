Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBC37F005
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778411322; cv=none; b=XSXIdLD5n+x71C6kJeEvUtWuqZErLxKNfNdqPE6/E57SXq5mIulYxnfahFJin/1BzCWuKgaAacNaKD2i+l87oZAgYjxm2u+lsW3OpOJd5+7pi8WButTsXfD+56bng14o1P8UYNwwsn7DtjIv8hxev4zT5eldIKMojpcfB/Chq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778411322; c=relaxed/simple;
	bh=h2fH+9JxaTA+3YN6pQmYivqu5WqGhmIv06d25+MV+iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGbHn0zgLmx2jBHc/ao0qqoBh+JX97BF7tX4jVlFHjYiOoKDaKsYpvJpppqicgcVn8u3UlB+kcWNmZ/zJSyMqoNwpkmBlr8LP+O+ZTZPl7NEEXlfP5mrKyz5MTq58yKYnAKK3uy6SnsefV6mopZW0SkJRdo3aXPpsVI92KbyQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+5b0IUQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+5b0IUQ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba922426c5cso601419666b.3
        for <linux-input@vger.kernel.org>; Sun, 10 May 2026 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778411317; x=1779016117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVAaYCC/b8sB/+xZoh+WsYJWpP47TuMRhFWL9RvgVCE=;
        b=l+5b0IUQ+uPWSbm85NfhamKSBdYDgPKKrMJSXSjvBkvg3/PBxQU4txKX3jSUEX8KR9
         cZCX6tyBzg+n3h2FpVObCcHDo5usft4xiBBdxOBmKhPbGIFS7+Bp/TK3O0mpVwd1dktQ
         FvMXo16AYZhQhjeEjTX9xf63SxOiCD/P7/CmeWMQa7qhSsMT/YJejteXO+1R922qal7T
         isVIOMQTFYy6hTm/8sVRsvLYZEjJe3pWwsbp5vy6f+3APCkFp2gATDdIp6P2hmD/59TN
         qGExnsOgQsrzHfCs6CT1tWchh25Gl06AY+KskG8pEFhFK7znTwsYZCeIJxPIhg0bCBtI
         lkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778411317; x=1779016117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aVAaYCC/b8sB/+xZoh+WsYJWpP47TuMRhFWL9RvgVCE=;
        b=a7hsB29hs1mFQXJuHl/2wGgI20iVQdD/5fcf6sCpnRPRQhh+5AXYSp40dqZeRYbLBk
         ov/tkBaNV6xDDsxSYd2TYHdDTCHpwcAboNBjbV9dAt0ZsvCViAEWsy80D+k8fkCT3Sbr
         ivz7IdTmANB/jX/YYuFeiBFM6yr/o4JXGjdgj9JB4t0cjsERx4mWKmeWjLTr6LbHZtFH
         BIp4XIFpsvIvNtP2PLQM0j2wU7fDwiK1JHZaCZYdD5cy5lxDc4kaLXG+pXWg9iCksrSo
         Dx0jK2xnZfygYZdPTkloyg2g59oPPBYKw6Na/NZ3/Eg8RbM1ZTUsxaGgfTWLqh7fIEbs
         zazw==
X-Gm-Message-State: AOJu0YwwxGb9cnWOFvaoC0SNUr6L2UPgukyBcuEbqlUPyO47iENYWa9y
	fFiSu9s8nIxMb9la9/8OthMZv+hwY7gdR76uwkf+OrboX0DXVhardEVY
X-Gm-Gg: Acq92OFDJX550F/8PBk8zKrD5fz73VDoW9+4ffxUdwEC3dvCqEOwhtGsYTj2xuHqi2l
	KYslhKhNmAUr/HjwkCfG4hFMDf3w7jxNLZei01C3R3PEmw3qtvSfC3bT+Efx5wVakODqtU8v7Zt
	AsODfcSZD5M3XMcDTMNSjOyhWvMWS80eIoZc0zeucojgYy2dMN+da4gLfxGbv8Wsr9Edv6Ls8h0
	LjHgj/N2GYkMMJqKMiStuv5rF6gbn/Vx/kN5+AQKKJBldSKuvPAKx6V213FccsO1xNu2kGaJtot
	0x3oICj/SQTVpFC18RX+gcQ/IThniLbBe4Rxdj1I1cEQhZcQtFqdW0FWa2v5DZCOXdOkUo/H8Qw
	cM7jU3FE+fi4t3ywM8XhqUi9n6dNBGCj04UMQ1FxeokNFYecu9K07VT/HvhW2YOsib0OfR2dgKs
	O2ALZekaMdr6t9mMaYuiL+1og=
X-Received: by 2002:a17:907:a07:b0:ba4:f501:cb8b with SMTP id a640c23a62f3a-bc56b83947fmr1184792166b.16.1778411316870;
        Sun, 10 May 2026 04:08:36 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bce7a3fcb57sm68146866b.60.2026.05.10.04.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 04:08:36 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v5 5/6] mfd: motorola-cpcap: diverge configuration per-board
Date: Sun, 10 May 2026 14:08:03 +0300
Message-ID: <20260510110804.33045-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260510110804.33045-1-clamor95@gmail.com>
References: <20260510110804.33045-1-clamor95@gmail.com>
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

Removed st,6556002 as it is no longer applicable to all cases and
duplicates motorola,cpcap, which is used as the default composition.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/motorola-cpcap.c       | 142 ++++++++++++++++-------------
 include/linux/mfd/motorola-cpcap.h |   6 ++
 2 files changed, 87 insertions(+), 61 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index d8243b956f87..f5a7fdd89dd5 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 
@@ -30,6 +31,7 @@ struct cpcap_ddata {
 	struct regmap_irq_chip_data *irqdata[CPCAP_NR_IRQ_CHIPS];
 	const struct regmap_config *regmap_conf;
 	struct regmap *regmap;
+	enum cpcap_variant variant;
 };
 
 static int cpcap_sense_irq(struct regmap *regmap, int irq)
@@ -195,20 +197,6 @@ static int cpcap_init_irq(struct cpcap_ddata *cpcap)
 	return 0;
 }
 
-static const struct of_device_id cpcap_of_match[] = {
-	{ .compatible = "motorola,cpcap", },
-	{ .compatible = "st,6556002", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, cpcap_of_match);
-
-static const struct spi_device_id cpcap_spi_ids[] = {
-	{ .name = "cpcap", },
-	{ .name = "6556002", },
-	{},
-};
-MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
-
 static const struct regmap_config cpcap_regmap_config = {
 	.reg_bits = 16,
 	.reg_stride = 4,
@@ -241,62 +229,76 @@ static int cpcap_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
 
-static const struct mfd_cell cpcap_mfd_devices[] = {
-	{
-		.name          = "cpcap_adc",
-		.of_compatible = "motorola,mapphone-cpcap-adc",
-	}, {
-		.name          = "cpcap_battery",
-		.of_compatible = "motorola,cpcap-battery",
-	}, {
-		.name          = "cpcap-charger",
-		.of_compatible = "motorola,mapphone-cpcap-charger",
-	}, {
-		.name          = "cpcap-regulator",
-		.of_compatible = "motorola,mapphone-cpcap-regulator",
-	}, {
-		.name          = "cpcap-rtc",
-		.of_compatible = "motorola,cpcap-rtc",
-	}, {
-		.name          = "cpcap-pwrbutton",
-		.of_compatible = "motorola,cpcap-pwrbutton",
-	}, {
-		.name          = "cpcap-usb-phy",
-		.of_compatible = "motorola,mapphone-cpcap-usb-phy",
-	}, {
-		.name          = "cpcap-led",
-		.id            = 0,
-		.of_compatible = "motorola,cpcap-led-red",
-	}, {
-		.name          = "cpcap-led",
-		.id            = 1,
-		.of_compatible = "motorola,cpcap-led-green",
-	}, {
-		.name          = "cpcap-led",
-		.id            = 2,
-		.of_compatible = "motorola,cpcap-led-blue",
-	}, {
-		.name          = "cpcap-led",
-		.id            = 3,
-		.of_compatible = "motorola,cpcap-led-adl",
-	}, {
-		.name          = "cpcap-led",
-		.id            = 4,
-		.of_compatible = "motorola,cpcap-led-cp",
-	}, {
-		.name          = "cpcap-codec",
-	}
+static const struct mfd_cell cpcap_default_mfd_devices[] = {
+	MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,cpcap-adc"),
+	MFD_CELL_OF("cpcap_battery", NULL, NULL, 0, 0,
+		    "motorola,cpcap-battery"),
+	MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0,
+		    "motorola,cpcap-regulator"),
+	MFD_CELL_OF("cpcap-rtc", NULL, NULL, 0, 0, "motorola,cpcap-rtc"),
+	MFD_CELL_OF("cpcap-pwrbutton", NULL, NULL, 0, 0,
+		    "motorola,cpcap-pwrbutton"),
+	MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0,
+		    "motorola,cpcap-usb-phy"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 0, "motorola,cpcap-led-red"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 1, "motorola,cpcap-led-green"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 2, "motorola,cpcap-led-blue"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 3, "motorola,cpcap-led-adl"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpcap-led-cp"),
+	MFD_CELL_NAME("cpcap-codec"),
+};
+
+static const struct mfd_cell cpcap_mapphone_mfd_devices[] = {
+	MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0,
+		    "motorola,mapphone-cpcap-adc"),
+	MFD_CELL_OF("cpcap_battery", NULL, NULL, 0, 0,
+		    "motorola,cpcap-battery"),
+	MFD_CELL_OF("cpcap-charger", NULL, NULL, 0, 0,
+		    "motorola,mapphone-cpcap-charger"),
+	MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0,
+		    "motorola,mapphone-cpcap-regulator"),
+	MFD_CELL_OF("cpcap-rtc", NULL, NULL, 0, 0, "motorola,cpcap-rtc"),
+	MFD_CELL_OF("cpcap-pwrbutton", NULL, NULL, 0, 0,
+		    "motorola,cpcap-pwrbutton"),
+	MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0,
+		    "motorola,mapphone-cpcap-usb-phy"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 0, "motorola,cpcap-led-red"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 1, "motorola,cpcap-led-green"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 2, "motorola,cpcap-led-blue"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 3, "motorola,cpcap-led-adl"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpcap-led-cp"),
+	MFD_CELL_NAME("cpcap-codec"),
 };
 
 static int cpcap_probe(struct spi_device *spi)
 {
 	struct cpcap_ddata *cpcap;
+	const struct mfd_cell *cells;
+	unsigned int num_cells;
 	int ret;
 
 	cpcap = devm_kzalloc(&spi->dev, sizeof(*cpcap), GFP_KERNEL);
 	if (!cpcap)
 		return -ENOMEM;
 
+	cpcap->variant = (enum cpcap_variant)spi_get_device_match_data(spi);
+	if (!cpcap->variant)
+		return -ENODEV;
+
+	switch (cpcap->variant) {
+	case CPCAP_DEFAULT:
+		cells = cpcap_default_mfd_devices;
+		num_cells = ARRAY_SIZE(cpcap_default_mfd_devices);
+		break;
+	case CPCAP_MAPPHONE:
+		cells = cpcap_mapphone_mfd_devices;
+		num_cells = ARRAY_SIZE(cpcap_mapphone_mfd_devices);
+		break;
+	default:
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "Unknown device %d\n", cpcap->variant);
+	}
+
 	cpcap->spi = spi;
 	spi_set_drvdata(spi, cpcap);
 
@@ -331,10 +333,28 @@ static int cpcap_probe(struct spi_device *spi)
 	spi->dev.coherent_dma_mask = 0;
 	spi->dev.dma_mask = &spi->dev.coherent_dma_mask;
 
-	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
-				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
+	return devm_mfd_add_devices(&spi->dev, 0, cells, num_cells, NULL, 0, NULL);
 }
 
+static const struct of_device_id cpcap_of_match[] = {
+	{
+		.compatible = "motorola,cpcap",
+		.data = (void *)CPCAP_DEFAULT
+	}, {
+		.compatible = "motorola,mapphone-cpcap",
+		.data = (void *)CPCAP_MAPPHONE
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cpcap_of_match);
+
+static const struct spi_device_id cpcap_spi_ids[] = {
+	{ "cpcap", CPCAP_DEFAULT },
+	{ "mapphone-cpcap", CPCAP_MAPPHONE },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
+
 static struct spi_driver cpcap_driver = {
 	.driver = {
 		.name = "cpcap-core",
diff --git a/include/linux/mfd/motorola-cpcap.h b/include/linux/mfd/motorola-cpcap.h
index 981e5777deb7..1a85b06272c8 100644
--- a/include/linux/mfd/motorola-cpcap.h
+++ b/include/linux/mfd/motorola-cpcap.h
@@ -25,6 +25,12 @@
 #define CPCAP_REVISION_2_0	0x10
 #define CPCAP_REVISION_2_1	0x11
 
+enum cpcap_variant {
+	CPCAP_DEFAULT = 1,
+	CPCAP_MAPPHONE,
+	CPCAP_MAX
+};
+
 /* CPCAP registers */
 #define CPCAP_REG_INT1		0x0000	/* Interrupt 1 */
 #define CPCAP_REG_INT2		0x0004	/* Interrupt 2 */
-- 
2.51.0

