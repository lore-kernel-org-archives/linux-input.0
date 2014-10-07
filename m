From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: Re: [PATCH 1/2] input: Add Qualcomm PM8941 power key driver
Date: Tue, 07 Oct 2014 15:24:11 +0530
Message-ID: <5433B843.5060200@smartplayin.com>
References: <1412644321-27683-1-git-send-email-bjorn.andersson@sonymobile.com> <1412644321-27683-2-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1412644321-27683-2-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, Courtney Cavin <courtney.cavin@sonymobile.com>
List-Id: linux-input@vger.kernel.org

On Tuesday 07 October 2014 06:42 AM, Bjorn Andersson wrote:
> From: Courtney Cavin <courtney.cavin@sonymobile.com>
> 
> Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>  drivers/input/misc/Kconfig         |   12 +++
>  drivers/input/misc/Makefile        |    1 +
>  drivers/input/misc/pm8941-pwrkey.c |  196 ++++++++++++++++++++++++++++++++++++

<snip>

> +
> +	platform_set_drvdata(pdev, pwrkey);
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	return 0;
> +}
> +
> +static int pm8941_pwrkey_remove(struct platform_device *pdev)
> +{
> +	device_init_wakeup(&pdev->dev, 0);

Shouldn't we unregister input device?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pm8941_pwr_key_id_table[] = {
> +	{ .compatible = "qcom,pm8941-pwrkey" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pm8941_pwr_key_id_table);
> +
> +static struct platform_driver pm8941_pwrkey_driver = {
> +	.probe		= pm8941_pwrkey_probe,
> +	.remove		= pm8941_pwrkey_remove,
> +	.driver		= {
> +		.name	= "pm8941-pwrkey",
> +		.owner	= THIS_MODULE,

This field can be removed because this driver which use the
module_platform_driver api as this is overridden in
platform_driver_register.

> +		.pm	= &pm8941_pwr_key_pm_ops,
> +		.of_match_table = of_match_ptr(pm8941_pwr_key_id_table),
> +	},
> +};
> +module_platform_driver(pm8941_pwrkey_driver);
> +
> +MODULE_DESCRIPTION("PM8941 Power Key driver");
> +MODULE_LICENSE("GPL v2");

May be you can add module author name.

Thanks,
--Kiran
