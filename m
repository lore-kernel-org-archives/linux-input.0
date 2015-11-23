From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 4/8] mfd: fsl imx25 Touchscreen ADC driver
Date: Mon, 23 Nov 2015 10:17:16 +0100
Message-ID: <3553344.v3fi0IDR4M@adelgunde>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de> <1447675269-8831-5-git-send-email-mpa@pengutronix.de> <5650A3AA.5080705@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart85196029.iQVlY3PcDa"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5650A3AA.5080705-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric =?ISO-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--nextPart85196029.iQVlY3PcDa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Saturday 21 November 2015 17:02:34 Jonathan Cameron wrote:
> On 16/11/15 12:01, Markus Pargmann wrote:
> > This is the core driver for imx25 touchscreen/adc driver. The modul=
e
> > has one shared ADC and two different conversion queues which use th=
e
> > ADC. The two queues are identical. Both can be used for general pur=
pose
> > ADC but one is meant to be used for touchscreens.
> >=20
> > This driver is the core which manages the central components and
> > registers of the TSC/ADC unit. It manages the IRQs and forwards the=
m to
> > the correct components.
> >=20
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> >=20
> > [ensure correct ADC clock depending on the IPG clock]
> > Signed-off-by: Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Looks good to me - one query on meaning of a comment inline.
>=20
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks, comment inline.

>=20
> I'm taking the view this series wants to go through the MFD tree
> but don't mind if it goes through IIO or input instead
> if there is a good reason to do so.
>=20
> Jonathan
> > ---
> >=20
> > Notes:
> >     Changes in v7:
> >      - Cleanup bit defines in header files to be more readable
> >      - Fix irq check to return with an error for irq <=3D 0
> >      - Add COMPILE_TEST in Kconfig file
> >    =20
> >     Changes in v5:
> >      - Remove ifdef CONFIG_OF as this driver is only for DT usage
> >      - Remove module owner
> >      - Add Kconfig dependencies ARCH_MX25 and OF
> >    =20
> >     @Jonathan Cameron:
> >     I left your acked-by on the patch as these were small changes. =
If it should be
> >     removed, please say so. Thanks
> >=20
> >  drivers/mfd/Kconfig             |   9 ++
> >  drivers/mfd/Makefile            |   2 +
> >  drivers/mfd/fsl-imx25-tsadc.c   | 204 ++++++++++++++++++++++++++++=
++++++++++++
> >  include/linux/mfd/imx25-tsadc.h | 140 +++++++++++++++++++++++++++
> >  4 files changed, 355 insertions(+)
> >  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
> >  create mode 100644 include/linux/mfd/imx25-tsadc.h
> >=20
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 4d92df6ef9fe..4222e202ad2b 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -271,6 +271,15 @@ config MFD_MC13XXX_I2C
> >  =09help
> >  =09  Select this if your MC13xxx is connected via an I2C bus.
> > =20
> > +config MFD_MX25_TSADC
> > +=09tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"=

> > +=09select REGMAP_MMIO
> > +=09depends on (SOC_IMX25 && OF) || COMPILE_TEST
> > +=09help
> > +=09  Enable support for the integrated Touchscreen and ADC unit of=
 the
> > +=09  i.MX25 processors. They consist of a conversion queue for gen=
eral
> > +=09  purpose ADC and a queue for Touchscreens.
> > +
> >  config MFD_HI6421_PMIC
> >  =09tristate "HiSilicon Hi6421 PMU/Codec IC"
> >  =09depends on OF
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index a8b76b81b467..5741be88c173 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -81,6 +81,8 @@ obj-$(CONFIG_TWL4030_POWER)    +=3D twl4030-power=
.o
> >  obj-$(CONFIG_MFD_TWL4030_AUDIO)=09+=3D twl4030-audio.o
> >  obj-$(CONFIG_TWL6040_CORE)=09+=3D twl6040.o
> > =20
> > +obj-$(CONFIG_MFD_MX25_TSADC)=09+=3D fsl-imx25-tsadc.o
> > +
> >  obj-$(CONFIG_MFD_MC13XXX)=09+=3D mc13xxx-core.o
> >  obj-$(CONFIG_MFD_MC13XXX_SPI)=09+=3D mc13xxx-spi.o
> >  obj-$(CONFIG_MFD_MC13XXX_I2C)=09+=3D mc13xxx-i2c.o
> > diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-=
tsadc.c
> > new file mode 100644
> > index 000000000000..e67d5ca81e10
> > --- /dev/null
> > +++ b/drivers/mfd/fsl-imx25-tsadc.c
> > @@ -0,0 +1,204 @@
> > +/*
> > + * Copyright (C) 2014-2015 Pengutronix, Markus Pargmann <mpa@pengu=
tronix.de>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify it under
> > + * the terms of the GNU General Public License version 2 as publis=
hed by the
> > + * Free Software Foundation.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqdesc.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/irq.h>
> > +#include <linux/mfd/imx25-tsadc.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +static struct regmap_config mx25_tsadc_regmap_config =3D {
> > +=09.fast_io =3D true,
> > +=09.max_register =3D 8,
> > +=09.reg_bits =3D 32,
> > +=09.val_bits =3D 32,
> > +=09.reg_stride =3D 4,
> > +};
> > +
> > +static void mx25_tsadc_irq_handler(struct irq_desc *desc)
> > +{
> > +=09struct mx25_tsadc *tsadc =3D irq_desc_get_handler_data(desc);
> > +=09struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +=09u32 status;
> > +
> > +=09chained_irq_enter(chip, desc);
> > +
> > +=09regmap_read(tsadc->regs, MX25_TSC_TGSR, &status);
> > +
> > +=09if (status & MX25_TGSR_GCQ_INT)
> > +=09=09generic_handle_irq(irq_find_mapping(tsadc->domain, 1));
> > +
> > +=09if (status & MX25_TGSR_TCQ_INT)
> > +=09=09generic_handle_irq(irq_find_mapping(tsadc->domain, 0));
> > +
> > +=09chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int mx25_tsadc_domain_map(struct irq_domain *d, unsigned in=
t irq,
> > +=09=09=09=09 irq_hw_number_t hwirq)
> > +{
> > +=09struct mx25_tsadc *tsadc =3D d->host_data;
> > +
> > +=09irq_set_chip_data(irq, tsadc);
> > +=09irq_set_chip_and_handler(irq, &dummy_irq_chip,
> > +=09=09=09=09 handle_level_irq);
> > +=09irq_modify_status(irq, IRQ_NOREQUEST, IRQ_NOPROBE);
> > +
> > +=09return 0;
> > +}
> > +
> > +static struct irq_domain_ops mx25_tsadc_domain_ops =3D {
> > +=09.map =3D mx25_tsadc_domain_map,
> > +=09.xlate =3D irq_domain_xlate_onecell,
> > +};
> > +
> > +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> > +=09=09=09=09struct mx25_tsadc *tsadc)
> > +{
> > +=09struct device *dev =3D &pdev->dev;
> > +=09struct device_node *np =3D dev->of_node;
> > +=09int irq;
> > +
> > +=09irq =3D platform_get_irq(pdev, 0);
> > +=09if (irq <=3D 0) {
> > +=09=09dev_err(dev, "Failed to get irq\n");
> > +=09=09return irq;
> > +=09}
> > +
> > +=09tsadc->domain =3D irq_domain_add_simple(np, 2, 0, &mx25_tsadc_d=
omain_ops,
> > +=09=09=09=09=09      tsadc);
> > +=09if (!tsadc->domain) {
> > +=09=09dev_err(dev, "Failed to add irq domain\n");
> > +=09=09return -ENOMEM;
> > +=09}
> > +
> > +=09irq_set_chained_handler(irq, mx25_tsadc_irq_handler);
> > +=09irq_set_handler_data(irq, tsadc);
> > +
> > +=09return 0;
> > +}
> > +
> > +static void mx25_tsadc_setup_clk(struct platform_device *pdev,
> > +=09=09=09=09 struct mx25_tsadc *tsadc)
> > +{
> > +=09unsigned clk_div;
> > +
> > +=09/*
> > +=09 * According to the datasheet the ADC clock should never
> > +=09 * exceed 1,75 MHz. Base clock is the IPG and the ADC unit uses=

> > +=09 * a funny clock divider. To keep the time constant the ADC nee=
ds to do
> > +=09 * one conversion, adapt the ADC internal clock divider to
> > +=09 * the available IPG
> I'm not entirely following this explanation...
> maybe

Thanks, this is indeed a bit misleading. It should be something like th=
is:

=09To keep the ADC conversion time constant adapt the ADC internal cloc=
k
=09divider to the IPG clock rate.

Will fix it.

Best Regards,

Markus

>=20
> ...one conversion, then adapt the ADC...
>=20
> > +=09 */
> > +
> > +=09dev_dbg(&pdev->dev, "Found master clock at %lu Hz\n",
> > +=09=09clk_get_rate(tsadc->clk));
> > +
> > +=09clk_div =3D DIV_ROUND_UP(clk_get_rate(tsadc->clk), 1750000);
> > +=09dev_dbg(&pdev->dev, "Setting up ADC clock divider to %u\n", clk=
_div);
> > +
> > +=09/* adc clock =3D IPG clock / (2 * div + 2) */
> > +=09clk_div -=3D 2;
> > +=09clk_div /=3D 2;
> > +
> > +=09/*
> > +=09 * the ADC clock divider changes its behaviour when values belo=
w 4
> > +=09 * are used: it is fixed to "/ 10" in this case
> > +=09 */
> > +=09clk_div =3D max_t(unsigned, 4, clk_div);
> > +
> > +=09dev_dbg(&pdev->dev, "Resulting ADC conversion clock at %lu Hz\n=
",
> > +=09=09clk_get_rate(tsadc->clk) / (2 * clk_div + 2));
> > +
> > +=09regmap_update_bits(tsadc->regs, MX25_TSC_TGCR,
> > +=09=09=09   MX25_TGCR_ADCCLKCFG(0x1f),
> > +=09=09=09   MX25_TGCR_ADCCLKCFG(clk_div));
> > +}
> > +
> > +static int mx25_tsadc_probe(struct platform_device *pdev)
> > +{
> > +=09struct device *dev =3D &pdev->dev;
> > +=09struct device_node *np =3D dev->of_node;
> > +=09struct mx25_tsadc *tsadc;
> > +=09struct resource *res;
> > +=09int ret;
> > +=09void __iomem *iomem;
> > +
> > +=09tsadc =3D devm_kzalloc(dev, sizeof(*tsadc), GFP_KERNEL);
> > +=09if (!tsadc)
> > +=09=09return -ENOMEM;
> > +
> > +=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +=09iomem =3D devm_ioremap_resource(dev, res);
> > +=09if (IS_ERR(iomem))
> > +=09=09return PTR_ERR(iomem);
> > +
> > +=09tsadc->regs =3D devm_regmap_init_mmio(dev, iomem,
> > +=09=09=09=09=09    &mx25_tsadc_regmap_config);
> > +=09if (IS_ERR(tsadc->regs)) {
> > +=09=09dev_err(dev, "Failed to initialize regmap\n");
> > +=09=09return PTR_ERR(tsadc->regs);
> > +=09}
> > +
> > +=09tsadc->clk =3D devm_clk_get(dev, "ipg");
> > +=09if (IS_ERR(tsadc->clk)) {
> > +=09=09dev_err(dev, "Failed to get ipg clock\n");
> > +=09=09return PTR_ERR(tsadc->clk);
> > +=09}
> > +
> > +=09/* setup clock according to the datasheet */
> > +=09mx25_tsadc_setup_clk(pdev, tsadc);
> > +
> > +=09/* Enable clock and reset the component */
> > +=09regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_CLK_EN=
,
> > +=09=09=09   MX25_TGCR_CLK_EN);
> > +=09regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_TSC_RS=
T,
> > +=09=09=09   MX25_TGCR_TSC_RST);
> > +
> > +=09/* Setup powersaving mode, but enable internal reference voltag=
e */
> > +=09regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_POWERM=
ODE_MASK,
> > +=09=09=09   MX25_TGCR_POWERMODE_SAVE);
> > +=09regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_INTREF=
EN,
> > +=09=09=09   MX25_TGCR_INTREFEN);
> > +
> > +=09ret =3D mx25_tsadc_setup_irq(pdev, tsadc);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09platform_set_drvdata(pdev, tsadc);
> > +
> > +=09of_platform_populate(np, NULL, NULL, dev);
> > +
> > +=09return 0;
> > +}
> > +
> > +static const struct of_device_id mx25_tsadc_ids[] =3D {
> > +=09{ .compatible =3D "fsl,imx25-tsadc" },
> > +=09{ /* Sentinel */ }
> > +};
> > +
> > +static struct platform_driver mx25_tsadc_driver =3D {
> > +=09.driver =3D {
> > +=09=09.name =3D "mx25-tsadc",
> > +=09=09.of_match_table =3D of_match_ptr(mx25_tsadc_ids),
> > +=09},
> > +=09.probe =3D mx25_tsadc_probe,
> > +};
> > +module_platform_driver(mx25_tsadc_driver);
> > +
> > +MODULE_DESCRIPTION("MFD for ADC/TSC for Freescale mx25");
> > +MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:mx25-tsadc");
> > diff --git a/include/linux/mfd/imx25-tsadc.h b/include/linux/mfd/im=
x25-tsadc.h
> > new file mode 100644
> > index 000000000000..7fe4b8c3baac
> > --- /dev/null
> > +++ b/include/linux/mfd/imx25-tsadc.h
> > @@ -0,0 +1,140 @@
> > +#ifndef _LINUX_INCLUDE_MFD_IMX25_TSADC_H_
> > +#define _LINUX_INCLUDE_MFD_IMX25_TSADC_H_
> > +
> > +struct regmap;
> > +struct clk;
> > +
> > +struct mx25_tsadc {
> > +=09struct regmap *regs;
> > +=09struct irq_domain *domain;
> > +=09struct clk *clk;
> > +};
> > +
> > +#define MX25_TSC_TGCR=09=09=090x00
> > +#define MX25_TSC_TGSR=09=09=090x04
> > +#define MX25_TSC_TICR=09=09=090x08
> > +
> > +/* The same register layout for TC and GC queue */
> > +#define MX25_ADCQ_FIFO=09=09=090x00
> > +#define MX25_ADCQ_CR=09=09=090x04
> > +#define MX25_ADCQ_SR=09=09=090x08
> > +#define MX25_ADCQ_MR=09=09=090x0c
> > +#define MX25_ADCQ_ITEM_7_0=09=090x20
> > +#define MX25_ADCQ_ITEM_15_8=09=090x24
> > +#define MX25_ADCQ_CFG(n)=09=09(0x40 + ((n) * 0x4))
> > +
> > +#define MX25_ADCQ_MR_MASK=09=090xffffffff
> > +
> > +/* TGCR */
> > +#define MX25_TGCR_PDBTIME(x)=09=09((x) << 25)
> > +#define MX25_TGCR_PDBTIME_MASK=09=09GENMASK(31, 25)
> > +#define MX25_TGCR_PDBEN=09=09=09BIT(24)
> > +#define MX25_TGCR_PDEN=09=09=09BIT(23)
> > +#define MX25_TGCR_ADCCLKCFG(x)=09=09((x) << 16)
> > +#define MX25_TGCR_GET_ADCCLK(x)=09=09(((x) >> 16) & 0x1f)
> > +#define MX25_TGCR_INTREFEN=09=09BIT(10)
> > +#define MX25_TGCR_POWERMODE_MASK=09GENMASK(9, 8)
> > +#define MX25_TGCR_POWERMODE_SAVE=09(1 << 8)
> > +#define MX25_TGCR_POWERMODE_ON=09=09(2 << 8)
> > +#define MX25_TGCR_STLC=09=09=09BIT(5)
> > +#define MX25_TGCR_SLPC=09=09=09BIT(4)
> > +#define MX25_TGCR_FUNC_RST=09=09BIT(2)
> > +#define MX25_TGCR_TSC_RST=09=09BIT(1)
> > +#define MX25_TGCR_CLK_EN=09=09BIT(0)
> > +
> > +/* TGSR */
> > +#define MX25_TGSR_SLP_INT=09=09BIT(2)
> > +#define MX25_TGSR_GCQ_INT=09=09BIT(1)
> > +#define MX25_TGSR_TCQ_INT=09=09BIT(0)
> > +
> > +/* ADCQ_ITEM_* */
> > +#define _MX25_ADCQ_ITEM(item, x)=09((x) << ((item) * 4))
> > +#define MX25_ADCQ_ITEM(item, x)=09=09((item) >=3D 8 ? \
> > +=09=09_MX25_ADCQ_ITEM((item) - 8, (x)) : _MX25_ADCQ_ITEM((item), (=
x)))
> > +
> > +/* ADCQ_FIFO (TCQFIFO and GCQFIFO) */
> > +#define MX25_ADCQ_FIFO_DATA(x)=09=09(((x) >> 4) & 0xfff)
> > +#define MX25_ADCQ_FIFO_ID(x)=09=09((x) & 0xf)
> > +
> > +/* ADCQ_CR (TCQR and GCQR) */
> > +#define MX25_ADCQ_CR_PDCFG_LEVEL=09BIT(19)
> > +#define MX25_ADCQ_CR_PDMSK=09=09BIT(18)
> > +#define MX25_ADCQ_CR_FRST=09=09BIT(17)
> > +#define MX25_ADCQ_CR_QRST=09=09BIT(16)
> > +#define MX25_ADCQ_CR_RWAIT_MASK=09=09GENMASK(15, 12)
> > +#define MX25_ADCQ_CR_RWAIT(x)=09=09((x) << 12)
> > +#define MX25_ADCQ_CR_WMRK_MASK=09=09GENMASK(11, 8)
> > +#define MX25_ADCQ_CR_WMRK(x)=09=09((x) << 8)
> > +#define MX25_ADCQ_CR_LITEMID_MASK=09(0xf << 4)
> > +#define MX25_ADCQ_CR_LITEMID(x)=09=09((x) << 4)
> > +#define MX25_ADCQ_CR_RPT=09=09BIT(3)
> > +#define MX25_ADCQ_CR_FQS=09=09BIT(2)
> > +#define MX25_ADCQ_CR_QSM_MASK=09=09GENMASK(1, 0)
> > +#define MX25_ADCQ_CR_QSM_PD=09=090x1
> > +#define MX25_ADCQ_CR_QSM_FQS=09=090x2
> > +#define MX25_ADCQ_CR_QSM_FQS_PD=09=090x3
> > +
> > +/* ADCQ_SR (TCQSR and GCQSR) */
> > +#define MX25_ADCQ_SR_FDRY=09=09BIT(15)
> > +#define MX25_ADCQ_SR_FULL=09=09BIT(14)
> > +#define MX25_ADCQ_SR_EMPT=09=09BIT(13)
> > +#define MX25_ADCQ_SR_FDN(x)=09=09(((x) >> 8) & 0x1f)
> > +#define MX25_ADCQ_SR_FRR=09=09BIT(6)
> > +#define MX25_ADCQ_SR_FUR=09=09BIT(5)
> > +#define MX25_ADCQ_SR_FOR=09=09BIT(4)
> > +#define MX25_ADCQ_SR_EOQ=09=09BIT(1)
> > +#define MX25_ADCQ_SR_PD=09=09=09BIT(0)
> > +
> > +/* ADCQ_MR (TCQMR and GCQMR) */
> > +#define MX25_ADCQ_MR_FDRY_DMA=09=09BIT(31)
> > +#define MX25_ADCQ_MR_FER_DMA=09=09BIT(22)
> > +#define MX25_ADCQ_MR_FUR_DMA=09=09BIT(21)
> > +#define MX25_ADCQ_MR_FOR_DMA=09=09BIT(20)
> > +#define MX25_ADCQ_MR_EOQ_DMA=09=09BIT(17)
> > +#define MX25_ADCQ_MR_PD_DMA=09=09BIT(16)
> > +#define MX25_ADCQ_MR_FDRY_IRQ=09=09BIT(15)
> > +#define MX25_ADCQ_MR_FER_IRQ=09=09BIT(6)
> > +#define MX25_ADCQ_MR_FUR_IRQ=09=09BIT(5)
> > +#define MX25_ADCQ_MR_FOR_IRQ=09=09BIT(4)
> > +#define MX25_ADCQ_MR_EOQ_IRQ=09=09BIT(1)
> > +#define MX25_ADCQ_MR_PD_IRQ=09=09BIT(0)
> > +
> > +/* ADCQ_CFG (TICR, TCC0-7,GCC0-7) */
> > +#define MX25_ADCQ_CFG_SETTLING_TIME(x)=09((x) << 24)
> > +#define MX25_ADCQ_CFG_IGS=09=09(1 << 20)
> > +#define MX25_ADCQ_CFG_NOS_MASK=09=09GENMASK(19, 16)
> > +#define MX25_ADCQ_CFG_NOS(x)=09=09(((x) - 1) << 16)
> > +#define MX25_ADCQ_CFG_WIPER=09=09(1 << 15)
> > +#define MX25_ADCQ_CFG_YNLR=09=09(1 << 14)
> > +#define MX25_ADCQ_CFG_YPLL_HIGH=09=09(0 << 12)
> > +#define MX25_ADCQ_CFG_YPLL_OFF=09=09(1 << 12)
> > +#define MX25_ADCQ_CFG_YPLL_LOW=09=09(3 << 12)
> > +#define MX25_ADCQ_CFG_XNUR_HIGH=09=09(0 << 10)
> > +#define MX25_ADCQ_CFG_XNUR_OFF=09=09(1 << 10)
> > +#define MX25_ADCQ_CFG_XNUR_LOW=09=09(3 << 10)
> > +#define MX25_ADCQ_CFG_XPUL_HIGH=09=09(0 << 9)
> > +#define MX25_ADCQ_CFG_XPUL_OFF=09=09(1 << 9)
> > +#define MX25_ADCQ_CFG_REFP(sel)=09=09((sel) << 7)
> > +#define MX25_ADCQ_CFG_REFP_YP=09=09MX25_ADCQ_CFG_REFP(0)
> > +#define MX25_ADCQ_CFG_REFP_XP=09=09MX25_ADCQ_CFG_REFP(1)
> > +#define MX25_ADCQ_CFG_REFP_EXT=09=09MX25_ADCQ_CFG_REFP(2)
> > +#define MX25_ADCQ_CFG_REFP_INT=09=09MX25_ADCQ_CFG_REFP(3)
> > +#define MX25_ADCQ_CFG_REFP_MASK=09=09GENMASK(8, 7)
> > +#define MX25_ADCQ_CFG_IN(sel)=09=09((sel) << 4)
> > +#define MX25_ADCQ_CFG_IN_XP=09=09MX25_ADCQ_CFG_IN(0)
> > +#define MX25_ADCQ_CFG_IN_YP=09=09MX25_ADCQ_CFG_IN(1)
> > +#define MX25_ADCQ_CFG_IN_XN=09=09MX25_ADCQ_CFG_IN(2)
> > +#define MX25_ADCQ_CFG_IN_YN=09=09MX25_ADCQ_CFG_IN(3)
> > +#define MX25_ADCQ_CFG_IN_WIPER=09=09MX25_ADCQ_CFG_IN(4)
> > +#define MX25_ADCQ_CFG_IN_AUX0=09=09MX25_ADCQ_CFG_IN(5)
> > +#define MX25_ADCQ_CFG_IN_AUX1=09=09MX25_ADCQ_CFG_IN(6)
> > +#define MX25_ADCQ_CFG_IN_AUX2=09=09MX25_ADCQ_CFG_IN(7)
> > +#define MX25_ADCQ_CFG_REFN(sel)=09=09((sel) << 2)
> > +#define MX25_ADCQ_CFG_REFN_XN=09=09MX25_ADCQ_CFG_REFN(0)
> > +#define MX25_ADCQ_CFG_REFN_YN=09=09MX25_ADCQ_CFG_REFN(1)
> > +#define MX25_ADCQ_CFG_REFN_NGND=09=09MX25_ADCQ_CFG_REFN(2)
> > +#define MX25_ADCQ_CFG_REFN_NGND2=09MX25_ADCQ_CFG_REFN(3)
> > +#define MX25_ADCQ_CFG_REFN_MASK=09=09GENMASK(3, 2)
> > +#define MX25_ADCQ_CFG_PENIACK=09=09(1 << 1)
> > +
> > +#endif  /* _LINUX_INCLUDE_MFD_IMX25_TSADC_H_ */
> >=20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart85196029.iQVlY3PcDa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWUtmcAAoJEEpcgKtcEGQQap0P/1DLA/L0LPZ2DPlpaiso9sGq
yce4IOj0DQpyyQAi/9UFI+hH/nbgQtpmmTH1ZBqhhv5nbp8pwoGtiOEPaJDle2xR
p/4ga68XpB6yF+MjimFW2EQVkroFbF2ZzY2p37KCNI0RnPhrLU6/rvsMW152BlTD
EXp2t5B0yOszoEEnsb+tO62LFe2Q5gJH/DbTxVebm45B7kC/MGCMfE1ijuxyEEYE
gH4E4kyckDYNpcURz+k7sg2GAJtSWRE12jo7XBCssVuZCgaw8T4a3Zpfi3YrgGyw
+y4gW/oJ6ToLkrP4LOUhwj91zBafqiPmZZIYzEjUjGb0x59harISaEcqIBxovoc0
aJXWoUGnnVJ3tXrRy95PKjO9yOtG60aKjTudRzDtTJrrtZXGMGxmZJBqOyLCpnH9
3nEr80v5e2QHcD3oK+5jf17bMWdFti0jArphhhFONF+gY0IFPOqbn5WOrj0/wK5r
K4P+HHDriElCaeNZ16HwBYeY4A6IgptG19U6SfESRMV15549Xo3AyO1RLypfTTp2
sZhZvcmaVczCdQeSr1/c2dmZBiyC20t2zpOjueIDMsNEdT49vbv9IwaN7ZAaMRX4
FGB/rN9foKEVoPlnVWBnioKHL6Qw6v909pwwbHLP/q1adNW0K+9pmd4oDjq6170p
ra946t7ETf2tw4nFh1Jb
=Emya
-----END PGP SIGNATURE-----

--nextPart85196029.iQVlY3PcDa--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
