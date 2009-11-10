From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 3/3] gpio_keys: seperate individual button setup to make code neater
Date: Tue, 10 Nov 2009 22:59:40 +0000
Message-ID: <20091110230002.856861720@fluff.org.uk>
References: <20091110225937.922379610@fluff.org.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:42290 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758635AbZKJW76 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2009 17:59:58 -0500
Content-Disposition: inline; filename=simtec/ready/gpio-buttons-make-probe-neater.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Simtec Linux Team <linux@simtec.co.uk>

Move the code that deals with setting up each individual button out into
a new function to reduce the indentation and allow us to common up some
of the error recovery code.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

---
 drivers/input/keyboard/gpio_keys.c |   93 +++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 40 deletions(-)

Index: b/drivers/input/keyboard/gpio_keys.c
===================================================================
--- a/drivers/input/keyboard/gpio_keys.c	2009-11-09 16:48:27.000000000 +0000
+++ b/drivers/input/keyboard/gpio_keys.c	2009-11-09 16:49:06.000000000 +0000
@@ -73,6 +73,57 @@ static irqreturn_t gpio_keys_isr(int irq
 	return IRQ_HANDLED;
 }
 
+static int __devinit gpio_keys_setup_key(struct device *dev,
+					 struct gpio_button_data *bdata,
+					 struct gpio_keys_button *button)
+{
+	char *desc = button->desc ? button->desc : "gpio_keys";
+	int irq, error;
+
+	setup_timer(&bdata->timer, gpio_keys_timer, (unsigned long)bdata);
+	INIT_WORK(&bdata->work, gpio_keys_report_event);
+
+	error = gpio_request(button->gpio, desc);
+	if (error < 0) {
+		dev_err(dev, "failed to request GPIO %d, error %d\n",
+			button->gpio, error);
+		goto fail2;
+	}
+
+	error = gpio_direction_input(button->gpio);
+	if (error < 0) {
+		dev_err(dev, "failed to configure"
+			" direction for GPIO %d, error %d\n",
+			button->gpio, error);
+		goto fail3;
+	}
+
+	irq = gpio_to_irq(button->gpio);
+	if (irq < 0) {
+		error = irq;
+		dev_err(dev, "Unable to get irq number for GPIO %d, error %d\n",
+			button->gpio, error);
+		goto fail3;
+	}
+
+	error = request_irq(irq, gpio_keys_isr,
+			    IRQF_SHARED |
+			    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			    desc, bdata);
+	if (error) {
+		dev_err(dev, "Unable to claim irq %d; error %d\n",
+			irq, error);
+		goto fail3;
+	}
+
+	return 0;
+
+fail3:
+	gpio_free(button->gpio);
+fail2:
+	return error;
+}
+
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
@@ -112,52 +163,14 @@ static int __devinit gpio_keys_probe(str
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
 		struct gpio_button_data *bdata = &ddata->data[i];
-		int irq;
 		unsigned int type = button->type ?: EV_KEY;
 
 		bdata->input = input;
 		bdata->button = button;
-		setup_timer(&bdata->timer,
-			    gpio_keys_timer, (unsigned long)bdata);
-		INIT_WORK(&bdata->work, gpio_keys_report_event);
-
-		error = gpio_request(button->gpio, button->desc ?: "gpio_keys");
-		if (error < 0) {
-			dev_err(dev, "failed to request GPIO %d, error %d\n",
-				button->gpio, error);
-			goto fail2;
-		}
-
-		error = gpio_direction_input(button->gpio);
-		if (error < 0) {
-			dev_err(dev, "failed to configure"
-				" direction for GPIO %d, error %d\n",
-				button->gpio, error);
-			gpio_free(button->gpio);
-			goto fail2;
-		}
 
-		irq = gpio_to_irq(button->gpio);
-		if (irq < 0) {
-			error = irq;
-			dev_err(dev, "Unable to get irq number "
-				"for GPIO %d, error %d\n",
-				button->gpio, error);
-			gpio_free(button->gpio);
+		error = gpio_keys_setup_key(dev, bdata, button);
+		if (error)
 			goto fail2;
-		}
-
-		error = request_irq(irq, gpio_keys_isr,
-				    IRQF_SHARED |
-				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				    button->desc ? button->desc : "gpio_keys",
-				    bdata);
-		if (error) {
-			dev_err(dev, "Unable to claim irq %d; error %d\n",
-				irq, error);
-			gpio_free(button->gpio);
-			goto fail2;
-		}
 
 		if (button->wakeup)
 			wakeup = 1;

