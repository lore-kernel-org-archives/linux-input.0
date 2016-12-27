From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input: silead_gsl1680: gpiod_get returning -EBUSY is
 not an error
Date: Tue, 27 Dec 2016 14:14:57 -0800
Message-ID: <20161227221457.GC28140@dtor-ws>
References: <20161209103522.3833-1-hdegoede@redhat.com>
 <20161209103522.3833-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33648 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754976AbcL0WPB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Dec 2016 17:15:01 -0500
Received: by mail-pg0-f66.google.com with SMTP id g1so13577807pgn.0
        for <linux-input@vger.kernel.org>; Tue, 27 Dec 2016 14:15:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161209103522.3833-2-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

On Fri, Dec 09, 2016 at 11:35:20AM +0100, Hans de Goede wrote:
> ACPI gpios may return -EBUSY this means that the gpio is owned by the
> ACPI code, and will be set / cleared as needed by the ACPI code.
> 
> Treat gpiod_get returning -EBUSY as not having a gpio, fixing the
> driver not loading on tablets where this happens.

Hmm, I'd say ACPI should not be exposing existence of GPIO to the
drivers if it decides to manage it itself. Can we hide this in gpiolib
ACPI code?

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/touchscreen/silead.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index f502c84..4387cd8 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -467,6 +467,14 @@ static int silead_ts_probe(struct i2c_client *client,
>  
>  	/* Power GPIO pin */
>  	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
> +#ifdef CONFIG_ACPI
> +	/*
> +	 * ACPI gpios may return -EBUSY this means that the gpio is owned by
> +	 * the ACPI code, and will be set / cleared by the ACPI code.
> +	 */
> +	if (IS_ERR(data->gpio_power) && PTR_ERR(data->gpio_power) == -EBUSY)
> +		data->gpio_power = NULL;
> +#endif
>  	if (IS_ERR(data->gpio_power)) {
>  		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
>  			dev_err(dev, "Shutdown GPIO request failed\n");
> -- 
> 2.9.3
> 

Thanks.

-- 
Dmitry
