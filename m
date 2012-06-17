From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 4/4] input/nomadik-ske: cleanup of probe and some more code style
Date: Sun, 17 Jun 2012 16:18:05 +0200
Message-ID: <1339942685-20194-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:38867 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757396Ab2FQOSV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jun 2012 10:18:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Naga Radesh Y <naga.radheshy@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

This fixes some kerneldoc, and clean up the probe function so we
split it in two parts: first allocate all resources and then start
the clock and begin initializing the hardware. We exit quickly
with negative error if the probe is unsucessful when getting
resources. We add a pointer to the device's struct device to be
used for dev_* prints and similar.

Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
Signed-off-by: Naga Radesh Y <naga.radheshy@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/keyboard/nomadik-ske-keypad.c |  152 +++++++++++++++------------
 1 file changed, 83 insertions(+), 69 deletions(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index ca802fe..a2f2479 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -53,14 +53,17 @@
 
 /**
  * struct ske_keypad  - data structure used by keypad driver
- * @irq:	irq no
- * @reg_base:	ske regsiters base address
- * @input:	pointer to input device object
- * @board:	keypad platform device
- * @keymap:	matrix scan code table for keycodes
- * @clk:	clock structure pointer
+ * @dev:		Pointer to the structure device
+ * @irq:		irq no
+ * @reg_base:		ske regsiters base address
+ * @input:		pointer to input device object
+ * @board:		keypad platform device
+ * @keymap:		matrix scan code table for keycodes
+ * @clk:		clock structure pointer
+ * @ske_keypad_lock:    lock used while writting into registers
  */
 struct ske_keypad {
+	struct device *dev;
 	int irq;
 	void __iomem *reg_base;
 	struct input_dev *input;
@@ -85,9 +88,9 @@ static void ske_keypad_set_bits(struct ske_keypad *keypad, u16 addr,
 	spin_unlock(&keypad->ske_keypad_lock);
 }
 
-/*
- * ske_keypad_chip_init: init keypad controller configuration
- *
+/**
+ * ske_keypad_chip_init() - init keypad controller configuration
+ * @keypad: pointer to device structure
  * Enable Multi key press detection, auto scan mode
  */
 static int __init ske_keypad_chip_init(struct ske_keypad *keypad)
@@ -225,6 +228,9 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 	struct ske_keypad *keypad;
 	struct input_dev *input;
 	struct resource *res;
+	struct clk *clk;
+	void __iomem *reg_base;
+	int ret = 0;
 	int irq;
 	int error;
 
@@ -242,40 +248,42 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "missing platform resources\n");
-		return -EINVAL;
+		return -ENXIO;
 	}
 
-	keypad = kzalloc(sizeof(struct ske_keypad), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!keypad || !input) {
-		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to request I/O memory\n");
+		return -EBUSY;
 	}
 
-	keypad->irq = irq;
-	keypad->board = plat;
-	keypad->input = input;
-	spin_lock_init(&keypad->ske_keypad_lock);
+	reg_base = ioremap(res->start, resource_size(res));
+	if (!reg_base) {
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+		ret = -ENXIO;
+		goto out_freerequest_memregions;
+	}
 
-	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
-		dev_err(&pdev->dev, "failed to request I/O memory\n");
-		error = -EBUSY;
-		goto err_free_mem;
+	clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "failed to clk_get\n");
+		ret = PTR_ERR(clk);
+		goto out_freeioremap;
 	}
 
-	keypad->reg_base = ioremap(res->start, resource_size(res));
-	if (!keypad->reg_base) {
-		dev_err(&pdev->dev, "failed to remap I/O memory\n");
-		error = -ENXIO;
-		goto err_free_mem_region;
+	/* resources are sane; we begin allocation */
+	keypad = kzalloc(sizeof(struct ske_keypad), GFP_KERNEL);
+	if (!keypad) {
+		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
+		goto out_freeclk;
 	}
+	keypad->dev = &pdev->dev;
 
-	keypad->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(keypad->clk)) {
-		dev_err(&pdev->dev, "failed to get clk\n");
-		error = PTR_ERR(keypad->clk);
-		goto err_iounmap;
+	input = input_allocate_device();
+	if (!input) {
+		dev_err(&pdev->dev, "failed to input_allocate_device\n");
+		ret = -ENOMEM;
+		goto out_freekeypad;
 	}
 
 	input->id.bustype = BUS_HOST;
@@ -287,37 +295,43 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 					   keypad->keymap, input);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to build keymap\n");
-		goto err_iounmap;
+		goto out_freekeypad;
 	}
 
 	input_set_capability(input, EV_MSC, MSC_SCAN);
+	input_set_drvdata(input, keypad);
+
+	__set_bit(EV_KEY, input->evbit);
 	if (!plat->no_autorepeat)
 		__set_bit(EV_REP, input->evbit);
 
-	clk_enable(keypad->clk);
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"unable to register input device: %d\n", ret);
+		goto out_freeinput;
+	}
 
-	/* go through board initialization helpers */
-	if (keypad->board->init)
-		keypad->board->init();
+	keypad->irq	= irq;
+	keypad->board	= plat;
+	keypad->input	= input;
+	keypad->reg_base = reg_base;
+	keypad->clk	= clk;
 
-	error = ske_keypad_chip_init(keypad);
-	if (error) {
-		dev_err(&pdev->dev, "unable to init keypad hardware\n");
-		goto err_clk_disable;
-	}
+	/* allocations are sane, we begin HW initialization */
+	clk_enable(keypad->clk);
 
-	error = request_threaded_irq(keypad->irq, NULL, ske_keypad_irq,
-				     IRQF_ONESHOT, "ske-keypad", keypad);
-	if (error) {
-		dev_err(&pdev->dev, "allocate irq %d failed\n", keypad->irq);
-		goto err_clk_disable;
+	if (keypad->board->init && keypad->board->init() < 0) {
+		dev_err(&pdev->dev, "keyboard init config failed\n");
+		ret = -EINVAL;
+		goto out_unregisterinput;
 	}
 
-	error = input_register_device(input);
-	if (error) {
-		dev_err(&pdev->dev,
-				"unable to register input device: %d\n", error);
-		goto err_free_irq;
+	ret =  request_threaded_irq(keypad->irq, NULL, ske_keypad_irq,
+				IRQF_ONESHOT, "ske-keypad", keypad);
+	if (ret) {
+		dev_err(&pdev->dev, "allocate irq %d failed\n", keypad->irq);
+		goto out_unregisterinput;
 	}
 
 	if (plat->wakeup_enable)
@@ -327,19 +341,21 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_free_irq:
-	free_irq(keypad->irq, keypad);
-err_clk_disable:
+out_unregisterinput:
+	input_unregister_device(input);
+	input = NULL;
 	clk_disable(keypad->clk);
-	clk_put(keypad->clk);
-err_iounmap:
-	iounmap(keypad->reg_base);
-err_free_mem_region:
-	release_mem_region(res->start, resource_size(res));
-err_free_mem:
+out_freeinput:
 	input_free_device(input);
+out_freekeypad:
 	kfree(keypad);
-	return error;
+out_freeclk:
+	clk_put(clk);
+out_freeioremap:
+	iounmap(reg_base);
+out_freerequest_memregions:
+	release_mem_region(res->start, resource_size(res));
+	return ret;
 }
 
 static int __devexit ske_keypad_remove(struct platform_device *pdev)
@@ -347,8 +363,6 @@ static int __devexit ske_keypad_remove(struct platform_device *pdev)
 	struct ske_keypad *keypad = platform_get_drvdata(pdev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	free_irq(keypad->irq, keypad);
-
 	input_unregister_device(keypad->input);
 
 	clk_disable(keypad->clk);
@@ -356,7 +370,7 @@ static int __devexit ske_keypad_remove(struct platform_device *pdev)
 
 	if (keypad->board->exit)
 		keypad->board->exit();
-
+	free_irq(keypad->irq, keypad);
 	iounmap(keypad->reg_base);
 	release_mem_region(res->start, resource_size(res));
 	kfree(keypad);
@@ -374,7 +388,7 @@ static int ske_keypad_suspend(struct device *dev)
 	if (device_may_wakeup(dev))
 		enable_irq_wake(irq);
 	else {
-		disable_irq(keypad->irq);
+		disable_irq(irq);
 		ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
 		clk_disable(keypad->clk);
 	}
@@ -392,7 +406,7 @@ static int ske_keypad_resume(struct device *dev)
 		disable_irq_wake(irq);
 	else {
 		clk_enable(keypad->clk);
-		enable_irq(keypad->irq);
+		enable_irq(irq);
 		ske_keypad_chip_init(keypad);
 	}
 
-- 
1.7.9.2

