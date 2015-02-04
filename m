From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] bfin_rotary: convert to use managed resources
Date: Wed, 4 Feb 2015 15:58:06 +0800
Message-ID: <1423036686-31891-3-git-send-email-sonic.adi@gmail.com>
References: <1423036686-31891-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bon0064.outbound.protection.outlook.com ([157.56.111.64]:51046
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752856AbbBDIAr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Feb 2015 03:00:47 -0500
In-Reply-To: <1423036686-31891-1-git-send-email-sonic.adi@gmail.com>
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

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 arch/blackfin/mach-bf527/boards/ad7160eval.c |    5 ++
 arch/blackfin/mach-bf527/boards/ezkit.c      |    5 ++
 arch/blackfin/mach-bf548/boards/ezkit.c      |    5 ++
 arch/blackfin/mach-bf609/boards/ezkit.c      |    5 ++
 drivers/input/misc/bfin_rotary.c             |   64 ++++++++++++++------------
 5 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
index 029a050..68f2a8a 100644
--- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
+++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
@@ -688,6 +688,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
 
 static struct resource bfin_rotary_resources[] = {
 	{
+		.start = CNT_CONFIG,
+		.end   = CNT_CONFIG + 0xff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
 		.start = IRQ_CNT,
 		.end = IRQ_CNT,
 		.flags = IORESOURCE_IRQ,
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index cc80c5b..d4219e8 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -1114,6 +1114,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
 
 static struct resource bfin_rotary_resources[] = {
 	{
+		.start = CNT_CONFIG,
+		.end   = CNT_CONFIG + 0xff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
 		.start = IRQ_CNT,
 		.end = IRQ_CNT,
 		.flags = IORESOURCE_IRQ,
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
index 8f70f83..4204b98 100644
--- a/arch/blackfin/mach-bf548/boards/ezkit.c
+++ b/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -173,6 +173,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
 
 static struct resource bfin_rotary_resources[] = {
 	{
+		.start = CNT_CONFIG,
+		.end   = CNT_CONFIG + 0xff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
 		.start = IRQ_CNT,
 		.end = IRQ_CNT,
 		.flags = IORESOURCE_IRQ,
diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
index f9dc64d..7f9fc27 100644
--- a/arch/blackfin/mach-bf609/boards/ezkit.c
+++ b/arch/blackfin/mach-bf609/boards/ezkit.c
@@ -88,6 +88,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
 
 static struct resource bfin_rotary_resources[] = {
 	{
+		.start = CNT_CONFIG,
+		.end   = CNT_CONFIG + 0xff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
 		.start = IRQ_CNT,
 		.end = IRQ_CNT,
 		.flags = IORESOURCE_IRQ,
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index defddca..3bc0018 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -95,11 +95,38 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
 
 static int bfin_rotary_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct bfin_rot *rotary;
+	struct resource *res;
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
@@ -108,15 +135,14 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 
 	error = peripheral_request_list(pdata->pin_list, dev_name(&pdev->dev));
 	if (error) {
-		dev_err(&pdev->dev, "requesting peripherals failed\n");
+		dev_err(dev, "requesting peripherals failed\n");
 		return error;
 	}
 
-	rotary = kzalloc(sizeof(struct bfin_rot), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!rotary || !input) {
+	input = devm_input_allocate_device(dev);
+	if (!input) {
 		error = -ENOMEM;
-		goto out1;
+		goto out;
 	}
 
 	rotary->input = input;
@@ -126,10 +152,6 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 	rotary->button_key = pdata->rotary_button_key;
 	rotary->rel_code = pdata->rotary_rel_code;
 
-	error = rotary->irq = platform_get_irq(pdev, 0);
-	if (error < 0)
-		goto out1;
-
 	input->name = pdev->name;
 	input->phys = "bfin-rotary/input0";
 	input->dev.parent = &pdev->dev;
@@ -155,20 +177,10 @@ static int bfin_rotary_probe(struct platform_device *pdev)
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
+		goto out;
 	}
 
 	if (pdata->rotary_button_key)
@@ -193,11 +205,7 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 
 	return 0;
 
-out2:
-	free_irq(rotary->irq, pdev);
-out1:
-	input_free_device(input);
-	kfree(rotary);
+out:
 	peripheral_free_list(per_cnt);
 
 	return error;
@@ -211,12 +219,8 @@ static int bfin_rotary_remove(struct platform_device *pdev)
 	writew(0, rotary->base + CNT_CONFIG_OFF);
 	writew(0, rotary->base + CNT_IMASK_OFF);
 
-	free_irq(rotary->irq, pdev);
-	input_unregister_device(rotary->input);
 	peripheral_free_list(pdata->pin_list);
 
-	kfree(rotary);
-
 	return 0;
 }
 
-- 
1.7.9.5

