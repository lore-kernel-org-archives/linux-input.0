From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 5/9] input: goodix: reset device at init
Date: Thu, 28 May 2015 15:47:41 +0300
Message-ID: <1432817265-23891-6-git-send-email-irina.tirdea@intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42892 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbbE1MsY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 08:48:24 -0400
In-Reply-To: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>

After power on, it is recommended that the driver resets the device.
For reset the driver needs to control the interrupt and
reset gpio pins (configured through ACPI/device tree).

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 .../bindings/input/touchscreen/goodix.txt          |  5 ++
 drivers/input/touchscreen/goodix.c                 | 99 ++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 8ba98ee..7137881 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -12,6 +12,8 @@ Required properties:
  - reg			: I2C address of the chip. Should be 0x5d or 0x14
  - interrupt-parent	: Interrupt controller to which the chip is connected
  - interrupts		: Interrupt to which the chip is connected
+ - irq-gpio		: GPIO pin used for IRQ
+ - reset-gpio		: GPIO pin used for reset
 
 Example:
 
@@ -23,6 +25,9 @@ Example:
 			reg = <0x5d>;
 			interrupt-parent = <&gpio>;
 			interrupts = <0 0>;
+
+			irq-gpio = <&gpio1 0 0>;
+			reset-gpio = <&gpio1 1 0>;
 		};
 
 		/* ... */
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 9e7d215..4405c55 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -26,6 +26,7 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <asm/unaligned.h>
+#include <linux/gpio.h>
 
 struct goodix_ts_data {
 	struct i2c_client *client;
@@ -34,8 +35,12 @@ struct goodix_ts_data {
 	int abs_y_max;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	struct gpio_desc *gpiod_int;
+	struct gpio_desc *gpiod_rst;
 };
 
+#define GOODIX_GPIO_INT_NAME		"irq"
+#define GOODIX_GPIO_RST_NAME		"reset"
 #define GOODIX_MAX_HEIGHT		4096
 #define GOODIX_MAX_WIDTH		4096
 #define GOODIX_INT_TRIGGER		1
@@ -187,6 +192,89 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int goodix_int_sync(struct goodix_ts_data *ts)
+{
+	int ret;
+
+	ret = gpiod_direction_output(ts->gpiod_int, 0);
+	if (ret)
+		return ret;
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
+	ret = goodix_int_sync(ts);
+	if (ret)
+		return ret;
+	msleep(50);				/* T5: 50ms */
+	return 0;
+}
+
+/**
+ * goodix_get_gpio_config - Get GPIO config from ACPI/DT
+ *
+ * @ts: goodix_ts_data pointer
+ */
+static int goodix_get_gpio_config(struct goodix_ts_data *ts)
+{
+	struct device *dev;
+	struct gpio_desc *gpiod;
+	int ret;
+
+	if (!ts->client)
+		return -EINVAL;
+	dev = &ts->client->dev;
+
+	/* Get interrupt GPIO pin number */
+	gpiod = devm_gpiod_get(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		dev_err(dev, "Failed to get %s GPIO: %d\n",
+			GOODIX_GPIO_INT_NAME, ret);
+		return ret;
+	}
+	ts->gpiod_int = gpiod;
+
+	/* Get the reset line GPIO pin number */
+	gpiod = devm_gpiod_get(dev, GOODIX_GPIO_RST_NAME, GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		dev_err(dev, "Failed to get %s GPIO: %d\n",
+			GOODIX_GPIO_RST_NAME, ret);
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
@@ -366,6 +454,17 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	error = goodix_get_gpio_config(ts);
+	if (error)
+		return error;
+
+	/* reset the controller */
+	error = goodix_reset(ts);
+	if (error) {
+		dev_err(&client->dev, "Controller reset failed.\n");
+		return error;
+	}
+
 	goodix_read_config(ts);
 
 	error = goodix_request_input_dev(ts, version_info, id_info);
-- 
1.9.1

