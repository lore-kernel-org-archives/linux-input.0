From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: move gpio mouse to managed api
Date: Fri, 19 May 2017 13:28:06 -0700
Message-ID: <20170519202806.GB19281@dtor-ws>
References: <20170519153502.28570-1-vlerickb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35372 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755979AbdESU2J (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 16:28:09 -0400
Content-Disposition: inline
In-Reply-To: <20170519153502.28570-1-vlerickb@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bram Vlerick <vlerickb@gmail.com>
Cc: michael.opdenacker@free-electrons.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bram,

On Fri, May 19, 2017 at 05:35:02PM +0200, Bram Vlerick wrote:
> Signed-off-by: Bram Vlerick <vlerickb@gmail.com>
> ---
>  drivers/input/mouse/gpio_mouse.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
> index ced07391304b..7d56fd5173bc 100644
> --- a/drivers/input/mouse/gpio_mouse.c
> +++ b/drivers/input/mouse/gpio_mouse.c
> @@ -93,7 +93,7 @@ static int gpio_mouse_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	input_poll = input_allocate_polled_device();
> +	input_poll = devm_input_allocate_polled_device(&pdev->dev);
>  	if (!input_poll) {
>  		dev_err(&pdev->dev, "not enough memory for input device\n");
>  		error = -ENOMEM;
> @@ -124,7 +124,7 @@ static int gpio_mouse_probe(struct platform_device *pdev)
>  	error = input_register_polled_device(input_poll);
>  	if (error) {
>  		dev_err(&pdev->dev, "could not register input device\n");
> -		goto out_free_polldev;
> +		goto out_free_gpios;
>  	}
>  
>  	dev_dbg(&pdev->dev, "%d ms scan time, buttons: %s%s%s\n",
> @@ -135,9 +135,6 @@ static int gpio_mouse_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> - out_free_polldev:
> -	input_free_polled_device(input_poll);
> -
>   out_free_gpios:
>  	while (--i >= 0) {
>  		pin = pdata->pins[i];
> @@ -154,9 +151,6 @@ static int gpio_mouse_remove(struct platform_device *pdev)
>  	struct gpio_mouse_platform_data *pdata = input->private;
>  	int pin, i;
>  
> -	input_unregister_polled_device(input);
> -	input_free_polled_device(input);
> -

This is wrong, as you now letting input device be active while gpios
are free.

Frankly, I wonder if we could not retire this driver by making gpio-keys
be more flexible... I think we discussed options to allow mode where
gpio-keys-polled "sums" the gpios for the same axis and report the
value.

>  	for (i = 0; i < GPIO_MOUSE_PIN_MAX; i++) {
>  		pin = pdata->pins[i];
>  		if (pin >= 0)
> -- 
> 2.12.2
> 

Thanks.

-- 
Dmitry
