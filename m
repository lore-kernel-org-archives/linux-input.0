Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167763FE343
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301407; cv=none; b=N4+3gEahgW5bbo3KvP4o0iRTnUMI2miVehKFJp71JrCFJC3OYZqSZv9ELxpCn3KRQIm5gRt8llP0D33O2vGGaMFX4RYJdJIagVnhk0arFywah7hR9o2tph/RVFLtXOx6qKPNKClghbeQEWASYxRDamXEkqnSo46acdDGWHKUyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301407; c=relaxed/simple;
	bh=RIfTQDHCQ2YqnNoaJ2ewpxoWS8B+PH190RGJwefZxN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4YegWLDmfwQWn24cFwwCWPYahCvjyGYxLMvDmcH6sAhO96ow0AjAa9eMHXgRhAJvm5WOcer7IPpbr1JEqCFvYuZXW9EWFaiRIsLA5sY70yn+lDNAQjXp2zdYsA+5t7oWTKAIOoLKGLzK5FBqF97UoOrp1F/vTV4aRIDa6q14JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7JDCgZW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7JDCgZW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49021532ebdso21106095e9.2
        for <linux-input@vger.kernel.org>; Wed, 20 May 2026 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779301402; x=1779906202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODwRsMFDaNCx2SgXogkfXBT7irmxGG50JjasciSXEuM=;
        b=j7JDCgZWMbfezpZQSKIglKcmm6N0Vj7F73wRUMn9+KwyHHnIr2G2m/uvdyx6m0oBSr
         RBV5dOsAsbePTf0rjyP/Ur32qxrtKeeCMv2aGnuwFouHNptpt3AB+ITye5EQM7FPetki
         G7uP2Yfq0IgAqVVZ8e9Sd5RNXqwhmp424vYwgKFQh5AmSR9FHjRBFF4aSHkuX/tMgWhZ
         VxSQX6RxPnmswtGCXpM4YM8O5pajjKxWZGxHPy9Ht3MzWgdZZhTPvM8KhyLPWJ2iTEz/
         dD53qRBGio+TD0YcZO0luX8R1BUkuQ06kU7lZCPneCRT7sqicimGeYWzumETl03svzc/
         yX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779301402; x=1779906202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODwRsMFDaNCx2SgXogkfXBT7irmxGG50JjasciSXEuM=;
        b=V6wR2RCY9cR3P2t5033eIw8uj97wvexMduxRkc6h/VLvuZ0GDj2vliJ2mY3RFGOdAg
         ew5E07DwbarsjqpMc01HIZeR3OhsEuWc9xFnwTXF3wpm6yB/ukiNyoMVUqY7+5NfI/Ef
         J4bYedRxTkTBcOwsyp1PAlO9ygIF1ycI32AsPEi4mgiOSehh8XVPxvSzkOlc3x5w0RRH
         bz2NjECc1tAuV2QagWJeWi/GKm1OS+ca/Avnl8tMO1ixJ1UfIx9X1LC3xPVGXtSFkHdC
         3rDRIApqGlt4JEYX4MViST170U3X8XUgqOCDKoRXMdlpX4y7VJBwDXGboAjhZtiDO8iU
         yRqQ==
X-Gm-Message-State: AOJu0Yz+L7MYDJf35JVWsNqb+PEo226XNVFCkAaNIG090jim18kETrmf
	B2lCkLPr9QK6pjRbwcD7EhLeYDbXpUfyxWrA4WdEw8DugSsW9w9HM/TN
X-Gm-Gg: Acq92OF0/mIGuY8bCzW/+RHf0/unBkPz8B1nCp40n11ZOwOHBglVCj/t5n+6GNid91Q
	BVFDnvx155n5fEkqvYe65chzP+EV5JYJPjxOyuYkOFk2GzXjRa0CjljpDR9HJPv0lsjkD9oRQC8
	53QSDU65el6xtjLZAsgkJYSySoB7bjBJSg5QPrXl/NZoDcxzNhUcKPPMtAVFlNUsVQ0Rlug+i+7
	JlummZds3z98W6XkA+KUfpHGopUD0d7lEPOJHaZXsTv6PROnxVLteZ9HYVjwYbtn/1pGtAhN6BY
	MLOhmz+Mn8vDqykeE24rFAQuVk3AUKgv9nFBOFurpIUFjEXioEzsXvOm3BZQJS/jsi4UaZgK8AZ
	Ymm4UZdOb29Zh9NZH/mvH0yuh7PxXyWUv6VxqBLFUoWgf5chL/wvnH7fKOEqkG0bogxmSpPsOiz
	6wkXqdpXrjKs16
X-Received: by 2002:a05:600c:1e24:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48fe63182a2mr389286225e9.26.1779301402152;
        Wed, 20 May 2026 11:23:22 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm51297739f8f.11.2026.05.20.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:23:21 -0700 (PDT)
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
Subject: [PATCH v6 5/6] mfd: motorola-cpcap: diverge configuration per-board
Date: Wed, 20 May 2026 21:21:23 +0300
Message-ID: <20260520182124.117863-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520182124.117863-1-clamor95@gmail.com>
References: <20260520182124.117863-1-clamor95@gmail.com>
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

