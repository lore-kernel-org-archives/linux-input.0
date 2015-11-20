From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 6/8] input: touchscreen: imx25 tcq driver
Date: Fri, 20 Nov 2015 14:33:17 +0100
Message-ID: <2248665.NK2zlY5PWs@adelgunde>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de> <1447675269-8831-7-git-send-email-mpa@pengutronix.de> <20151117181720.GC29423@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2445528.4SryevG9Bl"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151117181720.GC29423@dtor-ws>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?ISO-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--nextPart2445528.4SryevG9Bl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

On Tuesday 17 November 2015 10:17:20 Dmitry Torokhov wrote:
> On Mon, Nov 16, 2015 at 01:01:07PM +0100, Markus Pargmann wrote:
> > This is a driver for the imx25 ADC/TSC module. It controls the
> > touchscreen conversion queue and creates a touchscreen input device=
.
> > The driver currently only supports 4 wire touchscreens. The driver =
uses
> > a simple conversion queue of precharge, touch detection, X measurem=
ent,
> > Y measurement, precharge and another touch detection.
> >=20
> > This driver uses the regmap from the parent to setup some touch spe=
cific
> > settings in the core driver and setup a idle configuration with tou=
ch
> > detection.
> >=20
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> >=20
> > [fix clock's period calculation]
> > [fix calculation of the 'settling' value]
> > Signed-off-by: Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >=20
> > Notes:
> >     Changes in v7:
> >      - Moved clk_prepare_enable() and mx25_tcq_init() into mx25_tcq=
_open(). This
> >        was done to be able to use devm_request_threaded_irq().
> >      - Cleanup of the probe function through above change
> >      - Removed mx25_tcq_remove(), not necessary now
> >=20
> >  drivers/input/touchscreen/Kconfig         |   6 +
> >  drivers/input/touchscreen/Makefile        |   1 +
> >  drivers/input/touchscreen/fsl-imx25-tcq.c | 600 ++++++++++++++++++=
++++++++++++
> >  3 files changed, 607 insertions(+)
> >  create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
> >=20
> > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touc=
hscreen/Kconfig
> > index ae33da7ab51f..b44651d33080 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -811,6 +811,12 @@ config TOUCHSCREEN_USB_COMPOSITE
> >  =09  To compile this driver as a module, choose M here: the
> >  =09  module will be called usbtouchscreen.
> > =20
> > +config TOUCHSCREEN_MX25
> > +=09tristate "Freescale i.MX25 touchscreen input driver"
> > +=09depends on MFD_MX25_TSADC
> > +=09help
> > +=09  Enable support for touchscreen connected to your i.MX25.
> > +
>=20
> =09  To compile this driver as a module...
>=20
> >  config TOUCHSCREEN_MC13783
> >  =09tristate "Freescale MC13783 touchscreen input driver"
> >  =09depends on MFD_MC13XXX
> > diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/tou=
chscreen/Makefile
> > index cbaa6abb08da..77a2ac54101a 100644
> > --- a/drivers/input/touchscreen/Makefile
> > +++ b/drivers/input/touchscreen/Makefile
> > @@ -45,6 +45,7 @@ obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)=09+=3D intel-=
mid-touch.o
> >  obj-$(CONFIG_TOUCHSCREEN_IPROC)=09=09+=3D bcm_iproc_tsc.o
> >  obj-$(CONFIG_TOUCHSCREEN_LPC32XX)=09+=3D lpc32xx_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_MAX11801)=09+=3D max11801_ts.o
> > +obj-$(CONFIG_TOUCHSCREEN_MX25)=09=09+=3D fsl-imx25-tcq.o
> >  obj-$(CONFIG_TOUCHSCREEN_MC13783)=09+=3D mc13783_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_MCS5000)=09+=3D mcs5000_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_MIGOR)=09=09+=3D migor_ts.o
> > diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/in=
put/touchscreen/fsl-imx25-tcq.c
> > new file mode 100644
> > index 000000000000..c833cd814972
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
> > @@ -0,0 +1,600 @@
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
> > + * Based on driver from 2011:
> > + *   Juergen Beisert, Pengutronix <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > + *
> > + * This is the driver for the imx25 TCQ (Touchscreen Conversion Qu=
eue)
> > + * connected to the imx25 ADC.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/imx25-tsadc.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +static const char mx25_tcq_name[] =3D "mx25-tcq";
> > +
> > +enum mx25_tcq_mode {
> > +=09MX25_TS_4WIRE,
> > +};
> > +
> > +struct mx25_tcq_priv {
> > +=09struct regmap *regs;
> > +=09struct regmap *core_regs;
> > +=09struct input_dev *idev;
> > +=09enum mx25_tcq_mode mode;
> > +=09unsigned int pen_threshold;
> > +=09unsigned int sample_count;
> > +=09unsigned int expected_samples;
> > +=09unsigned int pen_debounce;
> > +=09unsigned int settling_time;
> > +=09struct clk *clk;
> > +=09int irq;
> > +};
> > +
> > +static struct regmap_config mx25_tcq_regconfig =3D {
> > +=09.fast_io =3D true,
> > +=09.max_register =3D 0x5c,
> > +=09.reg_bits =3D 32,
> > +=09.val_bits =3D 32,
> > +=09.reg_stride =3D 4,
> > +};
> > +
> > +static const struct of_device_id mx25_tcq_ids[] =3D {
> > +=09{ .compatible =3D "fsl,imx25-tcq", },
> > +=09{ /* Sentinel */ }
> > +};
> > +
> > +#define TSC_4WIRE_PRE_INDEX 0
> > +#define TSC_4WIRE_X_INDEX 1
> > +#define TSC_4WIRE_Y_INDEX 2
> > +#define TSC_4WIRE_POST_INDEX 3
> > +#define TSC_4WIRE_LEAVE 4
> > +
> > +#define MX25_TSC_DEF_THRESHOLD 80
> > +#define TSC_MAX_SAMPLES 16
> > +
> > +#define MX25_TSC_REPEAT_WAIT 14
> > +
> > +enum mx25_adc_configurations {
> > +=09MX25_CFG_PRECHARGE =3D 0,
> > +=09MX25_CFG_TOUCH_DETECT,
> > +=09MX25_CFG_X_MEASUREMENT,
> > +=09MX25_CFG_Y_MEASUREMENT,
> > +};
> > +
> > +#define MX25_PRECHARGE_VALUE (\
> > +=09=09=09MX25_ADCQ_CFG_YPLL_OFF | \
> > +=09=09=09MX25_ADCQ_CFG_XNUR_OFF | \
> > +=09=09=09MX25_ADCQ_CFG_XPUL_HIGH | \
> > +=09=09=09MX25_ADCQ_CFG_REFP_INT | \
> > +=09=09=09MX25_ADCQ_CFG_IN_XP | \
> > +=09=09=09MX25_ADCQ_CFG_REFN_NGND2 | \
> > +=09=09=09MX25_ADCQ_CFG_IGS)
> > +
> > +#define MX25_TOUCH_DETECT_VALUE (\
> > +=09=09=09MX25_ADCQ_CFG_YNLR | \
> > +=09=09=09MX25_ADCQ_CFG_YPLL_OFF | \
> > +=09=09=09MX25_ADCQ_CFG_XNUR_OFF | \
> > +=09=09=09MX25_ADCQ_CFG_XPUL_OFF | \
> > +=09=09=09MX25_ADCQ_CFG_REFP_INT | \
> > +=09=09=09MX25_ADCQ_CFG_IN_XP | \
> > +=09=09=09MX25_ADCQ_CFG_REFN_NGND2 | \
> > +=09=09=09MX25_ADCQ_CFG_PENIACK)
> > +
> > +static void imx25_setup_queue_cfgs(struct mx25_tcq_priv *priv,
> > +=09=09=09=09   unsigned int settling_cnt)
> > +{
> > +=09u32 precharge_cfg =3D
> > +=09=09=09MX25_PRECHARGE_VALUE |
> > +=09=09=09MX25_ADCQ_CFG_SETTLING_TIME(settling_cnt);
> > +=09u32 touch_detect_cfg =3D
> > +=09=09=09MX25_TOUCH_DETECT_VALUE |
> > +=09=09=09MX25_ADCQ_CFG_NOS(1) |
> > +=09=09=09MX25_ADCQ_CFG_SETTLING_TIME(settling_cnt);
> > +
> > +=09regmap_write(priv->core_regs, MX25_TSC_TICR, precharge_cfg);
> > +
> > +=09/* PRECHARGE */
> > +=09regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_PRECHARGE),
> > +=09=09     precharge_cfg);
> > +
> > +=09/* TOUCH_DETECT */
> > +=09regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_TOUCH_DETECT),
> > +=09=09     touch_detect_cfg);
> > +
> > +=09/* X Measurement */
> > +=09regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_X_MEASUREMENT),=

> > +=09=09     MX25_ADCQ_CFG_YPLL_OFF |
> > +=09=09     MX25_ADCQ_CFG_XNUR_LOW |
> > +=09=09     MX25_ADCQ_CFG_XPUL_HIGH |
> > +=09=09     MX25_ADCQ_CFG_REFP_XP |
> > +=09=09     MX25_ADCQ_CFG_IN_YP |
> > +=09=09     MX25_ADCQ_CFG_REFN_XN |
> > +=09=09     MX25_ADCQ_CFG_NOS(priv->sample_count) |
> > +=09=09     MX25_ADCQ_CFG_SETTLING_TIME(settling_cnt));
> > +
> > +=09/* Y Measurement */
> > +=09regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_Y_MEASUREMENT),=

> > +=09=09     MX25_ADCQ_CFG_YNLR |
> > +=09=09     MX25_ADCQ_CFG_YPLL_HIGH |
> > +=09=09     MX25_ADCQ_CFG_XNUR_OFF |
> > +=09=09     MX25_ADCQ_CFG_XPUL_OFF |
> > +=09=09     MX25_ADCQ_CFG_REFP_YP |
> > +=09=09     MX25_ADCQ_CFG_IN_XP |
> > +=09=09     MX25_ADCQ_CFG_REFN_YN |
> > +=09=09     MX25_ADCQ_CFG_NOS(priv->sample_count) |
> > +=09=09     MX25_ADCQ_CFG_SETTLING_TIME(settling_cnt));
> > +
> > +=09/* Enable the touch detection right now */
> > +=09regmap_write(priv->core_regs, MX25_TSC_TICR, touch_detect_cfg |=

> > +=09=09     MX25_ADCQ_CFG_IGS);
> > +}
> > +
> > +static int imx25_setup_queue_4wire(struct mx25_tcq_priv *priv,
> > +=09=09=09=09   unsigned settling_cnt, int *items)
> > +{
> > +=09imx25_setup_queue_cfgs(priv, settling_cnt);
> > +
> > +=09/* Setup the conversion queue */
> > +=09regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
> > +=09=09     MX25_ADCQ_ITEM(0, MX25_CFG_PRECHARGE) |
> > +=09=09     MX25_ADCQ_ITEM(1, MX25_CFG_TOUCH_DETECT) |
> > +=09=09     MX25_ADCQ_ITEM(2, MX25_CFG_X_MEASUREMENT) |
> > +=09=09     MX25_ADCQ_ITEM(3, MX25_CFG_Y_MEASUREMENT) |
> > +=09=09     MX25_ADCQ_ITEM(4, MX25_CFG_PRECHARGE) |
> > +=09=09     MX25_ADCQ_ITEM(5, MX25_CFG_TOUCH_DETECT));
> > +
> > +=09/*
> > +=09 * We measure X/Y with 'sample_count' number of samples and exe=
cute a
> > +=09 * touch detection twice, with 1 sample each
> > +=09 */
> > +=09priv->expected_samples =3D priv->sample_count * 2 + 2;
> > +=09*items =3D 6;
> > +
> > +=09return 0;
> > +}
> > +
> > +static void mx25_tcq_disable_touch_irq(struct mx25_tcq_priv *priv)=

> > +{
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_PDMSK=
,
> > +=09=09=09   MX25_ADCQ_CR_PDMSK);
> > +}
> > +
> > +static void mx25_tcq_enable_touch_irq(struct mx25_tcq_priv *priv)
> > +{
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_PDMSK=
, 0);
> > +}
> > +
> > +static void mx25_tcq_disable_fifo_irq(struct mx25_tcq_priv *priv)
> > +{
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_FDRY_=
IRQ,
> > +=09=09=09   MX25_ADCQ_MR_FDRY_IRQ);
> > +}
> > +
> > +static void mx25_tcq_enable_fifo_irq(struct mx25_tcq_priv *priv)
> > +{
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_FDRY_=
IRQ, 0);
> > +}
> > +
> > +static void mx25_tcq_force_queue_start(struct mx25_tcq_priv *priv)=

> > +{
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> > +=09=09=09   MX25_ADCQ_CR_FQS,
> > +=09=09=09   MX25_ADCQ_CR_FQS);
> > +}
> > +
> > +static void mx25_tcq_force_queue_stop(struct mx25_tcq_priv *priv)
> > +{
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> > +=09=09=09   MX25_ADCQ_CR_FQS, 0);
> > +}
> > +
> > +static void mx25_tcq_fifo_reset(struct mx25_tcq_priv *priv)
> > +{
> > +=09u32 tcqcr;
> > +
> > +=09regmap_read(priv->regs, MX25_ADCQ_CR, &tcqcr);
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FRST,=

> > +=09=09=09   MX25_ADCQ_CR_FRST);
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FRST,=
 0);
> > +=09regmap_write(priv->regs, MX25_ADCQ_CR, tcqcr);
> > +}
> > +
> > +static void mx25_tcq_re_enable_touch_detection(struct mx25_tcq_pri=
v *priv)
> > +{
> > +=09/* stop the queue from looping */
> > +=09mx25_tcq_force_queue_stop(priv);
> > +
> > +=09/* for a clean touch detection, preload the X plane */
> > +=09regmap_write(priv->core_regs, MX25_TSC_TICR, MX25_PRECHARGE_VAL=
UE);
> > +
> > +=09/* waste some time now to pre-load the X plate to high voltage =
*/
> > +=09mx25_tcq_fifo_reset(priv);
> > +
> > +=09/* re-enable the detection right now */
> > +=09regmap_write(priv->core_regs, MX25_TSC_TICR,
> > +=09=09     MX25_TOUCH_DETECT_VALUE | MX25_ADCQ_CFG_IGS);
> > +
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_PD,
> > +=09=09=09   MX25_ADCQ_SR_PD);
> > +
> > +=09/* enable the pen down event to be a source for the interrupt *=
/
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_PD_IR=
Q, 0);
> > +
> > +=09/* lets fire the next IRQ if someone touches the touchscreen */=

> > +=09mx25_tcq_enable_touch_irq(priv);
> > +}
> > +
> > +static int mx25_tcq_create_event_for_4wire(struct mx25_tcq_priv *p=
riv,
>=20
> Why not void? What callers are supposed to do with the value?

Good point.

>=20
> > +=09=09=09=09=09   u32 *sample_buf,
> > +=09=09=09=09=09   unsigned int samples)
> > +{
> > +=09unsigned int x_pos =3D 0;
> > +=09unsigned int y_pos =3D 0;
> > +=09unsigned int touch_pre =3D 0;
> > +=09unsigned int touch_post =3D 0;
> > +=09unsigned int i;
> > +=09int ret =3D 0;
> > +
> > +=09for (i =3D 0; i < samples; i++) {
> > +=09=09unsigned int index =3D MX25_ADCQ_FIFO_ID(sample_buf[i]);
> > +=09=09unsigned int val =3D MX25_ADCQ_FIFO_DATA(sample_buf[i]);
> > +
> > +=09=09switch (index) {
> > +=09=09case 1:
> > +=09=09=09touch_pre =3D val;
> > +=09=09=09break;
> > +=09=09case 2:
> > +=09=09=09x_pos =3D val;
> > +=09=09=09break;
> > +=09=09case 3:
> > +=09=09=09y_pos =3D val;
> > +=09=09=09break;
> > +=09=09case 5:
> > +=09=09=09touch_post =3D val;
> > +=09=09=09break;
> > +=09=09default:
> > +=09=09=09ret =3D -EINVAL;
> > +=09=09=09break;
> > +=09=09}
> > +=09}
> > +
> > +=09if (ret =3D=3D 0 && samples !=3D 0) {
>=20
> Where do we set ret to anything other than 0?

In the default case above.
I replaced the return -EINVAL with a debug message. This case shouldn't=
 happen
but just in case it does..

>=20
> > +=09=09/*
> > +=09=09 * only if both touch measures are below a threshold,
> > +=09=09 * the position is valid
> > +=09=09 */
> > +=09=09if (touch_pre < priv->pen_threshold &&
> > +=09=09    touch_post < priv->pen_threshold) {
> > +=09=09=09/* valid samples, generate a report */
> > +=09=09=09x_pos /=3D priv->sample_count;
> > +=09=09=09y_pos /=3D priv->sample_count;
> > +=09=09=09input_report_abs(priv->idev, ABS_X, x_pos);
> > +=09=09=09input_report_abs(priv->idev, ABS_Y, y_pos);
> > +=09=09=09input_report_key(priv->idev, BTN_TOUCH, 1);
> > +=09=09=09input_sync(priv->idev);
> > +
> > +=09=09=09/* get next sample */
> > +=09=09=09mx25_tcq_enable_fifo_irq(priv);
> > +=09=09} else if (touch_pre >=3D priv->pen_threshold &&
> > +=09=09=09   touch_post >=3D priv->pen_threshold) {
> > +=09=09=09/*
> > +=09=09=09 * if both samples are invalid,
> > +=09=09=09 * generate a release report
> > +=09=09=09 */
> > +=09=09=09input_report_key(priv->idev, BTN_TOUCH, 0);
> > +=09=09=09input_sync(priv->idev);
> > +=09=09=09mx25_tcq_re_enable_touch_detection(priv);
> > +=09=09} else {
> > +=09=09=09/*
> > +=09=09=09 * if only one of both touch measurements are
> > +=09=09=09 * below the threshold, still some bouncing
> > +=09=09=09 * happens. Take additional samples in this
> > +=09=09=09 * case to be sure
> > +=09=09=09 */
> > +=09=09=09mx25_tcq_enable_fifo_irq(priv);
> > +=09=09}
> > +=09}
> > +
> > +=09return ret;
> > +}
> > +
> > +static irqreturn_t mx25_tcq_irq_thread(int irq, void *dev_id)
> > +{
> > +=09struct mx25_tcq_priv *priv =3D dev_id;
> > +=09u32 sample_buf[TSC_MAX_SAMPLES];
> > +=09unsigned int samples =3D 0;
> > +
> > +=09/* read all samples */
> > +=09while (1) {
> > +=09=09u32 stats;
> > +
> > +=09=09regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
> > +=09=09if (stats & MX25_ADCQ_SR_EMPT)
> > +=09=09=09break;
> > +
> > +=09=09if (samples < TSC_MAX_SAMPLES) {
> > +=09=09=09regmap_read(priv->regs, MX25_ADCQ_FIFO,
> > +=09=09=09=09    &sample_buf[samples]);
> > +=09=09=09++samples;
> > +=09=09} else {
> > +=09=09=09u32 discarded;
> > +=09=09=09/* discard samples */
> > +=09=09=09regmap_read(priv->regs, MX25_ADCQ_FIFO, &discarded);
> > +=09=09}
> > +=09}
> > +
> > +=09mx25_tcq_create_event_for_4wire(priv, sample_buf, samples);
> > +
> > +=09return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t mx25_tcq_irq(int irq, void *dev_id)
> > +{
> > +=09struct mx25_tcq_priv *priv =3D dev_id;
> > +=09u32 stat;
> > +=09int ret =3D IRQ_HANDLED;
> > +
> > +=09regmap_read(priv->regs, MX25_ADCQ_SR, &stat);
>=20
> Is there any concern that these reads will fail?

This is always using mmio and we do not use the register clock feature.=
 So it
shouldn't fail.

>=20
> > +
> > +=09if (stat & (MX25_ADCQ_SR_FRR | MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_=
FOR))
> > +=09=09mx25_tcq_fifo_reset(priv);
> > +
> > +=09if (stat & MX25_ADCQ_SR_PD) {
> > +=09=09mx25_tcq_disable_touch_irq(priv);
> > +=09=09mx25_tcq_force_queue_start(priv);
> > +=09=09mx25_tcq_enable_fifo_irq(priv);
> > +=09}
> > +
> > +=09if (stat & MX25_ADCQ_SR_FDRY) {
> > +=09=09mx25_tcq_disable_fifo_irq(priv);
> > +=09=09ret =3D IRQ_WAKE_THREAD;
> > +=09}
> > +
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |=

> > +=09=09=09   MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR |
> > +=09=09=09   MX25_ADCQ_SR_PD | MX25_ADCQ_SR_EOQ,
> > +=09=09=09   MX25_ADCQ_SR_FRR | MX25_ADCQ_SR_FUR |
> > +=09=09=09   MX25_ADCQ_SR_FOR | MX25_ADCQ_SR_PD |
> > +=09=09=09   MX25_ADCQ_SR_EOQ);
> > +
> > +=09return ret;
> > +}
> > +
> > +/* configure the statemachine for a 4-wire touchscreen */
> > +static int mx25_tcq_init(struct mx25_tcq_priv *priv)
> > +{
> > +=09u32 tgcr;
> > +=09unsigned int ipg_div;
> > +=09unsigned int adc_period;
> > +=09unsigned int debounce_cnt;
> > +=09unsigned int settling_cnt;
> > +=09int itemct;
> > +=09int ret;
> > +
> > +=09regmap_read(priv->core_regs, MX25_TSC_TGCR, &tgcr);
> > +=09ipg_div =3D max_t(unsigned int, 4, MX25_TGCR_GET_ADCCLK(tgcr));=

> > +=09adc_period =3D USEC_PER_SEC * ipg_div * 2 + 2;
> > +=09adc_period /=3D clk_get_rate(priv->clk) / 1000 + 1;
> > +=09debounce_cnt =3D DIV_ROUND_UP(priv->pen_debounce, adc_period * =
8) - 1;
> > +=09settling_cnt =3D DIV_ROUND_UP(priv->settling_time, adc_period *=
 8) - 1;
> > +
> > +=09/* Reset */
> > +=09regmap_write(priv->regs, MX25_ADCQ_CR,
> > +=09=09     MX25_ADCQ_CR_QRST | MX25_ADCQ_CR_FRST);
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> > +=09=09=09   MX25_ADCQ_CR_QRST | MX25_ADCQ_CR_FRST, 0);
> > +
> > +=09/* up to 128 * 8 ADC clocks are possible */
> > +=09if (debounce_cnt > 127)
> > +=09=09debounce_cnt =3D 127;
> > +
> > +=09/* up to 255 * 8 ADC clocks are possible */
> > +=09if (settling_cnt > 255)
> > +=09=09settling_cnt =3D 255;
> > +
> > +=09ret =3D imx25_setup_queue_4wire(priv, settling_cnt, &itemct);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> > +=09=09=09   MX25_ADCQ_CR_LITEMID_MASK | MX25_ADCQ_CR_WMRK_MASK,
> > +=09=09=09   MX25_ADCQ_CR_LITEMID(itemct - 1) |
> > +=09=09=09   MX25_ADCQ_CR_WMRK(priv->expected_samples - 1));
> > +
> > +=09/* setup debounce count */
> > +=09regmap_update_bits(priv->core_regs, MX25_TSC_TGCR,
> > +=09=09=09   MX25_TGCR_PDBTIME_MASK,
> > +=09=09=09   MX25_TGCR_PDBTIME(debounce_cnt));
> > +
> > +=09/* enable debounce */
> > +=09regmap_update_bits(priv->core_regs, MX25_TSC_TGCR, MX25_TGCR_PD=
BEN,
> > +=09=09=09   MX25_TGCR_PDBEN);
> > +=09regmap_update_bits(priv->core_regs, MX25_TSC_TGCR, MX25_TGCR_PD=
EN,
> > +=09=09=09   MX25_TGCR_PDEN);
> > +
> > +=09/* enable the engine on demand */
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_QSM_M=
ASK,
> > +=09=09=09   MX25_ADCQ_CR_QSM_FQS);
> > +
> > +=09/* Enable repeat and repeat wait */
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> > +=09=09=09   MX25_ADCQ_CR_RPT | MX25_ADCQ_CR_RWAIT_MASK,
> > +=09=09=09   MX25_ADCQ_CR_RPT |
> > +=09=09=09   MX25_ADCQ_CR_RWAIT(MX25_TSC_REPEAT_WAIT));
> > +
> > +=09mx25_tcq_re_enable_touch_detection(priv);
> > +
> > +=09return 0;
> > +}
> > +
> > +static int mx25_tcq_parse_dt(struct platform_device *pdev,
> > +=09=09=09     struct mx25_tcq_priv *priv)
> > +{
> > +=09struct device_node *np =3D pdev->dev.of_node;
> > +=09u32 wires;
> > +=09int ret;
> > +
> > +=09/* Setup defaults */
> > +=09priv->pen_threshold =3D 500;
> > +=09priv->sample_count =3D 3;
> > +=09priv->pen_debounce =3D 1000000;
> > +=09priv->settling_time =3D 250000;
> > +
> > +=09ret =3D of_property_read_u32(np, "fsl,wires", &wires);
> > +=09if (ret) {
> > +=09=09dev_err(&pdev->dev, "Failed to find fsl,wires properties\n")=
;
> > +=09=09return ret;
> > +=09}
> > +
> > +=09if (wires =3D=3D 4) {
> > +=09=09priv->mode =3D MX25_TS_4WIRE;
> > +=09} else {
> > +=09=09dev_err(&pdev->dev, "%u-wire mode not supported\n", wires);
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09/* These are optional, we don't care about the return values */=

> > +=09of_property_read_u32(np, "fsl,pen-threshold", &priv->pen_thresh=
old);
> > +=09of_property_read_u32(np, "fsl,settling-time", &priv->settling_t=
ime);
> > +=09of_property_read_u32(np, "fsl,pen-debounce", &priv->pen_debounc=
e);
> > +
> > +=09return 0;
> > +}
> > +
> > +static int mx25_tcq_open(struct input_dev *idev)
> > +{
> > +=09struct device *dev =3D &idev->dev;
> > +=09struct mx25_tcq_priv *priv =3D dev_get_drvdata(dev);
> > +=09int ret;
> > +
> > +=09ret =3D clk_prepare_enable(priv->clk);
> > +=09if (ret) {
> > +=09=09dev_err(dev, "Failed to enable ipg clock\n");
> > +=09=09return ret;
> > +=09}
> > +
> > +=09ret =3D mx25_tcq_init(priv);
> > +=09if (ret) {
> > +=09=09dev_err(dev, "Failed to init tcq\n");
> > +=09=09clk_disable_unprepare(priv->clk);
> > +=09=09return ret;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static void mx25_tcq_close(struct input_dev *idev)
> > +{
> > +=09struct mx25_tcq_priv *priv =3D input_get_drvdata(idev);
> > +
> > +=09mx25_tcq_force_queue_stop(priv);
> > +=09mx25_tcq_disable_touch_irq(priv);
> > +=09mx25_tcq_disable_fifo_irq(priv);
> > +=09clk_disable_unprepare(priv->clk);
> > +}
> > +
> > +static int mx25_tcq_probe(struct platform_device *pdev)
> > +{
> > +=09struct device *dev =3D &pdev->dev;
> > +=09struct input_dev *idev;
> > +=09struct mx25_tcq_priv *priv;
> > +=09struct mx25_tsadc *tsadc =3D dev_get_drvdata(pdev->dev.parent);=

> > +=09struct resource *res;
> > +=09void __iomem *mem;
> > +=09int ret;
>=20
> Personal preference: can we call variables that hold error codes and =
not
> returned in success path (i.e. when we do explicit "return 0:' for
> success) be called "error"?

Yes that's fine for me, changed it for most functions in this driver.

> > +
> > +=09priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +=09if (!priv)
> > +=09=09return -ENOMEM;
> > +
> > +=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +=09mem =3D devm_ioremap_resource(dev, res);
> > +=09if (!mem)
>=20
> devm_ioremap_resource() returns ERR_PTR-encoded pointer, you should n=
ot
> test it for NULL bit rather for IS_ERR.

Fixed, thanks.

>=20
> > +=09=09return -ENOMEM;
> > +
> > +=09ret =3D mx25_tcq_parse_dt(pdev, priv);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09priv->regs =3D devm_regmap_init_mmio(dev, mem, &mx25_tcq_regcon=
fig);
> > +=09if (IS_ERR(priv->regs)) {
> > +=09=09dev_err(dev, "Failed to initialize regmap\n");
> > +=09=09return PTR_ERR(priv->regs);
> > +=09}
> > +
> > +=09priv->irq =3D platform_get_irq(pdev, 0);
> > +=09if (priv->irq <=3D 0) {
> > +=09=09dev_err(dev, "Failed to get IRQ\n");
> > +=09=09return priv->irq;
> > +=09}
> > +
> > +=09idev =3D devm_input_allocate_device(dev);
> > +=09if (!idev) {
> > +=09=09dev_err(dev, "Failed to allocate input device\n");
> > +=09=09return -ENOMEM;
> > +=09}
> > +
> > +=09idev->name =3D mx25_tcq_name;
> > +=09idev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > +=09idev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
>=20
> Replace the 2 lines above with:
>=20
> =09input_set_capability(idev, EV_BTN_TOUCH);

I assume you meant
=09input_set_capability(idev, EV_KEY, BTN_TOUCH);
and changed it to that.

>=20
> > +=09input_set_abs_params(idev, ABS_X, 0, 0xfff, 0, 0);
> > +=09input_set_abs_params(idev, ABS_Y, 0, 0xfff, 0, 0);
> > +
> > +=09idev->id.bustype =3D BUS_HOST;
> > +=09idev->open =3D mx25_tcq_open;
> > +=09idev->close =3D mx25_tcq_close;
> > +
> > +=09priv->idev =3D idev;
> > +=09input_set_drvdata(idev, priv);
> > +
> > +=09priv->core_regs =3D tsadc->regs;
> > +=09if (!priv->core_regs)
> > +=09=09return -EINVAL;
> > +
> > +=09priv->clk =3D tsadc->clk;
> > +=09if (!priv->clk)
> > +=09=09return -EINVAL;
> > +
> > +=09platform_set_drvdata(pdev, priv);
> > +
> > +=09ret =3D input_register_device(idev);
> > +=09if (ret) {
> > +=09=09dev_err(dev, "Failed to register input device\n");
> > +=09=09return ret;
> > +=09}
> > +
> > +=09ret =3D devm_request_threaded_irq(dev, priv->irq, mx25_tcq_irq,=

> > +=09=09=09=09=09mx25_tcq_irq_thread, IRQF_ONESHOT,
> > +=09=09=09=09=09pdev->name, priv);
> > +=09if (ret) {
> > +=09=09dev_err(dev, "Failed requesting IRQ\n");
> > +=09=09return ret;
> > +=09}
>=20
> Is it possible that we enable interrupt generation in the controller =
(in
> mx25_tcq_open) before we request IRQ and then (if someone touches the=

> screen) we'll get a spurious IRQ? I'd rather we swapped
> devm_request_threaded_irq() and input_register_device(): it is perfec=
tly
> safe to use (send events) to allocated but not registered input devic=
e.

Ok, if it is safe to send events for an allocated device I can't see wh=
y the
irq request shouldn't be first. I swapped these.

Thanks,

Markus

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart2445528.4SryevG9Bl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWTyEmAAoJEEpcgKtcEGQQELEQAJsP7grhWRE8cblo5PFc2dXU
F58VsM0p4bIXjaLAAcnHAaKG6UZ3fUPoBTC2+kJWyVD1aVf5Tt5DWNk6YJiYxJlH
t2oTQeCGB/p+GXNTU/BTQ12RdbpcB414e8Cxb1RulwxZcFJbnIk7afTQjeJELqdH
YznFm7wQbyFM1O8xYn3ELzJ9M/vb/+QFgWznX3seEgfFwrU1BpsBAfwP7HEk1ljk
kmjy3YET+Bwair0PE3tJxKL0nUUYEvKlHcqT1Y3oVPhMVkDfi6beYIHhlOyQlVPm
djeQ2OCgEF686y5Gg69n6CO9EvlsrZhHWdNPuWIrCRt0M4gx3J98yGv5iMKS9BF9
0WZZAGlK/LzX/Nn7WqRHdiX/13fzCgY57rImvBM+hadCwI+2r6dIzJ52ZNBbUiXe
0Cgwi3EZYM+JEzM2n06aI1/NciJAw1XfLXIEsSH6ycj49DOBZpqIYAcA30bWzqHL
0gcovvea3qVrjM6VbCDZb2bDdzvZjcqLj/K7P+Ikfd5eAqoA5Sr5Nj0U9VJbWLqW
l9ISOP/ZzOYoqtpimvvRM5yhjz+D/YvFVl2WfYp4GULyD0E74rGvgErx4NueDbcp
0vN+sJ91bOYZy04dId+bXCR6vxsv5O91G4nkP9sx6ineybtPCVuaDxI7tHJNT2JB
tULiXmHjYdE4S7B0K6Sz
=eTq5
-----END PGP SIGNATURE-----

--nextPart2445528.4SryevG9Bl--
