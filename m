From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 2/3] input: touchscreen: imx25 tcq driver
Date: Tue, 25 Feb 2014 12:05:44 +0100
Message-ID: <20140225110544.GC18317@pengutronix.de>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1392913312-9030-3-git-send-email-mpa@pengutronix.de>
 <20140223064406.GC10151@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43171 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaBYLFu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Feb 2014 06:05:50 -0500
Content-Disposition: inline
In-Reply-To: <20140223064406.GC10151@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 22, 2014 at 10:44:06PM -0800, Dmitry Torokhov wrote:
> Hi Marjus,
>=20
> On Thu, Feb 20, 2014 at 05:21:51PM +0100, Markus Pargmann wrote:
> > This is a driver for the imx25 ADC/TSC module. It controls the
> > touchscreen conversion queue and creates a touchscreen input device.
> > The driver currently only supports 4 wire touchscreens. The driver uses
> > a simple conversion queue of precharge, touch detection, X measurement,
> > Y measurement, precharge and another touch detection.
> >=20
> > This driver uses the regmap from the parent to setup some touch specific
> > settings in the core driver and setup a idle configuration with touch
> > detection.
> >=20
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane=
=2Eorg>
> > ---
> >  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  29 +
> >  drivers/input/touchscreen/Kconfig                  |   6 +
> >  drivers/input/touchscreen/Makefile                 |   1 +
> >  drivers/input/touchscreen/fsl-imx25-tcq.c          | 589 +++++++++++++=
++++++++
> >  4 files changed, 625 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/fsl-mx25-tcq.txt
> >  create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx=
25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-t=
cq.txt
> > new file mode 100644
> > index 0000000..4214a99
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.=
txt
> > @@ -0,0 +1,29 @@
> > +Freescale mx25 TS conversion queue module
> > +
> > +mx25 touchscreen conversion queue module which controls the ADC unit o=
f the
> > +mx25 for attached touchscreens.
> > +
> > +Required properties:
> > + - compatible: Should be "fsl,imx25-tcq".
> > + - reg: Memory range of the device.
> > + - interrupts: Should be the interrupt number associated with this mod=
ule within
> > +   the tscadc unit (<0>).
> > + - interrupt-parent: Should be a phandle to the tscadc unit.
> > + - fsl,wires: Should be '<4>' or '<5>'
> > +
> > +Optional properties:
> > + - fsl,pen-debounce: Pen debounce time.
> > + - fsl,pen-threshold: Pen-down threshold for the touchscreen.
> > + - fsl,settling-time: Settling time in nanoseconds.
> > +
> > +This device includes two conversion queues which can be added as subno=
des.
> > +The first queue is for the touchscreen, the second for general purpose=
 ADC.
> > +
> > +Example:
> > +	tsc: tcq@50030400 {
> > +		compatible =3D "fsl,imx25-tcq";
> > +		reg =3D <0x50030400 0x60>;
> > +		interrupt-parent =3D <&tscadc>;
> > +		interrupts =3D <0>;
> > +		fsl,wires =3D <4>;
> > +	};
> > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
> > index 07e9e82..d52c055 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -715,6 +715,12 @@ config TOUCHSCREEN_USB_COMPOSITE
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called usbtouchscreen.
> > =20
> > +config TOUCHSCREEN_MX25
> > +	tristate "Freescale i.MX25 touchscreen input driver"
> > +	depends on MFD_MX25_TSADC
> > +	help
> > +	  Enable support for touchscreen connected to your i.MX25.
> > +
> >  config TOUCHSCREEN_MC13783
> >  	tristate "Freescale MC13783 touchscreen input driver"
> >  	depends on MFD_MC13XXX
> > diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
> > index 62801f2..c891f30 100644
> > --- a/drivers/input/touchscreen/Makefile
> > +++ b/drivers/input/touchscreen/Makefile
> > @@ -38,6 +38,7 @@ obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+=3D inexio.o
> >  obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+=3D intel-mid-touch.o
> >  obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+=3D lpc32xx_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+=3D max11801_ts.o
> > +obj-$(CONFIG_TOUCHSCREEN_MX25)		+=3D fsl-imx25-tcq.o
> >  obj-$(CONFIG_TOUCHSCREEN_MC13783)	+=3D mc13783_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_MCS5000)	+=3D mcs5000_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+=3D migor_ts.o
> > diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/=
touchscreen/fsl-imx25-tcq.c
> > new file mode 100644
> > index 0000000..436cc8b
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
> > @@ -0,0 +1,589 @@
> > +/*
> > + * Copyright 2014 Markus Pargmann, Pengutronix <mpa-bIcnvbaLZ9MEGnE8C9=
+IrQ@public.gmane.org>
> > + * Based on driver from 2011 Juergen Beisert, Pengutronix <kernel-bIcn=
vbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + *
> > + * This is the driver for the imx25 TCQ (Touchscreen Conversion Queue)
> > + * connected to the imx25 ADC.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/input.h>
> > +#include <linux/mfd/imx25-tsadc.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +static const char mx25_tcq_name[] =3D "mx25-tcq";
> > +
> > +enum mx25_tcq_mode {
> > +	MX25_TS_4WIRE,
> > +};
> > +
> > +struct mx25_tcq_priv {
> > +	struct regmap *regs;
> > +	struct regmap *core_regs;
> > +	struct input_dev *idev;
> > +	enum mx25_tcq_mode mode;
> > +	unsigned int pen_threshold;
> > +	unsigned int sample_count;
> > +	unsigned int expected_samples;
> > +	unsigned int repeat_wait;
> > +	unsigned int pen_debounce;
> > +	unsigned int settling_time;
> > +	struct clk *clk;
> > +};
> > +
> > +static struct regmap_config mx25_tcq_regconfig =3D {
> > +	.fast_io =3D true,
> > +	.max_register =3D 0x5c,
> > +	.reg_bits =3D 32,
> > +	.val_bits =3D 32,
> > +	.reg_stride =3D 4,
> > +};
> > +
> > +static struct of_device_id mx25_tcq_ids[] =3D {
> > +	{ .compatible =3D "fsl,imx25-tcq", },
> > +	{ /* Senitel */ }
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
> > +
> > +enum mx25_adc_configurations {
> > +	MX25_CFG_PRECHARGE =3D 0,
> > +	MX25_CFG_TOUCH_DETECT,
> > +	MX25_CFG_X_MEASUREMENT,
> > +	MX25_CFG_Y_MEASUREMENT,
> > +};
> > +
> > +#define MX25_PRECHARGE_VALUE (\
> > +			MX25_ADCQ_CFG_YPLL_OFF | \
> > +			MX25_ADCQ_CFG_XNUR_OFF | \
> > +			MX25_ADCQ_CFG_XPUL_HIGH | \
> > +			MX25_ADCQ_CFG_REFP_INT | \
> > +			MX25_ADCQ_CFG_IN_XP | \
> > +			MX25_ADCQ_CFG_REFN_NGND2 | \
> > +			MX25_ADCQ_CFG_IGS)
> > +
> > +#define MX25_TOUCH_DETECT_VALUE (\
> > +			MX25_ADCQ_CFG_YNLR | \
> > +			MX25_ADCQ_CFG_YPLL_OFF | \
> > +			MX25_ADCQ_CFG_XNUR_OFF | \
> > +			MX25_ADCQ_CFG_XPUL_OFF | \
> > +			MX25_ADCQ_CFG_REFP_INT | \
> > +			MX25_ADCQ_CFG_IN_XP | \
> > +			MX25_ADCQ_CFG_REFN_NGND2 | \
> > +			MX25_ADCQ_CFG_PENIACK)
> > +
> > +static void imx25_setup_queue_cfgs(struct mx25_tcq_priv *priv,
> > +		unsigned int settling_time)
> > +{
> > +	u32 precharge_cfg =3D
> > +			MX25_PRECHARGE_VALUE |
> > +			MX25_ADCQ_CFG_SETTLING_TIME(settling_time);
> > +	u32 touch_detect_cfg =3D
> > +			MX25_TOUCH_DETECT_VALUE |
> > +			MX25_ADCQ_CFG_NOS(1) |
> > +			MX25_ADCQ_CFG_SETTLING_TIME(settling_time);
> > +
> > +	regmap_write(priv->core_regs, MX25_TSC_TICR, precharge_cfg);
> > +
> > +	/* PRECHARGE */
> > +	regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_PRECHARGE),
> > +			precharge_cfg);
> > +
> > +	/* TOUCH_DETECT */
> > +	regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_TOUCH_DETECT),
> > +			touch_detect_cfg);
> > +
> > +	/* X Measurement */
> > +	regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_X_MEASUREMENT),
> > +			MX25_ADCQ_CFG_YPLL_OFF |
> > +			MX25_ADCQ_CFG_XNUR_LOW |
> > +			MX25_ADCQ_CFG_XPUL_HIGH |
> > +			MX25_ADCQ_CFG_REFP_XP |
> > +			MX25_ADCQ_CFG_IN_YP |
> > +			MX25_ADCQ_CFG_REFN_XN |
> > +			MX25_ADCQ_CFG_NOS(priv->sample_count) |
> > +			MX25_ADCQ_CFG_SETTLING_TIME(settling_time));
> > +
> > +	/* Y Measurement */
> > +	regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_Y_MEASUREMENT),
> > +			MX25_ADCQ_CFG_YNLR |
> > +			MX25_ADCQ_CFG_YPLL_HIGH |
> > +			MX25_ADCQ_CFG_XNUR_OFF |
> > +			MX25_ADCQ_CFG_XPUL_OFF |
> > +			MX25_ADCQ_CFG_REFP_YP |
> > +			MX25_ADCQ_CFG_IN_XP |
> > +			MX25_ADCQ_CFG_REFN_YN |
> > +			MX25_ADCQ_CFG_NOS(priv->sample_count) |
> > +			MX25_ADCQ_CFG_SETTLING_TIME(settling_time));
> > +
> > +	/* Enable the touch detection right now */
> > +	regmap_write(priv->core_regs, MX25_TSC_TICR, touch_detect_cfg |
> > +			MX25_ADCQ_CFG_IGS);
> > +}
> > +
> > +static int imx25_setup_queue_4wire(struct mx25_tcq_priv *priv,
> > +		unsigned settling_time, int *items)
> > +{
> > +	imx25_setup_queue_cfgs(priv, settling_time);
> > +
> > +	/* Setup the conversion queue */
> > +	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
> > +			MX25_ADCQ_ITEM(0, MX25_CFG_PRECHARGE) |
> > +			MX25_ADCQ_ITEM(1, MX25_CFG_TOUCH_DETECT) |
> > +			MX25_ADCQ_ITEM(2, MX25_CFG_X_MEASUREMENT) |
> > +			MX25_ADCQ_ITEM(3, MX25_CFG_Y_MEASUREMENT) |
> > +			MX25_ADCQ_ITEM(4, MX25_CFG_PRECHARGE) |
> > +			MX25_ADCQ_ITEM(5, MX25_CFG_TOUCH_DETECT));
> > +
> > +	/* We measure X/Y with 'sample_count' number of samples and execute a
> > +	 * touch detection twice, with 1 sample each */
> > +	priv->expected_samples =3D priv->sample_count * 2 + 2;
> > +	*items =3D 6;
> > +
> > +	return 0;
> > +}
> > +
> > +static void mx25_tcq_disable_touch_irq(struct mx25_tcq_priv *priv)
> > +{
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_PDMSK,
> > +			MX25_ADCQ_CR_PDMSK);
> > +}
> > +
> > +static void mx25_tcq_enable_touch_irq(struct mx25_tcq_priv *priv)
> > +{
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_PDMSK, 0);
> > +}
> > +
> > +static void mx25_tcq_disable_fifo_irq(struct mx25_tcq_priv *priv)
> > +{
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_FDRY_IRQ,
> > +			MX25_ADCQ_MR_FDRY_IRQ);
> > +}
> > +
> > +static void mx25_tcq_enable_fifo_irq(struct mx25_tcq_priv *priv)
> > +{
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_FDRY_IRQ, 0=
);
> > +}
> > +
> > +static void mx25_tcq_force_queue_start(struct mx25_tcq_priv *priv)
> > +{
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
> > +			MX25_ADCQ_CR_FQS);
> > +
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, 0);
> > +}
> > +
> > +static void mx25_tcq_force_queue_stop(struct mx25_tcq_priv *priv)
> > +{
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, 0);
> > +}
> > +
> > +static void mx25_tcq_fifo_reset(struct mx25_tcq_priv *priv)
> > +{
> > +	u32 tcqcr;
> > +
> > +	regmap_read(priv->regs, MX25_ADCQ_CR, &tcqcr);
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FRST,
> > +			MX25_ADCQ_CR_FRST);
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FRST,
> > +			0);
> > +	regmap_write(priv->regs, MX25_ADCQ_CR, tcqcr);
> > +}
> > +
> > +static void mx25_tcq_re_enable_touch_detection(struct mx25_tcq_priv *p=
riv)
> > +{
> > +	/* stop the queue from looping */
> > +	mx25_tcq_force_queue_stop(priv);
> > +
> > +	/* for a clean touch detection, preload the X plane */
> > +	regmap_write(priv->core_regs, MX25_TSC_TICR, MX25_PRECHARGE_VALUE);
> > +
> > +	/* waste some time now to pre-load the X plate to high voltage */
> > +	mx25_tcq_fifo_reset(priv);
> > +
> > +	/* re-enable the detection right now */
> > +	regmap_write(priv->core_regs, MX25_TSC_TICR, MX25_TOUCH_DETECT_VALUE |
> > +			MX25_ADCQ_CFG_IGS);
> > +
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_PD,
> > +			MX25_ADCQ_SR_PD);
> > +
> > +	/* enable the pen down event to be a source for the interrupt */
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_PD_IRQ, 0);
> > +
> > +	/* lets fire the next IRQ if someone touches the touchscreen */
> > +	mx25_tcq_enable_touch_irq(priv);
> > +}
> > +
> > +static int mx25_tcq_create_event_for_4wire(struct mx25_tcq_priv *priv,
> > +		u32 *sample_buf, int samples)
> > +{
> > +	unsigned int x_pos =3D 0;
> > +	unsigned int y_pos =3D 0;
> > +	unsigned int touch_pre =3D 0;
> > +	unsigned int touch_post =3D 0;
> > +	unsigned i;
> > +	int ret =3D 0;
> > +
> > +	for (i =3D 0; i < samples; i++) {
> > +		unsigned int index =3D MX25_ADCQ_FIFO_ID(sample_buf[i]);
> > +		unsigned int val =3D MX25_ADCQ_FIFO_DATA(sample_buf[i]);
> > +
> > +		switch (index) {
> > +		case 1:
> > +			touch_pre =3D val;
> > +			break;
> > +		case 2:
> > +			x_pos =3D val;
> > +			break;
> > +		case 3:
> > +			y_pos =3D val;
> > +			break;
> > +		case 5:
> > +			touch_post =3D val;
> > +			break;
> > +		default:
> > +			ret =3D -EINVAL;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (ret =3D=3D 0 && samples !=3D 0) {
> > +		/*
> > +		 * only if both touch measures are below a treshold,
> > +		 * the position is valid
> > +		 */
> > +		if (touch_pre < priv->pen_threshold &&
> > +					touch_post < priv->pen_threshold) {
> > +			/* valid samples, generate a report */
> > +			x_pos /=3D priv->sample_count;
> > +			y_pos /=3D priv->sample_count;
> > +			input_report_abs(priv->idev, ABS_X, x_pos);
> > +			input_report_abs(priv->idev, ABS_Y, y_pos);
> > +			input_report_key(priv->idev, BTN_TOUCH,
> > +					0xfff - ((touch_pre + touch_post) / 2));
>=20
> Hmm, are you trying to report pressure here?

No this is only to detect touches, not pressure. Reporting pressure
would require a different, more complex conversion queue.

>=20
> > +			input_sync(priv->idev);
> > +
> > +			/* get next sample */
> > +			mx25_tcq_force_queue_start(priv);
> > +			mx25_tcq_enable_fifo_irq(priv);
> > +		} else {
> > +			if (touch_pre >=3D priv->pen_threshold &&
>=20
> You can convert this to "else if" and save indentation level here.

Fixed.

>=20
> > +					touch_post >=3D priv->pen_threshold) {
> > +				/*
> > +				 * if both samples are invalid,
> > +				 * generate a release report
> > +				 */
> > +				input_report_key(priv->idev, BTN_TOUCH, 0);
> > +				input_sync(priv->idev);
> > +				mx25_tcq_re_enable_touch_detection(priv);
> > +			} else {
> > +				/*
> > +				 * if only one of both touch measurements are
> > +				 * below the threshold, still some bouncing
> > +				 * happens. Take additional samples in this
> > +				 * case to be sure
> > +				 */
> > +				mx25_tcq_force_queue_start(priv);
> > +				mx25_tcq_enable_fifo_irq(priv);
> > +			}
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static irqreturn_t mx25_tcq_irq_thread(int irq, void *dev_id)
> > +{
> > +	struct mx25_tcq_priv *priv =3D (struct mx25_tcq_priv *) dev_id;
> > +	u32 sample_buf[TSC_MAX_SAMPLES];
> > +	int samples =3D 0;
> > +
> > +	/* read all samples */
> > +	while (1) {
> > +		u32 stats;
> > +
> > +		regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
>=20
> Error handling for I/O operations?

This is memory mapped io. It only returns an error when the clock enable
operation fails. As regmap is not configured to use a clock for this
driver, I would prefer to not use error handling for regmap_read/write.

>=20
> > +		if (stats & MX25_ADCQ_SR_EMPT)
> > +			break;
> > +
> > +		if (samples < TSC_MAX_SAMPLES) {
> > +			regmap_read(priv->regs, MX25_ADCQ_FIFO,
> > +					&sample_buf[samples]);
> > +			++samples;
> > +		} else {
> > +			u32 discarded;
> > +			/* discard samples */
> > +			regmap_read(priv->regs, MX25_ADCQ_FIFO, &discarded);
>=20
> Should there be some upper bound for number of discarded samples?

I just noticed that we do not repeat the conversion queue. The bit is
not set, so all the repeat code can be removed. This also means that the
conversion is stopped when we reach the end of the conversion queue and
this should not need an additional upper bound for discarded samples.

>=20
> > +		}
> > +	}
> > +
> > +	mx25_tcq_create_event_for_4wire(priv, sample_buf, samples);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t mx25_tcq_irq(int irq, void *dev_id)
> > +{
> > +	struct mx25_tcq_priv *priv =3D (struct mx25_tcq_priv *)dev_id;
> > +	u32 stat;
> > +	int ret =3D IRQ_HANDLED;
> > +
> > +	regmap_read(priv->regs, MX25_ADCQ_SR, &stat);
> > +
> > +	if (stat & (MX25_ADCQ_SR_FRR | MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR))
> > +		mx25_tcq_fifo_reset(priv);
> > +
> > +	if (stat & MX25_ADCQ_SR_PD) {
> > +		mx25_tcq_disable_touch_irq(priv);
> > +		mx25_tcq_force_queue_start(priv);
> > +		mx25_tcq_enable_fifo_irq(priv);
> > +	}
> > +
> > +	if (stat & MX25_ADCQ_SR_FDRY) {
> > +		mx25_tcq_disable_fifo_irq(priv);
> > +		ret =3D IRQ_WAKE_THREAD;
> > +	}
> > +
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |
> > +			MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR | MX25_ADCQ_SR_PD |
> > +			MX25_ADCQ_SR_EOQ,
> > +			MX25_ADCQ_SR_FRR |
> > +			MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR | MX25_ADCQ_SR_PD |
> > +			MX25_ADCQ_SR_EOQ);
> > +
> > +	return ret;
> > +}
> > +
> > +/* configure the statemachine for a 4-wire touchscreen */
> > +static int mx25_tcq_init(struct mx25_tcq_priv *priv)
> > +{
> > +	u32 tgcr;
> > +	unsigned int ipg_div;
> > +	unsigned int adc_period;
> > +	unsigned int repeat_wait;
> > +	unsigned int debounce_cnt;
> > +	unsigned int settling_time;
> > +	int itemct;
> > +	int ret;
> > +
> > +	regmap_read(priv->core_regs, MX25_TSC_TGCR, &tgcr);
> > +	ipg_div =3D max_t(unsigned int, 4, MX25_TGCR_GET_ADCCLK(tgcr));
> > +	adc_period =3D clk_get_rate(priv->clk) / (ipg_div * 2 + 2);
> > +	repeat_wait =3D fls(DIV_ROUND_UP(priv->repeat_wait, adc_period));
> > +	debounce_cnt =3D DIV_ROUND_UP(priv->pen_debounce, adc_period * 8) - 1;
> > +	settling_time =3D DIV_ROUND_UP(priv->settling_time, adc_period);
> > +
> > +
> > +	/* Reset */
> > +	regmap_write(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_QRST |
> > +			MX25_ADCQ_CR_FRST);
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_QRST |
> > +			MX25_ADCQ_CR_FRST, 0);
> > +
> > +	/* up to 128 * 8 ADC clocks are possible */
> > +	if (debounce_cnt > 127)
> > +		debounce_cnt =3D 127;
> > +
> > +	if (repeat_wait > 15)
> > +		repeat_wait =3D 15;
> > +
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_RWAIT_MASK,
> > +			MX25_ADCQ_CR_RWAIT(repeat_wait));
> > +
> > +	ret =3D imx25_setup_queue_4wire(priv, 0x0, &itemct);
> > +	if (ret)
> > +		return ret;
> > +
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_LITEMID_MAS=
K |
> > +			MX25_ADCQ_CR_WMRK_MASK,
> > +			MX25_ADCQ_CR_LITEMID(itemct - 1) |
> > +			MX25_ADCQ_CR_WMRK(priv->expected_samples - 1));
> > +
> > +	/* setup debounce count */
> > +	regmap_update_bits(priv->core_regs, MX25_TSC_TGCR,
> > +			MX25_TGCR_PDBTIME_MASK,
> > +			MX25_TGCR_PDBTIME(debounce_cnt));
> > +
> > +	/* enable debounce */
> > +	regmap_update_bits(priv->core_regs, MX25_TSC_TGCR, MX25_TGCR_PDBEN,
> > +			MX25_TGCR_PDBEN);
> > +	regmap_update_bits(priv->core_regs, MX25_TSC_TGCR, MX25_TGCR_PDEN,
> > +			MX25_TGCR_PDEN);
> > +
> > +	/* enable the engine on demand */
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_QSM_FQS,
> > +			MX25_ADCQ_CR_QSM_FQS);
> > +
> > +	mx25_tcq_re_enable_touch_detection(priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mx25_tcq_parse_dt(struct platform_device *pdev,
> > +		struct mx25_tcq_priv *priv)
> > +{
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	u32 wires;
> > +	int ret;
> > +
> > +	/* Setup defaults */
> > +	priv->pen_threshold =3D 500;
> > +	priv->sample_count =3D 3;
> > +	priv->repeat_wait =3D 15000000;
> > +	priv->pen_debounce =3D 1000000;
> > +	priv->settling_time =3D 250000;
> > +
> > +	ret =3D of_property_read_u32(np, "fsl,wires", &wires);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to find fsl,wires properties\n");
> > +		return ret;
> > +	}
> > +
> > +	if (wires =3D=3D 4) {
> > +		priv->mode =3D MX25_TS_4WIRE;
> > +	} else {
> > +		dev_err(&pdev->dev, "%u-wire mode not supported\n", wires);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* These are optional, we don't care about the return values */
> > +	of_property_read_u32(np, "fsl,pen-threshold", &priv->pen_threshold);
> > +	of_property_read_u32(np, "fsl,settling-time", &priv->settling_time);
> > +	of_property_read_u32(np, "fsl,pen-debounce", &priv->pen_debounce);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mx25_tcq_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct input_dev *idev;
> > +	struct mx25_tcq_priv *priv;
> > +	struct resource *res;
> > +	void __iomem *mem;
> > +	int ret;
> > +	int irq;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	mem =3D devm_ioremap_resource(dev, res);
> > +	if (!mem) {
> > +		dev_err(dev, "Failed to get iomem");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret =3D mx25_tcq_parse_dt(pdev, priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->regs =3D devm_regmap_init_mmio(dev, mem, &mx25_tcq_regconfig);
> > +	if (IS_ERR(priv->regs)) {
> > +		dev_err(dev, "Failed to initialize regmap\n");
> > +		return PTR_ERR(priv->regs);
> > +	}
> > +
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(dev, "Failed to get IRQ\n");
> > +		return irq;
> > +	}
> > +
> > +	ret =3D devm_request_threaded_irq(dev, irq, mx25_tcq_irq,
> > +			mx25_tcq_irq_thread, IRQF_ONESHOT, pdev->name, priv);
> > +	if (ret) {
> > +		dev_err(dev, "Failed requesting IRQ\n");
> > +		return ret;
> > +	}
>=20
> Are we sure the device is quiesce here? Otherwise interrupts will start
> coming but input device is not there yet.

I moved it to the end of the probe function just before tcq_init where
the interrupts are enabled.

>=20
> > +
> > +	idev =3D devm_input_allocate_device(dev);
> > +	if (!idev) {
> > +		dev_err(dev, "Failed to allocate input device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	idev->name =3D mx25_tcq_name;
> > +	idev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > +	idev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
> > +	input_set_abs_params(idev, ABS_X, 0, 0xfff, 0, 0);
> > +	input_set_abs_params(idev, ABS_Y, 0, 0xfff, 0, 0);
> > +
> > +	idev->id.bustype =3D BUS_HOST;
> > +
> > +	ret =3D input_register_device(idev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to register input device\n");
> > +		return ret;
> > +	}
> > +
> > +	priv->idev =3D idev;
> > +
> > +	priv->core_regs =3D mx25_tsadc_get_regmap(pdev->dev.parent);
> > +	priv->clk =3D mx25_tsadc_get_ipg(pdev->dev.parent);
> > +
> > +	ret =3D clk_prepare_enable(priv->clk);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable ipg clock\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D mx25_tcq_init(priv);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to init tcq\n");
> > +		goto error_tcq_init;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +
> > +error_tcq_init:
> > +	clk_disable_unprepare(priv->clk);
> > +	return ret;
> > +}
> > +
> > +static int mx25_tcq_remove(struct platform_device *pdev)
> > +{
> > +	struct mx25_tcq_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +	clk_disable_unprepare(priv->clk);
>=20
> Hmm, if you disable clk all other operations will likely to fail. We
> really need devm clk interface, I guess I need to dust off my old
> patch...
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver mx25_tcq_driver =3D {
> > +	.driver		=3D {
> > +		.name	=3D "mx25-tcq",
> > +		.owner	=3D THIS_MODULE,
> > +		.of_match_table =3D mx25_tcq_ids,
> > +	},
> > +	.probe		=3D mx25_tcq_probe,
> > +	.remove		=3D mx25_tcq_remove,
> > +};
> > +module_platform_driver(mx25_tcq_driver);
> > +
> > +MODULE_DESCRIPTION("TS input driver for Freescale mx25");
> > +MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gman=
e.org>");
> > +MODULE_LICENSE("GPL v2");
> > --=20
> > 1.8.5.3
> >=20

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTDHkIAAoJEEpcgKtcEGQQJcwP/R0ssacB3FVK+QwvenSTIx43
bzBvkLjPzTbi9bP0c6GTLTaZjmY3CNAav+XYbMQqoBaVWoA1NuNMcB3OovpVBXJP
4FlUSbSu4gr70vxRSw/eioztqJ91flqE77zBqL1IoDgemhLkfnZly4pMu0Boeypi
oLiPMc9pEgfBj1OTp5GZ62FFmEOLxkq66JHntTeBkUyroFvWsPBYSgaXUTR0HcRI
YYprG+Ht+yv6U5Pt34tUs9KLS38QW1t3WSBMqTcZHWcWhDFo4qVMevbth08b2mBH
uQF+8glLEZHSoC1OENiTXA1BnvXgearh7BvPnuU8Y7xSqNVbCtOSJ6kf3R29f2VH
j3RkC7j+c63aloiRQB9FvMkttxoh+Fvwwff5KODu0z5x02gDqON8R0faCG7cbrhX
iejqTJLHmrfjZBKGcR0aK3ovTI/9suspsLuDaxKNZk011GEoUeNPqZsTOyIO+sJN
9Ak+X6YMH9RmBErYjJxHOE7MZ12pDWAGR0l0K4iwLH0+Q3JrVQoqbu3eCHfEDFhZ
zdfX4FfIdHkv/0NodpEwVN3MVlKPnpT4E9TI0edBtrgZI/834cjfCIfJmSH0xt8v
19+8VsLJVRQ9icRXuOLQcsd/ASBf0t1jNAx+oDDwr4lAm/SnRmvpYLPjdbi5fys/
5vPnbpJh6FdHaLb3BxaP
=gYEG
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
