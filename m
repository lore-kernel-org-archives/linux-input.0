From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v5] input: add ADC resistor ladder driver
Date: Fri, 29 Jul 2016 00:44:33 +0200
Message-ID: <1469745873-14611-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35061 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751438AbcG1Wok (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 18:44:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

A common way of multiplexing buttons on a single input in cheap devices is
to use a resistor ladder on an ADC. This driver supports that configuration
by polling an ADC channel provided by IIO.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---

Changes in v5:
 - Dmitry's changes
 - s/mvolt/millivolt/

 .../devicetree/bindings/input/adc-keys.txt         |  49 +++++
 drivers/input/keyboard/Kconfig                     |  15 ++
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/adc-keys.c                  | 208 +++++++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
 create mode 100644 drivers/input/keyboard/adc-keys.c

diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
new file mode 100644
index 000000000000..e42fab5e431f
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
+ - keyup-threshold-millivolt: Voltage at which all the keys are considered up.
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
+	- press-threshold-millivolt: Voltage adc input when this key is pressed.
+
+Example:
+
+#include <dt-bindings/input/input.h>
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&lradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-millivolt = <2000>;
+
+		button@1500 {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-millivolt = <1500>;
+		};
+
+		button@1000 {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-millivolt = <1000>;
+		};
+
+		button@500 {
+			label = "Enter";
+			linux,code = <KEY_ENTER>;
+			press-threshold-millivolt = <500>;
+		};
+	};
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 509608c95994..cbd75cf44739 100644
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
index 1d416ddf84e4..d9f4cfcf3410 100644
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
index 000000000000..050ae6d5019f
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
+		if (fwnode_property_read_u32(child, "press-threshold-millivolt",
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
+	if (device_property_read_u32(dev, "keyup-threshold-millivolt",
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
-- 
2.8.1

