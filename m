From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] mfd: tc3589x: enforce device-tree only mode
Date: Fri, 27 Mar 2015 11:53:17 +0000
Message-ID: <20150327115317.GE15988@x1>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
 <1426776765-18812-3-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35879 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbbC0LxW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 07:53:22 -0400
Received: by wgra20 with SMTP id a20so96262261wgr.3
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2015 04:53:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426776765-18812-3-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Thu, 19 Mar 2015, Linus Walleij wrote:

> All systems using the TC3589x multifunction expander uses
> devicetree, so don't clutter the place with a lot of
> and assume it is there.
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/Kconfig                    | 1 +
>  drivers/gpio/gpio-tc3589x.c             | 3 ---
>  drivers/input/keyboard/tc3589x-keypad.c | 9 ---------
>  drivers/mfd/Kconfig                     | 1 +
>  drivers/mfd/tc3589x.c                   | 9 ---------
>  5 files changed, 2 insertions(+), 21 deletions(-)

Applied, thanks.

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index c1e2ca3d9a51..dc1aaa83a347 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -669,6 +669,7 @@ config GPIO_STP_XWAY
>  config GPIO_TC3589X
>  	bool "TC3589X GPIOs"
>  	depends on MFD_TC3589X
> +	depends on OF_GPIO
>  	select GPIOLIB_IRQCHIP
>  	help
>  	  This enables support for the GPIOs found on the TC3589X
> diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.=
c
> index 11aed2671065..31b244cffabb 100644
> --- a/drivers/gpio/gpio-tc3589x.c
> +++ b/drivers/gpio/gpio-tc3589x.c
> @@ -260,10 +260,7 @@ static int tc3589x_gpio_probe(struct platform_de=
vice *pdev)
>  	tc3589x_gpio->chip.ngpio =3D tc3589x->num_gpio;
>  	tc3589x_gpio->chip.dev =3D &pdev->dev;
>  	tc3589x_gpio->chip.base =3D -1;
> -
> -#ifdef CONFIG_OF_GPIO
>  	tc3589x_gpio->chip.of_node =3D np;
> -#endif
> =20
>  	/* Bring the GPIO module out of reset */
>  	ret =3D tc3589x_set_bits(tc3589x, TC3589x_RSTCTRL,
> diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/=
keyboard/tc3589x-keypad.c
> index 0ccc7de9b59d..08e62e6aeb1b 100644
> --- a/drivers/input/keyboard/tc3589x-keypad.c
> +++ b/drivers/input/keyboard/tc3589x-keypad.c
> @@ -318,7 +318,6 @@ static void tc3589x_keypad_close(struct input_dev=
 *input)
>  	tc3589x_keypad_disable(keypad);
>  }
> =20
> -#ifdef CONFIG_OF
>  static const struct tc3589x_keypad_platform_data *
>  tc3589x_keypad_of_probe(struct device *dev)
>  {
> @@ -368,14 +367,6 @@ tc3589x_keypad_of_probe(struct device *dev)
> =20
>  	return plat;
>  }
> -#else
> -static inline const struct tc3589x_keypad_platform_data *
> -tc3589x_keypad_of_probe(struct device *dev)
> -{
> -	return ERR_PTR(-ENODEV);
> -}
> -#endif
> -
> =20
>  static int tc3589x_keypad_probe(struct platform_device *pdev)
>  {
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 38356e39adba..476e63745742 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1210,6 +1210,7 @@ config MFD_TIMBERDALE
>  config MFD_TC3589X
>  	bool "Toshiba TC35892 and variants"
>  	depends on I2C=3Dy
> +	depends on OF
>  	select MFD_CORE
>  	help
>  	  Support for the Toshiba TC35892 and variants I/O Expander.
> diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
> index aacb3720065c..cf356395c9e9 100644
> --- a/drivers/mfd/tc3589x.c
> +++ b/drivers/mfd/tc3589x.c
> @@ -318,7 +318,6 @@ static int tc3589x_device_init(struct tc3589x *tc=
3589x)
>  	return ret;
>  }
> =20
> -#ifdef CONFIG_OF
>  static const struct of_device_id tc3589x_match[] =3D {
>  	/* Legacy compatible string */
>  	{ .compatible =3D "tc3589x", .data =3D (void *) TC3589X_UNKNOWN },
> @@ -359,14 +358,6 @@ tc3589x_of_probe(struct device *dev, enum tc3589=
x_version *version)
> =20
>  	return pdata;
>  }
> -#else
> -static inline struct tc3589x_platform_data *
> -tc3589x_of_probe(struct device *dev, enum tc3589x_version *version)
> -{
> -	dev_err(dev, "no device tree support\n");
> -	return ERR_PTR(-ENODEV);
> -}
> -#endif
> =20
>  static int tc3589x_probe(struct i2c_client *i2c,
>  				   const struct i2c_device_id *id)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
