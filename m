From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] iio: adc: fsl,imx25-gcq driver
Date: Thu, 20 Feb 2014 18:46:26 +0100
Message-ID: <53063F72.9070006@metafoo.de>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1392913312-9030-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392913312-9030-4-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, linux-iio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-input@vger.kernel.org

On 02/20/2014 05:21 PM, Markus Pargmann wrote:
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
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Looks good mostly. Just a couple of minor code-style issues. Try to run 
checkpatch, sparse and friends on your driver before submission. They catch 
most of the stuff that needs to be fixed in this driver.

[..]
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 2209f28..a421445 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -113,6 +113,13 @@ config EXYNOS_ADC
>   	  of SoCs for drivers such as the touchscreen and hwmon to use to share
>   	  this resource.
>
> +config MX25_ADC
> +	tristate "Freescale MX25 ADC driver"
> +	depends on MFD_MX25_TSADC
> +	help
> +	  Generic Conversion Queue driver used for general purpose ADC in the
> +	  MX25. This driver supports single measurements using the MX25 ADC.
> +

alphabetical order

>   config LP8788_ADC
>   	bool "LP8788 ADC driver"
>   	depends on MFD_LP8788
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ba9a10a..63daa2c 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>   obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>   obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
>   obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> +obj-$(CONFIG_MX25_ADC) += fsl-imx25-gcq.o

Here too

[...]

> +const struct iio_chan_spec mx25_gcq_channels[MX25_NUM_CFGS] = {

static

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

> +struct iio_info mx25_gcq_iio_info = {

static const

> +	.read_raw = mx25_gcq_read_raw,
> +};
> +
> +static struct regmap_config mx25_gcq_regconfig = {

const

> +	.fast_io = true,

You don't need to set fast_io since this is already done at the regmap_bus 
level.

> +	.max_register = 0x5c,
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static void mx25_gcq_iio_dev_setup(struct platform_device *pdev,
> +		struct iio_dev *idev)
> +{
> +	idev->dev.parent = &pdev->dev;
> +	idev->channels = mx25_gcq_channels;
> +	idev->num_channels = ARRAY_SIZE(mx25_gcq_channels);
> +	idev->info = &mx25_gcq_iio_info;

Any reason why this needs to be in a separate function and can't be inlined 
in probe()?

> +}
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
> +			dev_err(dev, "reg value is greater than the number of available configuration registers\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = of_property_read_u32(child, "fsl,adc-refn", &refn);
> +		if (ret) {
> +			dev_err(dev, "Failed to get fsl,adc-refn property\n");
> +			return ret;
> +		}
> +
> +		ret = of_property_read_u32(child, "fsl,adc-refp", &refp);
> +		if (ret) {
> +			dev_err(dev, "Failed to get fsl,adc-refp property\n");
> +			return ret;
> +		}

Range check for refp and refn?

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
> +	int irq;
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
> +	if (!mem) {
> +		dev_err(dev, "Failed to get iomem");

devm_ioremap_resource already prints a error message for you

> +		return -ENOMEM;
> +	}
> +
> +	priv->regs = devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
> +	if (IS_ERR(priv->regs)) {
> +		dev_err(dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(priv->regs);
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {

0 is not a valid IRQ number either

> +		dev_err(dev, "Failed to get IRQ\n");
> +		return irq;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, mx25_gcq_irq, IRQF_ONESHOT, pdev->name,
> +			priv);

IRQF_ONESHOT does not make much sense for non-threaded IRQs. Also it is 
probably safer to use the non managed variant of request_irq here.

> +	if (ret) {
> +		dev_err(dev, "Failed requesting IRQ\n");

It usually makes sense to include the error number in the message. Same for 
the other error messages in probe.

> +		return ret;
> +	}
> +
> +	ret = mx25_gcq_setup_cfgs(pdev, priv);
> +	if (ret)
> +		return ret;
> +
> +	mx25_gcq_iio_dev_setup(pdev, idev);
> +
> +	ret = iio_device_register(idev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register iio device\n");
> +		return ret;
> +	}
> +
> +	init_completion(&priv->completed);

Should be done before the interrupt handler is registered. You reference it 
in there.

> +
> +	priv->clk = mx25_tsadc_get_ipg(pdev->dev.parent);
> +	ret = clk_prepare_enable(priv->clk);

The clock should probably also be enabled before the interrupt handler and 
the IIO device are registered.

> +	if (ret) {
> +		dev_err(dev, "Failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int mx25_gcq_remove(struct platform_device *pdev)
> +{
> +	struct mx25_gcq_priv *priv = platform_get_drvdata(pdev);
> +

iio_device_unregister().

> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
