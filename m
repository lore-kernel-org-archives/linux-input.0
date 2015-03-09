From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 4/8] mfd: fsl imx25 Touchscreen ADC driver
Date: Mon, 9 Mar 2015 09:27:10 +0000
Message-ID: <20150309092710.GA3427@x1>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <1425369498-25541-5-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425369498-25541-5-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 03 Mar 2015, Markus Pargmann wrote:

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
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>=20
> Notes:
>     Changes in v7:
>      - Cleanup bit defines in header files to be more readable
>      - Fix irq check to return with an error for irq <=3D 0
>      - Add COMPILE_TEST in Kconfig file
>    =20
>     Changes in v5:
>      - Remove ifdef CONFIG_OF as this driver is only for DT usage
>      - Remove module owner
>      - Add Kconfig dependencies ARCH_MX25 and OF
>    =20
>     @Jonathan Cameron:
>     I left your acked-by on the patch as these were small changes. If=
 it should be
>     removed, please say so. Thanks
>=20
>  drivers/mfd/Kconfig             |  10 +++
>  drivers/mfd/Makefile            |   2 +
>  drivers/mfd/fsl-imx25-tsadc.c   | 164 ++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/imx25-tsadc.h | 141 ++++++++++++++++++++++++++++++=
++++
>  4 files changed, 317 insertions(+)
>  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
>  create mode 100644 include/linux/mfd/imx25-tsadc.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 38356e39adba..c0036aef61d7 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -244,6 +244,16 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
> =20
> +config MFD_MX25_TSADC
> +	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
> +	select REGMAP_MMIO
> +	depends on SOC_IMX25 || COMPILE_TEST
> +	depends on OF

Are you sure you can't compile test with OF disabled?

	depends on (SOC_IMX25 && OF) || COMPILE_TEST

> +	help
> +	  Enable support for the integrated Touchscreen and ADC unit of the
> +	  i.MX25 processors. They consist of a conversion queue for general
> +	  purpose ADC and a queue for Touchscreens.
> +
>  config MFD_HI6421_PMIC
>  	tristate "HiSilicon Hi6421 PMU/Codec IC"
>  	depends on OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 19f3d744e3bd..acfe639e147c 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -78,6 +78,8 @@ obj-$(CONFIG_TWL4030_POWER)    +=3D twl4030-power.o
>  obj-$(CONFIG_MFD_TWL4030_AUDIO)	+=3D twl4030-audio.o
>  obj-$(CONFIG_TWL6040_CORE)	+=3D twl6040.o
> =20
> +obj-$(CONFIG_MFD_MX25_TSADC)	+=3D fsl-imx25-tsadc.o
> +
>  obj-$(CONFIG_MFD_MC13XXX)	+=3D mc13xxx-core.o
>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+=3D mc13xxx-spi.o
>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+=3D mc13xxx-i2c.o
> diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-ts=
adc.c
> new file mode 100644
> index 000000000000..c4a3e15001ea
> --- /dev/null
> +++ b/drivers/mfd/fsl-imx25-tsadc.c
> @@ -0,0 +1,164 @@
> +/*
> + * Copyright (C) 2014-2015 Pengutronix, Markus Pargmann <mpa@pengutr=
onix.de>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it under
> + * the terms of the GNU General Public License version 2 as publishe=
d by the
> + * Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/imx25-tsadc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +static struct regmap_config mx25_tsadc_regmap_config =3D {
> +	.fast_io =3D true,
> +	.max_register =3D 8,
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D 4,
> +};
> +
> +static void mx25_tsadc_irq_handler(u32 irq, struct irq_desc *desc)
> +{
> +	struct mx25_tsadc *tsadc =3D irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_get_chip(irq);
> +	u32 status;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	regmap_read(tsadc->regs, MX25_TSC_TGSR, &status);
> +
> +	if (status & MX25_TGSR_GCQ_INT)
> +		generic_handle_irq(irq_find_mapping(tsadc->domain, 1));
> +
> +	if (status & MX25_TGSR_TCQ_INT)
> +		generic_handle_irq(irq_find_mapping(tsadc->domain, 0));
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int mx25_tsadc_domain_map(struct irq_domain *d, unsigned int =
irq,
> +				 irq_hw_number_t hwirq)
> +{
> +	struct mx25_tsadc *tsadc =3D d->host_data;
> +
> +	irq_set_chip_data(irq, tsadc);
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> +				 handle_level_irq);
> +	set_irq_flags(irq, IRQF_VALID);

I think you need to protect this with CONFIG_ARM.

> +	return 0;
> +}
> +
> +static struct irq_domain_ops mx25_tsadc_domain_ops =3D {
> +	.map =3D mx25_tsadc_domain_map,
> +	.xlate =3D irq_domain_xlate_onecell,
> +};
> +
> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> +				struct mx25_tsadc *tsadc)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	int irq;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq <=3D 0) {
> +		dev_err(dev, "Failed to get irq\n");
> +		return irq;
> +	}
> +
> +	tsadc->domain =3D irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domai=
n_ops,
> +					      tsadc);
> +	if (!tsadc->domain) {
> +		dev_err(dev, "Failed to add irq domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_set_chained_handler(irq, mx25_tsadc_irq_handler);
> +	irq_set_handler_data(irq, tsadc);
> +
> +	return 0;
> +}
> +
> +static int mx25_tsadc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct mx25_tsadc *tsadc;
> +	struct resource *res;
> +	int ret;
> +	void __iomem *iomem;
> +
> +	tsadc =3D devm_kzalloc(dev, sizeof(*tsadc), GFP_KERNEL);
> +	if (!tsadc)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	iomem =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(iomem))
> +		return PTR_ERR(iomem);
> +
> +	tsadc->regs =3D devm_regmap_init_mmio(dev, iomem,
> +					    &mx25_tsadc_regmap_config);
> +	if (IS_ERR(tsadc->regs)) {
> +		dev_err(dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(tsadc->regs);
> +	}
> +
> +	tsadc->clk =3D devm_clk_get(dev, "ipg");
> +	if (IS_ERR(tsadc->clk)) {
> +		dev_err(dev, "Failed to get ipg clock\n");
> +		return PTR_ERR(tsadc->clk);
> +	}
> +
> +	/* Enable clock and reset the component */
> +	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_CLK_EN,
> +			   MX25_TGCR_CLK_EN);
> +	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_TSC_RST,
> +			   MX25_TGCR_TSC_RST);
> +
> +	/* Setup powersaving mode, but enable internal reference voltage */
> +	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_POWERMODE_=
MASK,
> +			   MX25_TGCR_POWERMODE_SAVE);
> +	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_INTREFEN,
> +			   MX25_TGCR_INTREFEN);
> +
> +	ret =3D mx25_tsadc_setup_irq(pdev, tsadc);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, tsadc);
> +
> +	of_platform_populate(np, NULL, NULL, dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mx25_tsadc_ids[] =3D {
> +	{ .compatible =3D "fsl,imx25-tsadc" },
> +	{ /* Sentinel */ }
> +};
> +
> +static struct platform_driver mx25_tsadc_driver =3D {
> +	.driver =3D {
> +		.name =3D "mx25-tsadc",
> +		.of_match_table =3D of_match_ptr(mx25_tsadc_ids),
> +	},
> +	.probe =3D mx25_tsadc_probe,

No remove()?  Nothing to clean-up?  Clocks off?  Reset?

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
> index 000000000000..da348ac34a41
> --- /dev/null
> +++ b/include/linux/mfd/imx25-tsadc.h
> @@ -0,0 +1,141 @@
> +#ifndef _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
> +#define _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_

s/INPUT/MFD/

> +struct regmap;
> +struct device;

What's this for?

> +struct clk;
> +
> +struct mx25_tsadc {
> +	struct regmap *regs;
> +	struct irq_domain *domain;
> +	struct clk *clk;
> +};
> +
> +#define MX25_TSC_TGCR			0x00
> +#define MX25_TSC_TGSR			0x04
> +#define MX25_TSC_TICR			0x08
> +
> +/* The same register layout for TC and GC queue */
> +#define MX25_ADCQ_FIFO			0x00
> +#define MX25_ADCQ_CR			0x04
> +#define MX25_ADCQ_SR			0x08
> +#define MX25_ADCQ_MR			0x0c
> +#define MX25_ADCQ_ITEM_7_0		0x20
> +#define MX25_ADCQ_ITEM_15_8		0x24
> +#define MX25_ADCQ_CFG(n)		(0x40 + ((n) * 0x4))
> +
> +#define MX25_ADCQ_MR_MASK		0xffffffff
> +
> +/* TGCR */
> +#define MX25_TGCR_PDBTIME(x)		((x) << 25)
> +#define MX25_TGCR_PDBTIME_MASK		MX25_TGCR_PDBTIME(0x7f)
> +#define MX25_TGCR_PDBEN			BIT(24)
> +#define MX25_TGCR_PDEN			BIT(23)
> +#define MX25_TGCR_ADCCLKCFG(x)		((x) << 16)
> +#define MX25_TGCR_GET_ADCCLK(x)		(((x) >> 16) & 0x1f)
> +#define MX25_TGCR_INTREFEN		BIT(10)
> +#define MX25_TGCR_POWERMODE_MASK	(3 << 8)
> +#define MX25_TGCR_POWERMODE_SAVE	(1 << 8)
> +#define MX25_TGCR_POWERMODE_ON		(2 << 8)
> +#define MX25_TGCR_STLC			BIT(5)
> +#define MX25_TGCR_SLPC			BIT(4)
> +#define MX25_TGCR_FUNC_RST		BIT(2)
> +#define MX25_TGCR_TSC_RST		BIT(1)
> +#define MX25_TGCR_CLK_EN		BIT(0)
> +
> +/* TGSR */
> +#define MX25_TGSR_SLP_INT		BIT(2)
> +#define MX25_TGSR_GCQ_INT		BIT(1)
> +#define MX25_TGSR_TCQ_INT		BIT(0)
> +
> +/* ADCQ_ITEM_* */
> +#define _MX25_ADCQ_ITEM(item, x)	((x) << ((item) * 4))
> +#define MX25_ADCQ_ITEM(item, x)		((item) >=3D 8 ? \
> +		_MX25_ADCQ_ITEM((item) - 8, (x)) : _MX25_ADCQ_ITEM((item), (x)))
> +
> +/* ADCQ_FIFO (TCQFIFO and GCQFIFO) */
> +#define MX25_ADCQ_FIFO_DATA(x)		(((x) >> 4) & 0xfff)
> +#define MX25_ADCQ_FIFO_ID(x)		((x) & 0xf)
> +
> +/* ADCQ_CR (TCQR and GCQR) */
> +#define MX25_ADCQ_CR_PDCFG_LEVEL	BIT(19)
> +#define MX25_ADCQ_CR_PDMSK		BIT(18)
> +#define MX25_ADCQ_CR_FRST		BIT(17)
> +#define MX25_ADCQ_CR_QRST		BIT(16)
> +#define MX25_ADCQ_CR_RWAIT_MASK		(0xf << 12)
> +#define MX25_ADCQ_CR_RWAIT(x)		((x) << 12)
> +#define MX25_ADCQ_CR_WMRK_MASK		(0xf << 8)
> +#define MX25_ADCQ_CR_WMRK(x)		((x) << 8)
> +#define MX25_ADCQ_CR_LITEMID_MASK	(0xf << 4)
> +#define MX25_ADCQ_CR_LITEMID(x)		((x) << 4)
> +#define MX25_ADCQ_CR_RPT		BIT(3)
> +#define MX25_ADCQ_CR_FQS		BIT(2)
> +#define MX25_ADCQ_CR_QSM_MASK		0x3
> +#define MX25_ADCQ_CR_QSM_PD		0x1
> +#define MX25_ADCQ_CR_QSM_FQS		0x2
> +#define MX25_ADCQ_CR_QSM_FQS_PD		0x3
> +
> +/* ADCQ_SR (TCQSR and GCQSR) */
> +#define MX25_ADCQ_SR_FDRY		BIT(15)
> +#define MX25_ADCQ_SR_FULL		BIT(14)
> +#define MX25_ADCQ_SR_EMPT		BIT(13)
> +#define MX25_ADCQ_SR_FDN(x)		(((x) >> 8) & 0x1f)
> +#define MX25_ADCQ_SR_FRR		BIT(6)
> +#define MX25_ADCQ_SR_FUR		BIT(5)
> +#define MX25_ADCQ_SR_FOR		BIT(4)
> +#define MX25_ADCQ_SR_EOQ		BIT(1)
> +#define MX25_ADCQ_SR_PD			BIT(0)
> +
> +/* ADCQ_MR (TCQMR and GCQMR) */
> +#define MX25_ADCQ_MR_FDRY_DMA		BIT(31)
> +#define MX25_ADCQ_MR_FER_DMA		BIT(22)
> +#define MX25_ADCQ_MR_FUR_DMA		BIT(21)
> +#define MX25_ADCQ_MR_FOR_DMA		BIT(20)
> +#define MX25_ADCQ_MR_EOQ_DMA		BIT(17)
> +#define MX25_ADCQ_MR_PD_DMA		BIT(16)
> +#define MX25_ADCQ_MR_FDRY_IRQ		BIT(15)
> +#define MX25_ADCQ_MR_FER_IRQ		BIT(6)
> +#define MX25_ADCQ_MR_FUR_IRQ		BIT(5)
> +#define MX25_ADCQ_MR_FOR_IRQ		BIT(4)
> +#define MX25_ADCQ_MR_EOQ_IRQ		BIT(1)
> +#define MX25_ADCQ_MR_PD_IRQ		BIT(0)
> +
> +/* ADCQ_CFG (TICR, TCC0-7,GCC0-7) */
> +#define MX25_ADCQ_CFG_SETTLING_TIME(x)	((x) << 24)
> +#define MX25_ADCQ_CFG_IGS		(1 << 20)
> +#define MX25_ADCQ_CFG_NOS_MASK		(0xf << 16)
> +#define MX25_ADCQ_CFG_NOS(x)		(((x) - 1) << 16)
> +#define MX25_ADCQ_CFG_WIPER		(1 << 15)
> +#define MX25_ADCQ_CFG_YNLR		(1 << 14)
> +#define MX25_ADCQ_CFG_YPLL_HIGH		(0 << 12)
> +#define MX25_ADCQ_CFG_YPLL_OFF		(1 << 12)
> +#define MX25_ADCQ_CFG_YPLL_LOW		(3 << 12)
> +#define MX25_ADCQ_CFG_XNUR_HIGH		(0 << 10)
> +#define MX25_ADCQ_CFG_XNUR_OFF		(1 << 10)
> +#define MX25_ADCQ_CFG_XNUR_LOW		(3 << 10)
> +#define MX25_ADCQ_CFG_XPUL_HIGH		(0 << 9)
> +#define MX25_ADCQ_CFG_XPUL_OFF		(1 << 9)
> +#define MX25_ADCQ_CFG_REFP(sel)		((sel) << 7)
> +#define MX25_ADCQ_CFG_REFP_YP		(0 << 7)
> +#define MX25_ADCQ_CFG_REFP_XP		(1 << 7)
> +#define MX25_ADCQ_CFG_REFP_EXT		(2 << 7)
> +#define MX25_ADCQ_CFG_REFP_INT		(3 << 7)
> +#define MX25_ADCQ_CFG_REFP_MASK		(3 << 7)
> +#define MX25_ADCQ_CFG_IN(sel)		((sel) << 4)
> +#define MX25_ADCQ_CFG_IN_XP		(0 << 4)
> +#define MX25_ADCQ_CFG_IN_YP		(1 << 4)
> +#define MX25_ADCQ_CFG_IN_XN		(2 << 4)
> +#define MX25_ADCQ_CFG_IN_YN		(3 << 4)
> +#define MX25_ADCQ_CFG_IN_WIPER		(4 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX0		(5 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX1		(6 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX2		(7 << 4)
> +#define MX25_ADCQ_CFG_REFN(sel)		((sel) << 2)
> +#define MX25_ADCQ_CFG_REFN_XN		(0 << 2)
> +#define MX25_ADCQ_CFG_REFN_YN		(1 << 2)
> +#define MX25_ADCQ_CFG_REFN_NGND		(2 << 2)
> +#define MX25_ADCQ_CFG_REFN_NGND2	(3 << 2)
> +#define MX25_ADCQ_CFG_REFN_MASK		(3 << 2)
> +#define MX25_ADCQ_CFG_PENIACK		(1 << 1)
> +
> +#endif  /* _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_ */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
