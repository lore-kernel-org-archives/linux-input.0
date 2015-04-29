From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 03/10] regulator: max77693: Use core code for charger's is_enabled
Date: Wed, 29 Apr 2015 19:58:28 +0900
Message-ID: <1430305114-23598-4-git-send-email-k.kozlowski.k@gmail.com>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

The custom implementation of 'regulator_ops.is_enabled' callback for
charger regulator is exactly the same as regulator_is_enabled_regmap()
with 'enable_val' set.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/regulator/max77693.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/max77693.c b/drivers/regulator/max77693.c
index 9665a488e2f1..38722c8311a5 100644
--- a/drivers/regulator/max77693.c
+++ b/drivers/regulator/max77693.c
@@ -35,20 +35,6 @@
 
 #define CHGIN_ILIM_STEP_20mA			20000
 
-/* CHARGER regulator ops */
-/* CHARGER regulator uses two bits for enabling */
-static int max77693_chg_is_enabled(struct regulator_dev *rdev)
-{
-	int ret;
-	unsigned int val;
-
-	ret = regmap_read(rdev->regmap, rdev->desc->enable_reg, &val);
-	if (ret)
-		return ret;
-
-	return (val & rdev->desc->enable_mask) == rdev->desc->enable_mask;
-}
-
 /*
  * CHARGER regulator - Min : 20mA, Max : 2580mA, step : 20mA
  * 0x00, 0x01, 0x2, 0x03	= 60 mA
@@ -118,7 +104,7 @@ static struct regulator_ops max77693_safeout_ops = {
 };
 
 static struct regulator_ops max77693_charger_ops = {
-	.is_enabled		= max77693_chg_is_enabled,
+	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.get_current_limit	= max77693_chg_get_current_limit,
@@ -155,6 +141,7 @@ static const struct regulator_desc regulators[] = {
 		.enable_reg = MAX77693_CHG_REG_CHG_CNFG_00,
 		.enable_mask = CHG_CNFG_00_CHG_MASK |
 				CHG_CNFG_00_BUCK_MASK,
+		.enable_val = CHG_CNFG_00_CHG_MASK | CHG_CNFG_00_BUCK_MASK,
 	},
 };
 
-- 
2.1.4
