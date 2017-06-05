From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v3] input: keyboard: Add D-Link DIR-685 touchkeys
 driver
Date: Mon, 5 Jun 2017 15:12:47 -0700
Message-ID: <20170605221247.GA29061@dtor-ws>
References: <20170530120918.27357-1-linus.walleij@linaro.org>
 <20170530120918.27357-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34503 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEWMv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Jun 2017 18:12:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id v14so7354053pgn.1
        for <linux-input@vger.kernel.org>; Mon, 05 Jun 2017 15:12:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170530120918.27357-2-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org

Hi Linus,

On Tue, May 30, 2017 at 02:09:18PM +0200, Linus Walleij wrote:
> This adds support for the D-Link DIR-685 touchkeys found in the
> router with this name.
> 
> The vendor code calles this a "touchpad" but we are registering
> it here under its real name.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Switch "KEY_W" to "KEY_WPS_BUTTON" as apropriate.
> - Add comment about the mysterious "KEY_O".
> ChangeLog v1->v2:
> - Change the whole touchpad->touchkey naming scheme, even in
>   the device tree bindings.
> - Embedd the keycodes directly into the state container and
>   open code the key assignments.
> - Use Dmitry's suggested XOR loop to detect key state changes.
> - Drop <linux/mutex.h> add <linux/bitops.h>
> - Drop dependency on the OF config symbol.
> - Rename all "ret" to "err".
> - Drop driver dev_info() announcement.
> ---
>  MAINTAINERS                                     |   6 +
>  drivers/input/keyboard/Kconfig                  |  11 ++
>  drivers/input/keyboard/Makefile                 |   1 +
>  drivers/input/keyboard/dlink-dir685-touchkeys.c | 157 ++++++++++++++++++++++++
>  4 files changed, 175 insertions(+)
>  create mode 100644 drivers/input/keyboard/dlink-dir685-touchkeys.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96753be12026..eea776eec996 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3779,6 +3779,12 @@ S:	Supported
>  F:	drivers/input/touchscreen/cyttsp*
>  F:	include/linux/input/cyttsp.h
>  
> +D-LINK DIR-685 TOUCHKEYS DRIVER
> +M:	Linus Walleij <linus.walleij@linaro.org>
> +L:	linux-input@vger.kernel.org
> +S:	Supported
> +F:	drivers/input/dlink-dir685-touchkeys.c
> +
>  DALLAS/MAXIM DS1685-FAMILY REAL TIME CLOCK
>  M:	Joshua Kinard <kumba@gentoo.org>
>  S:	Maintained
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 97acd6524ad7..4c4ab1ced235 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -178,6 +178,17 @@ config KEYBOARD_CLPS711X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called clps711x-keypad.
>  
> +config KEYBOARD_DLINK_DIR685
> +	tristate "D-Link DIR-685 touchkeys support"
> +	depends on I2C
> +	default ARCH_GEMINI
> +	help
> +	  If you say yes here you get support for the D-Link DIR-685
> +	  touchkeys.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called dlink-dir685-touchkeys.
> +
>  config KEYBOARD_LKKBD
>  	tristate "DECstation/VAXstation LK201/LK401 keyboard"
>  	select SERIO
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 7d9acff819a7..d2338bacdad1 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_KEYBOARD_CAP11XX)		+= cap11xx.o
>  obj-$(CONFIG_KEYBOARD_CLPS711X)		+= clps711x-keypad.o
>  obj-$(CONFIG_KEYBOARD_CROS_EC)		+= cros_ec_keyb.o
>  obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
> +obj-$(CONFIG_KEYBOARD_DLINK_DIR685)	+= dlink-dir685-touchkeys.o
>  obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
>  obj-$(CONFIG_KEYBOARD_GOLDFISH_EVENTS)	+= goldfish_events.o
>  obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
> diff --git a/drivers/input/keyboard/dlink-dir685-touchkeys.c b/drivers/input/keyboard/dlink-dir685-touchkeys.c
> new file mode 100644
> index 000000000000..6d6f60963e3c
> --- /dev/null
> +++ b/drivers/input/keyboard/dlink-dir685-touchkeys.c
> @@ -0,0 +1,157 @@
> +/*
> + * D-Link DIR-685 router I2C-based Touchkeys input driver
> + * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
> + *
> + * This is a one-off touchkey controller based on the Cypress Semiconductor
> + * CY8C214 MCU with some firmware in its internal 8KB flash. The circuit
> + * board inside the router is named E119921
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/input.h>
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +
> +struct dir685_touchkeys {
> +	struct device		*dev;
> +	struct i2c_client	*client;
> +	struct input_dev	*input;
> +	unsigned long		cur_key;
> +	u16			codes[7];
> +};
> +
> +static irqreturn_t dir685_tk_irq_thread(int irq, void *data)
> +{
> +	struct dir685_touchkeys *tk = data;
> +	const int num_bits = min_t(int, ARRAY_SIZE(tk->codes), 16);
> +	unsigned long changed;
> +	u8 buf[6];
> +	unsigned long key;
> +	int i;
> +	int err;
> +
> +	memset(buf, 0, sizeof(buf));
> +	err = i2c_master_recv(tk->client, buf, sizeof(buf));
> +	if (err != sizeof(buf)) {
> +		dev_err(tk->dev, "short read %d\n", err);
> +		return IRQ_HANDLED;
> +	}
> +
> +	dev_dbg(tk->dev, "IN: %02x, %02x, %02x, %02x, %02x, %02x\n",
> +		buf[0], buf[1], buf[2], buf[3], buf[4], buf[5]);

I changed this to

	dev_dbg(tk->dev, "IN: %*ph\n", (int)sizeof(buf), buf);

> +	key = be16_to_cpup((__le16 *) &buf[4]);

Changed __le16 to __be16 as I assume the conversion was right, just the
annotation wrong.

> +
> +	/* Figure out if any bits went high or low since last message */
> +	changed = tk->cur_key ^ key;
> +	for_each_set_bit(i, &changed, num_bits) {
> +		dev_dbg(tk->dev, "key %d is %s\n", i,
> +			test_bit(i, &key) ? "down" : "up");
> +		input_report_key(tk->input, tk->codes[i], test_bit(i, &key));
> +	}
> +
> +	/* Store currently down keys */
> +	tk->cur_key = key;
> +	input_sync(tk->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int dir685_tk_probe(struct i2c_client *client,
> +				 const struct i2c_device_id *id)
> +{
> +	struct dir685_touchkeys *tk;
> +	struct device *dev = &client->dev;
> +	u8 bl_data[] = { 0xa7, 0x40 };
> +	int err;
> +	int i;
> +
> +	tk = devm_kzalloc(&client->dev, sizeof(*tk), GFP_KERNEL);
> +	if (!tk)
> +		return -ENOMEM;
> +
> +	tk->input = devm_input_allocate_device(dev);
> +	if (!tk->input)
> +		return -ENOMEM;
> +
> +	tk->client = client;
> +	tk->dev = dev;
> +
> +	tk->input->keycodesize = sizeof(u16);
> +	tk->input->keycodemax = ARRAY_SIZE(tk->codes);
> +	tk->input->keycode = tk->codes;
> +	tk->codes[0] = KEY_UP;
> +	tk->codes[1] = KEY_DOWN;
> +	tk->codes[2] = KEY_LEFT;
> +	tk->codes[3] = KEY_RIGHT;
> +	tk->codes[4] = KEY_ENTER;
> +	tk->codes[5] = KEY_WPS_BUTTON;
> +	/*
> +	 * This key appears in the vendor driver, but I have
> +	 * not been able to provoke it.
> +	 */
> +	tk->codes[6] = KEY_O;

As we have discussed, I changed this to KEY_RESERVED.

> +
> +	__set_bit(EV_KEY, tk->input->evbit);
> +	for (i = 0; i < ARRAY_SIZE(tk->codes); i++)
> +		__set_bit(tk->codes[i], tk->input->keybit);
> +
> +	tk->input->name = "D-Link DIR-685 touchkeys";
> +	input_set_drvdata(tk->input, tk);

Dropped as noone is using it at the moment. Added instead:

	tk->input->id.bustype = BUS_I2C;

> +
> +	err = input_register_device(tk->input);
> +	if (err)
> +		return err;
> +
> +	/* Set up the brightness to max level */
> +	err = i2c_master_send(client, bl_data, sizeof(bl_data));
> +	if (err != sizeof(bl_data))
> +		dev_warn(tk->dev, "error setting up brightness level\n");
> +
> +	if (!client->irq) {
> +		dev_err(dev, "no IRQ on the I2C device\n");
> +		return -ENODEV;
> +	}
> +	err = devm_request_threaded_irq(dev, client->irq, NULL,
> +				   dir685_tk_irq_thread,
> +				   IRQF_ONESHOT,
> +				   "dir685-tk",
> +				   tk);
> +	if (err) {
> +		dev_err(dev, "can't request IRQ\n");
> +		return err;
> +	}
> +
> +	i2c_set_clientdata(client, tk);

Dropped as noone is using it at the moment.

> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id dir685_tk_id[] = {
> +	{ "dir685tk", 0 },
> +	{ }
> +};
> +
> +static const struct of_device_id dir685_tk_of_match[] = {
> +	{ .compatible = "dlink,dir685-touchkeys" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dir685_tk_of_match);
> +
> +static struct i2c_driver dir685_tk_i2c_driver = {
> +	.driver = {
> +		.name	= "dlin-dir685-touchkeys",
> +		.of_match_table = of_match_ptr(dir685_tk_of_match),
> +	},
> +	.probe		= dir685_tk_probe,
> +	.id_table	= dir685_tk_id,
> +};
> +MODULE_DEVICE_TABLE(i2c, dir685_tk_id);
> +
> +module_i2c_driver(dir685_tk_i2c_driver);
> +
> +MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> +MODULE_DESCRIPTION("D-Link DIR-685 touchkeys driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.9.4
> 

Thanks.

-- 
Dmitry
