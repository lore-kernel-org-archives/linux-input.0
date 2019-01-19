From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 12/13] input: max77650: add onkey support
Date: Sat, 19 Jan 2019 01:03:18 -0800
Message-ID: <20190119090318.GB187380@dtor-ws>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-13-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118134244.22253-13-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

Hi Bartosz,

On Fri, Jan 18, 2019 at 02:42:43PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add support for the push- and slide-button events for max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/input/misc/Kconfig          |   9 ++
>  drivers/input/misc/Makefile         |   1 +
>  drivers/input/misc/max77650-onkey.c | 135 ++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 drivers/input/misc/max77650-onkey.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ca59a2be9bc5..bb9c45c1269e 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -180,6 +180,15 @@ config INPUT_M68K_BEEP
>  	tristate "M68k Beeper support"
>  	depends on M68K
>  
> +config INPUT_MAX77650_ONKEY
> +	tristate "Maxim MAX77650 ONKEY support"
> +	depends on MFD_MAX77650
> +	help
> +	  Support the ONKEY of the MAX77650 PMIC as an input device.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called max77650-onkey.
> +
>  config INPUT_MAX77693_HAPTIC
>  	tristate "MAXIM MAX77693/MAX77843 haptic controller support"
>  	depends on (MFD_MAX77693 || MFD_MAX77843) && PWM
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 9d0f9d1ff68f..5bd53590ce60 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
>  obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
>  obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
>  obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
> +obj-$(CONFIG_INPUT_MAX77650_ONKEY)	+= max77650-onkey.o
>  obj-$(CONFIG_INPUT_MAX77693_HAPTIC)	+= max77693-haptic.o
>  obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
>  obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+= max8997_haptic.o
> diff --git a/drivers/input/misc/max77650-onkey.c b/drivers/input/misc/max77650-onkey.c
> new file mode 100644
> index 000000000000..cc7e83f589cd
> --- /dev/null
> +++ b/drivers/input/misc/max77650-onkey.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 BayLibre SAS
> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> + *
> + * ONKEY driver for MAXIM 77650/77651 charger/power-supply.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max77650.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define MAX77650_ONKEY_MODE_MASK	BIT(3)
> +#define MAX77650_ONKEY_MODE_PUSH	0x00
> +#define MAX77650_ONKEY_MODE_SLIDE	BIT(3)
> +
> +struct max77650_onkey {
> +	struct input_dev *input;
> +	unsigned int code;
> +};
> +
> +static irqreturn_t
> +max77650_onkey_report(struct max77650_onkey *onkey, int value)
> +{
> +	input_report_key(onkey->input, onkey->code, value);
> +	input_sync(onkey->input);
> +
> +	return IRQ_HANDLED;

It is weird that report function returns irqreturn_t. I'd simply moved
input_report_key()/input_sync() into real IRQ handlers.

> +}
> +
> +static irqreturn_t max77650_onkey_falling(int irq, void *data)
> +{
> +	struct max77650_onkey *onkey = data;
> +
> +	return max77650_onkey_report(onkey, 0);
> +}
> +
> +static irqreturn_t max77650_onkey_rising(int irq, void *data)
> +{
> +	struct max77650_onkey *onkey = data;
> +
> +	return max77650_onkey_report(onkey, 1);
> +}
> +
> +static int max77650_onkey_probe(struct platform_device *pdev)
> +{
> +	struct regmap_irq_chip_data *irq_data;
> +	struct max77650_onkey *onkey;
> +	struct device *dev, *parent;
> +	int irq_r, irq_f, rv, mode;

Please call "rv" "error".

> +	struct i2c_client *i2c;
> +	const char *mode_prop;
> +	struct regmap *map;
> +
> +	dev = &pdev->dev;
> +	parent = dev->parent;
> +	i2c = to_i2c_client(parent);
> +	irq_data = i2c_get_clientdata(i2c);
> +
> +	map = dev_get_regmap(parent, NULL);
> +	if (!map)
> +		return -ENODEV;
> +
> +	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
> +	if (!onkey)
> +		return -ENOMEM;
> +
> +	rv = device_property_read_u32(dev, "linux,code", &onkey->code);
> +	if (rv)
> +		onkey->code = KEY_POWER;
> +
> +	rv = device_property_read_string(dev, "maxim,onkey-mode", &mode_prop);
> +	if (rv)
> +		mode_prop = "push";
> +
> +	if (strcmp(mode_prop, "push") == 0)
> +		mode = MAX77650_ONKEY_MODE_PUSH;
> +	else if (strcmp(mode_prop, "slide") == 0)
> +		mode = MAX77650_ONKEY_MODE_SLIDE;
> +	else
> +		return -EINVAL;
> +
> +	rv = regmap_update_bits(map, MAX77650_REG_CNFG_GLBL,
> +				MAX77650_ONKEY_MODE_MASK, mode);
> +	if (rv)
> +		return rv;
> +
> +	irq_f = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_F);
> +	if (irq_f <= 0)
> +		return -EINVAL;
> +
> +	irq_r = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_R);
> +	if (irq_r <= 0)
> +		return -EINVAL;

Ugh, it would be better if you handled IRQ mapping in the MFD piece and
passed it as resources of platform device. Then you'd simply call
platform_get_irq() here and did not have to reach into parent device for
"irq_dara".

> +
> +	onkey->input = devm_input_allocate_device(dev);
> +	if (!onkey->input)
> +		return -ENOMEM;
> +
> +	onkey->input->name = "max77650_onkey";
> +	onkey->input->phys = "max77650_onkey/input0";
> +	onkey->input->id.bustype = BUS_I2C;
> +	onkey->input->dev.parent = dev;

Not needed since devm_input_allocate_device sets parent for you.

> +	input_set_capability(onkey->input, EV_KEY, onkey->code);
> +
> +	rv = devm_request_threaded_irq(dev, irq_f, NULL,

Why threaded interrupt with only hard interrupt handler? If parent
interrupt is threaded use "any_context_irq" here.

> +				       max77650_onkey_falling,
> +				       IRQF_ONESHOT, "onkey-down", onkey);

Why do you need oneshot with interrupt that is essentially not threaded?

> +	if (rv)
> +		return rv;
> +
> +	rv = devm_request_threaded_irq(dev, irq_r, NULL,
> +				       max77650_onkey_rising,
> +				       IRQF_ONESHOT, "onkey-up", onkey);
> +	if (rv)
> +		return rv;
> +
> +	return input_register_device(onkey->input);
> +}
> +
> +static struct platform_driver max77650_onkey_driver = {
> +	.driver = {
> +		.name = "max77650-onkey",
> +	},
> +	.probe = max77650_onkey_probe,
> +};
> +module_platform_driver(max77650_onkey_driver);
> +
> +MODULE_DESCRIPTION("MAXIM 77650/77651 ONKEY driver");
> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> +MODULE_LICENSE("GPL");

SPDX header say GPL-2.0 so please "GPL v2" here as "GPL" means v2 and
later.

Thanks.

-- 
Dmitry
