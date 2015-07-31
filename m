From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v4 1/8] Input: goodix - reset device at init
Date: Fri, 31 Jul 2015 20:42:05 +0300
Message-ID: <1438364532-27150-2-git-send-email-irina.tirdea@intel.com>
References: <1438364532-27150-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438364532-27150-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

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
 drivers/input/touchscreen/goodix.c                 | 136 +++++++++++++++++++++
 2 files changed, 141 insertions(+)

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
index e36162b..d039643 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/gpio.h>
 #include <linux/of.h>
 #include <asm/unaligned.h>
 
@@ -36,6 +37,8 @@ struct goodix_ts_data {
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
 	bool rotated_screen;
+	struct gpio_desc *gpiod_int;
+	struct gpio_desc *gpiod_rst;
 };
 
 #define GOODIX_MAX_HEIGHT		4096
@@ -86,6 +89,30 @@ static const struct dmi_system_id rotated_screen[] = {
 	{}
 };
 
+/*
+ * ACPI table specifies gpio pins in this order: first rst pin and
+ * then interrupt pin.
+ */
+static const struct dmi_system_id goodix_rst_pin_first[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		.ident = "WinBook TW100",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "WinBook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TW100")
+		}
+	},
+	{
+		.ident = "WinBook TW700",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "WinBook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TW700")
+		},
+	},
+#endif
+	{}
+};
+
 /**
  * goodix_i2c_read - read data from a register of the i2c slave device.
  *
@@ -217,6 +244,102 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
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
+	struct gpio_desc *gpiod;
+	/* Default gpio pin order: irq, rst */
+	int irq_idx = 0, rst_idx = 1;
+
+	if (!ts->client)
+		return -EINVAL;
+	dev = &ts->client->dev;
+
+	if (dmi_check_system(goodix_rst_pin_first)) {
+		dev_dbg(&ts->client->dev,
+			"Applying 'reverse gpio pin order' quirk\n");
+		rst_idx = 0;
+		irq_idx = 1;
+	}
+
+	/* Get interrupt GPIO pin number */
+	gpiod = devm_gpiod_get_index(dev, NULL, irq_idx, GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_warn(dev, "Failed to get GPIO %d: %d\n",
+				 irq_idx, ret);
+		if (ret == -ENOENT)
+			return 0;
+		return ret;
+	}
+	ts->gpiod_int = gpiod;
+
+	/* Get the reset line GPIO pin number */
+	gpiod = devm_gpiod_get_index(dev, NULL, rst_idx, GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_warn(dev, "Failed to get GPIO %d: %d\n",
+				 rst_idx, ret);
+		if (ret == -ENOENT)
+			return 0;
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
@@ -398,6 +521,19 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	error = goodix_get_gpio_config(ts, id);
+	if (error)
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
-- 
1.9.1
