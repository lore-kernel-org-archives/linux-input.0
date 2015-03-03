From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v7 5/8] iio: adc: fsl,imx25-gcq driver
Date: Tue,  3 Mar 2015 08:58:15 +0100
Message-ID: <1425369498-25541-6-git-send-email-mpa@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52362 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172AbbCCH6u (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2015 02:58:50 -0500
In-Reply-To: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>
Cc: Denis Carikli <denis@eukrea.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Markus Pargmann <mpa@pengutronix.de>

This is a conversion queue driver for the mx25 SoC. It uses the central
ADC which is used by two seperate independent queues. This driver
prepares different conversion configurations for each possible input.
For a conversion it creates a conversionqueue of one item with the
correct configuration for the chosen channel. It then executes the queue
once and disables the conversion queue afterwards.

The reference voltages are configurable through devicetree subnodes,
depending on the connections of the ADC inputs.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Denis Carikli <denis@eukrea.com>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v7:
     - Remove separate functions mx25_gcq_disable/enable_eoq() as they were used at
       only one position
     - Enforce an external reference regulator if one of the conversions uses it as
       reference. The devm_regulator_get() call was moved into
       mx25_gcq_setup_cfgs() to be able to acquire the reference regulator when
       necessary.
     - Store indio_dev as platform driver data instead of the private data. This
       was changed in probe() and remove().
    
    Changes in v6:
     - Added defines for a complete list of references in the dt binding macros

 drivers/iio/adc/Kconfig                     |   7 +
 drivers/iio/adc/Makefile                    |   1 +
 drivers/iio/adc/fsl-imx25-gcq.c             | 356 ++++++++++++++++++++++++++++
 include/dt-bindings/iio/adc/fsl-imx25-gcq.h |  18 ++
 4 files changed, 382 insertions(+)
 create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
 create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 202daf889be2..947805d03d6c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -154,6 +154,13 @@ config EXYNOS_ADC
 	  of SoCs for drivers such as the touchscreen and hwmon to use to share
 	  this resource.
 
+config FSL_MX25_ADC
+	tristate "Freescale MX25 ADC driver"
+	depends on MFD_MX25_TSADC
+	help
+	  Generic Conversion Queue driver used for general purpose ADC in the
+	  MX25. This driver supports single measurements using the MX25 ADC.
+
 config LP8788_ADC
 	tristate "LP8788 ADC driver"
 	depends on MFD_LP8788
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 0315af640866..409583975ba0 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_AT91_ADC) += at91_adc.o
 obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
 obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
 obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
+obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX1363) += max1363.o
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
new file mode 100644
index 000000000000..18c21888aa4e
--- /dev/null
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -0,0 +1,356 @@
+/*
+ * Copyright (C) 2014-2015 Pengutronix, Markus Pargmann <mpa@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ *
+ * This is the driver for the imx25 GCQ (Generic Conversion Queue)
+ * connected to the imx25 ADC.
+ */
+
+#include <dt-bindings/iio/adc/fsl-imx25-gcq.h>
+#include <linux/clk.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/imx25-tsadc.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define MX25_GCQ_TIMEOUT (msecs_to_jiffies(2000))
+
+enum mx25_gcq_cfgs {
+	MX25_CFG_XP = 0,
+	MX25_CFG_YP,
+	MX25_CFG_XN,
+	MX25_CFG_YN,
+	MX25_CFG_WIPER,
+	MX25_CFG_INAUX0,
+	MX25_CFG_INAUX1,
+	MX25_CFG_INAUX2,
+	MX25_NUM_CFGS,
+};
+
+struct mx25_gcq_priv {
+	struct regmap *regs;
+	struct completion completed;
+	unsigned int settling_time;
+	struct clk *clk;
+	int irq;
+	struct regulator *ext_vref;
+	u32 channel_vref_mv[MX25_NUM_CFGS];
+};
+
+#define MX25_CQG_CHAN(chan, id) {\
+	.type = IIO_VOLTAGE,\
+	.indexed = 1,\
+	.channel = chan,\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
+	.datasheet_name = id,\
+}
+
+static const struct iio_chan_spec mx25_gcq_channels[MX25_NUM_CFGS] = {
+	MX25_CQG_CHAN(0, "xp"),
+	MX25_CQG_CHAN(1, "yp"),
+	MX25_CQG_CHAN(2, "xn"),
+	MX25_CQG_CHAN(3, "yn"),
+	MX25_CQG_CHAN(4, "wiper"),
+	MX25_CQG_CHAN(5, "inaux0"),
+	MX25_CQG_CHAN(6, "inaux1"),
+	MX25_CQG_CHAN(7, "inaux2"),
+};
+
+static irqreturn_t mx25_gcq_irq(int irq, void *data)
+{
+	struct mx25_gcq_priv *priv = data;
+	u32 stats;
+
+	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
+
+	if (stats & MX25_ADCQ_SR_EOQ) {
+		regmap_update_bits(priv->regs, MX25_ADCQ_MR,
+				   MX25_ADCQ_MR_EOQ_IRQ, MX25_ADCQ_MR_EOQ_IRQ);
+		complete(&priv->completed);
+	}
+
+	/* Disable conversion queue run */
+	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, 0);
+
+	/* Acknowledge all possible irqs */
+	regmap_write(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |
+		     MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR |
+		     MX25_ADCQ_SR_EOQ | MX25_ADCQ_SR_PD);
+
+	return IRQ_HANDLED;
+}
+
+static int mx25_gcq_get_raw_value(struct device *dev,
+				  struct iio_chan_spec const *chan,
+				  struct mx25_gcq_priv *priv,
+				  int *val)
+{
+	long timeout;
+	u32 data;
+
+	/* Setup the configuration we want to use */
+	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
+		     MX25_ADCQ_ITEM(0, chan->channel));
+
+	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_IRQ, 0);
+
+	/* Trigger queue for one run */
+	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
+			   MX25_ADCQ_CR_FQS);
+
+	timeout = wait_for_completion_interruptible_timeout(
+		&priv->completed, MX25_GCQ_TIMEOUT);
+	if (timeout < 0) {
+		dev_err(dev,
+			"ADC wait for measurement failed\n");
+		return timeout;
+	} else if (timeout == 0) {
+		dev_err(dev, "ADC timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+
+	*val = MX25_ADCQ_FIFO_DATA(data);
+
+	return IIO_VAL_INT;
+}
+
+static int mx25_gcq_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct mx25_gcq_priv *priv = iio_priv(indio_dev);
+	int ret = 0;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+		ret = mx25_gcq_get_raw_value(&indio_dev->dev, chan, priv, val);
+		mutex_unlock(&indio_dev->mlock);
+		return ret;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = priv->channel_vref_mv[chan->channel];
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mx25_gcq_iio_info = {
+	.read_raw = mx25_gcq_read_raw,
+};
+
+static const struct regmap_config mx25_gcq_regconfig = {
+	.max_register = 0x5c,
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
+			       struct mx25_gcq_priv *priv)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
+	struct device *dev = &pdev->dev;
+	int ret, i;
+	bool external_ref_used = false;
+
+	/*
+	 * Setup all configurations registers with a default conversion
+	 * configuration for each input
+	 */
+	for (i = 0; i < MX25_NUM_CFGS; ++i)
+		regmap_write(priv->regs, MX25_ADCQ_CFG(i),
+			     MX25_ADCQ_CFG_YPLL_OFF |
+			     MX25_ADCQ_CFG_XNUR_OFF |
+			     MX25_ADCQ_CFG_XPUL_OFF |
+			     MX25_ADCQ_CFG_REFP_INT |
+			     MX25_ADCQ_CFG_IN(i) |
+			     MX25_ADCQ_CFG_REFN_NGND2);
+
+	for_each_child_of_node(np, child) {
+		u32 reg;
+		u32 refp = MX25_ADCQ_CFG_REFP_INT;
+		u32 refn = MX25_ADCQ_CFG_REFN_NGND2;
+
+		ret = of_property_read_u32(child, "reg", &reg);
+		if (ret) {
+			dev_err(dev, "Failed to get reg property\n");
+			return ret;
+		}
+
+		if (reg >= MX25_NUM_CFGS) {
+			dev_err(dev,
+				"reg value is greater than the number of available configuration registers\n");
+			return -EINVAL;
+		}
+
+		of_property_read_u32(child, "fsl,adc-refp", &refp);
+		of_property_read_u32(child, "fsl,adc-refn", &refn);
+
+		if (refp == MX25_ADC_REFP_EXT)
+			external_ref_used = true;
+
+		/*
+		 * Shift the read values to the correct positions within the
+		 * register.
+		 */
+		refp = MX25_ADCQ_CFG_REFP(refp);
+		refn = MX25_ADCQ_CFG_REFN(refn);
+
+		if ((refp & MX25_ADCQ_CFG_REFP_MASK) != refp) {
+			dev_err(dev, "Invalid fsl,adc-refp property value\n");
+			return -EINVAL;
+		}
+		if ((refn & MX25_ADCQ_CFG_REFN_MASK) != refn) {
+			dev_err(dev, "Invalid fsl,adc-refn property value");
+			return -EINVAL;
+		}
+
+		regmap_update_bits(priv->regs, MX25_ADCQ_CFG(reg),
+				   MX25_ADCQ_CFG_REFP_MASK |
+				   MX25_ADCQ_CFG_REFN_MASK,
+				   refp | refn);
+	}
+	regmap_update_bits(priv->regs, MX25_ADCQ_CR,
+			   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST,
+			   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST);
+
+	regmap_write(priv->regs, MX25_ADCQ_CR,
+		     MX25_ADCQ_CR_PDMSK | MX25_ADCQ_CR_QSM_FQS);
+
+	if (external_ref_used) {
+		priv->ext_vref = devm_regulator_get(&pdev->dev, "vref");
+		if (IS_ERR(priv->ext_vref)) {
+			dev_err(&pdev->dev, "Failed to get regulator for vref although the external reference voltage is used.\n");
+			return PTR_ERR(priv->ext_vref);
+		}
+	}
+
+	return 0;
+}
+
+static int mx25_gcq_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct mx25_gcq_priv *priv;
+	struct mx25_tsadc *tsadc = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *mem;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mem = devm_ioremap_resource(dev, res);
+	if (!mem)
+		return -ENOMEM;
+
+	priv->regs = devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
+	if (IS_ERR(priv->regs)) {
+		dev_err(dev, "Failed to initialize regmap\n");
+		return PTR_ERR(priv->regs);
+	}
+
+	init_completion(&priv->completed);
+
+	ret = mx25_gcq_setup_cfgs(pdev, priv);
+	if (ret)
+		return ret;
+
+	if (!IS_ERR_OR_NULL(priv->ext_vref)) {
+		ret = regulator_enable(priv->ext_vref);
+		if (ret)
+			return ret;
+	}
+
+	priv->clk = tsadc->clk;
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock\n");
+		return ret;
+	}
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq <= 0) {
+		dev_err(dev, "Failed to get IRQ\n");
+		ret = priv->irq;
+		goto err_clk_unprepare;
+	}
+
+	ret = request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, priv);
+	if (ret) {
+		dev_err(dev, "Failed requesting IRQ\n");
+		goto err_clk_unprepare;
+	}
+
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->channels = mx25_gcq_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mx25_gcq_channels);
+	indio_dev->info = &mx25_gcq_iio_info;
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(dev, "Failed to register iio device\n");
+		goto err_irq_free;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	return 0;
+
+err_irq_free:
+	free_irq(priv->irq, (void *)priv);
+err_clk_unprepare:
+	clk_disable_unprepare(priv->clk);
+	return ret;
+}
+
+static int mx25_gcq_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct mx25_gcq_priv *priv = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	free_irq(priv->irq, priv);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static struct of_device_id mx25_gcq_ids[] = {
+	{ .compatible = "fsl,imx25-gcq", },
+	{ /* Sentinel */ }
+};
+
+static struct platform_driver mx25_gcq_driver = {
+	.driver		= {
+		.name	= "mx25-gcq",
+		.of_match_table = mx25_gcq_ids,
+	},
+	.probe		= mx25_gcq_probe,
+	.remove		= mx25_gcq_remove,
+};
+module_platform_driver(mx25_gcq_driver);
+
+MODULE_DESCRIPTION("ADC driver for Freescale mx25");
+MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/iio/adc/fsl-imx25-gcq.h b/include/dt-bindings/iio/adc/fsl-imx25-gcq.h
new file mode 100644
index 000000000000..4f2f4a9baafe
--- /dev/null
+++ b/include/dt-bindings/iio/adc/fsl-imx25-gcq.h
@@ -0,0 +1,18 @@
+/*
+ * This header provides constants for configuring the I.MX25 ADC
+ */
+
+#ifndef _DT_BINDINGS_IIO_ADC_FS_IMX25_GCQ_H
+#define _DT_BINDINGS_IIO_ADC_FS_IMX25_GCQ_H
+
+#define MX25_ADC_REFP_YP	0 /* YP voltage reference */
+#define MX25_ADC_REFP_XP	1 /* XP voltage reference */
+#define MX25_ADC_REFP_INT	2 /* Internal voltage reference */
+#define MX25_ADC_REFP_EXT	3 /* External voltage reference */
+
+#define MX25_ADC_REFN_XN	0
+#define MX25_ADC_REFN_YN	1
+#define MX25_ADC_REFN_NGND	2
+#define MX25_ADC_REFN_NGND2	3
+
+#endif
-- 
2.1.4

