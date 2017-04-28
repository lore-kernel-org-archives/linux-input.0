From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: twl4030-pwrbutton: use correct device for irq
 request
Date: Fri, 28 Apr 2017 10:27:50 -0700
Message-ID: <20170428172750.GD4949@dtor-ws>
References: <20170428122855.3185-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33674 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937613AbdD1R1x (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 13:27:53 -0400
Content-Disposition: inline
In-Reply-To: <20170428122855.3185-1-sebastian.reichel@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 28, 2017 at 02:28:54PM +0200, Sebastian Reichel wrote:
> The interrupt should be requested for the platform device
> and not for the input device.
> 
> Fixes: 7f9ce649d267 ("Input: twl4030-pwrbutton - simplify driver using devm_*")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Applied, thank you.

> ---
>  drivers/input/misc/twl4030-pwrbutton.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> index 54162d2cbcfc..7c4504c31b07 100644
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -70,7 +70,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
>  	pwr->phys = "twl4030_pwrbutton/input0";
>  	pwr->dev.parent = &pdev->dev;
>  
> -	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
> +	err = devm_request_threaded_irq(&pdev->dev, irq, NULL, powerbutton_irq,
>  			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
>  			IRQF_ONESHOT,
>  			"twl4030_pwrbutton", pwr);
> -- 
> 2.11.0
> 

-- 
Dmitry
