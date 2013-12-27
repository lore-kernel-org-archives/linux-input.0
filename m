From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [v2] input: Add new driver for GPIO beeper
Date: Fri, 27 Dec 2013 04:33:51 +0100
Message-ID: <20131227033351.GA8515@lunn.ch>
References: <1385373787-15668-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42569 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754127Ab3L0Deq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Dec 2013 22:34:46 -0500
Content-Disposition: inline
In-Reply-To: <1385373787-15668-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>

On Mon, Nov 25, 2013 at 02:03:07PM +0400, Alexander Shiyan wrote:
> This patch adds a new driver for the beeper controlled via GPIO pin.
> The driver does not depend on the architecture and is positioned as
> a replacement for the specific drivers that are used for this function.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Hi Alexander

I just tried this driver out on a board port i will soon be
contributing. Works for me. Please add a

Tested-by: Andrew Lunn <andrew@lunn.ch>

Has the Input maintainer picked it up for the next merge window?

Thanks
	Andrew

> 
> ---
> .../devicetree/bindings/input/gpio-beeper.txt      |  13 +++
>  drivers/input/misc/Kconfig                         |   9 ++
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/gpio-beeper.c                   | 127 +++++++++++++++++++++
>  4 files changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-beeper.txt
>  create mode 100644 drivers/input/misc/gpio-beeper.c
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-beeper.txt b/Documentation/devicetree/bindings/input/gpio-beeper.txt
> new file mode 100644
> index 0000000..a5086e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-beeper.txt
> @@ -0,0 +1,13 @@
> +* GPIO beeper device tree bindings
> +
> +Register a beeper connected to GPIO pin.
> +
> +Required properties:
> +- compatible:	Should be "gpio-beeper".
> +- gpios:	From common gpio binding; gpio connection to beeper enable pin.
> +
> +Example:
> +	beeper: beeper {
> +		compatible = "gpio-beeper";
> +		gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
> +	};
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 5f4967d..4ffc397 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -222,6 +222,15 @@ config INPUT_GP2A
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called gp2ap002a00f.
>  
> +config INPUT_GPIO_BEEPER
> +	tristate "Generic GPIO Beeper support"
> +	depends on OF_GPIO
> +	help
> +	  Say Y here if you have a beeper connected to a GPIO pin.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gpio-beeper.
> +
>  config INPUT_GPIO_TILT_POLLED
>  	tristate "Polled GPIO tilt switch"
>  	depends on GPIOLIB
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 0ebfb6d..cda71fc 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
>  obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
>  obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
> +obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
>  obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
>  obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
>  obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
> diff --git a/drivers/input/misc/gpio-beeper.c b/drivers/input/misc/gpio-beeper.c
> new file mode 100644
> index 0000000..cc81e6e
> --- /dev/null
> +++ b/drivers/input/misc/gpio-beeper.c
> @@ -0,0 +1,127 @@
> +/*
> + *  Generic GPIO beeper driver
> + *
> + *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/workqueue.h>
> +#include <linux/platform_device.h>
> +
> +#define BEEPER_MODNAME		"gpio-beeper"
> +
> +struct gpio_beeper {
> +	struct work_struct	work;
> +	int			gpio;
> +	bool			active_low;
> +	bool			beeping;
> +};
> +
> +static void gpio_beeper_toggle(struct gpio_beeper *beep, bool on)
> +{
> +	gpio_set_value_cansleep(beep->gpio, on ^ beep->active_low);
> +}
> +
> +static void gpio_beeper_work(struct work_struct *work)
> +{
> +	struct gpio_beeper *beep = container_of(work, struct gpio_beeper, work);
> +
> +	gpio_beeper_toggle(beep, beep->beeping);
> +}
> +
> +static int gpio_beeper_event(struct input_dev *dev, unsigned int type,
> +			     unsigned int code, int value)
> +{
> +	struct gpio_beeper *beep = input_get_drvdata(dev);
> +
> +	if (type != EV_SND || code != SND_BELL)
> +		return -ENOTSUPP;
> +
> +	if (value < 0)
> +		return -EINVAL;
> +
> +	beep->beeping = value;
> +	/* Schedule work to actually turn the beeper on or off */
> +	schedule_work(&beep->work);
> +
> +	return 0;
> +}
> +
> +static void gpio_beeper_close(struct input_dev *input)
> +{
> +	struct gpio_beeper *beep = input_get_drvdata(input);
> +
> +	cancel_work_sync(&beep->work);
> +	gpio_beeper_toggle(beep, false);
> +}
> +
> +static int gpio_beeper_probe(struct platform_device *pdev)
> +{
> +	struct gpio_beeper *beep;
> +	enum of_gpio_flags flags;
> +	struct input_dev *input;
> +	unsigned long gflags;
> +	int err;
> +
> +	beep = devm_kzalloc(&pdev->dev, sizeof(*beep), GFP_KERNEL);
> +	if (!beep)
> +		return -ENOMEM;
> +
> +	beep->gpio = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
> +	if (!gpio_is_valid(beep->gpio))
> +		return beep->gpio;
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&beep->work, gpio_beeper_work);
> +
> +	input->name		= pdev->name;
> +	input->id.bustype	= BUS_HOST;
> +	input->id.vendor	= 0x0001;
> +	input->id.product	= 0x0001;
> +	input->id.version	= 0x0100;
> +	input->close		= gpio_beeper_close;
> +	input->event		= gpio_beeper_event;
> +
> +	input_set_capability(input, EV_SND, SND_BELL);
> +
> +	beep->active_low = flags & OF_GPIO_ACTIVE_LOW;
> +	gflags = beep->active_low ? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
> +
> +	err = devm_gpio_request_one(&pdev->dev, beep->gpio, gflags, pdev->name);
> +	if (err)
> +		return err;
> +
> +	input_set_drvdata(input, beep);
> +
> +	return input_register_device(input);
> +}
> +
> +static struct of_device_id gpio_beeper_of_match[] = {
> +	{ .compatible = BEEPER_MODNAME, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gpio_beeper_of_match);
> +
> +static struct platform_driver gpio_beeper_platform_driver = {
> +	.driver	= {
> +		.name		= BEEPER_MODNAME,
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= gpio_beeper_of_match,
> +	},
> +	.probe	= gpio_beeper_probe,
> +};
> +module_platform_driver(gpio_beeper_platform_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
> +MODULE_DESCRIPTION("Generic GPIO beeper driver");
