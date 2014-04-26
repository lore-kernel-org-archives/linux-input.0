From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RESEND 1/2] input: gpio_keys_polled: Convert to devm-* API
Date: Sat, 26 Apr 2014 09:53:13 +0400
Message-ID: <1398491594-2004-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.mail.ru ([94.100.176.130]:60109 "EHLO smtp2.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbaDZFxY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Apr 2014 01:53:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Shiyan <shc_work@mail.ru>

Replace existing resource handling in the driver with managed
device resource, this ensures more consistent error values and
simplifies error paths.
kzalloc -> devm_kzalloc
gpio_request_one -> devm_gpio_request_one

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/keyboard/gpio_keys_polled.c | 87 ++++++++-----------------------
 1 file changed, 23 insertions(+), 64 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index e571e19..04db0a5 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -108,9 +108,7 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 	struct device_node *node, *pp;
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
-	int error;
-	int nbuttons;
-	int i;
+	int i, nbuttons;
 
 	node = dev->of_node;
 	if (!node)
@@ -120,12 +118,10 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 	if (nbuttons == 0)
 		return NULL;
 
-	pdata = kzalloc(sizeof(*pdata) + nbuttons * (sizeof *button),
-			GFP_KERNEL);
-	if (!pdata) {
-		error = -ENOMEM;
-		goto err_out;
-	}
+	pdata = devm_kzalloc(dev, sizeof(*pdata) + nbuttons * sizeof(*button),
+			     GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
 
 	pdata->buttons = (struct gpio_keys_button *)(pdata + 1);
 	pdata->nbuttons = nbuttons;
@@ -146,12 +142,11 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 
 		gpio = of_get_gpio_flags(pp, 0, &flags);
 		if (gpio < 0) {
-			error = gpio;
-			if (error != -EPROBE_DEFER)
+			if (gpio != -EPROBE_DEFER)
 				dev_err(dev,
 					"Failed to get gpio flags, error: %d\n",
-					error);
-			goto err_free_pdata;
+					gpio);
+			return ERR_PTR(gpio);
 		}
 
 		button = &pdata->buttons[i++];
@@ -162,8 +157,7 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 		if (of_property_read_u32(pp, "linux,code", &button->code)) {
 			dev_err(dev, "Button without keycode: 0x%x\n",
 				button->gpio);
-			error = -EINVAL;
-			goto err_free_pdata;
+			return ERR_PTR(-EINVAL);
 		}
 
 		button->desc = of_get_property(pp, "label", NULL);
@@ -178,17 +172,10 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 			button->debounce_interval = 5;
 	}
 
-	if (pdata->nbuttons == 0) {
-		error = -EINVAL;
-		goto err_free_pdata;
-	}
+	if (!pdata->nbuttons)
+		return ERR_PTR(-EINVAL);
 
 	return pdata;
-
-err_free_pdata:
-	kfree(pdata);
-err_out:
-	return ERR_PTR(error);
 }
 
 static struct of_device_id gpio_keys_polled_of_match[] = {
@@ -228,24 +215,21 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	if (!pdata->poll_interval) {
 		dev_err(dev, "missing poll_interval value\n");
-		error = -EINVAL;
-		goto err_free_pdata;
+		return -EINVAL;
 	}
 
-	bdev = kzalloc(sizeof(struct gpio_keys_polled_dev) +
-		       pdata->nbuttons * sizeof(struct gpio_keys_button_data),
-		       GFP_KERNEL);
+	bdev = devm_kzalloc(&pdev->dev, sizeof(struct gpio_keys_polled_dev) +
+			pdata->nbuttons * sizeof(struct gpio_keys_button_data),
+			GFP_KERNEL);
 	if (!bdev) {
 		dev_err(dev, "no memory for private data\n");
-		error = -ENOMEM;
-		goto err_free_pdata;
+		return -ENOMEM;
 	}
 
 	poll_dev = input_allocate_polled_device();
 	if (!poll_dev) {
 		dev_err(dev, "no memory for polled device\n");
-		error = -ENOMEM;
-		goto err_free_bdev;
+		return -ENOMEM;
 	}
 
 	poll_dev->private = bdev;
@@ -278,15 +262,15 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 		if (button->wakeup) {
 			dev_err(dev, DRV_NAME " does not support wakeup\n");
 			error = -EINVAL;
-			goto err_free_gpio;
+			goto err_out;
 		}
 
-		error = gpio_request_one(gpio, GPIOF_IN,
-					 button->desc ?: DRV_NAME);
+		error = devm_gpio_request_one(&pdev->dev, gpio, GPIOF_IN,
+					      button->desc ? : DRV_NAME);
 		if (error) {
 			dev_err(dev, "unable to claim gpio %u, err=%d\n",
 				gpio, error);
-			goto err_free_gpio;
+			goto err_out;
 		}
 
 		bdata->can_sleep = gpio_cansleep(gpio);
@@ -306,7 +290,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 	if (error) {
 		dev_err(dev, "unable to register polled device, err=%d\n",
 			error);
-		goto err_free_gpio;
+		goto err_out;
 	}
 
 	/* report initial state of the buttons */
@@ -316,45 +300,20 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_free_gpio:
-	while (--i >= 0)
-		gpio_free(pdata->buttons[i].gpio);
-
+err_out:
 	input_free_polled_device(poll_dev);
 
-err_free_bdev:
-	kfree(bdev);
-
-err_free_pdata:
-	/* If we have no platform_data, we allocated pdata dynamically.  */
-	if (!dev_get_platdata(&pdev->dev))
-		kfree(pdata);
-
 	return error;
 }
 
 static int gpio_keys_polled_remove(struct platform_device *pdev)
 {
 	struct gpio_keys_polled_dev *bdev = platform_get_drvdata(pdev);
-	const struct gpio_keys_platform_data *pdata = bdev->pdata;
-	int i;
 
 	input_unregister_polled_device(bdev->poll_dev);
 
-	for (i = 0; i < pdata->nbuttons; i++)
-		gpio_free(pdata->buttons[i].gpio);
-
 	input_free_polled_device(bdev->poll_dev);
 
-	/*
-	 * If we had no platform_data, we allocated pdata dynamically and
-	 * must free it here.
-	 */
-	if (!dev_get_platdata(&pdev->dev))
-		kfree(pdata);
-
-	kfree(bdev);
-
 	return 0;
 }
 
-- 
1.8.3.2

