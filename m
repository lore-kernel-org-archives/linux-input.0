From: Ramax Lo <ramaxlo@gmail.com>
Subject: Re: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from Arnaud
	Patard.
Date: Thu, 19 Nov 2009 09:45:01 +0800
Message-ID: <901c91090911181745n43e2ede4g559b06a993cc322f@mail.gmail.com>
References: <20091118232939.201290297@fluff.org.uk>
	 <20091118232948.063635416@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20091118232948.063635416@fluff.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-arm-kernel@lists.infradead.org, Simtec Linux Team <linux@simtec.co.uk>
List-Id: linux-input@vger.kernel.org

2009/11/19 Ben Dooks <ben@simtec.co.uk>:
<snip>
> +static int __init s3c2410ts_probe(struct platform_device *pdev)
> +{
> +	struct s3c2410_ts_mach_info *info;
> +	struct device *dev = &pdev->dev;
> +	struct input_dev *input_dev;
> +	struct resource *res;
> +	int ret = -EINVAL;
> +
> +	/* Initialise input stuff */
> +	memset(&ts, 0, sizeof(struct s3c2410ts));
> +
> +	ts.dev = dev;
> +
> +	info = pdev->dev.platform_data;
> +	if (!info) {
> +		dev_err(dev, "no platform data, cannot attach\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "initialising touchscreen\n");
> +
> +	ts.clock = clk_get(dev, "adc");
> +	if (IS_ERR(ts.clock)) {
> +		dev_err(dev, "cannot get adc clock source\n");
> +		return -ENOENT;
> +	}
> +
> +	clk_enable(ts.clock);
> +	dev_dbg(dev, "got and enabled clocks\n");
> +
> +	ts.irq_tc = ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "no resource for interrupt\n");
> +		goto err_clk;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "no resource for registers\n");
> +		ret = -ENOENT;
> +		goto err_clk;
> +	}
> +
> +	ts.io = ioremap(res->start, resource_size(res));
> +	if (ts.io == NULL) {
> +		dev_err(dev, "cannot map registers\n");
> +		ret = -ENOMEM;
> +		goto err_clk;
> +	}
> +
> +	/* Configure the touchscreen external FETs on the S3C2410 */
> +	if (!platform_get_device_id(pdev)->driver_data)
> +		s3c2410_ts_connect();
> +
> +	ts.client = s3c_adc_register(pdev, s3c24xx_ts_select,
> +				     s3c24xx_ts_conversion, 1);
> +	if (IS_ERR(ts.client)) {
> +		dev_err(dev, "failed to register adc client\n");
> +		ret = PTR_ERR(ts.client);
> +		goto err_iomap;
> +	}
> +
> +	/* Initialise registers */
> +	if ((info->delay & 0xffff) > 0)
> +		writel(info->delay & 0xffff, ts.io + S3C2410_ADCDLY);
> +
> +	writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
> +
> +	input_dev = input_allocate_device();
> +	if (!input_dev) {
> +		dev_err(dev, "Unable to allocate the input device !!\n");
> +		ret = -ENOMEM;
> +		goto err_iomap;
> +	}
> +
> +	ts.input = input_dev;
> +	ts.input->evbit[0] = BIT_MASK(EV_SYN) | BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +	ts.input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +	input_set_abs_params(ts.input, ABS_X, 0, 0x3FF, 0, 0);
> +	input_set_abs_params(ts.input, ABS_Y, 0, 0x3FF, 0, 0);
> +	input_set_abs_params(ts.input, ABS_PRESSURE, 0, 1, 0, 0);
> +
> +	ts.input->name = s3c2410ts_name;
> +	ts.input->id.bustype = BUS_HOST;
> +	ts.input->id.vendor = 0xDEAD;
> +	ts.input->id.product = 0xBEEF;
> +	ts.input->id.version = S3C2410TSVERSION;
> +
> +	ts.shift = info->oversampling_shift;
> +
> +	if (request_irq(ts.irq_tc, stylus_irq, IRQF_DISABLED,
> +			"s3c2410_ts_pen", ts.input)) {
> +		dev_err(dev, "cannot get TC interrupt\n");
> +		ret = -EIO;
> +		goto err_inputdev;
> +	}
> +
> +	dev_info(dev, "driver attached, registering input device\n");
> +
> +	/* All went ok, so register to the input system */
> +	ret = input_register_device(ts.input);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register input device\n");
> +		ret = -EIO;
> +		goto err_tcirq;
> +	}
> +
> +	return 0;
> +
> + err_tcirq:
> +	free_irq(ts.irq_tc, ts.input);
> + err_inputdev:
> +	input_unregister_device(ts.input);
> + err_iomap:
> +	iounmap(ts.io);

Isn't s3c_adc_release() needed for freeing unused adc client?

> + err_clk:
> +	clk_put(ts.clock);
> +	return ret;
> +}
> +
> +/**
> + * s3c2410ts_remove - device core removal entry point
> + * @pdev: The device we are being removed from.
> + *
> + * Free up our state ready to be removed.
> + */
> +static int s3c2410ts_remove(struct platform_device *pdev)
> +{
> +	free_irq(ts.irq_tc, ts.input);
> +
> +	clk_disable(ts.clock);
> +	clk_put(ts.clock);
> +
> +	input_unregister_device(ts.input);
> +	iounmap(ts.io);

The same reason.

> +
> +	return 0;
> +}

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
