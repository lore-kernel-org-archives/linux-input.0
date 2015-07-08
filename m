From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH v3 9/9] regulator: Remove the max77843 driver
Date: Wed,  8 Jul 2015 20:00:17 +0900
Message-ID: <1436353217-1141-10-git-send-email-k.kozlowski.k@gmail.com>
References: <1436353217-1141-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1436353217-1141-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

The max77693 regulator driver supports Maxim 77843 device so remove the
max77843 driver.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/regulator/Kconfig    |   8 --
 drivers/regulator/Makefile   |   1 -
 drivers/regulator/max77843.c | 203 -------------------------------------------
 3 files changed, 212 deletions(-)
 delete mode 100644 drivers/regulator/max77843.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b1022c2fd877..ed5ac9eb5063 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -424,14 +424,6 @@ config REGULATOR_MAX77802
 	  Exynos5420/Exynos5800 SoCs to control various voltages.
 	  It includes support for control of voltage and ramp speed.
 
-config REGULATOR_MAX77843
-	tristate "Maxim 77843 regulator"
-	depends on MFD_MAX77843
-	help
-	  This driver controls a Maxim 77843 regulator.
-	  The regulator include two 'SAFEOUT' for USB(Universal Serial Bus)
-	  This is suitable for Exynos5433 SoC chips.
-
 config REGULATOR_MC13XXX_CORE
 	tristate
 
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 91bf76267404..6429e629dcb6 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -56,7 +56,6 @@ obj-$(CONFIG_REGULATOR_MAX8998) += max8998.o
 obj-$(CONFIG_REGULATOR_MAX77686) += max77686.o
 obj-$(CONFIG_REGULATOR_MAX77693) += max77693.o
 obj-$(CONFIG_REGULATOR_MAX77802) += max77802.o
-obj-$(CONFIG_REGULATOR_MAX77843) += max77843.o
 obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
diff --git a/drivers/regulator/max77843.c b/drivers/regulator/max77843.c
deleted file mode 100644
index 93507c3aff23..000000000000
--- a/drivers/regulator/max77843.c
+++ /dev/null
@@ -1,203 +0,0 @@
-/*
- * max77843.c - Regulator driver for the Maxim MAX77843
- *
- * Copyright (C) 2015 Samsung Electronics
- * Author: Jaewon Kim <jaewon02.kim@samsung.com>
- * Author: Beomho Seo <beomho.seo@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/mfd/max77843-private.h>
-#include <linux/mfd/max77693-common.h>
-#include <linux/regulator/of_regulator.h>
-
-enum max77843_regulator_type {
-	MAX77843_SAFEOUT1 = 0,
-	MAX77843_SAFEOUT2,
-	MAX77843_CHARGER,
-
-	MAX77843_NUM,
-};
-
-static const unsigned int max77843_safeout_voltage_table[] = {
-	4850000,
-	4900000,
-	4950000,
-	3300000,
-};
-
-static int max77843_reg_get_current_limit(struct regulator_dev *rdev)
-{
-	struct regmap *regmap = rdev->regmap;
-	unsigned int chg_min_uA = rdev->constraints->min_uA;
-	unsigned int chg_max_uA = rdev->constraints->max_uA;
-	unsigned int val;
-	int ret;
-	unsigned int reg, sel;
-
-	ret = regmap_read(regmap, MAX77843_CHG_REG_CHG_CNFG_02, &reg);
-	if (ret) {
-		dev_err(&rdev->dev, "Failed to read charger register\n");
-		return ret;
-	}
-
-	sel = reg & MAX77843_CHG_FAST_CHG_CURRENT_MASK;
-
-	if (sel < 0x03)
-		sel = 0;
-	else
-		sel -= 2;
-
-	val = chg_min_uA + MAX77843_CHG_FAST_CHG_CURRENT_STEP * sel;
-	if (val > chg_max_uA)
-		return -EINVAL;
-
-	return val;
-}
-
-static int max77843_reg_set_current_limit(struct regulator_dev *rdev,
-		int min_uA, int max_uA)
-{
-	struct regmap *regmap = rdev->regmap;
-	unsigned int chg_min_uA = rdev->constraints->min_uA;
-	int sel = 0;
-
-	while (chg_min_uA + MAX77843_CHG_FAST_CHG_CURRENT_STEP * sel < min_uA)
-		sel++;
-
-	if (chg_min_uA + MAX77843_CHG_FAST_CHG_CURRENT_STEP * sel > max_uA)
-		return -EINVAL;
-
-	sel += 2;
-
-	return regmap_write(regmap, MAX77843_CHG_REG_CHG_CNFG_02, sel);
-}
-
-static struct regulator_ops max77843_charger_ops = {
-	.is_enabled		= regulator_is_enabled_regmap,
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
-	.get_current_limit	= max77843_reg_get_current_limit,
-	.set_current_limit	= max77843_reg_set_current_limit,
-};
-
-static struct regulator_ops max77843_regulator_ops = {
-	.is_enabled             = regulator_is_enabled_regmap,
-	.enable                 = regulator_enable_regmap,
-	.disable                = regulator_disable_regmap,
-	.list_voltage		= regulator_list_voltage_table,
-	.get_voltage_sel        = regulator_get_voltage_sel_regmap,
-	.set_voltage_sel        = regulator_set_voltage_sel_regmap,
-};
-
-#define	MAX77843_SAFEOUT(num)	{ \
-	.name		= "SAFEOUT" # num, \
-	.id		= MAX77843_SAFEOUT ## num, \
-	.ops		= &max77843_regulator_ops, \
-	.of_match	= of_match_ptr("SAFEOUT" # num), \
-	.regulators_node = of_match_ptr("regulators"), \
-	.type		= REGULATOR_VOLTAGE, \
-	.owner		= THIS_MODULE, \
-	.n_voltages	= ARRAY_SIZE(max77843_safeout_voltage_table), \
-	.volt_table	= max77843_safeout_voltage_table, \
-	.enable_reg	= MAX77843_SYS_REG_SAFEOUTCTRL, \
-	.enable_mask	= MAX77843_REG_SAFEOUTCTRL_ENSAFEOUT ## num, \
-	.vsel_reg	= MAX77843_SYS_REG_SAFEOUTCTRL, \
-	.vsel_mask	= MAX77843_REG_SAFEOUTCTRL_SAFEOUT ## num ## _MASK, \
-}
-
-static const struct regulator_desc max77843_supported_regulators[] = {
-	[MAX77843_SAFEOUT1] = MAX77843_SAFEOUT(1),
-	[MAX77843_SAFEOUT2] = MAX77843_SAFEOUT(2),
-	[MAX77843_CHARGER] = {
-		.name		= "CHARGER",
-		.id		= MAX77843_CHARGER,
-		.ops		= &max77843_charger_ops,
-		.of_match	= of_match_ptr("CHARGER"),
-		.regulators_node = of_match_ptr("regulators"),
-		.type		= REGULATOR_CURRENT,
-		.owner		= THIS_MODULE,
-		.enable_reg	= MAX77843_CHG_REG_CHG_CNFG_00,
-		.enable_mask	= MAX77843_CHG_MASK | MAX77843_CHG_BUCK_MASK,
-		.enable_val	= MAX77843_CHG_MASK | MAX77843_CHG_BUCK_MASK,
-	},
-};
-
-static struct regmap *max77843_get_regmap(struct max77693_dev *max77843,
-					  int reg_id)
-{
-	switch (reg_id) {
-	case MAX77843_SAFEOUT1:
-	case MAX77843_SAFEOUT2:
-		return max77843->regmap;
-	case MAX77843_CHARGER:
-		return max77843->regmap_chg;
-	default:
-		return max77843->regmap;
-	}
-}
-
-static int max77843_regulator_probe(struct platform_device *pdev)
-{
-	struct max77693_dev *max77843 = dev_get_drvdata(pdev->dev.parent);
-	struct regulator_config config = {};
-	int i;
-
-	config.dev = max77843->dev;
-	config.driver_data = max77843;
-
-	for (i = 0; i < ARRAY_SIZE(max77843_supported_regulators); i++) {
-		struct regulator_dev *regulator;
-
-		config.regmap = max77843_get_regmap(max77843,
-				max77843_supported_regulators[i].id);
-
-		regulator = devm_regulator_register(&pdev->dev,
-				&max77843_supported_regulators[i], &config);
-		if (IS_ERR(regulator)) {
-			dev_err(&pdev->dev,
-					"Failed to regiser regulator-%d\n", i);
-			return PTR_ERR(regulator);
-		}
-	}
-
-	return 0;
-}
-
-static const struct platform_device_id max77843_regulator_id[] = {
-	{ "max77843-regulator", },
-	{ /* sentinel */ },
-};
-
-static struct platform_driver max77843_regulator_driver = {
-	.driver	= {
-		.name = "max77843-regulator",
-	},
-	.probe		= max77843_regulator_probe,
-	.id_table	= max77843_regulator_id,
-};
-
-static int __init max77843_regulator_init(void)
-{
-	return platform_driver_register(&max77843_regulator_driver);
-}
-subsys_initcall(max77843_regulator_init);
-
-static void __exit max77843_regulator_exit(void)
-{
-	platform_driver_unregister(&max77843_regulator_driver);
-}
-module_exit(max77843_regulator_exit);
-
-MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
-MODULE_AUTHOR("Beomho Seo <beomho.seo@samsung.com>");
-MODULE_DESCRIPTION("Maxim MAX77843 regulator driver");
-MODULE_LICENSE("GPL");
-- 
2.1.4

