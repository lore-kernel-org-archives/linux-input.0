From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/3] input: goodix: Add device tree support
Date: Sat, 17 Jan 2015 21:38:05 +0100
Message-ID: <1421527085.2075.12.camel@hadess.net>
References: <1421505253-7474-1-git-send-email-mamlinav@gmail.com>
	 <1421505361-8871-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421505361-8871-1-git-send-email-mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 2015-01-17 at 17:36 +0300, Aleksei Mamlin wrote:
> Signed-off-by: Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/input/touchscreen/goodix.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
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

Pretty sure that wouldn't compile if CONFIG_OF is disabled.

>  	},
>  };
>  module_i2c_driver(goodix_ts_driver);


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
