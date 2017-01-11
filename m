From: Gary Bisson <gary.bisson@boundarydevices.com>
Subject: [PATCH] Input: egalax_ts - do not release gpio if probe successful
Date: Wed, 11 Jan 2017 18:28:41 +0100
Message-ID: <20170111172841.9825-1-gary.bisson@boundarydevices.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33792 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965257AbdAKR2u (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Jan 2017 12:28:50 -0500
Received: by mail-wm0-f51.google.com with SMTP id f73so28126805wmf.1
        for <linux-input@vger.kernel.org>; Wed, 11 Jan 2017 09:28:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, Gary Bisson <gary.bisson@boundarydevices.com>

Thus preventing anyone to later modify the interrupt GPIO direction
and/or state without the driver knowing.

Also checking if device is present before allocating the input device.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 drivers/input/touchscreen/egalax_ts.c | 56 ++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 1afc08b08155..f6b94bb19bd8 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -62,6 +62,7 @@
 struct egalax_ts {
 	struct i2c_client		*client;
 	struct input_dev		*input_dev;
+	struct gpio_desc		*wakeup_gpio;
 };
 
 static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
@@ -120,36 +121,21 @@ static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
 }
 
 /* wake up controller by an falling edge of interrupt gpio.  */
-static int egalax_wake_up_device(struct i2c_client *client)
+static int egalax_wake_up_device(struct gpio_desc *wakeup_gpio)
 {
-	struct device_node *np = client->dev.of_node;
-	int gpio;
 	int ret;
 
-	if (!np)
-		return -ENODEV;
-
-	gpio = of_get_named_gpio(np, "wakeup-gpios", 0);
-	if (!gpio_is_valid(gpio))
-		return -ENODEV;
-
-	ret = gpio_request(gpio, "egalax_irq");
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"request gpio failed, cannot wake up controller: %d\n",
-			ret);
+	/* wake up controller via an falling edge on IRQ gpio. */
+	ret = gpiod_direction_output(wakeup_gpio, 0);
+	if (ret < 0)
 		return ret;
-	}
 
-	/* wake up controller via an falling edge on IRQ gpio. */
-	gpio_direction_output(gpio, 0);
-	gpio_set_value(gpio, 1);
+	gpiod_set_value(wakeup_gpio, 1);
 
 	/* controller should be waken up, return irq.  */
-	gpio_direction_input(gpio);
-	gpio_free(gpio);
+	ret = gpiod_direction_input(wakeup_gpio);
 
-	return 0;
+	return ret;
 }
 
 static int egalax_firmware_version(struct i2c_client *client)
@@ -177,17 +163,15 @@ static int egalax_ts_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
-	input_dev = devm_input_allocate_device(&client->dev);
-	if (!input_dev) {
-		dev_err(&client->dev, "Failed to allocate memory\n");
-		return -ENOMEM;
+	ts->wakeup_gpio = devm_gpiod_get_index(&client->dev, "wakeup",
+					       0, GPIOD_ASIS);
+	if (IS_ERR(ts->wakeup_gpio)) {
+		dev_err(&client->dev, "Failed to get wakeup gpio");
+		return -ENODEV;
 	}
 
-	ts->client = client;
-	ts->input_dev = input_dev;
-
 	/* controller may be in sleep, wake it up. */
-	error = egalax_wake_up_device(client);
+	error = egalax_wake_up_device(ts->wakeup_gpio);
 	if (error) {
 		dev_err(&client->dev, "Failed to wake up the controller\n");
 		return error;
@@ -199,6 +183,15 @@ static int egalax_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	input_dev = devm_input_allocate_device(&client->dev);
+	if (!input_dev) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	ts->client = client;
+	ts->input_dev = input_dev;
+
 	input_dev->name = "EETI eGalax Touch Screen";
 	input_dev->id.bustype = BUS_I2C;
 
@@ -254,8 +247,9 @@ static int __maybe_unused egalax_ts_suspend(struct device *dev)
 static int __maybe_unused egalax_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct egalax_ts *ts = i2c_get_clientdata(client);
 
-	return egalax_wake_up_device(client);
+	return egalax_wake_up_device(ts->wakeup_gpio);
 }
 
 static SIMPLE_DEV_PM_OPS(egalax_ts_pm_ops, egalax_ts_suspend, egalax_ts_resume);
-- 
2.11.0

