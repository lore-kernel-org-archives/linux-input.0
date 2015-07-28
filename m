From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH] input: gpio_keys: Make pdev vs dev usage more consistent
Date: Mon, 27 Jul 2015 18:50:18 -0700
Message-ID: <1438048218-742-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

As gpio_keys_setup_key() only operates on the device, pass a pointer to
this from the probe instead of a platform_device and make the usage
consistent. Also make probe() more consistent by dropping the local copy
of the device pointer.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/input/keyboard/gpio_keys.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 3ce3298ac09e..2ffad10e2825 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -440,13 +440,12 @@ static void gpio_keys_quiesce_key(void *data)
 		del_timer_sync(&bdata->release_timer);
 }
 
-static int gpio_keys_setup_key(struct platform_device *pdev,
+static int gpio_keys_setup_key(struct device *dev,
 				struct input_dev *input,
 				struct gpio_button_data *bdata,
 				const struct gpio_keys_button *button)
 {
 	const char *desc = button->desc ? button->desc : "gpio_keys";
-	struct device *dev = &pdev->dev;
 	irq_handler_t isr;
 	unsigned long irqflags;
 	int irq;
@@ -458,7 +457,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 	if (gpio_is_valid(button->gpio)) {
 
-		error = devm_gpio_request_one(&pdev->dev, button->gpio,
+		error = devm_gpio_request_one(dev, button->gpio,
 					      GPIOF_IN, desc);
 		if (error < 0) {
 			dev_err(dev, "Failed to request GPIO %d, error %d\n",
@@ -520,9 +519,9 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	 * Install custom action to cancel release timer and
 	 * workqueue item.
 	 */
-	error = devm_add_action(&pdev->dev, gpio_keys_quiesce_key, bdata);
+	error = devm_add_action(dev, gpio_keys_quiesce_key, bdata);
 	if (error) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to register quiesce action, error: %d\n",
 			error);
 		return error;
@@ -535,7 +534,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	if (!button->can_disable)
 		irqflags |= IRQF_SHARED;
 
-	error = devm_request_any_context_irq(&pdev->dev, bdata->irq,
+	error = devm_request_any_context_irq(dev, bdata->irq,
 					     isr, irqflags, desc, bdata);
 	if (error < 0) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
@@ -694,31 +693,31 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 static int gpio_keys_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	const struct gpio_keys_platform_data *pdata = dev_get_platdata(dev);
+	const struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_drvdata *ddata;
 	struct input_dev *input;
 	size_t size;
 	int i, error;
 	int wakeup = 0;
 
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
-		pdata = gpio_keys_get_devtree_pdata(dev);
+		pdata = gpio_keys_get_devtree_pdata(&pdev->dev);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
 	}
 
 	size = sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data);
-	ddata = devm_kzalloc(dev, size, GFP_KERNEL);
+	ddata = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
 	if (!ddata) {
-		dev_err(dev, "failed to allocate state\n");
+		dev_err(&pdev->dev, "failed to allocate state\n");
 		return -ENOMEM;
 	}
 
-	input = devm_input_allocate_device(dev);
+	input = devm_input_allocate_device(&pdev->dev);
 	if (!input) {
-		dev_err(dev, "failed to allocate input device\n");
+		dev_err(&pdev->dev, "failed to allocate input device\n");
 		return -ENOMEM;
 	}
 
@@ -748,7 +747,7 @@ static int gpio_keys_probe(struct platform_device *pdev)
 		const struct gpio_keys_button *button = &pdata->buttons[i];
 		struct gpio_button_data *bdata = &ddata->data[i];
 
-		error = gpio_keys_setup_key(pdev, input, bdata, button);
+		error = gpio_keys_setup_key(&pdev->dev, input, bdata, button);
 		if (error)
 			return error;
 
@@ -758,14 +757,16 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 	error = sysfs_create_group(&pdev->dev.kobj, &gpio_keys_attr_group);
 	if (error) {
-		dev_err(dev, "Unable to export keys/switches, error: %d\n",
+		dev_err(&pdev->dev,
+			"Unable to export keys/switches, error: %d\n",
 			error);
 		return error;
 	}
 
 	error = input_register_device(input);
 	if (error) {
-		dev_err(dev, "Unable to register input device, error: %d\n",
+		dev_err(&pdev->dev,
+			"Unable to register input device, error: %d\n",
 			error);
 		goto err_remove_group;
 	}
-- 
1.8.2.2
