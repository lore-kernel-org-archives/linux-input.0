From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] input: samsung-keypad: Use devm_* functions
Date: Thu, 22 Nov 2012 23:28:08 -0800
Message-ID: <20121123072808.GC12631@core.coreip.homeip.net>
References: <1352980598-6305-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43050 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932894Ab2KWH2M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Nov 2012 02:28:12 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3357669pad.19
        for <linux-input@vger.kernel.org>; Thu, 22 Nov 2012 23:28:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352980598-6305-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, patches@linaro.org

Hi Sachin,

On Thu, Nov 15, 2012 at 05:26:38PM +0530, Sachin Kamat wrote:
>  
> -	keypad->base = ioremap(res->start, resource_size(res));
> -	if (!keypad->base) {
> -		error = -EBUSY;
> -		goto err_free_mem;
> -	}
> +	keypad->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));

Question: why don't you request this region? Is it done in platform
code?

> +	if (!keypad->base)
> +		return -EBUSY;
>  
> -	keypad->clk = clk_get(&pdev->dev, "keypad");
> +	keypad->clk = devm_clk_get(&pdev->dev, "keypad");
>  	if (IS_ERR(keypad->clk)) {
>  		dev_err(&pdev->dev, "failed to get keypad clk\n");
> -		error = PTR_ERR(keypad->clk);
> -		goto err_unmap_base;
> +		return PTR_ERR(keypad->clk);
>  	}
>  
>  	error = clk_prepare(keypad->clk);
>  	if (error) {
>  		dev_err(&pdev->dev, "keypad clock prepare failed\n");
> -		goto err_put_clk;
> +		goto err_dt_gpio_free;

Why are you trying to free GPIOs here, you have not parsed them yet.
This should be just "return error;".

>  	}
>  
>  	keypad->input_dev = input_dev;
> @@ -479,14 +472,15 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>  	keypad->irq = platform_get_irq(pdev, 0);
>  	if (keypad->irq < 0) {
>  		error = keypad->irq;
> -		goto err_put_clk;
> +		goto err_dt_gpio_free;

No, this should do clk_unprepare().

>  	}
>  
> -	error = request_threaded_irq(keypad->irq, NULL, samsung_keypad_irq,
> -			IRQF_ONESHOT, dev_name(&pdev->dev), keypad);
> +	error = devm_request_threaded_irq(&pdev->dev, keypad->irq, NULL,
> +					  samsung_keypad_irq, IRQF_ONESHOT,
> +					  dev_name(&pdev->dev), keypad);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to register keypad interrupt\n");
> -		goto err_put_clk;
> +		goto err_dt_gpio_free;

Same here.

Also, if you are converting to devm_* you do not need
samsung_keypad_dt_gpio_free() as you can allocate gpios with
devm_reguats_gpio().

Does the version of the patch below still work for you?

Thanks.

-- 
Dmitry

Input: samsung-keypad - Use devm_* functions

From: Sachin Kamat <sachin.kamat@linaro.org>

devm_* functions are device managed and make error handling
and code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c |  106 +++++++++----------------------
 1 file changed, 32 insertions(+), 74 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 8b0b361..2b7cbdb 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -313,21 +313,22 @@ static void samsung_keypad_parse_dt_gpio(struct device *dev,
 				struct samsung_keypad *keypad)
 {
 	struct device_node *np = dev->of_node;
-	int gpio, ret, row, col;
+	int gpio, error, row, col;
 
 	for (row = 0; row < keypad->rows; row++) {
 		gpio = of_get_named_gpio(np, "row-gpios", row);
 		keypad->row_gpios[row] = gpio;
 		if (!gpio_is_valid(gpio)) {
 			dev_err(dev, "keypad row[%d]: invalid gpio %d\n",
-					row, gpio);
+				row, gpio);
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
+				rowi, error);
 	}
 
 	for (col = 0; col < keypad->cols; col++) {
@@ -335,39 +336,23 @@ static void samsung_keypad_parse_dt_gpio(struct device *dev,
 		keypad->col_gpios[col] = gpio;
 		if (!gpio_is_valid(gpio)) {
 			dev_err(dev, "keypad column[%d]: invalid gpio %d\n",
-					col, gpio);
+				col, gpio);
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
 
 static int __devinit samsung_keypad_probe(struct platform_device *pdev)
@@ -408,36 +393,29 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
 	row_shift = get_count_order(pdata->cols);
 	keymap_size = (pdata->rows << row_shift) * sizeof(keypad->keycodes[0]);
 
-	keypad = kzalloc(sizeof(*keypad) + keymap_size, GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!keypad || !input_dev) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
+	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad) + keymap_size, GFP_KERNEL);
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
@@ -482,14 +460,15 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
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
@@ -498,7 +477,7 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
 
 	error = input_register_device(keypad->input_dev);
 	if (error)
-		goto err_free_irq;
+		goto err_disable_runtime_pm;
 
 	if (pdev->dev.of_node) {
 		devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
@@ -507,22 +486,12 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
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
 
@@ -536,18 +505,7 @@ static int __devexit samsung_keypad_remove(struct platform_device *pdev)
 
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
