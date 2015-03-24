From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v7 4/8] mfd: fsl imx25 Touchscreen ADC driver
Date: Tue, 24 Mar 2015 15:33:14 +0100
Message-ID: <20150324143314.GF28604@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <1425369498-25541-5-git-send-email-mpa@pengutronix.de>
 <20150309092710.GA3427@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33032 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbbCXOjr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 10:39:47 -0400
Content-Disposition: inline
In-Reply-To: <20150309092710.GA3427@x1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>


--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the late reply,

On Mon, Mar 09, 2015 at 09:27:10AM +0000, Lee Jones wrote:
> On Tue, 03 Mar 2015, Markus Pargmann wrote:
>=20
> > This is the core driver for imx25 touchscreen/adc driver. The module
> > has one shared ADC and two different conversion queues which use the
> > ADC. The two queues are identical. Both can be used for general purpose
> > ADC but one is meant to be used for touchscreens.
> >=20
> > This driver is the core which manages the central components and
> > registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> > the correct components.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
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
> >     I left your acked-by on the patch as these were small changes. If i=
t should be
> >     removed, please say so. Thanks
> >=20
> >  drivers/mfd/Kconfig             |  10 +++
> >  drivers/mfd/Makefile            |   2 +
> >  drivers/mfd/fsl-imx25-tsadc.c   | 164 ++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/mfd/imx25-tsadc.h | 141 ++++++++++++++++++++++++++++++++=
++
> >  4 files changed, 317 insertions(+)
> >  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
> >  create mode 100644 include/linux/mfd/imx25-tsadc.h
> >=20
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 38356e39adba..c0036aef61d7 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -244,6 +244,16 @@ config MFD_MC13XXX_I2C
> >  	help
> >  	  Select this if your MC13xxx is connected via an I2C bus.
> > =20
> > +config MFD_MX25_TSADC
> > +	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
> > +	select REGMAP_MMIO
> > +	depends on SOC_IMX25 || COMPILE_TEST
> > +	depends on OF
>=20
> Are you sure you can't compile test with OF disabled?
>=20
> 	depends on (SOC_IMX25 && OF) || COMPILE_TEST

Yes, should be possible without OF.

>=20
> > +	help
> > +	  Enable support for the integrated Touchscreen and ADC unit of the
> > +	  i.MX25 processors. They consist of a conversion queue for general
> > +	  purpose ADC and a queue for Touchscreens.
> > +
> >  config MFD_HI6421_PMIC
> >  	tristate "HiSilicon Hi6421 PMU/Codec IC"
> >  	depends on OF
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 19f3d744e3bd..acfe639e147c 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -78,6 +78,8 @@ obj-$(CONFIG_TWL4030_POWER)    +=3D twl4030-power.o
> >  obj-$(CONFIG_MFD_TWL4030_AUDIO)	+=3D twl4030-audio.o
> >  obj-$(CONFIG_TWL6040_CORE)	+=3D twl6040.o
> > =20
> > +obj-$(CONFIG_MFD_MX25_TSADC)	+=3D fsl-imx25-tsadc.o
> > +
> >  obj-$(CONFIG_MFD_MC13XXX)	+=3D mc13xxx-core.o
> >  obj-$(CONFIG_MFD_MC13XXX_SPI)	+=3D mc13xxx-spi.o
> >  obj-$(CONFIG_MFD_MC13XXX_I2C)	+=3D mc13xxx-i2c.o
> > diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsad=
c.c
> > new file mode 100644
> > index 000000000000..c4a3e15001ea
> > --- /dev/null
> > +++ b/drivers/mfd/fsl-imx25-tsadc.c
> > @@ -0,0 +1,164 @@
> > +/*
> > + * Copyright (C) 2014-2015 Pengutronix, Markus Pargmann <mpa@pengutron=
ix.de>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it under
> > + * the terms of the GNU General Public License version 2 as published =
by the
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
> > +	.fast_io =3D true,
> > +	.max_register =3D 8,
> > +	.reg_bits =3D 32,
> > +	.val_bits =3D 32,
> > +	.reg_stride =3D 4,
> > +};
> > +
> > +static void mx25_tsadc_irq_handler(u32 irq, struct irq_desc *desc)
> > +{
> > +	struct mx25_tsadc *tsadc =3D irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip =3D irq_get_chip(irq);
> > +	u32 status;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	regmap_read(tsadc->regs, MX25_TSC_TGSR, &status);
> > +
> > +	if (status & MX25_TGSR_GCQ_INT)
> > +		generic_handle_irq(irq_find_mapping(tsadc->domain, 1));
> > +
> > +	if (status & MX25_TGSR_TCQ_INT)
> > +		generic_handle_irq(irq_find_mapping(tsadc->domain, 0));
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int mx25_tsadc_domain_map(struct irq_domain *d, unsigned int ir=
q,
> > +				 irq_hw_number_t hwirq)
> > +{
> > +	struct mx25_tsadc *tsadc =3D d->host_data;
> > +
> > +	irq_set_chip_data(irq, tsadc);
> > +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> > +				 handle_level_irq);
> > +	set_irq_flags(irq, IRQF_VALID);
>=20
> I think you need to protect this with CONFIG_ARM.

Yes, added ifdef around set_irq_flags for IRQF_VALID.

>=20
> > +	return 0;
> > +}
> > +
> > +static struct irq_domain_ops mx25_tsadc_domain_ops =3D {
> > +	.map =3D mx25_tsadc_domain_map,
> > +	.xlate =3D irq_domain_xlate_onecell,
> > +};
> > +
> > +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> > +				struct mx25_tsadc *tsadc)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	int irq;
> > +
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq <=3D 0) {
> > +		dev_err(dev, "Failed to get irq\n");
> > +		return irq;
> > +	}
> > +
> > +	tsadc->domain =3D irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domain_=
ops,
> > +					      tsadc);
> > +	if (!tsadc->domain) {
> > +		dev_err(dev, "Failed to add irq domain\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	irq_set_chained_handler(irq, mx25_tsadc_irq_handler);
> > +	irq_set_handler_data(irq, tsadc);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mx25_tsadc_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct mx25_tsadc *tsadc;
> > +	struct resource *res;
> > +	int ret;
> > +	void __iomem *iomem;
> > +
> > +	tsadc =3D devm_kzalloc(dev, sizeof(*tsadc), GFP_KERNEL);
> > +	if (!tsadc)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	iomem =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(iomem))
> > +		return PTR_ERR(iomem);
> > +
> > +	tsadc->regs =3D devm_regmap_init_mmio(dev, iomem,
> > +					    &mx25_tsadc_regmap_config);
> > +	if (IS_ERR(tsadc->regs)) {
> > +		dev_err(dev, "Failed to initialize regmap\n");
> > +		return PTR_ERR(tsadc->regs);
> > +	}
> > +
> > +	tsadc->clk =3D devm_clk_get(dev, "ipg");
> > +	if (IS_ERR(tsadc->clk)) {
> > +		dev_err(dev, "Failed to get ipg clock\n");
> > +		return PTR_ERR(tsadc->clk);
> > +	}
> > +
> > +	/* Enable clock and reset the component */
> > +	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_CLK_EN,
> > +			   MX25_TGCR_CLK_EN);
> > +	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_TSC_RST,
> > +			   MX25_TGCR_TSC_RST);
> > +
> > +	/* Setup powersaving mode, but enable internal reference voltage */
> > +	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_POWERMODE_MA=
SK,
> > +			   MX25_TGCR_POWERMODE_SAVE);
> > +	regmap_update_bits(tsadc->regs, MX25_TSC_TGCR, MX25_TGCR_INTREFEN,
> > +			   MX25_TGCR_INTREFEN);
> > +
> > +	ret =3D mx25_tsadc_setup_irq(pdev, tsadc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	platform_set_drvdata(pdev, tsadc);
> > +
> > +	of_platform_populate(np, NULL, NULL, dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id mx25_tsadc_ids[] =3D {
> > +	{ .compatible =3D "fsl,imx25-tsadc" },
> > +	{ /* Sentinel */ }
> > +};
> > +
> > +static struct platform_driver mx25_tsadc_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "mx25-tsadc",
> > +		.of_match_table =3D of_match_ptr(mx25_tsadc_ids),
> > +	},
> > +	.probe =3D mx25_tsadc_probe,
>=20
> No remove()?  Nothing to clean-up?  Clocks off?  Reset?

No, Everything should cleanup on its own. No clocks enabled. This driver
mainly sets up some configuration for the other drivers using this unit.

>=20
> > +};
> > +module_platform_driver(mx25_tsadc_driver);
> > +
> > +MODULE_DESCRIPTION("MFD for ADC/TSC for Freescale mx25");
> > +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:mx25-tsadc");
> > diff --git a/include/linux/mfd/imx25-tsadc.h b/include/linux/mfd/imx25-=
tsadc.h
> > new file mode 100644
> > index 000000000000..da348ac34a41
> > --- /dev/null
> > +++ b/include/linux/mfd/imx25-tsadc.h
> > @@ -0,0 +1,141 @@
> > +#ifndef _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
> > +#define _LINUX_INCLUDE_INPUT_IMX25_TSADC_H_
>=20
> s/INPUT/MFD/

Fixed.

>=20
> > +struct regmap;
> > +struct device;
>=20
> What's this for?

Removed struct device. It was a leftover from a previous version.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEXWqAAoJEEpcgKtcEGQQhM4P/3qoiLy9dkzrAltE/aE12Q4M
/8xsvCn5M1Y+bZbWA/Ymj8n3ROPZCO7GxQfGTWuKREcwIQDGkvlyMDdJA1jtoZ1j
uOHvcZBld+MT+7k7qk6rGqiyG1W68MHMxaHWqB6D1MuyYwGm1RYsRkWHi2v3oakw
ygNbnA1YPVgrR9+/XtiUrxPc1/n5guTPCIKHkTyM5Dj+I3ByjX4/cow+J9sSCqG7
rAga+fOKGIA4vNlbtTnBNRYFWo2DOVQrzcoSjhWSYcCqqEDXXINQoDXrSZS2mo2+
eiY2oW4LkDsFV69FLF1HipOpN1P4gU+CzOtrEFGk5pVaS6IfXTVa1Ih/wyGbezGA
LjIk9Ho4IzMRoemT4vHQ0yY7PJUkKbyTWR8XQJRViyiE+nQE8qzwNaVVp43VlcTU
B6wJq+YY6kig43cGJ1X7aR3BCM3zBgew2LA0y1f5FedwMWJGDLhJHbtxVtxAkFU3
be74ph0Mmz1dnGlbVjf4Vd1Y6n+YJLGLsqsgyd0OTn71PbS6Utexrxc/BbbQexk8
lWmXPq0boTNTtIEZoZn5ctlFXyaof7fJpBCQFbsaGZNBZJJzsxsgun5tvKeZ/H/u
U1HauaN76XG9YSarSMP5GwujuJiWGGiWLJvGucOuQ3HkF6TxYmJwld/4H7zLvc+O
2OkzrjVPuNl8dAEOvXuz
=F7m7
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--
