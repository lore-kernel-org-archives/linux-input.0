From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: max8925_onkey - avoid accessing input device too early
Date: Mon, 5 Mar 2012 22:31:35 -0800
Message-ID: <20120306063135.GB27389@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:50969 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758506Ab2CFIir (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Mar 2012 03:38:47 -0500
Received: by dadp12 with SMTP id p12so6370008dad.11
        for <linux-input@vger.kernel.org>; Tue, 06 Mar 2012 00:38:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Kevin Liu <kliu5@marvell.com>, linux-input@vger.kernel.org

Input device must be allocated (but not necessarily registered) before
requesting IRQs, otherwise there is a chance that IRQ handler fires and
tries to reference not yet allocated input device.

Also it makes sense to store relative IRQ numbers in max8925_onkey_info
structure as they are needed in suspend/resume which we expect to be
called more often than probe and remove.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/max8925_onkey.c |   91 +++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 47 deletions(-)


diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc/max8925_onkey.c
index 2717477..0a12b74 100644
--- a/drivers/input/misc/max8925_onkey.c
+++ b/drivers/input/misc/max8925_onkey.c
@@ -1,5 +1,5 @@
 /**
- * max8925_onkey.c - MAX8925 ONKEY driver
+ * MAX8925 ONKEY driver
  *
  * Copyright (C) 2009 Marvell International Ltd.
  *      Haojian Zhuang <haojian.zhuang@marvell.com>
@@ -35,7 +35,7 @@ struct max8925_onkey_info {
 	struct input_dev	*idev;
 	struct i2c_client	*i2c;
 	struct device		*dev;
-	int			irq[2];
+	unsigned int		irq[2];
 };
 
 /*
@@ -46,17 +46,14 @@ struct max8925_onkey_info {
 static irqreturn_t max8925_onkey_handler(int irq, void *data)
 {
 	struct max8925_onkey_info *info = data;
-	int ret, event;
-
-	ret = max8925_reg_read(info->i2c, MAX8925_ON_OFF_STATUS);
-	if (ret & SW_INPUT)
-		event = 1;
-	else
-		event = 0;
-	input_report_key(info->idev, KEY_POWER, event);
+	int state;
+
+	state = max8925_reg_read(info->i2c, MAX8925_ON_OFF_STATUS);
+
+	input_report_key(info->idev, KEY_POWER, state & SW_INPUT);
 	input_sync(info->idev);
 
-	dev_dbg(info->dev, "onkey event:%d\n", event);
+	dev_dbg(info->dev, "onkey state:%d\n", state);
 
 	/* Enable hardreset to halt if system isn't shutdown on time */
 	max8925_set_bits(info->i2c, MAX8925_SYSENSEL,
@@ -69,6 +66,7 @@ static int __devinit max8925_onkey_probe(struct platform_device *pdev)
 {
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct max8925_onkey_info *info;
+	struct input_dev *input;
 	int irq[2], error;
 
 	irq[0] = platform_get_irq(pdev, 0);
@@ -76,6 +74,7 @@ static int __devinit max8925_onkey_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "No IRQ resource!\n");
 		return -EINVAL;
 	}
+
 	irq[1] = platform_get_irq(pdev, 1);
 	if (irq[1] < 0) {
 		dev_err(&pdev->dev, "No IRQ resource!\n");
@@ -83,11 +82,24 @@ static int __devinit max8925_onkey_probe(struct platform_device *pdev)
 	}
 
 	info = kzalloc(sizeof(struct max8925_onkey_info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
+	input = input_allocate_device();
+	if (!info || !input) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
 
+	info->idev = input;
 	info->i2c = chip->i2c;
 	info->dev = &pdev->dev;
+	info->irq[0] = irq[0];
+	info->irq[1] = irq[1];
+
+	input->name = "max8925_on";
+	input->phys = "max8925_on/input0";
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = &pdev->dev;
+	input_set_capability(input, EV_KEY, KEY_POWER);
+
 	irq[0] += chip->irq_base;
 	irq[1] += chip->irq_base;
 
@@ -96,61 +108,46 @@ static int __devinit max8925_onkey_probe(struct platform_device *pdev)
 	if (error < 0) {
 		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
 			irq[0], error);
-		goto out;
+		goto err_free_mem;
 	}
+
 	error = request_threaded_irq(irq[1], NULL, max8925_onkey_handler,
 				     IRQF_ONESHOT, "onkey-up", info);
 	if (error < 0) {
 		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
 			irq[1], error);
-		goto out_irq;
+		goto err_free_irq0;
 	}
 
-	info->idev = input_allocate_device();
-	if (!info->idev) {
-		dev_err(chip->dev, "Failed to allocate input dev\n");
-		error = -ENOMEM;
-		goto out_input;
-	}
-
-	info->idev->name = "max8925_on";
-	info->idev->phys = "max8925_on/input0";
-	info->idev->id.bustype = BUS_I2C;
-	info->idev->dev.parent = &pdev->dev;
-	info->irq[0] = irq[0];
-	info->irq[1] = irq[1];
-	info->idev->evbit[0] = BIT_MASK(EV_KEY);
-	info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
-
-	device_init_wakeup(&pdev->dev, 1);
-
 	error = input_register_device(info->idev);
 	if (error) {
 		dev_err(chip->dev, "Can't register input device: %d\n", error);
-		goto out_reg;
+		goto err_free_irq1;
 	}
 
 	platform_set_drvdata(pdev, info);
+	device_init_wakeup(&pdev->dev, 1);
 
 	return 0;
 
-out_reg:
-	input_free_device(info->idev);
-out_input:
-	free_irq(info->irq[1], info);
-out_irq:
-	free_irq(info->irq[0], info);
-out:
+err_free_irq1:
+	free_irq(irq[1], info);
+err_free_irq0:
+	free_irq(irq[0], info);
+err_free_mem:
+	input_free_device(input);
 	kfree(info);
+
 	return error;
 }
 
 static int __devexit max8925_onkey_remove(struct platform_device *pdev)
 {
 	struct max8925_onkey_info *info = platform_get_drvdata(pdev);
+	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
 
-	free_irq(info->irq[0], info);
-	free_irq(info->irq[1], info);
+	free_irq(info->irq[0] + chip->irq_base, info);
+	free_irq(info->irq[1] + chip->irq_base, info);
 	input_unregister_device(info->idev);
 	kfree(info);
 
@@ -167,8 +164,8 @@ static int max8925_onkey_suspend(struct device *dev)
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
 
 	if (device_may_wakeup(dev)) {
-		chip->wakeup_flag |= 1 << (info->irq[0] - chip->irq_base);
-		chip->wakeup_flag |= 1 << (info->irq[1] - chip->irq_base);
+		chip->wakeup_flag |= 1 << info->irq[0];
+		chip->wakeup_flag |= 1 << info->irq[1];
 	}
 
 	return 0;
@@ -181,8 +178,8 @@ static int max8925_onkey_resume(struct device *dev)
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
 
 	if (device_may_wakeup(dev)) {
-		chip->wakeup_flag &= ~(1 << (info->irq[0] - chip->irq_base));
-		chip->wakeup_flag &= ~(1 << (info->irq[1] - chip->irq_base));
+		chip->wakeup_flag &= ~(1 << info->irq[0]);
+		chip->wakeup_flag &= ~(1 << info->irq[1]);
 	}
 
 	return 0;
-- 
Dmitry
