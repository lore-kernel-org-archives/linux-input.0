From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RESEND 2/2] input: gpio_keys: Convert to devm-* API
Date: Sat, 26 Apr 2014 09:53:14 +0400
Message-ID: <1398491594-2004-2-git-send-email-shc_work@mail.ru>
References: <1398491594-2004-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.mail.ru ([94.100.176.130]:60128 "EHLO smtp2.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbaDZFxY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Apr 2014 01:53:24 -0400
In-Reply-To: <1398491594-2004-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Shiyan <shc_work@mail.ru>

Replace existing resource handling in the driver with managed
device resource, this ensures more consistent error values and
simplifies error paths.
kzalloc -> devm_kzalloc
gpio_request_one -> devm_gpio_request_one
input_allocate_device -> devm_input_allocate_device

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/keyboard/gpio_keys.c | 96 +++++++++++---------------------------
 1 file changed, 28 insertions(+), 68 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 2db1324..c4bc6e4 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -433,7 +433,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	irq_handler_t isr;
 	unsigned long irqflags;
-	int irq, error;
+	int error;
 
 	bdata->input = input;
 	bdata->button = button;
@@ -441,7 +441,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 	if (gpio_is_valid(button->gpio)) {
 
-		error = gpio_request_one(button->gpio, GPIOF_IN, desc);
+		error = devm_gpio_request_one(&pdev->dev, button->gpio,
+					      GPIOF_IN, desc);
 		if (error < 0) {
 			dev_err(dev, "Failed to request GPIO %d, error %d\n",
 				button->gpio, error);
@@ -457,15 +458,13 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 						button->debounce_interval;
 		}
 
-		irq = gpio_to_irq(button->gpio);
-		if (irq < 0) {
-			error = irq;
+		bdata->irq = gpio_to_irq(button->gpio);
+		if (bdata->irq < 0) {
 			dev_err(dev,
 				"Unable to get irq number for GPIO %d, error %d\n",
-				button->gpio, error);
-			goto fail;
+				button->gpio, bdata->irq);
+			return bdata->irq;
 		}
-		bdata->irq = irq;
 
 		INIT_WORK(&bdata->work, gpio_keys_gpio_work_func);
 		setup_timer(&bdata->timer,
@@ -507,16 +506,10 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	if (error < 0) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
 			bdata->irq, error);
-		goto fail;
+		return error;
 	}
 
 	return 0;
-
-fail:
-	if (gpio_is_valid(button->gpio))
-		gpio_free(button->gpio);
-
-	return error;
 }
 
 static void gpio_keys_report_state(struct gpio_keys_drvdata *ddata)
@@ -573,28 +566,20 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	struct device_node *node, *pp;
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
-	int error;
-	int nbuttons;
-	int i;
+	int i, nbuttons;
 
 	node = dev->of_node;
-	if (!node) {
-		error = -ENODEV;
-		goto err_out;
-	}
+	if (!node)
+		return ERR_PTR(-ENODEV);
 
 	nbuttons = of_get_child_count(node);
-	if (nbuttons == 0) {
-		error = -ENODEV;
-		goto err_out;
-	}
+	if (nbuttons == 0)
+		return ERR_PTR(-ENODEV);
 
-	pdata = kzalloc(sizeof(*pdata) + nbuttons * (sizeof *button),
-			GFP_KERNEL);
-	if (!pdata) {
-		error = -ENOMEM;
-		goto err_out;
-	}
+	pdata = devm_kzalloc(dev, sizeof(*pdata) + nbuttons * sizeof(*button),
+			     GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
 
 	pdata->buttons = (struct gpio_keys_button *)(pdata + 1);
 	pdata->nbuttons = nbuttons;
@@ -614,12 +599,11 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 		gpio = of_get_gpio_flags(pp, 0, &flags);
 		if (gpio < 0) {
-			error = gpio;
-			if (error != -EPROBE_DEFER)
+			if (gpio != -EPROBE_DEFER)
 				dev_err(dev,
 					"Failed to get gpio flags, error: %d\n",
-					error);
-			goto err_free_pdata;
+					gpio);
+			return ERR_PTR(gpio);
 		}
 
 		button = &pdata->buttons[i++];
@@ -630,8 +614,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 		if (of_property_read_u32(pp, "linux,code", &button->code)) {
 			dev_err(dev, "Button without keycode: 0x%x\n",
 				button->gpio);
-			error = -EINVAL;
-			goto err_free_pdata;
+			return ERR_PTR(-EINVAL);
 		}
 
 		button->desc = of_get_property(pp, "label", NULL);
@@ -646,17 +629,10 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			button->debounce_interval = 5;
 	}
 
-	if (pdata->nbuttons == 0) {
-		error = -EINVAL;
-		goto err_free_pdata;
-	}
+	if (!pdata->nbuttons)
+		return ERR_PTR(-EINVAL);
 
 	return pdata;
-
-err_free_pdata:
-	kfree(pdata);
-err_out:
-	return ERR_PTR(error);
 }
 
 static struct of_device_id gpio_keys_of_match[] = {
@@ -681,8 +657,6 @@ static void gpio_remove_key(struct gpio_button_data *bdata)
 	if (bdata->timer_debounce)
 		del_timer_sync(&bdata->timer);
 	cancel_work_sync(&bdata->work);
-	if (gpio_is_valid(bdata->button->gpio))
-		gpio_free(bdata->button->gpio);
 }
 
 static int gpio_keys_probe(struct platform_device *pdev)
@@ -700,14 +674,13 @@ static int gpio_keys_probe(struct platform_device *pdev)
 			return PTR_ERR(pdata);
 	}
 
-	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
-			pdata->nbuttons * sizeof(struct gpio_button_data),
-			GFP_KERNEL);
-	input = input_allocate_device();
+	ddata = devm_kzalloc(&pdev->dev, sizeof(struct gpio_keys_drvdata) +
+			     pdata->nbuttons * sizeof(struct gpio_button_data),
+			     GFP_KERNEL);
+	input = devm_input_allocate_device(&pdev->dev);
 	if (!ddata || !input) {
 		dev_err(dev, "failed to allocate state\n");
-		error = -ENOMEM;
-		goto fail1;
+		return -ENOMEM;
 	}
 
 	ddata->pdata = pdata;
@@ -768,13 +741,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	while (--i >= 0)
 		gpio_remove_key(&ddata->data[i]);
 
- fail1:
-	input_free_device(input);
-	kfree(ddata);
-	/* If we have no platform data, we allocated pdata dynamically. */
-	if (!dev_get_platdata(&pdev->dev))
-		kfree(pdata);
-
 	return error;
 }
 
@@ -793,12 +759,6 @@ static int gpio_keys_remove(struct platform_device *pdev)
 
 	input_unregister_device(input);
 
-	/* If we have no platform data, we allocated pdata dynamically. */
-	if (!dev_get_platdata(&pdev->dev))
-		kfree(ddata->pdata);
-
-	kfree(ddata);
-
 	return 0;
 }
 
-- 
1.8.3.2

