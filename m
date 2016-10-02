From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v7 2/5] iio: adc: mxs-lradc: Add support for adc driver
Date: Sun,  2 Oct 2016 16:15:46 +0200
Message-ID: <645df80f346859a1830c33f4eba81677525a39a4.1475416202.git.ksenija.stanojevic@gmail.com>
References: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36136 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbcJBOQB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 2 Oct 2016 10:16:01 -0400
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
References: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>

Add support for sixteen-channel 12-bit resolution ADC and its functions,
which include general-purpose ADC readings, battery voltage measurement,
and die temperature measurement.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
---
Changes in v7:
 - none

Changes in v6:
 - update copyright

Changes in v5:
 - add field void __iomem *base to struct mxs_lradc_adc
 - change arguments in all functions for accessing I/O memory
   to follow the previous change.
 - use devm_ioremap for mapping I/O memory

Changes in v4:
 - update copyright
 - use platform_get_irq_byname
 - use irq_of_parse_and_map

Changes in v3:
 - make buffer large enough for timestamps
 - remove unnecessary blank lines

Changes in v2:
 - improve commit message
 - do not change spacing in Kconfig
 - impove formating
 - remove wrapper show_scale_avail
 - use correct syntax for comments
 - use devm_iio_trigger_alloc
 - do not allocate buffer dynamically
 - use iio_device_claim_*_mode helpers
 - add spinlock in struct mxs_lradc_ts to enable locking in interrupt handler
 - only grab irqs that are relevant to adc
 - remove blank line at the end of the file
 - change licence to GPL
 - add copyright

 drivers/iio/adc/Kconfig  | 13 +++++++++++++
 drivers/iio/adc/Makefile |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7edcf32..6414397 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -207,6 +207,19 @@ config EXYNOS_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called exynos_adc.
 
+config MXS_LRADC_ADC
+	tristate "Freescale i.MX23/i.MX28 LRADC ADC"
+	depends on MFD_MXS_LRADC
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for the ADC functions of the
+	  i.MX23/i.MX28 LRADC. This includes general-purpose ADC readings,
+	  battery voltage measurement, and die temperature measurement.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mxs-lradc-adc.
+
 config FSL_MX25_ADC
 	tristate "Freescale MX25 ADC driver"
 	depends on MFD_MX25_TSADC
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7a40c04..e62ebeb 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
+obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
 obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
-- 
1.9.1

