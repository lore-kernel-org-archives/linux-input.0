From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 08/11] gpio: max77650: add GPIO support
Date: Mon, 4 Feb 2019 11:49:35 +0100
Message-ID: <CAMRc=Md5duy1nw2neBRoEUGcqV-KCdLasUL0f6DF41t3gFMsYQ@mail.gmail.com>
References: <20190201094736.32057-1-brgl@bgdev.pl> <20190201094736.32057-9-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201094736.32057-9-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

pt., 1 lut 2019 o 10:48 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a)=
:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add GPIO support for max77650 mfd device. This PMIC exposes a single
> GPIO line.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/Kconfig         |   7 ++
>  drivers/gpio/Makefile        |   1 +
>  drivers/gpio/gpio-max77650.c | 189 +++++++++++++++++++++++++++++++++++
>  3 files changed, 197 insertions(+)
>  create mode 100644 drivers/gpio/gpio-max77650.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b5a2845347ec..fb297fe5bfec 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1095,6 +1095,13 @@ config GPIO_MAX77620
>           driver also provides interrupt support for each of the gpios.
>           Say yes here to enable the max77620 to be used as gpio controll=
er.
>
> +config GPIO_MAX77650
> +       tristate "Maxim MAX77650/77651 GPIO support"
> +       depends on MFD_MAX77650
> +       help
> +         GPIO driver for MAX77650/77651 PMIC from Maxim Semiconductor.
> +         These chips have a single pin that can be configured as GPIO.
> +
>  config GPIO_MSIC
>         bool "Intel MSIC mixed signal gpio support"
>         depends on (X86 || COMPILE_TEST) && MFD_INTEL_MSIC
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 37628f8dbf70..8bdad50db822 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_GPIO_MAX7300)    +=3D gpio-max7300.o
>  obj-$(CONFIG_GPIO_MAX7301)     +=3D gpio-max7301.o
>  obj-$(CONFIG_GPIO_MAX732X)     +=3D gpio-max732x.o
>  obj-$(CONFIG_GPIO_MAX77620)    +=3D gpio-max77620.o
> +obj-$(CONFIG_GPIO_MAX77650)    +=3D gpio-max77650.o
>  obj-$(CONFIG_GPIO_MB86S7X)     +=3D gpio-mb86s7x.o
>  obj-$(CONFIG_GPIO_MENZ127)     +=3D gpio-menz127.o
>  obj-$(CONFIG_GPIO_MERRIFIELD)  +=3D gpio-merrifield.o
> diff --git a/drivers/gpio/gpio-max77650.c b/drivers/gpio/gpio-max77650.c
> new file mode 100644
> index 000000000000..8382dd85c548
> --- /dev/null
> +++ b/drivers/gpio/gpio-max77650.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 BayLibre SAS
> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +//
> +// GPIO driver for MAXIM 77650/77651 charger/power-supply.
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/max77650.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define MAX77650_GPIO_DIR_MASK         BIT(0)
> +#define MAX77650_GPIO_INVAL_MASK       BIT(1)
> +#define MAX77650_GPIO_DRV_MASK         BIT(2)
> +#define MAX77650_GPIO_OUTVAL_MASK      BIT(3)
> +#define MAX77650_GPIO_DEBOUNCE_MASK    BIT(4)
> +
> +#define MAX77650_GPIO_DIR_OUT          0x00
> +#define MAX77650_GPIO_DIR_IN           BIT(0)
> +#define MAX77650_GPIO_OUT_LOW          0x00
> +#define MAX77650_GPIO_OUT_HIGH         BIT(3)
> +#define MAX77650_GPIO_DRV_OPEN_DRAIN   0x00
> +#define MAX77650_GPIO_DRV_PUSH_PULL    BIT(2)
> +#define MAX77650_GPIO_DEBOUNCE         BIT(4)
> +
> +#define MAX77650_GPIO_DIR_BITS(_reg) \
> +               ((_reg) & MAX77650_GPIO_DIR_MASK)
> +#define MAX77650_GPIO_INVAL_BITS(_reg) \
> +               (((_reg) & MAX77650_GPIO_INVAL_MASK) >> 1)
> +
> +struct max77650_gpio_chip {
> +       struct regmap *map;
> +       struct gpio_chip gc;
> +};
> +
> +static int max77650_gpio_direction_input(struct gpio_chip *gc,
> +                                        unsigned int offset)
> +{
> +       struct max77650_gpio_chip *chip =3D gpiochip_get_data(gc);
> +
> +       return regmap_update_bits(chip->map,
> +                                 MAX77650_REG_CNFG_GPIO,
> +                                 MAX77650_GPIO_DIR_MASK,
> +                                 MAX77650_GPIO_DIR_IN);
> +}
> +
> +static int max77650_gpio_direction_output(struct gpio_chip *gc,
> +                                         unsigned int offset, int value)
> +{
> +       struct max77650_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       int mask, regval;
> +
> +       mask =3D MAX77650_GPIO_DIR_MASK | MAX77650_GPIO_OUTVAL_MASK;
> +       regval =3D value ? MAX77650_GPIO_OUT_HIGH : MAX77650_GPIO_OUT_LOW=
;
> +       regval |=3D MAX77650_GPIO_DIR_OUT;
> +
> +       return regmap_update_bits(chip->map,
> +                                 MAX77650_REG_CNFG_GPIO, mask, regval);
> +}
> +
> +static void max77650_gpio_set_value(struct gpio_chip *gc,
> +                                   unsigned int offset, int value)
> +{
> +       struct max77650_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       int rv, regval;
> +
> +       regval =3D value ? MAX77650_GPIO_OUT_HIGH : MAX77650_GPIO_OUT_LOW=
;
> +
> +       rv =3D regmap_update_bits(chip->map, MAX77650_REG_CNFG_GPIO,
> +                               MAX77650_GPIO_OUTVAL_MASK, regval);
> +       if (rv)
> +               dev_err(gc->parent, "cannot set GPIO value: %d\n", rv);
> +}
> +
> +static int max77650_gpio_get_value(struct gpio_chip *gc,
> +                                  unsigned int offset)
> +{
> +       struct max77650_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       unsigned int val;
> +       int rv;
> +
> +       rv =3D regmap_read(chip->map, MAX77650_REG_CNFG_GPIO, &val);
> +       if (rv)
> +               return rv;
> +
> +       return MAX77650_GPIO_INVAL_BITS(val);
> +}
> +
> +static int max77650_gpio_get_direction(struct gpio_chip *gc,
> +                                      unsigned int offset)
> +{
> +       struct max77650_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       unsigned int val;
> +       int rv;
> +
> +       rv =3D regmap_read(chip->map, MAX77650_REG_CNFG_GPIO, &val);
> +       if (rv)
> +               return rv;
> +
> +       return MAX77650_GPIO_DIR_BITS(val);
> +}
> +
> +static int max77650_gpio_set_config(struct gpio_chip *gc,
> +                                   unsigned int offset, unsigned long cf=
g)
> +{
> +       struct max77650_gpio_chip *chip =3D gpiochip_get_data(gc);
> +
> +       switch (pinconf_to_config_param(cfg)) {
> +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +               return regmap_update_bits(chip->map,
> +                                         MAX77650_REG_CNFG_GPIO,
> +                                         MAX77650_GPIO_DRV_MASK,
> +                                         MAX77650_GPIO_DRV_OPEN_DRAIN);
> +       case PIN_CONFIG_DRIVE_PUSH_PULL:
> +               return regmap_update_bits(chip->map,
> +                                         MAX77650_REG_CNFG_GPIO,
> +                                         MAX77650_GPIO_DRV_MASK,
> +                                         MAX77650_GPIO_DRV_PUSH_PULL);
> +       case PIN_CONFIG_INPUT_DEBOUNCE:
> +               return regmap_update_bits(chip->map,
> +                                         MAX77650_REG_CNFG_GPIO,
> +                                         MAX77650_GPIO_DEBOUNCE_MASK,
> +                                         MAX77650_GPIO_DEBOUNCE);
> +       default:
> +               return -ENOTSUPP;
> +       }
> +}
> +
> +static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int offse=
t)
> +{
> +       /*
> +        * TODO Add interrupt support.
> +        *
> +        * We first need to properly support hierarchical irqs in gpiolib
> +        * and regmap irq_chip.
> +        */
> +       return -EOPNOTSUPP;
> +}
> +
> +static int max77650_gpio_probe(struct platform_device *pdev)
> +{
> +       struct max77650_gpio_chip *chip;
> +       struct device *dev, *parent;
> +       struct i2c_client *i2c;
> +
> +       dev =3D &pdev->dev;
> +       parent =3D dev->parent;
> +       i2c =3D to_i2c_client(parent);
> +
> +       chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +       if (!chip)
> +               return -ENOMEM;
> +
> +       chip->map =3D dev_get_regmap(parent, NULL);
> +       if (!chip->map)
> +               return -ENODEV;
> +
> +       chip->gc.base =3D -1;
> +       chip->gc.ngpio =3D 1;
> +       chip->gc.label =3D i2c->name;
> +       chip->gc.parent =3D dev;
> +       chip->gc.owner =3D THIS_MODULE;
> +       chip->gc.can_sleep =3D true;
> +
> +       chip->gc.direction_input =3D max77650_gpio_direction_input;
> +       chip->gc.direction_output =3D max77650_gpio_direction_output;
> +       chip->gc.set =3D max77650_gpio_set_value;
> +       chip->gc.get =3D max77650_gpio_get_value;
> +       chip->gc.get_direction =3D max77650_gpio_get_direction;
> +       chip->gc.set_config =3D max77650_gpio_set_config;
> +       chip->gc.to_irq =3D max77650_gpio_to_irq;
> +
> +       return devm_gpiochip_add_data(dev, &chip->gc, chip);
> +}
> +
> +static struct platform_driver max77650_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "max77650-gpio",
> +       },
> +       .probe =3D max77650_gpio_probe,
> +};
> +module_platform_driver(max77650_gpio_driver);
> +
> +MODULE_DESCRIPTION("MAXIM 77650/77651 GPIO driver");
> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.20.1
>

I forgot to collect the tag, but Linus left his Reviewed-by:.

Bart
