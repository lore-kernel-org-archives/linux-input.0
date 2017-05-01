From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: keyboard: Add D-Link DIR-685 touchpad driver
Date: Mon, 1 May 2017 09:53:09 -0700
Message-ID: <20170501165309.GA7851@dtor-ws>
References: <20170430205937.29877-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36321 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbdEAQxM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 1 May 2017 12:53:12 -0400
Received: by mail-pf0-f195.google.com with SMTP id v14so28442014pfd.3
        for <linux-input@vger.kernel.org>; Mon, 01 May 2017 09:53:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170430205937.29877-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org

Hi Linus,

On Sun, Apr 30, 2017 at 10:59:37PM +0200, Linus Walleij wrote:
> This adds support for the D-Link DIR-685 touchpad found in the
> router with this name.

Routers have touchpads now? Wow...

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  MAINTAINERS                                    |   6 +
>  drivers/input/keyboard/Kconfig                 |  12 ++
>  drivers/input/keyboard/Makefile                |   1 +
>  drivers/input/keyboard/dlink-dir685-touchpad.c | 181 +++++++++++++++++++++++++

Why does it live in "keyboard" and not in "mouse" with other touchpads?
Ah, this is not really a touchpad in regular meaning, it is something we
usually call touchkeys. So yeah, could be either keyboard or misc, but
please adjust the name.

>  4 files changed, 200 insertions(+)
>  create mode 100644 drivers/input/keyboard/dlink-dir685-touchpad.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c265a5fe4848..95ef13b4ae71 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3730,6 +3730,12 @@ S:	Supported
>  F:	drivers/input/touchscreen/cyttsp*
>  F:	include/linux/input/cyttsp.h
>  
> +D-LINK DIR-685 TOUCHPAD DRIVER
> +M:	Linus Walleij <linus.walleij@linaro.org>
> +L:	linux-input@vger.kernel.org
> +S:	Supported
> +F:	drivers/input/dlink-dir685-touchpad.c

Wrong path in any case.

> +
>  DALLAS/MAXIM DS1685-FAMILY REAL TIME CLOCK
>  M:	Joshua Kinard <kumba@gentoo.org>
>  S:	Maintained
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 97acd6524ad7..06b19aa7cdf5 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -178,6 +178,18 @@ config KEYBOARD_CLPS711X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called clps711x-keypad.
>  
> +config KEYBOARD_DLINK_DIR685
> +	tristate "D-Link DIR-685 touchpad support"
> +	depends on I2C
> +	depends on OF

Does it have to be OF? Can we use generic device properties? Actually it
doe snot even use OF properties... So let's drop dependence on OF.

> +	default ARCH_GEMINI
> +	help
> +	  If you say yes here you get support for the D-Link DIR-685
> +	  touchpad.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called dlink-dir685-touchpad.
> +
>  config KEYBOARD_LKKBD
>  	tristate "DECstation/VAXstation LK201/LK401 keyboard"
>  	select SERIO
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 7d9acff819a7..11c1fb5f2426 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_KEYBOARD_CAP11XX)		+= cap11xx.o
>  obj-$(CONFIG_KEYBOARD_CLPS711X)		+= clps711x-keypad.o
>  obj-$(CONFIG_KEYBOARD_CROS_EC)		+= cros_ec_keyb.o
>  obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
> +obj-$(CONFIG_KEYBOARD_DLINK_DIR685)	+= dlink-dir685-touchpad.o
>  obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
>  obj-$(CONFIG_KEYBOARD_GOLDFISH_EVENTS)	+= goldfish_events.o
>  obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
> diff --git a/drivers/input/keyboard/dlink-dir685-touchpad.c b/drivers/input/keyboard/dlink-dir685-touchpad.c
> new file mode 100644
> index 000000000000..559e7e9a9340
> --- /dev/null
> +++ b/drivers/input/keyboard/dlink-dir685-touchpad.c
> @@ -0,0 +1,181 @@
> +/*
> + * D-Link DIR-685 router I2C-based Touchpad input driver
> + * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
> + *
> + * This is a one-off touchpad controller based on the Cypress Semiconductor
> + * CY8C214 MCU with some firmware in its internal 8KB flash. The circuit
> + * board inside the router is named E119921
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>

Why do you need mutex.h?

And I think you need bitops.h.

> +#include <linux/delay.h>
> +#include <linux/input.h>
> +#include <linux/slab.h>
> +
> +struct dir685_touchpad {
> +	struct device		*dev;
> +	struct i2c_client	*client;
> +	struct input_dev	*input;
> +	unsigned long		cur_key;
> +	u16 *codes;

The keycode array is tiny, why not embed it into dir685_touchpad instead
of allocating separately?

> +};
> +
> +static const u16 dir685_tp_keycodes[] = {
> +	KEY_UP,
> +	KEY_DOWN,
> +	KEY_LEFT,
> +	KEY_RIGHT,
> +	KEY_ENTER,
> +	KEY_W,
> +	KEY_O,
> +};
> +
> +static irqreturn_t dir685_tp_irq_thread(int irq, void *data)
> +{
> +	struct dir685_touchpad *tp = data;
> +	u8 buf[6];
> +	unsigned long key;
> +	int i;
> +	int ret;
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = i2c_master_recv(tp->client, buf, sizeof(buf));
> +	if (ret != sizeof(buf)) {
> +		dev_err(tp->dev, "short read %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	dev_dbg(tp->dev, "IN: %02x, %02x, %02x, %02x, %02x, %02x\n",
> +		buf[0], buf[1], buf[2], buf[3], buf[4], buf[5]);

	dev_dbg(tp->dev, "IN: %6ph\n", buf);

> +	key  = buf[4] << 8 | buf[5];
> +
> +	/* Figure out if any bits went high since last message */
> +	for_each_set_bit(i, &key, 16) {
> +		if (!(tp->cur_key & BIT(i))) {
> +			dev_dbg(tp->dev, "key %d down\n", i);
> +			if (i < ARRAY_SIZE(dir685_tp_keycodes)) {
> +				input_report_key(tp->input,
> +						 tp->codes[i], 1);
> +			}
> +		}
> +	}
> +	/* Figure out if any bits went low since last message */
> +	for_each_set_bit(i, &tp->cur_key, 16) {
> +		if (!(key & BIT(i))) {
> +			dev_dbg(tp->dev, "key %d up\n", i);
> +			if (i < ARRAY_SIZE(dir685_tp_keycodes)) {
> +				input_report_key(tp->input,
> +						 tp->codes[i], 0);
> +			}
> +		}
> +	}

Hmm, that's a bit too verbose. I think want you want is:

	const int num_bits = min_t(int, ARRAY_SIZE(dir685_tp_keycodes), 16);

	...

	key = le16_to_cpup((__le16 *)&buf[4]);
	changed = tp->cur_key ^ key;

	for_each_set_bit(i, &changed, num_bits) {
		dev_dbg(tp->dev, "key %d is %s\n",
			i, test_bit(i, &key) ? "up" : "down");
		input_report_key(tp->input, tp->codes[i],
				 test_bit(i, &key));
	}

> +
> +	/* Store currently down keys */
> +	tp->cur_key = key;
> +	input_sync(tp->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int dir685_tp_probe(struct i2c_client *client,
> +				 const struct i2c_device_id *id)
> +{
> +	struct dir685_touchpad *tp;
> +	struct device *dev = &client->dev;
> +	u8 bl_data[] = { 0xa7, 0x40 };
> +	int ret;

Call it "err" or "error", pretty please.

> +	int i;
> +
> +	tp = devm_kzalloc(&client->dev, sizeof(*tp), GFP_KERNEL);
> +	if (!tp)
> +		return -ENOMEM;
> +
> +	tp->input = devm_input_allocate_device(dev);
> +	if (!tp->input)
> +		return -ENOMEM;
> +
> +	tp->client = client;
> +	tp->dev = dev;
> +
> +	tp->input->keycodesize = sizeof(dir685_tp_keycodes[0]);
> +	tp->input->keycodemax = ARRAY_SIZE(dir685_tp_keycodes);
> +	tp->codes = devm_kmemdup(dev, dir685_tp_keycodes,
> +			   tp->input->keycodesize * tp->input->keycodemax,
> +			   GFP_KERNEL);

As I mentioned, I'd embed the keymap into dir685_touchpad.

> +	tp->input->keycode = tp->codes;
> +
> +	__set_bit(EV_KEY, tp->input->evbit);
> +	for (i = 0; i < ARRAY_SIZE(dir685_tp_keycodes); i++)
> +		__set_bit(dir685_tp_keycodes[i], tp->input->keybit);
> +
> +	tp->input->name = "D-Link DIR-685 touchpad";
> +	input_set_drvdata(tp->input, tp);
> +
> +	ret = input_register_device(tp->input);
> +	if (ret)
> +		return ret;
> +
> +	/* Set up the brightness to max level */
> +	ret = i2c_master_send(client, bl_data, sizeof(bl_data));
> +	if (ret != sizeof(bl_data))
> +		dev_err(tp->dev, "error setting up brightness level\n");

dev_warn() since you do not abort probe.

> +
> +	if (!client->irq) {
> +		dev_err(dev, "no IRQ on the I2C device\n");
> +		return -ENODEV;
> +	}
> +	ret = request_threaded_irq(client->irq, NULL,
> +				   dir685_tp_irq_thread,
> +				   IRQF_ONESHOT,
> +				   "dir685-tp",
> +				   tp);

devm_request_threaded_irq() so you do not need free_irq() in remove.

> +	if (ret) {
> +		dev_err(dev, "can't request IRQ\n");
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, tp);
> +
> +	dev_info(tp->dev, "registered D-Link DIR-685 touchpad\n");

Please drop.

> +	return 0;
> +}
> +
> +static int dir685_tp_remove(struct i2c_client *client)
> +{
> +	struct dir685_touchpad *tp = i2c_get_clientdata(client);
> +
> +	input_unregister_device(tp->input);

Not needed: you used devm_input_allocate_device(). In fact, you can drop
the whole method.

> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id dir685_tp_id[] = {
> +	{ "dir685tp", 0 },
> +	{ }
> +};
> +
> +static const struct of_device_id dir685_tp_of_match[] = {
> +	{ .compatible = "dlink,dir685-touchpad" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dir685_tp_of_match);
> +
> +static struct i2c_driver dir685_tp_i2c_driver = {
> +	.driver = {
> +		.name	= "dlin-dir685-touchpad",
> +		.of_match_table = of_match_ptr(dir685_tp_of_match),
> +	},
> +	.probe		= dir685_tp_probe,
> +	.remove		= dir685_tp_remove,
> +	.id_table	= dir685_tp_id,
> +};
> +MODULE_DEVICE_TABLE(i2c, dir685_tp_id);
> +
> +module_i2c_driver(dir685_tp_i2c_driver);
> +
> +MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> +MODULE_DESCRIPTION("D-Link DIR-685 touchpad driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.9.3
> 

Thanks.

-- 
Dmitry
