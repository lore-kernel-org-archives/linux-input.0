From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 06/17] video: lcd: add LoCoMo LCD driver
Date: Tue, 19 May 2015 10:36:44 +0100
Message-ID: <20150519093644.GT22418@x1>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
 <1431880077-26321-7-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431880077-26321-7-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

On Sun, 17 May 2015, Dmitry Eremin-Solenikov wrote:

> LoCoMo has some special handling for TFT screens attached to Collie a=
nd
> Poodle. Implement that as a separate driver.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/video/backlight/Kconfig      |  10 ++
>  drivers/video/backlight/Makefile     |   1 +
>  drivers/video/backlight/locomo_lcd.c | 285 +++++++++++++++++++++++++=
++++++++++
>  3 files changed, 296 insertions(+)
>  create mode 100644 drivers/video/backlight/locomo_lcd.c

This looks like it should be part of patch 16.

How much of this file is the same as the one removed later in the set?

> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backligh=
t/Kconfig
> index 6c093e2..b2f995c 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -48,6 +48,16 @@ config LCD_LMS283GF05
>  	  SPI driver for Samsung LMS283GF05. This provides basic support
>  	  for powering the LCD up/down through a sysfs interface.
> =20
> +config LCD_LOCOMO
> +	tristate "Sharp LOCOMO LCD Driver"
> +	depends on MFD_LOCOMO
> +	select IIO
> +	help
> +	  If you have a Sharp Zaurus SL-5500 (Collie) or SL-5600 (Poodle) s=
ay y to
> +	  enable the LCD driver.  The panel starts up in power
> +	  off state, so you need this driver in order to see any
> +	  output.
> +
>  config LCD_LTV350QV
>  	tristate "Samsung LTV350QV LCD Panel"
>  	depends on SPI_MASTER
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlig=
ht/Makefile
> index 2de73d2..686cf1a 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_LCD_L4F00242T03)		+=3D l4f00242t03.o
>  obj-$(CONFIG_LCD_LD9040)		+=3D ld9040.o
>  obj-$(CONFIG_LCD_LMS283GF05)		+=3D lms283gf05.o
>  obj-$(CONFIG_LCD_LMS501KF03)		+=3D lms501kf03.o
> +obj-$(CONFIG_LCD_LOCOMO)		+=3D locomo_lcd.o
>  obj-$(CONFIG_LCD_LTV350QV)		+=3D ltv350qv.o
>  obj-$(CONFIG_LCD_PLATFORM)		+=3D platform_lcd.o
>  obj-$(CONFIG_LCD_S6E63M0)		+=3D s6e63m0.o
> diff --git a/drivers/video/backlight/locomo_lcd.c b/drivers/video/bac=
klight/locomo_lcd.c
> new file mode 100644
> index 0000000..dc316cb
> --- /dev/null
> +++ b/drivers/video/backlight/locomo_lcd.c
> @@ -0,0 +1,285 @@
> +/*
> + * Backlight control code for Sharp Zaurus SL-5500
> + *
> + * Copyright 2005 John Lenz <lenz@cs.wisc.edu>
> + * Maintainer: Pavel Machek <pavel@ucw.cz> (unless John wants to :-)
> + * GPL v2
> + *
> + * This driver assumes single CPU. That's okay, because collie is
> + * slightly old hardware, and no one is going to retrofit second CPU=
 to
> + * old PDA.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fb.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/lcd.h>
> +#include <linux/mfd/locomo.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +struct locomo_lcd {
> +	struct regmap *regmap;
> +	struct platform_device *dev;
> +	struct locomo_lcd_platform_data *data;
> +	int power;
> +	struct iio_channel *comadj;
> +	struct gpio_desc *vsha, *vshd, *vee, *mod;
> +};
> +
> +static void locomo_lcd_on(struct locomo_lcd *lcd)
> +{
> +	gpiod_set_value(lcd->vsha, 1);
> +	usleep_range(2000, 3000);
> +
> +	gpiod_set_value(lcd->vshd, 1);
> +	usleep_range(2000, 3000);
> +
> +	iio_write_channel_raw(lcd->comadj, lcd->data->comadj);
> +	usleep_range(5000, 6000);
> +
> +	gpiod_set_value(lcd->vee, 1);
> +	usleep_range(10000, 11000);
> +
> +	/* TFTCRST | CPSOUT=3D0 | CPSEN */
> +	regmap_write(lcd->regmap, LOCOMO_TC, 0x01);
> +
> +	/* Set CPSD */
> +	regmap_write(lcd->regmap, LOCOMO_CPSD, 6);
> +
> +	/* TFTCRST | CPSOUT=3D0 | CPSEN */
> +	regmap_write(lcd->regmap, LOCOMO_TC, 0x04 | 0x01);
> +	usleep_range(10000, 11000);
> +
> +	gpiod_set_value(lcd->mod, 1);
> +}
> +
> +static void locomo_lcd_off(struct locomo_lcd *lcd)
> +{
> +	/* TFTCRST=3D1 | CPSOUT=3D1 | CPSEN =3D 0 */
> +	regmap_write(lcd->regmap, LOCOMO_TC, 0x06);
> +	usleep_range(1000, 2000);
> +
> +	gpiod_set_value(lcd->vsha, 0);
> +	msleep(110);
> +
> +	gpiod_set_value(lcd->vee, 0);
> +	msleep(700);
> +
> +	iio_write_channel_raw(lcd->comadj, 0);
> +	usleep_range(5000, 6000);
> +
> +	/* TFTCRST=3D0 | CPSOUT=3D0 | CPSEN =3D 0 */
> +	regmap_write(lcd->regmap, LOCOMO_TC, 0);
> +	gpiod_set_value(lcd->mod, 0);
> +	gpiod_set_value(lcd->vshd, 0);
> +}
> +
> +static void locomo_lcd_program_adsync(struct locomo_lcd *lcd)
> +{
> +	regmap_write(lcd->regmap, LOCOMO_ASD,
> +			6 + 8 + 320 + 30 - 10);
> +	regmap_update_bits(lcd->regmap, LOCOMO_ASD,
> +		0x8000,
> +		0x8000);
> +
> +	regmap_write(lcd->regmap, LOCOMO_HSD,
> +			6 + 8 + 320 + 30 - 10 - 128 + 4);
> +	regmap_update_bits(lcd->regmap, LOCOMO_HSD,
> +		0x8000,
> +		0x8000);
> +
> +	regmap_write(lcd->regmap, LOCOMO_HSC, 128 / 8);
> +
> +	/* XON */
> +	regmap_write(lcd->regmap, LOCOMO_TADC, 0x80);
> +	usleep_range(1000, 1100);
> +
> +	/* CLK9MEN */
> +	regmap_update_bits(lcd->regmap, LOCOMO_TADC,
> +		0x10,
> +		0x10);
> +	usleep_range(100, 200);
> +}
> +
> +static void locomo_lcd_disable_adsync(struct locomo_lcd *lcd)
> +{
> +	/* ADSTART */
> +	regmap_write(lcd->regmap, LOCOMO_ASD, 0x00);
> +
> +	/* 18MHz clock off*/
> +	regmap_write(lcd->regmap, LOCOMO_TADC, 0x00);
> +}
> +
> +int locomo_lcd_set_power(struct lcd_device *ldev, int power)
> +{
> +	struct locomo_lcd *lcd =3D lcd_get_data(ldev);
> +
> +	dev_dbg(&ldev->dev, "LCD power %d (is %d)\n", power, lcd->power);
> +
> +	if (!power && lcd->power)
> +		locomo_lcd_on(lcd);
> +
> +	if (power && !lcd->power)
> +		locomo_lcd_off(lcd);
> +
> +	lcd->power =3D power;
> +
> +	return 0;
> +}
> +
> +static int locomo_lcd_get_power(struct lcd_device *ldev)
> +{
> +	struct locomo_lcd *lcd =3D lcd_get_data(ldev);
> +
> +	return lcd->power;
> +}
> +
> +static struct lcd_ops locomo_lcd_ops =3D {
> +	.set_power =3D locomo_lcd_set_power,
> +	.get_power =3D locomo_lcd_get_power,
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int locomo_lcd_suspend(struct device *dev)
> +{
> +	struct lcd_device *ldev =3D dev_get_drvdata(dev);
> +	struct locomo_lcd *lcd =3D lcd_get_data(ldev);
> +
> +	locomo_lcd_off(lcd);
> +
> +	locomo_lcd_disable_adsync(lcd);
> +
> +	return 0;
> +}
> +
> +static int locomo_lcd_resume(struct device *dev)
> +{
> +	struct lcd_device *ldev =3D dev_get_drvdata(dev);
> +	struct locomo_lcd *lcd =3D lcd_get_data(ldev);
> +
> +	locomo_lcd_program_adsync(lcd);
> +
> +	if (!lcd->power)
> +		locomo_lcd_on(lcd);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(locomo_lcd_pm, locomo_lcd_suspend, locomo_l=
cd_resume);
> +#define LOCOMOLCD_PM	(&locomo_lcd_pm)
> +#else
> +#define LOCOMOLCD_PM	NULL
> +#endif
> +
> +static int locomo_lcd_probe(struct platform_device *dev)
> +{
> +	struct lcd_device *lcd_dev;
> +	struct locomo_lcd *lcd;
> +	int rc;
> +
> +	lcd =3D devm_kmalloc(&dev->dev, sizeof(struct locomo_lcd), GFP_KERN=
EL);
> +	if (!lcd)
> +		return -ENOMEM;
> +
> +	lcd->dev =3D dev;
> +	lcd->power =3D FB_BLANK_NORMAL;
> +
> +	lcd->regmap =3D dev_get_regmap(dev->dev.parent, NULL);
> +	if (!lcd->regmap)
> +		return -ENODEV;
> +
> +	lcd->data =3D dev_get_platdata(&dev->dev);
> +	if (!lcd->data)
> +		return -EINVAL;
> +
> +	lcd->vsha =3D devm_gpiod_get(&dev->dev, "VSHA", GPIOD_OUT_LOW);
> +	if (IS_ERR(lcd->vsha))
> +		return PTR_ERR(lcd->vsha);
> +
> +	lcd->vshd =3D devm_gpiod_get(&dev->dev, "VSHD", GPIOD_OUT_LOW);
> +	if (IS_ERR(lcd->vshd))
> +		return PTR_ERR(lcd->vshd);
> +
> +	lcd->vee =3D devm_gpiod_get(&dev->dev, "Vee", GPIOD_OUT_LOW);
> +	if (IS_ERR(lcd->vee))
> +		return PTR_ERR(lcd->vee);
> +
> +	lcd->mod =3D devm_gpiod_get(&dev->dev, "MOD", GPIOD_OUT_LOW);
> +	if (IS_ERR(lcd->mod))
> +		return PTR_ERR(lcd->mod);
> +
> +	lcd->comadj =3D iio_channel_get(&dev->dev, "comadj");
> +	if (IS_ERR(lcd->comadj)) {
> +		rc =3D PTR_ERR(lcd->comadj);
> +		if (rc =3D=3D -ENODEV)
> +			rc =3D -EPROBE_DEFER;
> +
> +		return rc;
> +	}
> +
> +	locomo_lcd_program_adsync(lcd);
> +
> +	lcd_dev =3D devm_lcd_device_register(&dev->dev, "locomo", &dev->dev=
, lcd,
> +			&locomo_lcd_ops);
> +	if (IS_ERR(lcd_dev)) {
> +		rc =3D PTR_ERR(lcd_dev);
> +		goto err;
> +	}
> +
> +	platform_set_drvdata(dev, lcd_dev);
> +
> +	lcd_set_power(lcd_dev, FB_BLANK_UNBLANK);
> +
> +	return 0;
> +
> +err:
> +	locomo_lcd_disable_adsync(lcd);
> +	iio_channel_release(lcd->comadj);
> +
> +	return rc;
> +}
> +
> +static int locomo_lcd_remove(struct platform_device *dev)
> +{
> +	struct lcd_device *ldev =3D platform_get_drvdata(dev);
> +	struct locomo_lcd *lcd =3D lcd_get_data(ldev);
> +
> +	locomo_lcd_off(lcd);
> +
> +	locomo_lcd_disable_adsync(lcd);
> +
> +	iio_channel_release(lcd->comadj);
> +
> +	return 0;
> +}
> +
> +static void locomo_lcd_shutdown(struct platform_device *dev)
> +{
> +	struct lcd_device *ldev =3D platform_get_drvdata(dev);
> +	struct locomo_lcd *lcd =3D lcd_get_data(ldev);
> +
> +	locomo_lcd_off(lcd);
> +
> +	locomo_lcd_disable_adsync(lcd);
> +}
> +
> +static struct platform_driver locomo_lcd_driver =3D {
> +	.driver =3D {
> +		.name	=3D "locomo-lcd",
> +		.pm	=3D LOCOMOLCD_PM,
> +	},
> +	.probe	=3D locomo_lcd_probe,
> +	.remove	=3D locomo_lcd_remove,
> +	.shutdown =3D locomo_lcd_shutdown,
> +};
> +
> +module_platform_driver(locomo_lcd_driver);
> +
> +MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
> +MODULE_AUTHOR("Pavel Machek <pavel@ucw.cz>");
> +MODULE_DESCRIPTION("LoCoMo LCD driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:locomo-lcd");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
