From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tca8418 - convert to dt
Date: Thu, 8 Nov 2012 08:57:29 -0800
Message-ID: <20121108165729.GC8877@core.coreip.homeip.net>
References: <1352131829-19449-1-git-send-email-alban.bedel@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:34796 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455Ab2KHQ5d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Nov 2012 11:57:33 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so1261996dak.19
        for <linux-input@vger.kernel.org>; Thu, 08 Nov 2012 08:57:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352131829-19449-1-git-send-email-alban.bedel@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi Alban,

On Mon, Nov 05, 2012 at 05:10:29PM +0100, Alban Bedel wrote:
> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
> ---
>  .../devicetree/bindings/input/tca8418_keypad.txt   |    8 +++
>  drivers/input/keyboard/tca8418_keypad.c            |   54 +++++++++++++-------
>  2 files changed, 44 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/tca8418_keypad.txt

How about version below instead? It needs the patch to matrix-keymap I
posted a few minutes ago.

Thanks.

-- 
Dmitry


Input: tca8418 - convert to dt

From: Alban Bedel <alban.bedel@avionic-design.de>

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/tca8418_keypad.txt   |    8 ++
 drivers/input/keyboard/tca8418_keypad.c            |   68 ++++++++++++--------
 2 files changed, 49 insertions(+), 27 deletions(-)
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
index 893869b..095187f 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -35,6 +35,7 @@
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/tca8418_keypad.h>
+#include <linux/of.h>
 
 /* TCA8418 hardware limits */
 #define TCA8418_MAX_ROWS	8
@@ -116,10 +117,15 @@ static const struct i2c_device_id tca8418_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tca8418_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id tca8418_dt_ids[] __devinitconst = {
+	{ .compatible = "ti,tca8418", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tca8418_dt_ids);
+#endif
+
 struct tca8418_keypad {
-	unsigned int rows;
-	unsigned int cols;
-	unsigned int keypad_mask; /* Mask for keypad col/rol regs */
 	unsigned int irq;
 	unsigned int row_shift;
 
@@ -241,7 +247,8 @@ exit:
 /*
  * Configure the TCA8418 for keypad operation
  */
-static int __devinit tca8418_configure(struct tca8418_keypad *keypad_data)
+static int __devinit tca8418_configure(struct tca8418_keypad *keypad_data,
+					u32 rows, u32 cols)
 {
 	int reg, error;
 
@@ -253,9 +260,8 @@ static int __devinit tca8418_configure(struct tca8418_keypad *keypad_data)
 
 
 	/* Assemble a mask for row and column registers */
-	reg  =  ~(~0 << keypad_data->rows);
-	reg += (~(~0 << keypad_data->cols)) << 8;
-	keypad_data->keypad_mask = reg;
+	reg  =  ~(~0 << rows);
+	reg += (~(~0 << cols)) << 8;
 
 	/* Set registers to keypad mode */
 	error |= tca8418_write_byte(keypad_data, REG_KP_GPIO1, reg);
@@ -277,25 +283,36 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
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
 
-	if (!pdata->keymap_data) {
-		dev_err(&client->dev, "no keymap data defined\n");
-		return -EINVAL;
-	}
-
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
@@ -307,8 +324,8 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	row_shift = get_count_order(pdata->cols);
-	max_keys = pdata->rows << row_shift;
+	row_shift = get_count_order(cols);
+	max_keys = rows << row_shift;
 
 	/* Allocate memory for keypad_data, keymap and input device */
 	keypad_data = kzalloc(sizeof(*keypad_data) +
@@ -316,13 +333,11 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 	if (!keypad_data)
 		return -ENOMEM;
 
-	keypad_data->rows = pdata->rows;
-	keypad_data->cols = pdata->cols;
 	keypad_data->client = client;
 	keypad_data->row_shift = row_shift;
 
 	/* Initialize the chip or fail if chip isn't present */
-	error = tca8418_configure(keypad_data);
+	error = tca8418_configure(keypad_data, rows, cols);
 	if (error < 0)
 		goto fail1;
 
@@ -342,21 +357,20 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
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
@@ -401,11 +415,11 @@ static int __devexit tca8418_keypad_remove(struct i2c_client *client)
 	return 0;
 }
 
-
 static struct i2c_driver tca8418_keypad_driver = {
 	.driver = {
 		.name	= TCA8418_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(tca8418_dt_ids),
 	},
 	.probe		= tca8418_keypad_probe,
 	.remove		= __devexit_p(tca8418_keypad_remove),
