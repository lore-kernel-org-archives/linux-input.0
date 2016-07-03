From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] input: add ADC resistor ladder driver
Date: Sun, 3 Jul 2016 14:50:01 +0100
Message-ID: <b02c99a8-52d8-cb66-7cc9-3ff8dd1c9426@kernel.org>
References: <1467408602-16546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1467408602-16546-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467408602-16546-2-git-send-email-alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 01/07/16 22:30, Alexandre Belloni wrote:
> A common way of multiplexing buttons on a single input in cheap devices is
> to use a resistor ladder on an ADC. This driver supports that configuration
> by polling an ADC channel provided by IIO.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
I like this a lot.  It's small elegant and does what it says on the tin.

Even when we do extend IIO to output threshold events, we'll still want the
polled version as there are plenty of ADCs out there without threshold
interrupts.

Next step add the iio event push support needed to interrupt drive this.
*cross fingers* :)

We may also want to do a full pushed mode at some point for self clocking
/ hardware sequencer equiped ADCs.  Easy enough to add when someone wants
it.

Jonathan
> ---
>  drivers/input/keyboard/Kconfig    |  15 +++
>  drivers/input/keyboard/Makefile   |   1 +
>  drivers/input/keyboard/adc-keys.c | 209 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 225 insertions(+)
>  create mode 100644 drivers/input/keyboard/adc-keys.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 509608c95994..ba20808f31e0 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -12,6 +12,21 @@ menuconfig INPUT_KEYBOARD
>  
>  if INPUT_KEYBOARD
>  
> +config KEYBOARD_ADC
> +	tristate "ADC ladder Buttons"
> +	depends on IIO || COMPILE_TEST
> +	select INPUT_POLLDEV
> +	help
> +	  This driver implements support for buttons connected
> +	  to an ADC using a resistor ladder.
> +
> +	  Say Y here if your device has such buttons connected to an ADC.  Your
> +	  board-specific setup logic must also provide a configuration data
> +	  saying mapping voltages to buttons.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adc_keys.
> +
>  config KEYBOARD_ADP5520
>  	tristate "Keypad Support for ADP5520 PMIC"
>  	depends on PMIC_ADP5520
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 1d416ddf84e4..d9f4cfcf3410 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -4,6 +4,7 @@
>  
>  # Each configuration option enables a list of files.
>  
> +obj-$(CONFIG_KEYBOARD_ADC)		+= adc-keys.o
>  obj-$(CONFIG_KEYBOARD_ADP5520)		+= adp5520-keys.o
>  obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
>  obj-$(CONFIG_KEYBOARD_ADP5589)		+= adp5589-keys.o
> diff --git a/drivers/input/keyboard/adc-keys.c b/drivers/input/keyboard/adc-keys.c
> new file mode 100644
> index 000000000000..ba6ee91272b2
> --- /dev/null
> +++ b/drivers/input/keyboard/adc-keys.c
> @@ -0,0 +1,209 @@
> +/* Input driver for resistor ladder connected on ADC
> + *
> + * Copyright (c) 2016 Alexandre Belloni
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/input.h>
> +#include <linux/input-polldev.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/types.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +
> +struct adc_keys_button {
> +	u32 voltage;
> +	u32 keycode;
> +};
> +
> +struct adc_keys_state {
> +	struct iio_channel *channel;
> +	u32 num_keys;
> +	u32 last_key;
> +	u32 keyup_voltage;
> +	struct adc_keys_button *map;
> +};
> +
> +static void adc_keys_poll(struct input_polled_dev *dev)
> +{
> +	struct adc_keys_state *st = dev->private;
> +	int i, value, ret;
> +	u32 diff, closest = 0xffffffff;
> +	int keycode = 0;
> +
> +	ret = iio_read_channel_processed(st->channel, &value);
> +	if (ret < 0) {
> +		if (st->last_key) {
> +			input_report_key(dev->input, st->last_key, 0);
> +			input_sync(dev->input);
> +			st->last_key = 0;
> +		}
> +		return;
> +	}
> +
> +	for (i = 0; i < st->num_keys; i++) {
> +		diff = abs(st->map[i].voltage - value);
> +		if (diff < closest) {
> +			closest = diff;
> +			keycode = st->map[i].keycode;
> +		}
> +	}
> +
> +	if (abs(st->keyup_voltage - value) < closest) {
> +		input_report_key(dev->input, st->last_key, 0);
> +		st->last_key = 0;
> +	} else {
> +		if (st->last_key && st->last_key != keycode)
> +			input_report_key(dev->input, st->last_key, 0);
> +		input_report_key(dev->input, keycode, 1);
> +		st->last_key = keycode;
> +	}
> +
> +	input_sync(dev->input);
> +}
> +
> +static int adc_keys_load_dt_keymap(struct device *dev,
> +				   struct adc_keys_state *st)
> +{
> +	struct device_node *pp, *np = dev->of_node;
> +	int i;
> +
> +	st->num_keys = of_get_child_count(np);
> +	if (st->num_keys == 0) {
> +		dev_err(dev, "keymap is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	st->map = devm_kmalloc_array(dev, st->num_keys, sizeof(*st->map),
> +				     GFP_KERNEL);
> +	if (!st->map)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	for_each_child_of_node(np, pp) {
> +		struct adc_keys_button *map = &st->map[i];
> +
> +		if (of_property_read_u32(pp, "voltage-mvolt", &map->voltage)) {
> +			dev_err(dev, "%s: Invalid or missing voltage\n",
> +				pp->name);
> +			return -EINVAL;
> +		}
> +
> +		if (of_property_read_u32(pp, "linux,code", &map->keycode)) {
> +			dev_err(dev, "%s: Invalid or missing linux,code\n",
> +				pp->name);
> +			return -EINVAL;
> +		}
> +
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adc_keys_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct adc_keys_state *st;
> +	struct input_polled_dev *poll_dev = NULL;
> +	struct input_dev *input;
> +	enum iio_chan_type type;
> +	int i, value, ret;
> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	st->channel = devm_iio_channel_get(dev, "buttons");
> +	if (IS_ERR(st->channel))
> +		return PTR_ERR(st->channel);
> +
> +	if (!st->channel->indio_dev)
> +		return -ENODEV;
> +
> +	ret = iio_get_channel_type(st->channel, &type);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (type != IIO_VOLTAGE) {
> +		dev_err(dev, "Incompatible channel type %d\n", type);
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32(node, "voltage-keyup-mvolt",
> +				 &st->keyup_voltage)) {
> +		dev_err(dev, "Invalid or missing keyup voltage\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = adc_keys_load_dt_keymap(dev, st);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, st);
> +
> +	poll_dev = devm_input_allocate_polled_device(dev);
> +	if (!poll_dev) {
> +		dev_err(dev, "failed to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (!of_property_read_u32(node, "poll-interval", &value))
> +		poll_dev->poll_interval = value;
> +	poll_dev->poll = adc_keys_poll;
> +	poll_dev->private = st;
> +
> +	input = poll_dev->input;
> +
> +	input->name = pdev->name;
> +	input->phys = "adc-keys/input0";
> +	input->dev.parent = &pdev->dev;
> +
> +	input->id.bustype = BUS_HOST;
> +	input->id.vendor = 0x0001;
> +	input->id.product = 0x0001;
> +	input->id.version = 0x0100;
> +
> +	__set_bit(EV_KEY, input->evbit);
> +	for (i = 0; i < st->num_keys; i++)
> +		__set_bit(st->map[i].keycode, input->keybit);
> +
> +	if (!!of_get_property(node, "autorepeat", NULL))
> +		__set_bit(EV_REP, input->evbit);
> +
> +	ret = input_register_polled_device(poll_dev);
> +	if (ret) {
> +		dev_err(dev, "Unable to register input device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id adc_keys_of_match[] = {
> +	{ .compatible = "adc-keys", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc_keys_of_match);
> +
> +static struct platform_driver __refdata adc_keys_driver = {
> +	.driver = {
> +		.name = "adc_keys",
> +		.of_match_table = adc_keys_of_match,
> +	},
> +	.probe = adc_keys_probe,
> +};
> +
> +module_platform_driver(adc_keys_driver);
> +
> +MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
> +MODULE_DESCRIPTION("Input driver for resistor ladder connected on ADC");
> +MODULE_LICENSE("GPL v2");
> 
