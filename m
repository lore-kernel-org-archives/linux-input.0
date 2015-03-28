From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] Input: Add driver for a generic ADC keypad
Date: Sat, 28 Mar 2015 14:02:52 +0000
Message-ID: <5516B48C.4030003@kernel.org>
References: <1427503398-19682-1-git-send-email-abrestic@chromium.org> <1427503398-19682-2-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427503398-19682-2-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 28/03/15 00:43, Andrew Bresticker wrote:
> Add a polled input driver for a keypad in which the buttons are connected
> in resistor ladders to an ADC.  The IIO framework is used to claim and
> read the ADC channels.
> 
> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
The IIO side of things looks fine.
> ---
>  drivers/input/keyboard/Kconfig    |  13 ++
>  drivers/input/keyboard/Makefile   |   1 +
>  drivers/input/keyboard/adc-keys.c | 291 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 drivers/input/keyboard/adc-keys.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index a89ba7c..bbaff9e 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -12,6 +12,19 @@ menuconfig INPUT_KEYBOARD
>  
>  if INPUT_KEYBOARD
>  
> +config KEYBOARD_ADC
> +	tristate "ADC Keypad"
> +	depends on IIO
> +	select INPUT_POLLDEV
> +	help
> +	  This driver supports generic ADC keypads using IIO.
> +
> +	  Say Y here if your device has buttons connected in a resistor ladder
> +	  to an ADC.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called adc-keys.
> +
>  config KEYBOARD_ADP5520
>  	tristate "Keypad Support for ADP5520 PMIC"
>  	depends on PMIC_ADP5520
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 4707678..888fa62 100644
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
> index 0000000..1b9bcad
> --- /dev/null
> +++ b/drivers/input/keyboard/adc-keys.c
> @@ -0,0 +1,291 @@
> +/*
> + * ADC keypad driver
> + *
> + * Copyright (C) 2015 Google, Inc.
> + *
> + * Based on /drivers/input/keybaord/gpio_keys_polled.c:
> + *  Copyright (C) 2007-2010 Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> + *  Copyright (C) 2010 Nuno Goncalves <nunojpg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/iio/consumer.h>
> +#include <linux/input.h>
> +#include <linux/input-polldev.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +struct adc_key {
> +	const char *desc;
> +	unsigned int type;
> +	unsigned int code;
> +	unsigned int min_uV;
> +	unsigned int max_uV;
> +};
> +
> +struct adc_chan_map {
> +	struct adc_key *keys;
> +	unsigned int num_keys;
> +	int last_key;
> +};
> +
> +struct adc_keypad {
> +	struct device *dev;
> +	struct input_polled_dev *poll_dev;
> +	unsigned int poll_interval;
> +	bool autorepeat;
> +	struct iio_channel *iio_chans;
> +	unsigned int num_chans;
> +	struct adc_chan_map *chan_map;
> +};
> +
> +static void adc_keypad_poll_chan(struct adc_keypad *keypad, unsigned int chan)
> +{
> +	struct adc_chan_map *chan_map = &keypad->chan_map[chan];
> +	struct input_dev *input = keypad->poll_dev->input;
> +	struct adc_key *key;
> +	unsigned int adc_uV;
> +	int ret, val, i;
> +
> +	ret = iio_read_channel_processed(&keypad->iio_chans[chan], &val);
> +	if (ret < 0) {
> +		dev_err(keypad->dev, "Failed to read ADC: %d\n", ret);
> +		return;
> +	}
> +	adc_uV = val * 1000;
> +
> +	for (i = 0; i < chan_map->num_keys; i++) {
> +		if (adc_uV >= chan_map->keys[i].min_uV &&
> +		    adc_uV <= chan_map->keys[i].max_uV)
> +			break;
> +	}
> +	if (i >= chan_map->num_keys)
> +		i = -1;
> +
> +	if (i != chan_map->last_key) {
> +		if (chan_map->last_key >= 0) {
> +			key = &chan_map->keys[chan_map->last_key];
> +			input_event(input, key->type, key->code, 0);
> +		}
> +		if (i >= 0) {
> +			key = &chan_map->keys[i];
> +			input_event(input, key->type, key->code, 1);
> +		}
> +		input_sync(input);
> +		chan_map->last_key = i;
> +	}
> +}
> +
> +static void adc_keypad_poll(struct input_polled_dev *poll_dev)
> +{
> +	struct adc_keypad *keypad = poll_dev->private;
> +	unsigned int i;
> +
> +	for (i = 0; i < keypad->num_chans; i++)
> +		adc_keypad_poll_chan(keypad, i);
> +}
> +
> +static int adc_keypad_of_parse_chan(struct adc_keypad *keypad,
> +				    unsigned int chan)
> +{
> +	struct device_node *child, *np = keypad->dev->of_node;
> +	struct adc_key *keys;
> +	unsigned int i = 0;
> +	int ret;
> +
> +	for_each_child_of_node(np, child) {
> +		unsigned int c;
> +
> +		ret = of_property_read_u32(child, "channel", &c);
> +		if (ret < 0)
> +			continue;
> +		if (c != chan)
> +			continue;
> +		i++;
> +	}
> +
> +	keys = devm_kcalloc(keypad->dev, i, sizeof(*keys), GFP_KERNEL);
> +	if (!keys)
> +		return -ENOMEM;
> +	keypad->chan_map[chan].keys = keys;
> +	keypad->chan_map[chan].num_keys = i;
> +
> +	i = 0;
> +	for_each_child_of_node(np, child) {
> +		struct adc_key *key = &keys[i];
> +		unsigned int c;
> +
> +		ret = of_property_read_u32(child, "channel", &c);
> +		if (ret < 0)
> +			continue;
> +		if (c != chan)
> +			continue;
> +
> +		ret = of_property_read_string(child, "label", &key->desc);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = of_property_read_u32(child, "min-voltage", &key->min_uV);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = of_property_read_u32(child, "max-voltage", &key->max_uV);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = of_property_read_u32(child, "linux,code", &key->code);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = of_property_read_u32(child, "linux,input-type",
> +					   &key->type);
> +		if (ret < 0)
> +			key->type = EV_KEY;
> +
> +		i++;
> +		if (i >= keypad->chan_map[chan].num_keys)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adc_keypad_of_parse(struct adc_keypad *keypad)
> +{
> +	struct device_node *np = keypad->dev->of_node;
> +	unsigned int i;
> +	int ret;
> +
> +	keypad->autorepeat = of_property_read_bool(np, "autorepeat");
> +	ret = of_property_read_u32(np, "poll-interval", &keypad->poll_interval);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < keypad->num_chans; i++) {
> +		ret = adc_keypad_of_parse_chan(keypad, i);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adc_keypad_probe(struct platform_device *pdev)
> +{
> +	struct adc_keypad *keypad;
> +	struct input_polled_dev *poll_dev;
> +	struct input_dev *input;
> +	unsigned int i;
> +	int ret;
> +
> +	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
> +	if (!keypad)
> +		return -ENOMEM;
> +	keypad->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, keypad);
> +
> +	keypad->iio_chans = iio_channel_get_all(&pdev->dev);
> +	if (IS_ERR(keypad->iio_chans)) {
> +		dev_err(&pdev->dev, "Failed to get IIO channels: %ld\n",
> +			PTR_ERR(keypad->iio_chans));
> +		return PTR_ERR(keypad->iio_chans);
> +	}
> +
> +	i = 0;
> +	while (keypad->iio_chans[i].channel != NULL)
> +		i++;
> +	keypad->num_chans = i;
> +	keypad->chan_map = devm_kcalloc(&pdev->dev, keypad->num_chans,
> +					sizeof(*keypad->chan_map), GFP_KERNEL);
> +	if (!keypad->chan_map) {
> +		ret = -ENOMEM;
> +		goto put_chans;
> +	}
> +
> +	ret = adc_keypad_of_parse(keypad);
> +	if (ret < 0)
> +		goto put_chans;
> +
> +	poll_dev = devm_input_allocate_polled_device(&pdev->dev);
> +	if (!poll_dev) {
> +		ret = -ENOMEM;
> +		goto put_chans;
> +	}
> +	keypad->poll_dev = poll_dev;
> +
> +	poll_dev->private = keypad;
> +	poll_dev->poll = adc_keypad_poll;
> +	poll_dev->poll_interval = keypad->poll_interval;
> +
> +	input = poll_dev->input;
> +	input->name = pdev->name;
> +	input->phys = "adc-keys/input0";
> +
> +	input->id.bustype = BUS_HOST;
> +	input->id.vendor = 0x0001;
> +	input->id.product = 0x0001;
> +	input->id.version = 0x0100;
Why these particular values?
> +
> +	__set_bit(EV_KEY, input->evbit);
> +	if (keypad->autorepeat)
> +		__set_bit(EV_REP, input->evbit);
> +
> +	for (i = 0; i < keypad->num_chans; i++) {
> +		struct adc_chan_map *chan_map = &keypad->chan_map[i];
> +		unsigned int j;
> +
> +		for (j = 0; j < chan_map->num_keys; j++)
> +			input_set_capability(input, chan_map->keys[j].type,
> +					     chan_map->keys[j].code);
> +	}
> +
> +	ret = input_register_polled_device(poll_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register polled device: %d\n",
> +			ret);
> +		goto put_chans;
> +	}
> +
> +	return 0;
> +
> +put_chans:
> +	iio_channel_release_all(keypad->iio_chans);
> +	return ret;
> +}
> +
> +static int adc_keypad_remove(struct platform_device *pdev)
> +{
> +	struct adc_keypad *keypad = platform_get_drvdata(pdev);
> +
> +	input_unregister_polled_device(keypad->poll_dev);
> +
> +	iio_channel_release_all(keypad->iio_chans);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id adc_keypad_of_match[] = {
> +	{ .compatible = "adc-keys", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc_keypad_of_match);
> +
> +static struct platform_driver adc_keypad_driver = {
> +	.probe	= adc_keypad_probe,
> +	.remove	= adc_keypad_remove,
> +	.driver	= {
> +		.name = "adc-keys",
> +		.of_match_table	= adc_keypad_of_match,
> +	},
> +};
> +module_platform_driver(adc_keypad_driver);
> +
> +MODULE_DESCRIPTION("ADC keypad driver");
> +MODULE_AUTHOR("Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> 
