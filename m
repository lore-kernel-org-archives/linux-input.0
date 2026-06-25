Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897537B03E
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375512; cv=none; b=T97aBMG6EfH1Yby2BZTxsA/NYuGFr9adUg5rykt0752Astjq5XnnkimXJFLBks5uciiI48R4tY3LzEtSJfj8P7nKBfJGxQR/T6STHdTAtVL3h+M8O+fLFIaB/va236r9sKncFekLhEc6nv+1Vw6UUsv3NrKdml97rLaaTqio6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375512; c=relaxed/simple;
	bh=RIfTQDHCQ2YqnNoaJ2ewpxoWS8B+PH190RGJwefZxN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVwxXPimwctF+Su/IokeyKXHO/DMmZ5qFm2Ruztj/s9kpE6EiEXwJqiYI6WZMjzr50cEs0UqMHhHe0xcm4ob1CMkQJC6VkZ80rynxWmNz8DA6nXIqU0cmpcR6XQasqruCaB5wW0GylGkXxh/ldb74q4pZrNyoISt973o9IoF8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciwaEA5c; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciwaEA5c"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3967738c801so16750231fa.2
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375508; x=1782980308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODwRsMFDaNCx2SgXogkfXBT7irmxGG50JjasciSXEuM=;
        b=ciwaEA5c5sw43QjzYeQ87y6CG8XDJ7XAGUp7Aa8nRgSWTjonvgM5Osr7wNjuoKnsgn
         OO8Agb5nhdXkQD3WQrehzFFZOMQsgOLlkbNvfc2rGqmYfwqasgbGkk7bImrPWDhfgAid
         dnvCGS7FBuwJHtYnhXtVBnnai1lGcJahWuegCjZ5J8WFbfcqFydqXhdAVNdNFIsSPmL6
         U997Fb+T+BRHVn43wSlkDUQl79QPg3CTTEWfT+BKLVcx8K6CZuliwycsfRmchF+LHkV9
         hJW8KyyzFxYrLe1TeL1A1deHForlKu4ct8m+z5XoD1rFPXnxEGGaP0plTYgSV0gYLuNo
         o5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375508; x=1782980308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODwRsMFDaNCx2SgXogkfXBT7irmxGG50JjasciSXEuM=;
        b=ojbSt+4k7/P2PAsmufrla80S7CA1lHsIB7it6LuOeLIwzVoXmuZO2pN5gMQ5I56cGe
         X4RhKVJFjKoEqyJzBIEpikj683E8JYdgkmpA/10awLxAMDwJUUqWVzv3wN9YPwGc32rM
         VpBWgmkNMRqXQs9bNBslEKma0TNBOdFiTYMFSL3xkzEYrQ+c1pDQSo+Q8FX2CafTYGmV
         /iFSbj45oKODuUoZxuZOOPHEd4mnslVSWE0hSXt1yuOM2UM2AlXLIv8u2nbvG7370+rd
         7M9UfG4SaTwwsGyMTjYdlKMjAoxOICeRwnBCizbvETr7yu+ptSlrOC80f9OIjN6h+CFf
         KWpw==
X-Gm-Message-State: AOJu0YyVKQV4XHdjiERN56hAvCpOBbBb1xFJlgK1KDReKjiIO8D/B+EJ
	+hfl451z2S2dUx/tdY7IfP+rb16ZpF+MGdUBQ4wTAR0DJ9U4fEYleuKt
X-Gm-Gg: AfdE7cmmbsbszHyCm0FgFVMnOolvYAxED2VC6Ozj+Oauq7S0vvW8uRbgLcxLIlJdebv
	TaJmT2nndMAbW3JjqmoQOD7+T/jyCr1ex6BEm9GK7vAqC2WVjbdGL+jZ4XR7h0ZJeVEEG10do03
	SUC9fGo0qEw8bdrutrinnKLwxtTObNPj0gT1ZVomCaJwN5vBJMWw5VR6uH+zN/OkPkz4GnldNvz
	2rdDc1V/4oR4HZXFvz02eCnsJ3Oou0/jHsuDysfSXQkLveJL0FIswzLiCeOnbjT56t8PZXe4gvp
	oBMA68d25MsNSexsXvr+sGDyJpNzxceZeDD2gBXa+oFloUzB5j6WM6iBbVYP12hjAemwXA50jMh
	HlKgTuAxYWrHrPiDPlpfgHKZqPuAn78eDQ3RegVtXDot/lsQMiQL0g9rKtgqTcSxm4jrJ9UYSAY
	bXDSg6cfdi+6ZSADPg704NYrFxgszS0Gwz0w==
X-Received: by 2002:a05:6512:20da:b0:5ae:a021:6b37 with SMTP id 2adb3069b0e04-5aea1f648edmr287243e87.40.1782375508090;
        Thu, 25 Jun 2026 01:18:28 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a268sm2464601e87.38.2026.06.25.01.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:18:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v6 5/6 RESEND] mfd: motorola-cpcap: diverge configuration per-board
Date: Thu, 25 Jun 2026 11:18:11 +0300
Message-ID: <20260625081812.33474-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625081812.33474-1-clamor95@gmail.com>
References: <20260625081812.33474-1-clamor95@gmail.com>
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

Create a common and default subdevice composition, rename edit existing
subdevice composition into cpcap_mapphone_devices since it targets mainly
Mapphone board.

Removed st,6556002 as it is no longer applicable to all cases and
duplicates motorola,cpcap, which is used as the default composition.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/motorola-cpcap.c       | 125 +++++++++++++++--------------
 include/linux/mfd/motorola-cpcap.h |   6 ++
 2 files changed, 70 insertions(+), 61 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index d8243b956f87..5b6ca6b81c23 100644
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
@@ -241,62 +229,58 @@ static int cpcap_resume(struct device *dev)
 
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
+static const struct mfd_cell cpcap_common_devices[] = {
+	MFD_CELL_OF("cpcap_battery", NULL, NULL, 0, 0, "motorola,cpcap-battery"),
+	MFD_CELL_OF("cpcap-rtc", NULL, NULL, 0, 0, "motorola,cpcap-rtc"),
+	MFD_CELL_OF("cpcap-pwrbutton", NULL, NULL, 0, 0, "motorola,cpcap-pwrbutton"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 0, "motorola,cpcap-led-red"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 1, "motorola,cpcap-led-green"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 2, "motorola,cpcap-led-blue"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 3, "motorola,cpcap-led-adl"),
+	MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpcap-led-cp"),
+	MFD_CELL_NAME("cpcap-codec"),
+};
+
+static const struct mfd_cell cpcap_default_devices[] = {
+	MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,cpcap-adc"),
+	MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0, "motorola,cpcap-regulator"),
+	MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0, "motorola,cpcap-usb-phy"),
+};
+
+static const struct mfd_cell cpcap_mapphone_devices[] = {
+	MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-adc"),
+	MFD_CELL_OF("cpcap-charger", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-charger"),
+	MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-regulator"),
+	MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0, "motorola,mapphone-cpcap-usb-phy"),
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
+
+	switch (cpcap->variant) {
+	case CPCAP_DEFAULT:
+		cells = cpcap_default_devices;
+		num_cells = ARRAY_SIZE(cpcap_default_devices);
+		break;
+	case CPCAP_MAPPHONE:
+		cells = cpcap_mapphone_devices;
+		num_cells = ARRAY_SIZE(cpcap_mapphone_devices);
+		break;
+	default:
+		return dev_err_probe(&spi->dev, -ENODEV,
+				     "Unknown device %d\n", cpcap->variant);
+	}
+
 	cpcap->spi = spi;
 	spi_set_drvdata(spi, cpcap);
 
@@ -331,10 +315,29 @@ static int cpcap_probe(struct spi_device *spi)
 	spi->dev.coherent_dma_mask = 0;
 	spi->dev.dma_mask = &spi->dev.coherent_dma_mask;
 
-	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
-				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(&spi->dev, 0, cpcap_common_devices,
+				   ARRAY_SIZE(cpcap_common_devices), NULL, 0, NULL);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to add common child devices\n");
+
+	return devm_mfd_add_devices(&spi->dev, 0, cells, num_cells, NULL, 0, NULL);
 }
 
+static const struct of_device_id cpcap_of_match[] = {
+	{ .compatible = "motorola,cpcap", .data = (void *)CPCAP_DEFAULT },
+	{ .compatible = "motorola,mapphone-cpcap", .data = (void *)CPCAP_MAPPHONE },
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

