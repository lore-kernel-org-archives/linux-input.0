From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: da9061: BUCK and LDO regulator driver" to the regulator tree
Date: Wed, 07 Jun 2017 20:32:15 +0100
Message-ID: <E1dIggh-0003pV-5u@debutante>
References: <f23fd01423a6db88c32ce7966b048525bf333b9e.1490608293.git.stwiss.opensource@diasemi.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47064 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdFGTc5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 15:32:57 -0400
In-Reply-To: <f23fd01423a6db88c32ce7966b048525bf333b9e.1490608293.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>linux-kernel@vger.kernel.org

The patch

   regulator: da9061: BUCK and LDO regulator driver

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4b7f4958a37e016317d3f25bd5290942f72597b4 Mon Sep 17 00:00:00 2001
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Wed, 7 Jun 2017 09:13:48 +0100
Subject: [PATCH] regulator: da9061: BUCK and LDO regulator driver

Regulator support for the DA9061 is added into the DA9062 regulator driver.

The regulators for DA9061 differ from those of DA9062.
A new DA9061 enumeration list for the LDOs and Bucks supported by this
device is added. Regulator information added: the old regulator
information for DA9062 is renamed from local_regulator_info[] to
local_da9062_regulator_info[] and a new array is added to support
local_da9061_regulator_info[].

The probe() function switches on the da9062_compatible_types enumeration
and configures the correct da9062_regulator_info array and number of
regulator entries.

Kconfig is updated to reflect support for DA9061 and DA9062 regulators.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig            |   4 +-
 drivers/regulator/da9062-regulator.c | 303 +++++++++++++++++++++++++++++++++--
 2 files changed, 293 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 48db87d6dfef..9d2222eadcfc 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -214,11 +214,11 @@ config REGULATOR_DA9055
 	  will be called da9055-regulator.
 
 config REGULATOR_DA9062
-	tristate "Dialog Semiconductor DA9062 regulators"
+	tristate "Dialog Semiconductor DA9061/62 regulators"
 	depends on MFD_DA9062
 	help
 	  Say y here to support the BUCKs and LDOs regulators found on
-	  DA9062 PMICs.
+	  DA9061 and DA9062 PMICs.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called da9062-regulator.
diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 0638c8b40521..34a70d9dc450 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1,6 +1,6 @@
 /*
- * da9062-regulator.c - REGULATOR device driver for DA9062
- * Copyright (C) 2015  Dialog Semiconductor Ltd.
+ * Regulator device driver for DA9061 and DA9062.
+ * Copyright (C) 2015-2017  Dialog Semiconductor
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -28,6 +28,17 @@
 
 /* Regulator IDs */
 enum {
+	DA9061_ID_BUCK1,
+	DA9061_ID_BUCK2,
+	DA9061_ID_BUCK3,
+	DA9061_ID_LDO1,
+	DA9061_ID_LDO2,
+	DA9061_ID_LDO3,
+	DA9061_ID_LDO4,
+	DA9061_MAX_REGULATORS,
+};
+
+enum {
 	DA9062_ID_BUCK1,
 	DA9062_ID_BUCK2,
 	DA9062_ID_BUCK3,
@@ -88,15 +99,21 @@ enum {
 
 /* Regulator operations */
 
-/* Current limits array (in uA) BUCK1 and BUCK3.
-   Entry indexes corresponds to register values. */
+/* Current limits array (in uA)
+ * - DA9061_ID_[BUCK1|BUCK3]
+ * - DA9062_ID_[BUCK1|BUCK2|BUCK4]
+ * Entry indexes corresponds to register values.
+ */
 static const int da9062_buck_a_limits[] = {
 	 500000,  600000,  700000,  800000,  900000, 1000000, 1100000, 1200000,
 	1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000
 };
 
-/* Current limits array (in uA) for BUCK2.
-   Entry indexes corresponds to register values. */
+/* Current limits array (in uA)
+ * - DA9061_ID_BUCK2
+ * - DA9062_ID_BUCK3
+ * Entry indexes corresponds to register values.
+ */
 static const int da9062_buck_b_limits[] = {
 	1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000, 2200000,
 	2300000, 2400000, 2500000, 2600000, 2700000, 2800000, 2900000, 3000000
@@ -405,8 +422,254 @@ static const struct regulator_ops da9062_ldo_ops = {
 	.set_suspend_mode	= da9062_ldo_set_suspend_mode,
 };
 
-/* Regulator information */
-static const struct da9062_regulator_info local_regulator_info[] = {
+/* DA9061 Regulator information */
+static const struct da9062_regulator_info local_da9061_regulator_info[] = {
+	{
+		.desc.id = DA9061_ID_BUCK1,
+		.desc.name = "DA9061 BUCK1",
+		.desc.of_match = of_match_ptr("buck1"),
+		.desc.regulators_node = of_match_ptr("regulators"),
+		.desc.ops = &da9062_buck_ops,
+		.desc.min_uV = (300) * 1000,
+		.desc.uV_step = (10) * 1000,
+		.desc.n_voltages = ((1570) - (300))/(10) + 1,
+		.current_limits = da9062_buck_a_limits,
+		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.enable_reg = DA9062AA_BUCK1_CONT,
+		.desc.enable_mask = DA9062AA_BUCK1_EN_MASK,
+		.desc.vsel_reg = DA9062AA_VBUCK1_A,
+		.desc.vsel_mask = DA9062AA_VBUCK1_A_MASK,
+		.desc.linear_min_sel = 0,
+		.sleep = REG_FIELD(DA9062AA_VBUCK1_A,
+			__builtin_ffs((int)DA9062AA_BUCK1_SL_A_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK1_SL_A_MASK)) - 1),
+		.suspend_sleep = REG_FIELD(DA9062AA_VBUCK1_B,
+			__builtin_ffs((int)DA9062AA_BUCK1_SL_B_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK1_SL_B_MASK)) - 1),
+		.suspend_vsel_reg = DA9062AA_VBUCK1_B,
+		.mode = REG_FIELD(DA9062AA_BUCK1_CFG,
+			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
+		.suspend = REG_FIELD(DA9062AA_DVC_1,
+			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
+		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_C,
+			__builtin_ffs((int)DA9062AA_BUCK1_ILIM_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK1_ILIM_MASK)) - 1),
+	},
+	{
+		.desc.id = DA9061_ID_BUCK2,
+		.desc.name = "DA9061 BUCK2",
+		.desc.of_match = of_match_ptr("buck2"),
+		.desc.regulators_node = of_match_ptr("regulators"),
+		.desc.ops = &da9062_buck_ops,
+		.desc.min_uV = (800) * 1000,
+		.desc.uV_step = (20) * 1000,
+		.desc.n_voltages = ((3340) - (800))/(20) + 1,
+		.current_limits = da9062_buck_b_limits,
+		.n_current_limits = ARRAY_SIZE(da9062_buck_b_limits),
+		.desc.enable_reg = DA9062AA_BUCK3_CONT,
+		.desc.enable_mask = DA9062AA_BUCK3_EN_MASK,
+		.desc.vsel_reg = DA9062AA_VBUCK3_A,
+		.desc.vsel_mask = DA9062AA_VBUCK3_A_MASK,
+		.desc.linear_min_sel = 0,
+		.sleep = REG_FIELD(DA9062AA_VBUCK3_A,
+			__builtin_ffs((int)DA9062AA_BUCK3_SL_A_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK3_SL_A_MASK)) - 1),
+		.suspend_sleep = REG_FIELD(DA9062AA_VBUCK3_B,
+			__builtin_ffs((int)DA9062AA_BUCK3_SL_B_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK3_SL_B_MASK)) - 1),
+		.suspend_vsel_reg = DA9062AA_VBUCK3_B,
+		.mode = REG_FIELD(DA9062AA_BUCK3_CFG,
+			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
+		.suspend = REG_FIELD(DA9062AA_DVC_1,
+			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
+		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_A,
+			__builtin_ffs((int)DA9062AA_BUCK3_ILIM_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK3_ILIM_MASK)) - 1),
+	},
+	{
+		.desc.id = DA9061_ID_BUCK3,
+		.desc.name = "DA9061 BUCK3",
+		.desc.of_match = of_match_ptr("buck3"),
+		.desc.regulators_node = of_match_ptr("regulators"),
+		.desc.ops = &da9062_buck_ops,
+		.desc.min_uV = (530) * 1000,
+		.desc.uV_step = (10) * 1000,
+		.desc.n_voltages = ((1800) - (530))/(10) + 1,
+		.current_limits = da9062_buck_a_limits,
+		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.enable_reg = DA9062AA_BUCK4_CONT,
+		.desc.enable_mask = DA9062AA_BUCK4_EN_MASK,
+		.desc.vsel_reg = DA9062AA_VBUCK4_A,
+		.desc.vsel_mask = DA9062AA_VBUCK4_A_MASK,
+		.desc.linear_min_sel = 0,
+		.sleep = REG_FIELD(DA9062AA_VBUCK4_A,
+			__builtin_ffs((int)DA9062AA_BUCK4_SL_A_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK4_SL_A_MASK)) - 1),
+		.suspend_sleep = REG_FIELD(DA9062AA_VBUCK4_B,
+			__builtin_ffs((int)DA9062AA_BUCK4_SL_B_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK4_SL_B_MASK)) - 1),
+		.suspend_vsel_reg = DA9062AA_VBUCK4_B,
+		.mode = REG_FIELD(DA9062AA_BUCK4_CFG,
+			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
+		.suspend = REG_FIELD(DA9062AA_DVC_1,
+			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
+		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_B,
+			__builtin_ffs((int)DA9062AA_BUCK4_ILIM_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_BUCK4_ILIM_MASK)) - 1),
+	},
+	{
+		.desc.id = DA9061_ID_LDO1,
+		.desc.name = "DA9061 LDO1",
+		.desc.of_match = of_match_ptr("ldo1"),
+		.desc.regulators_node = of_match_ptr("regulators"),
+		.desc.ops = &da9062_ldo_ops,
+		.desc.min_uV = (900) * 1000,
+		.desc.uV_step = (50) * 1000,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.enable_reg = DA9062AA_LDO1_CONT,
+		.desc.enable_mask = DA9062AA_LDO1_EN_MASK,
+		.desc.vsel_reg = DA9062AA_VLDO1_A,
+		.desc.vsel_mask = DA9062AA_VLDO1_A_MASK,
+		.desc.linear_min_sel = 0,
+		.sleep = REG_FIELD(DA9062AA_VLDO1_A,
+			__builtin_ffs((int)DA9062AA_LDO1_SL_A_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO1_SL_A_MASK)) - 1),
+		.suspend_sleep = REG_FIELD(DA9062AA_VLDO1_B,
+			__builtin_ffs((int)DA9062AA_LDO1_SL_B_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
+		.suspend_vsel_reg = DA9062AA_VLDO1_B,
+		.suspend = REG_FIELD(DA9062AA_DVC_1,
+			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
+		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
+			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO1_ILIM_MASK)) - 1),
+	},
+	{
+		.desc.id = DA9061_ID_LDO2,
+		.desc.name = "DA9061 LDO2",
+		.desc.of_match = of_match_ptr("ldo2"),
+		.desc.regulators_node = of_match_ptr("regulators"),
+		.desc.ops = &da9062_ldo_ops,
+		.desc.min_uV = (900) * 1000,
+		.desc.uV_step = (50) * 1000,
+		.desc.n_voltages = ((3600) - (600))/(50) + 1,
+		.desc.enable_reg = DA9062AA_LDO2_CONT,
+		.desc.enable_mask = DA9062AA_LDO2_EN_MASK,
+		.desc.vsel_reg = DA9062AA_VLDO2_A,
+		.desc.vsel_mask = DA9062AA_VLDO2_A_MASK,
+		.desc.linear_min_sel = 0,
+		.sleep = REG_FIELD(DA9062AA_VLDO2_A,
+			__builtin_ffs((int)DA9062AA_LDO2_SL_A_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO2_SL_A_MASK)) - 1),
+		.suspend_sleep = REG_FIELD(DA9062AA_VLDO2_B,
+			__builtin_ffs((int)DA9062AA_LDO2_SL_B_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
+		.suspend_vsel_reg = DA9062AA_VLDO2_B,
+		.suspend = REG_FIELD(DA9062AA_DVC_1,
+			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
+		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
+			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO2_ILIM_MASK)) - 1),
+	},
+	{
+		.desc.id = DA9061_ID_LDO3,
+		.desc.name = "DA9061 LDO3",
+		.desc.of_match = of_match_ptr("ldo3"),
+		.desc.regulators_node = of_match_ptr("regulators"),
+		.desc.ops = &da9062_ldo_ops,
+		.desc.min_uV = (900) * 1000,
+		.desc.uV_step = (50) * 1000,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.enable_reg = DA9062AA_LDO3_CONT,
+		.desc.enable_mask = DA9062AA_LDO3_EN_MASK,
+		.desc.vsel_reg = DA9062AA_VLDO3_A,
+		.desc.vsel_mask = DA9062AA_VLDO3_A_MASK,
+		.desc.linear_min_sel = 0,
+		.sleep = REG_FIELD(DA9062AA_VLDO3_A,
+			__builtin_ffs((int)DA9062AA_LDO3_SL_A_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO3_SL_A_MASK)) - 1),
+		.suspend_sleep = REG_FIELD(DA9062AA_VLDO3_B,
+			__builtin_ffs((int)DA9062AA_LDO3_SL_B_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
+		.suspend_vsel_reg = DA9062AA_VLDO3_B,
+		.suspend = REG_FIELD(DA9062AA_DVC_1,
+			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
+		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
+			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO3_ILIM_MASK)) - 1),
+	},
+	{
+		.desc.id = DA9061_ID_LDO4,
+		.desc.name = "DA9061 LDO4",
+		.desc.of_match = of_match_ptr("ldo4"),
+		.desc.regulators_node = of_match_ptr("regulators"),
+		.desc.ops = &da9062_ldo_ops,
+		.desc.min_uV = (900) * 1000,
+		.desc.uV_step = (50) * 1000,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.enable_reg = DA9062AA_LDO4_CONT,
+		.desc.enable_mask = DA9062AA_LDO4_EN_MASK,
+		.desc.vsel_reg = DA9062AA_VLDO4_A,
+		.desc.vsel_mask = DA9062AA_VLDO4_A_MASK,
+		.desc.linear_min_sel = 0,
+		.sleep = REG_FIELD(DA9062AA_VLDO4_A,
+			__builtin_ffs((int)DA9062AA_LDO4_SL_A_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO4_SL_A_MASK)) - 1),
+		.suspend_sleep = REG_FIELD(DA9062AA_VLDO4_B,
+			__builtin_ffs((int)DA9062AA_LDO4_SL_B_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
+		.suspend_vsel_reg = DA9062AA_VLDO4_B,
+		.suspend = REG_FIELD(DA9062AA_DVC_1,
+			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
+		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
+			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz((DA9062AA_LDO4_ILIM_MASK)) - 1),
+	},
+};
+
+/* DA9062 Regulator information */
+static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 	{
 		.desc.id = DA9062_ID_BUCK1,
 		.desc.name = "DA9062 BUCK1",
@@ -727,17 +990,33 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	struct da9062_regulators *regulators;
 	struct da9062_regulator *regl;
 	struct regulator_config config = { };
+	const struct da9062_regulator_info *rinfo;
 	int irq, n, ret;
 	size_t size;
+	int max_regulators;
+
+	switch (chip->chip_type) {
+	case COMPAT_TYPE_DA9061:
+		max_regulators = DA9061_MAX_REGULATORS;
+		rinfo = local_da9061_regulator_info;
+		break;
+	case COMPAT_TYPE_DA9062:
+		max_regulators = DA9062_MAX_REGULATORS;
+		rinfo = local_da9062_regulator_info;
+		break;
+	default:
+		dev_err(chip->dev, "Unrecognised chip type\n");
+		return -ENODEV;
+	}
 
 	/* Allocate memory required by usable regulators */
 	size = sizeof(struct da9062_regulators) +
-		DA9062_MAX_REGULATORS * sizeof(struct da9062_regulator);
+		max_regulators * sizeof(struct da9062_regulator);
 	regulators = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
 	if (!regulators)
 		return -ENOMEM;
 
-	regulators->n_regulators = DA9062_MAX_REGULATORS;
+	regulators->n_regulators = max_regulators;
 	platform_set_drvdata(pdev, regulators);
 
 	n = 0;
@@ -745,7 +1024,7 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 		/* Initialise regulator structure */
 		regl = &regulators->regulator[n];
 		regl->hw = chip;
-		regl->info = &local_regulator_info[n];
+		regl->info = &rinfo[n];
 		regl->desc = regl->info->desc;
 		regl->desc.type = REGULATOR_VOLTAGE;
 		regl->desc.owner = THIS_MODULE;
@@ -836,6 +1115,6 @@ module_exit(da9062_regulator_cleanup);
 
 /* Module information */
 MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
-MODULE_DESCRIPTION("REGULATOR device driver for Dialog DA9062");
+MODULE_DESCRIPTION("REGULATOR device driver for Dialog DA9062 and DA9061");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:da9062-regulators");
-- 
2.11.0

