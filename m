From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH 1/2] input: st1232: Add reset pin handling
Date: Sat,  6 Apr 2013 15:18:45 +0200
Message-ID: <1365254327-10408-1-git-send-email-hechtb+renesas@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

We add the possiblity to hand over a GPIO number for the reset pin.
This way we can remove existing board code that takes care of it and
group this information properly in the platform data or in the device
tree confguration.

The implementation is analogous to the cy8ctmg110 driver, thanks.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 .../bindings/input/touchscreen/sitronix-st1232.txt |   24 ++++++++++
 drivers/input/touchscreen/st1232.c                 |   47 ++++++++++++++++++--
 include/linux/input/st1232_pdata.h                 |   13 ++++++
 3 files changed, 81 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
 create mode 100644 include/linux/input/st1232_pdata.h

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
new file mode 100644
index 0000000..1936969
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
@@ -0,0 +1,24 @@
+* Sitronix st1232 touchscreen controller
+
+Required properties:
+- compatible: must be "sitronix,st1232"
+- reg: I2C address of the chip
+- interrupts: interrupt to which the chip is connected
+
+Optional properties:
+- sitronix,reset-pin: GPIO number of the reset pin
+
+Example:
+
+	i2c@00000000 {
+		/* ... */
+
+		touchscreen@55 {
+			compatible = "sitronix,st1232";
+			reg = <0x55>;
+			interrupts = <2 0>;
+			sitronix,reset-pin = <166>;
+		};
+
+		/* ... */
+	};
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index d9d05e2..6aa5038 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
@@ -26,6 +27,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/input/st1232_pdata.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 
@@ -48,6 +50,7 @@ struct st1232_ts_data {
 	struct input_dev *input_dev;
 	struct st1232_ts_finger finger[MAX_FINGERS];
 	struct dev_pm_qos_request low_latency_req;
+	int reset_pin;
 };
 
 static int st1232_ts_read_data(struct st1232_ts_data *ts)
@@ -139,10 +142,17 @@ end:
 	return IRQ_HANDLED;
 }
 
+static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
+{
+	if (ts->reset_pin)
+		gpio_direction_output(ts->reset_pin, poweron);
+}
+
 static int st1232_ts_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct st1232_ts_data *ts;
+	struct st1232_pdata *pdata = client->dev.platform_data;
 	struct input_dev *input_dev;
 	int error;
 
@@ -167,6 +177,25 @@ static int st1232_ts_probe(struct i2c_client *client,
 	ts->client = client;
 	ts->input_dev = input_dev;
 
+	if (client->dev.of_node)
+		of_property_read_u32(client->dev.of_node,
+				"sitronix,reset-pin", &ts->reset_pin);
+	else if (pdata)
+		ts->reset_pin = pdata->reset_pin;
+
+
+	if (ts->reset_pin) {
+		error = gpio_request(ts->reset_pin, NULL);
+		if (error) {
+			dev_err(&client->dev,
+				"Unable to request GPIO pin %d.\n",
+				ts->reset_pin);
+				goto err_free_mem;
+		}
+	}
+
+	st1232_ts_power(ts, true);
+
 	input_dev->name = "st1232-touchscreen";
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
@@ -183,7 +212,7 @@ static int st1232_ts_probe(struct i2c_client *client,
 				     IRQF_ONESHOT, client->name, ts);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto err_free_mem;
+		goto err_free_reset_gpio;
 	}
 
 	error = input_register_device(ts->input_dev);
@@ -200,6 +229,9 @@ static int st1232_ts_probe(struct i2c_client *client,
 
 err_free_irq:
 	free_irq(client->irq, ts);
+err_free_reset_gpio:
+	if (ts->reset_pin)
+		gpio_free(ts->reset_pin);
 err_free_mem:
 	input_free_device(input_dev);
 	kfree(ts);
@@ -210,8 +242,11 @@ static int st1232_ts_remove(struct i2c_client *client)
 {
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
+	st1232_ts_power(ts, false);
 	device_init_wakeup(&client->dev, 0);
 	free_irq(client->irq, ts);
+	if (ts->reset_pin)
+		gpio_free(ts->reset_pin);
 	input_unregister_device(ts->input_dev);
 	kfree(ts);
 
@@ -222,11 +257,14 @@ static int st1232_ts_remove(struct i2c_client *client)
 static int st1232_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(&client->dev))
 		enable_irq_wake(client->irq);
-	else
+	else {
 		disable_irq(client->irq);
+		st1232_ts_power(ts, false);
+	}
 
 	return 0;
 }
@@ -234,11 +272,14 @@ static int st1232_ts_suspend(struct device *dev)
 static int st1232_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(&client->dev))
 		disable_irq_wake(client->irq);
-	else
+	else {
+		st1232_ts_power(ts, true);
 		enable_irq(client->irq);
+	}
 
 	return 0;
 }
diff --git a/include/linux/input/st1232_pdata.h b/include/linux/input/st1232_pdata.h
new file mode 100644
index 0000000..ef99354
--- /dev/null
+++ b/include/linux/input/st1232_pdata.h
@@ -0,0 +1,13 @@
+#ifndef _LINUX_ST1232_PDATA_H
+#define _LINUX_ST1232_PDATA_H
+
+/*
+ * Optional platform data
+ *
+ * Use this if you want the driver to drive the reset pin.
+ */
+struct st1232_pdata {
+	int reset_pin;
+};
+
+#endif
-- 
1.7.9.5

