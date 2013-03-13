From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] Input: imx_keypad - use devm_ functions
Date: Wed, 13 Mar 2013 13:51:06 -0300
Message-ID: <1363193466-10737-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f178.google.com ([209.85.160.178]:52703 "EHLO
	mail-gh0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933907Ab3CMQ7M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Mar 2013 12:59:12 -0400
Received: by mail-gh0-f178.google.com with SMTP id g24so214058ghb.23
        for <linux-input@vger.kernel.org>; Wed, 13 Mar 2013 09:59:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: s.hauer@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_ functions can make the code cleaner and simpler. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Remove imx_keypad_remove()

 drivers/input/keyboard/imx_keypad.c |   77 +++++++----------------------------
 1 file changed, 14 insertions(+), 63 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 98f9113..03c8cc5 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -448,24 +448,17 @@ static int imx_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = request_mem_region(res->start, resource_size(res), pdev->name);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to request I/O memory\n");
-		return -EBUSY;
-	}
-
-	input_dev = input_allocate_device();
+	input_dev = devm_input_allocate_device(&pdev->dev);
 	if (!input_dev) {
 		dev_err(&pdev->dev, "failed to allocate the input device\n");
-		error = -ENOMEM;
-		goto failed_rel_mem;
+		return -ENOMEM;
 	}
 
-	keypad = kzalloc(sizeof(struct imx_keypad), GFP_KERNEL);
+	keypad = devm_kzalloc(&pdev->dev, sizeof(struct imx_keypad),
+			     GFP_KERNEL);
 	if (!keypad) {
 		dev_err(&pdev->dev, "not enough memory for driver data\n");
-		error = -ENOMEM;
-		goto failed_free_input;
+		return -ENOMEM;
 	}
 
 	keypad->input_dev = input_dev;
@@ -475,18 +468,14 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	setup_timer(&keypad->check_matrix_timer,
 		    imx_keypad_check_for_events, (unsigned long) keypad);
 
-	keypad->mmio_base = ioremap(res->start, resource_size(res));
-	if (keypad->mmio_base == NULL) {
-		dev_err(&pdev->dev, "failed to remap I/O memory\n");
-		error = -ENOMEM;
-		goto failed_free_priv;
-	}
+	keypad->mmio_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(keypad->mmio_base))
+		return PTR_ERR(keypad->mmio_base);
 
-	keypad->clk = clk_get(&pdev->dev, NULL);
+	keypad->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk)) {
 		dev_err(&pdev->dev, "failed to get keypad clock\n");
-		error = PTR_ERR(keypad->clk);
-		goto failed_unmap;
+		return PTR_ERR(keypad->clk);
 	}
 
 	/* Init the Input device */
@@ -502,7 +491,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
 					   keypad->keycodes, input_dev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to build keymap\n");
-		goto failed_clock_put;
+		return error;
 	}
 
 	/* Search for rows and cols enabled */
@@ -527,61 +516,24 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	imx_keypad_inhibit(keypad);
 	clk_disable_unprepare(keypad->clk);
 
-	error = request_irq(irq, imx_keypad_irq_handler, 0,
+	error = devm_request_irq(&pdev->dev, irq, imx_keypad_irq_handler, 0,
 			    pdev->name, keypad);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto failed_clock_put;
+		return error;
 	}
 
 	/* Register the input device */
 	error = input_register_device(input_dev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register input device\n");
-		goto failed_free_irq;
+		return error;
 	}
 
 	platform_set_drvdata(pdev, keypad);
 	device_init_wakeup(&pdev->dev, 1);
 
 	return 0;
-
-failed_free_irq:
-	free_irq(irq, pdev);
-failed_clock_put:
-	clk_put(keypad->clk);
-failed_unmap:
-	iounmap(keypad->mmio_base);
-failed_free_priv:
-	kfree(keypad);
-failed_free_input:
-	input_free_device(input_dev);
-failed_rel_mem:
-	release_mem_region(res->start, resource_size(res));
-	return error;
-}
-
-static int imx_keypad_remove(struct platform_device *pdev)
-{
-	struct imx_keypad *keypad = platform_get_drvdata(pdev);
-	struct resource *res;
-
-	dev_dbg(&pdev->dev, ">%s\n", __func__);
-
-	platform_set_drvdata(pdev, NULL);
-
-	input_unregister_device(keypad->input_dev);
-
-	free_irq(keypad->irq, keypad);
-	clk_put(keypad->clk);
-
-	iounmap(keypad->mmio_base);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
-	kfree(keypad);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -640,7 +592,6 @@ static struct platform_driver imx_keypad_driver = {
 		.of_match_table = of_match_ptr(imx_keypad_of_match),
 	},
 	.probe		= imx_keypad_probe,
-	.remove		= imx_keypad_remove,
 };
 module_platform_driver(imx_keypad_driver);
 
-- 
1.7.9.5

