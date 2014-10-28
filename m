From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 05/15] video: backlight: add new locomo backlight driver
Date: Tue, 28 Oct 2014 09:24:05 +0900
Message-ID: <000101cff245$7be2a570$73a7f050$%han@samsung.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-6-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <1414454528-24240-6-git-send-email-dbaryshkov@gmail.com>
Content-language: ko
Sender: linux-leds-owner@vger.kernel.org
To: 'Dmitry Eremin-Solenikov' <dbaryshkov@gmail.com>
Cc: 'Andrea Adami' <andrea.adami@gmail.com>, 'Russell King' <linux@arm.linux.org.uk>, 'Daniel Mack' <daniel@zonque.org>, 'Haojian Zhuang' <haojian.zhuang@gmail.com>, 'Robert Jarzmik' <robert.jarzmik@free.fr>, 'Linus Walleij' <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, 'Alexandre Courbot' <gnurou@gmail.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Bryan Wu' <cooloney@gmail.com>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Samuel Ortiz' <sameo@linux.intel.com>, 'Lee Jones' <lee.jones@linaro.org>, 'Mark Brown' <broonie@kernel.org>, 'Liam Girdwood' <lgirdwood@gmail.com>, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-input@vger.kernel.org

On Tuesday, October 28, 2014 9:02 AM, Dmitry Eremin-Solenikov wrote:
> 
> Add new simple backlight driver - it cares only about PWM/frontlight
> part of LoCoMo, it does not touch TFT settings and does not export TFT
> power control.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/video/backlight/Kconfig     |   6 +-
>  drivers/video/backlight/Makefile    |   2 +-
>  drivers/video/backlight/locomo_bl.c | 171 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 175 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/video/backlight/locomo_bl.c
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 8d03924..03b77b33 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -218,12 +218,12 @@ config BACKLIGHT_LM3533
>  	  levels.
> 
>  config BACKLIGHT_LOCOMO
> -	tristate "Sharp LOCOMO LCD/Backlight Driver"
> -	depends on SHARP_LOCOMO
> +	tristate "Sharp LOCOMO Backlight Driver"
> +	depends on MFD_LOCOMO
>  	default y
>  	help
>  	  If you have a Sharp Zaurus SL-5500 (Collie) or SL-5600 (Poodle) say y to
> -	  enable the LCD/backlight driver.
> +	  enable the backlight driver.
> 
>  config BACKLIGHT_OMAP1
>  	tristate "OMAP1 PWL-based LCD Backlight"
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index fcd50b73..2a61b7e 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -39,7 +39,7 @@ obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
>  obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
>  obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
>  obj-$(CONFIG_BACKLIGHT_LM3639)		+= lm3639_bl.o
> -obj-$(CONFIG_BACKLIGHT_LOCOMO)		+= locomolcd.o
> +obj-$(CONFIG_BACKLIGHT_LOCOMO)		+= locomo_bl.o
>  obj-$(CONFIG_BACKLIGHT_LP855X)		+= lp855x_bl.o
>  obj-$(CONFIG_BACKLIGHT_LP8788)		+= lp8788_bl.o
>  obj-$(CONFIG_BACKLIGHT_LV5207LP)	+= lv5207lp.o
> diff --git a/drivers/video/backlight/locomo_bl.c b/drivers/video/backlight/locomo_bl.c
> new file mode 100644
> index 0000000..cec1b51
> --- /dev/null
> +++ b/drivers/video/backlight/locomo_bl.c
> @@ -0,0 +1,171 @@
> +/*
> + * Backlight control code for Sharp Zaurus SL-5500
> + *
> + * Copyright 2005 John Lenz <lenz@cs.wisc.edu>
> + * Maintainer: Pavel Machek <pavel@ucw.cz> (unless John wants to :-)
> + * GPL v2
> + *
> + * This driver assumes single CPU. That's okay, because collie is
> + * slightly old hardware, and no one is going to retrofit second CPU to
> + * old PDA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/fb.h>
> +#include <linux/backlight.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/locomo.h>

Please, re-order these headers alphabetically.
It enhances the readability.

> +
> +struct locomo_bl {
> +	void __iomem *regs;
> +	int current_intensity;
> +	int gpio_fl_vr;
> +};
> +
> +static const struct {
> +	u16 duty, bpwf;
> +	bool vr;
> +} locomo_bl_pwm[] = {
> +	{ 0, 161, false },
> +	{ 117, 161, false },
> +	{ 163, 148, false },
> +	{ 194, 161, false },
> +	{ 194, 161, true },
> +};
> +
> +static int locomo_bl_set_intensity(struct backlight_device *bd)
> +{
> +	int intensity = bd->props.brightness;
> +	struct locomo_bl *bl = dev_get_drvdata(&bd->dev);
> +
> +	if (bd->props.power != FB_BLANK_UNBLANK)
> +		intensity = 0;
> +	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> +		intensity = 0;
> +	if (bd->props.state & BL_CORE_SUSPENDED)
> +		intensity = 0;
> +
> +	gpio_set_value(bl->gpio_fl_vr, locomo_bl_pwm[intensity].vr);
> +
> +	writew(locomo_bl_pwm[intensity].bpwf, bl->regs + LOCOMO_ALS);
> +	udelay(100);
> +	writew(locomo_bl_pwm[intensity].duty, bl->regs + LOCOMO_ALD);
> +	udelay(100);

How about changing udelay() to usleep_range()?

> +	writew(locomo_bl_pwm[intensity].bpwf | LOCOMO_ALC_EN,
> +			bl->regs + LOCOMO_ALS);

> +
> +	bl->current_intensity = intensity;
> +	if (bd->props.state & BL_CORE_SUSPENDED)
> +		writew(0x00, bl->regs + LOCOMO_ALS);
> +
> +	return 0;
> +}
> +
> +static int locomo_bl_get_intensity(struct backlight_device *bd)
> +{
> +	struct locomo_bl *bl = dev_get_drvdata(&bd->dev);
> +
> +	return bl->current_intensity;
> +}
> +
> +static const struct backlight_ops locomo_bl_ops = {
> +	.options	= BL_CORE_SUSPENDRESUME,
> +	.get_brightness = locomo_bl_get_intensity,
> +	.update_status  = locomo_bl_set_intensity,
> +};
> +
> +static int locomo_bl_probe(struct platform_device *dev)
> +{
> +	struct backlight_properties props;
> +	struct resource *res;
> +	struct locomo_bl_platform_data *pdata;
> +	struct locomo_bl *bl;
> +	struct backlight_device *locomo_bl_device;
> +	int rc;
> +
> +	bl = devm_kmalloc(&dev->dev, sizeof(struct locomo_bl), GFP_KERNEL);
> +	if (!bl)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;

There is no need to check this, because devm_ioremap_resource()
will check this.

> +	bl->regs = devm_ioremap_resource(&dev->dev, res);
> +	if (!bl->regs)
> +		return -EINVAL;

The correct usage is as follows.

	if (IS_ERR(base))
		return PTR_ERR(base);

Please change it as below.

	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
	bl->regs = devm_ioremap_resource(&dev->dev, res);
	if (IS_ERR(bl->regs))
		 return PTR_ERR(bl->regs);

> +
> +	pdata = dev_get_platdata(&dev->dev);
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	bl->gpio_fl_vr = pdata->gpio_fl_vr;
> +	rc = devm_gpio_request_one(&dev->dev, bl->gpio_fl_vr,
> +			GPIOF_OUT_INIT_LOW, "FL VR");
> +	if (rc)
> +		return rc;
> +
> +	writew(0, bl->regs + LOCOMO_ALS);
> +	writew(0, bl->regs + LOCOMO_ALD);
> +
> +	memset(&props, 0, sizeof(struct backlight_properties));
> +	props.type = BACKLIGHT_RAW;
> +	props.max_brightness = ARRAY_SIZE(locomo_bl_pwm) - 1;
> +	props.brightness = props.max_brightness / 2;
> +	locomo_bl_device = backlight_device_register("locomo-bl",

Please use devm_backlight_device_register().

> +						&dev->dev, bl,
> +						&locomo_bl_ops, &props);

> +
> +	if (IS_ERR(locomo_bl_device))
> +		return PTR_ERR(locomo_bl_device);
> +
> +	platform_set_drvdata(dev, locomo_bl_device);
> +
> +	/* Set up frontlight so that screen is readable */
> +	backlight_update_status(locomo_bl_device);
> +
> +	return 0;
> +}
> +
> +static int locomo_bl_remove(struct platform_device *dev)
> +{
> +	struct backlight_device *locomo_bl_device = platform_get_drvdata(dev);
> +
> +	locomo_bl_device->props.brightness = 0;
> +	locomo_bl_device->props.power = 0;
> +	locomo_bl_set_intensity(locomo_bl_device);
> +
> +	backlight_device_unregister(locomo_bl_device);

If devm_backlight_device_register() is used in probe(),
there is no need to call backlight_device_unregister() in remove().

> +
> +	return 0;
> +}
> +
> +static void locomo_bl_shutdown(struct platform_device *dev)
> +{
> +	struct backlight_device *locomo_bl_device = platform_get_drvdata(dev);
> +
> +	locomo_bl_device->props.brightness = 0;
> +	locomo_bl_device->props.power = 0;
> +	locomo_bl_set_intensity(locomo_bl_device);
> +}
> +
> +static struct platform_driver locomo_bl_driver = {
> +	.driver = {
> +		.name	= "locomo-backlight",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe	= locomo_bl_probe,
> +	.remove	= locomo_bl_remove,
> +	/* Turn off bl on power off/reboot */
> +	.shutdown = locomo_bl_shutdown,
> +};
> +
> +module_platform_driver(locomo_bl_driver);
> +
> +MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@ucw.cz>");

This might make checkpatch warning.
Please split these authors to lines as below.

MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
MODULE_AUTHOR("Pavel Machek <pavel@ucw.cz>");

> +MODULE_DESCRIPTION("Collie Backlight driver");

What does mean 'Collie'? 'Locomo' looks better.

> +MODULE_LICENSE("GPL");

How about using "GPL v2"?

Thank you.

Best regards,
Jingoo Han

> +MODULE_ALIAS("platform:locomo-backlight");
> --
> 2.1.1
