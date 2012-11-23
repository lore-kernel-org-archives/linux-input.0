From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/5] Input: bu21013_ts - Add support for Device Tree
 booting
Date: Fri, 23 Nov 2012 15:52:58 +0000
Message-ID: <20121123155258.GE28552@gmail.com>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-4-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45076 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab2KWPxC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Nov 2012 10:53:02 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so3936142bkw.19
        for <linux-input@vger.kernel.org>; Fri, 23 Nov 2012 07:53:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352900837-20759-4-git-send-email-lee.jones@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, 14 Nov 2012, Lee Jones wrote:

> Now we can register the BU21013_ts touch screen when booting with
> Device Tree enabled. Here we parse all the necessary components
> previously expected to be passed from platform data.
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/input/touchscreen/bu21013_ts.c |   39 ++++++++++++++++++++++=
++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/t=
ouchscreen/bu21013_ts.c
> index 5d8fc75..afef874 100644
> --- a/drivers/input/touchscreen/bu21013_ts.c
> +++ b/drivers/input/touchscreen/bu21013_ts.c
> @@ -15,6 +15,8 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/module.h>
>  #include <linux/gpio.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> =20
>  /* Reference tracking for multiple displays. */
>  static int bu21013_devices =3D 0;
> @@ -487,13 +489,33 @@ static void bu21013_free_irq(struct bu21013_ts_=
data *bu21013_data)
>   * This function used to initializes the i2c-client touchscreen
>   * driver and returns integer.
>   */
> +static void __devinit bu21013_of_probe(struct device_node *np,
> +				struct bu21013_platform_device *pdata)
> +{
> +	pdata->y_flip =3D pdata->x_flip =3D false;
> +
> +	if (of_get_property(np, "rohm,flip-x", NULL))
> +		pdata->x_flip =3D true;
> +
> +	if (of_get_property(np, "rohm,flip-y", NULL))
> +		pdata->y_flip =3D true;
> +
> +	of_property_read_u32(np, "rohm,touch-max-x", &pdata->touch_x_max);
> +	of_property_read_u32(np, "rohm,touch-max-y", &pdata->touch_y_max);
> +
> +	pdata->touch_pin =3D of_get_named_gpio(np, "touch-gpio", 0);
> +	pdata->cs_pin =3D of_get_named_gpio(np, "reset-gpio", 0);
> +
> +	pdata->ext_clk =3D false;
> +}
> +
>  static int __devinit bu21013_probe(struct i2c_client *client,
>  					const struct i2c_device_id *id)
>  {
>  	struct bu21013_ts_data *bu21013_data;
>  	struct input_dev *in_dev;
> -	const struct bu21013_platform_device *pdata =3D
> -					client->dev.platform_data;
> +	struct device_node *np =3D client->dev.of_node;
> +	struct bu21013_platform_device *pdata =3D client->dev.platform_data=
;
>  	int error;
> =20
>  	if (!i2c_check_functionality(client->adapter,
> @@ -503,8 +525,17 @@ static int __devinit bu21013_probe(struct i2c_cl=
ient *client,
>  	}
> =20
>  	if (!pdata) {
> -		dev_err(&client->dev, "platform data not defined\n");
> -		return -EINVAL;
> +		if (np) {
> +			pdata =3D devm_kzalloc(&client->dev, sizeof(*pdata),
> +					GFP_KERNEL);
> +			if (!pdata)
> +				return -ENOMEM;
> +
> +			bu21013_of_probe(np, pdata);
> +		} else {
> +			dev_err(&client->dev, "no device tree or platform data\n");
> +			return -EINVAL;
> +		}
>  	}
> =20
>  	pdata->irq =3D gpio_to_irq(pdata->touch_pin);
> --=20
> 1.7.9.5
>=20

=46riendly poke for Dmitry.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
