From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 3/3] iio: adc: fsl,imx25-gcq driver
Date: Thu, 20 Feb 2014 17:21:52 +0100
Message-ID: <1392913312-9030-4-git-send-email-mpa@pengutronix.de>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392913312-9030-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
---
 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  54 ++++
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/fsl-imx25-gcq.c                    | 325 +++++++++++++++++++++
 4 files changed, 387 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
 create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c

diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
new file mode 100644
index 0000000..333fc55
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
@@ -0,0 +1,54 @@
+Freescale i.MX25 ADC GCQ device
+
+This is a generic conversion queue device that can convert any of the analog
+inputs using the ADC unit of the i.MX25.
+
+Required properties:
+ - compatible: Should be "fsl,imx25-gcq".
+ - reg: Should be the register range of the module.
+ - interrupts: Should be the interrupt number of the module. Typically this is <1>.
+ - interrupt-parent: phandle to the tsadc module of the i.MX25.
+ - #address-cells: Should be <1> (setting for the subnodes)
+ - #size-cells: Should be <0> (setting for the subnodes)
+
+Optionally you can define subnodes which define the positive and negative
+reference voltage for one of the analog inputs.
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
+ - fsl,adc-refp: Positive reference input
+     0: yp
+     1: xp
+     2: External reference
+     3: Internal reference
+ - fsl,adc-refn: Negative reference input
+     0: xn
+     1: yn
+     2: ngnd_adc
+     3: ngnd_adc
+
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
+			fsl,adc-refp = <3>;
+			fsl,adc-refn = <3>;
+		};
+	};
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 2209f28..a421445 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -113,6 +113,13 @@ config EXYNOS_ADC
 	  of SoCs for drivers such as the touchscreen and hwmon to use to share
 	  this resource.
 
+config MX25_ADC
+	tristate "Freescale MX25 ADC driver"
+	depends on MFD_MX25_TSADC
+	help
+	  Generic Conversion Queue driver used for general purpose ADC in the
+	  MX25. This driver supports single measurements using the MX25 ADC.
+
 config LP8788_ADC
 	bool "LP8788 ADC driver"
 	depends on MFD_LP8788
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ba9a10a..63daa2c 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
 obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
+obj-$(CONFIG_MX25_ADC) += fsl-imx25-gcq.o
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
new file mode 100644
index 0000000..cc7f87f
--- /dev/null
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -0,0 +1,325 @@
+/*
+ * Copyright 2014 Markus Pargmann, Pengutronix <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
+};
+
+#define MX25_IIO_CHAN(chan, id) {\
+		.type = IIO_VOLTAGE,\
+		.indexed = 1,\
+		.channel = chan,\
+		.address = chan,\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+		.datasheet_name = id,				\
+	}
+
+const struct iio_chan_spec mx25_gcq_channels[MX25_NUM_CFGS] = {
+	MX25_IIO_CHAN(0, "xp"),
+	MX25_IIO_CHAN(1, "yp"),
+	MX25_IIO_CHAN(2, "xn"),
+	MX25_IIO_CHAN(3, "yn"),
+	MX25_IIO_CHAN(4, "wiper"),
+	MX25_IIO_CHAN(5, "inaux0"),
+	MX25_IIO_CHAN(6, "inaux1"),
+	MX25_IIO_CHAN(7, "inaux2"),
+};
+
+static void mx25_gcq_disable_eoq(struct mx25_gcq_priv *priv)
+{
+	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_IRQ,
+			MX25_ADCQ_MR_EOQ_IRQ);
+}
+
+static void mx25_gcq_enable_eoq(struct mx25_gcq_priv *priv)
+{
+	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_IRQ, 0);
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
+			MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR | MX25_ADCQ_SR_EOQ |
+			MX25_ADCQ_SR_PD);
+
+	return IRQ_HANDLED;
+}
+
+static int mx25_gcq_read_raw(struct iio_dev *idev,
+		struct iio_chan_spec const *chan, int *val, int *val2,
+		long mask)
+{
+	struct mx25_gcq_priv *priv = iio_priv(idev);
+	unsigned long timeout;
+	u32 data;
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	mutex_lock(&idev->mlock);
+
+	/* Setup the configuration we want to use */
+	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
+			MX25_ADCQ_ITEM(0, chan->address));
+
+	mx25_gcq_enable_eoq(priv);
+
+	/* Trigger queue for one run */
+	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
+			MX25_ADCQ_CR_FQS);
+
+	timeout = wait_for_completion_interruptible_timeout(&priv->completed,
+			MX25_GCQ_TIMEOUT);
+	if (timeout < 0) {
+		dev_err(&idev->dev, "ADC wait for measurement failed\n");
+		ret = timeout;
+		goto out;
+	} else if (timeout == 0) {
+		dev_err(&idev->dev, "ADC timed out\n");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+	*val = MX25_ADCQ_FIFO_DATA(data);
+
+	ret = IIO_VAL_INT;
+
+out:
+	mutex_unlock(&idev->mlock);
+
+	return ret;
+}
+
+struct iio_info mx25_gcq_iio_info = {
+	.read_raw = mx25_gcq_read_raw,
+};
+
+static struct regmap_config mx25_gcq_regconfig = {
+	.fast_io = true,
+	.max_register = 0x5c,
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static void mx25_gcq_iio_dev_setup(struct platform_device *pdev,
+		struct iio_dev *idev)
+{
+	idev->dev.parent = &pdev->dev;
+	idev->channels = mx25_gcq_channels;
+	idev->num_channels = ARRAY_SIZE(mx25_gcq_channels);
+	idev->info = &mx25_gcq_iio_info;
+}
+
+static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
+		struct mx25_gcq_priv *priv)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
+	struct device *dev = &pdev->dev;
+	int ret;
+	int i;
+
+	/* Setup all configurations registers with a default conversion
+	 * configuration for each input */
+	for (i = 0; i != MX25_NUM_CFGS; ++i)
+		regmap_write(priv->regs, MX25_ADCQ_CFG(i),
+				MX25_ADCQ_CFG_YPLL_OFF |
+				MX25_ADCQ_CFG_XNUR_OFF |
+				MX25_ADCQ_CFG_XPUL_OFF |
+				MX25_ADCQ_CFG_REFP_INT |
+				(i << 4) |
+				MX25_ADCQ_CFG_REFN_NGND2);
+
+	for_each_child_of_node(np, child) {
+		u32 reg;
+		u32 refn;
+		u32 refp;
+
+		ret = of_property_read_u32(child, "reg", &reg);
+		if (ret) {
+			dev_err(dev, "Failed to get reg property\n");
+			return ret;
+		}
+		if (reg > MX25_NUM_CFGS) {
+			dev_err(dev, "reg value is greater than the number of available configuration registers\n");
+			return -EINVAL;
+		}
+
+		ret = of_property_read_u32(child, "fsl,adc-refn", &refn);
+		if (ret) {
+			dev_err(dev, "Failed to get fsl,adc-refn property\n");
+			return ret;
+		}
+
+		ret = of_property_read_u32(child, "fsl,adc-refp", &refp);
+		if (ret) {
+			dev_err(dev, "Failed to get fsl,adc-refp property\n");
+			return ret;
+		}
+
+		regmap_update_bits(priv->regs, MX25_ADCQ_CFG(reg),
+				MX25_ADCQ_CFG_REFP_MASK |
+				MX25_ADCQ_CFG_REFN_MASK,
+				(refp << 7) | (refn << 2));
+	}
+	regmap_update_bits(priv->regs, MX25_ADCQ_CR,
+			MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST,
+			MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST);
+
+	regmap_write(priv->regs, MX25_ADCQ_CR,
+			MX25_ADCQ_CR_PDMSK |
+			MX25_ADCQ_CR_QSM_FQS);
+
+	return 0;
+}
+
+static int mx25_gcq_probe(struct platform_device *pdev)
+{
+	struct iio_dev *idev;
+	struct mx25_gcq_priv *priv;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	int ret;
+	int irq;
+	void __iomem *mem;
+
+	idev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	if (!idev)
+		return -ENOMEM;
+
+	priv = iio_priv(idev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mem = devm_ioremap_resource(dev, res);
+	if (!mem) {
+		dev_err(dev, "Failed to get iomem");
+		return -ENOMEM;
+	}
+
+	priv->regs = devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
+	if (IS_ERR(priv->regs)) {
+		dev_err(dev, "Failed to initialize regmap\n");
+		return PTR_ERR(priv->regs);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Failed to get IRQ\n");
+		return irq;
+	}
+
+	ret = devm_request_irq(dev, irq, mx25_gcq_irq, IRQF_ONESHOT, pdev->name,
+			priv);
+	if (ret) {
+		dev_err(dev, "Failed requesting IRQ\n");
+		return ret;
+	}
+
+	ret = mx25_gcq_setup_cfgs(pdev, priv);
+	if (ret)
+		return ret;
+
+	mx25_gcq_iio_dev_setup(pdev, idev);
+
+	ret = iio_device_register(idev);
+	if (ret) {
+		dev_err(dev, "Failed to register iio device\n");
+		return ret;
+	}
+
+	init_completion(&priv->completed);
+
+	priv->clk = mx25_tsadc_get_ipg(pdev->dev.parent);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int mx25_gcq_remove(struct platform_device *pdev)
+{
+	struct mx25_gcq_priv *priv = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static struct of_device_id mx25_gcq_ids[] = {
+	{ .compatible = "fsl,imx25-gcq", },
+	{ /* Senitel */ }
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
+MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
1.8.5.3
