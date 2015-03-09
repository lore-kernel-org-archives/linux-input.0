From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v7 5/8] iio: adc: fsl,imx25-gcq driver
Date: Mon, 9 Mar 2015 10:22:20 +0100
Message-ID: <20150309092220.GB3632@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <1425369498-25541-6-git-send-email-mpa@pengutronix.de>
 <54FB3D80.6070806@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38882 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbbCIJWz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 05:22:55 -0400
Content-Disposition: inline
In-Reply-To: <54FB3D80.6070806@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 07, 2015 at 06:03:44PM +0000, Jonathan Cameron wrote:
> On 03/03/15 07:58, Markus Pargmann wrote:
> > This is a conversion queue driver for the mx25 SoC. It uses the central
> > ADC which is used by two seperate independent queues. This driver
> > prepares different conversion configurations for each possible input.
> > For a conversion it creates a conversionqueue of one item with the
> > correct configuration for the chosen channel. It then executes the queue
> > once and disables the conversion queue afterwards.
> >=20
> > The reference voltages are configurable through devicetree subnodes,
> > depending on the connections of the ADC inputs.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> There's an unbalanced regulator_enable that needs fixing.
> Deal with that in both the remove and the error cases
> and I'm happy.
>=20
> > ---
> >=20
> > Notes:
> >     Changes in v7:
> >      - Remove separate functions mx25_gcq_disable/enable_eoq() as they =
were used at
> >        only one position
> >      - Enforce an external reference regulator if one of the conversion=
s uses it as
> >        reference. The devm_regulator_get() call was moved into
> >        mx25_gcq_setup_cfgs() to be able to acquire the reference regula=
tor when
> >        necessary.
> >      - Store indio_dev as platform driver data instead of the private d=
ata. This
> >        was changed in probe() and remove().
> >    =20
> >     Changes in v6:
> >      - Added defines for a complete list of references in the dt bindin=
g macros
> >=20
> >  drivers/iio/adc/Kconfig                     |   7 +
> >  drivers/iio/adc/Makefile                    |   1 +
> >  drivers/iio/adc/fsl-imx25-gcq.c             | 356 ++++++++++++++++++++=
++++++++
> >  include/dt-bindings/iio/adc/fsl-imx25-gcq.h |  18 ++
> >  4 files changed, 382 insertions(+)
> >  create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
> >  create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 202daf889be2..947805d03d6c 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -154,6 +154,13 @@ config EXYNOS_ADC
> >  	  of SoCs for drivers such as the touchscreen and hwmon to use to sha=
re
> >  	  this resource.
> > =20
> > +config FSL_MX25_ADC
> > +	tristate "Freescale MX25 ADC driver"
> > +	depends on MFD_MX25_TSADC
> > +	help
> > +	  Generic Conversion Queue driver used for general purpose ADC in the
> > +	  MX25. This driver supports single measurements using the MX25 ADC.
> > +
> >  config LP8788_ADC
> >  	tristate "LP8788 ADC driver"
> >  	depends on MFD_LP8788
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 0315af640866..409583975ba0 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -17,6 +17,7 @@ obj-$(CONFIG_AT91_ADC) +=3D at91_adc.o
> >  obj-$(CONFIG_AXP288_ADC) +=3D axp288_adc.o
> >  obj-$(CONFIG_CC10001_ADC) +=3D cc10001_adc.o
> >  obj-$(CONFIG_EXYNOS_ADC) +=3D exynos_adc.o
> > +obj-$(CONFIG_FSL_MX25_ADC) +=3D fsl-imx25-gcq.o
> >  obj-$(CONFIG_LP8788_ADC) +=3D lp8788_adc.o
> >  obj-$(CONFIG_MAX1027) +=3D max1027.o
> >  obj-$(CONFIG_MAX1363) +=3D max1363.o
> > diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx2=
5-gcq.c
> > new file mode 100644
> > index 000000000000..18c21888aa4e
> > --- /dev/null
> > +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> > @@ -0,0 +1,356 @@
> > +/*
> > + * Copyright (C) 2014-2015 Pengutronix, Markus Pargmann <mpa@pengutron=
ix.de>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it under
> > + * the terms of the GNU General Public License version 2 as published =
by the
> > + * Free Software Foundation.
> > + *
> > + * This is the driver for the imx25 GCQ (Generic Conversion Queue)
> > + * connected to the imx25 ADC.
> > + */
> > +
> > +#include <dt-bindings/iio/adc/fsl-imx25-gcq.h>
> > +#include <linux/clk.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/imx25-tsadc.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#define MX25_GCQ_TIMEOUT (msecs_to_jiffies(2000))
> > +
> > +enum mx25_gcq_cfgs {
> > +	MX25_CFG_XP =3D 0,
> > +	MX25_CFG_YP,
> > +	MX25_CFG_XN,
> > +	MX25_CFG_YN,
> > +	MX25_CFG_WIPER,
> > +	MX25_CFG_INAUX0,
> > +	MX25_CFG_INAUX1,
> > +	MX25_CFG_INAUX2,
> > +	MX25_NUM_CFGS,
> > +};
> > +
> > +struct mx25_gcq_priv {
> > +	struct regmap *regs;
> > +	struct completion completed;
> > +	unsigned int settling_time;
> > +	struct clk *clk;
> > +	int irq;
> > +	struct regulator *ext_vref;
> > +	u32 channel_vref_mv[MX25_NUM_CFGS];
> > +};
> > +
> > +#define MX25_CQG_CHAN(chan, id) {\
> > +	.type =3D IIO_VOLTAGE,\
> > +	.indexed =3D 1,\
> > +	.channel =3D chan,\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),\
> > +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),\
> > +	.datasheet_name =3D id,\
> > +}
> > +
> > +static const struct iio_chan_spec mx25_gcq_channels[MX25_NUM_CFGS] =3D=
 {
> > +	MX25_CQG_CHAN(0, "xp"),
> > +	MX25_CQG_CHAN(1, "yp"),
> > +	MX25_CQG_CHAN(2, "xn"),
> > +	MX25_CQG_CHAN(3, "yn"),
> > +	MX25_CQG_CHAN(4, "wiper"),
> > +	MX25_CQG_CHAN(5, "inaux0"),
> > +	MX25_CQG_CHAN(6, "inaux1"),
> > +	MX25_CQG_CHAN(7, "inaux2"),
> > +};
> > +
> > +static irqreturn_t mx25_gcq_irq(int irq, void *data)
> > +{
> > +	struct mx25_gcq_priv *priv =3D data;
> > +	u32 stats;
> > +
> > +	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
> > +
> > +	if (stats & MX25_ADCQ_SR_EOQ) {
> > +		regmap_update_bits(priv->regs, MX25_ADCQ_MR,
> > +				   MX25_ADCQ_MR_EOQ_IRQ, MX25_ADCQ_MR_EOQ_IRQ);
> > +		complete(&priv->completed);
> > +	}
> > +
> > +	/* Disable conversion queue run */
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, 0);
> > +
> > +	/* Acknowledge all possible irqs */
> > +	regmap_write(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |
> > +		     MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR |
> > +		     MX25_ADCQ_SR_EOQ | MX25_ADCQ_SR_PD);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mx25_gcq_get_raw_value(struct device *dev,
> > +				  struct iio_chan_spec const *chan,
> > +				  struct mx25_gcq_priv *priv,
> > +				  int *val)
> > +{
> > +	long timeout;
> > +	u32 data;
> > +
> > +	/* Setup the configuration we want to use */
> > +	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
> > +		     MX25_ADCQ_ITEM(0, chan->channel));
> > +
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_IRQ, 0);
> > +
> > +	/* Trigger queue for one run */
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
> > +			   MX25_ADCQ_CR_FQS);
> > +
> > +	timeout =3D wait_for_completion_interruptible_timeout(
> > +		&priv->completed, MX25_GCQ_TIMEOUT);
> > +	if (timeout < 0) {
> > +		dev_err(dev,
> > +			"ADC wait for measurement failed\n");
> > +		return timeout;
> > +	} else if (timeout =3D=3D 0) {
> > +		dev_err(dev, "ADC timed out\n");
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
> > +
> > +	*val =3D MX25_ADCQ_FIFO_DATA(data);
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int mx25_gcq_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan, int *val,
> > +			     int *val2, long mask)
> > +{
> > +	struct mx25_gcq_priv *priv =3D iio_priv(indio_dev);
> > +	int ret =3D 0;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&indio_dev->mlock);
> > +		ret =3D mx25_gcq_get_raw_value(&indio_dev->dev, chan, priv, val);
> > +		mutex_unlock(&indio_dev->mlock);
> > +		return ret;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val =3D priv->channel_vref_mv[chan->channel];
> > +		*val2 =3D 12;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info mx25_gcq_iio_info =3D {
> > +	.read_raw =3D mx25_gcq_read_raw,
> > +};
> > +
> > +static const struct regmap_config mx25_gcq_regconfig =3D {
> > +	.max_register =3D 0x5c,
> > +	.reg_bits =3D 32,
> > +	.val_bits =3D 32,
> > +	.reg_stride =3D 4,
> > +};
> > +
> > +static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
> > +			       struct mx25_gcq_priv *priv)
> > +{
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	struct device_node *child;
> > +	struct device *dev =3D &pdev->dev;
> > +	int ret, i;
> > +	bool external_ref_used =3D false;
> > +
> > +	/*
> > +	 * Setup all configurations registers with a default conversion
> > +	 * configuration for each input
> > +	 */
> > +	for (i =3D 0; i < MX25_NUM_CFGS; ++i)
> > +		regmap_write(priv->regs, MX25_ADCQ_CFG(i),
> > +			     MX25_ADCQ_CFG_YPLL_OFF |
> > +			     MX25_ADCQ_CFG_XNUR_OFF |
> > +			     MX25_ADCQ_CFG_XPUL_OFF |
> > +			     MX25_ADCQ_CFG_REFP_INT |
> > +			     MX25_ADCQ_CFG_IN(i) |
> > +			     MX25_ADCQ_CFG_REFN_NGND2);
> > +
> > +	for_each_child_of_node(np, child) {
> > +		u32 reg;
> > +		u32 refp =3D MX25_ADCQ_CFG_REFP_INT;
> > +		u32 refn =3D MX25_ADCQ_CFG_REFN_NGND2;
> > +
> > +		ret =3D of_property_read_u32(child, "reg", &reg);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to get reg property\n");
> > +			return ret;
> > +		}
> > +
> > +		if (reg >=3D MX25_NUM_CFGS) {
> > +			dev_err(dev,
> > +				"reg value is greater than the number of available configuration r=
egisters\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		of_property_read_u32(child, "fsl,adc-refp", &refp);
> > +		of_property_read_u32(child, "fsl,adc-refn", &refn);
> > +
> > +		if (refp =3D=3D MX25_ADC_REFP_EXT)
> > +			external_ref_used =3D true;
> > +
> > +		/*
> > +		 * Shift the read values to the correct positions within the
> > +		 * register.
> > +		 */
> > +		refp =3D MX25_ADCQ_CFG_REFP(refp);
> > +		refn =3D MX25_ADCQ_CFG_REFN(refn);
> > +
> > +		if ((refp & MX25_ADCQ_CFG_REFP_MASK) !=3D refp) {
> > +			dev_err(dev, "Invalid fsl,adc-refp property value\n");
> > +			return -EINVAL;
> > +		}
> > +		if ((refn & MX25_ADCQ_CFG_REFN_MASK) !=3D refn) {
> > +			dev_err(dev, "Invalid fsl,adc-refn property value");
> > +			return -EINVAL;
> > +		}
> > +
> > +		regmap_update_bits(priv->regs, MX25_ADCQ_CFG(reg),
> > +				   MX25_ADCQ_CFG_REFP_MASK |
> > +				   MX25_ADCQ_CFG_REFN_MASK,
> > +				   refp | refn);
> > +	}
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> > +			   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST,
> > +			   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST);
> > +
> > +	regmap_write(priv->regs, MX25_ADCQ_CR,
> > +		     MX25_ADCQ_CR_PDMSK | MX25_ADCQ_CR_QSM_FQS);
> > +
> > +	if (external_ref_used) {
> > +		priv->ext_vref =3D devm_regulator_get(&pdev->dev, "vref");
> > +		if (IS_ERR(priv->ext_vref)) {
> > +			dev_err(&pdev->dev, "Failed to get regulator for vref although the =
external reference voltage is used.\n");
> > +			return PTR_ERR(priv->ext_vref);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mx25_gcq_probe(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct mx25_gcq_priv *priv;
> > +	struct mx25_tsadc *tsadc =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct device *dev =3D &pdev->dev;
> > +	struct resource *res;
> > +	void __iomem *mem;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	priv =3D iio_priv(indio_dev);
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	mem =3D devm_ioremap_resource(dev, res);
> > +	if (!mem)
> > +		return -ENOMEM;
> > +
> > +	priv->regs =3D devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
> > +	if (IS_ERR(priv->regs)) {
> > +		dev_err(dev, "Failed to initialize regmap\n");
> > +		return PTR_ERR(priv->regs);
> > +	}
> > +
> > +	init_completion(&priv->completed);
> > +
> > +	ret =3D mx25_gcq_setup_cfgs(pdev, priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!IS_ERR_OR_NULL(priv->ext_vref)) {
> > +		ret =3D regulator_enable(priv->ext_vref);
>=20
> I don't seen this being disabled anywhere.  As devm_regulator_get
> will result in a regulator put on device exit and the regulator_put
> code is commented with enables must be balanced by disables this
> looks liable to cause trouble.

Thanks, I missed that. Will fix it.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/WZMAAoJEEpcgKtcEGQQA5kQAI2gthi9cafx6vpWK1W5J3DD
mzUUKyn0KUo0qXKl1HKxD2RGWr3gwzYSv0WANYlhhmgmTVdE4NmvFLLUsD1zQSW2
en76nlhPN6bl5tKBy5o+aQBcJmaIoZdVs3V3yMTZCiVKkz7kQOz9hL8hsY/EsAcN
xAawHu0FJwYB0eC9/FeeTEvRJEc5futeJkHN7yJrASQjW0FbaU5Ehewqje1hBfpN
ISmmROU0k4wofbA96dRpPQSF9lZvcmDlnvDV++Qch8gswdxdp3VNKS67K4tOmpRj
ToqIPk4Pcl/e2RKTn4udh/KCPzfdXdS2gJGCsp32iwNC7HMrRzrEylJG7HDUozpS
bHLLd8+hzalljRRhoDdhz09vjhQHhno3PgOLbTyPulXEeEW4MQP7jyXGW9H9MZJ7
FcjUttPe9FhYbNlQeOq5E5yOnyEqMiPjlCvGwCIF0Ub/FiQAplGWjcmYSVJnhDHJ
e72iAcKS+1aTmk5FahYT4IO2NMckzwoY1kCfqm6D6V7UgqJc4WK9YOF740aBxZAK
hH9JUdTCIni3MJrDS7/IE0NSxnzs7JynOFGOcdZOlNAqvV8YcDOMBRTTtXJnXcHm
wHrsbDlZUD5LlA7zFsGNLThHVu359jrotslncu10HSfEGmWlFTMd545SykhLXtwm
a4cuvGrJYCQ3P32G654Z
=FWZo
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
