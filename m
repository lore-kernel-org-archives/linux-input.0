From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH v3 1/2] input: st1232: Add reset pin handling
Date: Wed, 10 Apr 2013 23:41:22 +0200
Message-ID: <1365630083-9758-1-git-send-email-hechtb+renesas@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-input@vger.kernel.org
Cc: Laurent Pichart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

We add the possiblity to hand over a GPIO number for the reset pin.
This way we can remove existing board code that takes care of it and
group this information properly in the platform data or in the device
tree confguration.

The implementation is analogous to the cy8ctmg110 driver, thanks.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v3:
- Based on Laurent Pinchart's patch:
  input: st1232: Convert to devm_* infrastructure

- use gpio_valid()

- reorder probing for reset_gpio data

 drivers/input/touchscreen/st1232.c |   43 ++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index f091451..874e0ff 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -19,13 +19,16 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/input/st1232_pdata.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 
@@ -48,6 +51,7 @@ struct st1232_ts_data {
 	struct input_dev *input_dev;
 	struct st1232_ts_finger finger[MAX_FINGERS];
 	struct dev_pm_qos_request low_latency_req;
+	int reset_gpio;
 };
 
 static int st1232_ts_read_data(struct st1232_ts_data *ts)
@@ -139,10 +143,17 @@ end:
 	return IRQ_HANDLED;
 }
 
+static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
+{
+	if (gpio_is_valid(ts->reset_gpio))
+		gpio_direction_output(ts->reset_gpio, poweron);
+}
+
 static int st1232_ts_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct st1232_ts_data *ts;
+	struct st1232_pdata *pdata = client->dev.platform_data;
 	struct input_dev *input_dev;
 	int error;
 
@@ -165,6 +176,25 @@ static int st1232_ts_probe(struct i2c_client *client,
 	ts->client = client;
 	ts->input_dev = input_dev;
 
+	if (pdata)
+		ts->reset_gpio = pdata->reset_gpio;
+	else if (client->dev.of_node)
+		ts->reset_gpio = of_get_gpio(client->dev.of_node, 0);
+	else
+		ts->reset_gpio = -ENODEV;
+
+	if (gpio_is_valid(ts->reset_gpio)) {
+		error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);
+		if (error) {
+			dev_err(&client->dev,
+				"Unable to request GPIO pin %d.\n",
+				ts->reset_gpio);
+				return error;
+		}
+	}
+
+	st1232_ts_power(ts, true);
+
 	input_dev->name = "st1232-touchscreen";
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
@@ -200,7 +230,10 @@ static int st1232_ts_probe(struct i2c_client *client,
 
 static int st1232_ts_remove(struct i2c_client *client)
 {
+	struct st1232_ts_data *ts = i2c_get_clientdata(client);
+
 	device_init_wakeup(&client->dev, 0);
+	st1232_ts_power(ts, false);
 
 	return 0;
 }
@@ -209,11 +242,14 @@ static int st1232_ts_remove(struct i2c_client *client)
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
@@ -221,11 +257,14 @@ static int st1232_ts_suspend(struct device *dev)
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
-- 
1.7.9.5

