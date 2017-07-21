From: Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH v7 03/12] regulator: rk808: Add regulator driver for RK805
Date: Fri, 21 Jul 2017 19:14:32 +0800
Message-ID: <1500635681-12477-4-git-send-email-chenjh@rock-chips.com>
References: <1500635681-12477-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:38757 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdGULP6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Jul 2017 07:15:58 -0400
In-Reply-To: <1500635681-12477-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, tony.xie@rock-chips.com, zhangqing@rock-chips.com, wdc@rock-chips.com, devicetree@vger.kernel.org, w.egorov@phytec.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add support for the rk805 regulator. The regulator module consists
of 4 DCDCs, 3 LDOs.

The output voltages are configurable and are meant to supply power
to the main processor and other components.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig           |   4 +-
 drivers/regulator/rk808-regulator.c | 130 ++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index be06eb2..285e280 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -650,11 +650,11 @@ config REGULATOR_RC5T583
 	  outputs which can be controlled by i2c communication.
 
 config REGULATOR_RK808
-	tristate "Rockchip RK808/RK818 Power regulators"
+	tristate "Rockchip RK805/RK808/RK818 Power regulators"
 	depends on MFD_RK808
 	help
 	  Select this option to enable the power regulator of ROCKCHIP
-	  PMIC RK808 and RK818.
+	  PMIC RK805,RK808 and RK818.
 	  This driver supports the control of different power rails of device
 	  through regulator interface. The device supports multiple DCDC/LDO
 	  outputs which can be controlled by i2c communication.
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index fb44d52..128c81e 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -65,6 +65,27 @@
 /* max steps for increase voltage of Buck1/2, equal 100mv*/
 #define MAX_STEPS_ONE_TIME 8
 
+#define RK805_DESC(_id, _match, _supply, _min, _max, _step, _vreg,      \
+	_vmask, _ereg, _emask, _etime)                                  \
+	[_id] = {                                                       \
+		.name           = (_match),                             \
+		.supply_name    = (_supply),                            \
+		.of_match       = of_match_ptr(_match),                 \
+		.regulators_node = of_match_ptr("regulators"),          \
+		.type           = REGULATOR_VOLTAGE,                    \
+		.id             = (_id),                                \
+		.n_voltages     = (((_max) - (_min)) / (_step) + 1),    \
+		.owner          = THIS_MODULE,                          \
+		.min_uV         = (_min) * 1000,                        \
+		.uV_step        = (_step) * 1000,                       \
+		.vsel_reg       = (_vreg),                              \
+		.vsel_mask      = (_vmask),                             \
+		.enable_reg     = (_ereg),                              \
+		.enable_mask    = (_emask),                             \
+		.enable_time    = (_etime),                             \
+		.ops            = &rk805_reg_ops,                       \
+	}
+
 #define RK8XX_DESC(_id, _match, _supply, _min, _max, _step, _vreg,	\
 	_vmask, _ereg, _emask, _etime)					\
 	[_id] = {							\
@@ -298,6 +319,28 @@ static int rk808_set_suspend_voltage_range(struct regulator_dev *rdev, int uv)
 				  sel);
 }
 
+static int rk805_set_suspend_enable(struct regulator_dev *rdev)
+{
+	unsigned int reg;
+
+	reg = rdev->desc->enable_reg + RK808_SLP_SET_OFF_REG_OFFSET;
+
+	return regmap_update_bits(rdev->regmap, reg,
+				  rdev->desc->enable_mask,
+				  rdev->desc->enable_mask);
+}
+
+static int rk805_set_suspend_disable(struct regulator_dev *rdev)
+{
+	unsigned int reg;
+
+	reg = rdev->desc->enable_reg + RK808_SLP_SET_OFF_REG_OFFSET;
+
+	return regmap_update_bits(rdev->regmap, reg,
+				  rdev->desc->enable_mask,
+				  0);
+}
+
 static int rk808_set_suspend_enable(struct regulator_dev *rdev)
 {
 	unsigned int reg;
@@ -320,6 +363,27 @@ static int rk808_set_suspend_disable(struct regulator_dev *rdev)
 				  rdev->desc->enable_mask);
 }
 
+static struct regulator_ops rk805_reg_ops = {
+		.list_voltage           = regulator_list_voltage_linear,
+		.map_voltage            = regulator_map_voltage_linear,
+		.get_voltage_sel        = regulator_get_voltage_sel_regmap,
+		.set_voltage_sel        = regulator_set_voltage_sel_regmap,
+		.enable                 = regulator_enable_regmap,
+		.disable                = regulator_disable_regmap,
+		.is_enabled             = regulator_is_enabled_regmap,
+		.set_suspend_voltage    = rk808_set_suspend_voltage,
+		.set_suspend_enable     = rk805_set_suspend_enable,
+		.set_suspend_disable    = rk805_set_suspend_disable,
+};
+
+static struct regulator_ops rk805_switch_ops = {
+		.enable                 = regulator_enable_regmap,
+		.disable                = regulator_disable_regmap,
+		.is_enabled             = regulator_is_enabled_regmap,
+		.set_suspend_enable     = rk805_set_suspend_enable,
+		.set_suspend_disable    = rk805_set_suspend_disable,
+};
+
 static struct regulator_ops rk808_buck1_2_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -369,6 +433,68 @@ static int rk808_set_suspend_disable(struct regulator_dev *rdev)
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
+static const struct regulator_desc rk805_reg[] = {
+	{
+		.name = "DCDC_REG1",
+		.supply_name = "vcc1",
+		.of_match = of_match_ptr("DCDC_REG1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK805_ID_DCDC1,
+		.ops = &rk805_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 712500,
+		.uV_step = 12500,
+		.n_voltages = 64,
+		.vsel_reg = RK805_BUCK1_ON_VSEL_REG,
+		.vsel_mask = RK818_BUCK_VSEL_MASK,
+		.enable_reg = RK805_DCDC_EN_REG,
+		.enable_mask = BIT(0),
+		.owner = THIS_MODULE,
+	}, {
+		.name = "DCDC_REG2",
+		.supply_name = "vcc2",
+		.of_match = of_match_ptr("DCDC_REG2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK805_ID_DCDC2,
+		.ops = &rk805_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 712500,
+		.uV_step = 12500,
+		.n_voltages = 64,
+		.vsel_reg = RK805_BUCK2_ON_VSEL_REG,
+		.vsel_mask = RK818_BUCK_VSEL_MASK,
+		.enable_reg = RK805_DCDC_EN_REG,
+		.enable_mask = BIT(1),
+		.owner = THIS_MODULE,
+	}, {
+		.name = "DCDC_REG3",
+		.supply_name = "vcc3",
+		.of_match = of_match_ptr("DCDC_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK805_ID_DCDC3,
+		.ops = &rk805_switch_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 1,
+		.enable_reg = RK805_DCDC_EN_REG,
+		.enable_mask = BIT(2),
+		.owner = THIS_MODULE,
+	},
+
+	RK805_DESC(RK805_ID_DCDC4, "DCDC_REG4", "vcc4", 800, 3400, 100,
+		RK805_BUCK4_ON_VSEL_REG, RK818_BUCK4_VSEL_MASK,
+		RK805_DCDC_EN_REG, BIT(3), 0),
+
+	RK805_DESC(RK805_ID_LDO1, "LDO_REG1", "vcc5", 800, 3400, 100,
+		RK805_LDO1_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK805_LDO_EN_REG,
+		BIT(0), 400),
+	RK805_DESC(RK805_ID_LDO2, "LDO_REG2", "vcc5", 800, 3400, 100,
+		RK805_LDO2_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK805_LDO_EN_REG,
+		BIT(1), 400),
+	RK805_DESC(RK805_ID_LDO3, "LDO_REG3", "vcc6", 800, 3400, 100,
+		RK805_LDO3_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK805_LDO_EN_REG,
+		BIT(2), 400),
+};
+
 static const struct regulator_desc rk808_reg[] = {
 	{
 		.name = "DCDC_REG1",
@@ -625,6 +751,10 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pdata);
 
 	switch (rk808->variant) {
+	case RK805_ID:
+		regulators = rk805_reg;
+		nregulators = RK805_NUM_REGULATORS;
+		break;
 	case RK808_ID:
 		regulators = rk808_reg;
 		nregulators = RK808_NUM_REGULATORS;
-- 
1.9.1


