From: David Jander <david@protonic.nl>
Subject: [PATCH 1/3] Input: gpio_keys.c: Simplify platform_device -> device casting
Date: Mon,  6 Jun 2011 17:12:33 +0200
Message-ID: <1307373155-29470-2-git-send-email-david@protonic.nl>
References: <1307373155-29470-1-git-send-email-david@protonic.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:12808 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab1FFPbA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 11:31:00 -0400
In-Reply-To: <1307373155-29470-1-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

This patch factors out the use of struct platform_device *pdev in most
places.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/input/keyboard/gpio_keys.c |   46 ++++++++++++++++-------------------
 1 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6e6145b..987498e 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -251,8 +251,7 @@ static ssize_t gpio_keys_show_##name(struct device *dev,		\
 				     struct device_attribute *attr,	\
 				     char *buf)				\
 {									\
-	struct platform_device *pdev = to_platform_device(dev);		\
-	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);	\
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);		\
 									\
 	return gpio_keys_attr_show_helper(ddata, buf,			\
 					  type, only_disabled);		\
@@ -278,8 +277,7 @@ static ssize_t gpio_keys_store_##name(struct device *dev,		\
 				      const char *buf,			\
 				      size_t count)			\
 {									\
-	struct platform_device *pdev = to_platform_device(dev);		\
-	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);	\
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);		\
 	ssize_t error;							\
 									\
 	error = gpio_keys_attr_store_helper(ddata, buf, type);		\
@@ -364,12 +362,11 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
+static int __devinit gpio_keys_setup_key(struct device *dev,
 					 struct gpio_button_data *bdata,
 					 struct gpio_keys_button *button)
 {
 	const char *desc = button->desc ? button->desc : "gpio_keys";
-	struct device *dev = &pdev->dev;
 	unsigned long irqflags;
 	int irq, error;
 
@@ -447,9 +444,9 @@ static void gpio_keys_close(struct input_dev *input)
 
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata;
 	struct device *dev = &pdev->dev;
+	struct gpio_keys_platform_data *pdata = dev->platform_data;
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
@@ -470,12 +467,12 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	ddata->disable = pdata->disable;
 	mutex_init(&ddata->disable_lock);
 
-	platform_set_drvdata(pdev, ddata);
+	dev_set_drvdata(dev, ddata);
 	input_set_drvdata(input, ddata);
 
 	input->name = pdata->name ? : pdev->name;
 	input->phys = "gpio-keys/input0";
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = dev;
 	input->open = gpio_keys_open;
 	input->close = gpio_keys_close;
 
@@ -496,7 +493,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		bdata->input = input;
 		bdata->button = button;
 
-		error = gpio_keys_setup_key(pdev, bdata, button);
+		error = gpio_keys_setup_key(dev, bdata, button);
 		if (error)
 			goto fail2;
 
@@ -506,7 +503,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		input_set_capability(input, type, button->code);
 	}
 
-	error = sysfs_create_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+	error = sysfs_create_group(&dev->kobj, &gpio_keys_attr_group);
 	if (error) {
 		dev_err(dev, "Unable to export keys/switches, error: %d\n",
 			error);
@@ -525,12 +522,12 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		gpio_keys_report_event(&ddata->data[i]);
 	input_sync(input);
 
-	device_init_wakeup(&pdev->dev, wakeup);
+	device_init_wakeup(dev, wakeup);
 
 	return 0;
 
  fail3:
-	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+	sysfs_remove_group(&dev->kobj, &gpio_keys_attr_group);
  fail2:
 	while (--i >= 0) {
 		free_irq(gpio_to_irq(pdata->buttons[i].gpio), &ddata->data[i]);
@@ -540,7 +537,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		gpio_free(pdata->buttons[i].gpio);
 	}
 
-	platform_set_drvdata(pdev, NULL);
+	dev_set_drvdata(dev, NULL);
  fail1:
 	input_free_device(input);
 	kfree(ddata);
@@ -550,14 +547,15 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 static int __devexit gpio_keys_remove(struct platform_device *pdev)
 {
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
-	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct gpio_keys_platform_data *pdata = dev->platform_data;
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
 	struct input_dev *input = ddata->input;
 	int i;
 
-	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+	sysfs_remove_group(&dev->kobj, &gpio_keys_attr_group);
 
-	device_init_wakeup(&pdev->dev, 0);
+	device_init_wakeup(dev, 0);
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int irq = gpio_to_irq(pdata->buttons[i].gpio);
@@ -577,11 +575,10 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int gpio_keys_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_platform_data *pdata = dev->platform_data;
 	int i;
 
-	if (device_may_wakeup(&pdev->dev)) {
+	if (device_may_wakeup(dev)) {
 		for (i = 0; i < pdata->nbuttons; i++) {
 			struct gpio_keys_button *button = &pdata->buttons[i];
 			if (button->wakeup) {
@@ -596,15 +593,14 @@ static int gpio_keys_suspend(struct device *dev)
 
 static int gpio_keys_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
+	struct gpio_keys_platform_data *pdata = dev->platform_data;
 	int i;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 
 		struct gpio_keys_button *button = &pdata->buttons[i];
-		if (button->wakeup && device_may_wakeup(&pdev->dev)) {
+		if (button->wakeup && device_may_wakeup(dev)) {
 			int irq = gpio_to_irq(button->gpio);
 			disable_irq_wake(irq);
 		}
-- 
1.7.4.1

