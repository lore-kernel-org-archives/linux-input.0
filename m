From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] mfd: tc3589x: enforce device-tree only mode
Date: Thu, 19 Mar 2015 15:52:45 +0100
Message-ID: <1426776765-18812-3-git-send-email-linus.walleij@linaro.org>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-input@vger.kernel.org

All systems using the TC3589x multifunction expander uses
devicetree, so don't clutter the place with a lot of
and assume it is there.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig                    | 1 +
 drivers/gpio/gpio-tc3589x.c             | 3 ---
 drivers/input/keyboard/tc3589x-keypad.c | 9 ---------
 drivers/mfd/Kconfig                     | 1 +
 drivers/mfd/tc3589x.c                   | 9 ---------
 5 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index c1e2ca3d9a51..dc1aaa83a347 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -669,6 +669,7 @@ config GPIO_STP_XWAY
 config GPIO_TC3589X
 	bool "TC3589X GPIOs"
 	depends on MFD_TC3589X
+	depends on OF_GPIO
 	select GPIOLIB_IRQCHIP
 	help
 	  This enables support for the GPIOs found on the TC3589X
diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.c
index 11aed2671065..31b244cffabb 100644
--- a/drivers/gpio/gpio-tc3589x.c
+++ b/drivers/gpio/gpio-tc3589x.c
@@ -260,10 +260,7 @@ static int tc3589x_gpio_probe(struct platform_device *pdev)
 	tc3589x_gpio->chip.ngpio = tc3589x->num_gpio;
 	tc3589x_gpio->chip.dev = &pdev->dev;
 	tc3589x_gpio->chip.base = -1;
-
-#ifdef CONFIG_OF_GPIO
 	tc3589x_gpio->chip.of_node = np;
-#endif
 
 	/* Bring the GPIO module out of reset */
 	ret = tc3589x_set_bits(tc3589x, TC3589x_RSTCTRL,
diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 0ccc7de9b59d..08e62e6aeb1b 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -318,7 +318,6 @@ static void tc3589x_keypad_close(struct input_dev *input)
 	tc3589x_keypad_disable(keypad);
 }
 
-#ifdef CONFIG_OF
 static const struct tc3589x_keypad_platform_data *
 tc3589x_keypad_of_probe(struct device *dev)
 {
@@ -368,14 +367,6 @@ tc3589x_keypad_of_probe(struct device *dev)
 
 	return plat;
 }
-#else
-static inline const struct tc3589x_keypad_platform_data *
-tc3589x_keypad_of_probe(struct device *dev)
-{
-	return ERR_PTR(-ENODEV);
-}
-#endif
-
 
 static int tc3589x_keypad_probe(struct platform_device *pdev)
 {
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 38356e39adba..476e63745742 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1210,6 +1210,7 @@ config MFD_TIMBERDALE
 config MFD_TC3589X
 	bool "Toshiba TC35892 and variants"
 	depends on I2C=y
+	depends on OF
 	select MFD_CORE
 	help
 	  Support for the Toshiba TC35892 and variants I/O Expander.
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index aacb3720065c..cf356395c9e9 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -318,7 +318,6 @@ static int tc3589x_device_init(struct tc3589x *tc3589x)
 	return ret;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id tc3589x_match[] = {
 	/* Legacy compatible string */
 	{ .compatible = "tc3589x", .data = (void *) TC3589X_UNKNOWN },
@@ -359,14 +358,6 @@ tc3589x_of_probe(struct device *dev, enum tc3589x_version *version)
 
 	return pdata;
 }
-#else
-static inline struct tc3589x_platform_data *
-tc3589x_of_probe(struct device *dev, enum tc3589x_version *version)
-{
-	dev_err(dev, "no device tree support\n");
-	return ERR_PTR(-ENODEV);
-}
-#endif
 
 static int tc3589x_probe(struct i2c_client *i2c,
 				   const struct i2c_device_id *id)
-- 
1.9.3
