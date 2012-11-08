From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: tca8418-keypad - switch to use managed resources
Date: Thu, 8 Nov 2012 09:09:34 -0800
Message-ID: <20121108170932.GA28478@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64832 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab2KHRJi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Nov 2012 12:09:38 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2123849pad.19
        for <linux-input@vger.kernel.org>; Thu, 08 Nov 2012 09:09:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: linux-input@vger.kernel.org

Let's switch to using devm_*() interfaces to manage our resources, thus will
simplify error unwinding a bit.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 123 +++++++++++++-------------------
 1 file changed, 50 insertions(+), 73 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 65cf5fa..adfd8c5 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -110,30 +110,11 @@
 #define KEY_EVENT_CODE		0x7f
 #define KEY_EVENT_VALUE		0x80
 
-
-static const struct i2c_device_id tca8418_id[] = {
-	{ TCA8418_NAME, 8418, },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, tca8418_id);
-
-#ifdef CONFIG_OF
-static const struct of_device_id tca8418_dt_ids[] __devinitconst = {
-	{ .compatible = "ti,tca8418", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, tca8418_dt_ids);
-#endif
-
 struct tca8418_keypad {
-	unsigned int irq;
-	unsigned int row_shift;
-
 	struct i2c_client *client;
 	struct input_dev *input;
 
-	/* Flexible array member, must be at end of struct */
-	unsigned short keymap[];
+	unsigned int row_shift;
 };
 
 /*
@@ -178,6 +159,8 @@ static int tca8418_read_byte(struct tca8418_keypad *keypad_data,
 
 static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
 {
+	struct input_dev *input = keypad_data->input;
+	unsigned short *keymap = input->keycode;
 	int error, col, row;
 	u8 reg, state, code;
 
@@ -196,9 +179,8 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
 		col = (col) ? col - 1 : TCA8418_MAX_COLS - 1;
 
 		code = MATRIX_SCAN_CODE(row, col, keypad_data->row_shift);
-		input_event(keypad_data->input, EV_MSC, MSC_SCAN, code);
-		input_report_key(keypad_data->input,
-				keypad_data->keymap[code], state);
+		input_event(input, EV_MSC, MSC_SCAN, code);
+		input_report_key(input, keymap[code], state);
 
 		/* Read for next loop */
 		error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
@@ -208,7 +190,7 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
 		dev_err(&keypad_data->client->dev,
 			"unable to read REG_KEY_EVENT_A\n");
 
-	input_sync(keypad_data->input);
+	input_sync(input);
 }
 
 /*
@@ -281,20 +263,22 @@ static int __devinit tca8418_configure(struct tca8418_keypad *keypad_data,
 static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 					  const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	const struct tca8418_keypad_platform_data *pdata =
-						client->dev.platform_data;
+						dev_get_platdata(dev);
 	struct tca8418_keypad *keypad_data;
 	struct input_dev *input;
 	const struct matrix_keymap_data *keymap_data = NULL;
 	u32 rows = 0, cols = 0;
 	bool rep = false;
 	bool irq_is_gpio = false;
+	int irq;
 	int error, row_shift, max_keys;
 
 	/* Copy the platform data */
 	if (pdata) {
 		if (!pdata->keymap_data) {
-			dev_err(&client->dev, "no keymap data defined\n");
+			dev_err(dev, "no keymap data defined\n");
 			return -EINVAL;
 		}
 		keymap_data = pdata->keymap_data;
@@ -303,25 +287,25 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 		rep  = pdata->rep;
 		irq_is_gpio = pdata->irq_is_gpio;
 	} else {
-		struct device_node *np = client->dev.of_node;
+		struct device_node *np = dev->of_node;
 		of_property_read_u32(np, "keypad,num-rows", &rows);
 		of_property_read_u32(np, "keypad,num-columns", &cols);
 		rep = of_property_read_bool(np, "keypad,autorepeat");
 	}
 
 	if (!rows || rows > TCA8418_MAX_ROWS) {
-		dev_err(&client->dev, "invalid rows\n");
+		dev_err(dev, "invalid rows\n");
 		return -EINVAL;
 	}
 
 	if (!cols || cols > TCA8418_MAX_COLS) {
-		dev_err(&client->dev, "invalid columns\n");
+		dev_err(dev, "invalid columns\n");
 		return -EINVAL;
 	}
 
 	/* Check i2c driver capabilities */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE)) {
-		dev_err(&client->dev, "%s adapter not supported\n",
+		dev_err(dev, "%s adapter not supported\n",
 			dev_driver_string(&client->adapter->dev));
 		return -ENODEV;
 	}
@@ -329,9 +313,8 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 	row_shift = get_count_order(cols);
 	max_keys = rows << row_shift;
 
-	/* Allocate memory for keypad_data, keymap and input device */
-	keypad_data = kzalloc(sizeof(*keypad_data) +
-			max_keys * sizeof(keypad_data->keymap[0]), GFP_KERNEL);
+	/* Allocate memory for keypad_data and input device */
+	keypad_data = devm_kzalloc(dev, sizeof(*keypad_data), GFP_KERNEL);
 	if (!keypad_data)
 		return -ENOMEM;
 
@@ -341,29 +324,26 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 	/* Initialize the chip or fail if chip isn't present */
 	error = tca8418_configure(keypad_data, rows, cols);
 	if (error < 0)
-		goto fail1;
+		return error;
 
 	/* Configure input device */
-	input = input_allocate_device();
-	if (!input) {
-		error = -ENOMEM;
-		goto fail1;
-	}
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
 	keypad_data->input = input;
 
 	input->name = client->name;
-	input->dev.parent = &client->dev;
-
 	input->id.bustype = BUS_I2C;
 	input->id.vendor  = 0x0001;
 	input->id.product = 0x001;
 	input->id.version = 0x0001;
 
 	error = matrix_keypad_build_keymap(keymap_data, NULL, rows, cols,
-					   keypad_data->keymap, input);
+					   NULL, input);
 	if (error) {
-		dev_dbg(&client->dev, "Failed to build keymap\n");
-		goto fail2;
+		dev_err(dev, "Failed to build keymap\n");
+		return error;
 	}
 
 	if (rep)
@@ -372,53 +352,50 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 
 	input_set_drvdata(input, keypad_data);
 
+	irq = client->irq;
 	if (irq_is_gpio)
-		client->irq = gpio_to_irq(client->irq);
+		irq = gpio_to_irq(irq);
 
-	error = request_threaded_irq(client->irq, NULL, tca8418_irq_handler,
-				     IRQF_TRIGGER_FALLING |
-				     IRQF_SHARED |
-				     IRQF_ONESHOT,
-				     client->name, keypad_data);
+	error = devm_request_threaded_irq(dev, irq, NULL, tca8418_irq_handler,
+					  IRQF_TRIGGER_FALLING |
+						IRQF_SHARED |
+						IRQF_ONESHOT,
+					  client->name, keypad_data);
 	if (error) {
-		dev_dbg(&client->dev,
-			"Unable to claim irq %d; error %d\n",
+		dev_err(dev, "Unable to claim irq %d; error %d\n",
 			client->irq, error);
-		goto fail2;
+		return error;
 	}
 
 	error = input_register_device(input);
 	if (error) {
-		dev_dbg(&client->dev,
-			"Unable to register input device, error: %d\n", error);
-		goto fail3;
+		dev_err(dev, "Unable to register input device, error: %d\n",
+			error);
+		return error;
 	}
 
-	i2c_set_clientdata(client, keypad_data);
 	return 0;
-
-fail3:
-	free_irq(client->irq, keypad_data);
-fail2:
-	input_free_device(input);
-fail1:
-	kfree(keypad_data);
-	return error;
 }
 
 static int __devexit tca8418_keypad_remove(struct i2c_client *client)
 {
-	struct tca8418_keypad *keypad_data = i2c_get_clientdata(client);
-
-	free_irq(keypad_data->client->irq, keypad_data);
-
-	input_unregister_device(keypad_data->input);
-
-	kfree(keypad_data);
-
 	return 0;
 }
 
+static const struct i2c_device_id tca8418_id[] = {
+	{ TCA8418_NAME, 8418, },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tca8418_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id tca8418_dt_ids[] __devinitconst = {
+	{ .compatible = "ti,tca8418", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tca8418_dt_ids);
+#endif
+
 static struct i2c_driver tca8418_keypad_driver = {
 	.driver = {
 		.name	= TCA8418_NAME,
-- 
1.7.11.7


-- 
Dmitry
