From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 12/26] Input: synaptics-rmi4: Use generic interrupt handling
Date: Thu, 5 Nov 2015 15:40:07 -0800
Message-ID: <1446766807-30760-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:65225 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965324AbbKEXkP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Nov 2015 18:40:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

Currently the RMI4 driver expects the device to have a GPIO and manages
the that GPIO internally. However, this duplicates functionality which
could be handled by more generic interrupt handling code. Also, some
RMI devices will not have a GPIO or it won't be accessible to the rmi4
driver. This patch removes the GPIO code and instead gets the irq passed
up from the underlying transport (ie i2c-core).

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_bus.h    |  3 ++
 drivers/input/rmi4/rmi_driver.c | 81 +++++++----------------------------------
 drivers/input/rmi4/rmi_driver.h |  2 -
 drivers/input/rmi4/rmi_i2c.c    | 28 +++-----------
 include/linux/rmi.h             | 21 ++---------
 5 files changed, 24 insertions(+), 111 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 41d6c3d..2a892be 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -175,6 +175,9 @@ struct rmi_transport_dev {
 	struct device *dev;
 	struct rmi_device *rmi_dev;
 
+	int irq;
+	int irq_flags;
+
 	irqreturn_t (*irq_thread)(int irq, void *p);
 	irqreturn_t (*hard_irq)(int irq, void *p);
 
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 81e7c55..5efcaca 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/fs.h>
-#include <linux/gpio.h>
 #include <linux/kconfig.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -42,27 +41,18 @@
 
 #define DEFAULT_POLL_INTERVAL_MS	13
 
-#define IRQ_DEBUG(data) (IS_ENABLED(CONFIG_RMI4_DEBUG) && data->irq_debug)
-
 static irqreturn_t rmi_irq_thread(int irq, void *p)
 {
 	struct rmi_transport_dev *xport = p;
 	struct rmi_device *rmi_dev = xport->rmi_dev;
 	struct rmi_driver *driver = rmi_dev->driver;
-	struct rmi_device_platform_data *pdata = xport->dev->platform_data;
 	struct rmi_driver_data *data;
 
 	data = dev_get_drvdata(&rmi_dev->dev);
 
-	if (IRQ_DEBUG(data))
-		dev_dbg(xport->dev, "ATTN gpio, value: %d.\n",
-				gpio_get_value(pdata->attn_gpio));
-
-	if (gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity) {
-		data->attn_count++;
-		if (driver && driver->irq_handler && rmi_dev)
-			driver->irq_handler(rmi_dev, irq);
-	}
+	data->attn_count++;
+	if (driver && driver->irq_handler && rmi_dev)
+		driver->irq_handler(rmi_dev, irq);
 
 	return IRQ_HANDLED;
 }
@@ -128,9 +118,9 @@ static void disable_sensor(struct rmi_device *rmi_dev)
 	if (rmi_dev->xport->ops->disable_device)
 		rmi_dev->xport->ops->disable_device(rmi_dev->xport);
 
-	if (data->irq) {
-		disable_irq(data->irq);
-		free_irq(data->irq, rmi_dev->xport);
+	if (rmi_dev->xport->irq > 0) {
+		disable_irq(rmi_dev->xport->irq);
+		free_irq(rmi_dev->xport->irq, rmi_dev->xport);
 	}
 
 	data->enabled = false;
@@ -302,12 +292,12 @@ static int enable_sensor(struct rmi_device *rmi_dev)
 		return retval;
 
 	xport = rmi_dev->xport;
-	if (data->irq) {
-		retval = request_threaded_irq(data->irq,
+	if (xport->irq) {
+		retval = request_threaded_irq(xport->irq,
 				xport->hard_irq ? xport->hard_irq : NULL,
 				xport->irq_thread ?
 					xport->irq_thread : rmi_irq_thread,
-				data->irq_flags,
+				xport->irq_flags,
 				dev_name(&rmi_dev->dev), xport);
 		if (retval)
 			return retval;
@@ -753,17 +743,12 @@ static int rmi_driver_remove(struct device *dev)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	const struct rmi_device_platform_data *pdata =
-					rmi_get_platform_data(rmi_dev);
 
 	if (data->input)
 		input_unregister_device(data->input);
 	disable_sensor(rmi_dev);
 	rmi_free_function_list(rmi_dev);
 
-	if (data->gpio_held)
-		gpio_free(pdata->attn_gpio);
-
 	kfree(data->irq_status);
 	kfree(data);
 
@@ -922,48 +907,10 @@ static int rmi_driver_probe(struct device *dev)
 		}
 	}
 
-	if (gpio_is_valid(pdata->attn_gpio)) {
-		static const char GPIO_LABEL[] = "attn";
-		unsigned long gpio_flags = GPIOF_DIR_IN;
-
-		data->irq = gpio_to_irq(pdata->attn_gpio);
-		if (pdata->level_triggered) {
-			data->irq_flags = IRQF_ONESHOT |
-				((pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
-				? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW);
-		} else {
-			data->irq_flags =
-				(pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
-				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
-		}
-
-		if (IS_ENABLED(CONFIG_RMI4_DEV))
-			gpio_flags |= GPIOF_EXPORT;
-
-		retval = gpio_request_one(pdata->attn_gpio, gpio_flags,
-					  GPIO_LABEL);
-		if (retval) {
-			dev_warn(dev, "WARNING: Failed to request ATTN gpio %d, code=%d.\n",
-				 pdata->attn_gpio, retval);
-			retval = 0;
-		} else {
-			dev_info(dev, "Obtained ATTN gpio %d.\n",
-					pdata->attn_gpio);
-			data->gpio_held = true;
-			if (IS_ENABLED(CONFIG_RMI4_DEV)) {
-				retval = gpio_export_link(dev,
-						GPIO_LABEL, pdata->attn_gpio);
-				if (retval) {
-					dev_warn(dev,
-						"WARNING: Failed to symlink ATTN gpio!\n");
-					retval = 0;
-				} else {
-					dev_info(dev, "Exported ATTN gpio %d.",
-						pdata->attn_gpio);
-				}
-			}
-		}
-	} else if (pdata->attn_gpio == RMI_POLLING) {
+	if (rmi_dev->xport->irq > 0) {
+		if (!rmi_dev->xport->hard_irq)
+			rmi_dev->xport->irq_flags |= IRQF_ONESHOT;
+	} else if (data->polling) {
 		data->poll_interval = ktime_set(0,
 			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
 			DEFAULT_POLL_INTERVAL_MS) * 1000 * 1000);
@@ -982,8 +929,6 @@ err_destroy_functions:
 	rmi_free_function_list(rmi_dev);
 	kfree(irq_memory);
 err_free_mem:
-	if (data->gpio_held)
-		gpio_free(pdata->attn_gpio);
 	kfree(data);
 	return retval < 0 ? retval : 0;
 }
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 8a2d91a..4e99e48 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -41,8 +41,6 @@ struct rmi_driver_data {
 	bool f01_bootloader_mode;
 
 	u32 attn_count;
-	u32 irq_debug;	/* Should be bool, but debugfs wants u32 */
-	bool gpio_held;
 	bool polling;
 	int irq;
 	int irq_flags;
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 24d8a04..277cdc8 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -196,9 +196,9 @@ static int rmi_i2c_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	dev_dbg(&client->dev, "Probing %s at %#02x (GPIO %d).\n",
+	dev_dbg(&client->dev, "Probing %s at %#02x.\n",
 		pdata->sensor_name ? pdata->sensor_name : "-no name-",
-		client->addr, pdata->attn_gpio);
+		client->addr);
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(&client->dev,
@@ -206,15 +206,6 @@ static int rmi_i2c_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	if (pdata->gpio_config) {
-		retval = pdata->gpio_config(pdata->gpio_data, true);
-		if (retval < 0) {
-			dev_err(&client->dev, "Failed to configure GPIOs, code: %d.\n",
-				retval);
-			return retval;
-		}
-	}
-
 	rmi_i2c = devm_kzalloc(&client->dev, sizeof(struct rmi_i2c_xport),
 				GFP_KERNEL);
 	if (!rmi_i2c)
@@ -226,6 +217,8 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	rmi_i2c->xport.dev = &client->dev;
 	rmi_i2c->xport.proto_name = "i2c";
 	rmi_i2c->xport.ops = &rmi_i2c_ops;
+	rmi_i2c->xport.irq = client->irq;
+	rmi_i2c->xport.irq_flags = pdata->irq_flags;
 
 	/*
 	 * Setting the page to zero will (a) make sure the PSR is in a
@@ -241,7 +234,7 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	if (retval) {
 		dev_err(&client->dev, "Failed to register transport driver at 0x%.2X.\n",
 			client->addr);
-		goto err_gpio;
+		return retval;
 	}
 
 	i2c_set_clientdata(client, rmi_i2c);
@@ -249,25 +242,14 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	dev_info(&client->dev, "registered rmi i2c driver at %#04x.\n",
 			client->addr);
 	return 0;
-
-err_gpio:
-	if (pdata->gpio_config)
-		pdata->gpio_config(pdata->gpio_data, false);
-
-	return retval;
 }
 
 static int rmi_i2c_remove(struct i2c_client *client)
 {
-	const struct rmi_device_platform_data *pdata =
-				dev_get_platdata(&client->dev);
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
 
 	rmi_unregister_transport_device(&rmi_i2c->xport);
 
-	if (pdata->gpio_config)
-		pdata->gpio_config(pdata->gpio_data, false);
-
 	return 0;
 }
 
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index f270ff9..9a0152c 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -215,22 +215,11 @@ struct rmi_device_platform_data_spi {
  *
  * @sensor_name - this is used for various diagnostic messages.
  *
+ * @irq_flags - this is used to specify intrerrupt type flags.
+ *
  * @firmware_name - if specified will override default firmware name,
  * for reflashing.
  *
- * @attn_gpio - the index of a GPIO that will be used to provide the ATTN
- * interrupt from the touch sensor.
- * @attn_polarity - indicates whether ATTN is active high or low.
- * @level_triggered - by default, the driver uses edge triggered interrupts.
- * However, this can cause problems with suspend/resume on some platforms.  In
- * that case, set this to 1 to use level triggered interrupts.
- * @gpio_config - a routine that will be called when the driver is loaded to
- * perform any platform specific GPIO configuration, and when it is unloaded
- * for GPIO de-configuration.  This is typically used to configure the ATTN
- * GPIO and the I2C or SPI pins, if necessary.
- * @gpio_data - platform specific data to be passed to the GPIO configuration
- * function.
- *
  * @poll_interval_ms - the time in milliseconds between reads of the interrupt
  * status register.  This is ignored if attn_gpio is non-zero.
  *
@@ -268,11 +257,7 @@ struct rmi_device_platform_data_spi {
 struct rmi_device_platform_data {
 	char *sensor_name;	/* Used for diagnostics. */
 
-	int attn_gpio;
-	enum rmi_attn_polarity attn_polarity;
-	bool level_triggered;
-	void *gpio_data;
-	int (*gpio_config)(void *gpio_data, bool configure);
+	int irq_flags;
 
 	int poll_interval_ms;
 
-- 
2.1.4

