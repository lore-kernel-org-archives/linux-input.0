From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 05/10] Input: eeti-ts - switch to using managed resources
Date: Tue, 28 Feb 2017 14:46:27 -0800
Message-ID: <20170228224632.3401-5-dmitry.torokhov@gmail.com>
References: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36545 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdB1Wzq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 17:55:46 -0500
In-Reply-To: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Using devm_* APIs simpifies error handling and device teardown.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/eeti_ts.c | 70 ++++++++++++-------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index b472e0e467e8..e99e4fec93f5 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -157,13 +157,14 @@ static void eeti_ts_close(struct input_dev *dev)
 }
 
 static int eeti_ts_probe(struct i2c_client *client,
-				   const struct i2c_device_id *idp)
+			 const struct i2c_device_id *idp)
 {
-	struct eeti_ts_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct device *dev = &client->dev;
+	struct eeti_ts_platform_data *pdata = dev_get_platdata(dev);
 	struct eeti_ts *eeti;
 	struct input_dev *input;
 	unsigned int irq_flags;
-	int err = -ENOMEM;
+	int error;
 
 	/*
 	 * In contrast to what's described in the datasheet, there seems
@@ -172,18 +173,18 @@ static int eeti_ts_probe(struct i2c_client *client,
 	 * for interrupts to occur.
 	 */
 
-	eeti = kzalloc(sizeof(*eeti), GFP_KERNEL);
+	eeti = devm_kzalloc(dev, sizeof(*eeti), GFP_KERNEL);
 	if (!eeti) {
-		dev_err(&client->dev, "failed to allocate driver data\n");
+		dev_err(dev, "failed to allocate driver data\n");
 		return -ENOMEM;
 	}
 
 	mutex_init(&eeti->mutex);
 
-	input = input_allocate_device();
+	input = devm_input_allocate_device(dev);
 	if (!input) {
-		dev_err(&client->dev, "Failed to allocate input device.\n");
-		goto err1;
+		dev_err(dev, "Failed to allocate input device.\n");
+		return -ENOMEM;
 	}
 
 	input_set_capability(input, EV_KEY, BTN_TOUCH);
@@ -194,7 +195,6 @@ static int eeti_ts_probe(struct i2c_client *client,
 
 	input->name = client->name;
 	input->id.bustype = BUS_I2C;
-	input->dev.parent = &client->dev;
 	input->open = eeti_ts_open;
 	input->close = eeti_ts_close;
 
@@ -203,9 +203,10 @@ static int eeti_ts_probe(struct i2c_client *client,
 	eeti->irq_gpio = pdata->irq_gpio;
 	eeti->irq = gpio_to_irq(pdata->irq_gpio);
 
-	err = gpio_request_one(pdata->irq_gpio, GPIOF_IN, client->name);
-	if (err < 0)
-		goto err1;
+	error = devm_gpio_request_one(dev, pdata->irq_gpio, GPIOF_IN,
+				      client->name);
+	if (error)
+		return error;
 
 	eeti->irq_active_high = pdata->irq_active_high;
 
@@ -216,15 +217,16 @@ static int eeti_ts_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, eeti);
 	input_set_drvdata(input, eeti);
 
-	err = input_register_device(input);
-	if (err)
-		goto err2;
+	error = input_register_device(input);
+	if (error)
+		return error;
 
-	err = request_irq(eeti->irq, eeti_ts_isr, irq_flags,
-			  client->name, eeti);
-	if (err) {
-		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
-		goto err3;
+	error = devm_request_irq(dev, eeti->irq, eeti_ts_isr, irq_flags,
+				 client->name, eeti);
+	if (error) {
+		dev_err(dev, "Unable to request touchscreen IRQ: %d\n",
+			error);
+		return error;
 	}
 
 	/*
@@ -234,33 +236,6 @@ static int eeti_ts_probe(struct i2c_client *client,
 	eeti_ts_stop(eeti);
 
 	return 0;
-
-err3:
-	input_unregister_device(input);
-	input = NULL; /* so we dont try to free it below */
-err2:
-	gpio_free(pdata->irq_gpio);
-err1:
-	input_free_device(input);
-	kfree(eeti);
-	return err;
-}
-
-static int eeti_ts_remove(struct i2c_client *client)
-{
-	struct eeti_ts *eeti = i2c_get_clientdata(client);
-
-	free_irq(eeti->irq, eeti);
-	/*
-	 * eeti_ts_stop() leaves IRQ disabled. We need to re-enable it
-	 * so that device still works if we reload the driver.
-	 */
-	enable_irq(eeti->irq);
-
-	input_unregister_device(eeti->input);
-	kfree(eeti);
-
-	return 0;
 }
 
 static int __maybe_unused eeti_ts_suspend(struct device *dev)
@@ -315,7 +290,6 @@ static struct i2c_driver eeti_ts_driver = {
 		.pm = &eeti_ts_pm,
 	},
 	.probe = eeti_ts_probe,
-	.remove = eeti_ts_remove,
 	.id_table = eeti_ts_id,
 };
 
-- 
2.11.0.483.g087da7b7c-goog

