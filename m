From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: imx_keypad - use devm_ functions
Date: Wed, 13 Mar 2013 01:21:24 -0300
Message-ID: <1363148484-5920-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:63970 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab3CMEVg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Mar 2013 00:21:36 -0400
Received: by mail-ea0-f177.google.com with SMTP id r16so193798ead.8
        for <linux-input@vger.kernel.org>; Tue, 12 Mar 2013 21:21:35 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: s.hauer@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_ functions can make the code cleaner and simpler. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c |   63 ++++++++---------------------------
 1 file changed, 14 insertions(+), 49 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 98f9113..09a7a04 100644
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
@@ -527,44 +516,29 @@ static int imx_keypad_probe(struct platform_device *pdev)
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
 }
 
 static int imx_keypad_remove(struct platform_device *pdev)
 {
 	struct imx_keypad *keypad = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	dev_dbg(&pdev->dev, ">%s\n", __func__);
 
@@ -572,15 +546,6 @@ static int imx_keypad_remove(struct platform_device *pdev)
 
 	input_unregister_device(keypad->input_dev);
 
-	free_irq(keypad->irq, keypad);
-	clk_put(keypad->clk);
-
-	iounmap(keypad->mmio_base);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
-	kfree(keypad);
-
 	return 0;
 }
 
-- 
1.7.9.5

