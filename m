From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 3/4] Input: max77693: Add support for Maxim 77843
Date: Thu, 30 Jul 2015 10:36:43 +0900
Message-ID: <1438220204-377-4-git-send-email-k.kozlowski@samsung.com>
References: <1438220204-377-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438220204-377-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dan Murphy <dmurphy@ti.com>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

The Maxim 77843 haptic driver differs from 77693 by:
1. Setting the bias.
2. Different configuration register.
3. Not enabling the low-sys DAC.
4. Using same regmap for PMIC and haptic blocks.

Incorporate all differences into max77693 haptic driver so both devices
can be supported.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/Kconfig           |  6 ++---
 drivers/input/misc/max77693-haptic.c | 48 +++++++++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index d4f0a817e858..f5d7a98a329d 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -167,12 +167,12 @@ config INPUT_M68K_BEEP
 	depends on M68K
 
 config INPUT_MAX77693_HAPTIC
-	tristate "MAXIM MAX77693 haptic controller support"
-	depends on MFD_MAX77693 && PWM
+	tristate "MAXIM MAX77693/MAX77843 haptic controller support"
+	depends on (MFD_MAX77693 || MFD_MAX77843) && PWM
 	select INPUT_FF_MEMLESS
 	help
 	  This option enables support for the haptic controller on
-	  MAXIM MAX77693 chip.
+	  MAXIM MAX77693 and MAX77843 chips.
 
 	  To compile this driver as module, choose M here: the
 	  module will be called max77693-haptic.
diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 4c0f67ab66d9..6d96bff32a0e 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -1,8 +1,9 @@
 /*
- * MAXIM MAX77693 Haptic device driver
+ * MAXIM MAX77693/MAX77843 Haptic device driver
  *
- * Copyright (C) 2014 Samsung Electronics
+ * Copyright (C) 2014,2015 Samsung Electronics
  * Jaewon Kim <jaewon02.kim@samsung.com>
+ * Krzysztof Kozlowski <k.kozlowski@samsung.com>
  *
  * This program is not provided / owned by Maxim Integrated Products.
  *
@@ -26,6 +27,7 @@
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-common.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/mfd/max77843-private.h>
 
 #define MAX_MAGNITUDE_SHIFT	16
 
@@ -80,6 +82,26 @@ static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
 	return 0;
 }
 
+static int max77843_haptic_bias(struct max77693_haptic *haptic, bool on)
+{
+	int error;
+
+	if (haptic->dev_type != TYPE_MAX77843)
+		return 0;
+
+	error = regmap_update_bits(haptic->regmap_haptic,
+				   MAX77843_SYS_REG_MAINCTRL1,
+				   MAX77843_MAINCTRL1_BIASEN_MASK,
+				   on << MAINCTRL1_BIASEN_SHIFT);
+	if (error) {
+		dev_err(haptic->dev, "failed to %s bias: %d\n",
+			on ? "enable" : "disable", error);
+		return error;
+	}
+
+	return 0;
+}
+
 static int max77693_haptic_configure(struct max77693_haptic *haptic,
 				     bool enable)
 {
@@ -94,6 +116,12 @@ static int max77693_haptic_configure(struct max77693_haptic *haptic,
 			MAX77693_HAPTIC_PWM_DIVISOR_128);
 		config_reg = MAX77693_HAPTIC_REG_CONFIG2;
 		break;
+	case TYPE_MAX77843:
+		value = (haptic->type << MCONFIG_MODE_SHIFT) |
+			(enable << MCONFIG_MEN_SHIFT) |
+			MAX77693_HAPTIC_PWM_DIVISOR_128;
+		config_reg = MAX77843_HAP_REG_MCONFIG;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -113,6 +141,9 @@ static int max77693_haptic_lowsys(struct max77693_haptic *haptic, bool enable)
 {
 	int error;
 
+	if (haptic->dev_type != TYPE_MAX77693)
+		return 0;
+
 	error = regmap_update_bits(haptic->regmap_pmic,
 				   MAX77693_PMIC_REG_LSCNFG,
 				   MAX77693_PMIC_LOW_SYS_MASK,
@@ -228,6 +259,10 @@ static int max77693_haptic_open(struct input_dev *dev)
 	struct max77693_haptic *haptic = input_get_drvdata(dev);
 	int error;
 
+	error = max77843_haptic_bias(haptic, true);
+	if (error)
+		return error;
+
 	error = regulator_enable(haptic->motor_reg);
 	if (error) {
 		dev_err(haptic->dev,
@@ -250,6 +285,8 @@ static void max77693_haptic_close(struct input_dev *dev)
 	if (error)
 		dev_err(haptic->dev,
 			"failed to disable regulator: %d\n", error);
+
+	max77843_haptic_bias(haptic, false);
 }
 
 static int max77693_haptic_probe(struct platform_device *pdev)
@@ -274,6 +311,9 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 	case TYPE_MAX77693:
 		haptic->regmap_haptic = max77693->regmap_haptic;
 		break;
+	case TYPE_MAX77843:
+		haptic->regmap_haptic = max77693->regmap;
+		break;
 	default:
 		dev_err(&pdev->dev, "unsupported device type: %u\n",
 			haptic->dev_type);
@@ -359,6 +399,7 @@ static SIMPLE_DEV_PM_OPS(max77693_haptic_pm_ops,
 
 static const struct platform_device_id max77693_haptic_id[] = {
 	{ "max77693-haptic", TYPE_MAX77693 },
+	{ "max77843-haptic", TYPE_MAX77843 },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, max77693_haptic_id);
@@ -374,6 +415,7 @@ static struct platform_driver max77693_haptic_driver = {
 module_platform_driver(max77693_haptic_driver);
 
 MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
-MODULE_DESCRIPTION("MAXIM MAX77693 Haptic driver");
+MODULE_AUTHOR("Krzysztof Kozlowski <k.kozlowski@samsung.com>");
+MODULE_DESCRIPTION("MAXIM 77693/77843 Haptic driver");
 MODULE_ALIAS("platform:max77693-haptic");
 MODULE_LICENSE("GPL");
-- 
1.9.1
