From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 2/4] Input: max77693: Prepare for adding support for Maxim
 77843
Date: Thu, 30 Jul 2015 10:36:42 +0900
Message-ID: <1438220204-377-3-git-send-email-k.kozlowski@samsung.com>
References: <1438220204-377-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438220204-377-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dan Murphy <dmurphy@ti.com>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Prepare the driver for supporting two devices: Maxim 77693 and 77843:
1. Add table of device ids and store current device type for later
   usage.
2. Differentiate the haptic device configuration.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/max77693-haptic.c | 41 ++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 8dc43c1ebf0e..4c0f67ab66d9 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -47,6 +47,8 @@ enum max77693_haptic_pwm_divisor {
 };
 
 struct max77693_haptic {
+	enum max77693_types dev_type;
+
 	struct regmap *regmap_pmic;
 	struct regmap *regmap_haptic;
 	struct device *dev;
@@ -81,16 +83,23 @@ static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
 static int max77693_haptic_configure(struct max77693_haptic *haptic,
 				     bool enable)
 {
-	unsigned int value;
+	unsigned int value, config_reg;
 	int error;
 
-	value = ((haptic->type << MAX77693_CONFIG2_MODE) |
-		(enable << MAX77693_CONFIG2_MEN) |
-		(haptic->mode << MAX77693_CONFIG2_HTYP) |
-		MAX77693_HAPTIC_PWM_DIVISOR_128);
+	switch (haptic->dev_type) {
+	case TYPE_MAX77693:
+		value = ((haptic->type << MAX77693_CONFIG2_MODE) |
+			(enable << MAX77693_CONFIG2_MEN) |
+			(haptic->mode << MAX77693_CONFIG2_HTYP) |
+			MAX77693_HAPTIC_PWM_DIVISOR_128);
+		config_reg = MAX77693_HAPTIC_REG_CONFIG2;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	error = regmap_write(haptic->regmap_haptic,
-			     MAX77693_HAPTIC_REG_CONFIG2, value);
+			     config_reg, value);
 	if (error) {
 		dev_err(haptic->dev,
 			"failed to update haptic config: %d\n", error);
@@ -254,12 +263,23 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	haptic->regmap_pmic = max77693->regmap;
-	haptic->regmap_haptic = max77693->regmap_haptic;
 	haptic->dev = &pdev->dev;
 	haptic->type = MAX77693_HAPTIC_LRA;
 	haptic->mode = MAX77693_HAPTIC_EXTERNAL_MODE;
 	haptic->suspend_state = false;
 
+	/* Variant-specific init */
+	haptic->dev_type = platform_get_device_id(pdev)->driver_data;
+	switch (haptic->dev_type) {
+	case TYPE_MAX77693:
+		haptic->regmap_haptic = max77693->regmap_haptic;
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported device type: %u\n",
+			haptic->dev_type);
+		return -EINVAL;
+	}
+
 	INIT_WORK(&haptic->work, max77693_haptic_play_work);
 
 	/* Get pwm and regulatot for haptic device */
@@ -337,12 +357,19 @@ static int __maybe_unused max77693_haptic_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(max77693_haptic_pm_ops,
 			 max77693_haptic_suspend, max77693_haptic_resume);
 
+static const struct platform_device_id max77693_haptic_id[] = {
+	{ "max77693-haptic", TYPE_MAX77693 },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, max77693_haptic_id);
+
 static struct platform_driver max77693_haptic_driver = {
 	.driver		= {
 		.name	= "max77693-haptic",
 		.pm	= &max77693_haptic_pm_ops,
 	},
 	.probe		= max77693_haptic_probe,
+	.id_table	= max77693_haptic_id,
 };
 module_platform_driver(max77693_haptic_driver);
 
-- 
1.9.1
