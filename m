From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5] gpio: pca953x: Name the gpiochip after the I2C address
Date: Fri, 24 Nov 2017 10:30:42 +0100
Message-ID: <20171124093045.5961-3-linus.walleij@linaro.org>
References: <20171124093045.5961-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39677 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbdKXJax (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Nov 2017 04:30:53 -0500
Received: by mail-lf0-f67.google.com with SMTP id x76so20102146lfb.6
        for <linux-input@vger.kernel.org>; Fri, 24 Nov 2017 01:30:53 -0800 (PST)
In-Reply-To: <20171124093045.5961-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

Just putting the name of the I2C device as name for the
GPIO chip (label) is ambigous, and makes it hard for us
to use GPIO descriptor tables on systems such as DaVinci
DA850EVM which has two chips but on I2C address 0x20 and 0x21.

Instead, append "-XX" to the GPIOchip name using the I2C
address so we get a unique chip name that can be used
in descriptor tables, such as "tca6416-20" and
"tca6416-21" on the DaVinci DA850EVM.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-pca953x.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index babb7bd2ba59..bab09f1a6bc9 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -413,10 +413,17 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
 	mutex_unlock(&chip->i2c_lock);
 }
 
-static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
+static int pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 {
+	struct i2c_client *client = chip->client;
 	struct gpio_chip *gc;
+	static char *chipname;
 
+	/* Gives a chip name from the chip name and I2C address */
+	chipname = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%02x",
+				  client->name, client->addr);
+	if (!chipname)
+		return -ENOMEM;
 	gc = &chip->gpio_chip;
 
 	gc->direction_input  = pca953x_gpio_direction_input;
@@ -429,10 +436,12 @@ static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 
 	gc->base = chip->gpio_start;
 	gc->ngpio = gpios;
-	gc->label = chip->client->name;
+	gc->label = chipname;
 	gc->parent = &chip->client->dev;
 	gc->owner = THIS_MODULE;
 	gc->names = chip->names;
+
+	return 0;
 }
 
 #ifdef CONFIG_GPIO_PCA953X_IRQ
@@ -848,7 +857,9 @@ static int pca953x_probe(struct i2c_client *client,
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
 	 */
-	pca953x_setup_gpio(chip, chip->driver_data & PCA_GPIO_MASK);
+	ret = pca953x_setup_gpio(chip, chip->driver_data & PCA_GPIO_MASK);
+	if (ret)
+		goto err_exit;
 
 	if (chip->gpio_chip.ngpio <= 8) {
 		chip->write_regs = pca953x_write_regs_8;
-- 
2.14.3

