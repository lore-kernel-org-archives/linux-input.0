From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: wrong irq requested in edt-ft5x06.c
Date: Wed, 19 Sep 2012 09:58:15 -0700
Message-ID: <20120919165815.GB16286@core.coreip.homeip.net>
References: <1348066434-2168-1-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62111 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615Ab2ISQ6a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Sep 2012 12:58:30 -0400
Received: by pbbrr13 with SMTP id rr13so2917621pbb.19
        for <linux-input@vger.kernel.org>; Wed, 19 Sep 2012 09:58:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348066434-2168-1-git-send-email-sbabic@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefano Babic <sbabic@denx.de>
Cc: linux-input@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Guenter Roeck <linux@roeck-us.net>

Hi Stefano,

On Wed, Sep 19, 2012 at 04:53:54PM +0200, Stefano Babic wrote:
> The probe function checks for integrity the pdata->irq_pin,
> but then does not request this line for interrupt.
> For this reason, no interrupts are generated.
> 
> Tested on a AM3517 board with EP0700M06

Why is your board code does not set client->irq properly?

Thanks.

> 
> Signed-off-by: Stefano Babic <sbabic@denx.de>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> CC: Simon Budig <simon.budig@kernelconcepts.de>
> CC: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index b06a5e3..9608281 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -788,7 +788,8 @@ static int __devinit edt_ft5x06_ts_probe(struct i2c_client *client,
>  	input_set_drvdata(input, tsdata);
>  	i2c_set_clientdata(client, tsdata);
>  
> -	error = request_threaded_irq(client->irq, NULL, edt_ft5x06_ts_isr,
> +	error = request_threaded_irq(gpio_to_irq(pdata->irq_pin), NULL,
> +				     edt_ft5x06_ts_isr,
>  				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  				     client->name, tsdata);
>  	if (error) {
> -- 
> 1.7.9.5
> 

-- 
Dmitry
