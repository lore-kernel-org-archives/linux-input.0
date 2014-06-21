From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
Date: Sat, 21 Jun 2014 11:18:00 +0100
Message-ID: <53A55BD8.7030905@kernel.org>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de> <1402672899-6995-1-git-send-email-denis@eukrea.com> <1402672899-6995-3-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42099 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885AbaFUKQD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Jun 2014 06:16:03 -0400
In-Reply-To: <1402672899-6995-3-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>

On 13/06/14 16:21, Denis Carikli wrote:
> From: Markus Pargmann <mpa@pengutronix.de>
>
> This is a driver for the imx25 ADC/TSC module. It controls the
> touchscreen conversion queue and creates a touchscreen input device.
> The driver currently only supports 4 wire touchscreens. The driver uses
> a simple conversion queue of precharge, touch detection, X measurement,
> Y measurement, precharge and another touch detection.
>
> This driver uses the regmap from the parent to setup some touch specific
> settings in the core driver and setup a idle configuration with touch
> detection.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
A couple of little bits inline.
I haven't looked in detail by the devm irq handling
looks dangerous as the clock is set to running before
this is enabled, but disabled before it is disabled.

Jonathan
> ---
>   .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |   29 +
>   drivers/input/touchscreen/Kconfig                  |    6 +
>   drivers/input/touchscreen/Makefile                 |    1 +
>   drivers/input/touchscreen/fsl-imx25-tcq.c          |  576 ++++++++++++++++++++
>   4 files changed, 612 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
>   create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> new file mode 100644
> index 0000000..4214a99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> @@ -0,0 +1,29 @@
> +Freescale mx25 TS conversion queue module
> +
> +mx25 touchscreen conversion queue module which controls the ADC unit of the
> +mx25 for attached touchscreens.
> +
> +Required properties:
> + - compatible: Should be "fsl,imx25-tcq".
> + - reg: Memory range of the device.
> + - interrupts: Should be the interrupt number associated with this module within
> +   the tscadc unit (<0>).
> + - interrupt-parent: Should be a phandle to the tscadc unit.
> + - fsl,wires: Should be '<4>' or '<5>'
> +
> +Optional properties:
> + - fsl,pen-debounce: Pen debounce time.
> + - fsl,pen-threshold: Pen-down threshold for the touchscreen.
> + - fsl,settling-time: Settling time in nanoseconds.
> +
> +This device includes two conversion queues which can be added as subnodes.
> +The first queue is for the touchscreen, the second for general purpose ADC.
> +
> +Example:
> +	tsc: tcq@50030400 {
> +		compatible = "fsl,imx25-tcq";
> +		reg = <0x50030400 0x60>;
> +		interrupt-parent = <&tscadc>;
> +		interrupts = <0>;
> +		fsl,wires = <4>;
> +	};
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index a23a94b..a2290b9 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -699,6 +699,12 @@ config TOUCHSCREEN_USB_COMPOSITE
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called usbtouchscreen.
>
> +config TOUCHSCREEN_MX25
> +	tristate "Freescale i.MX25 touchscreen input driver"
> +	depends on MFD_MX25_TSADC
> +	help
> +	  Enable support for touchscreen connected to your i.MX25.
> +
>   config TOUCHSCREEN_MC13783
>   	tristate "Freescale MC13783 touchscreen input driver"
>   	depends on MFD_MC13XXX
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 126479d..537d591 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
>   obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+= intel-mid-touch.o
>   obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+= lpc32xx_ts.o
>   obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+= max11801_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_MX25)		+= fsl-imx25-tcq.o
>   obj-$(CONFIG_TOUCHSCREEN_MC13783)	+= mc13783_ts.o
>   obj-$(CONFIG_TOUCHSCREEN_MCS5000)	+= mcs5000_ts.o
>   obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+= migor_ts.o
> diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
> new file mode 100644
> index 0000000..4ce576e
> --- /dev/null
> +++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
> @@ -0,0 +1,576 @@
> +/*
> + * Copyright 2014 Markus Pargmann, Pengutronix <mpa@pengutronix.de>
> + * Based on driver from 2011:
> + *   Juergen Beisert, Pengutronix <kernel@pengutronix.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + *
> + * This is the driver for the imx25 TCQ (Touchscreen Conversion Queue)
> + * connected to the imx25 ADC.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/mfd/imx25-tsadc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +static const char mx25_tcq_name[] = "mx25-tcq";
> +
> +enum mx25_tcq_mode {
> +	MX25_TS_4WIRE,
> +};
> +
> +struct mx25_tcq_priv {
> +	struct regmap *regs;
> +	struct regmap *core_regs;
> +	struct input_dev *idev;
> +	enum mx25_tcq_mode mode;
> +	unsigned int pen_threshold;
> +	unsigned int sample_count;
> +	unsigned int expected_samples;
> +	unsigned int pen_debounce;
> +	unsigned int settling_time;
> +	struct clk *clk;
> +};
> +
> +static struct regmap_config mx25_tcq_regconfig = {
> +	.fast_io = true,
> +	.max_register = 0x5c,
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static struct of_device_id mx25_tcq_ids[] = {
> +	{ .compatible = "fsl,imx25-tcq", },
> +	{ /* Senitel */ }
> +};
> +
> +#define TSC_4WIRE_PRE_INDEX 0
> +#define TSC_4WIRE_X_INDEX 1
> +#define TSC_4WIRE_Y_INDEX 2
> +#define TSC_4WIRE_POST_INDEX 3
> +#define TSC_4WIRE_LEAVE 4
> +
> +#define MX25_TSC_DEF_THRESHOLD 80
> +#define TSC_MAX_SAMPLES 16
> +
> +
> +enum mx25_adc_configurations {
> +	MX25_CFG_PRECHARGE = 0,
> +	MX25_CFG_TOUCH_DETECT,
> +	MX25_CFG_X_MEASUREMENT,
> +	MX25_CFG_Y_MEASUREMENT,
> +};
> +
> +#define MX25_PRECHARGE_VALUE (\
> +			MX25_ADCQ_CFG_YPLL_OFF | \
> +			MX25_ADCQ_CFG_XNUR_OFF | \
> +			MX25_ADCQ_CFG_XPUL_HIGH | \
> +			MX25_ADCQ_CFG_REFP_INT | \
> +			MX25_ADCQ_CFG_IN_XP | \
> +			MX25_ADCQ_CFG_REFN_NGND2 | \
> +			MX25_ADCQ_CFG_IGS)
> +
> +#define MX25_TOUCH_DETECT_VALUE (\
> +			MX25_ADCQ_CFG_YNLR | \
> +			MX25_ADCQ_CFG_YPLL_OFF | \
> +			MX25_ADCQ_CFG_XNUR_OFF | \
> +			MX25_ADCQ_CFG_XPUL_OFF | \
> +			MX25_ADCQ_CFG_REFP_INT | \
> +			MX25_ADCQ_CFG_IN_XP | \
> +			MX25_ADCQ_CFG_REFN_NGND2 | \
> +			MX25_ADCQ_CFG_PENIACK)
> +
> +static void imx25_setup_queue_cfgs(struct mx25_tcq_priv *priv,
> +		unsigned int settling_time)
> +{
> +	u32 precharge_cfg =
> +			MX25_PRECHARGE_VALUE |
> +			MX25_ADCQ_CFG_SETTLING_TIME(settling_time);
> +	u32 touch_detect_cfg =
> +			MX25_TOUCH_DETECT_VALUE |
> +			MX25_ADCQ_CFG_NOS(1) |
> +			MX25_ADCQ_CFG_SETTLING_TIME(settling_time);
> +
> +	regmap_write(priv->core_regs, MX25_TSC_TICR, precharge_cfg);
> +
> +	/* PRECHARGE */
> +	regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_PRECHARGE),
> +			precharge_cfg);
> +
> +	/* TOUCH_DETECT */
> +	regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_TOUCH_DETECT),
> +			touch_detect_cfg);
> +
> +	/* X Measurement */
> +	regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_X_MEASUREMENT),
> +			MX25_ADCQ_CFG_YPLL_OFF |
> +			MX25_ADCQ_CFG_XNUR_LOW |
> +			MX25_ADCQ_CFG_XPUL_HIGH |
> +			MX25_ADCQ_CFG_REFP_XP |
> +			MX25_ADCQ_CFG_IN_YP |
> +			MX25_ADCQ_CFG_REFN_XN |
> +			MX25_ADCQ_CFG_NOS(priv->sample_count) |
> +			MX25_ADCQ_CFG_SETTLING_TIME(settling_time));
> +
> +	/* Y Measurement */
> +	regmap_write(priv->regs, MX25_ADCQ_CFG(MX25_CFG_Y_MEASUREMENT),
> +			MX25_ADCQ_CFG_YNLR |
> +			MX25_ADCQ_CFG_YPLL_HIGH |
> +			MX25_ADCQ_CFG_XNUR_OFF |
> +			MX25_ADCQ_CFG_XPUL_OFF |
> +			MX25_ADCQ_CFG_REFP_YP |
> +			MX25_ADCQ_CFG_IN_XP |
> +			MX25_ADCQ_CFG_REFN_YN |
> +			MX25_ADCQ_CFG_NOS(priv->sample_count) |
> +			MX25_ADCQ_CFG_SETTLING_TIME(settling_time));
> +
> +	/* Enable the touch detection right now */
> +	regmap_write(priv->core_regs, MX25_TSC_TICR, touch_detect_cfg |
> +			MX25_ADCQ_CFG_IGS);
> +}
> +
> +static int imx25_setup_queue_4wire(struct mx25_tcq_priv *priv,
> +		unsigned settling_time, int *items)
> +{
> +	imx25_setup_queue_cfgs(priv, settling_time);
> +
> +	/* Setup the conversion queue */
> +	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
> +			MX25_ADCQ_ITEM(0, MX25_CFG_PRECHARGE) |
> +			MX25_ADCQ_ITEM(1, MX25_CFG_TOUCH_DETECT) |
> +			MX25_ADCQ_ITEM(2, MX25_CFG_X_MEASUREMENT) |
> +			MX25_ADCQ_ITEM(3, MX25_CFG_Y_MEASUREMENT) |
> +			MX25_ADCQ_ITEM(4, MX25_CFG_PRECHARGE) |
> +			MX25_ADCQ_ITEM(5, MX25_CFG_TOUCH_DETECT));
> +
> +	/* We measure X/Y with 'sample_count' number of samples and execute a
> +	 * touch detection twice, with 1 sample each */
> +	priv->expected_samples = priv->sample_count * 2 + 2;
> +	*items = 6;
> +
> +	return 0;
> +}
> +
> +static void mx25_tcq_disable_touch_irq(struct mx25_tcq_priv *priv)
> +{
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_PDMSK,
> +			MX25_ADCQ_CR_PDMSK);
> +}
> +
> +static void mx25_tcq_enable_touch_irq(struct mx25_tcq_priv *priv)
> +{
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_PDMSK, 0);
> +}
> +
> +static void mx25_tcq_disable_fifo_irq(struct mx25_tcq_priv *priv)
> +{
> +	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_FDRY_IRQ,
> +			MX25_ADCQ_MR_FDRY_IRQ);
> +}
> +
> +static void mx25_tcq_enable_fifo_irq(struct mx25_tcq_priv *priv)
> +{
> +	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_FDRY_IRQ, 0);
> +}
> +
> +static void mx25_tcq_force_queue_start(struct mx25_tcq_priv *priv)
> +{
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
> +			MX25_ADCQ_CR_FQS);
> +
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, 0);
> +}
> +
> +static void mx25_tcq_force_queue_stop(struct mx25_tcq_priv *priv)
> +{
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, 0);
> +}
> +
> +static void mx25_tcq_fifo_reset(struct mx25_tcq_priv *priv)
> +{
> +	u32 tcqcr;
> +
> +	regmap_read(priv->regs, MX25_ADCQ_CR, &tcqcr);
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FRST,
> +			MX25_ADCQ_CR_FRST);
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FRST,
> +			0);
> +	regmap_write(priv->regs, MX25_ADCQ_CR, tcqcr);
> +}
> +
> +static void mx25_tcq_re_enable_touch_detection(struct mx25_tcq_priv *priv)
> +{
> +	/* stop the queue from looping */
> +	mx25_tcq_force_queue_stop(priv);
> +
> +	/* for a clean touch detection, preload the X plane */
> +	regmap_write(priv->core_regs, MX25_TSC_TICR, MX25_PRECHARGE_VALUE);
> +
> +	/* waste some time now to pre-load the X plate to high voltage */
> +	mx25_tcq_fifo_reset(priv);
> +
> +	/* re-enable the detection right now */
> +	regmap_write(priv->core_regs, MX25_TSC_TICR, MX25_TOUCH_DETECT_VALUE |
> +			MX25_ADCQ_CFG_IGS);
> +
> +	regmap_update_bits(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_PD,
> +			MX25_ADCQ_SR_PD);
> +
> +	/* enable the pen down event to be a source for the interrupt */
> +	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_PD_IRQ, 0);
> +
> +	/* lets fire the next IRQ if someone touches the touchscreen */
> +	mx25_tcq_enable_touch_irq(priv);
> +}
> +
> +static int mx25_tcq_create_event_for_4wire(struct mx25_tcq_priv *priv,
> +		u32 *sample_buf, int samples)
> +{
> +	unsigned int x_pos = 0;
> +	unsigned int y_pos = 0;
> +	unsigned int touch_pre = 0;
> +	unsigned int touch_post = 0;
> +	unsigned i;
> +	int ret = 0;
> +
> +	for (i = 0; i < samples; i++) {
> +		unsigned int index = MX25_ADCQ_FIFO_ID(sample_buf[i]);
> +		unsigned int val = MX25_ADCQ_FIFO_DATA(sample_buf[i]);
> +
> +		switch (index) {
> +		case 1:
> +			touch_pre = val;
> +			break;
> +		case 2:
> +			x_pos = val;
> +			break;
> +		case 3:
> +			y_pos = val;
> +			break;
> +		case 5:
> +			touch_post = val;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}
> +
> +	if (ret == 0 && samples != 0) {
> +		/*
> +		 * only if both touch measures are below a treshold,
> +		 * the position is valid
> +		 */
> +		if (touch_pre < priv->pen_threshold &&
> +					touch_post < priv->pen_threshold) {
> +			/* valid samples, generate a report */
> +			x_pos /= priv->sample_count;
> +			y_pos /= priv->sample_count;
> +			input_report_abs(priv->idev, ABS_X, x_pos);
> +			input_report_abs(priv->idev, ABS_Y, y_pos);
> +			input_report_key(priv->idev, BTN_TOUCH,
> +					0xfff - ((touch_pre + touch_post) / 2));
> +			input_sync(priv->idev);
> +
> +			/* get next sample */
> +			mx25_tcq_force_queue_start(priv);
> +			mx25_tcq_enable_fifo_irq(priv);
> +		} else if (touch_pre >= priv->pen_threshold &&
> +				touch_post >= priv->pen_threshold) {
> +			/*
> +			 * if both samples are invalid,
> +			 * generate a release report
> +			 */
> +			input_report_key(priv->idev, BTN_TOUCH, 0);
> +			input_sync(priv->idev);
> +			mx25_tcq_re_enable_touch_detection(priv);
> +		} else {
> +			/*
> +			 * if only one of both touch measurements are
> +			 * below the threshold, still some bouncing
> +			 * happens. Take additional samples in this
> +			 * case to be sure
> +			 */
> +			mx25_tcq_force_queue_start(priv);
> +			mx25_tcq_enable_fifo_irq(priv);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t mx25_tcq_irq_thread(int irq, void *dev_id)
> +{
> +	struct mx25_tcq_priv *priv = (struct mx25_tcq_priv *) dev_id;
> +	u32 sample_buf[TSC_MAX_SAMPLES];
> +	int samples = 0;
> +
> +	/* read all samples */
> +	while (1) {
> +		u32 stats;
> +
> +		regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
> +		if (stats & MX25_ADCQ_SR_EMPT)
> +			break;
> +
> +		if (samples < TSC_MAX_SAMPLES) {
> +			regmap_read(priv->regs, MX25_ADCQ_FIFO,
> +							&sample_buf[samples]);
> +			++samples;
> +		} else {
> +			u32 discarded;
> +			/* discard samples */
> +			regmap_read(priv->regs, MX25_ADCQ_FIFO, &discarded);
> +		}
> +	}
> +
> +	mx25_tcq_create_event_for_4wire(priv, sample_buf, samples);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mx25_tcq_irq(int irq, void *dev_id)
> +{
> +	struct mx25_tcq_priv *priv = (struct mx25_tcq_priv *)dev_id;
> +	u32 stat;
> +	int ret = IRQ_HANDLED;
> +
> +	regmap_read(priv->regs, MX25_ADCQ_SR, &stat);
> +
> +	if (stat & (MX25_ADCQ_SR_FRR | MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR))
> +		mx25_tcq_fifo_reset(priv);
> +
> +	if (stat & MX25_ADCQ_SR_PD) {
> +		mx25_tcq_disable_touch_irq(priv);
> +		mx25_tcq_force_queue_start(priv);
> +		mx25_tcq_enable_fifo_irq(priv);
> +	}
> +
> +	if (stat & MX25_ADCQ_SR_FDRY) {
> +		mx25_tcq_disable_fifo_irq(priv);
> +		ret = IRQ_WAKE_THREAD;
> +	}
> +
> +	regmap_update_bits(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |
> +			MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR | MX25_ADCQ_SR_PD |
> +			MX25_ADCQ_SR_EOQ,
> +			MX25_ADCQ_SR_FRR |
> +			MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR | MX25_ADCQ_SR_PD |
> +			MX25_ADCQ_SR_EOQ);
> +
> +	return ret;
> +}
> +
> +/* configure the statemachine for a 4-wire touchscreen */
> +static int mx25_tcq_init(struct mx25_tcq_priv *priv)
> +{
> +	u32 tgcr;
> +	unsigned int ipg_div;
> +	unsigned int adc_period;
> +	unsigned int debounce_cnt;
> +	unsigned int settling_time;
> +	int itemct;
> +	int ret;
> +
> +	regmap_read(priv->core_regs, MX25_TSC_TGCR, &tgcr);
> +	ipg_div = max_t(unsigned int, 4, MX25_TGCR_GET_ADCCLK(tgcr));
> +	adc_period = clk_get_rate(priv->clk) / (ipg_div * 2 + 2);
> +	debounce_cnt = DIV_ROUND_UP(priv->pen_debounce, adc_period * 8) - 1;
> +	settling_time = DIV_ROUND_UP(priv->settling_time, adc_period);
> +
> +
> +	/* Reset */
> +	regmap_write(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_QRST |
> +			MX25_ADCQ_CR_FRST);
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_QRST |
> +			MX25_ADCQ_CR_FRST, 0);
> +
> +	/* up to 128 * 8 ADC clocks are possible */
> +	if (debounce_cnt > 127)
> +		debounce_cnt = 127;
> +
> +	ret = imx25_setup_queue_4wire(priv, 0x0, &itemct);
> +	if (ret)
> +		return ret;
> +
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_LITEMID_MASK |
> +			MX25_ADCQ_CR_WMRK_MASK,
> +			MX25_ADCQ_CR_LITEMID(itemct - 1) |
> +			MX25_ADCQ_CR_WMRK(priv->expected_samples - 1));
> +
> +	/* setup debounce count */
> +	regmap_update_bits(priv->core_regs, MX25_TSC_TGCR,
> +			MX25_TGCR_PDBTIME_MASK,
> +			MX25_TGCR_PDBTIME(debounce_cnt));
> +
> +	/* enable debounce */
> +	regmap_update_bits(priv->core_regs, MX25_TSC_TGCR, MX25_TGCR_PDBEN,
> +			MX25_TGCR_PDBEN);
> +	regmap_update_bits(priv->core_regs, MX25_TSC_TGCR, MX25_TGCR_PDEN,
> +			MX25_TGCR_PDEN);
> +
> +	/* enable the engine on demand */
> +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_QSM_FQS,
> +			MX25_ADCQ_CR_QSM_FQS);
> +
> +	mx25_tcq_re_enable_touch_detection(priv);
> +
> +	return 0;
> +}
> +
> +static int mx25_tcq_parse_dt(struct platform_device *pdev,
> +		struct mx25_tcq_priv *priv)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	u32 wires;
> +	int ret;
> +
> +	/* Setup defaults */
> +	priv->pen_threshold = 500;
> +	priv->sample_count = 3;
> +	priv->pen_debounce = 1000000;
> +	priv->settling_time = 250000;
> +
> +	ret = of_property_read_u32(np, "fsl,wires", &wires);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to find fsl,wires properties\n");
> +		return ret;
> +	}
> +
> +	if (wires == 4) {
> +		priv->mode = MX25_TS_4WIRE;
> +	} else {
> +		dev_err(&pdev->dev, "%u-wire mode not supported\n", wires);
> +		return -EINVAL;
> +	}
> +
> +	/* These are optional, we don't care about the return values */
> +	of_property_read_u32(np, "fsl,pen-threshold", &priv->pen_threshold);
> +	of_property_read_u32(np, "fsl,settling-time", &priv->settling_time);
> +	of_property_read_u32(np, "fsl,pen-debounce", &priv->pen_debounce);
> +
> +	return 0;
> +}
> +
> +static int mx25_tcq_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct input_dev *idev;
> +	struct mx25_tcq_priv *priv;
> +	struct resource *res;
> +	void __iomem *mem;
> +	int ret;
> +	int irq;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
Could this not in theory fail?
> +	mem = devm_ioremap_resource(dev, res);
> +	if (!mem)
> +		return -ENOMEM;
> +
> +	ret = mx25_tcq_parse_dt(pdev, priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->regs = devm_regmap_init_mmio(dev, mem, &mx25_tcq_regconfig);
> +	if (IS_ERR(priv->regs)) {
> +		dev_err(dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(priv->regs);
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0) {
> +		dev_err(dev, "Failed to get IRQ\n");
> +		return irq;
> +	}
> +
> +	idev = devm_input_allocate_device(dev);
> +	if (!idev) {
> +		dev_err(dev, "Failed to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	idev->name = mx25_tcq_name;
> +	idev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +	idev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +	input_set_abs_params(idev, ABS_X, 0, 0xfff, 0, 0);
> +	input_set_abs_params(idev, ABS_Y, 0, 0xfff, 0, 0);
> +
> +	idev->id.bustype = BUS_HOST;
> +
> +	ret = input_register_device(idev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register input device\n");
> +		return ret;
> +	}
> +
> +	priv->idev = idev;
> +
> +	priv->core_regs = mx25_tsadc_get_regmap(pdev->dev.parent);
> +	priv->clk = mx25_tsadc_get_ipg(pdev->dev.parent);
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable ipg clock\n");
> +		return ret;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, irq, mx25_tcq_irq,
> +			mx25_tcq_irq_thread, IRQF_ONESHOT, pdev->name, priv);
> +	if (ret) {
> +		dev_err(dev, "Failed requesting IRQ\n");
> +		return ret;
> +	}
This use of devm_request_threaded_irq strikes me as potentially dangerous
as the order in removing the device has the clock being disabled before
the interrupt is removed whereas for a simple unwinding they would be in
the other order.
> +
> +	ret = mx25_tcq_init(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to init tcq\n");
> +		goto error_tcq_init;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +error_tcq_init:
> +	clk_disable_unprepare(priv->clk);
> +	return ret;
> +}
> +
> +static int mx25_tcq_remove(struct platform_device *pdev)
> +{
> +	struct mx25_tcq_priv *priv = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mx25_tcq_driver = {
> +	.driver		= {
> +		.name	= "mx25-tcq",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = mx25_tcq_ids,
> +	},
> +	.probe		= mx25_tcq_probe,
> +	.remove		= mx25_tcq_remove,
> +};
> +module_platform_driver(mx25_tcq_driver);
> +
> +MODULE_DESCRIPTION("TS input driver for Freescale mx25");
> +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
> +MODULE_LICENSE("GPL v2");
>

