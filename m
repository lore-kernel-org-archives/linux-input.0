From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v2 1/3] input: goodix: Add device tree support
Date: Mon, 19 Jan 2015 10:48:44 +0100
Message-ID: <1421660924.2075.16.camel@hadess.net>
References: <1421589740-12132-1-git-send-email-mamlinav@gmail.com>
	 <1421589870-14232-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421589870-14232-1-git-send-email-mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 2015-01-18 at 17:04 +0300, Aleksei Mamlin wrote:
> Signed-off-by: Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/input/touchscreen/Kconfig  |  2 +-
>  drivers/input/touchscreen/goodix.c | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 5891752..c4a79b7 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -297,7 +297,7 @@ config TOUCHSCREEN_FUJITSU
>  
>  config TOUCHSCREEN_GOODIX
>  	tristate "Goodix I2C touchscreen"
> -	depends on I2C && ACPI
> +	depends on I2C && (ACPI || OF)

This can't be ACPI or OF. If ACPI is disabled, the goodix_acpi_match
structure is still defined, not ifdef'ed like the OF code you're adding.

>  	help
>  	  Say Y here if you have the Goodix touchscreen (such as one
>  	  installed in Onda v975w tablets) connected to your
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index ca19668..603d2ae 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -23,6 +23,7 @@
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  #include <asm/unaligned.h>
>  
>  struct goodix_ts_data {
> @@ -378,6 +379,14 @@ static const struct acpi_device_id goodix_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id goodix_of_match[] = {
> +	{ .compatible = "goodix,gt9xx" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, goodix_of_match);
> +#endif
> +
>  static struct i2c_driver goodix_ts_driver = {
>  	.probe = goodix_ts_probe,
>  	.id_table = goodix_ts_id,
> @@ -385,6 +394,7 @@ static struct i2c_driver goodix_ts_driver = {
>  		.name = "Goodix-TS",
>  		.owner = THIS_MODULE,
>  		.acpi_match_table = goodix_acpi_match,
> +		.of_match_table = of_match_ptr(goodix_of_match),
>  	},
>  };
>  module_i2c_driver(goodix_ts_driver);


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
