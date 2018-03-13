From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH V2] Input: pm8941-pwrkey: add resin key capabilities
Date: Tue, 13 Mar 2018 12:24:14 -0700
Message-ID: <dff22ba9-2b83-9861-e7f2-700a10fdbcdf@codeaurora.org>
References: <1520930158-5854-1-git-send-email-tirupath@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520930158-5854-1-git-send-email-tirupath@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tirupathi Reddy <tirupath@codeaurora.org>, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Tirupathi,

On 3/13/2018 1:35 AM, Tirupathi Reddy wrote:
> Add resin key support to handle different types of key events
> defined in different platforms.

Describe "resin"  in the commit text? or just call it same as power key 
or different purpose?

>   
> +static irqreturn_t pm8941_resinkey_irq(int irq, void *_data)
> +{
> +	struct pm8941_pwrkey *pwrkey = _data;
> +	unsigned int sts;
> +	int error;
> +
> +	error = regmap_read(pwrkey->regmap,
> +			    pwrkey->baseaddr + PON_RT_STS, &sts);
> +	if (error)
> +		return IRQ_HANDLED;

You may want to document here why you still return as IRQ_HANDLED on the 
error after reading the status register?

>   
> +	resin_irq = platform_get_irq_byname(pdev, "resin");
> +	if (resin_irq < 0 && resin_irq != -ENXIO) {
> +		if (resin_irq != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get resin irq\n");
> +		return resin_irq;
> +	} else if (resin_irq >= 0) {
> +		/* resin key capabilities are defined in device node */
> +		error = pm8941_resin_key_init(pwrkey, resin_irq);
> +		if (error) {
> +			dev_err(&pdev->dev, "failed resin key initialization: %d\n",
> +				error);
> +			return error;
> +		}
> +	}
> +

Any reason you don't want to create different driver for "resin" key? Is 
this going to be physically different key on the platform? Please 
describe why it needs to be part of the power key driver.

---Trilok Soni

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
