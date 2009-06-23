From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] Input: rotary_encoder cleanup
Date: Tue, 23 Jun 2009 18:21:26 +0200
Message-ID: <20090623162126.GL29236@buzzloop.caiaq.de>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:57962 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353AbZFWQV2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 12:21:28 -0400
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

On Sat, Jun 20, 2009 at 06:15:51PM -0400, H Hartley Sweeten wrote:
> There is no need to carry the two irq numbers in the allocated memory.
> They are only needed for the free_irq() calls during the remove.  Since
> the driver is already carrying the platform_data we can just call
> gpio_to_irq() to get the irq number.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Acked-by: Daniel Mack <daniel@caiaq.de>

Thanks!


> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index c806fbf..910d2db 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -32,9 +32,6 @@ struct rotary_encoder {
>  	unsigned int axis;
>  	unsigned int pos;
>  
> -	unsigned int irq_a;
> -	unsigned int irq_b;
> -
>  	bool armed;
>  	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
>  };
> @@ -121,8 +118,6 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  
>  	encoder->input = input;
>  	encoder->pdata = pdata;
> -	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
> -	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
>  
>  	/* create and register the input driver */
>  	input->name = pdev->name;
> @@ -160,21 +155,21 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  	}
>  
>  	/* request the IRQs */
> -	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
> +	err = request_irq(gpio_to_irq(pdata->gpio_a), &rotary_encoder_irq,
>  			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
>  			  DRV_NAME, encoder);
>  	if (err) {
>  		dev_err(&pdev->dev, "unable to request IRQ %d\n",
> -			encoder->irq_a);
> +			gpio_to_irq(pdata->gpio_a));
>  		goto exit_free_gpio_b;
>  	}
>  
> -	err = request_irq(encoder->irq_b, &rotary_encoder_irq,
> +	err = request_irq(gpio_to_irq(pdata->gpio_b), &rotary_encoder_irq,
>  			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
>  			  DRV_NAME, encoder);
>  	if (err) {
>  		dev_err(&pdev->dev, "unable to request IRQ %d\n",
> -			encoder->irq_b);
> +			gpio_to_irq(pdata->gpio_b));
>  		goto exit_free_irq_a;
>  	}
>  
> @@ -183,7 +178,7 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  	return 0;
>  
>  exit_free_irq_a:
> -	free_irq(encoder->irq_a, encoder);
> +	free_irq(gpio_to_irq(pdata->gpio_a), encoder);
>  exit_free_gpio_b:
>  	gpio_free(pdata->gpio_b);
>  exit_free_gpio_a:
> @@ -202,8 +197,8 @@ static int __devexit rotary_encoder_remove(struct platform_device *pdev)
>  	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
>  	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
>  
> -	free_irq(encoder->irq_a, encoder);
> -	free_irq(encoder->irq_b, encoder);
> +	free_irq(gpio_to_irq(pdata->gpio_a), encoder);
> +	free_irq(gpio_to_irq(pdata->gpio_b), encoder);
>  	gpio_free(pdata->gpio_a);
>  	gpio_free(pdata->gpio_b);
>  	input_unregister_device(encoder->input); 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
