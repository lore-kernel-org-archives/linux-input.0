From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] input: Add new driver for ARM CLPS711X keypad
Date: Wed, 15 Jan 2014 20:27:18 +0400
Message-ID: <1389803238-32612-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp40.i.mail.ru ([94.100.177.100]:50284 "EHLO smtp40.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbaAOQ1a (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jan 2014 11:27:30 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>

This patch adds a new driver for keypad for Cirrus Logic CLPS711X CPUs
and devicetree binding documentation.
Target CPU contain keyboard interface which can scan 8 column lines,
so we can read row GPIOs to read status and determine asserted state.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/input/clps711x-keypad.txt  |  29 +++
 drivers/input/keyboard/Kconfig                     |  12 ++
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/clps711x-keypad.c           | 209 +++++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/clps711x-keypad.txt
 create mode 100644 drivers/input/keyboard/clps711x-keypad.c

diff --git a/Documentation/devicetree/bindings/input/clps711x-keypad.txt b/Documentation/devicetree/bindings/input/clps711x-keypad.txt
new file mode 100644
index 0000000..26b7fe5
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/clps711x-keypad.txt
@@ -0,0 +1,29 @@
+* Cirrus Logic CLPS711X matrix keypad device tree bindings
+
+Required Properties:
+- compatible:    Should be "cirrus,clps711x--keypad".
+- syscon:        phandle to syscon device node which control keypad (SYSCON1).
+- row-gpios:     List of GPIOs used as row lines.
+- poll-interval: Poll interval time in milliseconds.
+- linux,keymap:  The definition can be found at
+                 bindings/input/matrix-keymap.txt.
+
+Optional Properties:
+- autorepeat:    Enable autorepeat feature.
+
+Example:
+	keypad {
+		compatible = "cirrus,clps711x--keypad";
+		syscon = <&syscon1>;
+		autorepeat;
+		poll-interval = <120>;
+		row-gpios = <&porta 0 0>,
+			    <&porta 1 0>;
+
+		linux,keymap = <
+			MATRIX_KEY(0, 0, KEY_UP)
+			MATRIX_KEY(0, 1, KEY_DOWN)
+			MATRIX_KEY(1, 0, KEY_LEFT)
+			MATRIX_KEY(1, 1, KEY_RIGHT)
+		>;
+	};
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a673c9f..126901b 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -151,6 +151,18 @@ config KEYBOARD_BFIN
 	  To compile this driver as a module, choose M here: the
 	  module will be called bf54x-keys.
 
+config KEYBOARD_CLPS711X
+	tristate "CLPS711X Keypad support"
+	depends on OF_GPIO && (ARCH_CLPS711X || COMPILE_TEST)
+	select INPUT_MATRIXKMAP
+	select INPUT_POLLDEV
+	help
+	  Say Y here to enable the matrix keypad on the Cirrus Logic
+	  CLPS711X CPU.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called clps711x-keypad.
+
 config KEYBOARD_LKKBD
 	tristate "DECstation/VAXstation LK201/LK401 keyboard"
 	select SERIO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index a699b61..f8589fe 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_ATARI)		+= atakbd.o
 obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
 obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
+obj-$(CONFIG_KEYBOARD_CLPS711X)		+= clps711x-keypad.o
 obj-$(CONFIG_KEYBOARD_CROS_EC)		+= cros_ec_keyb.o
 obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
 obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
diff --git a/drivers/input/keyboard/clps711x-keypad.c b/drivers/input/keyboard/clps711x-keypad.c
new file mode 100644
index 0000000..1e2c93f
--- /dev/null
+++ b/drivers/input/keyboard/clps711x-keypad.c
@@ -0,0 +1,209 @@
+/*
+ * Cirrus Logic CLPS711X Keypad driver
+ *
+ * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/input-polldev.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/clps711x.h>
+
+#define CLPS711X_KEYPAD_COL_COUNT	8
+
+struct clps711x_gpio_data {
+	int	gpio;
+	bool	active_low;
+	DECLARE_BITMAP(last_state, CLPS711X_KEYPAD_COL_COUNT);
+};
+
+struct clps711x_keypad_data {
+	struct regmap			*syscon;
+	int				row_count;
+	unsigned int			row_shift;
+	struct clps711x_gpio_data	*gpio_data;
+};
+
+static void clps711x_keypad_poll(struct input_polled_dev *dev)
+{
+	const unsigned short *keycodes = dev->input->keycode;
+	struct clps711x_keypad_data *priv = dev->private;
+	int col, row;
+
+	for (col = 0; col < CLPS711X_KEYPAD_COL_COUNT; col++) {
+		/* Assert column */
+		regmap_update_bits(priv->syscon, SYSCON_OFFSET,
+				   SYSCON1_KBDSCAN_MASK,
+				   SYSCON1_KBDSCAN(8 + col));
+
+		/* Scan rows */
+		for (row = 0; row < priv->row_count; row++) {
+			struct clps711x_gpio_data *data = &priv->gpio_data[row];
+			bool state, state1;
+
+			/* Protection against fluctuations */
+			do {
+				state = gpio_get_value_cansleep(data->gpio);
+				udelay(1);
+				state1 = gpio_get_value_cansleep(data->gpio);
+			} while (state != state1);
+
+			state ^= data->active_low;
+
+			if (test_bit(col, data->last_state) != state) {
+				int code = MATRIX_SCAN_CODE(row, col,
+							    priv->row_shift);
+
+				if (state)
+					set_bit(col, data->last_state);
+				else
+					clear_bit(col, data->last_state);
+
+				input_event(dev->input, EV_MSC, MSC_SCAN, code);
+				if (keycodes[code])
+					input_report_key(dev->input,
+							 keycodes[code], state);
+			}
+		}
+
+		/* Set all columns to low */
+		regmap_update_bits(priv->syscon, SYSCON_OFFSET,
+				   SYSCON1_KBDSCAN_MASK, SYSCON1_KBDSCAN(1));
+	}
+
+	input_sync(dev->input);
+}
+
+static int clps711x_keypad_probe(struct platform_device *pdev)
+{
+	struct clps711x_keypad_data *priv;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct input_polled_dev *poll_dev;
+	u32 poll_interval;
+	int i, err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
+	if (IS_ERR(priv->syscon))
+		return PTR_ERR(priv->syscon);
+
+	priv->row_count = of_gpio_named_count(np, "row-gpios");
+	if (priv->row_count < 1)
+		return -EINVAL;
+
+	priv->gpio_data = devm_kzalloc(dev, sizeof(*priv->gpio_data) *
+				       priv->row_count, GFP_KERNEL);
+	if (!priv->gpio_data)
+		return -ENOMEM;
+
+	priv->row_shift = get_count_order(CLPS711X_KEYPAD_COL_COUNT);
+
+	for (i = 0; i < priv->row_count; i++) {
+		struct clps711x_gpio_data *data = &priv->gpio_data[i];
+		enum of_gpio_flags flg;
+
+		data->gpio = of_get_named_gpio_flags(np, "row-gpios", i, &flg);
+		if (data->gpio < 0)
+			return data->gpio;
+
+		err = devm_gpio_request_one(dev, data->gpio, GPIOF_IN, NULL);
+		if (err)
+			return err;
+
+		data->active_low = flg & OF_GPIO_ACTIVE_LOW;
+	}
+
+	err = of_property_read_u32(np, "poll-interval", &poll_interval);
+	if (err)
+		return err;
+
+	poll_dev = input_allocate_polled_device();
+	if (!poll_dev)
+		return -ENOMEM;
+
+	poll_dev->private		= priv;
+	poll_dev->poll			= clps711x_keypad_poll;
+	poll_dev->poll_interval		= poll_interval;
+	poll_dev->input->name		= pdev->name;
+	poll_dev->input->dev.parent	= &pdev->dev;
+	poll_dev->input->id.bustype	= BUS_HOST;
+	poll_dev->input->id.vendor	= 0x0001;
+	poll_dev->input->id.product	= 0x0001;
+	poll_dev->input->id.version	= 0x0100;
+
+	err = matrix_keypad_build_keymap(NULL, NULL, priv->row_count,
+					 CLPS711X_KEYPAD_COL_COUNT,
+					 NULL, poll_dev->input);
+	if (err)
+		goto out_err;
+
+	input_set_capability(poll_dev->input, EV_MSC, MSC_SCAN);
+	if (of_property_read_bool(np, "autorepeat"))
+		__set_bit(EV_REP, poll_dev->input->evbit);
+
+	platform_set_drvdata(pdev, poll_dev);
+
+	/* Set all columns to low */
+	regmap_update_bits(priv->syscon, SYSCON_OFFSET, SYSCON1_KBDSCAN_MASK,
+			   SYSCON1_KBDSCAN(1));
+
+	err = input_register_polled_device(poll_dev);
+	if (err)
+		goto out_err;
+
+	/* Report initial state */
+	clps711x_keypad_poll(poll_dev);
+
+	return 0;
+
+out_err:
+	input_free_polled_device(poll_dev);
+
+	return err;
+}
+
+static int clps711x_keypad_remove(struct platform_device *pdev)
+{
+	struct input_polled_dev *poll_dev = platform_get_drvdata(pdev);
+
+	input_unregister_polled_device(poll_dev);
+	input_free_polled_device(poll_dev);
+
+	return 0;
+}
+
+static struct of_device_id clps711x_keypad_of_match[] = {
+	{ .compatible = "cirrus,clps711x-keypad", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clps711x_keypad_of_match);
+
+static struct platform_driver clps711x_keypad_driver = {
+	.driver	= {
+		.name		= "clps711x-keypad",
+		.owner		= THIS_MODULE,
+		.of_match_table	= clps711x_keypad_of_match,
+	},
+	.probe	= clps711x_keypad_probe,
+	.remove	= clps711x_keypad_remove,
+};
+module_platform_driver(clps711x_keypad_driver);
+
+MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
+MODULE_DESCRIPTION("Cirrus Logic CLPS711X Keypad driver");
+MODULE_LICENSE("GPL");
-- 
1.8.3.2

