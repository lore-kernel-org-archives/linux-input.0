From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/6] iio: adc: fsl,imx25-gcq driver
Date: Sat, 21 Jun 2014 11:45:15 +0100
Message-ID: <53A5623B.7090009@kernel.org>
References: <1402910933-20534-1-git-send-email-denis@eukrea.com> <1402910933-20534-3-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402910933-20534-3-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
Cc: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 16/06/14 10:28, Denis Carikli wrote:
> From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>
> This is a conversion queue driver for the mx25 SoC. It uses the central
> ADC which is used by two seperate independent queues. This driver
> prepares different conversion configurations for each possible input.
> For a conversion it creates a conversionqueue of one item with the
> correct configuration for the chosen channel. It then executes the queue
> once and disables the conversion queue afterwards.
>
> The reference voltages are configurable through devicetree subnodes,
> depending on the connections of the ADC inputs.
>
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> ---
> Changelog v2->v3:
> - Fixed compilation: I forgott to tell that this IIO patch was untested
>    in the previous cover letter. Now it is tested at runtime:
>    I left the touchscreen connected but I configured the TSC as an ADC
>    instead, set the refp to internal reference, and the refn to ngnd_adc(3)
>    for the first 4 channels(xp,yp,xn,yn) and observed the values changing
>    while touching the resistive 4-wire touchscreen.
> - MX25_IIO_CHAN now became MX25_GCQ_CHAN and its .address is now gone
>    and the code using it adapted.
> - The instances of struct iio_dev were renamed from idev to indio_dev.
> - regmap_read return value is now checked in mx25_gcq_read_raw.
> - Comparisons with MX25_NUM_CFGS are now fixed
> - Cosmetics fix in a multiline comment.
> ---
>   .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |   54 ++++
>   drivers/iio/adc/Kconfig                            |    7 +
>   drivers/iio/adc/Makefile                           |    1 +
>   drivers/iio/adc/fsl-imx25-gcq.c                    |  342 ++++++++++++++++++++
>   4 files changed, 404 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
>   create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
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
>   	  of SoCs for drivers such as the touchscreen and hwmon to use to share
>   	  this resource.
>
> +config FSL_MX25_ADC
> +	tristate "Freescale MX25 ADC driver"
> +	depends on MFD_MX25_TSADC
> +	help
> +	  Generic Conversion Queue driver used for general purpose ADC in the
> +	  MX25. This driver supports single measurements using the MX25 ADC.
> +
>   config LP8788_ADC
>   	tristate "LP8788 ADC driver"
>   	depends on MFD_LP8788
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9d60f2d..2767fd6 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_AD7887) += ad7887.o
>   obj-$(CONFIG_AD799X) += ad799x.o
>   obj-$(CONFIG_AT91_ADC) += at91_adc.o
>   obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
> +obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
>   obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>   obj-$(CONFIG_MAX1363) += max1363.o
>   obj-$(CONFIG_MCP320X) += mcp320x.o
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> new file mode 100644
> index 0000000..685cac5
> --- /dev/null
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -0,0 +1,342 @@
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
> +#define MX25_CQG_CHAN(chan, id) {\
> +		.type = IIO_VOLTAGE,\
> +		.indexed = 1,\
> +		.channel = chan,\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +		.datasheet_name = id,				\
> +	}
> +
> +static const struct iio_chan_spec mx25_gcq_channels[MX25_NUM_CFGS] = {
> +	MX25_CQG_CHAN(0, "xp"),
> +	MX25_CQG_CHAN(1, "yp"),
> +	MX25_CQG_CHAN(2, "xn"),
> +	MX25_CQG_CHAN(3, "yn"),
> +	MX25_CQG_CHAN(4, "wiper"),
> +	MX25_CQG_CHAN(5, "inaux0"),
> +	MX25_CQG_CHAN(6, "inaux1"),
> +	MX25_CQG_CHAN(7, "inaux2"),
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
> +static int mx25_gcq_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan, int *val, int *val2,
> +		long mask)
> +{
> +	struct mx25_gcq_priv *priv = iio_priv(indio_dev);
> +	long timeout;
> +	u32 data;
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	/* Setup the configuration we want to use */
> +	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
> +			MX25_ADCQ_ITEM(0, chan->channel));
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
> +		dev_err(&indio_dev->dev, "ADC wait for measurement failed\n");
> +		ret = timeout;
> +		goto out;
> +	} else if (timeout == 0) {
> +		dev_err(&indio_dev->dev, "ADC timed out\n");
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	ret = regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
> +	if (ret)
> +		return ret;
> +
> +	*val = MX25_ADCQ_FIFO_DATA(data);
> +
> +	ret = IIO_VAL_INT;
> +
> +out:
> +	mutex_unlock(&indio_dev->mlock);
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
> +	 * configuration for each input
> +	 */
> +	for (i = 0; i < MX25_NUM_CFGS; ++i)
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
> +
> +		if (reg >= MX25_NUM_CFGS) {
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
> +			return -EINVAL;
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
> +	struct iio_dev *indio_dev;
> +	struct mx25_gcq_priv *priv;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	void __iomem *mem;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
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
> +		ret = priv->irq;
> +		goto err_clk_unprepare;
> +	}
> +
> +	ret = request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name,
> +			priv);
> +	if (ret) {
> +		dev_err(dev, "Failed requesting IRQ\n");
> +		goto err_clk_unprepare;
> +	}
> +
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->channels = mx25_gcq_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mx25_gcq_channels);
> +	indio_dev->info = &mx25_gcq_iio_info;
> +
> +	ret = iio_device_register(indio_dev);
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
> +	struct iio_dev *indio_dev = iio_priv_to_dev(pdev);
> +
> +	iio_device_unregister(indio_dev);
> +	free_irq(priv->irq, (void *)priv);
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id mx25_gcq_ids[] = {
> +	{ .compatible = "fsl,imx25-gcq", },
> +	{ /* Sentinel */ }
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
