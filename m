From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH] Input: ep93xx_keypad - switch to using dev_pm_ops
Date: Tue, 10 Apr 2012 11:34:52 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206986C017C@AUSP01VMBX24.collaborationhost.net>
References: <20120410080134.GA19114@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail209.messagelabs.com ([216.82.255.3]:19437 "EHLO
	mail209.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab2DJQe5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Apr 2012 12:34:57 -0400
In-Reply-To: <20120410080134.GA19114@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tuesday, April 10, 2012 1:02 AM, Dmitry Torokhov wrote:
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/input/keyboard/ep93xx_keypad.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index 0ba69f3..d6cd634 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -182,16 +182,16 @@ static void ep93xx_keypad_close(struct input_dev *pdev)
>  }
>  
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  /*
>   * NOTE: I don't know if this is correct, or will work on the ep93xx.
>   *
>   * None of the existing ep93xx drivers have power management support.
>   * But, this is basically what the pxa27x_keypad driver does.
>   */

Dmitry,

The comment above can probably be removed also.

> -static int ep93xx_keypad_suspend(struct platform_device *pdev,
> -				 pm_message_t state)
> +static int ep93xx_keypad_suspend(struct device *dev)
>  {
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
>  	struct input_dev *input_dev = keypad->input_dev;
>  
> @@ -210,8 +210,9 @@ static int ep93xx_keypad_suspend(struct platform_device *pdev,
>  	return 0;
>  }
>  
> -static int ep93xx_keypad_resume(struct platform_device *pdev)
> +static int ep93xx_keypad_resume(struct device *dev)
>  {
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
>  	struct input_dev *input_dev = keypad->input_dev;
>  
> @@ -232,10 +233,10 @@ static int ep93xx_keypad_resume(struct platform_device *pdev)
>  
>  	return 0;
>  }
> -#else	/* !CONFIG_PM */
> -#define ep93xx_keypad_suspend	NULL
> -#define ep93xx_keypad_resume	NULL
> -#endif	/* !CONFIG_PM */
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(ep93xx_keypad_pm_ops,
> +			 ep93xx_keypad_suspend, ep93xx_keypad_resume);
>  
>  static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
>  {
> @@ -384,11 +385,10 @@ static struct platform_driver ep93xx_keypad_driver = {
>  	.driver		= {
>  		.name	= "ep93xx-keypad",
>  		.owner	= THIS_MODULE,
> +		.pm	= &ep93xx_keypad_pm_ops,
>  	},
>  	.probe		= ep93xx_keypad_probe,
>  	.remove		= __devexit_p(ep93xx_keypad_remove),
> -	.suspend	= ep93xx_keypad_suspend,
> -	.resume		= ep93xx_keypad_resume,
>  };
>  module_platform_driver(ep93xx_keypad_driver);

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

