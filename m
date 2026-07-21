Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5B477E4B
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627839; cv=none; b=EPtHpwAnoyhljpCrFDPMqeTMcN+FfZwxdugSg2ILIMMYDyGHAT8CaaDmIoqqAfAosbr0bgOFPxeeLAQ4TqyJkwxlaTFrYrcjQlPuKz5hYZ7fBm4sOVKtF0jOpp0PzJQqPvD0Qd6a22G62/PLowzIeRANQP0Y4EVttdUHsNse9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627839; c=relaxed/simple;
	bh=MhwUPNMfjuHJCSf1UHEfKdnte5pvi57V4HstzTo0BU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+U1fgSzguS+cIAn3W53D/wR+GeEruzezPumuqTKXzTcQZ8EGFodIMbdSI1OnMV2YMHsW/VUXnyxkj44RWcqq4ESZulyydjOxBAzXXfgX+ZzsYbl26E4P7ucn0QOvs3rRhjzE0i9JNtB3n9Qd/kxQDQoVbcPyyv5Q9hn/ABVlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dS2OIPq5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS2OIPq5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495635a85d2so12390745e9.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627836; x=1785232636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jR/88/6hKI13+HRKV9R/SQ8C/NAaG3k0AtjMe+JTtmc=;
        b=dS2OIPq5p/R+BVzxaMFTeCw4RIuOTM/K3tpIlg779+J8jGxAhlgE4P3l+zPltWAUHf
         l81BFHaediclZgnvMtL+c/MFToKPQ/j79VypLE6zaF9ZieyNNTnsaMrd9fUM9U7ouP8O
         f8CbKvEIAR8aNAHFCb10T85Nuo86qSr56GAT/4GRjxFrOat25buY8z+srlnomGsaHnFq
         zlLcQVOTIl0XlLov49dle0OHnPPHzpctg9nkLQ+pNZSvEpylErmydz2xJexBtwc3/GET
         6F4IHsMS3CTXk3nKMitubg3+8PTBazDb/ou0jnnKYeHH7KHRs8BGB5HXmuhuC2nW3b8g
         jM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627836; x=1785232636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jR/88/6hKI13+HRKV9R/SQ8C/NAaG3k0AtjMe+JTtmc=;
        b=hiOSn6lVeBrHfi59TVYbhuzMNPnNbGlpJVsbKg74dG78QY26Mhf/el47LrcJF4wP4X
         c1ULi3+Njs50d7E4WGy8ohpGNrldVQI17Of8+vUCkRN4+L7YvwfMe4Y+Iy/veJ9bUytz
         JQ3CnybBtixP5k84/S0e+UQk9/AikoVCqEAq7H9zlqshec1zswgi13IpaHeZxbVvP6oi
         m93KjeFr7YgIn/Kzslrr5BQ0vfLpEhsa9hcKVZJNgGCOMAOxhiiyUdUMJM8Vrl+tSWJN
         z9lV9TP/MnNCxX3DsdufBvxptxJSlXeKrxPE3MAEfDb1amNjhgcoZIUMRK5GeP/GXpkm
         CKKg==
X-Gm-Message-State: AOJu0YzNflNGhIWB4RC8EL+tN8rXAcKcBdcQaTmxsfDgNNGVA5/K/7pA
	Kgukn7wU1PXvI7BUqXobIAz+rr7hGKXzJpzbphEROJNtdrjDj5cgtA61
X-Gm-Gg: AfdE7cnLxAnPSNYuilZ0cT9BT7U8AjWHPs5QwGJjkqH0jFiZRq5cSsheRKEZDgf+d1G
	Fkx0VDhScb0Sw/Q/6eXWQlEaY3CRQp24EuNcTD+fY41lDSS8RpH+cGf1XAwLZbHMCzEXGRl+eWr
	u5+4t25o3QPH23uRHS2OSuxk9yHov6kJU0QJhR5sWMbbxbxy+pp2eNHivQwEJ9t/9frXUCzcNJI
	CyHvn8nSKIMgjpOGpj1uzbVKRaw8pr0kaaoQIR+coWebJ4nyyHfs+QqddAJxPUR01gKrVE30H8e
	JIGvlOCS4al5lpu4iOojp1tbML3DqA9NMdyDbiO4PgHh0BKG/AfA8OZvsj++/vRM6iNb5W0qbna
	X50JSoLFKKFKz/7gqqAB+whycL9NUa+581ZJVFSZD1PM3QxzTyEma+/CJFYjXlE4ZVMQB2FAOa4
	3dFmyRZtYx6CYFTiN4gdpWTLLLZ25rE7WRrQ==
X-Received: by 2002:a05:600c:1987:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-49552a58960mr161034285e9.11.1784627835679;
        Tue, 21 Jul 2026 02:57:15 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954995b78dsm227476185e9.0.2026.07.21.02.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:57:15 -0700 (PDT)
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
Subject: [PATCH v7 5/6] mfd: motorola-cpcap: diverge configuration per-board
Date: Tue, 21 Jul 2026 12:56:52 +0300
Message-ID: <20260721095654.429346-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721095654.429346-1-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
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
index 4ed8704c985ab..5feb403f26101 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -11,6 +11,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 
@@ -29,6 +30,7 @@ struct cpcap_ddata {
 	struct regmap_irq_chip_data *irqdata[CPCAP_NR_IRQ_CHIPS];
 	const struct regmap_config *regmap_conf;
 	struct regmap *regmap;
+	enum cpcap_variant variant;
 };
 
 static int cpcap_sense_irq(struct regmap *regmap, int irq)
@@ -194,20 +196,6 @@ static int cpcap_init_irq(struct cpcap_ddata *cpcap)
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
-	{ .name = "cpcap" },
-	{ .name = "6556002" },
-	{ }
-};
-MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
-
 static const struct regmap_config cpcap_regmap_config = {
 	.reg_bits = 16,
 	.reg_stride = 4,
@@ -240,62 +228,58 @@ static int cpcap_resume(struct device *dev)
 
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
 
@@ -330,10 +314,29 @@ static int cpcap_probe(struct spi_device *spi)
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
+	{ .name = "cpcap", .driver_data = CPCAP_DEFAULT },
+	{ .name = "mapphone-cpcap", .driver_data = CPCAP_MAPPHONE },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
+
 static struct spi_driver cpcap_driver = {
 	.driver = {
 		.name = "cpcap-core",
diff --git a/include/linux/mfd/motorola-cpcap.h b/include/linux/mfd/motorola-cpcap.h
index 981e5777deb74..1a85b06272c8f 100644
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
2.53.0

