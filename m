From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH V3] Input: pm8941-pwrkey: add resin key capabilities
Date: Fri, 23 Mar 2018 12:14:22 -0700
Message-ID: <240c6cbc-886f-94c6-cba4-3c4eb3ed0b45@codeaurora.org>
References: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tirupathi Reddy <tirupath@codeaurora.org>, dmitry.torokhov@gmail.com, bjorn.andersson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Tirupathi,

>   
> +static irqreturn_t pm8941_resinkey_irq(int irq, void *_data)
> +{
> +	struct pm8941_pwrkey *pwrkey = _data;
> +	unsigned int sts;
> +	int error;
> +	u32 key_code = pwrkey->resin_key_code;
> +
> +	error = regmap_read(pwrkey->regmap,
> +			    pwrkey->baseaddr + PON_RT_STS, &sts);
> +	if (error)
> +		return IRQ_HANDLED;
> +
> +	input_report_key(pwrkey->input, key_code, !!(sts & PON_RESIN_N_SET));
> +	input_sync(pwrkey->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static int __maybe_unused pm8941_pwrkey_suspend(struct device *dev)
>   {
>   	struct pm8941_pwrkey *pwrkey = dev_get_drvdata(dev);
> @@ -153,9 +175,56 @@ static int __maybe_unused pm8941_pwrkey_resume(struct device *dev)
>   static SIMPLE_DEV_PM_OPS(pm8941_pwr_key_pm_ops,
>   			 pm8941_pwrkey_suspend, pm8941_pwrkey_resume);
>   
> +static int pm8941_resin_key_init(struct pm8941_pwrkey *pwrkey,
> +			struct device_node *np)
> +{
> +	int error, irq;
> +	bool pull_up;
> +
> +	/*
> +	 * Get the standard-key parameters. This might not be
> +	 * specified if there is no key mapping on the reset line.
> +	 */
> +	error = of_property_read_u32(np, "linux,code", &pwrkey->resin_key_code);
> +	if (error) {
> +		dev_err(pwrkey->dev, "failed to read key-code for resin key\n");
> +		return error;
> +	}
> +
> +	pull_up = of_property_read_bool(np, "bias-pull-up");
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (irq < 0) {
> +		dev_err(pwrkey->dev, "failed to get resin irq\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Register key configuration */
> +	input_set_capability(pwrkey->input, EV_KEY, pwrkey->resin_key_code);
> +
> +	error = regmap_update_bits(pwrkey->regmap,
> +				   pwrkey->baseaddr + PON_PULL_CTL,
> +				   PON_RESIN_PULL_UP,
> +				   pull_up ? PON_RESIN_PULL_UP : 0);
> +	if (error) {
> +		dev_err(pwrkey->dev, "failed to set resin pull: %d\n", error);
> +		return error;
> +	}
> +
> +	error = devm_request_threaded_irq(pwrkey->dev, irq, NULL,
> +					  pm8941_resinkey_irq, IRQF_ONESHOT,
> +					  "pm8941_resinkey", pwrkey);
> +	if (error)
> +		dev_err(pwrkey->dev, "failed requesting resin key IRQ: %d\n",
> +			error);
> +
> +	return error;
> +}
> +
>   static int pm8941_pwrkey_probe(struct platform_device *pdev)
>   {
>   	struct pm8941_pwrkey *pwrkey;
> +	struct device_node *np = NULL;
>   	bool pull_up;
>   	u32 req_delay;
>   	int error;
> @@ -241,6 +310,18 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>   		return error;
>   	}
>   
> +	np = of_find_node_by_name(pdev->dev.of_node, "resin");
> +	if (np) {
> +		/* resin key capabilities are defined in device node */
> +		error = pm8941_resin_key_init(pwrkey, np);


What happens if interrupts comes as soon as you have done the 
key_init(..) here? I see that you are registering the input device after 
it, right? Looks like you should do this at the end of probe?

> +		of_node_put(np);
> +		if (error) {
> +			dev_err(&pdev->dev, "failed resin key initialization: %d\n",
> +				error);
> +			return error;
> +		}
> +	}
> +
>   	error = input_register_device(pwrkey->input);
>   	if (error) {
>   		dev_err(&pdev->dev, "failed to register input device: %d\n",
> 

-- 
---Trilok Soni
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
