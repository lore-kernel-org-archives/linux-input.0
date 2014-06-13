From: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v2 3/6] iio: adc: fsl,imx25-gcq driver
Date: Fri, 13 Jun 2014 19:25:52 +0200 (CEST)
Message-ID: <alpine.DEB.2.01.1406131912160.16722@pmeerw.net>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de> <1402672899-6995-1-git-send-email-denis@eukrea.com> <1402672899-6995-4-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402672899-6995-4-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Eric_B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


> This is a conversion queue driver for the mx25 SoC. It uses the central
> ADC which is used by two seperate independent queues. This driver
> prepares different conversion configurations for each possible input.
> For a conversion it creates a conversionqueue of one item with the
> correct configuration for the chosen channel. It then executes the queue
> once and disables the conversion queue afterwards.

comments inline

> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |   54 ++++
>  drivers/iio/adc/Kconfig                            |    7 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/fsl-imx25-gcq.c                    |  338 ++++++++++++++++++++
>  4 files changed, 400 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
>  create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
> new file mode 100644
> index 0000000..333fc55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
> @@ -0,0 +1,54 @@
> +Freescale i.MX25 ADC GCQ device
> +
> +This is a generic conversion queue device that can convert any of the analog
> +inputs using the ADC unit of the i.MX25.
> +
> +Required properties:
> + - compatible: Should be "fsl,imx25-gcq".
> + - reg: Should be the register range of the module.
> + - interrupts: Should be the interrupt number of the module. Typically this is <1>.
> + - interrupt-parent: phandle to the tsadc module of the i.MX25.
> + - #address-cells: Should be <1> (setting for the subnodes)
> + - #size-cells: Should be <0> (setting for the subnodes)
> +
> +Optionally you can define subnodes which define the positive and negative
> +reference voltage for one of the analog inputs.
> +
> +Required properties for subnodes:
> + - reg: Should be the number of the analog input.
> +     0: xp
> +     1: yp
> +     2: xn
> +     3: yn
> +     4: wiper
> +     5: inaux0
> +     6: inaux1
> +     7: inaux2
> + - fsl,adc-refp: Positive reference input
> +     0: yp
> +     1: xp
> +     2: External reference
> +     3: Internal reference
> + - fsl,adc-refn: Negative reference input
> +     0: xn
> +     1: yn
> +     2: ngnd_adc
> +     3: ngnd_adc
> +
> +
> +Example:
> +
> +	adc: adc@50030800 {
> +		compatible = "fsl,imx25-gcq";
> +		reg = <0x50030800 0x60>;
> +		interrupt-parent = <&tscadc>;
> +		interrupts = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		inaux@5 {
> +			reg = <5>;
> +			fsl,adc-refp = <3>;
> +			fsl,adc-refn = <3>;
> +		};
> +	};
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a80d236..58efb8d 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -125,6 +125,13 @@ config EXYNOS_ADC
>  	  of SoCs for drivers such as the touchscreen and hwmon to use to share
>  	  this resource.
>  
> +config FSL_MX25_ADC
> +	tristate "Freescale MX25 ADC driver"
> +	depends on MFD_MX25_TSADC
> +	help
> +	  Generic Conversion Queue driver used for general purpose ADC in the
> +	  MX25. This driver supports single measurements using the MX25 ADC.
> +
>  config LP8788_ADC
>  	tristate "LP8788 ADC driver"
>  	depends on MFD_LP8788
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9d60f2d..2767fd6 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_AD7887) += ad7887.o
>  obj-$(CONFIG_AD799X) += ad799x.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
> +obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> new file mode 100644
> index 0000000..1ae697c
> --- /dev/null
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -0,0 +1,338 @@
> +/*
> + * Copyright 2014 Markus Pargmann, Pengutronix <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + *
> + * This is the driver for the imx25 GCQ (Generic Conversion Queue)
> + * connected to the imx25 ADC.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mfd/imx25-tsadc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define MX25_GCQ_TIMEOUT (msecs_to_jiffies(2000))
> +
> +enum mx25_gcq_cfgs {
> +	MX25_CFG_XP = 0,
> +	MX25_CFG_YP,
> +	MX25_CFG_XN,
> +	MX25_CFG_YN,
> +	MX25_CFG_WIPER,
> +	MX25_CFG_INAUX0,
> +	MX25_CFG_INAUX1,
> +	MX25_CFG_INAUX2,
> +	MX25_NUM_CFGS,
> +};
> +
> +struct mx25_gcq_priv {
> +	struct regmap *regs;
> +	struct completion completed;
> +	unsigned int settling_time;
> +	struct clk *clk;
> +	int irq;
> +};
> +
> +#define MX25_IIO_CHAN(chan, id) {\

prefix should be MX25_GCQ_

> +		.type = IIO_VOLTAGE,\
> +		.indexed = 1,\
> +		.channel = chan,\
> +		.address = chan,\

don't set .address and use .channel instead

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +		.datasheet_name = id,				\
> +	}
> +
> +static const struct iio_chan_spec mx25_gcq_channels[MX25_NUM_CFGS] = {
> +	MX25_IIO_CHAN(0, "xp"),
> +	MX25_IIO_CHAN(1, "yp"),
> +	MX25_IIO_CHAN(2, "xn"),
> +	MX25_IIO_CHAN(3, "yn"),
> +	MX25_IIO_CHAN(4, "wiper"),
> +	MX25_IIO_CHAN(5, "inaux0"),
> +	MX25_IIO_CHAN(6, "inaux1"),
> +	MX25_IIO_CHAN(7, "inaux2"),
> +};
> +
> +static void mx25_gcq_disable_eoq(struct mx25_gcq_priv *priv)
> +{
> +	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_IRQ,
> +			MX25_ADCQ_MR_EOQ_IRQ);
> +}
> +
> +static void mx25_gcq_enable_eoq(struct mx25_gcq_priv *priv)
> +{
> +	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_IRQ, 0);
> +}
> +
> +static irqreturn_t mx25_gcq_irq(int irq, void *data)
> +{
> +	struct mx25_gcq_priv *priv = data;
> +	u32 stats;
> +
> +	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
> +
> +	if (stats & MX25_ADCQ_SR_EOQ) {
> +		mx25_gcq_disable_eoq(priv);
> +		complete(&priv->completed);
> +	}
> +
> +	/* Disable conversion queue run */
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, 0);
> +
> +	/* Acknowledge all possible irqs */
> +	regmap_write(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |
> +			MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR | MX25_ADCQ_SR_EOQ |
> +			MX25_ADCQ_SR_PD);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mx25_gcq_read_raw(struct iio_dev *idev,
> +		struct iio_chan_spec const *chan, int *val, int *val2,
> +		long mask)
> +{
> +	struct mx25_gcq_priv *priv = iio_priv(idev);
> +	unsigned long timeout;

this should be long, not unsigned long; see return of 
wait_for_completion_interruptible_timeout()

> +	u32 data;
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	mutex_lock(&idev->mlock);
> +
> +	/* Setup the configuration we want to use */
> +	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
> +			MX25_ADCQ_ITEM(0, chan->address));

chan->channel

> +
> +	mx25_gcq_enable_eoq(priv);
> +
> +	/* Trigger queue for one run */
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
> +			MX25_ADCQ_CR_FQS);
> +
> +	timeout = wait_for_completion_interruptible_timeout(&priv->completed,
> +			MX25_GCQ_TIMEOUT);
> +	if (timeout < 0) {
> +		dev_err(&idev->dev, "ADC wait for measurement failed\n");
> +		ret = timeout;
> +		goto out;
> +	} else if (timeout == 0) {
> +		dev_err(&idev->dev, "ADC timed out\n");
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);

this ignores the return value

> +	*val = MX25_ADCQ_FIFO_DATA(data);
> +
> +	ret = IIO_VAL_INT;
> +
> +out:
> +	mutex_unlock(&idev->mlock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info mx25_gcq_iio_info = {
> +	.read_raw = mx25_gcq_read_raw,
> +};
> +
> +static const struct regmap_config mx25_gcq_regconfig = {
> +	.max_register = 0x5c,
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
> +		struct mx25_gcq_priv *priv)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *child;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	int i;
> +
> +	/* Setup all configurations registers with a default conversion
> +	 * configuration for each input */

multi-line comment style

> +	for (i = 0; i != MX25_NUM_CFGS; ++i)
> +		regmap_write(priv->regs, MX25_ADCQ_CFG(i),
> +				MX25_ADCQ_CFG_YPLL_OFF |
> +				MX25_ADCQ_CFG_XNUR_OFF |
> +				MX25_ADCQ_CFG_XPUL_OFF |
> +				MX25_ADCQ_CFG_REFP_INT |
> +				(i << 4) |
> +				MX25_ADCQ_CFG_REFN_NGND2);
> +
> +	for_each_child_of_node(np, child) {
> +		u32 reg;
> +		u32 refn;
> +		u32 refp;
> +
> +		ret = of_property_read_u32(child, "reg", &reg);
> +		if (ret) {
> +			dev_err(dev, "Failed to get reg property\n");
> +			return ret;
> +		}
> +		if (reg > MX25_NUM_CFGS) {

>= probably

> +			dev_err(dev, "reg value is greater than the number of available configuration registers\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = of_property_read_u32(child, "fsl,adc-refn", &refn);
> +		if (ret) {
> +			dev_err(dev, "Failed to get fsl,adc-refn property\n");
> +			return ret;
> +		}
> +		if (refn < 0 || refn > 3) {
> +			dev_err(dev, "Invalid fsl,adc-refn property value %d\n",
> +							refn);
> +			return -EINVAL
> +		}
> +
> +		ret = of_property_read_u32(child, "fsl,adc-refp", &refp);
> +		if (ret) {
> +			dev_err(dev, "Failed to get fsl,adc-refp property\n");
> +			return ret;
> +		}
> +		if (refp < 0 || refp > 3) {
> +			dev_err(dev, "Invalid fsl,adc-refp property value %d\n",
> +							refp);
> +			return -EINVAL;
> +		}
> +
> +		regmap_update_bits(priv->regs, MX25_ADCQ_CFG(reg),
> +				MX25_ADCQ_CFG_REFP_MASK |
> +				MX25_ADCQ_CFG_REFN_MASK,
> +				(refp << 7) | (refn << 2));
> +	}
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> +			MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST,
> +			MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST);
> +
> +	regmap_write(priv->regs, MX25_ADCQ_CR,
> +			MX25_ADCQ_CR_PDMSK |
> +			MX25_ADCQ_CR_QSM_FQS);
> +
> +	return 0;
> +}
> +
> +static int mx25_gcq_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *idev;
> +	struct mx25_gcq_priv *priv;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	void __iomem *mem;
> +
> +	idev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(idev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mem = devm_ioremap_resource(dev, res);
> +	if (!mem)
> +		return -ENOMEM;
> +
> +	priv->regs = devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
> +	if (IS_ERR(priv->regs)) {
> +		dev_err(dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(priv->regs);
> +	}
> +
> +	init_completion(&priv->completed);
> +
> +	ret = mx25_gcq_setup_cfgs(pdev, priv);
> +	if (ret)
> +		goto err_irq_free;
> +
> +	priv->clk = mx25_tsadc_get_ipg(pdev->dev.parent);
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	priv->irq = platform_get_irq(pdev, 0);
> +	if (priv->irq <= 0) {
> +		dev_err(dev, "Failed to get IRQ\n");
> +		err = priv->irq;
> +		goto err_clk_unprepare;
> +	}
> +
> +	ret = request_irq(priv->irq, mx25_gcq_irq, NULL, pdev->name,
> +			priv);
> +	if (ret) {
> +		dev_err(dev, "Failed requesting IRQ\n");
> +		goto err_clk_unprepare;
> +	}
> +
> +	idev->dev.parent = &pdev->dev;
> +	idev->channels = mx25_gcq_channels;
> +	idev->num_channels = ARRAY_SIZE(mx25_gcq_channels);
> +	idev->info = &mx25_gcq_iio_info;
> +
> +	ret = iio_device_register(idev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register iio device\n");
> +		goto err_irq_free;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +err_irq_free:
> +	free_irq(priv->irq, (void *)priv);
> +
> +err_clk_unprepare:
> +	clk_disable_unprepare(priv->clk);
> +
> +	return ret;
> +}
> +
> +static int mx25_gcq_remove(struct platform_device *pdev)
> +{
> +	struct mx25_gcq_priv *priv = platform_get_drvdata(pdev);
> +	struct iio_dev *idev = iio_priv_to_dev(pdev);
> +
> +	iio_device_unregister(idev);
> +	free_irq(priv->irq, (void *)priv);
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id mx25_gcq_ids[] = {
> +	{ .compatible = "fsl,imx25-gcq", },
> +	{ /* Senitel */ }

Sentinel

> +};
> +
> +static struct platform_driver mx25_gcq_driver = {
> +	.driver		= {
> +		.name	= "mx25-gcq",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = mx25_gcq_ids,
> +	},
> +	.probe		= mx25_gcq_probe,
> +	.remove		= mx25_gcq_remove,
> +};
> +module_platform_driver(mx25_gcq_driver);
> +
> +MODULE_DESCRIPTION("ADC driver for Freescale mx25");
> +MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
