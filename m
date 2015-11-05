From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 25/26] Input: synaptics-rmi4: remove sensor_name in platform data
Date: Thu, 5 Nov 2015 15:43:05 -0800
Message-ID: <1446766985-31350-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

The platform data contained a sensor_name string which was used in debug
logs to identify the device. But, the logs already contain enough
information to uniquely identify the device. This patch removes the
sensor_name and substitutes the transport device's name or the
rmi device's when needed.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_bus.c    | 3 +--
 drivers/input/rmi4/rmi_driver.c | 7 ++-----
 drivers/input/rmi4/rmi_f11.c    | 3 +--
 drivers/input/rmi4/rmi_i2c.c    | 5 +----
 include/linux/rmi.h             | 2 --
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index c50ddfc..a04468d 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -54,7 +54,6 @@ bool rmi_is_physical_device(struct device *dev)
 int rmi_register_transport_device(struct rmi_transport_dev *xport)
 {
 	static atomic_t transport_device_count = ATOMIC_INIT(0);
-	struct rmi_device_platform_data *pdata = &xport->pdata;
 	struct rmi_device *rmi_dev;
 	int error;
 
@@ -79,7 +78,7 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
 		goto err_put_device;
 
 	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
-		pdata->sensor_name, dev_name(&rmi_dev->dev));
+		dev_name(rmi_dev->xport->dev), dev_name(&rmi_dev->dev));
 
 	return 0;
 
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 328a0e5..1fd6ed2 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -819,14 +819,12 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 {
 	struct device *dev = &rmi_dev->dev;
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	const struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
 	int *current_irq_count = ctx;
 	struct rmi_function *fn;
 	int i;
 	int error;
 
-	dev_dbg(dev, "Initializing F%02X for %s.\n",
-		pdt->function_number, pdata->sensor_name);
+	dev_dbg(dev, "Initializing F%02X.\n", pdt->function_number);
 
 	fn = kzalloc(sizeof(struct rmi_function) +
 			BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
@@ -1058,8 +1056,7 @@ static int rmi_driver_probe(struct device *dev)
 	irq_count = 0;
 	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_count_irqs);
 	if (retval < 0) {
-		dev_err(dev, "IRQ counting for %s failed with code %d.\n",
-			pdata->sensor_name, retval);
+		dev_err(dev, "IRQ counting failed with code %d.\n", retval);
 		goto err_free_mem;
 	}
 	data->irq_count = irq_count;
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 10a0c11..33da583 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1038,8 +1038,7 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	u8 buf;
 	int mask_size;
 
-	dev_dbg(&fn->dev, "Initializing F11 values for %s.\n",
-		 pdata->sensor_name);
+	dev_dbg(&fn->dev, "Initializing F11 values.\n");
 
 	mask_size = BITS_TO_LONGS(drvdata->irq_count) * sizeof(unsigned long);
 
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 62cc8ba..6c63623 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -211,10 +211,7 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	if (!client->dev.of_node)
 		*pdata = *client_pdata;
 
-	dev_dbg(&client->dev, "Probing %s at %#02x.\n",
-		pdata->sensor_name ? pdata->sensor_name : "-no name-",
-		client->addr);
-
+	dev_dbg(&client->dev, "Probing %s.\n", dev_name(&client->dev));
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(&client->dev,
 			"adapter does not support required functionality.\n");
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 2e4c658..c5663c7 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -267,8 +267,6 @@ struct rmi_device_platform_data_spi {
  * functions.
  */
 struct rmi_device_platform_data {
-	char *sensor_name;	/* Used for diagnostics. */
-
 	int irq_flags;
 
 	int poll_interval_ms;
-- 
2.1.4
