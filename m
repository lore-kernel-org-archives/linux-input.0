From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] bfin_rotary: convert to use managed resources
Date: Thu, 5 Feb 2015 22:04:18 -0800
Message-ID: <20150206060418.GA18256@dtor-ws>
References: <1423124953-9564-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:61601 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbBFGEY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 01:04:24 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so5953042igq.0
        for <linux-input@vger.kernel.org>; Thu, 05 Feb 2015 22:04:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423124953-9564-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

On Thu, Feb 05, 2015 at 04:29:13PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> - remap rotary register physical address into kernel space in probe
> - replace kzalloc with devm_kzalloc
> - replace request_irq with devm_request_irq
> - remove memory free and irq free from the device remove function
> - use devm_input_allocate_device
> 
> v2-changes:
> - remove rotary register address remap operation from this patch
> - Use devm_add_action() to integrate freeing of pins into the
> rest of devm* unwind sequence.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/input/misc/bfin_rotary.c |   84 ++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
> index dd929ad..80f66e7 100644
> --- a/drivers/input/misc/bfin_rotary.c
> +++ b/drivers/input/misc/bfin_rotary.c
> @@ -93,6 +93,13 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +
> +static void bfin_rotary_free_action(void *data)
> +{
> +	unsigned short *pin_list = (unsigned short *)data;
> +	peripheral_free_list(pin_list);

This gives me warnign about unused variable because your stub for
peripheral_free_list() is not that great. Please convert them into empty
static inline functions so that you enjoy proper typechecking in all
cases.

In the meantime I'd like to apply the following version of the patch
(note that I adjusted the previous patch to check that pin_list is not
NULL so that this series does not depend on the arch patch you posted).

Thanks.

-- 
Dmitry

Input: bfin_rotary - convert to use managed resources

From: Sonic Zhang <sonic.zhang@analog.com>

Use of managed resources simplifies error handling.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/bfin_rotary.c |   84 ++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 45 deletions(-)

diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index 70ee33a..a39793c 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -94,6 +94,11 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void bfin_rotary_free_action(void *data)
+{
+	peripheral_free_list(data);
+}
+
 static int bfin_rotary_probe(struct platform_device *pdev)
 {
 	const struct bfin_rotary_platform_data *pdata =
@@ -110,28 +115,37 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	rotary = devm_kzalloc(dev, sizeof(struct bfin_rot), GFP_KERNEL);
+	if (!rotary)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rotary->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(rotary->base))
+		return PTR_ERR(rotary->base);
+
 	if (pdata->pin_list) {
 		error = peripheral_request_list(pdata->pin_list,
 						dev_name(&pdev->dev));
 		if (error) {
-			dev_err(&pdev->dev, "requesting peripherals failed\n");
+			dev_err(dev, "requesting peripherals failed: %d\n",
+				error);
 			return error;
 		}
-	}
 
-	rotary = kzalloc(sizeof(struct bfin_rot), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!rotary || !input) {
-		error = -ENOMEM;
-		goto out1;
+		error = devm_add_action(dev, bfin_rotary_free_action,
+					pdata->pin_list);
+		if (error) {
+			dev_err(dev, "setting cleanup action failed: %d\n",
+				error);
+			peripheral_free_list(pdata->pin_list);
+			return error;
+		}
 	}
 
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
 
@@ -140,10 +154,6 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 	rotary->button_key = pdata->rotary_button_key;
 	rotary->rel_code = pdata->rotary_rel_code;
 
-	error = rotary->irq = platform_get_irq(pdev, 0);
-	if (error < 0)
-		goto out1;
-
 	input->name = pdev->name;
 	input->phys = "bfin-rotary/input0";
 	input->dev.parent = &pdev->dev;
@@ -169,20 +179,24 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 		__set_bit(rotary->button_key, input->keybit);
 	}
 
-	error = request_irq(rotary->irq, bfin_rotary_isr,
-			    0, dev_name(&pdev->dev), pdev);
+	rotary->irq = platform_get_irq(pdev, 0);
+	if (rotary->irq < 0) {
+		dev_err(dev, "No rotary IRQ specified\n");
+		return -ENOENT;
+	}
+
+	error = devm_request_irq(dev, rotary->irq, bfin_rotary_isr,
+				 0, dev_name(&pdev->dev), pdev);
 	if (error) {
-		dev_err(&pdev->dev,
-			"unable to claim irq %d; error %d\n",
+		dev_err(dev, "unable to claim irq %d; error %d\n",
 			rotary->irq, error);
-		goto out1;
+		return error;
 	}
 
 	error = input_register_device(input);
 	if (error) {
-		dev_err(&pdev->dev,
-			"unable to register input device (%d)\n", error);
-		goto out2;
+		dev_err(dev, "unable to register input device (%d)\n", error);
+		return error;
 	}
 
 	if (pdata->rotary_button_key)
@@ -206,35 +220,15 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 1);
 
 	return 0;
-
-out2:
-	free_irq(rotary->irq, pdev);
-out1:
-	input_free_device(input);
-	kfree(rotary);
-	if (pdata->pin_list)
-		peripheral_free_list(pdata->pin_list);
-
-	return error;
 }
 
 static int bfin_rotary_remove(struct platform_device *pdev)
 {
-	const struct bfin_rotary_platform_data *pdata =
-					dev_get_platdata(&pdev->dev);
 	struct bfin_rot *rotary = platform_get_drvdata(pdev);
 
 	writew(0, rotary->base + CNT_CONFIG_OFF);
 	writew(0, rotary->base + CNT_IMASK_OFF);
 
-	free_irq(rotary->irq, pdev);
-	input_unregister_device(rotary->input);
-
-	if (pdata->pin_list)
-		peripheral_free_list(pdata->pin_list);
-
-	kfree(rotary);
-
 	return 0;
 }
 
