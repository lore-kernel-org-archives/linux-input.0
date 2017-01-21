From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/13] Input: keyboard - Use local variables consistently
Date: Sat, 21 Jan 2017 10:45:56 -0800
Message-ID: <1485024365-3368-5-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49487 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdAUSrK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 13:47:10 -0500
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Hans de Goede <hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sudeep Holla <sudeep.holla@arm.com>

If a function declares a variable to access a structure element,
use it conssistently.

The conversion was done automatically with coccinelle using
the following semantic patch.

// Catch function parameters.
// Handle those first to trigger reformatting.

@@
identifier d;
identifier fn;
identifier svar;
identifier elem;
type T;
identifier i;
expression e;
identifier fn;
expression list es;
@@

fn(...) {
  ...
  T d = &svar->elem;
<... when != d = e;
- fn(&svar->elem, es)
+ fn(d, es)
...> }

// Now address non-functions and multiple transformations in function
// parameters.

@@
identifier d;
identifier fn;
identifier svar;
identifier elem;
type T;
identifier i;
expression e;
@@

fn(...) {
  ...
  T d = &svar->elem;
<... when != d = e;
(
- &svar->elem
+ d
|
- svar->elem.i
+ d->i
)
...> }

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/keyboard/davinci_keyscan.c  |  4 ++--
 drivers/input/keyboard/gpio_keys.c        | 24 +++++++++++-------------
 drivers/input/keyboard/gpio_keys_polled.c |  6 +++---
 drivers/input/keyboard/mpr121_touchkey.c  | 18 +++++++++---------
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index f363d1d2907a..b20a5d044caa 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -172,7 +172,7 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
 	struct input_dev *key_dev;
 	struct resource *res, *mem;
 	struct device *dev = &pdev->dev;
-	struct davinci_ks_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct davinci_ks_platform_data *pdata = dev_get_platdata(dev);
 	int error, i;
 
 	if (pdata->device_enable) {
@@ -255,7 +255,7 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
 
 	key_dev->name = "davinci_keyscan";
 	key_dev->phys = "davinci_keyscan/input0";
-	key_dev->dev.parent = &pdev->dev;
+	key_dev->dev.parent = dev;
 	key_dev->id.bustype = BUS_HOST;
 	key_dev->id.vendor = 0x0001;
 	key_dev->id.product = 0x0001;
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 582462d0af75..0da10ab34368 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -514,8 +514,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		if (button->active_low)
 			flags |= GPIOF_ACTIVE_LOW;
 
-		error = devm_gpio_request_one(&pdev->dev, button->gpio, flags,
-					      desc);
+		error = devm_gpio_request_one(dev, button->gpio, flags, desc);
 		if (error < 0) {
 			dev_err(dev, "Failed to request GPIO %d, error %d\n",
 				button->gpio, error);
@@ -583,10 +582,9 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	 * Install custom action to cancel release timer and
 	 * workqueue item.
 	 */
-	error = devm_add_action(&pdev->dev, gpio_keys_quiesce_key, bdata);
+	error = devm_add_action(dev, gpio_keys_quiesce_key, bdata);
 	if (error) {
-		dev_err(&pdev->dev,
-			"failed to register quiesce action, error: %d\n",
+		dev_err(dev, "failed to register quiesce action, error: %d\n",
 			error);
 		return error;
 	}
@@ -598,8 +596,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	if (!button->can_disable)
 		irqflags |= IRQF_SHARED;
 
-	error = devm_request_any_context_irq(&pdev->dev, bdata->irq,
-					     isr, irqflags, desc, bdata);
+	error = devm_request_any_context_irq(dev, bdata->irq, isr, irqflags,
+					     desc, bdata);
 	if (error < 0) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
 			bdata->irq, error);
@@ -765,7 +763,7 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 	input->name = pdata->name ? : pdev->name;
 	input->phys = "gpio-keys/input0";
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = dev;
 	input->open = gpio_keys_open;
 	input->close = gpio_keys_close;
 
@@ -783,9 +781,9 @@ static int gpio_keys_probe(struct platform_device *pdev)
 		struct gpio_button_data *bdata = &ddata->data[i];
 
 		if (!dev_get_platdata(dev)) {
-			child = device_get_next_child_node(&pdev->dev, child);
+			child = device_get_next_child_node(dev, child);
 			if (!child) {
-				dev_err(&pdev->dev,
+				dev_err(dev,
 					"missing child device node for entry %d\n",
 					i);
 				return -EINVAL;
@@ -804,7 +802,7 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 	fwnode_handle_put(child);
 
-	error = sysfs_create_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+	error = sysfs_create_group(&dev->kobj, &gpio_keys_attr_group);
 	if (error) {
 		dev_err(dev, "Unable to export keys/switches, error: %d\n",
 			error);
@@ -818,12 +816,12 @@ static int gpio_keys_probe(struct platform_device *pdev)
 		goto err_remove_group;
 	}
 
-	device_init_wakeup(&pdev->dev, wakeup);
+	device_init_wakeup(dev, wakeup);
 
 	return 0;
 
 err_remove_group:
-	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+	sysfs_remove_group(&dev->kobj, &gpio_keys_attr_group);
 	return error;
 }
 
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index cc193e665358..4fce43a6a0e0 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -252,13 +252,13 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	size = sizeof(struct gpio_keys_polled_dev) +
 			pdata->nbuttons * sizeof(struct gpio_keys_button_data);
-	bdev = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	bdev = devm_kzalloc(dev, size, GFP_KERNEL);
 	if (!bdev) {
 		dev_err(dev, "no memory for private data\n");
 		return -ENOMEM;
 	}
 
-	poll_dev = devm_input_allocate_polled_device(&pdev->dev);
+	poll_dev = devm_input_allocate_polled_device(dev);
 	if (!poll_dev) {
 		dev_err(dev, "no memory for polled device\n");
 		return -ENOMEM;
@@ -332,7 +332,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 			if (button->active_low)
 				flags |= GPIOF_ACTIVE_LOW;
 
-			error = devm_gpio_request_one(&pdev->dev, button->gpio,
+			error = devm_gpio_request_one(dev, button->gpio,
 					flags, button->desc ? : DRV_NAME);
 			if (error) {
 				dev_err(dev,
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 989ca66f63af..884a74d8a7ed 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -237,7 +237,7 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 	int i;
 
 	if (!client->irq) {
-		dev_err(&client->dev, "irq number should not be zero\n");
+		dev_err(dev, "irq number should not be zero\n");
 		return -EINVAL;
 	}
 
@@ -247,11 +247,11 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 
 	vdd_uv = regulator_get_voltage(vdd_supply);
 
-	mpr121 = devm_kzalloc(&client->dev, sizeof(*mpr121), GFP_KERNEL);
+	mpr121 = devm_kzalloc(dev, sizeof(*mpr121), GFP_KERNEL);
 	if (!mpr121)
 		return -ENOMEM;
 
-	input_dev = devm_input_allocate_device(&client->dev);
+	input_dev = devm_input_allocate_device(dev);
 	if (!input_dev)
 		return -ENOMEM;
 
@@ -275,7 +275,7 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 
 	input_dev->name = "Freescale MPR121 Touchkey";
 	input_dev->id.bustype = BUS_I2C;
-	input_dev->dev.parent = &client->dev;
+	input_dev->dev.parent = dev;
 	if (device_property_read_bool(dev, "autorepeat"))
 		__set_bit(EV_REP, input_dev->evbit);
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
@@ -289,16 +289,16 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 
 	error = mpr121_phys_init(mpr121, client, vdd_uv);
 	if (error) {
-		dev_err(&client->dev, "Failed to init register\n");
+		dev_err(dev, "Failed to init register\n");
 		return error;
 	}
 
-	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, mpr_touchkey_interrupt,
+	error = devm_request_threaded_irq(dev, client->irq, NULL,
+					  mpr_touchkey_interrupt,
 					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					  client->dev.driver->name, mpr121);
+					  dev->driver->name, mpr121);
 	if (error) {
-		dev_err(&client->dev, "Failed to register interrupt\n");
+		dev_err(dev, "Failed to register interrupt\n");
 		return error;
 	}
 
-- 
2.7.4

