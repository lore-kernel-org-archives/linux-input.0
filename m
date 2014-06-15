From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
Date: Sun, 15 Jun 2014 00:27:40 -0700
Message-ID: <20140615072740.GA23950@core.coreip.homeip.net>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1402672899-6995-1-git-send-email-denis@eukrea.com>
 <1402672899-6995-3-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402672899-6995-3-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Denis,

On Fri, Jun 13, 2014 at 05:21:35PM +0200, Denis Carikli wrote:
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

I still do not understand this calculation. input_report_key()
converts the last argument to a boolean, so the only time it would
report BTN_TOUCH UP here if (touch_pre + touch_post) / 2 is exactly
0xfff. Given that default threshold is 500 this won't ever happen.

Why isn't it simply:

			input_report_key(priv->idev, BTN_TOUCH, 1);

?

...

> +
> +static irqreturn_t mx25_tcq_irq_thread(int irq, void *dev_id)
> +{
> +	struct mx25_tcq_priv *priv = (struct mx25_tcq_priv *) dev_id;

No need to cast.

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

Same here.

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

You are leaving clock enabled here.

> +		return ret;
> +	}
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
> +MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5
> 

Thanks.

-- 
Dmitry
