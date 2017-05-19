From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Subject: Re: [PATCH] input: move gpio mouse to managed api
Date: Fri, 19 May 2017 17:43:38 +0200
Message-ID: <9c817d33-b430-a0fb-a439-d88c6b532a25@free-electrons.com>
References: <20170519153502.28570-1-vlerickb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54574 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753200AbdESPnl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 11:43:41 -0400
In-Reply-To: <20170519153502.28570-1-vlerickb@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bram Vlerick <vlerickb@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 19/05/2017 17:35, Bram Vlerick wrote:
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
>  	for (i = 0; i < GPIO_MOUSE_PIN_MAX; i++) {
>  		pin = pdata->pins[i];
>  		if (pin >= 0)

Reviewed-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

-- 
Michael Opdenacker, CEO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

