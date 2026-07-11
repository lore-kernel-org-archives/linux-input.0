Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E13C9EF6
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775518; cv=none; b=R4QL4FUMm3SwWzlraarOeqoHOSdkG/veBgq4W/fMQL+bFuduMDmJ7WN1x6c5Ei78YSY/yTMQtnUMR9rwkOWLnBhNHgcz2IztzSxmGBmHQ0nlpq1S2zI7ouaDM928t6bgVh/L9vbADJa9ZTbArsZ6eeyB931zAc3EY+x00wHFx6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775518; c=relaxed/simple;
	bh=YRU9k1lERNTxkTc+5YgTqgr3AgfJ0f+mJ5crHfuI4jE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUjMOiSI/opF2t18tcEYI5Y1r/xj+U9iawUO6N9h//gK0Ka4ValHstV1F9yoRdCrni2dL39GgVYLhX75c/qT4gOm15whBQR/5Xs+PRBkg9eoJxSLGquwy8/sQcmwsasRe4yKYWevaDtW5QKI5+50gz7/m8T9rC+KgHp3XIQ5bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so715935a91.0
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 06:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775512; x=1784380312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kc4/WVQy8fssVht4RAYrhTn5gJQpHPueTRIgj0gLJ/A=;
        b=bwEXy+GDFas3SdGJmIDEnUocKj/MBGnvTUpNQ83IrIht8E6ziAIaqtcwVP/6FXmJrz
         3I5+y5YKqUpC0KnTUaUpOLwVmHb+CqabhP16l3fzXyF4+IGRYB8gNQpWuPHZqLzMhE31
         7FLihGhkX8DftkYxc42W2LFFSNJoGrea0fdvdeoV8B9O9cvT8qtCU2ZubD5QhukhcGlM
         TXZcbkvyukvyBj5bZfTQER1rhk2cI1gZXz5nnkpreV2T4bwdRlddL92c3foAD7Nv2wyP
         fSFx1oEgoH8K6wMXORQZiWYvYq1z0syeVJF8T/uWaO5QCxpKvgJ+fxugb+rK5baQvcCM
         OaEw==
X-Gm-Message-State: AOJu0YwQGKMItpAujqmMx0Hp9r2hrYKrysnpmUiI5vcKOvDFt0a2bp0j
	pPWB1DFrV+enZKTQGu9p8oYhyID1Y6fJPdl+B8UNNStWqmoK4PcxErw=
X-Gm-Gg: AfdE7clpPM4t6kMAA0liS1GqsgXLgW8XWdu5ChN7Y0yK1FRgbvzAqgzirUCEqOuqayS
	OiIU4zQLvsCRU4vXrk72hUkR7GzAjPf1QFYHcG46FpHakoAzuLLwXrfBBy1taIKAw6sssqZdFf2
	3E42o6cxOIV0kHVisEEzxUy5ND6Vib37gxtUM67HumzG8krsDYdTEi7+FdvZ5K6nLEKSuiDEgze
	w+xt+ck53m1Rto6xLqSUxO7U13U6D6xxfSVpmlPgODzT65fPpp9zkSOQ1R0/kpsKnQij1MnaIuR
	jUIUm1CZxk0Awj/LF38xT1KJ+59jHG5gNrygzKeBiVgQVoFO9oT31ZhFVBIw9aageVhYhWpy3rg
	Td3h02vl3+AtJrF+rwMgOWSGtVOuUgL67hnfKF1YZOnCJlRvtwdCjah0RfDRhuW2v2Vyv/8LVZG
	vaFOpYSbs47HDJ+87g/24UiMoVrilSbVKTm0gMgOhVO0NS9qKvlZYwhsw04NzyGu7L8nEZsI4N4
	cCiyTqoamTM1bhrPsVRgHAGnQ==
X-Received: by 2002:a17:90b:4a81:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-38dc75e184dmr2909302a91.18.1783775512460;
        Sat, 11 Jul 2026 06:11:52 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55557f25sm4136221a91.5.2026.07.11.06.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:11:51 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v5 3/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Sat, 11 Jul 2026 21:11:40 +0800
Message-Id: <20260711131140.18777-4-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711131140.18777-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711131140.18777-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller's DMA
handshake and interrupt routing frequently fail or time out on boot,
causing the keyboard and trackpad to become unresponsive.

Avoid this architectural bug by disabling DMA and forcing the SPI
controller to use PIO mode. Move this platform/motherboard-level quirk
to the SPI host controller driver (spi-pxa2xx-pci.c) where LPSS setup
occurs, preventing layering violations, TOCTOU races, or execute-after-free
bugs in the client driver.

Additionally, introduce a `force_pio` module parameter in the PCI
host controller driver to allow other users to force PIO mode for
debugging.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cae77ac18520..31bdaa096d9e 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -18,9 +18,14 @@
 
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-dw.h>
+#include <linux/dmi.h>
 
 #include "spi-pxa2xx.h"
 
+static bool spi_pxa2xx_force_pio;
+module_param_named(force_pio, spi_pxa2xx_force_pio, bool, 0444);
+MODULE_PARM_DESC(force_pio, "Force PIO mode (disables DMA) for SPI transfers. ([0] = disabled, 1 = enabled)");
+
 #define PCI_DEVICE_ID_INTEL_QUARK_X1000		0x0935
 #define PCI_DEVICE_ID_INTEL_BYT			0x0f0e
 #define PCI_DEVICE_ID_INTEL_MRFLD		0x1194
@@ -93,6 +98,32 @@ static void lpss_dma_put_device(void *dma_dev)
 	pci_dev_put(dma_dev);
 }
 
+static const struct dmi_system_id pxa2xx_spi_pci_dmi_table[] = {
+	{
+		.ident = "Apple MacBook8,1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook8,1"),
+		},
+	},
+	{ }
+};
+
+static bool pxa2xx_spi_pci_can_dma(struct pci_dev *dev)
+{
+	if (spi_pxa2xx_force_pio) {
+		pci_info(dev, "Forcing PIO mode (disabling DMA)\n");
+		return false;
+	}
+
+	if (dmi_check_system(pxa2xx_spi_pci_dmi_table)) {
+		pci_info(dev, "MacBook8,1 detected: disabling DMA to force PIO mode\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 {
 	struct ssp_device *ssp = &c->ssp;
@@ -166,7 +197,7 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 1;
-	c->enable_dma = 1;
+	c->enable_dma = pxa2xx_spi_pci_can_dma(dev);
 	return 0;
 }
 
@@ -238,7 +269,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 8;
-	c->enable_dma = 1;
+	c->enable_dma = pxa2xx_spi_pci_can_dma(dev);
 	return 0;
 }
 
-- 
2.39.5

