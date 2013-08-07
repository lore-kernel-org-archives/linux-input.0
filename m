From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 3/3] input: gpio_keys{_polled}: Replace enable/disable callbacks with regulator API
Date: Wed,  7 Aug 2013 12:25:13 +0400
Message-ID: <1375863913-26648-3-git-send-email-shc_work@mail.ru>
References: <1375863913-26648-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:37350 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3HGIZn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Aug 2013 04:25:43 -0400
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 48E1DDE1B24C
	for <linux-input@vger.kernel.org>; Wed,  7 Aug 2013 12:25:42 +0400 (MSK)
In-Reply-To: <1375863913-26648-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Shiyan <shc_work@mail.ru>

Typical use to enable/disable is a power switch, so replace these
callbacks to the regulator API. This will allow using devices,
which depends on the regulator, from devicetree.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/input/gpio-keys-polled.txt |  1 +
 arch/arm/mach-ux500/board-mop500-regulators.c      |  2 +-
 arch/arm/mach-ux500/board-mop500.c                 | 25 ----------------------
 drivers/input/keyboard/gpio_keys.c                 | 16 ++++++++------
 drivers/input/keyboard/gpio_keys_polled.c          | 16 ++++++++------
 include/linux/gpio_keys.h                          |  2 --
 6 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
index 313abef..4dba546 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
@@ -7,6 +7,7 @@ Required properties:
 Optional properties:
 	- autorepeat: Boolean, Enable auto repeat feature of Linux input
 	  subsystem.
+	- keys-supply: The regulator to drive the GPIOs.
 
 Each button (key) is represented as a sub-node of "gpio-keys-polled":
 Subnode properties:
diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 0dc44c6..6952117 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -76,7 +76,7 @@ static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
 	/* Secondary display, ST uib */
 	REGULATOR_SUPPLY("vdd1", "samsung_s6d16d0.1"),
 	/* SFH7741 proximity sensor */
-	REGULATOR_SUPPLY("vcc", "gpio-keys.0"),
+	REGULATOR_SUPPLY("keys", "gpio-keys.0"),
 	/* BH1780GLS ambient light sensor */
 	REGULATOR_SUPPLY("vcc", "2-0029"),
 	/* lsm303dlh accelerometer */
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index df5d27a..f0b327d 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -375,15 +375,9 @@ static struct gpio_keys_button mop500_gpio_keys[] = {
 	}
 };
 
-static struct regulator *prox_regulator;
-static int mop500_prox_activate(struct device *dev);
-static void mop500_prox_deactivate(struct device *dev);
-
 static struct gpio_keys_platform_data mop500_gpio_keys_data = {
 	.buttons	= mop500_gpio_keys,
 	.nbuttons	= ARRAY_SIZE(mop500_gpio_keys),
-	.enable		= mop500_prox_activate,
-	.disable	= mop500_prox_deactivate,
 };
 
 static struct platform_device mop500_gpio_keys_device = {
@@ -394,25 +388,6 @@ static struct platform_device mop500_gpio_keys_device = {
 	},
 };
 
-static int mop500_prox_activate(struct device *dev)
-{
-	prox_regulator = regulator_get(&mop500_gpio_keys_device.dev,
-						"vcc");
-	if (IS_ERR(prox_regulator)) {
-		dev_err(&mop500_gpio_keys_device.dev,
-			"no regulator\n");
-		return PTR_ERR(prox_regulator);
-	}
-
-	return regulator_enable(prox_regulator);
-}
-
-static void mop500_prox_deactivate(struct device *dev)
-{
-	regulator_disable(prox_regulator);
-	regulator_put(prox_regulator);
-}
-
 static struct cryp_platform_data u8500_cryp1_platform_data = {
 		.mem_to_engine = {
 				.dir = DMA_MEM_TO_DEV,
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 8fe28d7..785befc 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -29,6 +29,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/spinlock.h>
+#include <linux/regulator/consumer.h>
 
 struct gpio_button_data {
 	const struct gpio_keys_button *button;
@@ -47,6 +48,7 @@ struct gpio_keys_drvdata {
 	struct input_dev *input;
 	struct mutex disable_lock;
 	struct gpio_button_data data[0];
+	struct regulator *regulator;
 };
 
 /*
@@ -527,11 +529,10 @@ static void gpio_keys_report_state(struct gpio_keys_drvdata *ddata)
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
@@ -545,10 +546,9 @@ static int gpio_keys_open(struct input_dev *input)
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
@@ -682,6 +682,10 @@ static int gpio_keys_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	ddata->regulator = devm_regulator_get(&pdev->dev, "keys");
+	if (PTR_ERR(ddata->regulator) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ddata->pdata = pdata;
 	ddata->input = input;
 	mutex_init(&ddata->disable_lock);
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index b589d12..405afbd 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -27,6 +27,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
 
 #define DRV_NAME	"gpio-keys-polled"
 
@@ -42,6 +43,7 @@ struct gpio_keys_polled_dev {
 	struct device *dev;
 	const struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button_data data[0];
+	struct regulator *regulator;
 };
 
 static void gpio_keys_polled_check_state(struct input_dev *input,
@@ -87,19 +89,17 @@ static void gpio_keys_polled_poll(struct input_polled_dev *dev)
 static void gpio_keys_polled_open(struct input_polled_dev *dev)
 {
 	struct gpio_keys_polled_dev *bdev = dev->private;
-	const struct gpio_keys_platform_data *pdata = bdev->pdata;
 
-	if (pdata->enable)
-		pdata->enable(bdev->dev);
+	if (!IS_ERR(bdev->regulator))
+		regulator_enable(bdev->regulator);
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
@@ -226,6 +226,10 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	bdev->regulator = devm_regulator_get(&pdev->dev, "keys");
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

