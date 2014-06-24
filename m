From: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 1/6] mfd: fsl imx25 Touchscreen ADC driver
Date: Tue, 24 Jun 2014 16:46:20 +0200
Message-ID: <1403621185-9581-1-git-send-email-denis@eukrea.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

This is the core driver for imx25 touchscreen/adc driver. The module
has one shared ADC and two different conversion queues which use the
ADC. The two queues are identical. Both can be used for general purpose
ADC but one is meant to be used for touchscreens.

This driver is the core which manages the central components and
registers of the TSC/ADC unit. It manages the IRQs and forwards them to
the correct components.

Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
Changelog v3->v4:
- Added Jonathan's Ack
- ARCH_MXC Kconfigdependency removed.
- mx25_tsadc_get_regmap and mx25_tsadc_get_ipg contents have been moved
  in the caller function.
- mx25_tsadc_irq_chip has been removed.
- Register definitions are now more humain readable.
- Many other code and style cleanups.

Changelog v2->v3:
- None
---
 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |   46 ++++++
 drivers/mfd/Kconfig                                |    8 +
 drivers/mfd/Makefile                               |    2 +
 drivers/mfd/fsl-imx25-tsadc.c                      |  170 ++++++++++++++++++++
 include/linux/mfd/imx25-tsadc.h                    |  140 ++++++++++++++++
 5 files changed, 366 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
 create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
 create mode 100644 include/linux/mfd/imx25-tsadc.h

diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
new file mode 100644
index 0000000..a857af0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
@@ -0,0 +1,46 @@
+Freescale mx25 ADC/TSC multifunction device
+
+This device combines two general purpose conversion queues one used for general
+ADC and the other used for touchscreens.
+
+Required properties:
+ - compatible: Should be "fsl,imx25-tsadc".
+ - reg: Memory range of the device.
+ - interrupts: Interrupt for this device as described in
+   interrupts/interrupts.txt
+ - clocks: An 'ipg' clock defined as described in clocks/clock.txt
+ - interrupt-controller: This device is an interrupt controller. It controls
+   the interrupts of both conversion queues.
+ - #interrupt-cells: Should be '<1>'.
+ - #address-cells: Should be '<1>'.
+ - #size-cells: Should be '<1>'.
+ - ranges
+
+This device includes two conversion queues which can be added as subnodes.
+The first queue is for the touchscreen, the second for general purpose ADC.
+
+Example:
+	tscadc: tscadc@50030000 {
+		compatible = "fsl,imx25-tsadc";
+		reg = <0x50030000 0xc>;
+		interrupts = <46>;
+		clocks = <&clks 119>;
+		clock-names = "ipg";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		tsc: tcq@50030400 {
+			compatible = "fsl,imx25-tcq";
+			reg = <0x50030400 0x60>;
+			...
+		};
+
+		adc: gcq@50030800 {
+			compatible = "fsl,imx25-gcq";
+			reg = <0x50030800 0x60>;
+			...
+		};
+	};
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index af0e83f..d354547 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -183,6 +183,14 @@ config MFD_DA9063
 	  Additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_MX25_TSADC
+	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
+	select REGMAP_MMIO
+	help
+	  Enable support for the integrated Touchscreen and ADC unit of the
+	  i.MX25 processors. They consist of a conversion queue for general
+	  purpose ADC and a queue for Touchscreens.
+
 config MFD_MC13XXX
 	tristate
 	depends on (SPI_MASTER || I2C)
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 4e2bc25..34388c4 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -78,6 +78,8 @@ obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
 obj-$(CONFIG_MFD_TWL4030_AUDIO)	+= twl4030-audio.o
 obj-$(CONFIG_TWL6040_CORE)	+= twl6040.o
 
+obj-$(CONFIG_MFD_MX25_TSADC)	+= fsl-imx25-tsadc.o
+
 obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
 obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
new file mode 100644
index 0000000..cebc291
--- /dev/null
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -0,0 +1,170 @@
+/*
+ * Copyright 2014 Markus Pargmann, Pengutronix <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
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
+static void mx25_tsadc_irq_handler(u32 irq, struct irq_desc *desc)
+{
+	struct mx25_tsadc *tsadc = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_get_chip(irq);
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
+			     irq_hw_number_t hwirq)
+{
+	struct mx25_tsadc *tsadc = d->host_data;
+
+	irq_set_chip_data(irq, tsadc);
+	irq_set_chip_and_handler(irq, &dummy_irq_chip,
+				 handle_level_irq);
+	set_irq_flags(irq, IRQF_VALID);
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
+		struct mx25_tsadc *tsadc)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Failed to get irq\n");
+		return irq;
+	}
+
+	tsadc->domain = irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domain_ops,
+			tsadc);
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
+	/* Enable clock and reset the component */
+	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_CLK_EN,
+			MX25_TGCR_CLK_EN);
+	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_TSC_RST,
+			MX25_TGCR_TSC_RST);
+
+	/* Setup powersaving mode, but enable internal reference voltage */
+	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_POWERMODE_MASK,
+			MX25_TGCR_POWERMODE_SAVE);
+	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_INTREFEN,
+			MX25_TGCR_INTREFEN);
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
+#ifdef CONFIG_OF
+static const struct of_device_id mx25_tsadc_ids[] = {
+	{ .compatible = "fsl,imx25-tsadc" },
+	{ /* Sentinel */ }
+};
+#endif
+
+static struct platform_driver mx25_tsadc_driver = {
+	.driver = {
+		.name = "mx25-tsadc",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(mx25_tsadc_ids),
+	},
+	.probe = mx25_tsadc_probe,
+};
+module_platform_driver(mx25_tsadc_driver);
+
+MODULE_DESCRIPTION("MFD for ADC/TSC for Freescale mx25");
+MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:mx25-tsadc");
diff --git a/include/linux/mfd/imx25-tsadc.h b/include/linux/mfd/imx25-tsadc.h
new file mode 100644
index 0000000..207dc7b
--- /dev/null
+++ b/include/linux/mfd/imx25-tsadc.h
@@ -0,0 +1,140 @@
+#ifndef _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
+#define _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
+
+struct regmap;
+struct device;
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
+/* Register values */
+/* Queue Config register */
+#define MX25_ADCQ_MR_MASK		0xffffffff
+
+/* TGCR */
+#define MX25_TGCR_PDBTIME(x)		((x) << 25)
+#define MX25_TGCR_PDBTIME_MASK		MX25_TGCR_PDBTIME(0x7f)
+#define MX25_TGCR_PDBEN		BIT(24)
+#define MX25_TGCR_PDEN			BIT(23)
+#define MX25_TGCR_ADCCLKCFG(x)		((x) << 16)
+#define MX25_TGCR_GET_ADCCLK(x)	(((x) >> 16) & 0x1f)
+#define MX25_TGCR_INTREFEN		BIT(10)
+#define MX25_TGCR_POWERMODE_MASK	(3 << 8)
+#define MX25_TGCR_POWERMODE_SAVE	BIT(8)
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
+#define MX25_ADCQ_ITEM(item, x)	((item) >= 8 ? \
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
+#define MX25_ADCQ_CR_RWAIT_MASK	(0xf << 12)
+#define MX25_ADCQ_CR_RWAIT(x)		((x) << 12)
+#define MX25_ADCQ_CR_WMRK_MASK		(0xf << 8)
+#define MX25_ADCQ_CR_WMRK(x)		((x) << 8)
+#define MX25_ADCQ_CR_LITEMID_MASK	(0xf << 4)
+#define MX25_ADCQ_CR_LITEMID(x)	((x) << 4)
+#define MX25_ADCQ_CR_RPT		BIT(3)
+#define MX25_ADCQ_CR_FQS		BIT(2)
+#define MX25_ADCQ_CR_QSM_MASK		0x3
+#define MX25_ADCQ_CR_QSM_PD		0x1
+#define MX25_ADCQ_CR_QSM_FQS		0x2
+#define MX25_ADCQ_CR_QSM_FQS_PD	0x3
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
+#define MX25_ADCQ_SR_PD		BIT(0)
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
+#define MX25_ADCQ_CFG_IGS		BIT(20)
+#define MX25_ADCQ_CFG_NOS_MASK		(0xf << 16)
+#define MX25_ADCQ_CFG_NOS(x)		(((x) - 1) << 16)
+#define MX25_ADCQ_CFG_WIPER		BIT(15)
+#define MX25_ADCQ_CFG_YNLR		BIT(14)
+#define MX25_ADCQ_CFG_YPLL_HIGH	0
+#define MX25_ADCQ_CFG_YPLL_OFF		BIT(12)
+#define MX25_ADCQ_CFG_YPLL_LOW		(3 << 12)
+#define MX25_ADCQ_CFG_XNUR_HIGH	0
+#define MX25_ADCQ_CFG_XNUR_OFF		BIT(10)
+#define MX25_ADCQ_CFG_XNUR_LOW		(3 << 10)
+#define MX25_ADCQ_CFG_XPUL_OFF		BIT(9)
+#define MX25_ADCQ_CFG_XPUL_HIGH	0
+#define MX25_ADCQ_CFG_REFP_YP		0
+#define MX25_ADCQ_CFG_REFP_XP		BIT(7)
+#define MX25_ADCQ_CFG_REFP_EXT		(2 << 7)
+#define MX25_ADCQ_CFG_REFP_INT		(3 << 7)
+#define MX25_ADCQ_CFG_REFP_MASK	(3 << 7)
+#define MX25_ADCQ_CFG_IN_XP		0
+#define MX25_ADCQ_CFG_IN_YP		BIT(4)
+#define MX25_ADCQ_CFG_IN_XN		(2 << 4)
+#define MX25_ADCQ_CFG_IN_YN		(3 << 4)
+#define MX25_ADCQ_CFG_IN_WIPER		(4 << 4)
+#define MX25_ADCQ_CFG_IN_AUX0		(5 << 4)
+#define MX25_ADCQ_CFG_IN_AUX1		(6 << 4)
+#define MX25_ADCQ_CFG_IN_AUX2		(7 << 4)
+#define MX25_ADCQ_CFG_REFN_XN		0
+#define MX25_ADCQ_CFG_REFN_YN		BIT(2)
+#define MX25_ADCQ_CFG_REFN_NGND	(2 << 2)
+#define MX25_ADCQ_CFG_REFN_NGND2	(3 << 2)
+#define MX25_ADCQ_CFG_REFN_MASK	(3 << 2)
+#define MX25_ADCQ_CFG_PENIACK		BIT(1)
+
+#endif  /* _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_ */
-- 
1.7.9.5
