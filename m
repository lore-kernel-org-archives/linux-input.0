From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v9 5/8] iio: adc: fsl,imx25-gcq driver
Date: Mon, 14 Dec 2015 12:26:02 +0100
Message-ID: <1783157.2jnGQGOp7m@adelgunde>
References: <1449431542-1892-1-git-send-email-mpa@pengutronix.de> <1449431542-1892-6-git-send-email-mpa@pengutronix.de> <566C55F0.6080901@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1461282.ON7vrEqbs7"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <566C55F0.6080901-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric =?ISO-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--nextPart1461282.ON7vrEqbs7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

On Saturday 12 December 2015 17:14:24 Jonathan Cameron wrote:
> On 06/12/15 19:52, Markus Pargmann wrote:
> > This is a conversion queue driver for the mx25 SoC. It uses the cen=
tral
> > ADC which is used by two seperate independent queues. This driver
> > prepares different conversion configurations for each possible inpu=
t.
> > For a conversion it creates a conversionqueue of one item with the
> conversion queue
> > correct configuration for the chosen channel. It then executes the =
queue
> > once and disables the conversion queue afterwards.
> >=20
> > The reference voltages are configurable through devicetree subnodes=
,
> > depending on the connections of the ADC inputs.
> >=20
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> A couple of little bits inline.  Fix the return of 0 on fail in probe=

> and you can add

Thanks, I fixed all your comments for the next version.

Best Regards,

Markus

>=20
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >=20
> > Notes:
> >     Changes in v7:
> >      - Remove separate functions mx25_gcq_disable/enable_eoq() as t=
hey were used at
> >        only one position
> >      - Enforce an external reference regulator if one of the conver=
sions uses it as
> >        reference. The devm_regulator_get() call was moved into
> >        mx25_gcq_setup_cfgs() to be able to acquire the reference re=
gulator when
> >        necessary.
> >      - Store indio_dev as platform driver data instead of the priva=
te data. This
> >        was changed in probe() and remove().
> >    =20
> >     Changes in v6:
> >      - Added defines for a complete list of references in the dt bi=
nding macros
> >=20
> >  drivers/iio/adc/Kconfig         |   7 +
> >  drivers/iio/adc/Makefile        |   1 +
> >  drivers/iio/adc/fsl-imx25-gcq.c | 415 ++++++++++++++++++++++++++++=
++++++++++++
> >  3 files changed, 423 insertions(+)
> >  create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 7868c744fd4b..73145c53ec2c 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -183,6 +183,13 @@ config EXYNOS_ADC
> >  =09  To compile this driver as a module, choose M here: the module=
 will be
> >  =09  called exynos_adc.
> > =20
> > +config FSL_MX25_ADC
> > +=09tristate "Freescale MX25 ADC driver"
> > +=09depends on MFD_MX25_TSADC
> > +=09help
> > +=09  Generic Conversion Queue driver used for general purpose ADC =
in the
> > +=09  MX25. This driver supports single measurements using the MX25=
 ADC.
> > +
> >  config HI8435
> >  =09tristate "Holt Integrated Circuits HI-8435 threshold detector"
> >  =09select IIO_TRIGGERED_EVENT
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 99b37a963a1e..2fe9b78e4b02 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -19,6 +19,7 @@ obj-$(CONFIG_BERLIN2_ADC) +=3D berlin2-adc.o
> >  obj-$(CONFIG_CC10001_ADC) +=3D cc10001_adc.o
> >  obj-$(CONFIG_DA9150_GPADC) +=3D da9150-gpadc.o
> >  obj-$(CONFIG_EXYNOS_ADC) +=3D exynos_adc.o
> > +obj-$(CONFIG_FSL_MX25_ADC) +=3D fsl-imx25-gcq.o
> >  obj-$(CONFIG_HI8435) +=3D hi8435.o
> >  obj-$(CONFIG_LP8788_ADC) +=3D lp8788_adc.o
> >  obj-$(CONFIG_MAX1027) +=3D max1027.o
> > diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-=
imx25-gcq.c
> > new file mode 100644
> > index 000000000000..eb9570876291
> > --- /dev/null
> > +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> > @@ -0,0 +1,415 @@
> > +/*
> > + * Copyright (C) 2014-2015 Pengutronix, Markus Pargmann <mpa@pengu=
tronix.de>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify it under
> > + * the terms of the GNU General Public License version 2 as publis=
hed by the
> > + * Free Software Foundation.
> > + *
> > + * This is the driver for the imx25 GCQ (Generic Conversion Queue)=

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
> > +static const char * const driver_name =3D "mx25-gcq";
> > +
> > +enum mx25_gcq_cfgs {
> > +=09MX25_CFG_XP =3D 0,
> > +=09MX25_CFG_YP,
> > +=09MX25_CFG_XN,
> > +=09MX25_CFG_YN,
> > +=09MX25_CFG_WIPER,
> > +=09MX25_CFG_INAUX0,
> > +=09MX25_CFG_INAUX1,
> > +=09MX25_CFG_INAUX2,
> > +=09MX25_NUM_CFGS,
> > +};
> > +
> > +struct mx25_gcq_priv {
> > +=09struct regmap *regs;
> > +=09struct completion completed;
> > +=09struct clk *clk;
> > +=09int irq;
> > +=09struct regulator *vref[4];
> > +=09u32 channel_vref_mv[MX25_NUM_CFGS];
> > +};
> > +
> > +#define MX25_CQG_CHAN(chan, id) {\
> > +=09.type =3D IIO_VOLTAGE,\
> > +=09.indexed =3D 1,\
> > +=09.channel =3D chan,\
> > +=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> > +=09=09=09      BIT(IIO_CHAN_INFO_SCALE),\
> > +=09.datasheet_name =3D id,\
> > +}
> > +
> > +static const struct iio_chan_spec mx25_gcq_channels[MX25_NUM_CFGS]=
 =3D {
> > +=09MX25_CQG_CHAN(MX25_CFG_XP, "xp"),
> > +=09MX25_CQG_CHAN(MX25_CFG_YP, "yp"),
> > +=09MX25_CQG_CHAN(MX25_CFG_XN, "xn"),
> > +=09MX25_CQG_CHAN(MX25_CFG_YN, "yn"),
> > +=09MX25_CQG_CHAN(MX25_CFG_WIPER, "wiper"),
> > +=09MX25_CQG_CHAN(MX25_CFG_INAUX0, "inaux0"),
> > +=09MX25_CQG_CHAN(MX25_CFG_INAUX1, "inaux1"),
> > +=09MX25_CQG_CHAN(MX25_CFG_INAUX2, "inaux2"),
> > +};
> > +
> > +static const char * const mx25_gcq_refp_names[] =3D {
> > +=09[MX25_ADC_REFP_YP] =3D "yp",
> > +=09[MX25_ADC_REFP_XP] =3D "xp",
> > +=09[MX25_ADC_REFP_INT] =3D "int",
> > +=09[MX25_ADC_REFP_EXT] =3D "ext",
> > +};
> > +
> > +static irqreturn_t mx25_gcq_irq(int irq, void *data)
> > +{
> > +=09struct mx25_gcq_priv *priv =3D data;
> > +=09u32 stats;
> > +
> > +=09regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
> > +
> > +=09if (stats & MX25_ADCQ_SR_EOQ) {
> > +=09=09regmap_update_bits(priv->regs, MX25_ADCQ_MR,
> > +=09=09=09=09   MX25_ADCQ_MR_EOQ_IRQ, MX25_ADCQ_MR_EOQ_IRQ);
> > +=09=09complete(&priv->completed);
> > +=09}
> > +
> > +=09/* Disable conversion queue run */
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, =
0);
> > +
> > +=09/* Acknowledge all possible irqs */
> > +=09regmap_write(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |
> > +=09=09     MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR |
> > +=09=09     MX25_ADCQ_SR_EOQ | MX25_ADCQ_SR_PD);
> > +
> > +=09return IRQ_HANDLED;
> > +}
> > +
> > +static int mx25_gcq_get_raw_value(struct device *dev,
> > +=09=09=09=09  struct iio_chan_spec const *chan,
> > +=09=09=09=09  struct mx25_gcq_priv *priv,
> > +=09=09=09=09  int *val)
> > +{
> > +=09long timeout;
> > +=09u32 data;
> > +
> > +=09/* Setup the configuration we want to use */
> > +=09regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
> > +=09=09     MX25_ADCQ_ITEM(0, chan->channel));
> > +
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_I=
RQ, 0);
> > +
> > +=09/* Trigger queue for one run */
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
> > +=09=09=09   MX25_ADCQ_CR_FQS);
> > +
> > +=09timeout =3D wait_for_completion_interruptible_timeout(
> > +=09=09&priv->completed, MX25_GCQ_TIMEOUT);
> > +=09if (timeout < 0) {
> > +=09=09dev_err(dev, "ADC wait for measurement failed\n");
> > +=09=09return timeout;
> > +=09} else if (timeout =3D=3D 0) {
> > +=09=09dev_err(dev, "ADC timed out\n");
> > +=09=09return -ETIMEDOUT;
> > +=09}
> > +
> > +=09regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
> > +
> > +=09*val =3D MX25_ADCQ_FIFO_DATA(data);
> > +
> > +=09return IIO_VAL_INT;
> > +}
> > +
> > +static int mx25_gcq_read_raw(struct iio_dev *indio_dev,
> > +=09=09=09     struct iio_chan_spec const *chan, int *val,
> > +=09=09=09     int *val2, long mask)
> > +{
> > +=09struct mx25_gcq_priv *priv =3D iio_priv(indio_dev);
> > +=09int ret;
> > +
> > +=09switch (mask) {
> > +=09case IIO_CHAN_INFO_RAW:
> > +=09=09mutex_lock(&indio_dev->mlock);
> > +=09=09ret =3D mx25_gcq_get_raw_value(&indio_dev->dev, chan, priv, =
val);
> > +=09=09mutex_unlock(&indio_dev->mlock);
> > +=09=09return ret;
> > +
> > +=09case IIO_CHAN_INFO_SCALE:
> > +=09=09*val =3D priv->channel_vref_mv[chan->channel];
> > +=09=09*val2 =3D 12;
> > +=09=09return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +=09default:
> > +=09=09return -EINVAL;
> > +=09}
> > +}
> > +
> > +static const struct iio_info mx25_gcq_iio_info =3D {
> > +=09.read_raw =3D mx25_gcq_read_raw,
> > +};
> > +
> > +static const struct regmap_config mx25_gcq_regconfig =3D {
> > +=09.max_register =3D 0x5c,
> > +=09.reg_bits =3D 32,
> > +=09.val_bits =3D 32,
> > +=09.reg_stride =3D 4,
> > +};
> > +
> > +static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
> > +=09=09=09       struct mx25_gcq_priv *priv)
> > +{
> > +=09struct device_node *np =3D pdev->dev.of_node;
> > +=09struct device_node *child;
> > +=09struct device *dev =3D &pdev->dev;
> > +=09unsigned int refp_used[4] =3D {};
> > +=09int ret, i;
> > +
> > +=09/*
> > +=09 * Setup all configurations registers with a default conversion=

> > +=09 * configuration for each input
> > +=09 */
> > +=09for (i =3D 0; i < MX25_NUM_CFGS; ++i)
> > +=09=09regmap_write(priv->regs, MX25_ADCQ_CFG(i),
> > +=09=09=09     MX25_ADCQ_CFG_YPLL_OFF |
> > +=09=09=09     MX25_ADCQ_CFG_XNUR_OFF |
> > +=09=09=09     MX25_ADCQ_CFG_XPUL_OFF |
> > +=09=09=09     MX25_ADCQ_CFG_REFP_INT |
> > +=09=09=09     MX25_ADCQ_CFG_IN(i) |
> > +=09=09=09     MX25_ADCQ_CFG_REFN_NGND2);
> > +
> > +=09/*
> > +=09 * First get all regulators to store them in channel_vref_mv if=

> > +=09 * necessary. Later we use that information for proper IIO scal=
e
> > +=09 * information.
> > +=09 */
> > +=09priv->vref[MX25_ADC_REFP_INT] =3D NULL;
> > +=09priv->vref[MX25_ADC_REFP_EXT] =3D
> > +=09=09devm_regulator_get_optional(&pdev->dev, "vref-ext");
> > +=09priv->vref[MX25_ADC_REFP_XP] =3D
> > +=09=09devm_regulator_get_optional(&pdev->dev, "vref-xp");
> > +=09priv->vref[MX25_ADC_REFP_YP] =3D
> > +=09=09devm_regulator_get_optional(&pdev->dev, "vref-yp");
> > +
> > +=09for_each_child_of_node(np, child) {
> > +=09=09u32 reg;
> > +=09=09u32 refp =3D MX25_ADCQ_CFG_REFP_INT;
> > +=09=09u32 refn =3D MX25_ADCQ_CFG_REFN_NGND2;
> > +
> > +=09=09ret =3D of_property_read_u32(child, "reg", &reg);
> > +=09=09if (ret) {
> > +=09=09=09dev_err(dev, "Failed to get reg property\n");
> > +=09=09=09return ret;
> > +=09=09}
> > +
> > +=09=09if (reg >=3D MX25_NUM_CFGS) {
> > +=09=09=09dev_err(dev,
> > +=09=09=09=09"reg value is greater than the number of available con=
figuration registers\n");
> > +=09=09=09return -EINVAL;
> > +=09=09}
> > +
> > +=09=09of_property_read_u32(child, "fsl,adc-refp", &refp);
> > +=09=09of_property_read_u32(child, "fsl,adc-refn", &refn);
> > +
> > +=09=09switch (refp) {
> > +=09=09case MX25_ADC_REFP_EXT:
> > +=09=09case MX25_ADC_REFP_XP:
> > +=09=09case MX25_ADC_REFP_YP:
> > +=09=09=09if (IS_ERR(priv->vref[refp])) {
> > +=09=09=09=09dev_err(dev, "Error, trying to use external voltage re=
ference without a vref-%s regulator.",
> > +=09=09=09=09=09mx25_gcq_refp_names[refp]);
> > +=09=09=09=09return PTR_ERR(priv->vref[refp]);
> > +=09=09=09}
> > +=09=09=09priv->channel_vref_mv[reg] =3D
> > +=09=09=09=09regulator_get_voltage(priv->vref[refp]);
> > +=09=09=09/* Conversion from uV to mV */
> > +=09=09=09do_div(priv->channel_vref_mv[reg], 1000);
> > +=09=09=09break;
> > +=09=09case MX25_ADC_REFP_INT:
> > +=09=09=09priv->channel_vref_mv[reg] =3D 2500;
> > +=09=09=09break;
> > +=09=09default:
> > +=09=09=09dev_err(dev, "Invalid positive reference %d\n", refp);
> > +=09=09=09return -EINVAL;
> > +=09=09}
> > +
> > +=09=09++refp_used[refp];
> > +
> > +=09=09/*
> > +=09=09 * Shift the read values to the correct positions within the=

> > +=09=09 * register.
> > +=09=09 */
> > +=09=09refp =3D MX25_ADCQ_CFG_REFP(refp);
> > +=09=09refn =3D MX25_ADCQ_CFG_REFN(refn);
> > +
> > +=09=09if ((refp & MX25_ADCQ_CFG_REFP_MASK) !=3D refp) {
> > +=09=09=09dev_err(dev, "Invalid fsl,adc-refp property value\n");
> > +=09=09=09return -EINVAL;
> > +=09=09}
> > +=09=09if ((refn & MX25_ADCQ_CFG_REFN_MASK) !=3D refn) {
> > +=09=09=09dev_err(dev, "Invalid fsl,adc-refn property value\n");
> > +=09=09=09return -EINVAL;
> > +=09=09}
> > +
> > +=09=09regmap_update_bits(priv->regs, MX25_ADCQ_CFG(reg),
> > +=09=09=09=09   MX25_ADCQ_CFG_REFP_MASK |
> > +=09=09=09=09   MX25_ADCQ_CFG_REFN_MASK,
> > +=09=09=09=09   refp | refn);
> > +=09}
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> > +=09=09=09   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST,
> > +=09=09=09   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST);
> > +
> > +=09regmap_write(priv->regs, MX25_ADCQ_CR,
> > +=09=09     MX25_ADCQ_CR_PDMSK | MX25_ADCQ_CR_QSM_FQS);
> > +
> > +=09/* Remove unused regulators */
> > +=09for (i =3D 0; i !=3D 4; ++i) {
> > +=09=09if (!refp_used[i]) {
> > +=09=09=09if (!IS_ERR_OR_NULL(priv->vref[i]))
> > +=09=09=09=09devm_regulator_put(priv->vref[i]);
> > +=09=09=09priv->vref[i] =3D NULL;
> > +=09=09}
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static int mx25_gcq_probe(struct platform_device *pdev)
> > +{
> > +=09struct iio_dev *indio_dev;
> > +=09struct mx25_gcq_priv *priv;
> > +=09struct mx25_tsadc *tsadc =3D dev_get_drvdata(pdev->dev.parent);=

> > +=09struct device *dev =3D &pdev->dev;
> > +=09struct resource *res;
> > +=09void __iomem *mem;
> > +=09int ret;
> > +=09int i;
> > +
> > +=09indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));=

> > +=09if (!indio_dev)
> > +=09=09return -ENOMEM;
> > +
> > +=09priv =3D iio_priv(indio_dev);
> > +
> > +=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +=09mem =3D devm_ioremap_resource(dev, res);
> > +=09if (IS_ERR(mem))
> > +=09=09return PTR_ERR(mem);
> > +
> > +=09priv->regs =3D devm_regmap_init_mmio(dev, mem, &mx25_gcq_regcon=
fig);
> > +=09if (IS_ERR(priv->regs)) {
> > +=09=09dev_err(dev, "Failed to initialize regmap\n");
> > +=09=09return PTR_ERR(priv->regs);
> > +=09}
> > +
> > +=09init_completion(&priv->completed);
> > +
> > +=09ret =3D mx25_gcq_setup_cfgs(pdev, priv);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09for (i =3D 0; i !=3D 4; ++i) {
> > +=09=09if (!priv->vref[i])
> > +=09=09=09continue;
> > +
> > +=09=09ret =3D regulator_enable(priv->vref[i]);
> > +=09=09if (ret)
> > +=09=09=09goto err_regulator_disable;
> > +=09}
> > +
> > +=09priv->clk =3D tsadc->clk;
> > +=09ret =3D clk_prepare_enable(priv->clk);
> > +=09if (ret) {
> > +=09=09dev_err(dev, "Failed to enable clock\n");
> > +=09=09goto err_vref_disable;
> > +=09}
> > +
> > +=09priv->irq =3D platform_get_irq(pdev, 0);
> > +=09if (priv->irq <=3D 0) {
> > +=09=09dev_err(dev, "Failed to get IRQ\n");
> > +=09=09ret =3D priv->irq;
> If it is zero you'll return 0 from probe (success)
> whilst actually failing. =20
> > +=09=09goto err_clk_unprepare;
> > +=09}
> > +
> > +=09ret =3D request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, pri=
v);
> > +=09if (ret) {
> > +=09=09dev_err(dev, "Failed requesting IRQ\n");
> > +=09=09goto err_clk_unprepare;
> > +=09}
> > +
> > +=09indio_dev->dev.parent =3D &pdev->dev;
> > +=09indio_dev->channels =3D mx25_gcq_channels;
> > +=09indio_dev->num_channels =3D ARRAY_SIZE(mx25_gcq_channels);
> > +=09indio_dev->info =3D &mx25_gcq_iio_info;
> > +=09indio_dev->name =3D driver_name;
> > +
> > +=09ret =3D iio_device_register(indio_dev);
> > +=09if (ret) {
> > +=09=09dev_err(dev, "Failed to register iio device\n");
> > +=09=09goto err_irq_free;
> > +=09}
> > +
> > +=09platform_set_drvdata(pdev, indio_dev);
> > +
> > +=09return 0;
> > +
> > +err_irq_free:
> > +=09free_irq(priv->irq, (void *)priv);
> Cast to void * not needed. Any pointer can be implicitly be
> cast to void *
>=20
> > +err_clk_unprepare:
> > +=09clk_disable_unprepare(priv->clk);
> > +err_vref_disable:
> > +=09i =3D 4;
> > +err_regulator_disable:
> > +=09for (; i-- > 0;) {
> > +=09=09if (priv->vref[i])
> > +=09=09=09regulator_disable(priv->vref[i]);
> > +=09}
> > +=09return ret;
> > +}
> > +
> > +static int mx25_gcq_remove(struct platform_device *pdev)
> > +{
> > +=09struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > +=09struct mx25_gcq_priv *priv =3D iio_priv(indio_dev);
> > +=09int i;
> > +
> > +=09iio_device_unregister(indio_dev);
> > +=09free_irq(priv->irq, priv);
> > +=09clk_disable_unprepare(priv->clk);
> > +=09for (i =3D 4; i-- > 0;) {
> > +=09=09if (priv->vref[i])
> > +=09=09=09regulator_disable(priv->vref[i]);
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static const struct of_device_id mx25_gcq_ids[] =3D {
> > +=09{ .compatible =3D "fsl,imx25-gcq", },
> > +=09{ /* Sentinel */ }
> > +};
> > +
> > +static struct platform_driver mx25_gcq_driver =3D {
> > +=09.driver=09=09=3D {
> > +=09=09.name=09=3D "mx25-gcq",
> > +=09=09.of_match_table =3D mx25_gcq_ids,
> > +=09},
> > +=09.probe=09=09=3D mx25_gcq_probe,
> > +=09.remove=09=09=3D mx25_gcq_remove,
> > +};
> > +module_platform_driver(mx25_gcq_driver);
> > +
> > +MODULE_DESCRIPTION("ADC driver for Freescale mx25");
> > +MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> > +MODULE_LICENSE("GPL v2");
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

--nextPart1461282.ON7vrEqbs7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWbqdYAAoJEEpcgKtcEGQQwC8P/jYk5jg8wi1F85SfarSlc8QD
5XdCz6SsILoLb00HjCVvfnkGkzJpAR1UR2hcBFj14RdPYBHp2I/8d894/8GUBwTg
YNvxueUo+q0Bz6RPjZ2xWdmMVmjroftSFSBkuLa52Ryq7iaFRwno5Ufcb5xRmcce
+kp2gBU2LmfhMzESOda6ZqeAwqJGZUzAfsDzWlj2JfPQayk+3xDdIiL083CxwbjK
f78/KVTxnGw+LoBG5A7TG6nrfQWDTXrFQWjx3JO083iJpDRpN4jCxqYm1SxHVPhi
Bmw1CimJyori7TrVglS6d738j5R6N3teuFz7WfS2KNRLsswKqpQIfHJYc43SQqR/
eKbNBlMxUcxJEQNc0du4ZTPnjoWilJ0zki5sLOuUx49CE48WCRvf6BbHLViftFpj
in1RhQaiTQkJxrXe9QtsTpebajw0P8eswFXIzNmzXd3/FtCAr8OuGgMO9bOK3r1E
aB5Da6nMHOxPit1B2f3sUtbIFob9OuPeGTK1A51hX1syKGkbjZJARSqd2vPBtUG+
/AhO+mwmPxTKXT9bj5mMeGPmmraRRipjKFmixtNM6/l6PZAD5q9VN58dvSPfWlNH
KRHYpnH9686H4xW2lj6agD2mKuPyoCMJatLvEj8OW7HX/auL0XrY9Cku+N98TaT2
0wNR/sBAp4yMP/ySPS/u
=sQVd
-----END PGP SIGNATURE-----

--nextPart1461282.ON7vrEqbs7--
