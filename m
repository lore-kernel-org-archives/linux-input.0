From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 11/13] leds: max77650: add LEDs support
Date: Sun, 20 Jan 2019 17:39:05 +0100
Message-ID: <c23c3bb0-4da6-5f82-5a5d-1c14902b97c5@gmail.com>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-12-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118134244.22253-12-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

Hi Bartosz,

Thank you for the patch.

I have few minor issues below.

On 1/18/19 2:42 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This adds basic support for LEDs for the max77650 PMIC. The device has
> three current sinks for driving LEDs.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/leds/Kconfig         |   6 ++
>   drivers/leds/Makefile        |   1 +
>   drivers/leds/leds-max77650.c | 162 +++++++++++++++++++++++++++++++++++
>   3 files changed, 169 insertions(+)
>   create mode 100644 drivers/leds/leds-max77650.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a72f97fca57b..6e7a8f51eccc 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -608,6 +608,12 @@ config LEDS_TLC591XX
>   	  This option enables support for Texas Instruments TLC59108
>   	  and TLC59116 LED controllers.
>   
> +config LEDS_MAX77650
> +	tristate "LED support for Maxim MAX77650 PMIC"
> +	depends on MFD_MAX77650
> +	help
> +	  LEDs driver for MAX77650 family of PMICs from Maxim Integrated."
> +
>   config LEDS_MAX77693
>   	tristate "LED support for MAX77693 Flash"
>   	depends on LEDS_CLASS_FLASH
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 4c1b0054f379..f48b2404dbb7 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
>   obj-$(CONFIG_LEDS_NS2)			+= leds-ns2.o
>   obj-$(CONFIG_LEDS_NETXBIG)		+= leds-netxbig.o
>   obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
> +obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
>   obj-$(CONFIG_LEDS_MAX77693)		+= leds-max77693.o
>   obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
>   obj-$(CONFIG_LEDS_LM355x)		+= leds-lm355x.o
> diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
> new file mode 100644
> index 000000000000..be2bb1c60448
> --- /dev/null
> +++ b/drivers/leds/leds-max77650.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 BayLibre SAS
> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> + *
> + * LEDS driver for MAXIM 77650/77651 charger/power-supply.
> + */

Please use uniform C++ comment style.

If in doubt, please refer to the following Linus statement
from [0]:

"And yes, feel free to replace block comments with // while at it."

> +#include <linux/i2c.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/max77650.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define MAX77650_NUM_LEDS		3
> +
> +#define MAX77650_LED_A_BASE		0x40
> +#define MAX77650_LED_B_BASE		0x43
> +
> +#define MAX77650_LED_BR_MASK		GENMASK(4, 0)
> +#define MAX77650_LED_EN_MASK		GENMASK(7, 6)
> +
> +/* Enable EN_LED_MSTR. */
> +#define MAX77650_LED_TOP_DEFAULT	BIT(0)
> +
> +#define MAX77650_LED_ENABLE		GENMASK(7, 6)
> +#define MAX77650_LED_DISABLE		0x00
> +
> +#define MAX77650_LED_A_DEFAULT		MAX77650_LED_DISABLE
> +/* 100% on duty */
> +#define MAX77650_LED_B_DEFAULT		GENMASK(3, 0)
> +
> +struct max77650_leds;
> +
> +struct max77650_led {
> +	struct led_classdev cdev;
> +	struct max77650_leds *parent;
> +	unsigned int regA;
> +	unsigned int regB;
> +};
> +
> +struct max77650_leds {
> +	struct regmap *map;
> +	struct max77650_led leds[MAX77650_NUM_LEDS];
> +};
> +
> +static struct max77650_led *max77650_to_led(struct led_classdev *cdev)
> +{
> +	return container_of(cdev, struct max77650_led, cdev);
> +}
> +
> +static int max77650_leds_brightness_set(struct led_classdev *cdev,
> +					enum led_brightness brightness)

I would change function names to max77650_led* (singular).
It would be consistent with most of the other LED class drivers.
LED driver for max77693 flash cell also uses this scheme
(drivers/leds/leds-max77693.c).

> +{
> +	struct max77650_led *led = max77650_to_led(cdev);
> +	struct regmap *regmap = led->parent->map;
> +	int val, mask;
> +
> +	mask = MAX77650_LED_BR_MASK | MAX77650_LED_EN_MASK;
> +
> +	if (brightness == LED_OFF) {
> +		val = MAX77650_LED_DISABLE;
> +	} else {
> +		val = MAX77650_LED_ENABLE;
> +		/*
> +		 * We can set the brightness with 5-bit resolution.
> +		 *
> +		 * For brightness == 1, the bits we're writing will be 0, but
> +		 * since we keep LED_FS0 set to 12.8mA full-scale range, the
> +		 * LED will be lit slightly.
> +		 */
> +		val |= brightness / 8;
> +	}
> +
> +	return regmap_update_bits(regmap, led->regA, mask, val);
> +}
> +
> +static int max77650_leds_probe(struct platform_device *pdev)
> +{
> +	struct device_node *of_node, *child;
> +	struct max77650_leds *leds;
> +	struct max77650_led *led;
> +	struct device *parent;
> +	struct device *dev;
> +	int rv, num_leds;
> +	u32 reg;
> +
> +	dev = &pdev->dev;
> +	parent = dev->parent;
> +	of_node = dev->of_node;
> +
> +	if (!of_node)
> +		return -ENODEV;
> +
> +	leds = devm_kzalloc(dev, sizeof(*leds), GFP_KERNEL);
> +	if (!leds)
> +		return -ENOMEM;
> +
> +	leds->map = dev_get_regmap(dev->parent, NULL);
> +	if (!leds->map)
> +		return -ENODEV;
> +
> +	num_leds = of_get_child_count(of_node);
> +	if (!num_leds || num_leds > MAX77650_NUM_LEDS)
> +		return -ENODEV;
> +
> +	for_each_child_of_node(of_node, child) {
> +		rv = of_property_read_u32(child, "reg", &reg);
> +		if (rv || reg >= MAX77650_NUM_LEDS)
> +			return -EINVAL;
> +
> +		led = &leds->leds[reg];
> +
> +		led->parent = leds;
> +		led->regA = MAX77650_LED_A_BASE + reg;
> +		led->regB = MAX77650_LED_B_BASE + reg;
> +		led->cdev.brightness_set_blocking
> +					= max77650_leds_brightness_set;
> +
> +		led->cdev.name = of_get_property(child, "label", NULL);
> +		if (!led->cdev.name)
> +			led->cdev.name = child->name;

Please follow how other recent LED class drivers construct LED names,
e.g. drivers/leds/leds-cr0014114.c. We are in the course of creating
generic support for creating LED names, but until it is agreed upon
we've got to use other drivers as a reference.

> +
> +		of_property_read_string(child, "linux,default-trigger",
> +					&led->cdev.default_trigger);
> +
> +		rv = devm_of_led_classdev_register(dev, child, &led->cdev);
> +		if (rv)
> +			return rv;
> +
> +		rv = regmap_write(leds->map, led->regA,
> +				  MAX77650_LED_A_DEFAULT);
> +		if (rv)
> +			return rv;
> +
> +		rv = regmap_write(leds->map, led->regB,
> +				  MAX77650_LED_B_DEFAULT);
> +		if (rv)
> +			return rv;
> +	}
> +
> +	rv = regmap_write(leds->map,
> +			  MAX77650_REG_CNFG_LED_TOP,
> +			  MAX77650_LED_TOP_DEFAULT);
> +	if (rv)
> +		return rv;

No need to check rv here:

	return regmap_write(leds->map,
			  MAX77650_REG_CNFG_LED_TOP,
			  MAX77650_LED_TOP_DEFAULT)

> +	return 0;
> +}
> +
> +static struct platform_driver max77650_leds_driver = {
> +	.driver = {
> +		.name = "max77650-leds",

s/leds/led/

> +	},
> +	.probe = max77650_leds_probe,
> +};
> +module_platform_driver(max77650_leds_driver);
> +
> +MODULE_DESCRIPTION("MAXIM 77650/77651 LED driver");
> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> +MODULE_LICENSE("GPL");

s/GPL/GPL v2/


[0] https://lkml.org/lkml/2017/11/2/715

-- 
Best regards,
Jacek Anaszewski
