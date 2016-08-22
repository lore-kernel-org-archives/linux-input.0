From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input: touchscreen: silead: Use devm_gpiod_get
Date: Mon, 22 Aug 2016 14:12:00 -0700
Message-ID: <20160822211200.GD12277@dtor-ws>
References: <1471384043-11717-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471384043-11717-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 16, 2016 at 11:47:23PM +0200, Hans de Goede wrote:
> The silead code is using devm_foo for everything (and does not free
> any resources). Except that it is using gpiod_get instead of
> devm_gpiod_get (but is not freeing the gpio_desc), change this
> to use devm_gpiod_get so that the gpio will be properly released.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/silead.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index 04992c5..3b80f14 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -497,7 +497,7 @@ static int silead_ts_probe(struct i2c_client *client,
>  	}
>  
>  	/* Power GPIO pin */
> -	data->gpio_power = gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
> +	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
>  	if (IS_ERR(data->gpio_power)) {
>  		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
>  			dev_err(dev, "Shutdown GPIO request failed\n");
> -- 
> 2.7.4
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
