From: Joseph Chen <chenjh@rock-chips.com>
Subject: [RESEND v9 04/12] mfd: rk808: Add RK805 support
Date: Wed, 16 Aug 2017 09:57:00 +0800
Message-ID: <1502848628-27757-5-git-send-email-chenjh@rock-chips.com>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, zhangqing@rock-chips.com, robh+dt@kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, wdc@rock-chips.com, tony.xie@rock-chips.com, linux-input@vger.kernel.org, mark.rutland@arm.com, w.egorov@phytec.de, linux-clk@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, rtc-linux@googlegroups.com, Joseph Chen <chenjh@rock-chips.com>
List-Id: linux-input@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

The RK805 chip is a Power Management IC (PMIC) for multimedia and handheld
devices. It contains the following components:

    - Regulators
    - RTC
    - Clocking

Both RK808 and RK805 chips are using a similar register map,
so we can reuse the RTC and Clocking functionality.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig |   4 +-
 drivers/mfd/rk808.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 55ecdfb..b410a34 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -892,13 +892,13 @@ config MFD_RC5T583
 	  different functionality of the device.
 
 config MFD_RK808
-	tristate "Rockchip RK808/RK818 Power Management Chip"
+	tristate "Rockchip RK805/RK808/RK818 Power Management Chip"
 	depends on I2C && OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
 	help
-	  If you say yes here you get support for the RK808 and RK818
+	  If you say yes here you get support for the RK805, RK808 and RK818
 	  Power Management chips.
 	  This driver provides common support for accessing the device
 	  through I2C interface. The device supports multiple sub-devices
diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 8e60eba..18329c8 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -70,6 +70,14 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 	.volatile_reg = rk808_is_volatile_reg,
 };
 
+static const struct regmap_config rk805_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK805_OFF_SOURCE_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = rk808_is_volatile_reg,
+};
+
 static const struct regmap_config rk808_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -86,6 +94,16 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 };
 
+static const struct mfd_cell rk805s[] = {
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
+	{
+		.name = "rk808-rtc",
+		.num_resources = ARRAY_SIZE(rtc_resources),
+		.resources = &rtc_resources[0],
+	},
+};
+
 static const struct mfd_cell rk808s[] = {
 	{ .name = "rk808-clkout", },
 	{ .name = "rk808-regulator", },
@@ -106,6 +124,20 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 	},
 };
 
+static const struct rk808_reg_data rk805_pre_init_reg[] = {
+	{RK805_BUCK1_CONFIG_REG, RK805_BUCK1_2_ILMAX_MASK,
+				 RK805_BUCK1_2_ILMAX_4000MA},
+	{RK805_BUCK2_CONFIG_REG, RK805_BUCK1_2_ILMAX_MASK,
+				 RK805_BUCK1_2_ILMAX_4000MA},
+	{RK805_BUCK3_CONFIG_REG, RK805_BUCK3_4_ILMAX_MASK,
+				 RK805_BUCK3_ILMAX_3000MA},
+	{RK805_BUCK4_CONFIG_REG, RK805_BUCK3_4_ILMAX_MASK,
+				 RK805_BUCK4_ILMAX_3500MA},
+	{RK805_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK, BUCK_ILMIN_400MA},
+	{RK805_GPIO_IO_POL_REG, SLP_SD_MSK, SLEEP_FUN},
+	{RK805_THERMAL_REG, TEMP_HOTDIE_MSK, TEMP115C},
+};
+
 static const struct rk808_reg_data rk808_pre_init_reg[] = {
 	{ RK808_BUCK3_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_150MA },
 	{ RK808_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_200MA },
@@ -135,6 +167,41 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 						    VB_LO_SEL_3500MV },
 };
 
+static const struct regmap_irq rk805_irqs[] = {
+	[RK805_IRQ_PWRON_RISE] = {
+		.mask = RK805_IRQ_PWRON_RISE_MSK,
+		.reg_offset = 0,
+	},
+	[RK805_IRQ_VB_LOW] = {
+		.mask = RK805_IRQ_VB_LOW_MSK,
+		.reg_offset = 0,
+	},
+	[RK805_IRQ_PWRON] = {
+		.mask = RK805_IRQ_PWRON_MSK,
+		.reg_offset = 0,
+	},
+	[RK805_IRQ_PWRON_LP] = {
+		.mask = RK805_IRQ_PWRON_LP_MSK,
+		.reg_offset = 0,
+	},
+	[RK805_IRQ_HOTDIE] = {
+		.mask = RK805_IRQ_HOTDIE_MSK,
+		.reg_offset = 0,
+	},
+	[RK805_IRQ_RTC_ALARM] = {
+		.mask = RK805_IRQ_RTC_ALARM_MSK,
+		.reg_offset = 0,
+	},
+	[RK805_IRQ_RTC_PERIOD] = {
+		.mask = RK805_IRQ_RTC_PERIOD_MSK,
+		.reg_offset = 0,
+	},
+	[RK805_IRQ_PWRON_FALL] = {
+		.mask = RK805_IRQ_PWRON_FALL_MSK,
+		.reg_offset = 0,
+	},
+};
+
 static const struct regmap_irq rk808_irqs[] = {
 	/* INT_STS */
 	[RK808_IRQ_VOUT_LO] = {
@@ -247,6 +314,17 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 	},
 };
 
+static struct regmap_irq_chip rk805_irq_chip = {
+	.name = "rk805",
+	.irqs = rk805_irqs,
+	.num_irqs = ARRAY_SIZE(rk805_irqs),
+	.num_regs = 1,
+	.status_base = RK805_INT_STS_REG,
+	.mask_base = RK805_INT_STS_MSK_REG,
+	.ack_base = RK805_INT_STS_REG,
+	.init_ack_masked = true,
+};
+
 static const struct regmap_irq_chip rk808_irq_chip = {
 	.name = "rk808",
 	.irqs = rk808_irqs,
@@ -272,6 +350,25 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 };
 
 static struct i2c_client *rk808_i2c_client;
+
+static void rk805_device_shutdown(void)
+{
+	int ret;
+	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+
+	if (!rk808) {
+		dev_warn(&rk808_i2c_client->dev,
+			 "have no rk805, so do nothing here\n");
+		return;
+	}
+
+	ret = regmap_update_bits(rk808->regmap,
+				 RK805_DEV_CTRL_REG,
+				 DEV_OFF, DEV_OFF);
+	if (ret)
+		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+}
+
 static void rk808_device_shutdown(void)
 {
 	int ret;
@@ -309,6 +406,7 @@ static void rk818_device_shutdown(void)
 }
 
 static const struct of_device_id rk808_of_match[] = {
+	{ .compatible = "rockchip,rk805" },
 	{ .compatible = "rockchip,rk808" },
 	{ .compatible = "rockchip,rk818" },
 	{ },
@@ -352,6 +450,15 @@ static int rk808_probe(struct i2c_client *client,
 	dev_info(&client->dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
 
 	switch (rk808->variant) {
+	case RK805_ID:
+		rk808->regmap_cfg = &rk805_regmap_config;
+		rk808->regmap_irq_chip = &rk805_irq_chip;
+		pre_init_reg = rk805_pre_init_reg;
+		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
+		cells = rk805s;
+		nr_cells = ARRAY_SIZE(rk805s);
+		pm_pwroff_fn = rk805_device_shutdown;
+		break;
 	case RK808_ID:
 		rk808->regmap_cfg = &rk808_regmap_config;
 		rk808->regmap_irq_chip = &rk808_irq_chip;
@@ -444,6 +551,7 @@ static int rk808_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id rk808_ids[] = {
+	{ "rk805" },
 	{ "rk808" },
 	{ "rk818" },
 	{ },
-- 
1.9.1
