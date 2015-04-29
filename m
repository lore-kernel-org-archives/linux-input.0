From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 09/10] regulator: max77693: Add support for MAX77843 device
Date: Wed, 29 Apr 2015 19:58:34 +0900
Message-ID: <1430305114-23598-10-git-send-email-k.kozlowski.k@gmail.com>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

The charger and safeout part of MAX77843 is almost the same as MAX77693.
>From regulator point of view the only differences are the constraints
and register values related to these constraints. Now the max77693
regulator driver can be used for MAX77843.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/regulator/Kconfig    |   8 +--
 drivers/regulator/max77693.c | 125 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 117 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index a6f116aa5235..7bf6365eb0d3 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -397,13 +397,13 @@ config REGULATOR_MAX77686
 	  Exynos-4 chips to control VARM and VINT voltages.
 
 config REGULATOR_MAX77693
-	tristate "Maxim MAX77693 regulator"
-	depends on MFD_MAX77693
+	tristate "Maxim 77693/77843 regulator"
+	depends on (MFD_MAX77693 || MFD_MAX77843)
 	help
-	  This driver controls a Maxim 77693 regulator via I2C bus.
+	  This driver controls a Maxim 77693/77843 regulators via I2C bus.
 	  The regulators include two LDOs, 'SAFEOUT1', 'SAFEOUT2'
 	  and one current regulator 'CHARGER'. This is suitable for
-	  Exynos-4x12 chips.
+	  Exynos-4x12 (MAX77693) or Exynos5433 (MAX77843) SoC chips.
 
 config REGULATOR_MAX77802
 	tristate "Maxim 77802 regulator"
diff --git a/drivers/regulator/max77693.c b/drivers/regulator/max77693.c
index 5b30dc42679c..918745d1c5e4 100644
--- a/drivers/regulator/max77693.c
+++ b/drivers/regulator/max77693.c
@@ -1,8 +1,9 @@
 /*
- * max77693.c - Regulator driver for the Maxim 77693
+ * max77693.c - Regulator driver for the Maxim 77693 and 77843
  *
- * Copyright (C) 2013 Samsung Electronics
+ * Copyright (C) 2013-2015 Samsung Electronics
  * Jonghwa Lee <jonghwa3.lee@samsung.com>
+ * Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -30,11 +31,24 @@
 #include <linux/regulator/machine.h>
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/mfd/max77843-private.h>
 #include <linux/mfd/max77693-common.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regmap.h>
 
-/* Charger regulator differences between MAX77693 and MAX77843 */
+/*
+ * ID for MAX77843 regulators.
+ * There is no need for such for MAX77693.
+ */
+enum max77843_regulator_type {
+	MAX77843_SAFEOUT1 = 0,
+	MAX77843_SAFEOUT2,
+	MAX77843_CHARGER,
+
+	MAX77843_NUM,
+};
+
+/* Register differences between chargers: MAX77693 and MAX77843 */
 struct chg_reg_data {
 	unsigned int linear_reg;
 	unsigned int linear_mask;
@@ -43,9 +57,14 @@ struct chg_reg_data {
 };
 
 /*
- * CHARGER regulator - Min : 20mA, Max : 2580mA, step : 20mA
+ * MAX77693 CHARGER regulator - Min : 20mA, Max : 2580mA, step : 20mA
  * 0x00, 0x01, 0x2, 0x03	= 60 mA
  * 0x04 ~ 0x7E			= (60 + (X - 3) * 20) mA
+ * Actually for MAX77693 the driver manipulates the maximum input current,
+ * not the fast charge current (output). This should be fixed.
+ *
+ * On MAX77843 the calculation formula is the same (except values).
+ * Fortunately it properly manipulates the fast charge current.
  */
 static int max77693_chg_get_current_limit(struct regulator_dev *rdev)
 {
@@ -95,6 +114,26 @@ static int max77693_chg_set_current_limit(struct regulator_dev *rdev,
 }
 /* end of CHARGER regulator ops */
 
+/* Returns regmap suitable for given regulator on chosen device */
+static struct regmap *max77693_get_regmap(enum max77693_types type,
+					  struct max77693_dev *max77693,
+					  int reg_id)
+{
+	if (type == TYPE_MAX77693)
+		return max77693->regmap;
+
+	/* Else: TYPE_MAX77843 */
+	switch (reg_id) {
+	case MAX77843_SAFEOUT1:
+	case MAX77843_SAFEOUT2:
+		return max77693->regmap;
+	case MAX77843_CHARGER:
+		return max77693->regmap_chg;
+	default:
+		return max77693->regmap;
+	}
+}
+
 static const unsigned int max77693_safeout_table[] = {
 	4850000,
 	4900000,
@@ -119,7 +158,7 @@ static struct regulator_ops max77693_charger_ops = {
 	.set_current_limit	= max77693_chg_set_current_limit,
 };
 
-#define regulator_desc_esafeout(_num)	{			\
+#define max77693_regulator_desc_esafeout(_num)	{		\
 	.name		= "ESAFEOUT"#_num,			\
 	.id		= MAX77693_ESAFEOUT##_num,		\
 	.of_match	= of_match_ptr("ESAFEOUT"#_num),	\
@@ -135,9 +174,9 @@ static struct regulator_ops max77693_charger_ops = {
 	.enable_mask	= SAFEOUT_CTRL_ENSAFEOUT##_num##_MASK ,	\
 }
 
-static const struct regulator_desc regulators[] = {
-	regulator_desc_esafeout(1),
-	regulator_desc_esafeout(2),
+static const struct regulator_desc max77693_supported_regulators[] = {
+	max77693_regulator_desc_esafeout(1),
+	max77693_regulator_desc_esafeout(2),
 	{
 		.name = "CHARGER",
 		.id = MAX77693_CHARGER,
@@ -160,19 +199,79 @@ static const struct chg_reg_data max77693_chg_reg_data = {
 	.min_sel	= 3,
 };
 
+#define	max77843_regulator_desc_esafeout(num)	{			\
+	.name		= "SAFEOUT" # num,				\
+	.id		= MAX77843_SAFEOUT ## num,			\
+	.ops		= &max77693_safeout_ops,			\
+	.of_match	= of_match_ptr("SAFEOUT" # num),		\
+	.regulators_node = of_match_ptr("regulators"),			\
+	.type		= REGULATOR_VOLTAGE,				\
+	.owner		= THIS_MODULE,					\
+	.n_voltages	= ARRAY_SIZE(max77693_safeout_table),		\
+	.volt_table	= max77693_safeout_table,			\
+	.enable_reg	= MAX77843_SYS_REG_SAFEOUTCTRL,			\
+	.enable_mask	= MAX77843_REG_SAFEOUTCTRL_ENSAFEOUT ## num,	\
+	.vsel_reg	= MAX77843_SYS_REG_SAFEOUTCTRL,			\
+	.vsel_mask	= MAX77843_REG_SAFEOUTCTRL_SAFEOUT ## num ## _MASK, \
+}
+
+static const struct regulator_desc max77843_supported_regulators[] = {
+	[MAX77843_SAFEOUT1] = max77843_regulator_desc_esafeout(1),
+	[MAX77843_SAFEOUT2] = max77843_regulator_desc_esafeout(2),
+	[MAX77843_CHARGER] = {
+		.name		= "CHARGER",
+		.id		= MAX77843_CHARGER,
+		.ops		= &max77693_charger_ops,
+		.of_match	= of_match_ptr("CHARGER"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type		= REGULATOR_CURRENT,
+		.owner		= THIS_MODULE,
+		.enable_reg	= MAX77843_CHG_REG_CHG_CNFG_00,
+		.enable_mask	= MAX77843_CHG_MASK,
+		.enable_val	= MAX77843_CHG_MASK,
+	},
+};
+
+static const struct chg_reg_data max77843_chg_reg_data = {
+	.linear_reg	= MAX77843_CHG_REG_CHG_CNFG_02,
+	.linear_mask	= MAX77843_CHG_FAST_CHG_CURRENT_MASK,
+	.uA_step	= MAX77843_CHG_FAST_CHG_CURRENT_STEP,
+	.min_sel	= 2,
+};
+
 static int max77693_pmic_probe(struct platform_device *pdev)
 {
+	enum max77693_types type = platform_get_device_id(pdev)->driver_data;
 	struct max77693_dev *iodev = dev_get_drvdata(pdev->dev.parent);
+	const struct regulator_desc *regulators;
+	unsigned int regulators_size;
 	int i;
 	struct regulator_config config = { };
 
 	config.dev = iodev->dev;
-	config.regmap = iodev->regmap;
-	config.driver_data = (void *)&max77693_chg_reg_data;
 
-	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
+	switch (type) {
+	case TYPE_MAX77693:
+		regulators = max77693_supported_regulators;
+		regulators_size = ARRAY_SIZE(max77693_supported_regulators);
+		config.driver_data = (void *)&max77693_chg_reg_data;
+		break;
+	case TYPE_MAX77843:
+		regulators = max77843_supported_regulators;
+		regulators_size = ARRAY_SIZE(max77843_supported_regulators);
+		config.driver_data = (void *)&max77843_chg_reg_data;
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported device type: %u\n", type);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < regulators_size; i++) {
 		struct regulator_dev *rdev;
 
+		config.regmap = max77693_get_regmap(type, iodev,
+						    regulators[i].id);
+
 		rdev = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
 		if (IS_ERR(rdev)) {
@@ -187,6 +286,7 @@ static int max77693_pmic_probe(struct platform_device *pdev)
 
 static const struct platform_device_id max77693_pmic_id[] = {
 	{ "max77693-pmic", TYPE_MAX77693 },
+	{ "max77843-regulator", TYPE_MAX77843 },
 	{},
 };
 
@@ -202,6 +302,7 @@ static struct platform_driver max77693_pmic_driver = {
 
 module_platform_driver(max77693_pmic_driver);
 
-MODULE_DESCRIPTION("MAXIM MAX77693 regulator driver");
+MODULE_DESCRIPTION("MAXIM 77693/77843 regulator driver");
 MODULE_AUTHOR("Jonghwa Lee <jonghwa3.lee@samsung.com>");
+MODULE_AUTHOR("Krzysztof Kozlowski <k.kozlowski.k@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
2.1.4

