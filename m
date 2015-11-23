From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v8 6/8] input: touchscreen: imx25 tcq driver
Date: Mon, 23 Nov 2015 14:43:20 +0100
Message-ID: <68969672.YElqsov9vm@adelgunde>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de> <1447675269-8831-7-git-send-email-mpa@pengutronix.de> <5650AE5A.5010506@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1687716.X4tKKalEu7"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40694 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbbKWNnu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 08:43:50 -0500
In-Reply-To: <5650AE5A.5010506@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Denis Carikli <denis@eukrea.com>, Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <festevam@gmail.com>, Juergen Borleis <jbe@pengutronix.de>


--nextPart1687716.X4tKKalEu7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Saturday 21 November 2015 17:48:10 Jonathan Cameron wrote:
> On 16/11/15 12:01, Markus Pargmann wrote:
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
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> >=20
> > [fix clock's period calculation]
> > [fix calculation of the 'settling' value]
> > Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> I read this out of curiousity to see how you had handled the touchscr=
een
> usecase of this hardware differently from the generic version.
>=20
> Anyhow, a few little bits and pieces inline from me as a result
>=20
> Jonathan
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
> > + *   Juergen Beisert, Pengutronix <kernel@pengutronix.de>
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
> Another personal preference. I'd not bother wrapping these single lin=
e
> calls up but rather just make them inline.  They don't in of
> themselves add much to my mind.  Still this one is very much up to yo=
u
> as far as I'm concerned.
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
> It's not a terribly big fifo, so I'm not convinced personally
> of the merits of having the separate thread for this interrupt...

Yes that is correct, but it is calling into the input framework as well=
.
I am not sure how much work is done there. Also the thread shouldn't be=

extremely costy as it is mostly sleeping?

>=20
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
> Comment on how this could happen would be good.

This could happen if there are new samples while we read all samples
from=20the fifo.

Thanks to your comment I had a closer look on this handler again. The
problem here is that we read x samples while x may be a different numbe=
r
than the number of samples generated by the conversion queue. But only
want to read samples that were produced by exactly one conversion queue=

run.

So I redesigned this handler to first read the number of samples in the=

fifo and then read as many as we want.

>=20
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
> > +
> > +=09if (stat & (MX25_ADCQ_SR_FRR | MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_=
FOR))
> > +=09=09mx25_tcq_fifo_reset(priv);
> Again, currious cross comparison with the adc driver (hardware is pre=
tty
> much the same ;)  In there you don't reset the fifo if you get one
> of these.  Why not?  Now you should never get one as you only ever sc=
hedule
> a single reading, but best to be consistent.

Yes, the conversion queue in the touch driver is running continously so=

that this may happen. Actually a fifo reset is not enough here. For the=

touch we need to reset the conversion queue as well, thanks.
This could be added to the gcq driver but this should never happen.

>=20
> > +
> > +=09if (stat & MX25_ADCQ_SR_PD) {
> > +=09=09mx25_tcq_disable_touch_irq(priv);
> > +=09=09mx25_tcq_force_queue_start(priv);
> > +=09=09mx25_tcq_enable_fifo_irq(priv);
> > +=09}
> > +
> > +=09if (stat & MX25_ADCQ_SR_FDRY) {
> > +=09=09mx25_tcq_disable_fifo_irq(priv);
> I'm missing something I think.. In a oneshot irq the irq will be mask=
ed
> anyway till the thread is done.  Why the explicit disable as well?

The driver which receives the interrupts for both units GCQ and TCQ has=

a proper interrupt status register. It uses this register to distribute=

them to the different units. The problem is that it doesn't have a mask=

register. The interrupts can only be masked in the TCQ or GCQ unit. So
by default the interrupt for both units will be masked.

GCQ currently doesn't use any time-critical interrupts. But waiting for=

the thread shouldn't block the other unit. So I think it's better to
mask the interrupt here explicitly. This of course should not be with
IRQF_ONESHOT. That's a mistake, will fix that.

>=20
> > +=09=09ret =3D IRQ_WAKE_THREAD;
> > +=09}
> > +
> > +=09regmap_update_bits(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |=

> > +=09=09=09   MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR |
> > +=09=09=09   MX25_ADCQ_SR_PD | MX25_ADCQ_SR_EOQ,
> > +=09=09=09   MX25_ADCQ_SR_FRR | MX25_ADCQ_SR_FUR |
> > +=09=09=09   MX25_ADCQ_SR_FOR | MX25_ADCQ_SR_PD |
> > +=09=09=09   MX25_ADCQ_SR_EOQ);
> As with the adc driver you are clearing at least one bit that should
> not I think ever be set... EOQ.  Why?

Indeed, this is always masked. Thanks, removed that.

> > +
> > +=09return ret;
> > +}
> > +
> > +/* configure the statemachine for a 4-wire touchscreen */
> state machine
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
> There is a certain missbalance in naming at least between the open
> and the close.   I'd be tempted to reorganise the two so that
> they obviously balance..  Either split up the init into the various
> things such as enabling the interrupts and bringing the queue up
> (so the oposite of the remove) or wrap the remove calls up in an
> _exit which can easily be compared to the init)
>=20
> This definitely comes in the category of writing the code so it
> is 'obviously correct', rather than making review harder!
>=20
> There is also some stuff in that init - like enabling debounce that
> isn't undone in the close - to my mind that suggests it doesn't
> belong in this function, but rather in device startup, but I may
> well be missing some interactions in the hardware that prevent this.

Yes, init() is more of a reset_configure_and_init() function. I will tr=
y
to make this more obvious.

>=20
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
> > +
> > +=09priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +=09if (!priv)
> > +=09=09return -ENOMEM;
> > +
> > +=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +=09mem =3D devm_ioremap_resource(dev, res);
> > +=09if (!mem)
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
> I'm not 100% sure of whether input works the way I think it does ;)
> but I'd imagine this just exposed the userspace interface.  Hence fro=
m
> here on you can open the device and cause the interrupt to be enabled=
.
> It doesn't have a handler until after the request_threaded_irq device=

> below...  So nasty if unlikely race condition here.

Yes, fixed as Dmitry suggested.

>=20
> > +=09if (ret) {
> > +=09=09dev_err(dev, "Failed to register input device\n");
> > +=09=09return ret;
> > +=09}
> > +
> > +=09ret =3D devm_request_threaded_irq(dev, priv->irq, mx25_tcq_irq,=

> > +=09=09=09=09=09mx25_tcq_irq_thread, IRQF_ONESHOT,
> > +=09=09=09=09=09pdev->name, priv);
> currious difference in approach here.  Why a devm call in this driver=

> and not in the adc one?  I assumed general paranoia with devm irq req=
uests
> and the various obscure ways they can go wrong so didn't mention it t=
here...

For the gcq driver we have things are a bit different. There is no real=

open()/close() function. We configure the unit once (including
interrupts) and want to be careful when shutting down the driver to do
it in the right order of disabling clocks, interrupts and regulators.
The interrupts there are actually never masked there.

In this tcq driver the interrupts are masked and clocks are off when th=
e
input was closed.

Thanks,

Markus

> > +=09if (ret) {
> > +=09=09dev_err(dev, "Failed requesting IRQ\n");
> > +=09=09return ret;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static struct platform_driver mx25_tcq_driver =3D {
> > +=09.driver=09=09=3D {
> > +=09=09.name=09=3D "mx25-tcq",
> > +=09=09.of_match_table =3D mx25_tcq_ids,
> > +=09},
> > +=09.probe=09=09=3D mx25_tcq_probe,
> > +};
> > +module_platform_driver(mx25_tcq_driver);
> > +
> > +MODULE_DESCRIPTION("TS input driver for Freescale mx25");
> > +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
> > +MODULE_LICENSE("GPL v2");
> >=20
>=20
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

--nextPart1687716.X4tKKalEu7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWUxgIAAoJEEpcgKtcEGQQMjUQAJMP7/P3doyLXKQPHRW6/FQo
/LO9WK9zRvga6ASePdcGO19hj2/3cm6Zb4edkhbIdFgx7ILQ3pwJ6WnRZ+iDWrql
YgcBUaJPRedQGNCIhZAWGlB1miMlZJnWRmjI88B2bC8TTed8gFo7Gb8f31vgwY6v
iGnRyft3ul4j+A8kT7TVPq8JX0W31sE2zx2kRLlhA+VihGNM88l0eJruVBphHQmg
POGmqMhST+UZcQeiH0p1EkI/0Sw1MSnTk8QKDLxLMCL2GKj7HNrFoeGidhh6SKkK
iwtVdaH9HB5gO244v7lAv8LB04psURJ38th6szGG54cRhWMlXFytCqoOiyDsdtuH
Dc7O+NzD1Lgn8h0xllLHMU7QFrwzilz467/r2YOrmnsaO23QxwNTcYCQSlwt0NoZ
kzld57dRTWpbwgjXCiSWBccAYozphhs+SEs8H/WgBwsxk/jY67097DP9lEIoxgbF
1QjCB6fglalA79KG/sjeluWsoI9XiIADWLxkQMhNms9VKXgowJAisbdpkaJ4xx47
b0eZcMRios2UpFbMlAD7BN1zsXuj/9/Zy+WAeXKuCzO65ADKG+G99eGGzNl2pHPz
RGa2XoUx6UwVrDTNWzKy4ZrTgWBeOtz42TbIUzFL9X8fGbdGr+HNFW3iDBJ3Hu94
ZCoOGHWNhAApQOtVr/Ru
=ZPI2
-----END PGP SIGNATURE-----

--nextPart1687716.X4tKKalEu7--

