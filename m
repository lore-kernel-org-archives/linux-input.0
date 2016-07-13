From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 2/2] input: add ADC resistor ladder driver
Date: Tue, 12 Jul 2016 17:41:50 -0700
Message-ID: <20160713004150.GB24789@dtor-ws>
References: <1468352186-14190-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1468352186-14190-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34596 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbcGMAmI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2016 20:42:08 -0400
Content-Disposition: inline
In-Reply-To: <1468352186-14190-2-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Alexandre,

On Tue, Jul 12, 2016 at 09:36:26PM +0200, Alexandre Belloni wrote:
> A common way of multiplexing buttons on a single input in cheap devices is
> to use a resistor ladder on an ADC. This driver supports that configuration
> by polling an ADC channel provided by IIO.

This looks quite reasonable, just a few small comments.

> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/input/keyboard/Kconfig    |  15 +++
>  drivers/input/keyboard/Makefile   |   1 +
>  drivers/input/keyboard/adc-keys.c | 210 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 226 insertions(+)
>  create mode 100644 drivers/input/keyboard/adc-keys.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 509608c95994..4cf042cc5e63 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -12,6 +12,21 @@ menuconfig INPUT_KEYBOARD
>  
>  if INPUT_KEYBOARD
>  
> +config KEYBOARD_ADC
> +	tristate "ADC ladder Buttons"
> +	depends on IIO
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
> index 000000000000..cf299ff517a0
> --- /dev/null
> +++ b/drivers/input/keyboard/adc-keys.c
> @@ -0,0 +1,210 @@
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

const

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

I think this can be simplified a bit, see version below.

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

There is no need to limit this driver to OF, generic device properties
will allow us to use it on DT, ACPI and legacy boards.

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
> +		if (of_property_read_u32(pp, "press-threshold-mvolt",
> +					 &map->voltage)) {
> +			dev_err(dev, "%s: Invalid or missing voltage\n",
> +				pp->name);

You have to remember to drop node reference if you return early from
for_each_child_of_node().

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
> +	if (of_property_read_u32(node, "keyup-threshold-mvolt",
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

No need to do that for devm input devices - it is done for you.

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

Needs #ifdef CONFIG_OF.

> +
> +static struct platform_driver __refdata adc_keys_driver = {
> +	.driver = {
> +		.name = "adc_keys",
> +		.of_match_table = adc_keys_of_match,

of_match_ptr().

> +	},
> +	.probe = adc_keys_probe,
> +};
> +
> +module_platform_driver(adc_keys_driver);
> +
> +MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
> +MODULE_DESCRIPTION("Input driver for resistor ladder connected on ADC");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.8.1
> 

Thanks.

-- 
Dmitry


Input: add ADC resistor ladder driver

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

A common way of multiplexing buttons on a single input in cheap devices is
to use a resistor ladder on an ADC. This driver supports that configuration
by polling an ADC channel provided by IIO.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/adc-keys.txt         |   49 +++++
 drivers/input/keyboard/Kconfig                     |   15 +
 drivers/input/keyboard/Makefile                    |    1 
 drivers/input/keyboard/adc-keys.c                  |  208 ++++++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
 create mode 100644 drivers/input/keyboard/adc-keys.c

diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
new file mode 100644
index 0000000..feab05a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adc-keys.txt
@@ -0,0 +1,49 @@
+ADC attached resistor ladder buttons
+------------------------------------
+
+Required properties:
+ - compatible: "adc-keys"
+ - io-channels: Phandle to an ADC channel
+ - io-channel-names = "buttons";
+ - keyup-threshold-mvolt: Voltage at which all the keys are considered up.
+
+Optional properties:
+	- poll-interval: Poll interval time in milliseconds
+	- autorepeat: Boolean, Enable auto repeat feature of Linux input
+	  subsystem.
+
+Each button (key) is represented as a sub-node of "adc-keys":
+
+Required subnode-properties:
+	- label: Descriptive name of the key.
+	- linux,code: Keycode to emit.
+	- press-threshold-mvolt: Voltage adc input when this key is pressed.
+
+Example:
+
+#include <dt-bindings/input/input.h>
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&lradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-mvolt = <2000>;
+
+		button@1500 {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-mvolt = <1500>;
+		};
+
+		button@1000 {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-mvolt = <1000>;
+		};
+
+		button@500 {
+			label = "Enter";
+			linux,code = <KEY_ENTER>;
+			press-threshold-mvolt = <500>;
+		};
+	};
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 509608c..cbd75cf 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -12,6 +12,21 @@ menuconfig INPUT_KEYBOARD
 
 if INPUT_KEYBOARD
 
+config KEYBOARD_ADC
+	tristate "ADC Ladder Buttons"
+	depends on IIO
+	select INPUT_POLLDEV
+	help
+	  This driver implements support for buttons connected
+	  to an ADC using a resistor ladder.
+
+	  Say Y here if your device has such buttons connected to an ADC.  Your
+	  board-specific setup logic must also provide a configuration data
+	  for mapping voltages to buttons.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adc_keys.
+
 config KEYBOARD_ADP5520
 	tristate "Keypad Support for ADP5520 PMIC"
 	depends on PMIC_ADP5520
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 1d416dd..d9f4cfc 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -4,6 +4,7 @@
 
 # Each configuration option enables a list of files.
 
+obj-$(CONFIG_KEYBOARD_ADC)		+= adc-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5520)		+= adp5520-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5589)		+= adp5589-keys.o
diff --git a/drivers/input/keyboard/adc-keys.c b/drivers/input/keyboard/adc-keys.c
new file mode 100644
index 0000000..f91eec5
--- /dev/null
+++ b/drivers/input/keyboard/adc-keys.c
@@ -0,0 +1,208 @@
+/*
+ * Input driver for resistor ladder connected on ADC
+ *
+ * Copyright (c) 2016 Alexandre Belloni
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/types.h>
+#include <linux/input.h>
+#include <linux/input-polldev.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+struct adc_keys_button {
+	u32 voltage;
+	u32 keycode;
+};
+
+struct adc_keys_state {
+	struct iio_channel *channel;
+	u32 num_keys;
+	u32 last_key;
+	u32 keyup_voltage;
+	const struct adc_keys_button *map;
+};
+
+static void adc_keys_poll(struct input_polled_dev *dev)
+{
+	struct adc_keys_state *st = dev->private;
+	int i, value, ret;
+	u32 diff, closest = 0xffffffff;
+	int keycode = 0;
+
+	ret = iio_read_channel_processed(st->channel, &value);
+	if (unlikely(ret < 0)) {
+		/* Forcibly release key if any was pressed */
+		value = st->keyup_voltage;
+	} else {
+		for (i = 0; i < st->num_keys; i++) {
+			diff = abs(st->map[i].voltage - value);
+			if (diff < closest) {
+				closest = diff;
+				keycode = st->map[i].keycode;
+			}
+		}
+	}
+
+	if (abs(st->keyup_voltage - value) < closest)
+		keycode = 0;
+
+	if (st->last_key && st->last_key != keycode)
+		input_report_key(dev->input, st->last_key, 0);
+
+	if (keycode)
+		input_report_key(dev->input, keycode, 1);
+
+	input_sync(dev->input);
+	st->last_key = keycode;
+}
+
+static int adc_keys_load_keymap(struct device *dev, struct adc_keys_state *st)
+{
+	struct adc_keys_button *map;
+	struct fwnode_handle *child;
+	int i;
+
+	st->num_keys = device_get_child_node_count(dev);
+	if (st->num_keys == 0) {
+		dev_err(dev, "keymap is missing\n");
+		return -EINVAL;
+	}
+
+	map = devm_kmalloc_array(dev, st->num_keys, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	i = 0;
+	device_for_each_child_node(dev, child) {
+		if (fwnode_property_read_u32(child, "press-threshold-mvolt",
+					     &map[i].voltage)) {
+			dev_err(dev, "Key with invalid or missing voltage\n");
+			fwnode_handle_put(child);
+			return -EINVAL;
+		}
+
+		if (fwnode_property_read_u32(child, "linux,code",
+					     &map[i].keycode)) {
+			dev_err(dev, "Key with invalid or missing linux,code\n");
+			fwnode_handle_put(child);
+			return -EINVAL;
+		}
+
+		i++;
+	}
+
+	st->map = map;
+	return 0;
+}
+
+static int adc_keys_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct adc_keys_state *st;
+	struct input_polled_dev *poll_dev;
+	struct input_dev *input;
+	enum iio_chan_type type;
+	int i, value;
+	int error;
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->channel = devm_iio_channel_get(dev, "buttons");
+	if (IS_ERR(st->channel))
+		return PTR_ERR(st->channel);
+
+	if (!st->channel->indio_dev)
+		return -ENXIO;
+
+	error = iio_get_channel_type(st->channel, &type);
+	if (error < 0)
+		return error;
+
+	if (type != IIO_VOLTAGE) {
+		dev_err(dev, "Incompatible channel type %d\n", type);
+		return -EINVAL;
+	}
+
+	if (device_property_read_u32(dev, "keyup-threshold-mvolt",
+				     &st->keyup_voltage)) {
+		dev_err(dev, "Invalid or missing keyup voltage\n");
+		return -EINVAL;
+	}
+
+	error = adc_keys_load_keymap(dev, st);
+	if (error)
+		return error;
+
+	platform_set_drvdata(pdev, st);
+
+	poll_dev = devm_input_allocate_polled_device(dev);
+	if (!poll_dev) {
+		dev_err(dev, "failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	if (!device_property_read_u32(dev, "poll-interval", &value))
+		poll_dev->poll_interval = value;
+
+	poll_dev->poll = adc_keys_poll;
+	poll_dev->private = st;
+
+	input = poll_dev->input;
+
+	input->name = pdev->name;
+	input->phys = "adc-keys/input0";
+
+	input->id.bustype = BUS_HOST;
+	input->id.vendor = 0x0001;
+	input->id.product = 0x0001;
+	input->id.version = 0x0100;
+
+	__set_bit(EV_KEY, input->evbit);
+	for (i = 0; i < st->num_keys; i++)
+		__set_bit(st->map[i].keycode, input->keybit);
+
+	if (device_property_read_bool(dev, "autorepeat"))
+		__set_bit(EV_REP, input->evbit);
+
+	error = input_register_polled_device(poll_dev);
+	if (error) {
+		dev_err(dev, "Unable to register input device: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id adc_keys_of_match[] = {
+	{ .compatible = "adc-keys", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adc_keys_of_match);
+#endif
+
+static struct platform_driver __refdata adc_keys_driver = {
+	.driver = {
+		.name = "adc_keys",
+		.of_match_table = of_match_ptr(adc_keys_of_match),
+	},
+	.probe = adc_keys_probe,
+};
+module_platform_driver(adc_keys_driver);
+
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
+MODULE_DESCRIPTION("Input driver for resistor ladder connected on ADC");
+MODULE_LICENSE("GPL v2");
