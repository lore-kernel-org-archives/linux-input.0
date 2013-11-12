From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RESEND 3/3] input: gpio_keys{_polled}: Replace enable/disable callbacks with regulator API
Date: Tue, 12 Nov 2013 14:38:25 +0400
Message-ID: <1384252705-18553-3-git-send-email-shc_work@mail.ru>
References: <1384252705-18553-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:36572 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab3KLLHx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Nov 2013 06:07:53 -0500
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id 9097744D70F1
	for <linux-input@vger.kernel.org>; Tue, 12 Nov 2013 14:39:19 +0400 (MSK)
In-Reply-To: <1384252705-18553-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Shiyan <shc_work@mail.ru>

Typical use to enable/disable is a power switch, so replace these
callbacks to the regulator API. This will allow using devices,
which depends on the regulator, from devicetree.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/input/gpio-keys-polled.txt       |  1 +
 drivers/input/keyboard/gpio_keys.c                       | 16 ++++++++++------
 drivers/input/keyboard/gpio_keys_polled.c                | 16 ++++++++++------
 include/linux/gpio_keys.h                                |  2 --
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
index 313abef..a210963 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
@@ -7,6 +7,7 @@ Required properties:
 Optional properties:
 	- autorepeat: Boolean, Enable auto repeat feature of Linux input
 	  subsystem.
+	- vcc-supply: The regulator to drive the GPIOs.
 
 Each button (key) is represented as a sub-node of "gpio-keys-polled":
 Subnode properties:
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 50c2746..659c426 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/spinlock.h>
+#include <linux/regulator/consumer.h>
 
 struct gpio_button_data {
 	const struct gpio_keys_button *button;
@@ -48,6 +49,7 @@ struct gpio_keys_drvdata {
 	struct input_dev *input;
 	struct mutex disable_lock;
 	struct gpio_button_data data[0];
+	struct regulator *regulator;
 };
 
 /*
@@ -528,11 +530,10 @@ static void gpio_keys_report_state(struct gpio_keys_drvdata *ddata)
 static int gpio_keys_open(struct input_dev *input)
 {
 	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
-	const struct gpio_keys_platform_data *pdata = ddata->pdata;
 	int error;
 
-	if (pdata->enable) {
-		error = pdata->enable(input->dev.parent);
+	if (!IS_ERR(ddata->regulator)) {
+		error = regulator_enable(ddata->regulator);
 		if (error)
 			return error;
 	}
@@ -546,10 +547,9 @@ static int gpio_keys_open(struct input_dev *input)
 static void gpio_keys_close(struct input_dev *input)
 {
 	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
-	const struct gpio_keys_platform_data *pdata = ddata->pdata;
 
-	if (pdata->disable)
-		pdata->disable(input->dev.parent);
+	if (!IS_ERR(ddata->regulator))
+		regulator_disable(ddata->regulator);
 }
 
 /*
@@ -683,6 +683,10 @@ static int gpio_keys_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	ddata->regulator = devm_regulator_get(&pdev->dev, "vcc");
+	if (PTR_ERR(ddata->regulator) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ddata->pdata = pdata;
 	ddata->input = input;
 	mutex_init(&ddata->disable_lock);
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 0dce49d..955a59d 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
 
 #define DRV_NAME	"gpio-keys-polled"
 
@@ -43,6 +44,7 @@ struct gpio_keys_polled_dev {
 	struct device *dev;
 	const struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button_data data[0];
+	struct regulator *regulator;
 };
 
 static void gpio_keys_polled_check_state(struct input_dev *input,
@@ -88,19 +90,17 @@ static void gpio_keys_polled_poll(struct input_polled_dev *dev)
 static void gpio_keys_polled_open(struct input_polled_dev *dev)
 {
 	struct gpio_keys_polled_dev *bdev = dev->private;
-	const struct gpio_keys_platform_data *pdata = bdev->pdata;
 
-	if (pdata->enable)
-		pdata->enable(bdev->dev);
+	if (!IS_ERR(bdev->regulator))
+		WARN_ON(regulator_enable(bdev->regulator));
 }
 
 static void gpio_keys_polled_close(struct input_polled_dev *dev)
 {
 	struct gpio_keys_polled_dev *bdev = dev->private;
-	const struct gpio_keys_platform_data *pdata = bdev->pdata;
 
-	if (pdata->disable)
-		pdata->disable(bdev->dev);
+	if (!IS_ERR(bdev->regulator))
+		regulator_disable(bdev->regulator);
 }
 
 #ifdef CONFIG_OF
@@ -227,6 +227,10 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	bdev->regulator = devm_regulator_get(&pdev->dev, "vcc");
+	if (PTR_ERR(bdev->regulator) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	poll_dev = input_allocate_polled_device();
 	if (!poll_dev) {
 		dev_err(dev, "no memory for polled device\n");
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index a7e977f..05d3bf8 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -23,8 +23,6 @@ struct gpio_keys_platform_data {
 	unsigned int poll_interval;	/* polling interval in msecs -
 					   for polling driver only */
 	unsigned int rep:1;		/* enable input subsystem auto repeat */
-	int (*enable)(struct device *dev);
-	void (*disable)(struct device *dev);
 	const char *name;		/* input device name */
 };
 
-- 
1.8.1.5

