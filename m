From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 2/2] input: gpio_keys: Convert to devm-* API
Date: Mon, 28 Apr 2014 19:30:21 -0700
Message-ID: <20140429023021.GB7672@core.coreip.homeip.net>
References: <1398491594-2004-1-git-send-email-shc_work@mail.ru>
 <1398491594-2004-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:59795 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbaD2CaY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Apr 2014 22:30:24 -0400
Received: by mail-pd0-f181.google.com with SMTP id y13so160747pdi.12
        for <linux-input@vger.kernel.org>; Mon, 28 Apr 2014 19:30:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398491594-2004-2-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

Hi Alexander,

On Sat, Apr 26, 2014 at 09:53:14AM +0400, Alexander Shiyan wrote:
> Replace existing resource handling in the driver with managed
> device resource, this ensures more consistent error values and
> simplifies error paths.
> kzalloc -> devm_kzalloc
> gpio_request_one -> devm_gpio_request_one
> input_allocate_device -> devm_input_allocate_device
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/input/keyboard/gpio_keys.c | 96 +++++++++++---------------------------
>  1 file changed, 28 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 2db1324..c4bc6e4 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -433,7 +433,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  	struct device *dev = &pdev->dev;
>  	irq_handler_t isr;
>  	unsigned long irqflags;
> -	int irq, error;
> +	int error;
>  
>  	bdata->input = input;
>  	bdata->button = button;
> @@ -441,7 +441,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  
>  	if (gpio_is_valid(button->gpio)) {
>  
> -		error = gpio_request_one(button->gpio, GPIOF_IN, desc);
> +		error = devm_gpio_request_one(&pdev->dev, button->gpio,
> +					      GPIOF_IN, desc);
>  		if (error < 0) {
>  			dev_err(dev, "Failed to request GPIO %d, error %d\n",
>  				button->gpio, error);
> @@ -457,15 +458,13 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  						button->debounce_interval;
>  		}
>  
> -		irq = gpio_to_irq(button->gpio);
> -		if (irq < 0) {
> -			error = irq;
> +		bdata->irq = gpio_to_irq(button->gpio);
> +		if (bdata->irq < 0) {

This is wrong, bdata->irq is unsigned.

Also I already applied the earlier version of the patch dealing with
non-gpio resources. How about the patch below?

Thanks.

-- 
Dmitry


Input: gpio_keys - more conversions to devm-* API

From: Alexander Shiyan <shc_work@mail.ru>

Replace existing gpio resource handling in the driver with managed
resources, this ensures more consistent error values and simplifies error
paths.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c |   69 ++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 52dc872..8d7d748 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -424,6 +424,16 @@ out:
 	return IRQ_HANDLED;
 }
 
+static void gpio_keys_quiesce_key(void *data)
+{
+	struct gpio_button_data *bdata = data;
+
+	if (bdata->timer_debounce)
+		del_timer_sync(&bdata->timer);
+
+	cancel_work_sync(&bdata->work);
+}
+
 static int gpio_keys_setup_key(struct platform_device *pdev,
 				struct input_dev *input,
 				struct gpio_button_data *bdata,
@@ -433,7 +443,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	irq_handler_t isr;
 	unsigned long irqflags;
-	int irq, error;
+	int irq;
+	int error;
 
 	bdata->input = input;
 	bdata->button = button;
@@ -441,7 +452,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 	if (gpio_is_valid(button->gpio)) {
 
-		error = gpio_request_one(button->gpio, GPIOF_IN, desc);
+		error = devm_gpio_request_one(&pdev->dev, button->gpio,
+					      GPIOF_IN, desc);
 		if (error < 0) {
 			dev_err(dev, "Failed to request GPIO %d, error %d\n",
 				button->gpio, error);
@@ -463,7 +475,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 			dev_err(dev,
 				"Unable to get irq number for GPIO %d, error %d\n",
 				button->gpio, error);
-			goto fail;
+			return error;
 		}
 		bdata->irq = irq;
 
@@ -497,26 +509,33 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	input_set_capability(input, button->type ?: EV_KEY, button->code);
 
 	/*
+	 * Install custom action to cancel debounce timer and
+	 * workqueue item.
+	 */
+	error = devm_add_action(&pdev->dev, gpio_keys_quiesce_key, bdata);
+	if (error) {
+		dev_err(&pdev->dev,
+			"failed to register quiesce action, error: %d\n",
+			error);
+		return error;
+	}
+
+	/*
 	 * If platform has specified that the button can be disabled,
 	 * we don't want it to share the interrupt line.
 	 */
 	if (!button->can_disable)
 		irqflags |= IRQF_SHARED;
 
-	error = request_any_context_irq(bdata->irq, isr, irqflags, desc, bdata);
+	error = devm_request_any_context_irq(&pdev->dev, bdata->irq,
+					     isr, irqflags, desc, bdata);
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
@@ -662,16 +681,6 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 #endif
 
-static void gpio_remove_key(struct gpio_button_data *bdata)
-{
-	free_irq(bdata->irq, bdata);
-	if (bdata->timer_debounce)
-		del_timer_sync(&bdata->timer);
-	cancel_work_sync(&bdata->work);
-	if (gpio_is_valid(bdata->button->gpio))
-		gpio_free(bdata->button->gpio);
-}
-
 static int gpio_keys_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -730,7 +739,7 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 		error = gpio_keys_setup_key(pdev, input, bdata, button);
 		if (error)
-			goto fail2;
+			return error;
 
 		if (button->wakeup)
 			wakeup = 1;
@@ -740,41 +749,31 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	if (error) {
 		dev_err(dev, "Unable to export keys/switches, error: %d\n",
 			error);
-		goto fail2;
+		return error;
 	}
 
 	error = input_register_device(input);
 	if (error) {
 		dev_err(dev, "Unable to register input device, error: %d\n",
 			error);
-		goto fail3;
+		goto err_remove_group;
 	}
 
 	device_init_wakeup(&pdev->dev, wakeup);
 
 	return 0;
 
- fail3:
+err_remove_group:
 	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
- fail2:
-	while (--i >= 0)
-		gpio_remove_key(&ddata->data[i]);
-
 	return error;
 }
 
 static int gpio_keys_remove(struct platform_device *pdev)
 {
-	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
-	int i;
-
 	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
 
 	device_init_wakeup(&pdev->dev, 0);
 
-	for (i = 0; i < ddata->pdata->nbuttons; i++)
-		gpio_remove_key(&ddata->data[i]);
-
 	return 0;
 }
 
