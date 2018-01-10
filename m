From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix - disable IRQs while suspended
Date: Wed, 10 Jan 2018 15:14:58 +0100
Message-ID: <1515593698.2523.56.camel@hadess.net>
References: <20180110113456.3091-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49675 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeAJOPB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 Jan 2018 09:15:01 -0500
In-Reply-To: <20180110113456.3091-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

On Wed, 2018-01-10 at 12:34 +0100, Hans de Goede wrote:
> We should not try to do any i2c transfers before the controller is
> resumed (which happens before our resume method gets called).
> 
> So we need to disable our IRQ while suspended to enforce this. The
> code paths for devices with GPIOs for the int and reset pins already
> disable the IRQ the through goodix_free_irq().
> 
> This commit also disables the IRQ while suspended for devices without
> GPIOs for the int and reset pins.

Do disable_irq() and enable_irq() require to be paired, and if so, are
goodix_suspend() and goodix_resume() guaranteed to be paired?

Other than that, looks good to me. Please add the name of the device(s)
you tested this on in the changelog and add your tested-by, to show
it's not a "compile-only check" kind of commit.

Cheers

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/touchscreen/goodix.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c
> b/drivers/input/touchscreen/goodix.c
> index 69d0b8cbc71f..ecec8eb17f28 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -878,8 +878,10 @@ static int __maybe_unused goodix_suspend(struct
> device *dev)
>  	int error;
>  
>  	/* We need gpio pins to suspend/resume */
> -	if (!ts->gpiod_int || !ts->gpiod_rst)
> +	if (!ts->gpiod_int || !ts->gpiod_rst) {
> +		disable_irq(client->irq);
>  		return 0;
> +	}
>  
>  	wait_for_completion(&ts->firmware_loading_complete);
>  
> @@ -919,8 +921,10 @@ static int __maybe_unused goodix_resume(struct
> device *dev)
>  	struct goodix_ts_data *ts = i2c_get_clientdata(client);
>  	int error;
>  
> -	if (!ts->gpiod_int || !ts->gpiod_rst)
> +	if (!ts->gpiod_int || !ts->gpiod_rst) {
> +		enable_irq(client->irq);
>  		return 0;
> +	}
>  
>  	/*
>  	 * Exit sleep mode by outputting HIGH level to INT pin
