From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] input: touchscreen: ar1021_i2c: add support for
 AR1020
Date: Wed, 12 Apr 2017 08:40:54 -0700
Message-ID: <20170412154054.GB6297@dtor-ws>
References: <1491906479-17639-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491906479-17639-1-git-send-email-martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
Cc: christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Martin,

On Tue, Apr 11, 2017 at 12:27:57PM +0200, Martin Kepplinger wrote:
> ar1021_i2c simply also supports the ar1020 device we use. This is tested.
> They also share the same datasheet:
> 
>    http://ww1.microchip.com/downloads/en/DeviceDoc/40001393C.pdf
> 
> We differentiate not only to make it obvious that we support both devices,
> but also to be able to implement the few model specific things in the
> future.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
> ---
>  drivers/input/touchscreen/Kconfig      |  4 ++--
>  drivers/input/touchscreen/ar1021_i2c.c | 13 ++++++++++---
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 33c62e5..535b91a 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -96,8 +96,8 @@ config TOUCHSCREEN_AR1021_I2C
>  	tristate "Microchip AR1021 i2c touchscreen"
>  	depends on I2C && OF
>  	help
> -	  Say Y here if you have the Microchip AR1021 touchscreen controller
> -	  chip in your system.
> +	  Say Y here if you have the Microchip AR1020 or AR1021 touchscreen
> +	  controller chip in your system.
>  
>  	  If unsure, say N.
>  
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index 6562b17..1767257 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -1,5 +1,5 @@
>  /*
> - * Microchip AR1021 driver for I2C
> + * Microchip AR1020 and AR1021 driver for I2C
>   *
>   * Author: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>   *
> @@ -24,6 +24,11 @@ struct ar1021_i2c {
>  	u8 data[AR1021_TOCUH_PKG_SIZE];
>  };
>  
> +enum {
> +	ar1021,
> +	ar1020,
> +};
> +
>  static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
>  {
>  	struct ar1021_i2c *ar1021 = dev_id;
> @@ -151,13 +156,15 @@ static int __maybe_unused ar1021_i2c_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(ar1021_i2c_pm, ar1021_i2c_suspend, ar1021_i2c_resume);
>  
>  static const struct i2c_device_id ar1021_i2c_id[] = {
> -	{ "MICROCHIP_AR1021_I2C", 0 },
> +	{ "MICROCHIP_AR1021_I2C", ar1021 },
> +	{ "MICROCHIP_AR1020_I2C", ar1020 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);
>  
>  static const struct of_device_id ar1021_i2c_of_match[] = {
>  	{ .compatible = "microchip,ar1021-i2c", },
> +	{ .compatible = "microchip,ar1020-i2c", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ar1021_i2c_of_match);
> @@ -175,5 +182,5 @@ static struct i2c_driver ar1021_i2c_driver = {
>  module_i2c_driver(ar1021_i2c_driver);
>  
>  MODULE_AUTHOR("Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> -MODULE_DESCRIPTION("Microchip AR1021 I2C Driver");
> +MODULE_DESCRIPTION("Microchip AR1020 and AR1021 I2C Driver");
>  MODULE_LICENSE("GPL");
> -- 
> 2.1.4
> 

I do not see where you handle ar1020 differently from ar1021. If devices
are compatible, you do not need to add a new compatible to the driver,
simply use it in the binding:

	compatible = "microchip,ar1020-i2c", "microchip,ar1021-i2c";

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
