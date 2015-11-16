From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v8 5/8] iio: adc: fsl,imx25-gcq driver
Date: Mon, 16 Nov 2015 13:01:06 +0100
Message-ID: <1447675269-8831-6-git-send-email-mpa@pengutronix.de>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447675269-8831-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This is a conversion queue driver for the mx25 SoC. It uses the central
ADC which is used by two seperate independent queues. This driver
prepares different conversion configurations for each possible input.
For a conversion it creates a conversionqueue of one item with the
correct configuration for the chosen channel. It then executes the queue
once and disables the conversion queue afterwards.

The reference voltages are configurable through devicetree subnodes,
depending on the connections of the ADC inputs.

Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
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
 drivers/iio/adc/fsl-imx25-gcq.c             | 415 ++++++++++++++++++++++++++++
 include/dt-bindings/iio/adc/fsl-imx25-gcq.h |  18 ++
 4 files changed, 441 insertions(+)
 create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
 create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7868c744fd4b..73145c53ec2c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -183,6 +183,13 @@ config EXYNOS_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called exynos_adc.
 
+config FSL_MX25_ADC
+	tristate "Freescale MX25 ADC driver"
+	depends on MFD_MX25_TSADC
+	help
+	  Generic Conversion Queue driver used for general purpose ADC in the
+	  MX25. This driver supports single measurements using the MX25 ADC.
+
 config HI8435
 	tristate "Holt Integrated Circuits HI-8435 threshold detector"
 	select IIO_TRIGGERED_EVENT
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 99b37a963a1e..2fe9b78e4b02 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
 obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
 obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
 obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
+obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
 obj-$(CONFIG_HI8435) += hi8435.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_MAX1027) += max1027.o
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
new file mode 100644
index 000000000000..eb9570876291
--- /dev/null
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -0,0 +1,415 @@
+/*
+ * Copyright (C) 2014-2015 Pengutronix, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
+static const char * const driver_name = "mx25-gcq";
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
+	struct clk *clk;
+	int irq;
+	struct regulator *vref[4];
+	u32 channel_vref_mv[MX25_NUM_CFGS];
+};
+
+#define MX25_CQG_CHAN(chan, id) {\
+	.type = IIO_VOLTAGE,\
+	.indexed = 1,\
+	.channel = chan,\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE),\
+	.datasheet_name = id,\
+}
+
+static const struct iio_chan_spec mx25_gcq_channels[MX25_NUM_CFGS] = {
+	MX25_CQG_CHAN(MX25_CFG_XP, "xp"),
+	MX25_CQG_CHAN(MX25_CFG_YP, "yp"),
+	MX25_CQG_CHAN(MX25_CFG_XN, "xn"),
+	MX25_CQG_CHAN(MX25_CFG_YN, "yn"),
+	MX25_CQG_CHAN(MX25_CFG_WIPER, "wiper"),
+	MX25_CQG_CHAN(MX25_CFG_INAUX0, "inaux0"),
+	MX25_CQG_CHAN(MX25_CFG_INAUX1, "inaux1"),
+	MX25_CQG_CHAN(MX25_CFG_INAUX2, "inaux2"),
+};
+
+static const char * const mx25_gcq_refp_names[] = {
+	[MX25_ADC_REFP_YP] = "yp",
+	[MX25_ADC_REFP_XP] = "xp",
+	[MX25_ADC_REFP_INT] = "int",
+	[MX25_ADC_REFP_EXT] = "ext",
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
+		dev_err(dev, "ADC wait for measurement failed\n");
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
+	int ret;
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
+	unsigned int refp_used[4] = {};
+	int ret, i;
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
+	/*
+	 * First get all regulators to store them in channel_vref_mv if
+	 * necessary. Later we use that information for proper IIO scale
+	 * information.
+	 */
+	priv->vref[MX25_ADC_REFP_INT] = NULL;
+	priv->vref[MX25_ADC_REFP_EXT] =
+		devm_regulator_get_optional(&pdev->dev, "vref-ext");
+	priv->vref[MX25_ADC_REFP_XP] =
+		devm_regulator_get_optional(&pdev->dev, "vref-xp");
+	priv->vref[MX25_ADC_REFP_YP] =
+		devm_regulator_get_optional(&pdev->dev, "vref-yp");
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
+		switch (refp) {
+		case MX25_ADC_REFP_EXT:
+		case MX25_ADC_REFP_XP:
+		case MX25_ADC_REFP_YP:
+			if (IS_ERR(priv->vref[refp])) {
+				dev_err(dev, "Error, trying to use external voltage reference without a vref-%s regulator.",
+					mx25_gcq_refp_names[refp]);
+				return PTR_ERR(priv->vref[refp]);
+			}
+			priv->channel_vref_mv[reg] =
+				regulator_get_voltage(priv->vref[refp]);
+			/* Conversion from uV to mV */
+			do_div(priv->channel_vref_mv[reg], 1000);
+			break;
+		case MX25_ADC_REFP_INT:
+			priv->channel_vref_mv[reg] = 2500;
+			break;
+		default:
+			dev_err(dev, "Invalid positive reference %d\n", refp);
+			return -EINVAL;
+		}
+
+		++refp_used[refp];
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
+			dev_err(dev, "Invalid fsl,adc-refn property value\n");
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
+	/* Remove unused regulators */
+	for (i = 0; i != 4; ++i) {
+		if (!refp_used[i]) {
+			if (!IS_ERR_OR_NULL(priv->vref[i]))
+				devm_regulator_put(priv->vref[i]);
+			priv->vref[i] = NULL;
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
+	int i;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mem = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
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
+	for (i = 0; i != 4; ++i) {
+		if (!priv->vref[i])
+			continue;
+
+		ret = regulator_enable(priv->vref[i]);
+		if (ret)
+			goto err_regulator_disable;
+	}
+
+	priv->clk = tsadc->clk;
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock\n");
+		goto err_vref_disable;
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
+	indio_dev->name = driver_name;
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
+err_vref_disable:
+	i = 4;
+err_regulator_disable:
+	for (; i-- > 0;) {
+		if (priv->vref[i])
+			regulator_disable(priv->vref[i]);
+	}
+	return ret;
+}
+
+static int mx25_gcq_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct mx25_gcq_priv *priv = iio_priv(indio_dev);
+	int i;
+
+	iio_device_unregister(indio_dev);
+	free_irq(priv->irq, priv);
+	clk_disable_unprepare(priv->clk);
+	for (i = 4; i-- > 0;) {
+		if (priv->vref[i])
+			regulator_disable(priv->vref[i]);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mx25_gcq_ids[] = {
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
+MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/iio/adc/fsl-imx25-gcq.h b/include/dt-bindings/iio/adc/fsl-imx25-gcq.h
new file mode 100644
index 000000000000..87abdd4a7674
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
+#define MX25_ADC_REFP_EXT	2 /* External voltage reference */
+#define MX25_ADC_REFP_INT	3 /* Internal voltage reference */
+
+#define MX25_ADC_REFN_XN	0 /* XN ground reference */
+#define MX25_ADC_REFN_YN	1 /* YN ground reference */
+#define MX25_ADC_REFN_NGND	2 /* Internal ground reference */
+#define MX25_ADC_REFN_NGND2	3 /* External ground reference */
+
+#endif
-- 
2.6.1
