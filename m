From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v8 4/8] mfd: fsl imx25 Touchscreen ADC driver
Date: Mon, 16 Nov 2015 13:01:05 +0100
Message-ID: <1447675269-8831-5-git-send-email-mpa@pengutronix.de>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33623 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbKPMB0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 07:01:26 -0500
In-Reply-To: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Denis Carikli <denis@eukrea.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <festevam@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Juergen Borleis <jbe@pengutronix.de>

This is the core driver for imx25 touchscreen/adc driver. The module
has one shared ADC and two different conversion queues which use the
ADC. The two queues are identical. Both can be used for general purpose
ADC but one is meant to be used for touchscreens.

This driver is the core which manages the central components and
registers of the TSC/ADC unit. It manages the IRQs and forwards them to
the correct components.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Denis Carikli <denis@eukrea.com>

[ensure correct ADC clock depending on the IPG clock]
Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---

Notes:
    Changes in v7:
     - Cleanup bit defines in header files to be more readable
     - Fix irq check to return with an error for irq <= 0
     - Add COMPILE_TEST in Kconfig file
    
    Changes in v5:
     - Remove ifdef CONFIG_OF as this driver is only for DT usage
     - Remove module owner
     - Add Kconfig dependencies ARCH_MX25 and OF
    
    @Jonathan Cameron:
    I left your acked-by on the patch as these were small changes. If it should be
    removed, please say so. Thanks

 drivers/mfd/Kconfig             |   9 ++
 drivers/mfd/Makefile            |   2 +
 drivers/mfd/fsl-imx25-tsadc.c   | 204 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/imx25-tsadc.h | 140 +++++++++++++++++++++++++++
 4 files changed, 355 insertions(+)
 create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
 create mode 100644 include/linux/mfd/imx25-tsadc.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4d92df6ef9fe..4222e202ad2b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -271,6 +271,15 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MX25_TSADC
+	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
+	select REGMAP_MMIO
+	depends on (SOC_IMX25 && OF) || COMPILE_TEST
+	help
+	  Enable support for the integrated Touchscreen and ADC unit of the
+	  i.MX25 processors. They consist of a conversion queue for general
+	  purpose ADC and a queue for Touchscreens.
+
 config MFD_HI6421_PMIC
 	tristate "HiSilicon Hi6421 PMU/Codec IC"
 	depends on OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a8b76b81b467..5741be88c173 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -81,6 +81,8 @@ obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
 obj-$(CONFIG_MFD_TWL4030_AUDIO)	+= twl4030-audio.o
 obj-$(CONFIG_TWL6040_CORE)	+= twl6040.o
 
+obj-$(CONFIG_MFD_MX25_TSADC)	+= fsl-imx25-tsadc.o
+
 obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
 obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
new file mode 100644
index 000000000000..e67d5ca81e10
--- /dev/null
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -0,0 +1,204 @@
+/*
+ * Copyright (C) 2014-2015 Pengutronix, Markus Pargmann <mpa@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/mfd/imx25-tsadc.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+static struct regmap_config mx25_tsadc_regmap_config = {
+	.fast_io = true,
+	.max_register = 8,
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static void mx25_tsadc_irq_handler(struct irq_desc *desc)
+{
+	struct mx25_tsadc *tsadc = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 status;
+
+	chained_irq_enter(chip, desc);
+
+	regmap_read(tsadc->regs, MX25_TSC_TGSR, &status);
+
+	if (status & MX25_TGSR_GCQ_INT)
+		generic_handle_irq(irq_find_mapping(tsadc->domain, 1));
+
+	if (status & MX25_TGSR_TCQ_INT)
+		generic_handle_irq(irq_find_mapping(tsadc->domain, 0));
+
+	chained_irq_exit(chip, desc);
+}
+
+static int mx25_tsadc_domain_map(struct irq_domain *d, unsigned int irq,
+				 irq_hw_number_t hwirq)
+{
+	struct mx25_tsadc *tsadc = d->host_data;
+
+	irq_set_chip_data(irq, tsadc);
+	irq_set_chip_and_handler(irq, &dummy_irq_chip,
+				 handle_level_irq);
+	irq_modify_status(irq, IRQ_NOREQUEST, IRQ_NOPROBE);
+
+	return 0;
+}
+
+static struct irq_domain_ops mx25_tsadc_domain_ops = {
+	.map = mx25_tsadc_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int mx25_tsadc_setup_irq(struct platform_device *pdev,
+				struct mx25_tsadc *tsadc)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_err(dev, "Failed to get irq\n");
+		return irq;
+	}
+
+	tsadc->domain = irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domain_ops,
+					      tsadc);
+	if (!tsadc->domain) {
+		dev_err(dev, "Failed to add irq domain\n");
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler(irq, mx25_tsadc_irq_handler);
+	irq_set_handler_data(irq, tsadc);
+
+	return 0;
+}
+
+static void mx25_tsadc_setup_clk(struct platform_device *pdev,
+				 struct mx25_tsadc *tsadc)
+{
+	unsigned clk_div;
+
+	/*
+	 * According to the datasheet the ADC clock should never
+	 * exceed 1,75 MHz. Base clock is the IPG and the ADC unit uses
+	 * a funny clock divider. To keep the time constant the ADC needs to do
+	 * one conversion, adapt the ADC internal clock divider to
+	 * the available IPG
+	 */
+
+	dev_dbg(&pdev->dev, "Found master clock at %lu Hz\n",
+		clk_get_rate(tsadc->clk));
+
+	clk_div = DIV_ROUND_UP(clk_get_rate(tsadc->clk), 1750000);
+	dev_dbg(&pdev->dev, "Setting up ADC clock divider to %u\n", clk_div);
+
+	/* adc clock = IPG clock / (2 * div + 2) */
+	clk_div -= 2;
+	clk_div /= 2;
+
+	/*
+	 * the ADC clock divider changes its behaviour when values below 4
+	 * are used: it is fixed to "/ 10" in this case
+	 */
+	clk_div = max_t(unsigned, 4, clk_div);
+
+	dev_dbg(&pdev->dev, "Resulting ADC conversion clock at %lu Hz\n",
+		clk_get_rate(tsadc->clk) / (2 * clk_div + 2));
+
+	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR,
+			   MX25_TGCR_ADCCLKCFG(0x1f),
+			   MX25_TGCR_ADCCLKCFG(clk_div));
+}
+
+static int mx25_tsadc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct mx25_tsadc *tsadc;
+	struct resource *res;
+	int ret;
+	void __iomem *iomem;
+
+	tsadc = devm_kzalloc(dev, sizeof(*tsadc), GFP_KERNEL);
+	if (!tsadc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	iomem = devm_ioremap_resource(dev, res);
+	if (IS_ERR(iomem))
+		return PTR_ERR(iomem);
+
+	tsadc->regs = devm_regmap_init_mmio(dev, iomem,
+					    &mx25_tsadc_regmap_config);
+	if (IS_ERR(tsadc->regs)) {
+		dev_err(dev, "Failed to initialize regmap\n");
+		return PTR_ERR(tsadc->regs);
+	}
+
+	tsadc->clk = devm_clk_get(dev, "ipg");
+	if (IS_ERR(tsadc->clk)) {
+		dev_err(dev, "Failed to get ipg clock\n");
+		return PTR_ERR(tsadc->clk);
+	}
+
+	/* setup clock according to the datasheet */
+	mx25_tsadc_setup_clk(pdev, tsadc);
+
+	/* Enable clock and reset the component */
+	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_CLK_EN,
+			   MX25_TGCR_CLK_EN);
+	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_TSC_RST,
+			   MX25_TGCR_TSC_RST);
+
+	/* Setup powersaving mode, but enable internal reference voltage */
+	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_POWERMODE_MASK,
+			   MX25_TGCR_POWERMODE_SAVE);
+	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_INTREFEN,
+			   MX25_TGCR_INTREFEN);
+
+	ret = mx25_tsadc_setup_irq(pdev, tsadc);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, tsadc);
+
+	of_platform_populate(np, NULL, NULL, dev);
+
+	return 0;
+}
+
+static const struct of_device_id mx25_tsadc_ids[] = {
+	{ .compatible = "fsl,imx25-tsadc" },
+	{ /* Sentinel */ }
+};
+
+static struct platform_driver mx25_tsadc_driver = {
+	.driver = {
+		.name = "mx25-tsadc",
+		.of_match_table = of_match_ptr(mx25_tsadc_ids),
+	},
+	.probe = mx25_tsadc_probe,
+};
+module_platform_driver(mx25_tsadc_driver);
+
+MODULE_DESCRIPTION("MFD for ADC/TSC for Freescale mx25");
+MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:mx25-tsadc");
diff --git a/include/linux/mfd/imx25-tsadc.h b/include/linux/mfd/imx25-tsadc.h
new file mode 100644
index 000000000000..7fe4b8c3baac
--- /dev/null
+++ b/include/linux/mfd/imx25-tsadc.h
@@ -0,0 +1,140 @@
+#ifndef _LINUX_INCLUDE_MFD_IMX25_TSADC_H_
+#define _LINUX_INCLUDE_MFD_IMX25_TSADC_H_
+
+struct regmap;
+struct clk;
+
+struct mx25_tsadc {
+	struct regmap *regs;
+	struct irq_domain *domain;
+	struct clk *clk;
+};
+
+#define MX25_TSC_TGCR			0x00
+#define MX25_TSC_TGSR			0x04
+#define MX25_TSC_TICR			0x08
+
+/* The same register layout for TC and GC queue */
+#define MX25_ADCQ_FIFO			0x00
+#define MX25_ADCQ_CR			0x04
+#define MX25_ADCQ_SR			0x08
+#define MX25_ADCQ_MR			0x0c
+#define MX25_ADCQ_ITEM_7_0		0x20
+#define MX25_ADCQ_ITEM_15_8		0x24
+#define MX25_ADCQ_CFG(n)		(0x40 + ((n) * 0x4))
+
+#define MX25_ADCQ_MR_MASK		0xffffffff
+
+/* TGCR */
+#define MX25_TGCR_PDBTIME(x)		((x) << 25)
+#define MX25_TGCR_PDBTIME_MASK		GENMASK(31, 25)
+#define MX25_TGCR_PDBEN			BIT(24)
+#define MX25_TGCR_PDEN			BIT(23)
+#define MX25_TGCR_ADCCLKCFG(x)		((x) << 16)
+#define MX25_TGCR_GET_ADCCLK(x)		(((x) >> 16) & 0x1f)
+#define MX25_TGCR_INTREFEN		BIT(10)
+#define MX25_TGCR_POWERMODE_MASK	GENMASK(9, 8)
+#define MX25_TGCR_POWERMODE_SAVE	(1 << 8)
+#define MX25_TGCR_POWERMODE_ON		(2 << 8)
+#define MX25_TGCR_STLC			BIT(5)
+#define MX25_TGCR_SLPC			BIT(4)
+#define MX25_TGCR_FUNC_RST		BIT(2)
+#define MX25_TGCR_TSC_RST		BIT(1)
+#define MX25_TGCR_CLK_EN		BIT(0)
+
+/* TGSR */
+#define MX25_TGSR_SLP_INT		BIT(2)
+#define MX25_TGSR_GCQ_INT		BIT(1)
+#define MX25_TGSR_TCQ_INT		BIT(0)
+
+/* ADCQ_ITEM_* */
+#define _MX25_ADCQ_ITEM(item, x)	((x) << ((item) * 4))
+#define MX25_ADCQ_ITEM(item, x)		((item) >= 8 ? \
+		_MX25_ADCQ_ITEM((item) - 8, (x)) : _MX25_ADCQ_ITEM((item), (x)))
+
+/* ADCQ_FIFO (TCQFIFO and GCQFIFO) */
+#define MX25_ADCQ_FIFO_DATA(x)		(((x) >> 4) & 0xfff)
+#define MX25_ADCQ_FIFO_ID(x)		((x) & 0xf)
+
+/* ADCQ_CR (TCQR and GCQR) */
+#define MX25_ADCQ_CR_PDCFG_LEVEL	BIT(19)
+#define MX25_ADCQ_CR_PDMSK		BIT(18)
+#define MX25_ADCQ_CR_FRST		BIT(17)
+#define MX25_ADCQ_CR_QRST		BIT(16)
+#define MX25_ADCQ_CR_RWAIT_MASK		GENMASK(15, 12)
+#define MX25_ADCQ_CR_RWAIT(x)		((x) << 12)
+#define MX25_ADCQ_CR_WMRK_MASK		GENMASK(11, 8)
+#define MX25_ADCQ_CR_WMRK(x)		((x) << 8)
+#define MX25_ADCQ_CR_LITEMID_MASK	(0xf << 4)
+#define MX25_ADCQ_CR_LITEMID(x)		((x) << 4)
+#define MX25_ADCQ_CR_RPT		BIT(3)
+#define MX25_ADCQ_CR_FQS		BIT(2)
+#define MX25_ADCQ_CR_QSM_MASK		GENMASK(1, 0)
+#define MX25_ADCQ_CR_QSM_PD		0x1
+#define MX25_ADCQ_CR_QSM_FQS		0x2
+#define MX25_ADCQ_CR_QSM_FQS_PD		0x3
+
+/* ADCQ_SR (TCQSR and GCQSR) */
+#define MX25_ADCQ_SR_FDRY		BIT(15)
+#define MX25_ADCQ_SR_FULL		BIT(14)
+#define MX25_ADCQ_SR_EMPT		BIT(13)
+#define MX25_ADCQ_SR_FDN(x)		(((x) >> 8) & 0x1f)
+#define MX25_ADCQ_SR_FRR		BIT(6)
+#define MX25_ADCQ_SR_FUR		BIT(5)
+#define MX25_ADCQ_SR_FOR		BIT(4)
+#define MX25_ADCQ_SR_EOQ		BIT(1)
+#define MX25_ADCQ_SR_PD			BIT(0)
+
+/* ADCQ_MR (TCQMR and GCQMR) */
+#define MX25_ADCQ_MR_FDRY_DMA		BIT(31)
+#define MX25_ADCQ_MR_FER_DMA		BIT(22)
+#define MX25_ADCQ_MR_FUR_DMA		BIT(21)
+#define MX25_ADCQ_MR_FOR_DMA		BIT(20)
+#define MX25_ADCQ_MR_EOQ_DMA		BIT(17)
+#define MX25_ADCQ_MR_PD_DMA		BIT(16)
+#define MX25_ADCQ_MR_FDRY_IRQ		BIT(15)
+#define MX25_ADCQ_MR_FER_IRQ		BIT(6)
+#define MX25_ADCQ_MR_FUR_IRQ		BIT(5)
+#define MX25_ADCQ_MR_FOR_IRQ		BIT(4)
+#define MX25_ADCQ_MR_EOQ_IRQ		BIT(1)
+#define MX25_ADCQ_MR_PD_IRQ		BIT(0)
+
+/* ADCQ_CFG (TICR, TCC0-7,GCC0-7) */
+#define MX25_ADCQ_CFG_SETTLING_TIME(x)	((x) << 24)
+#define MX25_ADCQ_CFG_IGS		(1 << 20)
+#define MX25_ADCQ_CFG_NOS_MASK		GENMASK(19, 16)
+#define MX25_ADCQ_CFG_NOS(x)		(((x) - 1) << 16)
+#define MX25_ADCQ_CFG_WIPER		(1 << 15)
+#define MX25_ADCQ_CFG_YNLR		(1 << 14)
+#define MX25_ADCQ_CFG_YPLL_HIGH		(0 << 12)
+#define MX25_ADCQ_CFG_YPLL_OFF		(1 << 12)
+#define MX25_ADCQ_CFG_YPLL_LOW		(3 << 12)
+#define MX25_ADCQ_CFG_XNUR_HIGH		(0 << 10)
+#define MX25_ADCQ_CFG_XNUR_OFF		(1 << 10)
+#define MX25_ADCQ_CFG_XNUR_LOW		(3 << 10)
+#define MX25_ADCQ_CFG_XPUL_HIGH		(0 << 9)
+#define MX25_ADCQ_CFG_XPUL_OFF		(1 << 9)
+#define MX25_ADCQ_CFG_REFP(sel)		((sel) << 7)
+#define MX25_ADCQ_CFG_REFP_YP		MX25_ADCQ_CFG_REFP(0)
+#define MX25_ADCQ_CFG_REFP_XP		MX25_ADCQ_CFG_REFP(1)
+#define MX25_ADCQ_CFG_REFP_EXT		MX25_ADCQ_CFG_REFP(2)
+#define MX25_ADCQ_CFG_REFP_INT		MX25_ADCQ_CFG_REFP(3)
+#define MX25_ADCQ_CFG_REFP_MASK		GENMASK(8, 7)
+#define MX25_ADCQ_CFG_IN(sel)		((sel) << 4)
+#define MX25_ADCQ_CFG_IN_XP		MX25_ADCQ_CFG_IN(0)
+#define MX25_ADCQ_CFG_IN_YP		MX25_ADCQ_CFG_IN(1)
+#define MX25_ADCQ_CFG_IN_XN		MX25_ADCQ_CFG_IN(2)
+#define MX25_ADCQ_CFG_IN_YN		MX25_ADCQ_CFG_IN(3)
+#define MX25_ADCQ_CFG_IN_WIPER		MX25_ADCQ_CFG_IN(4)
+#define MX25_ADCQ_CFG_IN_AUX0		MX25_ADCQ_CFG_IN(5)
+#define MX25_ADCQ_CFG_IN_AUX1		MX25_ADCQ_CFG_IN(6)
+#define MX25_ADCQ_CFG_IN_AUX2		MX25_ADCQ_CFG_IN(7)
+#define MX25_ADCQ_CFG_REFN(sel)		((sel) << 2)
+#define MX25_ADCQ_CFG_REFN_XN		MX25_ADCQ_CFG_REFN(0)
+#define MX25_ADCQ_CFG_REFN_YN		MX25_ADCQ_CFG_REFN(1)
+#define MX25_ADCQ_CFG_REFN_NGND		MX25_ADCQ_CFG_REFN(2)
+#define MX25_ADCQ_CFG_REFN_NGND2	MX25_ADCQ_CFG_REFN(3)
+#define MX25_ADCQ_CFG_REFN_MASK		GENMASK(3, 2)
+#define MX25_ADCQ_CFG_PENIACK		(1 << 1)
+
+#endif  /* _LINUX_INCLUDE_MFD_IMX25_TSADC_H_ */
-- 
2.6.1

