From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH 1/2] input: Add Qualcomm PM8941 power key driver
Date: Tue, 7 Oct 2014 16:30:46 -0700
Message-ID: <20141007233045.GD31125@sonymobile.com>
References: <1412644321-27683-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412644321-27683-2-git-send-email-bjorn.andersson@sonymobile.com>
 <5433B843.5060200@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5433B843.5060200@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kiran Padwal <kiran.padwal@smartplayin.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>
List-Id: linux-input@vger.kernel.org

On Tue 07 Oct 02:54 PDT 2014, Kiran Padwal wrote:

> On Tuesday 07 October 2014 06:42 AM, Bjorn Andersson wrote:
> > From: Courtney Cavin <courtney.cavin@sonymobile.com>
> > 
> > Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > ---
> >  drivers/input/misc/Kconfig         |   12 +++
> >  drivers/input/misc/Makefile        |    1 +
> >  drivers/input/misc/pm8941-pwrkey.c |  196 ++++++++++++++++++++++++++++++++++++
> 
> <snip>
> 
> > +
> > +	platform_set_drvdata(pdev, pwrkey);
> > +	device_init_wakeup(&pdev->dev, 1);
> > +
> > +	return 0;
> > +}
> > +
> > +static int pm8941_pwrkey_remove(struct platform_device *pdev)
> > +{
> > +	device_init_wakeup(&pdev->dev, 0);
> 
> Shouldn't we unregister input device?
> 

It's allocated with devm_input_allocate_device() so I assumed that it goes away
upon the device being removed. Looking at input_register_device() seems to
confirm that.

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id pm8941_pwr_key_id_table[] = {
> > +	{ .compatible = "qcom,pm8941-pwrkey" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, pm8941_pwr_key_id_table);
> > +
> > +static struct platform_driver pm8941_pwrkey_driver = {
> > +	.probe		= pm8941_pwrkey_probe,
> > +	.remove		= pm8941_pwrkey_remove,
> > +	.driver		= {
> > +		.name	= "pm8941-pwrkey",
> > +		.owner	= THIS_MODULE,
> 
> This field can be removed because this driver which use the
> module_platform_driver api as this is overridden in
> platform_driver_register.
> 

Thanks

> > +		.pm	= &pm8941_pwr_key_pm_ops,
> > +		.of_match_table = of_match_ptr(pm8941_pwr_key_id_table),
> > +	},
> > +};
> > +module_platform_driver(pm8941_pwrkey_driver);
> > +
> > +MODULE_DESCRIPTION("PM8941 Power Key driver");
> > +MODULE_LICENSE("GPL v2");
> 
> May be you can add module author name.
> 

Courtney based this driver on the skeleton from pmic8xxx-pwrkey, so I don't
think it's right to say that there's any particular author. And you have the
git log...

Regards,
Bjorn
