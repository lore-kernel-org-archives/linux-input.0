From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 01/10] Input: eeti_ts - rename eeti_ts_priv to eeti_ts
Date: Tue, 28 Feb 2017 14:46:23 -0800
Message-ID: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33809 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdB1Wzq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 17:55:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Also rename 'priv' variables to eeti.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Hi,

This is all is not tested as I do not have the hardware, so if anyone
has raumfeld device that would be awesome.

 drivers/input/touchscreen/eeti_ts.c | 115 ++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 57 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 16023867b9da..74d57ef68663 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -43,7 +43,7 @@ static bool flip_y;
 module_param(flip_y, bool, 0644);
 MODULE_PARM_DESC(flip_y, "flip y coordinate");
 
-struct eeti_ts_priv {
+struct eeti_ts {
 	struct i2c_client *client;
 	struct input_dev *input;
 	struct work_struct work;
@@ -60,25 +60,25 @@ struct eeti_ts_priv {
 #define REPORT_BIT_HAS_PRESSURE	(1 << 6)
 #define REPORT_RES_BITS(v)	(((v) >> 1) + EETI_TS_BITDEPTH)
 
-static inline int eeti_ts_irq_active(struct eeti_ts_priv *priv)
+static inline int eeti_ts_irq_active(struct eeti_ts *eeti)
 {
-	return gpio_get_value(priv->irq_gpio) == priv->irq_active_high;
+	return gpio_get_value(eeti->irq_gpio) == eeti->irq_active_high;
 }
 
 static void eeti_ts_read(struct work_struct *work)
 {
 	char buf[6];
 	unsigned int x, y, res, pressed, to = 100;
-	struct eeti_ts_priv *priv =
-		container_of(work, struct eeti_ts_priv, work);
+	struct eeti_ts *eeti =
+		container_of(work, struct eeti_ts, work);
 
-	mutex_lock(&priv->mutex);
+	mutex_lock(&eeti->mutex);
 
-	while (eeti_ts_irq_active(priv) && --to)
-		i2c_master_recv(priv->client, buf, sizeof(buf));
+	while (eeti_ts_irq_active(eeti) && --to)
+		i2c_master_recv(eeti->client, buf, sizeof(buf));
 
 	if (!to) {
-		dev_err(&priv->client->dev,
+		dev_err(&eeti->client->dev,
 			"unable to clear IRQ - line stuck?\n");
 		goto out;
 	}
@@ -103,62 +103,62 @@ static void eeti_ts_read(struct work_struct *work)
 		y = EETI_MAXVAL - y;
 
 	if (buf[0] & REPORT_BIT_HAS_PRESSURE)
-		input_report_abs(priv->input, ABS_PRESSURE, buf[5]);
+		input_report_abs(eeti->input, ABS_PRESSURE, buf[5]);
 
-	input_report_abs(priv->input, ABS_X, x);
-	input_report_abs(priv->input, ABS_Y, y);
-	input_report_key(priv->input, BTN_TOUCH, !!pressed);
-	input_sync(priv->input);
+	input_report_abs(eeti->input, ABS_X, x);
+	input_report_abs(eeti->input, ABS_Y, y);
+	input_report_key(eeti->input, BTN_TOUCH, !!pressed);
+	input_sync(eeti->input);
 
 out:
-	mutex_unlock(&priv->mutex);
+	mutex_unlock(&eeti->mutex);
 }
 
 static irqreturn_t eeti_ts_isr(int irq, void *dev_id)
 {
-	struct eeti_ts_priv *priv = dev_id;
+	struct eeti_ts *eeti = dev_id;
 
 	 /* postpone I2C transactions as we are atomic */
-	schedule_work(&priv->work);
+	schedule_work(&eeti->work);
 
 	return IRQ_HANDLED;
 }
 
-static void eeti_ts_start(struct eeti_ts_priv *priv)
+static void eeti_ts_start(struct eeti_ts *eeti)
 {
-	enable_irq(priv->irq);
+	enable_irq(eeti->irq);
 
 	/* Read the events once to arm the IRQ */
-	eeti_ts_read(&priv->work);
+	eeti_ts_read(&eeti->work);
 }
 
-static void eeti_ts_stop(struct eeti_ts_priv *priv)
+static void eeti_ts_stop(struct eeti_ts *eeti)
 {
-	disable_irq(priv->irq);
-	cancel_work_sync(&priv->work);
+	disable_irq(eeti->irq);
+	cancel_work_sync(&eeti->work);
 }
 
 static int eeti_ts_open(struct input_dev *dev)
 {
-	struct eeti_ts_priv *priv = input_get_drvdata(dev);
+	struct eeti_ts *eeti = input_get_drvdata(dev);
 
-	eeti_ts_start(priv);
+	eeti_ts_start(eeti);
 
 	return 0;
 }
 
 static void eeti_ts_close(struct input_dev *dev)
 {
-	struct eeti_ts_priv *priv = input_get_drvdata(dev);
+	struct eeti_ts *eeti = input_get_drvdata(dev);
 
-	eeti_ts_stop(priv);
+	eeti_ts_stop(eeti);
 }
 
 static int eeti_ts_probe(struct i2c_client *client,
 				   const struct i2c_device_id *idp)
 {
 	struct eeti_ts_platform_data *pdata = dev_get_platdata(&client->dev);
-	struct eeti_ts_priv *priv;
+	struct eeti_ts *eeti;
 	struct input_dev *input;
 	unsigned int irq_flags;
 	int err = -ENOMEM;
@@ -170,13 +170,14 @@ static int eeti_ts_probe(struct i2c_client *client,
 	 * for interrupts to occur.
 	 */
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
+	eeti = kzalloc(sizeof(*eeti), GFP_KERNEL);
+	if (!eeti) {
 		dev_err(&client->dev, "failed to allocate driver data\n");
 		return -ENOMEM;
 	}
 
-	mutex_init(&priv->mutex);
+	mutex_init(&eeti->mutex);
+
 	input = input_allocate_device();
 	if (!input) {
 		dev_err(&client->dev, "Failed to allocate input device.\n");
@@ -196,30 +197,30 @@ static int eeti_ts_probe(struct i2c_client *client,
 	input->open = eeti_ts_open;
 	input->close = eeti_ts_close;
 
-	priv->client = client;
-	priv->input = input;
-	priv->irq_gpio = pdata->irq_gpio;
-	priv->irq = gpio_to_irq(pdata->irq_gpio);
+	eeti->client = client;
+	eeti->input = input;
+	eeti->irq_gpio = pdata->irq_gpio;
+	eeti->irq = gpio_to_irq(pdata->irq_gpio);
 
 	err = gpio_request_one(pdata->irq_gpio, GPIOF_IN, client->name);
 	if (err < 0)
 		goto err1;
 
-	priv->irq_active_high = pdata->irq_active_high;
+	eeti->irq_active_high = pdata->irq_active_high;
 
-	irq_flags = priv->irq_active_high ?
+	irq_flags = eeti->irq_active_high ?
 		IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
 
-	INIT_WORK(&priv->work, eeti_ts_read);
-	i2c_set_clientdata(client, priv);
-	input_set_drvdata(input, priv);
+	INIT_WORK(&eeti->work, eeti_ts_read);
+	i2c_set_clientdata(client, eeti);
+	input_set_drvdata(input, eeti);
 
 	err = input_register_device(input);
 	if (err)
 		goto err2;
 
-	err = request_irq(priv->irq, eeti_ts_isr, irq_flags,
-			  client->name, priv);
+	err = request_irq(eeti->irq, eeti_ts_isr, irq_flags,
+			  client->name, eeti);
 	if (err) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
 		goto err3;
@@ -229,7 +230,7 @@ static int eeti_ts_probe(struct i2c_client *client,
 	 * Disable the device for now. It will be enabled once the
 	 * input device is opened.
 	 */
-	eeti_ts_stop(priv);
+	eeti_ts_stop(eeti);
 
 	return 0;
 
@@ -240,23 +241,23 @@ static int eeti_ts_probe(struct i2c_client *client,
 	gpio_free(pdata->irq_gpio);
 err1:
 	input_free_device(input);
-	kfree(priv);
+	kfree(eeti);
 	return err;
 }
 
 static int eeti_ts_remove(struct i2c_client *client)
 {
-	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
+	struct eeti_ts *eeti = i2c_get_clientdata(client);
 
-	free_irq(priv->irq, priv);
+	free_irq(eeti->irq, eeti);
 	/*
 	 * eeti_ts_stop() leaves IRQ disabled. We need to re-enable it
 	 * so that device still works if we reload the driver.
 	 */
-	enable_irq(priv->irq);
+	enable_irq(eeti->irq);
 
-	input_unregister_device(priv->input);
-	kfree(priv);
+	input_unregister_device(eeti->input);
+	kfree(eeti);
 
 	return 0;
 }
@@ -264,18 +265,18 @@ static int eeti_ts_remove(struct i2c_client *client)
 static int __maybe_unused eeti_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
-	struct input_dev *input_dev = priv->input;
+	struct eeti_ts *eeti = i2c_get_clientdata(client);
+	struct input_dev *input_dev = eeti->input;
 
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		eeti_ts_stop(priv);
+		eeti_ts_stop(eeti);
 
 	mutex_unlock(&input_dev->mutex);
 
 	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(priv->irq);
+		enable_irq_wake(eeti->irq);
 
 	return 0;
 }
@@ -283,16 +284,16 @@ static int __maybe_unused eeti_ts_suspend(struct device *dev)
 static int __maybe_unused eeti_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
-	struct input_dev *input_dev = priv->input;
+	struct eeti_ts *eeti = i2c_get_clientdata(client);
+	struct input_dev *input_dev = eeti->input;
 
 	if (device_may_wakeup(&client->dev))
-		disable_irq_wake(priv->irq);
+		disable_irq_wake(eeti->irq);
 
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		eeti_ts_start(priv);
+		eeti_ts_start(eeti);
 
 	mutex_unlock(&input_dev->mutex);
 
-- 
2.11.0.483.g087da7b7c-goog

