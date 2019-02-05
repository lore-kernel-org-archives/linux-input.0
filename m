From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/3] Input: add new vibrator driver for various MSM
 SOCs
Date: Tue, 5 Feb 2019 11:42:46 -0800
Message-ID: <20190205194246.GA19151@dtor-ws>
References: <20181025012937.2154-1-masneyb@onstation.org>
 <20181025012937.2154-3-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181025012937.2154-3-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Masney <masneyb@onstation.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, jonathan@marek.ca
List-Id: linux-input@vger.kernel.org

Hi Brian,

On Wed, Oct 24, 2018 at 09:29:36PM -0400, Brian Masney wrote:
> This patch adds a new vibrator driver that supports various Qualcomm
> MSM SOCs. Driver was tested on a LG Nexus 5 (hammerhead) phone.
> 

...

> +
> +#define msm_vibrator_write(msm_vibrator, offset, value) \
> +	writel((value), (void __iomem *)((msm_vibrator)->base + (offset)))

Make in a function? It will be inlined anyways...

> +
> +	vibrator->vcc = devm_regulator_get(&pdev->dev, "vcc");
> +	if (IS_ERR(vibrator->vcc)) {
> +		if (PTR_ERR(vibrator->vcc) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get regulator: %ld\n",
> +				PTR_ERR(vibrator->vcc));
> +		return PTR_ERR(vibrator->vcc);
> +	}
> +
> +	vibrator->enable_gpio = devm_gpiod_get(&pdev->dev, "enable",
> +					       GPIOD_OUT_LOW);
> +	if (IS_ERR(vibrator->enable_gpio)) {

You have explicit deferral handling for the regulator, but not gpio. I'd
prefer if we did (or not) it consistently.

> +		dev_err(&pdev->dev, "Failed to get enable gpio: %ld\n",
> +			PTR_ERR(vibrator->enable_gpio));
> +		return PTR_ERR(vibrator->enable_gpio);
> +	}
> +
> +	vibrator->clk = devm_clk_get(&pdev->dev, "pwm");
> +	if (IS_ERR(vibrator->clk)) {

Same here.

> +		dev_err(&pdev->dev, "Failed to lookup pwm clock: %ld\n",
> +			PTR_ERR(vibrator->clk));
> +		return PTR_ERR(vibrator->clk);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get platform resource\n");
> +		return -ENODEV;
> +	}
> +
> +	vibrator->base = devm_ioremap(&pdev->dev, res->start,
> +				     resource_size(res));
> +	if (IS_ERR(vibrator->base)) {

devm_ioremap() returns NULL on error. You either need to check for NULL
or see of you can use devm_ioremap_resource().

> +		dev_err(&pdev->dev, "Failed to iomap resource: %ld\n",
> +			PTR_ERR(vibrator->base));
> +		return PTR_ERR(vibrator->base);
> +	}
> +
> +	vibrator->enabled = false;
> +	mutex_init(&vibrator->mutex);
> +	INIT_WORK(&vibrator->worker, msm_vibrator_worker);
> +
> +	vibrator->input->name = "msm-vibrator";
> +	vibrator->input->id.bustype = BUS_HOST;
> +	vibrator->input->dev.parent = &pdev->dev;

You allocated input device with devm so there is no need to set parent
by hand.

> +	vibrator->input->close = msm_vibrator_close;
> +
> +	input_set_drvdata(vibrator->input, vibrator);
> +	input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
> +
> +	ret = input_ff_create_memless(vibrator->input, NULL,
> +				      msm_vibrator_play_effect);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to create ff memless: %d", ret);
> +		return ret;
> +	}
> +
> +	ret = input_register_device(vibrator->input);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register input device: %d", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, vibrator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused msm_vibrator_suspend(struct device *dev)
> +{
> +	struct msm_vibrator *vibrator = dev_get_drvdata(dev);

Prefer explicit platform_get_drvdata() since we are working with
platform device (even though it resolves to the same thing).

> +
> +	cancel_work_sync(&vibrator->worker);
> +
> +	if (vibrator->enabled)
> +		msm_vibrator_stop(vibrator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused msm_vibrator_resume(struct device *dev)
> +{
> +	struct msm_vibrator *vibrator = dev_get_drvdata(dev);

Same here.

Thanks.

-- 
Dmitry
