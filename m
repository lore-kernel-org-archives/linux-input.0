From: Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH v7 02/12] mfd: rk808: add rk805 regs addr and ID
Date: Fri, 21 Jul 2017 19:14:31 +0800
Message-ID: <1500635681-12477-3-git-send-email-chenjh@rock-chips.com>
References: <1500635681-12477-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500635681-12477-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, tony.xie@rock-chips.com, zhangqing@rock-chips.com, wdc@rock-chips.com, devicetree@vger.kernel.org, w.egorov@phytec.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/linux/mfd/rk808.h | 120 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 54feb14..d315659 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -206,6 +206,97 @@ enum rk818_reg {
 #define RK818_USB_ILMIN_2000MA		0x7
 #define RK818_USB_CHG_SD_VSEL_MASK	0x70
 
+/* RK805 */
+enum rk805_reg {
+	RK805_ID_DCDC1,
+	RK805_ID_DCDC2,
+	RK805_ID_DCDC3,
+	RK805_ID_DCDC4,
+	RK805_ID_LDO1,
+	RK805_ID_LDO2,
+	RK805_ID_LDO3,
+};
+
+/* CONFIG REGISTER */
+#define RK805_VB_MON_REG		0x21
+#define RK805_THERMAL_REG		0x22
+
+/* POWER CHANNELS ENABLE REGISTER */
+#define RK805_DCDC_EN_REG		0x23
+#define RK805_SLP_DCDC_EN_REG		0x25
+#define RK805_SLP_LDO_EN_REG		0x26
+#define RK805_LDO_EN_REG		0x27
+
+/* BUCK AND LDO CONFIG REGISTER */
+#define RK805_BUCK_LDO_SLP_LP_EN_REG	0x2A
+#define RK805_BUCK1_CONFIG_REG		0x2E
+#define RK805_BUCK1_ON_VSEL_REG		0x2F
+#define RK805_BUCK1_SLP_VSEL_REG	0x30
+#define RK805_BUCK2_CONFIG_REG		0x32
+#define RK805_BUCK2_ON_VSEL_REG		0x33
+#define RK805_BUCK2_SLP_VSEL_REG	0x34
+#define RK805_BUCK3_CONFIG_REG		0x36
+#define RK805_BUCK4_CONFIG_REG		0x37
+#define RK805_BUCK4_ON_VSEL_REG		0x38
+#define RK805_BUCK4_SLP_VSEL_REG	0x39
+#define RK805_LDO1_ON_VSEL_REG		0x3B
+#define RK805_LDO1_SLP_VSEL_REG		0x3C
+#define RK805_LDO2_ON_VSEL_REG		0x3D
+#define RK805_LDO2_SLP_VSEL_REG		0x3E
+#define RK805_LDO3_ON_VSEL_REG		0x3F
+#define RK805_LDO3_SLP_VSEL_REG		0x40
+
+/* INTERRUPT REGISTER */
+#define RK805_PWRON_LP_INT_TIME_REG	0x47
+#define RK805_PWRON_DB_REG		0x48
+#define RK805_DEV_CTRL_REG		0x4B
+#define RK805_INT_STS_REG		0x4C
+#define RK805_INT_STS_MSK_REG		0x4D
+#define RK805_GPIO_IO_POL_REG		0x50
+#define RK805_OUT_REG			0x52
+#define RK805_ON_SOURCE_REG		0xAE
+#define RK805_OFF_SOURCE_REG		0xAF
+
+#define RK805_NUM_REGULATORS		7
+
+#define RK805_PWRON_FALL_RISE_INT_EN	0x0
+#define RK805_PWRON_FALL_RISE_INT_MSK	0x81
+
+/* RK805 IRQ Definitions */
+#define RK805_IRQ_PWRON_RISE		0
+#define RK805_IRQ_VB_LOW		1
+#define RK805_IRQ_PWRON			2
+#define RK805_IRQ_PWRON_LP		3
+#define RK805_IRQ_HOTDIE		4
+#define RK805_IRQ_RTC_ALARM		5
+#define RK805_IRQ_RTC_PERIOD		6
+#define RK805_IRQ_PWRON_FALL		7
+
+#define RK805_IRQ_PWRON_RISE_MSK	BIT(0)
+#define RK805_IRQ_VB_LOW_MSK		BIT(1)
+#define RK805_IRQ_PWRON_MSK		BIT(2)
+#define RK805_IRQ_PWRON_LP_MSK		BIT(3)
+#define RK805_IRQ_HOTDIE_MSK		BIT(4)
+#define RK805_IRQ_RTC_ALARM_MSK		BIT(5)
+#define RK805_IRQ_RTC_PERIOD_MSK	BIT(6)
+#define RK805_IRQ_PWRON_FALL_MSK	BIT(7)
+
+#define RK805_PWR_RISE_INT_STATUS	BIT(0)
+#define RK805_VB_LOW_INT_STATUS		BIT(1)
+#define RK805_PWRON_INT_STATUS		BIT(2)
+#define RK805_PWRON_LP_INT_STATUS	BIT(3)
+#define RK805_HOTDIE_INT_STATUS		BIT(4)
+#define RK805_ALARM_INT_STATUS		BIT(5)
+#define RK805_PERIOD_INT_STATUS		BIT(6)
+#define RK805_PWR_FALL_INT_STATUS	BIT(7)
+
+#define RK805_BUCK1_2_ILMAX_MASK	(3 << 6)
+#define RK805_BUCK3_4_ILMAX_MASK        (3 << 3)
+#define RK805_RTC_PERIOD_INT_MASK	(1 << 6)
+#define RK805_RTC_ALARM_INT_MASK	(1 << 5)
+#define RK805_INT_ALARM_EN		(1 << 3)
+#define RK805_INT_TIMER_EN		(1 << 2)
+
 /* RK808 IRQ Definitions */
 #define RK808_IRQ_VOUT_LO	0
 #define RK808_IRQ_VB_LO		1
@@ -298,7 +389,14 @@ enum rk818_reg {
 #define VOUT_LO_INT	BIT(0)
 #define CLK32KOUT2_EN	BIT(0)
 
+#define TEMP115C			0x0c
+#define TEMP_HOTDIE_MSK			0x0c
+#define SLP_SD_MSK			(0x3 << 2)
+#define SHUTDOWN_FUN			(0x2 << 2)
+#define SLEEP_FUN			(0x1 << 2)
 #define RK8XX_ID_MSK			0xfff0
+#define FPWM_MODE			BIT(7)
+
 enum {
 	BUCK_ILMIN_50MA,
 	BUCK_ILMIN_100MA,
@@ -322,6 +420,28 @@ enum {
 };
 
 enum {
+	RK805_BUCK1_2_ILMAX_2500MA,
+	RK805_BUCK1_2_ILMAX_3000MA,
+	RK805_BUCK1_2_ILMAX_3500MA,
+	RK805_BUCK1_2_ILMAX_4000MA,
+};
+
+enum {
+	RK805_BUCK3_ILMAX_1500MA,
+	RK805_BUCK3_ILMAX_2000MA,
+	RK805_BUCK3_ILMAX_2500MA,
+	RK805_BUCK3_ILMAX_3000MA,
+};
+
+enum {
+	RK805_BUCK4_ILMAX_2000MA,
+	RK805_BUCK4_ILMAX_2500MA,
+	RK805_BUCK4_ILMAX_3000MA,
+	RK805_BUCK4_ILMAX_3500MA,
+};
+
+enum {
+	RK805_ID = 0x8050,
 	RK808_ID = 0x0000,
 	RK818_ID = 0x8181,
 };
-- 
1.9.1
