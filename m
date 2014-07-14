From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v4] Input: Add driver for Microchip's CAP1106
Date: Mon, 14 Jul 2014 16:28:02 +0200
Message-ID: <1405348082-24210-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:45889 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbaGNO2O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2014 10:28:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, broonie@kernel.org, dh.herrmann@gmail.com, devicetree@vger.kernel.org, mark.rutland@arm.com, Daniel Mack <zonque@gmail.com>

This patch adds a driver for Microchips CAP1106, an I2C driven, 6-channel
capacitive touch sensor.

For now, only the capacitive buttons are supported, and no specific
settings that can be tweaked for individual channels, except for the
device-wide sensitivity gain. The defaults seem to work just fine out of
the box, so I'll leave configurable parameters for someone who's in need
of them and who can actually measure the impact. All registers are
prepared, however. Many of them are just not used for now.

The implementation does not make any attempt to be compatible to platform
data driven boards, but fully depends on CONFIG_OF.

Power management functions are also left for volounteers with the ability
to actually test them.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
v2:                                                                              
 * Fix potential deadlocks pointed out by David.

v3:
 * Use devm_request_threaded_irq() and get rid of the work struct.
 * Drop ->open() and ->close() as it isn't actually needed for an
   interrupt-driven device. This way, we can also get rid of the
   locking entirely.

v4:
 * Follow Mark Rutland's advices regarding the DTS bindings:
    * Fix 'interrupt' node in the bindings documentation
    * Drop the subnode structure, and store keycodes in an array named
      'linux,keycodes'. This way, we no longer rely on subnodes
      ordering.
    * Use of_property_read_bool() to read boolean properties.

 * Re-introduce ->open() and ->close() for the input device, for
   power-saving purposes. Also, put the device to deep sleep at probe
   time, so it draws less power until ->open() is called.

 .../devicetree/bindings/input/cap1106.txt          |  53 ++++
 drivers/input/keyboard/Kconfig                     |  10 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/cap1106.c                   | 347 +++++++++++++++++++++
 4 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cap1106.txt
 create mode 100644 drivers/input/keyboard/cap1106.c

diff --git a/Documentation/devicetree/bindings/input/cap1106.txt b/Documentation/devicetree/bindings/input/cap1106.txt
new file mode 100644
index 0000000..4b46390
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cap1106.txt
@@ -0,0 +1,53 @@
+Device tree bindings for Microchip CAP1106, 6 channel capacitive touch sensor
+
+The node for this driver must be a child of a I2C controller node, as the
+device communication via I2C only.
+
+Required properties:
+
+	compatible:		Must be "microchip,cap1106"
+
+	reg:			The I2C slave address of the device.
+				Only 0x28 is valid.
+
+	interrupts:		Property describing the interrupt line the
+				device's ALERT#/CM_IRQ# pin is connected to.
+				The device only has one interrupt source.
+
+Optional properties:
+
+	autorepeat:		Enables the Linux input system's autorepeat
+				feature on the input device.
+
+	microchip,sensor-gain:	Defines the gain of the sensor circuitry. This
+				effectively controls the sensitivity, as a
+				smaller delta capacitance is required to
+				generate the same delta count values.
+				Valid values are 1, 2, 4, and 8.
+				By default, a gain of 1 is set.
+
+	linux,keycodes:		Specifies an array of numeric keycode values to
+				be used for the channels. If this property is
+				omitted, KEY_A, KEY_B, etc are used as
+				defaults. The array must have exactly six
+				entries.
+
+Example:
+
+i2c_controller {
+	cap1106@28 {
+		compatible = "microchip,cap1106";
+		interrupt-parent = <&gpio1>;
+		interrupts = <0 0>;
+		reg = <0x28>;
+		autorepeat;
+		microchip,sensor-gain = <2>;
+
+		linux,keycodes = <103		/* KEY_UP */
+				  106		/* KEY_RIGHT */
+				  108		/* KEY_DOWN */
+				  105		/* KEY_LEFT */
+				  109		/* KEY_PAGEDOWN */
+				  104>;		/* KEY_PAGEUP */
+	};
+}
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index f7e79b4..a3958c6 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -665,4 +665,14 @@ config KEYBOARD_CROS_EC
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_keyb.
 
+config KEYBOARD_CAP1106
+	tristate "Microchip CAP1106 touch sensor"
+	depends on OF && I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to enable the CAP1106 touch sensor driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cap1106.
+
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 7504ae1..0a33456 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_ATARI)		+= atakbd.o
 obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
 obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
+obj-$(CONFIG_KEYBOARD_CAP1106)		+= cap1106.o
 obj-$(CONFIG_KEYBOARD_CLPS711X)		+= clps711x-keypad.o
 obj-$(CONFIG_KEYBOARD_CROS_EC)		+= cros_ec_keyb.o
 obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
diff --git a/drivers/input/keyboard/cap1106.c b/drivers/input/keyboard/cap1106.c
new file mode 100644
index 0000000..5b416be
--- /dev/null
+++ b/drivers/input/keyboard/cap1106.c
@@ -0,0 +1,347 @@
+/*
+ * Input driver for Microchip CAP1106, 6 channel capacitive touch sensor
+ *
+ * http://www.microchip.com/wwwproducts/Devices.aspx?product=CAP1106
+ *
+ * (c) 2014 Daniel Mack <linux@zonque.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
+
+#define CAP1106_REG_MAIN_CONTROL	0x00
+#define CAP1106_REG_MAIN_CONTROL_GAIN_SHIFT	(6)
+#define CAP1106_REG_MAIN_CONTROL_GAIN_MASK	(0xc0)
+#define CAP1106_REG_MAIN_CONTROL_DLSEEP		BIT(4)
+#define CAP1106_REG_GENERAL_STATUS	0x02
+#define CAP1106_REG_SENSOR_INPUT	0x03
+#define CAP1106_REG_NOISE_FLAG_STATUS	0x0a
+#define CAP1106_REG_SENOR_DELTA(X)	(0x10 + (X))
+#define CAP1106_REG_SENSITIVITY_CONTROL	0x1f
+#define CAP1106_REG_CONFIG		0x20
+#define CAP1106_REG_SENSOR_ENABLE	0x21
+#define CAP1106_REG_SENSOR_CONFIG	0x22
+#define CAP1106_REG_SENSOR_CONFIG2	0x23
+#define CAP1106_REG_SAMPLING_CONFIG	0x24
+#define CAP1106_REG_CALIBRATION		0x25
+#define CAP1106_REG_INT_ENABLE		0x26
+#define CAP1106_REG_REPEAT_RATE		0x28
+#define CAP1106_REG_MT_CONFIG		0x2a
+#define CAP1106_REG_MT_PATTERN_CONFIG	0x2b
+#define CAP1106_REG_MT_PATTERN		0x2d
+#define CAP1106_REG_RECALIB_CONFIG	0x2f
+#define CAP1106_REG_SENSOR_THRESH(X)	(0x30 + (X))
+#define CAP1106_REG_SENSOR_NOISE_THRESH	0x38
+#define CAP1106_REG_STANDBY_CHANNEL	0x40
+#define CAP1106_REG_STANDBY_CONFIG	0x41
+#define CAP1106_REG_STANDBY_SENSITIVITY	0x42
+#define CAP1106_REG_STANDBY_THRESH	0x43
+#define CAP1106_REG_CONFIG2		0x44
+#define CAP1106_REG_SENSOR_BASE_CNT(X)	(0x50 + (X))
+#define CAP1106_REG_SENSOR_CALIB	(0xb1 + (X))
+#define CAP1106_REG_SENSOR_CALIB_LSB1	0xb9
+#define CAP1106_REG_SENSOR_CALIB_LSB2	0xba
+#define CAP1106_REG_PRODUCT_ID		0xfd
+#define CAP1106_REG_MANUFACTURER_ID	0xfe
+#define CAP1106_REG_REVISION		0xff
+
+#define CAP1106_NUM_CHN 6
+#define CAP1106_PRODUCT_ID	0x55
+#define CAP1106_MANUFACTURER_ID	0x5d
+
+struct cap1106_priv {
+	struct regmap *regmap;
+	struct input_dev *idev;
+
+	/* config */
+	unsigned int keycodes[CAP1106_NUM_CHN];
+};
+
+static const struct reg_default cap1106_reg_defaults[] = {
+	{ CAP1106_REG_MAIN_CONTROL,		0x00 },
+	{ CAP1106_REG_GENERAL_STATUS,		0x00 },
+	{ CAP1106_REG_SENSOR_INPUT,		0x00 },
+	{ CAP1106_REG_NOISE_FLAG_STATUS,	0x00 },
+	{ CAP1106_REG_SENSITIVITY_CONTROL,	0x2f },
+	{ CAP1106_REG_CONFIG,			0x20 },
+	{ CAP1106_REG_SENSOR_ENABLE,		0x3f },
+	{ CAP1106_REG_SENSOR_CONFIG,		0xa4 },
+	{ CAP1106_REG_SENSOR_CONFIG2,		0x07 },
+	{ CAP1106_REG_SAMPLING_CONFIG,		0x39 },
+	{ CAP1106_REG_CALIBRATION,		0x00 },
+	{ CAP1106_REG_INT_ENABLE,		0x3f },
+	{ CAP1106_REG_REPEAT_RATE,		0x3f },
+	{ CAP1106_REG_MT_CONFIG,		0x80 },
+	{ CAP1106_REG_MT_PATTERN_CONFIG,	0x00 },
+	{ CAP1106_REG_MT_PATTERN,		0x3f },
+	{ CAP1106_REG_RECALIB_CONFIG,		0x8a },
+	{ CAP1106_REG_SENSOR_THRESH(0),		0x40 },
+	{ CAP1106_REG_SENSOR_THRESH(1),		0x40 },
+	{ CAP1106_REG_SENSOR_THRESH(2),		0x40 },
+	{ CAP1106_REG_SENSOR_THRESH(3),		0x40 },
+	{ CAP1106_REG_SENSOR_THRESH(4),		0x40 },
+	{ CAP1106_REG_SENSOR_THRESH(5),		0x40 },
+	{ CAP1106_REG_SENSOR_NOISE_THRESH,	0x01 },
+	{ CAP1106_REG_STANDBY_CHANNEL,		0x00 },
+	{ CAP1106_REG_STANDBY_CONFIG,		0x39 },
+	{ CAP1106_REG_STANDBY_SENSITIVITY,	0x02 },
+	{ CAP1106_REG_STANDBY_THRESH,		0x40 },
+	{ CAP1106_REG_CONFIG2,			0x40 },
+	{ CAP1106_REG_SENSOR_CALIB_LSB1,	0x00 },
+	{ CAP1106_REG_SENSOR_CALIB_LSB2,	0x00 },
+};
+
+static bool cap1106_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CAP1106_REG_MAIN_CONTROL:
+	case CAP1106_REG_SENSOR_INPUT:
+	case CAP1106_REG_SENOR_DELTA(0):
+	case CAP1106_REG_SENOR_DELTA(1):
+	case CAP1106_REG_SENOR_DELTA(2):
+	case CAP1106_REG_SENOR_DELTA(3):
+	case CAP1106_REG_SENOR_DELTA(4):
+	case CAP1106_REG_SENOR_DELTA(5):
+	case CAP1106_REG_PRODUCT_ID:
+	case CAP1106_REG_MANUFACTURER_ID:
+	case CAP1106_REG_REVISION:
+		return true;
+	}
+
+	return false;
+}
+
+static const struct regmap_config cap1106_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = CAP1106_REG_REVISION,
+	.reg_defaults = cap1106_reg_defaults,
+
+	.num_reg_defaults = ARRAY_SIZE(cap1106_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = cap1106_volatile_reg,
+};
+
+static irqreturn_t cap1106_thread_func(int irq_num, void *data)
+{
+	struct cap1106_priv *priv = data;
+	unsigned int status;
+	int ret, i;
+
+	/*
+	 * Deassert interrupt. This needs to be done before reading the status
+	 * registers, which will not carry valid values otherwise.
+	 */
+	ret = regmap_update_bits(priv->regmap, CAP1106_REG_MAIN_CONTROL, 1, 0);
+	if (ret < 0)
+		goto out;
+
+	ret = regmap_read(priv->regmap, CAP1106_REG_SENSOR_INPUT, &status);
+	if (ret < 0)
+		goto out;
+
+	for (i = 0; i < CAP1106_NUM_CHN; i++)
+		input_report_key(priv->idev, priv->keycodes[i],
+				 status & (1 << i));
+
+	input_sync(priv->idev);
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int cap1106_set_sleep(struct cap1106_priv *priv, bool sleep)
+{
+	return regmap_update_bits(priv->regmap, CAP1106_REG_MAIN_CONTROL,
+				  CAP1106_REG_MAIN_CONTROL_DLSEEP,
+				  sleep ? CAP1106_REG_MAIN_CONTROL_DLSEEP : 0);
+}
+
+static int cap1106_input_open(struct input_dev *idev)
+{
+	struct cap1106_priv *priv = input_get_drvdata(idev);
+
+	return cap1106_set_sleep(priv, false);
+}
+
+static void cap1106_input_close(struct input_dev *idev)
+{
+	struct cap1106_priv *priv = input_get_drvdata(idev);
+
+	cap1106_set_sleep(priv, true);
+}
+
+static int cap1106_i2c_probe(struct i2c_client *i2c_client,
+			     const struct i2c_device_id *id)
+{
+	struct device *dev = &i2c_client->dev;
+	struct cap1106_priv *priv;
+	struct device_node *node;
+	int i, ret, irq, gain = 0;
+	unsigned int val, rev;
+	u32 gain32, keycodes[CAP1106_NUM_CHN];
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = devm_regmap_init_i2c(i2c_client, &cap1106_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	ret = regmap_read(priv->regmap, CAP1106_REG_PRODUCT_ID, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != CAP1106_PRODUCT_ID) {
+		dev_err(dev, "Product ID: Got 0x%02x, expected 0x%02x\n",
+			val, CAP1106_PRODUCT_ID);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(priv->regmap, CAP1106_REG_MANUFACTURER_ID, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != CAP1106_MANUFACTURER_ID) {
+		dev_err(dev, "Manufacturer ID: Got 0x%02x, expected 0x%02x\n",
+			val, CAP1106_MANUFACTURER_ID);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(priv->regmap, CAP1106_REG_REVISION, &rev);
+	if (ret < 0)
+		return ret;
+
+	dev_info(dev, "CAP1106 detected, revision 0x%02x\n", rev);
+	i2c_set_clientdata(i2c_client, priv);
+	node = dev->of_node;
+
+	if (!of_property_read_u32(node, "microchip,sensor-gain", &gain32)) {
+		if (is_power_of_2(gain32) && gain32 <= 8)
+			gain = ilog2(gain32);
+		else
+			dev_err(dev, "Invalid sensor-gain value %d\n", gain32);
+	}
+
+	BUILD_BUG_ON(ARRAY_SIZE(keycodes) != ARRAY_SIZE(priv->keycodes));
+
+	/* Provide some useful defaults */
+	for (i = 0; i < ARRAY_SIZE(keycodes); i++)
+		keycodes[i] = KEY_A + i;
+
+	of_property_read_u32_array(node, "linux,keycodes",
+				   keycodes, ARRAY_SIZE(keycodes));
+
+	for (i = 0; i < ARRAY_SIZE(keycodes); i++)
+		priv->keycodes[i] = keycodes[i];
+
+	ret = regmap_update_bits(priv->regmap, CAP1106_REG_MAIN_CONTROL,
+				 CAP1106_REG_MAIN_CONTROL_GAIN_MASK,
+				 gain << CAP1106_REG_MAIN_CONTROL_GAIN_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	/* Disable autorepeat. The Linux input system has its own handling. */
+	ret = regmap_write(priv->regmap, CAP1106_REG_REPEAT_RATE, 0);
+	if (ret < 0)
+		return ret;
+
+	priv->idev = devm_input_allocate_device(dev);
+	if (!priv->idev)
+		return -ENOMEM;
+
+	priv->idev->name = "CAP1106 capacitive touch sensor";
+	priv->idev->id.bustype = BUS_I2C;
+	priv->idev->evbit[0] = BIT_MASK(EV_KEY);
+
+	if (of_property_read_bool(node, "autorepeat"))
+		__set_bit(EV_REP, priv->idev->evbit);
+
+	for (i = 0; i < CAP1106_NUM_CHN; i++) {
+		unsigned int code = priv->keycodes[i];
+		priv->idev->keybit[BIT_WORD(code)] |= BIT_MASK(code);
+	}
+
+	priv->idev->id.vendor = CAP1106_MANUFACTURER_ID;
+	priv->idev->id.product = CAP1106_PRODUCT_ID;
+	priv->idev->id.version = rev;
+
+	priv->idev->open = cap1106_input_open;
+	priv->idev->close = cap1106_input_close;
+
+	input_set_drvdata(priv->idev, priv);
+
+	/*
+	 * Put the device in deep sleep mode for now.
+	 * ->open() will bring it back once the it is actually needed.
+	 */
+	cap1106_set_sleep(priv, true);
+
+	ret = input_register_device(priv->idev);
+	if (ret < 0)
+		return ret;
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (!irq) {
+		dev_err(dev, "Unable to parse or map IRQ\n");
+		return -ENXIO;
+	}
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, cap1106_thread_func,
+					IRQF_ONESHOT, dev_name(dev), priv);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int cap1106_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cap1106_priv *priv = i2c_get_clientdata(i2c_client);
+
+	input_unregister_device(priv->idev);
+
+	return 0;
+}
+
+static const struct of_device_id cap1106_dt_ids[] = {
+	{ .compatible = "microchip,cap1106", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cap1106_dt_ids);
+
+static const struct i2c_device_id cap1106_i2c_ids[] = {
+	{ "cap1106", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cap1106_i2c_ids);
+
+static struct i2c_driver cap1106_i2c_driver = {
+	.driver = {
+		.name	= "cap1106",
+		.owner	= THIS_MODULE,
+		.of_match_table = cap1106_dt_ids,
+	},
+	.id_table	= cap1106_i2c_ids,
+	.probe		= cap1106_i2c_probe,
+	.remove		= cap1106_i2c_remove,
+};
+
+module_i2c_driver(cap1106_i2c_driver);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DESCRIPTION("Microchip CAP1106 driver");
+MODULE_AUTHOR("Daniel Mack <linux@zonque.org>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.3

