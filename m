From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 1/2] input: gpio_keys_polled: Convert to devm-* API
Date: Mon, 28 Apr 2014 20:26:00 -0700
Message-ID: <20140429032600.GD7672@core.coreip.homeip.net>
References: <1398491594-2004-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40439 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbaD2D0C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Apr 2014 23:26:02 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so6124030pdj.18
        for <linux-input@vger.kernel.org>; Mon, 28 Apr 2014 20:26:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398491594-2004-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

Hi Alexander,

On Sat, Apr 26, 2014 at 09:53:13AM +0400, Alexander Shiyan wrote:
> Replace existing resource handling in the driver with managed
> device resource, this ensures more consistent error values and
> simplifies error paths.
> kzalloc -> devm_kzalloc
> gpio_request_one -> devm_gpio_request_one
> 

If we are doing the conversion can we go all the Alexanderway (needs the
other 2 patches I just posted and CCed you)?

Thanks.

-- 
Dmitry

Input: gpio_keys_polled - convert to devm-* API

From: Alexander Shiyan <shc_work@mail.ru>

Replace existing resource handling in the driver with managed device
resources, this ensures more consistent error values and simplifies error
handling paths:

kzalloc -> devm_kzalloc
gpio_request_one -> devm_gpio_request_one
input_allocate_polled_device -> devm_input_allocate_polled_device

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/gpio_keys_polled.c |   98 ++++++-----------------------
 1 file changed, 21 insertions(+), 77 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index e571e19..196b5ec 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -120,12 +120,10 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
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
@@ -151,7 +149,7 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 				dev_err(dev,
 					"Failed to get gpio flags, error: %d\n",
 					error);
-			goto err_free_pdata;
+			return ERR_PTR(error);
 		}
 
 		button = &pdata->buttons[i++];
@@ -162,8 +160,7 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 		if (of_property_read_u32(pp, "linux,code", &button->code)) {
 			dev_err(dev, "Button without keycode: 0x%x\n",
 				button->gpio);
-			error = -EINVAL;
-			goto err_free_pdata;
+			return ERR_PTR(-EINVAL);
 		}
 
 		button->desc = of_get_property(pp, "label", NULL);
@@ -178,17 +175,10 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 			button->debounce_interval = 5;
 	}
 
-	if (pdata->nbuttons == 0) {
-		error = -EINVAL;
-		goto err_free_pdata;
-	}
+	if (pdata->nbuttons == 0)
+		return ERR_PTR(-EINVAL);
 
 	return pdata;
-
-err_free_pdata:
-	kfree(pdata);
-err_out:
-	return ERR_PTR(error);
 }
 
 static struct of_device_id gpio_keys_polled_of_match[] = {
@@ -213,6 +203,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 	struct gpio_keys_polled_dev *bdev;
 	struct input_polled_dev *poll_dev;
 	struct input_dev *input;
+	size_t size;
 	int error;
 	int i;
 
@@ -228,24 +219,21 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	if (!pdata->poll_interval) {
 		dev_err(dev, "missing poll_interval value\n");
-		error = -EINVAL;
-		goto err_free_pdata;
+		return -EINVAL;
 	}
 
-	bdev = kzalloc(sizeof(struct gpio_keys_polled_dev) +
-		       pdata->nbuttons * sizeof(struct gpio_keys_button_data),
-		       GFP_KERNEL);
+	size = sizeof(struct gpio_keys_polled_dev) +
+			pdata->nbuttons * sizeof(struct gpio_keys_button_data);
+	bdev = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
 	if (!bdev) {
 		dev_err(dev, "no memory for private data\n");
-		error = -ENOMEM;
-		goto err_free_pdata;
+		return -ENOMEM;
 	}
 
-	poll_dev = input_allocate_polled_device();
+	poll_dev = devm_input_allocate_polled_device(&pdev->dev);
 	if (!poll_dev) {
 		dev_err(dev, "no memory for polled device\n");
-		error = -ENOMEM;
-		goto err_free_bdev;
+		return -ENOMEM;
 	}
 
 	poll_dev->private = bdev;
@@ -258,7 +246,6 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	input->name = pdev->name;
 	input->phys = DRV_NAME"/input0";
-	input->dev.parent = &pdev->dev;
 
 	input->id.bustype = BUS_HOST;
 	input->id.vendor = 0x0001;
@@ -277,16 +264,15 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 		if (button->wakeup) {
 			dev_err(dev, DRV_NAME " does not support wakeup\n");
-			error = -EINVAL;
-			goto err_free_gpio;
+			return -EINVAL;
 		}
 
-		error = gpio_request_one(gpio, GPIOF_IN,
-					 button->desc ?: DRV_NAME);
+		error = devm_gpio_request_one(&pdev->dev, gpio, GPIOF_IN,
+					      button->desc ? : DRV_NAME);
 		if (error) {
 			dev_err(dev, "unable to claim gpio %u, err=%d\n",
 				gpio, error);
-			goto err_free_gpio;
+			return error;
 		}
 
 		bdata->can_sleep = gpio_cansleep(gpio);
@@ -306,7 +292,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 	if (error) {
 		dev_err(dev, "unable to register polled device, err=%d\n",
 			error);
-		goto err_free_gpio;
+		return error;
 	}
 
 	/* report initial state of the buttons */
@@ -315,52 +301,10 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 					     &bdev->data[i]);
 
 	return 0;
-
-err_free_gpio:
-	while (--i >= 0)
-		gpio_free(pdata->buttons[i].gpio);
-
-	input_free_polled_device(poll_dev);
-
-err_free_bdev:
-	kfree(bdev);
-
-err_free_pdata:
-	/* If we have no platform_data, we allocated pdata dynamically.  */
-	if (!dev_get_platdata(&pdev->dev))
-		kfree(pdata);
-
-	return error;
-}
-
-static int gpio_keys_polled_remove(struct platform_device *pdev)
-{
-	struct gpio_keys_polled_dev *bdev = platform_get_drvdata(pdev);
-	const struct gpio_keys_platform_data *pdata = bdev->pdata;
-	int i;
-
-	input_unregister_polled_device(bdev->poll_dev);
-
-	for (i = 0; i < pdata->nbuttons; i++)
-		gpio_free(pdata->buttons[i].gpio);
-
-	input_free_polled_device(bdev->poll_dev);
-
-	/*
-	 * If we had no platform_data, we allocated pdata dynamically and
-	 * must free it here.
-	 */
-	if (!dev_get_platdata(&pdev->dev))
-		kfree(pdata);
-
-	kfree(bdev);
-
-	return 0;
 }
 
 static struct platform_driver gpio_keys_polled_driver = {
 	.probe	= gpio_keys_polled_probe,
-	.remove	= gpio_keys_polled_remove,
 	.driver	= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
