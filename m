From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH v5 3/9] regulator: max77693: Support different register configurations
Date: Wed, 15 Jul 2015 21:59:49 +0900
Message-ID: <1436965195-8899-4-git-send-email-k.kozlowski.k@gmail.com>
References: <1436965195-8899-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436965195-8899-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-leds@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

Add support for different configurations of charger's registers so the
same driver could be used on other devices (e.g. MAX77843).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77693.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/max77693.c b/drivers/regulator/max77693.c
index 38722c8311a5..236851ab575a 100644
--- a/drivers/regulator/max77693.c
+++ b/drivers/regulator/max77693.c
@@ -33,7 +33,13 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/regmap.h>
 
-#define CHGIN_ILIM_STEP_20mA			20000
+/* Charger regulator differences between MAX77693 and MAX77843 */
+struct chg_reg_data {
+	unsigned int linear_reg;
+	unsigned int linear_mask;
+	unsigned int uA_step;
+	unsigned int min_sel;
+};
 
 /*
  * CHARGER regulator - Min : 20mA, Max : 2580mA, step : 20mA
@@ -42,25 +48,26 @@
  */
 static int max77693_chg_get_current_limit(struct regulator_dev *rdev)
 {
+	const struct chg_reg_data *reg_data = rdev_get_drvdata(rdev);
 	unsigned int chg_min_uA = rdev->constraints->min_uA;
 	unsigned int chg_max_uA = rdev->constraints->max_uA;
 	unsigned int reg, sel;
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read(rdev->regmap, MAX77693_CHG_REG_CHG_CNFG_09, &reg);
+	ret = regmap_read(rdev->regmap, reg_data->linear_reg, &reg);
 	if (ret < 0)
 		return ret;
 
-	sel = reg & CHG_CNFG_09_CHGIN_ILIM_MASK;
+	sel = reg & reg_data->linear_mask;
 
 	/* the first four codes for charger current are all 60mA */
-	if (sel <= 3)
+	if (sel <= reg_data->min_sel)
 		sel = 0;
 	else
-		sel -= 3;
+		sel -= reg_data->min_sel;
 
-	val = chg_min_uA + CHGIN_ILIM_STEP_20mA * sel;
+	val = chg_min_uA + reg_data->uA_step * sel;
 	if (val > chg_max_uA)
 		return -EINVAL;
 
@@ -70,20 +77,20 @@ static int max77693_chg_get_current_limit(struct regulator_dev *rdev)
 static int max77693_chg_set_current_limit(struct regulator_dev *rdev,
 						int min_uA, int max_uA)
 {
+	const struct chg_reg_data *reg_data = rdev_get_drvdata(rdev);
 	unsigned int chg_min_uA = rdev->constraints->min_uA;
 	int sel = 0;
 
-	while (chg_min_uA + CHGIN_ILIM_STEP_20mA * sel < min_uA)
+	while (chg_min_uA + reg_data->uA_step * sel < min_uA)
 		sel++;
 
-	if (chg_min_uA + CHGIN_ILIM_STEP_20mA * sel > max_uA)
+	if (chg_min_uA + reg_data->uA_step * sel > max_uA)
 		return -EINVAL;
 
 	/* the first four codes for charger current are all 60mA */
-	sel += 3;
+	sel += reg_data->min_sel;
 
-	return regmap_write(rdev->regmap,
-				MAX77693_CHG_REG_CHG_CNFG_09, sel);
+	return regmap_write(rdev->regmap, reg_data->linear_reg, sel);
 }
 /* end of CHARGER regulator ops */
 
@@ -145,6 +152,13 @@ static const struct regulator_desc regulators[] = {
 	},
 };
 
+static const struct chg_reg_data max77693_chg_reg_data = {
+	.linear_reg	= MAX77693_CHG_REG_CHG_CNFG_09,
+	.linear_mask	= CHG_CNFG_09_CHGIN_ILIM_MASK,
+	.uA_step	= 20000,
+	.min_sel	= 3,
+};
+
 static int max77693_pmic_probe(struct platform_device *pdev)
 {
 	struct max77693_dev *iodev = dev_get_drvdata(pdev->dev.parent);
@@ -153,6 +167,7 @@ static int max77693_pmic_probe(struct platform_device *pdev)
 
 	config.dev = iodev->dev;
 	config.regmap = iodev->regmap;
+	config.driver_data = (void *)&max77693_chg_reg_data;
 
 	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
 		struct regulator_dev *rdev;
@@ -170,7 +185,7 @@ static int max77693_pmic_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id max77693_pmic_id[] = {
-	{"max77693-pmic", 0},
+	{ "max77693-pmic", TYPE_MAX77693 },
 	{},
 };
 
-- 
2.1.4
