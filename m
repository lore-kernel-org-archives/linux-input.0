From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/6] mfd: fsl imx25 Touchscreen ADC driver
Date: Mon, 16 Jun 2014 12:26:49 +0100
Message-ID: <20140616112649.GQ14323@lee--X1>
References: <1402910933-20534-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402910933-20534-1-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

> From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> This is the core driver for imx25 touchscreen/adc driver. The module
> has one shared ADC and two different conversion queues which use the
> ADC. The two queues are identical. Both can be used for general purpo=
se
> ADC but one is meant to be used for touchscreens.
>=20
> This driver is the core which manages the central components and
> registers of the TSC/ADC unit. It manages the IRQs and forwards them =
to
> the correct components.
>=20
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> ---
> Changelog v2->v3:
> - None
> ---
>  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |   46 ++++
>  drivers/mfd/Kconfig                                |    9 +
>  drivers/mfd/Makefile                               |    2 +
>  drivers/mfd/fsl-imx25-tsadc.c                      |  232 ++++++++++=
++++++++++
>  include/linux/mfd/imx25-tsadc.h                    |  138 ++++++++++=
++
>  5 files changed, 427 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-t=
sadc.txt
>  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
>  create mode 100644 include/linux/mfd/imx25-tsadc.h

[...]

> diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-ts=
adc.c
> new file mode 100644
> index 0000000..10332c2
> --- /dev/null
> +++ b/drivers/mfd/fsl-imx25-tsadc.c

[...]

> +static struct regmap_config mx25_tsadc =3D {
> +	.fast_io =3D true,
> +	.max_register =3D 0x8,

Why are you representing this and this alone, in hex?

> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D 4,
> +};
> +
> +struct regmap *mx25_tsadc_get_regmap(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct mx25_tsadc_priv *priv;
> +
> +	if (!dev)
> +		return NULL;
> +
> +	pdev =3D container_of(dev, struct platform_device, dev);
> +	priv =3D platform_get_drvdata(pdev);
> +	if (IS_ERR_OR_NULL(priv->regs))
> +		return NULL;

What?  Why are you going to all the trouble of requesting driver data
through pdev?

In fact, why have this function at all?  Just pull out the information
you need from the child device driver.

> +	return priv->regs;
> +}
> +EXPORT_SYMBOL(mx25_tsadc_get_regmap);
> +
> +struct clk *mx25_tsadc_get_ipg(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct mx25_tsadc_priv *priv;
> +
> +	if (!dev)
> +		return NULL;
> +
> +	pdev =3D container_of(dev, struct platform_device, dev);
> +	priv =3D platform_get_drvdata(pdev);
> +	if (IS_ERR_OR_NULL(priv->clk))
> +		return NULL;
> +
> +	return priv->clk;

As above - both points.

> +}
> +EXPORT_SYMBOL(mx25_tsadc_get_ipg);

[...]

> +static void mx25_tsadc_nop(struct irq_data *d)
> +{
> +}

Err, no, this is not required.  Just don't populate the call-backs.

> +static int mx25_tsadc_set_wake_nop(struct irq_data *d, unsigned int =
state)
> +{
> +	return 0;
> +}
> +
> +static struct irq_chip mx25_tsadc_irq_chip =3D {
> +	.name =3D "mx25-tsadc",
> +	.irq_ack =3D mx25_tsadc_nop,
> +	.irq_mask =3D mx25_tsadc_nop,
> +	.irq_unmask =3D mx25_tsadc_nop,

No need to do this.

> +	.irq_set_wake =3D mx25_tsadc_set_wake_nop,
> +};
> +
> +static int mx25_tsadc_domain_map(struct irq_domain *d, unsigned int =
irq,
> +			     irq_hw_number_t hwirq)
> +{
> +	struct mx25_tsadc_priv *priv =3D d->host_data;
> +
> +	irq_set_chip_data(irq, priv);
> +	irq_set_chip_and_handler(irq, &mx25_tsadc_irq_chip,
> +				 handle_level_irq);
> +
> +

Too many '\n's here.

> +	set_irq_flags(irq, IRQF_VALID);
> +
> +	return 0;
> +}

[...]

> +static int mx25_tsadc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct mx25_tsadc_priv *priv;
> +	struct resource *iores;

It would be more consistent if you just called this 'res'.

> +	int ret;
> +	void __iomem *iomem;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	iomem =3D devm_ioremap_resource(dev, iores);
> +	if (IS_ERR(iomem)) {
> +		dev_err(dev, "Failed to remap iomem\n");

No need for an error message here, devm_ioremap_resource() is noisy
enough.

> +		return PTR_ERR(iomem);
> +	}
> +
> +	priv->regs =3D regmap_init_mmio(dev, iomem, &mx25_tsadc);

devm_*?

Best to identify the regmap config as such -
mx25_tsadc_regmap_config.

> +	if (IS_ERR(priv->regs)) {
> +		dev_err(dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(priv->regs);
> +	}
> +
> +	priv->clk =3D devm_clk_get(dev, "ipg");
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(dev, "Failed to get ipg clock\n");
> +		return PTR_ERR(priv->clk);
> +	}
> +
> +	/* Enable clock and reset the component */
> +	regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_CLK_EN,
> +			MX25_TGCR_CLK_EN);
> +	regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_TSC_RST,
> +			MX25_TGCR_TSC_RST);
> +
> +	/* Setup powersaving mode, but enable internal reference voltage */
> +	regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_POWERMODE_M=
ASK,
> +			MX25_TGCR_POWERMODE_SAVE);
> +	regmap_update_bits(priv->regs, MX25_TSC_TGCR, MX25_TGCR_INTREFEN,
> +			MX25_TGCR_INTREFEN);
> +
> +	ret =3D mx25_tsadc_setup_irq(pdev, priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to setup irqs\n");

mx25_tsadc_setup_irq() is noisy enough.  No need for added prints.

> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	of_platform_populate(np, NULL, NULL, dev);
> +
> +	dev_info(dev, "i.MX25 Touchscreen and ADC core driver loaded\n");

Remove this.

> +	return 0;
> +}
> +
> +static const struct of_device_id mx25_tsadc_ids[] =3D {
> +	{ .compatible =3D "fsl,imx25-tsadc", },

No need for the ',' after the '"'.

> +	{ /* Sentinel */ }
> +};
> +
> +static struct platform_driver mx25_tsadc_driver =3D {
> +	.driver		=3D {

You're lining up '=3D' from different layers here.  I suggest you don't
do that.

> +		.name	=3D "mx25-tsadc",
> +		.owner	=3D THIS_MODULE,
> +		.of_match_table =3D mx25_tsadc_ids,

If this driver DT only?

> +	},
> +	.probe		=3D mx25_tsadc_probe,
> +};
> +module_platform_driver(mx25_tsadc_driver);
> +
> +MODULE_DESCRIPTION("MFD for ADC/TSC for Freescale mx25");
> +MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:mx25-tsadc");
> diff --git a/include/linux/mfd/imx25-tsadc.h b/include/linux/mfd/imx2=
5-tsadc.h
> new file mode 100644
> index 0000000..6fba341
> --- /dev/null
> +++ b/include/linux/mfd/imx25-tsadc.h
> @@ -0,0 +1,138 @@
> +#ifndef _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
> +#define _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
> +
> +struct regmap;
> +struct device;
> +struct clk;
> +
> +struct regmap *mx25_tsadc_get_regmap(struct device *dev);
> +struct clk *mx25_tsadc_get_ipg(struct device *dev);

Remove these, they're pointless.

> +#define MX25_TSC_TGCR 0x00
> +#define MX25_TSC_TGSR 0x04
> +#define MX25_TSC_TICR 0x08
> +
> +/* The same register layout for TC and GC queue */
> +#define MX25_ADCQ_FIFO 0x00
> +#define MX25_ADCQ_CR 0x04
> +#define MX25_ADCQ_SR 0x08
> +#define MX25_ADCQ_MR 0x0c
> +#define MX25_ADCQ_ITEM_7_0 0x20
> +#define MX25_ADCQ_ITEM_15_8 0x24
> +#define MX25_ADCQ_CFG(n) (0x40 + ((n) * 0x4))
> +
> +/* Register values */
> +/* Queue Config register */
> +#define MX25_ADCQ_MR_MASK 0xffffffff
> +
> +/* TGCR */
> +#define MX25_TGCR_PDBTIME(x) ((x) << 25)
> +#define MX25_TGCR_PDBTIME_MASK MX25_TGCR_PDBTIME(0x7f)
> +#define MX25_TGCR_PDBEN (1 << 24)
> +#define MX25_TGCR_PDEN (1 << 23)
> +#define MX25_TGCR_ADCCLKCFG(x) ((x) << 16)
> +#define MX25_TGCR_GET_ADCCLK(x) (((x) >> 16) & 0x1f)
> +#define MX25_TGCR_INTREFEN (1 << 10)
> +#define MX25_TGCR_POWERMODE_MASK (3 << 8)
> +#define MX25_TGCR_POWERMODE_SAVE (1 << 8)
> +#define MX25_TGCR_POWERMODE_ON (2 << 8)
> +#define MX25_TGCR_STLC (1 << 5)
> +#define MX25_TGCR_SLPC (1 << 4)
> +#define MX25_TGCR_FUNC_RST (1 << 2)
> +#define MX25_TGCR_TSC_RST (1 << 1)
> +#define MX25_TGCR_CLK_EN (1 << 0)

The (1 << X)'s can be replaced with BIT(X).

> +/* TGSR */
> +#define MX25_TGSR_SLP_INT (1 << 2)
> +#define MX25_TGSR_GCQ_INT (1 << 1)
> +#define MX25_TGSR_TCQ_INT (1 << 0)
> +
> +/* ADCQ_ITEM_* */
> +#define _MX25_ADCQ_ITEM(item, x) ((x) << ((item) * 4))
> +#define MX25_ADCQ_ITEM(item, x) ((item) >=3D 8 ? \
> +		_MX25_ADCQ_ITEM((item) - 8, (x)) : _MX25_ADCQ_ITEM((item), (x)))
> +
> +/* ADCQ_FIFO (TCQFIFO and GCQFIFO) */
> +#define MX25_ADCQ_FIFO_DATA(x) (((x) >> 4) & 0xfff)
> +#define MX25_ADCQ_FIFO_ID(x) ((x) & 0xf)
> +
> +/* ADCQ_CR (TCQR and GCQR) */
> +#define MX25_ADCQ_CR_PDCFG_LEVEL (1 << 19)
> +#define MX25_ADCQ_CR_PDMSK (1 << 18)
> +#define MX25_ADCQ_CR_FRST (1 << 17)
> +#define MX25_ADCQ_CR_QRST (1 << 16)
> +#define MX25_ADCQ_CR_RWAIT_MASK (0xf << 12)
> +#define MX25_ADCQ_CR_RWAIT(x) ((x) << 12)
> +#define MX25_ADCQ_CR_WMRK_MASK (0xf << 8)
> +#define MX25_ADCQ_CR_WMRK(x) ((x) << 8)
> +#define MX25_ADCQ_CR_LITEMID_MASK (0xf << 4)
> +#define MX25_ADCQ_CR_LITEMID(x) ((x) << 4)
> +#define MX25_ADCQ_CR_RPT (1 << 3)
> +#define MX25_ADCQ_CR_FQS (1 << 2)
> +#define MX25_ADCQ_CR_QSM_MASK 0x3
> +#define MX25_ADCQ_CR_QSM_PD 0x1
> +#define MX25_ADCQ_CR_QSM_FQS 0x2
> +#define MX25_ADCQ_CR_QSM_FQS_PD 0x3
> +
> +/* ADCQ_SR (TCQSR and GCQSR) */
> +#define MX25_ADCQ_SR_FDRY (1 << 15)
> +#define MX25_ADCQ_SR_FULL (1 << 14)
> +#define MX25_ADCQ_SR_EMPT (1 << 13)
> +#define MX25_ADCQ_SR_FDN(x) (((x) >> 8) & 0x1f)
> +#define MX25_ADCQ_SR_FRR (1 << 6)
> +#define MX25_ADCQ_SR_FUR (1 << 5)
> +#define MX25_ADCQ_SR_FOR (1 << 4)
> +#define MX25_ADCQ_SR_EOQ (1 << 1)
> +#define MX25_ADCQ_SR_PD (1 << 0)
> +
> +/* ADCQ_MR (TCQMR and GCQMR) */
> +#define MX25_ADCQ_MR_FDRY_DMA (1 << 31)
> +#define MX25_ADCQ_MR_FER_DMA (1 << 22)
> +#define MX25_ADCQ_MR_FUR_DMA (1 << 21)
> +#define MX25_ADCQ_MR_FOR_DMA (1 << 20)
> +#define MX25_ADCQ_MR_EOQ_DMA (1 << 17)
> +#define MX25_ADCQ_MR_PD_DMA (1 << 16)
> +#define MX25_ADCQ_MR_FDRY_IRQ (1 << 15)
> +#define MX25_ADCQ_MR_FER_IRQ (1 << 6)
> +#define MX25_ADCQ_MR_FUR_IRQ (1 << 5)
> +#define MX25_ADCQ_MR_FOR_IRQ (1 << 4)
> +#define MX25_ADCQ_MR_EOQ_IRQ (1 << 1)
> +#define MX25_ADCQ_MR_PD_IRQ (1 << 0)
> +
> +/* ADCQ_CFG (TICR, TCC0-7,GCC0-7) */
> +#define MX25_ADCQ_CFG_SETTLING_TIME(x) ((x) << 24)
> +#define MX25_ADCQ_CFG_IGS (1 << 20)
> +#define MX25_ADCQ_CFG_NOS_MASK (0xf << 16)
> +#define MX25_ADCQ_CFG_NOS(x) (((x) - 1) << 16)
> +#define MX25_ADCQ_CFG_WIPER (1 << 15)
> +#define MX25_ADCQ_CFG_YNLR (1 << 14)
> +#define MX25_ADCQ_CFG_YPLL_HIGH 0
> +#define MX25_ADCQ_CFG_YPLL_OFF (1 << 12)
> +#define MX25_ADCQ_CFG_YPLL_LOW (3 << 12)
> +#define MX25_ADCQ_CFG_XNUR_HIGH 0
> +#define MX25_ADCQ_CFG_XNUR_OFF (1 << 10)
> +#define MX25_ADCQ_CFG_XNUR_LOW (3 << 10)
> +#define MX25_ADCQ_CFG_XPUL_OFF (1 << 9)
> +#define MX25_ADCQ_CFG_XPUL_HIGH 0
> +#define MX25_ADCQ_CFG_REFP_YP 0
> +#define MX25_ADCQ_CFG_REFP_XP (1 << 7)
> +#define MX25_ADCQ_CFG_REFP_EXT (2 << 7)
> +#define MX25_ADCQ_CFG_REFP_INT (3 << 7)
> +#define MX25_ADCQ_CFG_REFP_MASK (3 << 7)
> +#define MX25_ADCQ_CFG_IN_XP 0
> +#define MX25_ADCQ_CFG_IN_YP (1 << 4)
> +#define MX25_ADCQ_CFG_IN_XN (2 << 4)
> +#define MX25_ADCQ_CFG_IN_YN (3 << 4)
> +#define MX25_ADCQ_CFG_IN_WIPER (4 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX0 (5 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX1 (6 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX2 (7 << 4)
> +#define MX25_ADCQ_CFG_REFN_XN 0
> +#define MX25_ADCQ_CFG_REFN_YN (1 << 2)
> +#define MX25_ADCQ_CFG_REFN_NGND (2 << 2)
> +#define MX25_ADCQ_CFG_REFN_NGND2 (3 << 2)
> +#define MX25_ADCQ_CFG_REFN_MASK (3 << 2)
> +#define MX25_ADCQ_CFG_PENIACK (1 << 1)

Can you line up all of the definitions for the entire file with tabs.
They are currently incredibly hard to read.

> +
> +

Extra '\n'.
> +#endif  /* _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_ */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
