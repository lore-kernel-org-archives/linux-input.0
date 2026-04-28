Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A93B9D8C
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390608; cv=none; b=baUle0Yqb9WDamWhBJpG1dFcG2JOgq8fUO8NGx/EWIDUftSigzI9PQlHuNa58TD9i4DttOVVuDQj0TOxGmAav2MPJFZJNN+VjXmlYnbpckMpmW04r2pemr2WeMFonqkFpg3eaExx8RCDJVzMaNfI0zbdZjU0hg+l3pmvwF6Z+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390608; c=relaxed/simple;
	bh=Fi8+HlKnN1h+N9DJycInvz7TYXjUPCLz5vbSQaQ2Gmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1tQvPkBMnji1TLjpG1G9cvUZP4rQQ7j3stoxJA7ZyQBWIV5tRDta2BjYBXOmYZneKngmD/Y7/9UN2VN/UIop7NlAZvCGm4w+Op+nPQdYJD1rpRR7KDzGf6NDQuj/YT80hxwuwHv9epkhpOZaKrlcKxE/S84lYkpMu+i5vKUSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNSPpX7Z; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNSPpX7Z"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso89023605e9.2
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777390600; x=1777995400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX7h5kXQ2ZfXYWkWgx4GofzlTaZv8NlPbhuLaaOQgic=;
        b=lNSPpX7Zyj8nzuSKgQQJ9wEvj+wMqxuiW42LYs60PoqosAzsv1IhW3xWn64hwaK1qS
         u6ddZuqdQK4KXnlSIs2Fqjp8FO3VgqlDH6dyiQ7Y2bu7Y4+ioRxhkf45pXSCx74RWfsc
         fXP5TiS2TOiB8kURyRnRCK9jJ5UCzvbe5STue9o843m9ZiQwr3d8I6iYj5BZZImA0zVH
         X2pZsNvAV1oGmyNwoDicN9RNRQeCJKAm4puebhJInIXZeUeuiUlN47hA2MQtjjade2fO
         7t3jhY+SEIbtl69ZzIgs4S+87VyIvy+1GUbKQ922OA0cSVOlxff1xZkqZRR1y89WmW3J
         t7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390600; x=1777995400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PX7h5kXQ2ZfXYWkWgx4GofzlTaZv8NlPbhuLaaOQgic=;
        b=JlzzLA1l8/jnOjTQ05GHlRMjDxIYagVs+Fv+7DxLdeI119BncAiroCMMb0NlD0YJlU
         PKx+RYm0fDg1/4m2b2b8Ak1NbQy/qDmK0aoC4houX71trlm7VvGaateUVyPeFNZj3ikA
         Vg92tA+5I6Z/xSuj6iV2l1d1Epzgp4YpCak3pzbQg3Nttspvr26JK3lpPyS0N0FRF5P5
         3JAX5heeMenPKygyFX+/jgzP5WhErZo+UY4jtjhZ5QgP30g0R3zrR9sNVYbrvCEusZh5
         osUIvPlztLmR2rDty3Pi7CyaiHnxfwkn//WXoyYUB44hHasMmVrgxMkYuMpO2XmSaBWC
         gNBw==
X-Gm-Message-State: AOJu0Yz8nlxx/CJ3jdT9wrFn5K4WT9R5KXv/BRCB2AAcJ04CprHY4ovZ
	wzMoQXEiT2wf2OWWJcWB+mMKoL1HVDtBqH/JIN9vfziyv6X1x2Q6cNop
X-Gm-Gg: AeBDietctTYUagtjDx9UOU16KWWGA4vayE6hxaZtG9Bbkt3b6wFqqlIN/p8DdTjk+CR
	AeV+kjjElEcAMOQm+Z2EJzba+yYKgVeWip9EanKcbGq2IsxTXgAZMQ1nIBtlO377sRoy5o8tL4H
	1WaX/lya9n4qmzPm9KY8FIdooL7y4xBUH15kaLWjAXderrgRH83FdsMqi9IsW9tLQpXYcMPXeyH
	fupfNriRppf+PbQttm+J1K9SereECj5LMewblmw4N3HbLWKC9y39D0mFT73YtARk1U/WcLDMZ37
	yufaB5WXyvapMSG+IgCiRJdDoNf6o2PfdUAh+7q6evuBQp8YhR7oaZyYMvjFG0dspWK2BgRvjVC
	1+wUp0nrG2InHoQTyUxR6ceNlyIP6pgbU7UNLifnav+velbw+U8dcO/vIbq5eLti/Mz9EK6TvST
	ArMPbH91o1u08CSaUp60BMUzg=
X-Received: by 2002:a05:600c:3f16:b0:487:55c:e0c1 with SMTP id 5b1f17b1804b1-48a77b1da5emr64465875e9.14.1777390600138;
        Tue, 28 Apr 2026 08:36:40 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b56c2d0sm1358875e9.11.2026.04.28.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:36:39 -0700 (PDT)
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
Subject: [PATCH v4 5/6 RESEND] mfd: motorola-cpcap: diverge configuration per-board
Date: Tue, 28 Apr 2026 18:36:10 +0300
Message-ID: <20260428153611.142816-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428153611.142816-1-clamor95@gmail.com>
References: <20260428153611.142816-1-clamor95@gmail.com>
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
 drivers/mfd/motorola-cpcap.c | 101 ++++++++++++++++++++++++++++-------
 1 file changed, 83 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index d8243b956f87..516d1e33affa 100644
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
@@ -195,20 +202,6 @@ static int cpcap_init_irq(struct cpcap_ddata *cpcap)
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
@@ -241,7 +234,56 @@ static int cpcap_resume(struct device *dev)
 
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
@@ -285,7 +327,12 @@ static const struct mfd_cell cpcap_mfd_devices[] = {
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
@@ -297,6 +344,10 @@ static int cpcap_probe(struct spi_device *spi)
 	if (!cpcap)
 		return -ENOMEM;
 
+	cpcap->cdata = device_get_match_data(&spi->dev);
+	if (!cpcap->cdata)
+		return -ENODEV;
+
 	cpcap->spi = spi;
 	spi_set_drvdata(spi, cpcap);
 
@@ -331,10 +382,24 @@ static int cpcap_probe(struct spi_device *spi)
 	spi->dev.coherent_dma_mask = 0;
 	spi->dev.dma_mask = &spi->dev.coherent_dma_mask;
 
-	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
-				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
+	return devm_mfd_add_devices(&spi->dev, 0, cpcap->cdata->mfd_devices,
+				    cpcap->cdata->num_devices, NULL, 0, NULL);
 }
 
+static const struct of_device_id cpcap_of_match[] = {
+	{ .compatible = "motorola,cpcap", .data = &cpcap_default_data },
+	{ .compatible = "motorola,mapphone-cpcap", .data = &cpcap_mapphone_data	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cpcap_of_match);
+
+static const struct spi_device_id cpcap_spi_ids[] = {
+	{ .name = "cpcap", .driver_data = (kernel_ulong_t)&cpcap_default_data },
+	{ .name = "mapphone-cpcap", .driver_data = (kernel_ulong_t)&cpcap_mapphone_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
+
 static struct spi_driver cpcap_driver = {
 	.driver = {
 		.name = "cpcap-core",
-- 
2.51.0

