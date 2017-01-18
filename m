From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 19/33] Input: tps65218-pwrbutton - Drop unnecessary call
 to platform_set_drvdata and other changes
Date: Wed, 18 Jan 2017 11:44:11 -0800
Message-ID: <20170118194411.GK33920@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-20-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35617 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdARToO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 14:44:14 -0500
Content-Disposition: inline
In-Reply-To: <1484761614-12225-20-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>, Marcin Niestroj <m.niestroj@grinn-global.com>

On Wed, Jan 18, 2017 at 09:46:40AM -0800, Guenter Roeck wrote:
> There is no call to platform_get_drvdata() or dev_get_drvdata().
> Drop the unnecessary call to platform_set_drvdata().
> Other relevant changes:
>   Use existing variable 'dev' instead of dereferencing it several times
> 
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Drop platform_set_drvdata()
> - Use local variable 'struct device *dev' consistently
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/input/misc/tps65218-pwrbutton.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
> index cc74a41bdb0d..33f48a622fc6 100644
> --- a/drivers/input/misc/tps65218-pwrbutton.c
> +++ b/drivers/input/misc/tps65218-pwrbutton.c
> @@ -70,7 +70,7 @@ static irqreturn_t tps6521x_pb_irq(int irq, void *_pwr)
>  	error = regmap_read(pwr->regmap, tps_data->reg_status, &reg);
>  	if (error) {
>  		dev_err(pwr->dev, "can't read register: %d\n", error);
> -		goto out;
> +		return IRQ_HANDLED;
>  	}
>  
>  	if (reg & tps_data->pb_mask) {
> @@ -82,7 +82,6 @@ static irqreturn_t tps6521x_pb_irq(int irq, void *_pwr)
>  
>  	input_sync(pwr->idev);
>  
> -out:
>  	return IRQ_HANDLED;
>  }

Applied except for the above chunks, thank you.

>  
> @@ -95,7 +94,7 @@ static int tps6521x_pb_probe(struct platform_device *pdev)
>  	int error;
>  	int irq;
>  
> -	match = of_match_node(of_tps6521x_pb_match, pdev->dev.of_node);
> +	match = of_match_node(of_tps6521x_pb_match, dev->of_node);
>  	if (!match)
>  		return -ENXIO;
>  
> @@ -118,10 +117,9 @@ static int tps6521x_pb_probe(struct platform_device *pdev)
>  
>  	input_set_capability(idev, EV_KEY, KEY_POWER);
>  
> -	pwr->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	pwr->regmap = dev_get_regmap(dev->parent, NULL);
>  	pwr->dev = dev;
>  	pwr->idev = idev;
> -	platform_set_drvdata(pdev, pwr);
>  	device_init_wakeup(dev, true);
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -136,8 +134,7 @@ static int tps6521x_pb_probe(struct platform_device *pdev)
>  						IRQF_ONESHOT,
>  					  pwr->data->name, pwr);
>  	if (error) {
> -		dev_err(dev, "failed to request IRQ #%d: %d\n",
> -			irq, error);
> +		dev_err(dev, "failed to request IRQ #%d: %d\n", irq, error);
>  		return error;
>  	}
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
