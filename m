From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v3 1/5] Input: goodix - reset device at init
Date: Mon, 29 Jun 2015 19:28:20 +0300
Message-ID: <1435595304-4840-2-git-send-email-irina.tirdea@intel.com>
References: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52189 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbbF2Q3c (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 12:29:32 -0400
In-Reply-To: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>

After power on, it is recommended that the driver resets the device.
The reset procedure timing is described in the datasheet and is used
at device init (before writing device configuration) and
for power management. It is a sequence of setting the interrupt
and reset pins high/low at specific timing intervals. This procedure
also includes setting the slave address to the one specified in the
ACPI/device tree.

This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
driver gt9xx.c for Android (publicly available in Android kernel
trees for various devices).

For reset the driver needs to control the interrupt and
reset gpio pins (configured through ACPI/device tree). For devices
that do not have the gpio pins declared, the functionality depending
on these pins will not be available, but the device can still be used
with basic functionality.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 .../bindings/input/touchscreen/goodix.txt          |   5 +
 drivers/input/touchscreen/goodix.c                 | 131 ++++++++++++++++++++-
 2 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 8ba98ee..c0715f8 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -12,6 +12,8 @@ Required properties:
  - reg			: I2C address of the chip. Should be 0x5d or 0x14
  - interrupt-parent	: Interrupt controller to which the chip is connected
  - interrupts		: Interrupt to which the chip is connected
+ - gpios		: GPIOS the chip is connected to: first one is the
+			  interrupt gpio and second one the reset gpio.
 
 Example:
 
@@ -23,6 +25,9 @@ Example:
 			reg = <0x5d>;
 			interrupt-parent = <&gpio>;
 			interrupts = <0 0>;
+
+			gpios = <&gpio1 0 0>, /* INT */
+				<&gpio1 1 0>; /* RST */
 		};
 
 		/* ... */
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index b4d12e2..80100f9 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/gpio.h>
 #include <linux/of.h>
 #include <asm/unaligned.h>
 
@@ -34,6 +35,13 @@ struct goodix_ts_data {
 	int abs_y_max;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	struct gpio_desc *gpiod_int;
+	struct gpio_desc *gpiod_rst;
+};
+
+struct goodix_gpio_data {
+	u8 irq_idx;
+	u8 rst_idx;
 };
 
 #define GOODIX_MAX_HEIGHT		4096
@@ -60,6 +68,16 @@ static const unsigned long goodix_irq_flags[] = {
 	IRQ_TYPE_LEVEL_HIGH,
 };
 
+static const struct goodix_gpio_data goodix_gpio_irq_rst = {
+	.irq_idx = 0,
+	.rst_idx = 1,
+};
+
+static const struct goodix_gpio_data goodix_gpio_rst_irq = {
+	.irq_idx = 1,
+	.rst_idx = 0,
+};
+
 /**
  * goodix_i2c_read - read data from a register of the i2c slave device.
  *
@@ -186,6 +204,102 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int goodix_int_sync(struct goodix_ts_data *ts)
+{
+	int ret;
+
+	ret = gpiod_direction_output(ts->gpiod_int, 0);
+	if (ret)
+		return ret;
+	msleep(50);				/* T5: 50ms */
+
+	return gpiod_direction_input(ts->gpiod_int);
+}
+
+/**
+ * goodix_reset - Reset device during power on
+ *
+ * @ts: goodix_ts_data pointer
+ */
+static int goodix_reset(struct goodix_ts_data *ts)
+{
+	int ret;
+
+	/* begin select I2C slave addr */
+	ret = gpiod_direction_output(ts->gpiod_rst, 0);
+	if (ret)
+		return ret;
+	msleep(20);				/* T2: > 10ms */
+	/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
+	ret = gpiod_direction_output(ts->gpiod_int, ts->client->addr == 0x14);
+	if (ret)
+		return ret;
+	usleep_range(100, 2000);		/* T3: > 100us */
+	ret = gpiod_direction_output(ts->gpiod_rst, 1);
+	if (ret)
+		return ret;
+	usleep_range(6000, 10000);		/* T4: > 5ms */
+	/* end select I2C slave addr */
+	ret = gpiod_direction_input(ts->gpiod_rst);
+	if (ret)
+		return ret;
+	return goodix_int_sync(ts);
+}
+
+/**
+ * goodix_get_gpio_config - Get GPIO config from ACPI/DT
+ *
+ * @ts: goodix_ts_data pointer
+ */
+static int goodix_get_gpio_config(struct goodix_ts_data *ts,
+				  const struct i2c_device_id *i2c_id)
+{
+	int ret;
+	struct device *dev;
+	const struct acpi_device_id *acpi_id;
+	struct gpio_desc *gpiod;
+	/* Default gpio pin order: irq, rst */
+	const struct goodix_gpio_data *gpio = &goodix_gpio_irq_rst;
+
+	if (!ts->client)
+		return -EINVAL;
+	dev = &ts->client->dev;
+
+	/* Set gpio pin order if specified in chip data */
+	if (i2c_id) {
+		if (i2c_id->driver_data)
+			gpio = (struct goodix_gpio_data *)i2c_id->driver_data;
+	} else if (ACPI_HANDLE(dev)) {
+		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
+		if (acpi_id)
+			gpio = (struct goodix_gpio_data *)acpi_id->driver_data;
+	}
+
+	/* Get interrupt GPIO pin number */
+	gpiod = devm_gpiod_get_index(dev, NULL, gpio->irq_idx, GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_warn(dev, "Failed to get GPIO %d: %d\n",
+				 gpio->irq_idx, ret);
+		return ret;
+	}
+	ts->gpiod_int = gpiod;
+
+	/* Get the reset line GPIO pin number */
+	gpiod = devm_gpiod_get_index(dev, NULL, gpio->rst_idx, GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_warn(dev, "Failed to get GPIO %d: %d\n",
+				 gpio->rst_idx, ret);
+		return ret;
+	}
+	ts->gpiod_rst = gpiod;
+
+	return 0;
+}
+
 /**
  * goodix_read_config - Read the embedded configuration of the panel
  *
@@ -362,6 +476,19 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	error = goodix_get_gpio_config(ts, id);
+	if (error && error != -ENOENT)
+		return error;
+
+	if (ts->gpiod_int && ts->gpiod_rst) {
+		/* reset the controller */
+		error = goodix_reset(ts);
+		if (error) {
+			dev_err(&client->dev, "Controller reset failed.\n");
+			return error;
+		}
+	}
+
 	goodix_read_config(ts);
 
 	error = goodix_request_input_dev(ts, version_info, id_info);
@@ -381,13 +508,13 @@ static int goodix_ts_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id goodix_ts_id[] = {
-	{ "GDIX1001:00", 0 },
+	{ "GDIX1001:00", (kernel_ulong_t)&goodix_gpio_rst_irq },
 	{ }
 };
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id goodix_acpi_match[] = {
-	{ "GDIX1001", 0 },
+	{ "GDIX1001", (kernel_ulong_t)&goodix_gpio_rst_irq },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
-- 
1.9.1

