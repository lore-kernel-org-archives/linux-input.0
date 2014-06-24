From: Denis Carikli <denis@eukrea.com>
Subject: [PATCH v4 3/6] iio: adc: fsl,imx25-gcq driver
Date: Tue, 24 Jun 2014 16:46:32 +0200
Message-ID: <1403621195-9622-3-git-send-email-denis@eukrea.com>
References: <1403621195-9622-1-git-send-email-denis@eukrea.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:40286 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbaFXOrV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jun 2014 10:47:21 -0400
In-Reply-To: <1403621195-9622-1-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Denis Carikli <denis@eukrea.com>

From: Markus Pargmann <mpa@pengutronix.de>

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
---
Changelog v3->v4:
- Reworked the ADC reference voltage bindings.
- IIO_CHAN_INFO_SCALE is now handled.
- Lot of code and style cleanups.
- Tested by watching WIPER become 0 when the touchscreen is touched.

Changelog v2->v3:
- Fixed compilation: I forgott to tell that this IIO patch was untested
  in the previous cover letter. Now it is tested at runtime:
  I left the touchscreen connected but I configured the TSC as an ADC
  instead, set the refp to internal reference, and the refn to ngnd_adc(3)
  for the first 4 channels(xp,yp,xn,yn) and observed the values changing
  while touching the resistive 4-wire touchscreen.
- MX25_IIO_CHAN now became MX25_GCQ_CHAN and its .address is now gone
  and the code using it adapted.
- The instances of struct iio_dev were renamed from idev to indio_dev.
- regmap_read return value is now checked in mx25_gcq_read_raw.
- Comparisons with MX25_NUM_CFGS are now fixed
- Cosmetics fix in a multiline comment.
---
 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |   51 +++
 drivers/iio/adc/Kconfig                            |    7 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/fsl-imx25-gcq.c                    |  371 ++++++++++++++++++++
 include/dt-bindings/iio/adc/fsl-imx25-gcq.h        |   11 +
 5 files changed, 441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
 create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
 create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h

diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
new file mode 100644
index 0000000..e4a7170
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
@@ -0,0 +1,51 @@
+Freescale i.MX25 ADC GCQ device
+
+This is a generic conversion queue device that can convert any of the
+analog inputs using the ADC unit of the i.MX25.
+
+Required properties:
+ - compatible: Should be "fsl,imx25-gcq".
+ - reg: Should be the register range of the module.
+ - interrupts: Should be the interrupt number of the module.
+   Typically this is <1>.
+ - interrupt-parent: phandle to the tsadc module of the i.MX25.
+ - #address-cells: Should be <1> (setting for the subnodes)
+ - #size-cells: Should be <0> (setting for the subnodes)
+
+Optional properties:
+ - vref-supply: The regulator supplying the ADC refrence voltage.
+   Required when at least one subnode uses the external reference.
+
+Sub-nodes:
+Optionally you can define subnodes which define the reference voltage
+for the analog inputs.
+
+Required properties for subnodes:
+ - reg: Should be the number of the analog input.
+     0: xp
+     1: yp
+     2: xn
+     3: yn
+     4: wiper
+     5: inaux0
+     6: inaux1
+     7: inaux2
+ - fsl,adc-ref: specifies the reference input as defined in
+     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
+     MX25_ADC_REF_INT and MX25_ADC_REF_EXT flags are supported.
+
+Example:
+
+	adc: adc@50030800 {
+		compatible = "fsl,imx25-gcq";
+		reg = <0x50030800 0x60>;
+		interrupt-parent = <&tscadc>;
+		interrupts = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		inaux@5 {
+			reg = <5>;
+			fsl,adc-ref = <MX25_ADC_REF_INT>;
+		};
+	};
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a80d236..58efb8d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -125,6 +125,13 @@ config EXYNOS_ADC
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
index 9d60f2d..2767fd6 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_AD7887) += ad7887.o
 obj-$(CONFIG_AD799X) += ad799x.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
 obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
+obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
new file mode 100644
index 0000000..1e95553
--- /dev/null
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -0,0 +1,371 @@
+/*
+ * Copyright 2014 Markus Pargmann, Pengutronix <mpa@pengutronix.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ *
+ * This is the driver for the imx25 GCQ (Generic Conversion Queue)
+ * connected to the imx25 ADC.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/iio/iio.h>
+#include <linux/mfd/imx25-tsadc.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <dt-bindings/iio/adc/fsl-imx25-gcq.h>
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
+static void mx25_gcq_disable_eoq(struct mx25_gcq_priv *priv)
+{
+	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_IRQ,
+			   MX25_ADCQ_MR_EOQ_IRQ);
+}
+
+static void mx25_gcq_enable_eoq(struct mx25_gcq_priv *priv)
+{
+	regmap_update_bits(priv->regs, MX25_ADCQ_MR,
+			   MX25_ADCQ_MR_EOQ_IRQ, 0);
+}
+
+static irqreturn_t mx25_gcq_irq(int irq, void *data)
+{
+	struct mx25_gcq_priv *priv = data;
+	u32 stats;
+
+	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
+
+	if (stats & MX25_ADCQ_SR_EOQ) {
+		mx25_gcq_disable_eoq(priv);
+		complete(&priv->completed);
+	}
+
+	/* Disable conversion queue run */
+	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, 0);
+
+	/* Acknowledge all possible irqs */
+	regmap_write(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |
+				 MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR |
+				 MX25_ADCQ_SR_EOQ | MX25_ADCQ_SR_PD);
+
+	return IRQ_HANDLED;
+}
+
+static int mx25_gcq_read_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *chan, int *val, int *val2,
+		long mask)
+{
+	struct mx25_gcq_priv *priv = iio_priv(indio_dev);
+	long timeout;
+	u32 data;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+
+		/* Setup the configuration we want to use */
+		regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
+			     MX25_ADCQ_ITEM(0, chan->channel));
+
+		mx25_gcq_enable_eoq(priv);
+
+		/* Trigger queue for one run */
+		regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
+				   MX25_ADCQ_CR_FQS);
+
+		timeout = wait_for_completion_interruptible_timeout(
+			&priv->completed, MX25_GCQ_TIMEOUT);
+		if (timeout < 0) {
+			dev_err(&indio_dev->dev,
+					 "ADC wait for measurement failed\n");
+			ret = timeout;
+			goto out;
+		} else if (timeout == 0) {
+			dev_err(&indio_dev->dev, "ADC timed out\n");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+
+		ret = regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+		if (ret)
+			return ret;
+
+		*val = MX25_ADCQ_FIFO_DATA(data);
+		ret = IIO_VAL_INT;
+		goto out;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = priv->channel_vref_mv[chan->channel];
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+out:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
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
+
+	/* Setup all configurations registers with a default conversion
+	 * configuration for each input
+	 */
+	for (i = 0; i < MX25_NUM_CFGS; ++i)
+		regmap_write(priv->regs, MX25_ADCQ_CFG(i),
+			     MX25_ADCQ_CFG_YPLL_OFF |
+			     MX25_ADCQ_CFG_XNUR_OFF |
+			     MX25_ADCQ_CFG_XPUL_OFF |
+			     MX25_ADCQ_CFG_REFP_INT |
+			     (i << 4) |
+			     MX25_ADCQ_CFG_REFN_NGND2);
+
+	for_each_child_of_node(np, child) {
+		u32 reg;
+		u32 refp;
+		u32 adc_ref;
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
+		ret = of_property_read_u32(child, "fsl,adc-ref", &adc_ref);
+		if (ret) {
+			dev_err(dev, "Failed to get fsl,adc-ref property\n");
+			return ret;
+		}
+
+		if (adc_ref != MX25_ADC_REF_INT &&
+		    adc_ref != MX25_ADC_REF_EXT) {
+			dev_err(dev, "Invalid fsl,adc-refp property value %d\n",
+				adc_ref);
+			return -EINVAL;
+		}
+
+		switch (adc_ref) {
+		case MX25_ADC_REF_EXT:
+			if (IS_ERR_OR_NULL(priv->ext_vref)) {
+				dev_err(dev,
+					"No regulator found for the external vref\n");
+				return -EINVAL;
+			}
+			priv->channel_vref_mv[reg] =
+				regulator_get_voltage(priv->ext_vref);
+			refp = MX25_ADCQ_CFG_REFP_EXT;
+			break;
+		case MX25_ADC_REF_INT:
+			priv->channel_vref_mv[reg] = 2500;
+			refp = MX25_ADCQ_CFG_REFP_INT;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		regmap_update_bits(priv->regs, MX25_ADCQ_CFG(reg),
+				   MX25_ADCQ_CFG_REFP_MASK |
+				   MX25_ADCQ_CFG_REFN_MASK, (refp << 7) |
+				   (MX25_ADCQ_CFG_REFN_NGND << 2));
+	}
+	regmap_update_bits(priv->regs, MX25_ADCQ_CR,
+			   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST,
+			   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST);
+
+	regmap_write(priv->regs, MX25_ADCQ_CR,
+		     MX25_ADCQ_CR_PDMSK |
+		     MX25_ADCQ_CR_QSM_FQS);
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
+	/* Optional external regulator */
+	priv->ext_vref = devm_regulator_get(&pdev->dev, "vref");
+	if (!IS_ERR_OR_NULL(priv->ext_vref)) {
+		ret = regulator_enable(priv->ext_vref);
+		if (ret)
+			return ret;
+	}
+
+	ret = mx25_gcq_setup_cfgs(pdev, priv);
+	if (ret)
+		return ret;
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
+	platform_set_drvdata(pdev, priv);
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
+	struct mx25_gcq_priv *priv = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = iio_priv_to_dev(pdev);
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
+		.owner	= THIS_MODULE,
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
index 0000000..486dce7
--- /dev/null
+++ b/include/dt-bindings/iio/adc/fsl-imx25-gcq.h
@@ -0,0 +1,11 @@
+/*
+ * This header provides constants for configuring the I.MX25 ADC
+ */
+
+#ifndef _DT_BINDINGS_IIO_ADC_FS_IMX25_GCQ_H
+#define _DT_BINDINGS_IIO_ADC_FS_IMX25_GCQ_H
+
+#define MX25_ADC_REF_INT	0 /* Internal voltage reference */
+#define MX25_ADC_REF_EXT	1 /* External voltage reference */
+
+#endif
-- 
1.7.9.5

