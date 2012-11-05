From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: [PATCH] Input: tca8418 - convert to dt
Date: Mon,  5 Nov 2012 17:10:29 +0100
Message-ID: <1352131829-19449-1-git-send-email-alban.bedel@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56916 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab2KEQLA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Nov 2012 11:11:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Alban Bedel <alban.bedel@avionic-design.de>

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 .../devicetree/bindings/input/tca8418_keypad.txt   |    8 +++
 drivers/input/keyboard/tca8418_keypad.c            |   54 +++++++++++++-------
 2 files changed, 44 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/tca8418_keypad.txt

diff --git a/Documentation/devicetree/bindings/input/tca8418_keypad.txt b/Documentation/devicetree/bindings/input/tca8418_keypad.txt
new file mode 100644
index 0000000..2a1538f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/tca8418_keypad.txt
@@ -0,0 +1,8 @@
+
+Required properties:
+- compatible: "ti,tca8418"
+- reg: the I2C address
+- interrupts: IRQ line number, should trigger on falling edge
+- keypad,num-rows: The number of rows
+- keypad,num-columns: The number of columns
+- linux,keymap: Keys definitions, see keypad-matrix.
diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 893869b..fc9cc94 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -35,6 +35,7 @@
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/tca8418_keypad.h>
+#include <linux/of.h>
 
 /* TCA8418 hardware limits */
 #define TCA8418_MAX_ROWS	8
@@ -116,6 +117,12 @@ static const struct i2c_device_id tca8418_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tca8418_id);
 
+static const struct of_device_id tca8418_dt_ids[] __devinitconst = {
+	{ .compatible = "ti,tca8418", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tca8418_dt_ids);
+
 struct tca8418_keypad {
 	unsigned int rows;
 	unsigned int cols;
@@ -277,25 +284,36 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 						client->dev.platform_data;
 	struct tca8418_keypad *keypad_data;
 	struct input_dev *input;
+	const struct matrix_keymap_data *keymap_data = NULL;
+	u32 rows = 0, cols = 0;
+	bool rep = false;
+	bool irq_is_gpio = false;
 	int error, row_shift, max_keys;
 
 	/* Copy the platform data */
-	if (!pdata) {
-		dev_dbg(&client->dev, "no platform data\n");
-		return -EINVAL;
-	}
-
-	if (!pdata->keymap_data) {
-		dev_err(&client->dev, "no keymap data defined\n");
-		return -EINVAL;
+	if (pdata) {
+		if (!pdata->keymap_data) {
+			dev_err(&client->dev, "no keymap data defined\n");
+			return -EINVAL;
+		}
+		keymap_data = pdata->keymap_data;
+		rows = pdata->rows;
+		cols = pdata->cols;
+		rep  = pdata->rep;
+		irq_is_gpio = pdata->irq_is_gpio;
+	} else {
+		struct device_node *np = client->dev.of_node;
+		of_property_read_u32(np, "keypad,num-rows", &rows);
+		of_property_read_u32(np, "keypad,num-columns", &cols);
+		rep = of_property_read_bool(np, "keypad,autorepeat");
 	}
 
-	if (!pdata->rows || pdata->rows > TCA8418_MAX_ROWS) {
+	if (!rows || rows > TCA8418_MAX_ROWS) {
 		dev_err(&client->dev, "invalid rows\n");
 		return -EINVAL;
 	}
 
-	if (!pdata->cols || pdata->cols > TCA8418_MAX_COLS) {
+	if (!cols || cols > TCA8418_MAX_COLS) {
 		dev_err(&client->dev, "invalid columns\n");
 		return -EINVAL;
 	}
@@ -307,8 +325,8 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	row_shift = get_count_order(pdata->cols);
-	max_keys = pdata->rows << row_shift;
+	row_shift = get_count_order(cols);
+	max_keys = rows << row_shift;
 
 	/* Allocate memory for keypad_data, keymap and input device */
 	keypad_data = kzalloc(sizeof(*keypad_data) +
@@ -316,8 +334,8 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 	if (!keypad_data)
 		return -ENOMEM;
 
-	keypad_data->rows = pdata->rows;
-	keypad_data->cols = pdata->cols;
+	keypad_data->rows = rows;
+	keypad_data->cols = cols;
 	keypad_data->client = client;
 	keypad_data->row_shift = row_shift;
 
@@ -342,21 +360,20 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 	input->id.product = 0x001;
 	input->id.version = 0x0001;
 
-	error = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
-					   pdata->rows, pdata->cols,
+	error = matrix_keypad_build_keymap(keymap_data, NULL, rows, cols,
 					   keypad_data->keymap, input);
 	if (error) {
 		dev_dbg(&client->dev, "Failed to build keymap\n");
 		goto fail2;
 	}
 
-	if (pdata->rep)
+	if (rep)
 		__set_bit(EV_REP, input->evbit);
 	input_set_capability(input, EV_MSC, MSC_SCAN);
 
 	input_set_drvdata(input, keypad_data);
 
-	if (pdata->irq_is_gpio)
+	if (irq_is_gpio)
 		client->irq = gpio_to_irq(client->irq);
 
 	error = request_threaded_irq(client->irq, NULL, tca8418_irq_handler,
@@ -406,6 +423,7 @@ static struct i2c_driver tca8418_keypad_driver = {
 	.driver = {
 		.name	= TCA8418_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(tca8418_dt_ids),
 	},
 	.probe		= tca8418_keypad_probe,
 	.remove		= __devexit_p(tca8418_keypad_remove),
-- 
1.7.0.4

