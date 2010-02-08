From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] input/misc: rotary-encoder: Set gpio direction
Date: Mon, 8 Feb 2010 23:12:06 +0100
Message-ID: <20100208221206.GP9007@buzzloop.caiaq.de>
References: <20100208210350.36f51cbf@digital-domain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:38454 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab0BHWML (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 17:12:11 -0500
Content-Disposition: inline
In-Reply-To: <20100208210350.36f51cbf@digital-domain.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Clayton <andrew@digital-domain.net>
Cc: linux-input@vger.kernel.org, Mark Somerville <mark@scottishclimbs.com>

On Mon, Feb 08, 2010 at 09:03:50PM +0000, Andrew Clayton wrote:
> While trying to get a rotary encoder working under a beagle board using 
> the drivers/input/misc/rotary-encoder.c driver, we found that even with 
> the right pin mux settings configured through /sys/kernel/debug/omap_mux/*, 
> i.e INPUT_PULLUP and MODE4, the gpio_get_value() functions only ever 
> returned 1.
> 
> By explicitly calling gpio_direction_input() after each requested gpio, 
> the driver started working and started returning correct input events.
>  
> The following is the patch that works for us. What do you think?

Yep, that looks good to me, thanks!

Acked-by: Daniel Mack <daniel@caiaq.de>

> Set the gpio direction to input for each requested gpio.
> 
> Even with the correct pin mux settings, you still need to explicitly 
> set the gpio direction. Call gpio_direction_input() after each 
> requested gpio.
> 
> Signed-off-by: Andrew Clayton <andrew@digital-domain.net>
> ---
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index 3b9f588..4ae0793 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -152,6 +152,13 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  		goto exit_unregister_input;
>  	}
>  
> +	err = gpio_direction_input(pdata->gpio_a);
> +	if (err) {
> +		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
> +			pdata->gpio_a);
> +		goto exit_unregister_input;
> +	}
> +
>  	err = gpio_request(pdata->gpio_b, DRV_NAME);
>  	if (err) {
>  		dev_err(&pdev->dev, "unable to request GPIO %d\n",
> @@ -159,6 +166,13 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  		goto exit_free_gpio_a;
>  	}
>  
> +	err = gpio_direction_input(pdata->gpio_b);
> +	if (err) {
> +		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
> +			pdata->gpio_b);
> +		goto exit_free_gpio_a;
> +	}
> +
>  	/* request the IRQs */
>  	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
>  			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
