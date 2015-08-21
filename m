From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/5] input: touchscreen: add imx6ul_tsc driver support
Date: Fri, 21 Aug 2015 11:26:07 +0200
Message-ID: <20150821092607.GA706@pengutronix.de>
References: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
 <1438077521-12857-2-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438077521-12857-2-git-send-email-haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2015 at 05:58:37PM +0800, Haibo Chen wrote:
> Freescale i.MX6UL contains a internal touchscreen controller,
> this patch add a driver to support this controller.
>=20
> Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/input/touchscreen/Kconfig      |  12 +
>  drivers/input/touchscreen/Makefile     |   1 +
>  drivers/input/touchscreen/imx6ul_tsc.c | 504 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 517 insertions(+)
>  create mode 100644 drivers/input/touchscreen/imx6ul_tsc.c
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscree=
n/Kconfig
> index 5b272ba..32c300d 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -479,6 +479,18 @@ config TOUCHSCREEN_MTOUCH
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mtouch.
> =20
> +config TOUCHSCREEN_IMX6UL_TSC
> +	tristate "Freescale i.MX6UL touchscreen controller"
> +	depends on OF
> +	help
> +	  Say Y here if you have a Freescale i.MX6UL, and want to
> +	  use the internal touchscreen controller.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  moduel will be called imx6ul_tsc.
> +
>  config TOUCHSCREEN_INEXIO
>  	tristate "iNexio serial touchscreens"
>  	select SERIO
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscre=
en/Makefile
> index c85aae2..9379b32 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+=3D egalax_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+=3D fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+=3D goodix.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+=3D ili210x.o
> +obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC)	+=3D imx6ul_tsc.o
>  obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+=3D inexio.o
>  obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+=3D intel-mid-touch.o
>  obj-$(CONFIG_TOUCHSCREEN_IPROC)		+=3D bcm_iproc_tsc.o
> diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touch=
screen/imx6ul_tsc.c
> new file mode 100644
> index 0000000..807f1db
> --- /dev/null
> +++ b/drivers/input/touchscreen/imx6ul_tsc.c
> @@ -0,0 +1,504 @@
> +/*
> + * Freescale i.MX6UL touchscreen controller driver
> + *
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/gpio.h>
> +#include <linux/input.h>
> +#include <linux/slab.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +/* ADC configuration registers field define */
> +#define ADC_AIEN		(0x1 << 7)
> +#define ADC_CONV_DISABLE	0x1F
> +#define ADC_CAL			(0x1 << 7)
> +#define ADC_CALF		0x2
> +#define ADC_12BIT_MODE		(0x2 << 2)
> +#define ADC_IPG_CLK		0x00
> +#define ADC_CLK_DIV_8		(0x03 << 5)
> +#define ADC_SHORT_SAMPLE_MODE	(0x0 << 4)
> +#define ADC_HARDWARE_TRIGGER	(0x1 << 13)
> +#define SELECT_CHANNEL_4	0x04
> +#define SELECT_CHANNEL_1	0x01
> +#define DISABLE_CONVERSION_INT	(0x0 << 7)
> +
> +/* ADC registers */
> +#define REG_ADC_HC0		0x00
> +#define REG_ADC_HC1		0x04
> +#define REG_ADC_HC2		0x08
> +#define REG_ADC_HC3		0x0C
> +#define REG_ADC_HC4		0x10
> +#define REG_ADC_HS		0x14
> +#define REG_ADC_R0		0x18
> +#define REG_ADC_CFG		0x2C
> +#define REG_ADC_GC		0x30
> +#define REG_ADC_GS		0x34
> +
> +#define ADC_TIMEOUT		msecs_to_jiffies(100)

These defines are in two drivers. Here and in
drivers/iio/adc/vf610_adc.c

> +
> +/* TSC registers */
> +#define REG_TSC_BASIC_SETING	0x00
> +#define REG_TSC_PRE_CHARGE_TIME	0x10
> +#define REG_TSC_FLOW_CONTROL	0x20
> +#define REG_TSC_MEASURE_VALUE	0x30
> +#define REG_TSC_INT_EN		0x40
> +#define REG_TSC_INT_SIG_EN	0x50
> +#define REG_TSC_INT_STATUS	0x60
> +#define REG_TSC_DEBUG_MODE	0x70
> +#define REG_TSC_DEBUG_MODE2	0x80
> +
> +/* TSC configuration registers field define */
> +#define DETECT_4_WIRE_MODE	(0x0 << 4)
> +#define AUTO_MEASURE		0x1
> +#define MEASURE_SIGNAL		0x1
> +#define DETECT_SIGNAL		(0x1 << 4)
> +#define VALID_SIGNAL		(0x1 << 8)
> +#define MEASURE_INT_EN		0x1
> +#define MEASURE_SIG_EN		0x1
> +#define VALID_SIG_EN		(0x1 << 8)
> +#define DE_GLITCH_2		(0x2 << 29)
> +#define START_SENSE		(0x1 << 12)
> +#define TSC_DISABLE		(0x1 << 16)
> +#define DETECT_MODE		0x2
> +
> +struct imx6ul_tsc {
> +	struct device *dev;
> +	struct input_dev *input;
> +	void __iomem *tsc_regs;
> +	void __iomem *adc_regs;
> +	struct clk *tsc_clk;
> +	struct clk *adc_clk;
> +
> +	int xnur_gpio;
> +	int measure_delay_time;
> +	int pre_charge_time;
> +
> +	struct completion completion;
> +};
> +
> +/*
> + * TSC module need ADC to get the measure value. So
> + * before config TSC, we should initialize ADC module.
> + */
> +static void imx6ul_adc_init(struct imx6ul_tsc *tsc)
> +{
> +	int adc_hc =3D 0;
> +	int adc_gc;
> +	int adc_gs;
> +	int adc_cfg;
> +	int timeout;
> +
> +	adc_cfg =3D readl(tsc->adc_regs + REG_ADC_CFG);
> +	adc_cfg |=3D ADC_12BIT_MODE | ADC_IPG_CLK;
> +	adc_cfg |=3D ADC_CLK_DIV_8 | ADC_SHORT_SAMPLE_MODE;
> +	adc_cfg &=3D ~ADC_HARDWARE_TRIGGER;
> +	writel(adc_cfg, tsc->adc_regs + REG_ADC_CFG);
> +
> +	/* enable calibration interrupt */
> +	adc_hc |=3D ADC_AIEN;
> +	adc_hc |=3D ADC_CONV_DISABLE;
> +	writel(adc_hc, tsc->adc_regs + REG_ADC_HC0);
> +
> +	/* start ADC calibration */
> +	adc_gc =3D readl(tsc->adc_regs + REG_ADC_GC);
> +	adc_gc |=3D ADC_CAL;
> +	writel(adc_gc, tsc->adc_regs + REG_ADC_GC);
> +
> +	timeout =3D wait_for_completion_timeout
> +			(&tsc->completion, ADC_TIMEOUT);
> +	if (timeout =3D=3D 0)
> +		dev_err(tsc->dev, "Timeout for adc calibration\n");
> +
> +	adc_gs =3D readl(tsc->adc_regs + REG_ADC_GS);
> +	if (adc_gs & ADC_CALF)
> +		dev_err(tsc->dev, "ADC calibration failed\n");
> +
> +	/* TSC need the ADC work in hardware trigger */
> +	adc_cfg =3D readl(tsc->adc_regs + REG_ADC_CFG);
> +	adc_cfg |=3D ADC_HARDWARE_TRIGGER;
> +	writel(adc_cfg, tsc->adc_regs + REG_ADC_CFG);
> +}
> +
> +/*
> + * This is a TSC workaround. Currently TSC misconnect two
> + * ADC channels, this function remap channel configure for
> + * hardware trigger.
> + */
> +static void imx6ul_tsc_channel_config(struct imx6ul_tsc *tsc)
> +{
> +	int adc_hc0, adc_hc1, adc_hc2, adc_hc3, adc_hc4;
> +
> +	adc_hc0 =3D DISABLE_CONVERSION_INT;
> +	writel(adc_hc0, tsc->adc_regs + REG_ADC_HC0);
> +
> +	adc_hc1 =3D DISABLE_CONVERSION_INT | SELECT_CHANNEL_4;
> +	writel(adc_hc1, tsc->adc_regs + REG_ADC_HC1);
> +
> +	adc_hc2 =3D DISABLE_CONVERSION_INT;
> +	writel(adc_hc2, tsc->adc_regs + REG_ADC_HC2);
> +
> +	adc_hc3 =3D DISABLE_CONVERSION_INT | SELECT_CHANNEL_1;
> +	writel(adc_hc3, tsc->adc_regs + REG_ADC_HC3);
> +
> +	adc_hc4 =3D DISABLE_CONVERSION_INT;
> +	writel(adc_hc4, tsc->adc_regs + REG_ADC_HC4);
> +}

Is this code similar to initialization of the adc driver? Does it make
sense to move this code to the ADC driver?

Best regards,

Markus

> +
> +/*
> + * TSC setting, confige the pre-charge time and measure delay time.
> + * different touch screen may need different pre-charge time and
> + * measure delay time.
> + */
> +static void imx6ul_tsc_set(struct imx6ul_tsc *tsc)
> +{
> +	int basic_setting =3D 0;
> +	int start;
> +
> +	basic_setting |=3D tsc->measure_delay_time << 8;
> +	basic_setting |=3D DETECT_4_WIRE_MODE | AUTO_MEASURE;
> +	writel(basic_setting, tsc->tsc_regs + REG_TSC_BASIC_SETING);
> +
> +	writel(DE_GLITCH_2, tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
> +
> +	writel(tsc->pre_charge_time, tsc->tsc_regs + REG_TSC_PRE_CHARGE_TIME);
> +	writel(MEASURE_INT_EN, tsc->tsc_regs + REG_TSC_INT_EN);
> +	writel(MEASURE_SIG_EN | VALID_SIG_EN,
> +		tsc->tsc_regs + REG_TSC_INT_SIG_EN);
> +
> +	/* start sense detection */
> +	start =3D readl(tsc->tsc_regs + REG_TSC_FLOW_CONTROL);
> +	start |=3D START_SENSE;
> +	start &=3D ~TSC_DISABLE;
> +	writel(start, tsc->tsc_regs + REG_TSC_FLOW_CONTROL);
> +}
> +
> +static void imx6ul_tsc_init(struct imx6ul_tsc *tsc)
> +{
> +	imx6ul_adc_init(tsc);
> +	imx6ul_tsc_channel_config(tsc);
> +	imx6ul_tsc_set(tsc);
> +}
> +
> +static irqreturn_t tsc_irq_fn(int irq, void *dev_id)
> +{
> +	struct imx6ul_tsc *tsc =3D (struct imx6ul_tsc *)dev_id;
> +	int status;
> +	int value;
> +	int x, y;
> +	int xnur;
> +	int debug_mode2;
> +	int state_machine;
> +	int start;
> +	unsigned long timeout;
> +
> +	status =3D readl(tsc->tsc_regs + REG_TSC_INT_STATUS);
> +
> +	/* write 1 to clear the bit measure-signal */
> +	writel(MEASURE_SIGNAL | DETECT_SIGNAL,
> +		tsc->tsc_regs + REG_TSC_INT_STATUS);
> +
> +	/* It's a HW self-clean bit. Set this bit and start sense detection */
> +	start =3D readl(tsc->tsc_regs + REG_TSC_FLOW_CONTROL);
> +	start |=3D START_SENSE;
> +	writel(start, tsc->tsc_regs + REG_TSC_FLOW_CONTROL);
> +
> +	if (status & MEASURE_SIGNAL) {
> +		value =3D readl(tsc->tsc_regs + REG_TSC_MEASURE_VALUE);
> +		x =3D (value >> 16) & 0x0fff;
> +		y =3D value & 0x0fff;
> +
> +		/*
> +		 * Delay some time(max 2ms), wait the pre-charge done.
> +		 * After the pre-change mode, TSC go into detect mode.
> +		 * And in detect mode, we can get the xnur gpio value.
> +		 * If xnur is low, this means the touch screen still
> +		 * be touched. If xnur is high, this means finger leave
> +		 * the touch screen.
> +		 */
> +		timeout =3D jiffies + HZ/500;
> +		do {
> +			if (time_after(jiffies, timeout)) {
> +				xnur =3D 0;
> +				goto touch_event;
> +			}
> +			usleep_range(200, 400);
> +			debug_mode2 =3D readl(tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
> +			state_machine =3D (debug_mode2 >> 20) & 0x7;
> +		} while (state_machine !=3D DETECT_MODE);
> +		usleep_range(200, 400);
> +
> +		xnur =3D gpio_get_value(tsc->xnur_gpio);
> +touch_event:
> +		if (xnur =3D=3D 0) {
> +			input_report_key(tsc->input, BTN_TOUCH, 1);
> +			input_report_abs(tsc->input, ABS_X, x);
> +			input_report_abs(tsc->input, ABS_Y, y);
> +		} else
> +			input_report_key(tsc->input, BTN_TOUCH, 0);
> +
> +		input_sync(tsc->input);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t adc_irq_fn(int irq, void *dev_id)
> +{
> +	struct imx6ul_tsc *tsc =3D (struct imx6ul_tsc *)dev_id;
> +	int coco;
> +	int value;
> +
> +	coco =3D readl(tsc->adc_regs + REG_ADC_HS);
> +	if (coco & 0x01) {
> +		value =3D readl(tsc->adc_regs + REG_ADC_R0);
> +		complete(&tsc->completion);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct of_device_id imx6ul_tsc_match[] =3D {
> +	{ .compatible =3D "fsl,imx6ul-tsc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx6ul_tsc_match);
> +
> +static int imx6ul_tsc_probe(struct platform_device *pdev)
> +{
> +	struct imx6ul_tsc *tsc;
> +	struct resource *tsc_mem;
> +	struct resource *adc_mem;
> +	struct input_dev *input_dev;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	int err;
> +	int tsc_irq;
> +	int adc_irq;
> +
> +	tsc =3D devm_kzalloc(&pdev->dev, sizeof(struct imx6ul_tsc), GFP_KERNEL);
> +	input_dev =3D devm_input_allocate_device(&pdev->dev);
> +
> +	tsc->dev =3D &pdev->dev;
> +
> +	tsc->input =3D input_dev;
> +	tsc->input->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +	tsc->input->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
> +	input_set_abs_params(tsc->input, ABS_X, 0, 0xFFF, 0, 0);
> +	input_set_abs_params(tsc->input, ABS_Y, 0, 0xFFF, 0, 0);
> +
> +	tsc->input->name =3D "iMX6UL TouchScreen Controller";
> +
> +	tsc->xnur_gpio =3D of_get_named_gpio(np, "xnur-gpio", 0);
> +	err =3D gpio_request_one(tsc->xnur_gpio, GPIOF_IN, "tsc_X-");
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to request GPIO tsc_X-\n");
> +		return err;
> +	}
> +
> +	tsc_mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	tsc->tsc_regs =3D devm_ioremap_resource(&pdev->dev, tsc_mem);
> +	if (IS_ERR(tsc->tsc_regs)) {
> +		dev_err(&pdev->dev, "failed to remap tsc memory\n");
> +		err =3D PTR_ERR(tsc->tsc_regs);
> +		return err;
> +	}
> +
> +	adc_mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	tsc->adc_regs =3D devm_ioremap_resource(&pdev->dev, adc_mem);
> +	if (IS_ERR(tsc->adc_regs)) {
> +		dev_err(&pdev->dev, "failed to remap adc memory\n");
> +		err =3D PTR_ERR(tsc->adc_regs);
> +		return err;
> +	}
> +
> +	tsc->tsc_clk =3D devm_clk_get(&pdev->dev, "tsc");
> +	if (IS_ERR(tsc->tsc_clk)) {
> +		dev_err(&pdev->dev, "failed getting tsc clock\n");
> +		err =3D PTR_ERR(tsc->tsc_clk);
> +		return err;
> +	}
> +
> +	tsc->adc_clk =3D devm_clk_get(&pdev->dev, "adc");
> +	if (IS_ERR(tsc->adc_clk)) {
> +		dev_err(&pdev->dev, "failed getting adc clock\n");
> +		err =3D PTR_ERR(tsc->adc_clk);
> +		return err;
> +	}
> +
> +	tsc_irq =3D platform_get_irq(pdev, 0);
> +	if (tsc_irq < 0) {
> +		dev_err(&pdev->dev, "no tsc irq resource?\n");
> +		return tsc_irq;
> +	}
> +
> +	adc_irq =3D platform_get_irq(pdev, 1);
> +	if (adc_irq <=3D 0) {
> +		dev_err(&pdev->dev, "no adc irq resource?\n");
> +		return adc_irq;
> +	}
> +
> +	err =3D devm_request_threaded_irq(tsc->dev, tsc_irq,
> +					NULL, tsc_irq_fn,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					dev_name(&pdev->dev), tsc);
> +	if (err < 0) {
> +		dev_err(&pdev->dev,
> +			"failed requesting tsc irq %d\n",
> +					    tsc_irq);
> +		return err;
> +	}
> +
> +	err =3D devm_request_irq(tsc->dev, adc_irq,
> +				adc_irq_fn, 0,
> +				dev_name(&pdev->dev), tsc);
> +	if (err < 0) {
> +		dev_err(&pdev->dev,
> +			"failed requesting adc irq %d\n",
> +					    adc_irq);
> +		return err;
> +	}
> +
> +	err =3D of_property_read_u32(np, "measure-delay-time",
> +				&tsc->measure_delay_time);
> +	if (err)
> +		tsc->measure_delay_time =3D 0xffff;
> +
> +	err =3D of_property_read_u32(np, "pre-charge-time",
> +				&tsc->pre_charge_time);
> +	if (err)
> +		tsc->pre_charge_time =3D 0xfff;
> +
> +	init_completion(&tsc->completion);
> +
> +	err =3D clk_prepare_enable(tsc->adc_clk);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Could not prepare or enable the adc clock.\n");
> +		return err;
> +	}
> +
> +	err =3D clk_prepare_enable(tsc->tsc_clk);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Could not prepare or enable the tsc clock.\n");
> +		goto error_tsc_clk_enable;
> +	}
> +
> +	err =3D input_register_device(tsc->input);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		err =3D -EIO;
> +		goto err_input_register;
> +	}
> +
> +	imx6ul_tsc_init(tsc);
> +
> +	platform_set_drvdata(pdev, tsc);
> +	return 0;
> +
> +err_input_register:
> +	clk_disable_unprepare(tsc->tsc_clk);
> +error_tsc_clk_enable:
> +	clk_disable_unprepare(tsc->adc_clk);
> +
> +	return err;
> +}
> +
> +static void imx6ul_tsc_disable(struct imx6ul_tsc *tsc)
> +{
> +	int tsc_flow;
> +	int adc_cfg;
> +
> +	/* TSC controller enters to idle status */
> +	tsc_flow =3D readl(tsc->tsc_regs + REG_TSC_FLOW_CONTROL);
> +	tsc_flow |=3D TSC_DISABLE;
> +	writel(tsc_flow, tsc->tsc_regs + REG_TSC_FLOW_CONTROL);
> +
> +	/* ADC controller enters to stop mode */
> +	adc_cfg =3D readl(tsc->adc_regs + REG_ADC_HC0);
> +	adc_cfg |=3D ADC_CONV_DISABLE;
> +	writel(adc_cfg, tsc->adc_regs + REG_ADC_HC0);
> +}
> +
> +static int imx6ul_tsc_remove(struct platform_device *pdev)
> +{
> +	struct imx6ul_tsc *tsc =3D platform_get_drvdata(pdev);
> +
> +	imx6ul_tsc_disable(tsc);
> +
> +	clk_disable_unprepare(tsc->tsc_clk);
> +	clk_disable_unprepare(tsc->adc_clk);
> +	input_unregister_device(tsc->input);
> +	kfree(tsc);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imx6ul_tsc_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct imx6ul_tsc *tsc =3D platform_get_drvdata(pdev);
> +
> +	imx6ul_tsc_disable(tsc);
> +
> +	clk_disable_unprepare(tsc->tsc_clk);
> +	clk_disable_unprepare(tsc->adc_clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imx6ul_tsc_resume(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct imx6ul_tsc *tsc =3D platform_get_drvdata(pdev);
> +	int err;
> +
> +	err =3D clk_prepare_enable(tsc->adc_clk);
> +	if (err)
> +		return err;
> +
> +	err =3D clk_prepare_enable(tsc->tsc_clk);
> +	if (err) {
> +		clk_disable_unprepare(tsc->adc_clk);
> +		return err;
> +	}
> +
> +	imx6ul_tsc_init(tsc);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(imx6ul_tsc_pm_ops,
> +			 imx6ul_tsc_suspend,
> +			 imx6ul_tsc_resume);
> +
> +static struct platform_driver imx6ul_tsc_driver =3D {
> +	.driver		=3D {
> +		.name	=3D "imx6ul-tsc",
> +		.owner	=3D THIS_MODULE,
> +		.of_match_table	=3D imx6ul_tsc_match,
> +		.pm	=3D &imx6ul_tsc_pm_ops,
> +	},
> +	.probe		=3D imx6ul_tsc_probe,
> +	.remove		=3D imx6ul_tsc_remove,
> +};
> +module_platform_driver(imx6ul_tsc_driver);
> +
> +MODULE_AUTHOR("Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>");
> +MODULE_DESCRIPTION("Freescale i.MX6UL Touchscreen controller driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1u6vAAoJEEpcgKtcEGQQyUQP/0xvFF4JZsP+3AeFtNAZMPCH
DR9MtAHzJIfUvRCPxdvo5iaRpANeqo/g4sndD3/BBmao/kqxWYmBjg9L15n6PcyV
hgi7jLixrupHw9A5hJFKt2yBhaexdjS1Oa35pe6jxukiddf/pMhnWmLO/TslKNFL
fVw6b9fECJlUQaVRWIXQmfEOC//CuLGVYRVgrQmMt0XKs/AUpQ/C+LwPIZRd67k0
LYx0d60KmAEnwsd0Xbt5VhLcXofe7xpl7IWNn1mq48W9zIyicB6+F0kMatgSRyts
ikDk+627PClXxn8P4OqQ9cDumLq9bzl8NM2fE6xP+g0wbUMkdT+uYAZAQtLCVzno
eOqa6Q+lVeVxQ8tWvIjGC9lnH0c7J0oOHtTYA6Gn+aS1zWSXlNhgpwIRKVZEZbHp
nhAMRnhCPbjHzVnEPicMXg49PV1TUUY7y/0j8dUzHsxttDvSw/XFHo5hWgE9kKpD
iENow2dFp/IpgdMtJaa/DWvn5rsIUOV0LflDnq4wrHQNHm0Da+0VwkBW9c3IZ+r0
1DYSu906VyeILy0c219zHZwZ7Dmf7IBS21WhELR/to77/lqRyp7n28J2fa81ZvkS
K2glb1Oy3kubOXA/cz1/HEQADDHhaSjm9XXJ4qg4SqVJalKjTalcYIFZ4ohZtGAE
S9J7kW3BLIHS9AyXcvvt
=DACF
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
