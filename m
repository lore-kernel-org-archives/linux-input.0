From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH v2] Input: samsung-keypad - Use devm_* functions
Date: Tue, 27 Nov 2012 15:24:51 +0530
Message-ID: <1354010091-31294-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47385 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933272Ab2K0KBV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 05:01:21 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so5814005pad.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 02:01:20 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, patches@linaro.org, Kukjin Kim <kgene.kim@samsung.com>

devm_* functions are device managed and make error handling
and code simpler. While at it also fix error exit paths.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c |  103 +++++++++---------------------
 1 files changed, 31 insertions(+), 72 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index acc1619..22e357b 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -309,7 +309,7 @@ static void samsung_keypad_parse_dt_gpio(struct device *dev,
 				struct samsung_keypad *keypad)
 {
 	struct device_node *np = dev->of_node;
-	int gpio, ret, row, col;
+	int gpio, error, row, col;
 
 	for (row = 0; row < keypad->rows; row++) {
 		gpio = of_get_named_gpio(np, "row-gpios", row);
@@ -320,10 +320,11 @@ static void samsung_keypad_parse_dt_gpio(struct device *dev,
 			continue;
 		}
 
-		ret = gpio_request(gpio, "keypad-row");
-		if (ret)
-			dev_err(dev, "keypad row[%d] gpio request failed\n",
-					row);
+		error = devm_gpio_request(dev, gpio, "keypad-row");
+		if (error)
+			dev_err(dev,
+				"keypad row[%d] gpio request failed: %d\n",
+				row, error);
 	}
 
 	for (col = 0; col < keypad->cols; col++) {
@@ -335,35 +336,19 @@ static void samsung_keypad_parse_dt_gpio(struct device *dev,
 			continue;
 		}
 
-		ret = gpio_request(gpio, "keypad-col");
-		if (ret)
-			dev_err(dev, "keypad column[%d] gpio request failed\n",
-					col);
+		error = devm_gpio_request(dev, gpio, "keypad-col");
+		if (error)
+			dev_err(dev,
+				"keypad column[%d] gpio request failed: %d\n",
+				col, error);
 	}
 }
-
-static void samsung_keypad_dt_gpio_free(struct samsung_keypad *keypad)
-{
-	int cnt;
-
-	for (cnt = 0; cnt < keypad->rows; cnt++)
-		if (gpio_is_valid(keypad->row_gpios[cnt]))
-			gpio_free(keypad->row_gpios[cnt]);
-
-	for (cnt = 0; cnt < keypad->cols; cnt++)
-		if (gpio_is_valid(keypad->col_gpios[cnt]))
-			gpio_free(keypad->col_gpios[cnt]);
-}
 #else
 static
 struct samsung_keypad_platdata *samsung_keypad_parse_dt(struct device *dev)
 {
 	return NULL;
 }
-
-static void samsung_keypad_dt_gpio_free(struct samsung_keypad *keypad)
-{
-}
 #endif
 
 static int samsung_keypad_probe(struct platform_device *pdev)
@@ -405,36 +390,30 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	row_shift = get_count_order(pdata->cols);
 	keymap_size = (pdata->rows << row_shift) * sizeof(keypad->keycodes[0]);
 
-	keypad = kzalloc(sizeof(*keypad) + keymap_size, GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!keypad || !input_dev) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
+	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad) + keymap_size,
+			      GFP_KERNEL);
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!keypad || !input_dev)
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		error = -ENODEV;
-		goto err_free_mem;
-	}
+	if (!res)
+		return -ENODEV;
 
-	keypad->base = ioremap(res->start, resource_size(res));
-	if (!keypad->base) {
-		error = -EBUSY;
-		goto err_free_mem;
-	}
+	keypad->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!keypad->base)
+		return -EBUSY;
 
-	keypad->clk = clk_get(&pdev->dev, "keypad");
+	keypad->clk = devm_clk_get(&pdev->dev, "keypad");
 	if (IS_ERR(keypad->clk)) {
 		dev_err(&pdev->dev, "failed to get keypad clk\n");
-		error = PTR_ERR(keypad->clk);
-		goto err_unmap_base;
+		return PTR_ERR(keypad->clk);
 	}
 
 	error = clk_prepare(keypad->clk);
 	if (error) {
 		dev_err(&pdev->dev, "keypad clock prepare failed\n");
-		goto err_put_clk;
+		return error;
 	}
 
 	keypad->input_dev = input_dev;
@@ -479,14 +458,15 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	keypad->irq = platform_get_irq(pdev, 0);
 	if (keypad->irq < 0) {
 		error = keypad->irq;
-		goto err_put_clk;
+		goto err_unprepare_clk;
 	}
 
-	error = request_threaded_irq(keypad->irq, NULL, samsung_keypad_irq,
-			IRQF_ONESHOT, dev_name(&pdev->dev), keypad);
+	error = devm_request_threaded_irq(&pdev->dev, keypad->irq, NULL,
+					  samsung_keypad_irq, IRQF_ONESHOT,
+					  dev_name(&pdev->dev), keypad);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register keypad interrupt\n");
-		goto err_put_clk;
+		goto err_unprepare_clk;
 	}
 
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
@@ -495,7 +475,7 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 
 	error = input_register_device(keypad->input_dev);
 	if (error)
-		goto err_free_irq;
+		goto err_disable_runtime_pm;
 
 	if (pdev->dev.of_node) {
 		devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
@@ -504,22 +484,12 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	}
 	return 0;
 
-err_free_irq:
-	free_irq(keypad->irq, keypad);
+err_disable_runtime_pm:
 	pm_runtime_disable(&pdev->dev);
 	device_init_wakeup(&pdev->dev, 0);
 	platform_set_drvdata(pdev, NULL);
 err_unprepare_clk:
 	clk_unprepare(keypad->clk);
-err_put_clk:
-	clk_put(keypad->clk);
-	samsung_keypad_dt_gpio_free(keypad);
-err_unmap_base:
-	iounmap(keypad->base);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(keypad);
-
 	return error;
 }
 
@@ -533,18 +503,7 @@ static int samsung_keypad_remove(struct platform_device *pdev)
 
 	input_unregister_device(keypad->input_dev);
 
-	/*
-	 * It is safe to free IRQ after unregistering device because
-	 * samsung_keypad_close will shut off interrupts.
-	 */
-	free_irq(keypad->irq, keypad);
-
 	clk_unprepare(keypad->clk);
-	clk_put(keypad->clk);
-	samsung_keypad_dt_gpio_free(keypad);
-
-	iounmap(keypad->base);
-	kfree(keypad);
 
 	return 0;
 }
-- 
1.7.4.1

