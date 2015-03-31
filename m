From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH V2 3/3] Input: Add driver for a generic ADC keypad
Date: Mon, 30 Mar 2015 17:28:09 -0700
Message-ID: <1427761689-5238-3-git-send-email-abrestic@chromium.org>
References: <1427761689-5238-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f202.google.com ([209.85.213.202]:33670 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbbCaA2N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Mar 2015 20:28:13 -0400
Received: by igdh15 with SMTP id h15so1455043igd.0
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2015 17:28:13 -0700 (PDT)
In-Reply-To: <1427761689-5238-1-git-send-email-abrestic@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>, Jonathan Cameron <jic23@kernel.org>

Add a polled input driver for a keypad in which the buttons are connected
in resistor ladders to an ADC.  The IIO framework is used to claim and
read the ADC channels.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>
---
Changes from v1:
 - Made linux,input-type a required property.
---
 drivers/input/keyboard/Kconfig    |  13 ++
 drivers/input/keyboard/Makefile   |   1 +
 drivers/input/keyboard/adc-keys.c | 294 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 308 insertions(+)
 create mode 100644 drivers/input/keyboard/adc-keys.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a89ba7c..bbaff9e 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -12,6 +12,19 @@ menuconfig INPUT_KEYBOARD
 
 if INPUT_KEYBOARD
 
+config KEYBOARD_ADC
+	tristate "ADC Keypad"
+	depends on IIO
+	select INPUT_POLLDEV
+	help
+	  This driver supports generic ADC keypads using IIO.
+
+	  Say Y here if your device has buttons connected in a resistor ladder
+	  to an ADC.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called adc-keys.
+
 config KEYBOARD_ADP5520
 	tristate "Keypad Support for ADP5520 PMIC"
 	depends on PMIC_ADP5520
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 4707678..888fa62 100644
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
index 0000000..d5691ca
--- /dev/null
+++ b/drivers/input/keyboard/adc-keys.c
@@ -0,0 +1,294 @@
+/*
+ * ADC keypad driver
+ *
+ * Copyright (C) 2015 Google, Inc.
+ *
+ * Based on /drivers/input/keybaord/gpio_keys_polled.c:
+ *  Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2010 Nuno Goncalves <nunojpg@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/iio/consumer.h>
+#include <linux/input.h>
+#include <linux/input-polldev.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct adc_key {
+	const char *desc;
+	unsigned int type;
+	unsigned int code;
+	unsigned int min_uV;
+	unsigned int max_uV;
+};
+
+struct adc_chan_map {
+	struct adc_key *keys;
+	unsigned int num_keys;
+	int last_key;
+};
+
+struct adc_keypad {
+	struct device *dev;
+	struct input_polled_dev *poll_dev;
+	unsigned int poll_interval;
+	bool autorepeat;
+	struct iio_channel *iio_chans;
+	unsigned int num_chans;
+	struct adc_chan_map *chan_map;
+};
+
+static void adc_keypad_poll_chan(struct adc_keypad *keypad, unsigned int chan)
+{
+	struct adc_chan_map *chan_map = &keypad->chan_map[chan];
+	struct input_dev *input = keypad->poll_dev->input;
+	struct adc_key *key;
+	unsigned int adc_uV;
+	int ret, val, i;
+
+	ret = iio_read_channel_processed(&keypad->iio_chans[chan], &val);
+	if (ret < 0) {
+		dev_err(keypad->dev, "Failed to read ADC: %d\n", ret);
+		return;
+	}
+	adc_uV = val * 1000;
+
+	if (chan == 1)
+		dev_info(keypad->dev, "%u uV\n", adc_uV);
+
+	for (i = 0; i < chan_map->num_keys; i++) {
+		if (adc_uV >= chan_map->keys[i].min_uV &&
+		    adc_uV <= chan_map->keys[i].max_uV)
+			break;
+	}
+	if (i >= chan_map->num_keys)
+		i = -1;
+
+	if (i != chan_map->last_key) {
+		if (chan_map->last_key >= 0) {
+			key = &chan_map->keys[chan_map->last_key];
+			input_event(input, key->type, key->code, 0);
+		}
+		if (i >= 0) {
+			key = &chan_map->keys[i];
+			input_event(input, key->type, key->code, 1);
+		}
+		input_sync(input);
+		chan_map->last_key = i;
+	}
+}
+
+static void adc_keypad_poll(struct input_polled_dev *poll_dev)
+{
+	struct adc_keypad *keypad = poll_dev->private;
+	unsigned int i;
+
+	for (i = 0; i < keypad->num_chans; i++)
+		adc_keypad_poll_chan(keypad, i);
+}
+
+static int adc_keypad_of_parse_chan(struct adc_keypad *keypad,
+				    unsigned int chan)
+{
+	struct device_node *child, *np = keypad->dev->of_node;
+	struct adc_key *keys;
+	unsigned int i = 0;
+	int ret;
+
+	for_each_child_of_node(np, child) {
+		unsigned int c;
+
+		ret = of_property_read_u32(child, "channel", &c);
+		if (ret < 0)
+			continue;
+		if (c != chan)
+			continue;
+		i++;
+	}
+
+	keys = devm_kcalloc(keypad->dev, i, sizeof(*keys), GFP_KERNEL);
+	if (!keys)
+		return -ENOMEM;
+	keypad->chan_map[chan].keys = keys;
+	keypad->chan_map[chan].num_keys = i;
+
+	i = 0;
+	for_each_child_of_node(np, child) {
+		struct adc_key *key = &keys[i];
+		unsigned int c;
+
+		ret = of_property_read_u32(child, "channel", &c);
+		if (ret < 0)
+			continue;
+		if (c != chan)
+			continue;
+
+		ret = of_property_read_string(child, "label", &key->desc);
+		if (ret < 0)
+			return ret;
+
+		ret = of_property_read_u32(child, "min-voltage", &key->min_uV);
+		if (ret < 0)
+			return ret;
+
+		ret = of_property_read_u32(child, "max-voltage", &key->max_uV);
+		if (ret < 0)
+			return ret;
+
+		ret = of_property_read_u32(child, "linux,code", &key->code);
+		if (ret < 0)
+			return ret;
+
+		ret = of_property_read_u32(child, "linux,input-type",
+					   &key->type);
+		if (ret < 0)
+			return ret;
+
+		i++;
+		if (i >= keypad->chan_map[chan].num_keys)
+			break;
+	}
+
+	return 0;
+}
+
+static int adc_keypad_of_parse(struct adc_keypad *keypad)
+{
+	struct device_node *np = keypad->dev->of_node;
+	unsigned int i;
+	int ret;
+
+	keypad->autorepeat = of_property_read_bool(np, "autorepeat");
+	ret = of_property_read_u32(np, "poll-interval", &keypad->poll_interval);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < keypad->num_chans; i++) {
+		ret = adc_keypad_of_parse_chan(keypad, i);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int adc_keypad_probe(struct platform_device *pdev)
+{
+	struct adc_keypad *keypad;
+	struct input_polled_dev *poll_dev;
+	struct input_dev *input;
+	unsigned int i;
+	int ret;
+
+	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
+	if (!keypad)
+		return -ENOMEM;
+	keypad->dev = &pdev->dev;
+	platform_set_drvdata(pdev, keypad);
+
+	keypad->iio_chans = iio_channel_get_all(&pdev->dev);
+	if (IS_ERR(keypad->iio_chans)) {
+		dev_err(&pdev->dev, "Failed to get IIO channels: %ld\n",
+			PTR_ERR(keypad->iio_chans));
+		return PTR_ERR(keypad->iio_chans);
+	}
+
+	i = 0;
+	while (keypad->iio_chans[i].channel != NULL)
+		i++;
+	keypad->num_chans = i;
+	keypad->chan_map = devm_kcalloc(&pdev->dev, keypad->num_chans,
+					sizeof(*keypad->chan_map), GFP_KERNEL);
+	if (!keypad->chan_map) {
+		ret = -ENOMEM;
+		goto put_chans;
+	}
+
+	ret = adc_keypad_of_parse(keypad);
+	if (ret < 0)
+		goto put_chans;
+
+	poll_dev = devm_input_allocate_polled_device(&pdev->dev);
+	if (!poll_dev) {
+		ret = -ENOMEM;
+		goto put_chans;
+	}
+	keypad->poll_dev = poll_dev;
+
+	poll_dev->private = keypad;
+	poll_dev->poll = adc_keypad_poll;
+	poll_dev->poll_interval = keypad->poll_interval;
+
+	input = poll_dev->input;
+	input->name = pdev->name;
+	input->phys = "adc-keys/input0";
+
+	input->id.bustype = BUS_HOST;
+	input->id.vendor = 0x0001;
+	input->id.product = 0x0001;
+	input->id.version = 0x0100;
+
+	__set_bit(EV_KEY, input->evbit);
+	if (keypad->autorepeat)
+		__set_bit(EV_REP, input->evbit);
+
+	for (i = 0; i < keypad->num_chans; i++) {
+		struct adc_chan_map *chan_map = &keypad->chan_map[i];
+		unsigned int j;
+
+		for (j = 0; j < chan_map->num_keys; j++)
+			input_set_capability(input, chan_map->keys[j].type,
+					     chan_map->keys[j].code);
+	}
+
+	ret = input_register_polled_device(poll_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register polled device: %d\n",
+			ret);
+		goto put_chans;
+	}
+
+	return 0;
+
+put_chans:
+	iio_channel_release_all(keypad->iio_chans);
+	return ret;
+}
+
+static int adc_keypad_remove(struct platform_device *pdev)
+{
+	struct adc_keypad *keypad = platform_get_drvdata(pdev);
+
+	input_unregister_polled_device(keypad->poll_dev);
+
+	iio_channel_release_all(keypad->iio_chans);
+
+	return 0;
+}
+
+static const struct of_device_id adc_keypad_of_match[] = {
+	{ .compatible = "adc-keys", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adc_keypad_of_match);
+
+static struct platform_driver adc_keypad_driver = {
+	.probe	= adc_keypad_probe,
+	.remove	= adc_keypad_remove,
+	.driver	= {
+		.name = "adc-keys",
+		.of_match_table	= adc_keypad_of_match,
+	},
+};
+module_platform_driver(adc_keypad_driver);
+
+MODULE_DESCRIPTION("ADC keypad driver");
+MODULE_AUTHOR("Andrew Bresticker <abrestic@chromium.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.2.0.rc0.207.ga3a616c

