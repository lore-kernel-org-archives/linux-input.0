From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] misc: max8925_onkey: add function to work as wakeup
 source
Date: Thu, 22 Dec 2011 09:43:39 -0800
Message-ID: <20111222174338.GA21103@core.coreip.homeip.net>
References: <1324544151-2040-1-git-send-email-haojian.zhuang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36087 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab1LVRnt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Dec 2011 12:43:49 -0500
Received: by ggdk6 with SMTP id k6so6395398ggd.19
        for <linux-input@vger.kernel.org>; Thu, 22 Dec 2011 09:43:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1324544151-2040-1-git-send-email-haojian.zhuang@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Liu <kliu5@marvell.com>

Hi Haojian,

On Thu, Dec 22, 2011 at 04:55:51PM +0800, Haojian Zhuang wrote:
> From: Kevin Liu <kliu5@marvell.com>
> 
> Signed-off-by: Kevin Liu <kliu5@marvell.com>

Since I am getting the patch from you you need to add your own
"Signed-off-by: ..." as well.

> ---
>  drivers/input/misc/max8925_onkey.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc/max8925_onkey.c
> index 7de0ded..ce07ae2 100644
> --- a/drivers/input/misc/max8925_onkey.c
> +++ b/drivers/input/misc/max8925_onkey.c
> @@ -122,6 +122,7 @@ static int __devinit max8925_onkey_probe(struct platform_device *pdev)
>  	info->idev->evbit[0] = BIT_MASK(EV_KEY);
>  	info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
>  
> +	device_init_wakeup(&pdev->dev, 1);
>  
>  	error = input_register_device(info->idev);
>  	if (error) {
> @@ -158,10 +159,44 @@ static int __devexit max8925_onkey_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM

#ifdef CONFIG_PM_SLEEP is better choice here.

> +static int max8925_onkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
> +
> +	if (device_may_wakeup(dev)) {
> +		chip->wakeup_flag |= 1 << (onkey_irq[0] - chip->irq_base);
> +		chip->wakeup_flag |= 1 << (onkey_irq[1] - chip->irq_base);

You don't need to actually communicate this to the device?

> +	}
> +	return 0;
> +}
> +
> +static int max8925_onkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
> +
> +	if (device_may_wakeup(dev)) {
> +		chip->wakeup_flag &= ~(1 << (onkey_irq[0] - chip->irq_base));
> +		chip->wakeup_flag &= ~(1 << (onkey_irq[1] - chip->irq_base));
> +	}
> +	return 0;
> +}
> +
> +static struct dev_pm_ops max8925_onkey_pm_ops = {
> +	.suspend        = max8925_onkey_suspend,
> +	.resume         = max8925_onkey_resume,
> +}
> +#endif
> +
>  static struct platform_driver max8925_onkey_driver = {
>  	.driver		= {
>  		.name	= "max8925-onkey",
>  		.owner	= THIS_MODULE,
> +#ifdef CONFIG_PM

CONFIG_PM_SLEEP here as well.

> +		.pm	= &max8925_onkey_pm_ops,
> +#endif
>  	},
>  	.probe		= max8925_onkey_probe,
>  	.remove		= __devexit_p(max8925_onkey_remove),
> -- 
> 1.7.0.4
> 
> 

Thanks.

-- 
Dmitry
