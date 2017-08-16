From: Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RESEND v9 02/12] mfd: rk808: add rk805 regs addr and ID
Date: Wed, 16 Aug 2017 09:56:58 +0800
Message-ID: <1502848628-27757-3-git-send-email-chenjh@rock-chips.com>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <rtc-linux+bncBAABBSONZ3GAKGQEJPOMYDY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1502848628-27757-1-git-send-email-chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wdc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Signed-off-by: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
