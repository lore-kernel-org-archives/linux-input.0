Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C773C13F8
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770608; cv=none; b=nuVpmKOYxR3Oaj0ScwnUUPjJbgp+C7JttNoVgfJqk/XeaJrk+BApUX8aaiUOjmiobpyOeJgUHrXNTjPfJrRRpeLkyW0sClk0+YSLJ8Q6lGilQ7x3ixOqQrtJlEaTcoOZGjJMvOfLlIZ0BOPfjVuntfyHj5qpjbRzedfks9bSnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770608; c=relaxed/simple;
	bh=FImt+bsSj++vXBt8dl06uq7wyPYDWF8eV3nAHecKHCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Riqmlesfq7J0TiJFmslTrmXJcYbwrYFyLnthogOirGX7DTm7KYl2QC9vId+m7MdEuUI/TEzDOkX6F3N7ZcWpkj6tMBIriycmpcy5D09inc4k59DihuqB4/o03UAjMPPR1p9h7i51bnGx3H6Id7zJtLZPLhV4O0g1y+DXeK+pOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceab75934dso2296325ad.2
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 04:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770606; x=1784375406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HRFub8kSA/fS8InEMuVJNmE6mYQvQVfDODAvVSAOiMA=;
        b=EJ6ojWn8PU4zazqu60QdTIbpOTsHMIkHqDIJ5UkSO6AanIfgDwWbJsK8VYR15U6E4n
         PfyuYWU/jc1qwtnmsfLtccCvsye3dNYDUXFmErVy6QQh2/izCEqELvLFIBsMaF4k/Xar
         TRYt5syUQ7ws88fdg24guiCFE2uyvcfHXpcNWeN8UuQwiWqrbOQusDoJ2YDqGUCCgzCL
         e6VZoMFu1U+B9CbcptTNij24ZArR/tVHw1qOhu78+1o0UOor3RYAFnjLHmevslzShfoL
         0aJBadPYQXGv/6pE4i7/DsMZA911TiCcgPcIPSVRTOWOfNRgilWwv0wOMGV6FSywvyl5
         OzQQ==
X-Forwarded-Encrypted: i=1; AHgh+RraDcZGk7XZGlgdioHnLPrl7JZNVeFMV2OOg4H8DP4UhstTkxjWtiHzJ/qjQI2VTssjHvbC4RYOa/7LWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKVn0sZNPh2o058XINurJBswk7jnN/B+iuL8urBaq5H98XmpzK
	Yh4kl8pmHd+6w/g6TLa0bT9tg75a+2wjzNEFCNQkSWiW4EybY2o46aE=
X-Gm-Gg: AfdE7cm4vIOHhApTWEwzBMvjupZOXuy/kXDJTD7qD1xngCh1yNLWoYbX/znXjw+fsKO
	MCAb2k1Y/+Ww2rp9DcEugr/kmuhJGpL9slOTo1FTnwy962FkxL5XQStSxBnWrVDX3VWC3tuhJQB
	tNHTsAeNJsnTS5rZ+MJS7nS2f4AInCytILxg4GtmAeq1Vspzw3MoxGbre3eABz6OBSGNK7Wc5qU
	AjrBu+HmHSHKO6C76idb18QoSWK7BtCrOPeB4ebHFj6AuDq06sGMoIDQKouVZxQ9or3x8WImKzL
	QMLvat7XO3BHDZWg3CDyV9v6kDrxIrAHlTBY8GQIeVRnZU7YRwPAr70paLHpxvya8RLRbOowp+o
	jmd1KeyWoFC3/ycD0Eu6zN3pCiPnBBSUnwfozN29STQ+Bw/2DjDJFBV4nbFgqnysKU7qsAKt/xi
	KgXsDD97uj0CnhPBRTsOS02b1mZDaZuKbzdihy67gpubCzqzGz9z8NZUQ8nqtckuCUfGLjdLD2m
	gXNhm5uukXW7YeWR5cehQdzbQ==
X-Received: by 2002:a17:90b:3806:b0:384:5dbc:cba5 with SMTP id 98e67ed59e1d1-38dc777c6d4mr2735418a91.26.1783770606205;
        Sat, 11 Jul 2026 04:50:06 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm3957570a91.1.2026.07.11.04.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:50:05 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Shih-Yuan Lee <fourdollars@debian.org>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Sat, 11 Jul 2026 19:49:37 +0800
Message-Id: <20260711114937.16670-4-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711114937.16670-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711114937.16670-1-fourdollars@debian.org>
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
 drivers/spi/spi-pxa2xx-pci.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cae77ac18520..96bbc7a7c381 100644
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
 
-- 
2.39.5

