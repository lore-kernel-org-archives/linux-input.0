From: Bram Vlerick <vlerickb@gmail.com>
Subject: Re: [PATCH] input: move gpio mouse to managed api
Date: Sun, 21 May 2017 09:30:20 +0200
Message-ID: <1495351820.30420.1.camel@gmail.com>
References: <20170520131325.21049-1-vlerickb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33312 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdEUHac (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 May 2017 03:30:32 -0400
In-Reply-To: <20170520131325.21049-1-vlerickb@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

I've updated the patch with your comments, unregistering first before
freeing the gpios.

In regards of your comment for the gpio-keys-polled update, I've just
started with kernel dev and thought moving old drivers to the new
managed api was a good start.
So I don't really know how to start that. However I'm willing to look
at it if you could give some pointers where to start/how to tacle this.

Regards
Bram

On Sat, 2017-05-20 at 15:13 +0200, Bram Vlerick wrote:
> Signed-off-by: Bram Vlerick <vlerickb@gmail.com>
> ---
>  drivers/input/mouse/gpio_mouse.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/mouse/gpio_mouse.c
> b/drivers/input/mouse/gpio_mouse.c
> index ced07391304b..2fc8ddaf0175 100644
> --- a/drivers/input/mouse/gpio_mouse.c
> +++ b/drivers/input/mouse/gpio_mouse.c
> @@ -93,7 +93,7 @@ static int gpio_mouse_probe(struct platform_device
> *pdev)
>  		}
>  	}
>  
> -	input_poll = input_allocate_polled_device();
> +	input_poll = devm_input_allocate_polled_device(&pdev->dev);
>  	if (!input_poll) {
>  		dev_err(&pdev->dev, "not enough memory for input
> device\n");
>  		error = -ENOMEM;
> @@ -124,7 +124,7 @@ static int gpio_mouse_probe(struct
> platform_device *pdev)
>  	error = input_register_polled_device(input_poll);
>  	if (error) {
>  		dev_err(&pdev->dev, "could not register input
> device\n");
> -		goto out_free_polldev;
> +		goto out_free_gpios;
>  	}
>  
>  	dev_dbg(&pdev->dev, "%d ms scan time, buttons: %s%s%s\n",
> @@ -135,9 +135,6 @@ static int gpio_mouse_probe(struct
> platform_device *pdev)
>  
>  	return 0;
>  
> - out_free_polldev:
> -	input_free_polled_device(input_poll);
> -
>   out_free_gpios:
>  	while (--i >= 0) {
>  		pin = pdata->pins[i];
> @@ -155,7 +152,6 @@ static int gpio_mouse_remove(struct
> platform_device *pdev)
>  	int pin, i;
>  
>  	input_unregister_polled_device(input);
> -	input_free_polled_device(input);
>  
>  	for (i = 0; i < GPIO_MOUSE_PIN_MAX; i++) {
>  		pin = pdata->pins[i];
