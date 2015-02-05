From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH v2] bfin_rotary: convert to use managed resources
Date: Thu, 5 Feb 2015 16:29:13 +0800
Message-ID: <1423124953-9564-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0092.outbound.protection.outlook.com ([65.55.169.92]:20032
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754745AbbBEIbd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Feb 2015 03:31:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

- remap rotary register physical address into kernel space in probe
- replace kzalloc with devm_kzalloc
- replace request_irq with devm_request_irq
- remove memory free and irq free from the device remove function
- use devm_input_allocate_device

v2-changes:
- remove rotary register address remap operation from this patch
- Use devm_add_action() to integrate freeing of pins into the
rest of devm* unwind sequence.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/input/misc/bfin_rotary.c |   84 ++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 45 deletions(-)

diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index dd929ad..80f66e7 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -93,6 +93,13 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+
+static void bfin_rotary_free_action(void *data)
+{
+	unsigned short *pin_list = (unsigned short *)data;
+	peripheral_free_list(pin_list);
+}
+
 static int bfin_rotary_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -102,6 +109,31 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 	struct input_dev *input;
 	int error;
 
+	rotary = devm_kzalloc(dev, sizeof(struct bfin_rot), GFP_KERNEL);
+	if (!rotary) {
+		dev_err(dev, "fail to malloc bfin_rot\n");
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rotary->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(rotary->base))
+		return PTR_ERR(rotary->base);
+
+	rotary->irq = platform_get_irq(pdev, 0);
+	if (rotary->irq < 0) {
+		dev_err(dev, "No rotary IRQ specified\n");
+		return -ENOENT;
+	}
+
+	error = devm_request_irq(dev, rotary->irq, bfin_rotary_isr,
+			    0, dev_name(&pdev->dev), pdev);
+	if (error) {
+		dev_err(dev, "unable to claim irq %d; error %d\n",
+			rotary->irq, error);
+		return error;
+	}
+
 	/* Basic validation */
 	if ((pdata->rotary_up_key && !pdata->rotary_down_key) ||
 	    (!pdata->rotary_up_key && pdata->rotary_down_key)) {
@@ -110,23 +142,15 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 
 	error = peripheral_request_list(pdata->pin_list, dev_name(&pdev->dev));
 	if (error) {
-		dev_err(&pdev->dev, "requesting peripherals failed\n");
+		dev_err(dev, "requesting peripherals failed\n");
 		return error;
 	}
 
-	rotary = kzalloc(sizeof(struct bfin_rot), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!rotary || !input) {
-		error = -ENOMEM;
-		goto out1;
-	}
+	devm_add_action(dev, bfin_rotary_free_action, pdata->pin_list);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rotary->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(rotary->base)) {
-		error = PTR_ERR(rotary->base);
-		goto out1;
-	}
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
 
 	rotary->input = input;
 
@@ -135,10 +159,6 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 	rotary->button_key = pdata->rotary_button_key;
 	rotary->rel_code = pdata->rotary_rel_code;
 
-	error = rotary->irq = platform_get_irq(pdev, 0);
-	if (error < 0)
-		goto out1;
-
 	input->name = pdev->name;
 	input->phys = "bfin-rotary/input0";
 	input->dev.parent = &pdev->dev;
@@ -164,20 +184,10 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 		__set_bit(rotary->button_key, input->keybit);
 	}
 
-	error = request_irq(rotary->irq, bfin_rotary_isr,
-			    0, dev_name(&pdev->dev), pdev);
-	if (error) {
-		dev_err(&pdev->dev,
-			"unable to claim irq %d; error %d\n",
-			rotary->irq, error);
-		goto out1;
-	}
-
 	error = input_register_device(input);
 	if (error) {
-		dev_err(&pdev->dev,
-			"unable to register input device (%d)\n", error);
-		goto out2;
+		dev_err(dev, "unable to register input device (%d)\n", error);
+		return error;
 	}
 
 	if (pdata->rotary_button_key)
@@ -201,31 +211,15 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 1);
 
 	return 0;
-
-out2:
-	free_irq(rotary->irq, pdev);
-out1:
-	input_free_device(input);
-	kfree(rotary);
-	peripheral_free_list(pdata->pin_list);
-
-	return error;
 }
 
 static int bfin_rotary_remove(struct platform_device *pdev)
 {
-	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct bfin_rot *rotary = platform_get_drvdata(pdev);
 
 	writew(0, rotary->base + CNT_CONFIG_OFF);
 	writew(0, rotary->base + CNT_IMASK_OFF);
 
-	free_irq(rotary->irq, pdev);
-	input_unregister_device(rotary->input);
-	peripheral_free_list(pdata->pin_list);
-
-	kfree(rotary);
-
 	return 0;
 }
 
-- 
1.7.9.5

