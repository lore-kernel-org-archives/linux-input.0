From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx_keypad: Provide PM support
Date: Tue, 23 Aug 2011 23:53:53 -0700
Message-ID: <20110824065353.GD15604@core.coreip.homeip.net>
References: <1313769364-27249-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55549 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab1HXGx7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Aug 2011 02:53:59 -0400
Received: by gya6 with SMTP id 6so660698gya.19
        for <linux-input@vger.kernel.org>; Tue, 23 Aug 2011 23:53:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313769364-27249-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@freescale.com>

Hi Fabio,

On Fri, Aug 19, 2011 at 12:56:04PM -0300, Fabio Estevam wrote:
> Provide PM support to imx_keypad and allow the keypad to be used as a wakeup source.
> 
> Tested on a mx27_3ds, which wakes up via keypad press.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> 
> If I put disable_irq_wake(keypad->irq) inside imx_keypad_resume
> like other keyboard drivers do I get the following:
> 
> mx27# echo mem > /sys/power/state                                               
> PM: Syncing filesystems ... done.                                               
> Freezing user space processes ... (elapsed 0.01 seconds) done.                  
> Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.             
> Suspending console(s) (use no_console_suspend to debug)                         
> PM: suspend of devices complete after 0.692 msecs                               
> PM: late suspend of devices complete after 0.418 msecs                          
> PM: early resume of devices complete after 0.179 msecs                          
> ------------[ cut here ]------------                                            
> WARNING: at kernel/irq/manage.c:510 irq_set_irq_wake+0xdc/0xec()                
> Unbalanced IRQ 21 wake disable

You need to figure out who else messes up with wakeup count on that IRQ.
The calls to enable_irq_wake() and disable_irq_wake() should be
balanced.

>  
> +#ifdef CONFIG_PM

Make it CONFIG_PM_SLEEP - we don't do runtime PM here.

> +static int imx_keypad_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct imx_keypad *keypad = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		enable_irq_wake(keypad->irq);
> +
> +	return 0;
> +}
> +
> +static int imx_keypad_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops imx_keypad_pm_ops = {
> +	.suspend	= imx_keypad_suspend,
> +	.resume		= imx_keypad_resume,
> +};
> +#endif

Just say

static SIMPLE_DEV_PM_OPS(imx_keypad_pm_ops,
			 imx_keypad_suspend, imx_keypad_resume);

And you won't need ifdefing assignment to pm below.

>  static int __devinit imx_keypad_probe(struct platform_device *pdev)
>  {
>  	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
> @@ -571,6 +593,9 @@ static struct platform_driver imx_keypad_driver = {
>  	.driver		= {
>  		.name	= "imx-keypad",
>  		.owner	= THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.pm	= &imx_keypad_pm_ops,
> +#endif
>  	},
>  	.probe		= imx_keypad_probe,
>  	.remove		= __devexit_p(imx_keypad_remove),
> -- 
> 1.6.0.4
> 

Thanks.

-- 
Dmitry
