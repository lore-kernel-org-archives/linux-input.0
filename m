From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/4] input: mc13783: Make mc13xxx_buttons_platform_data more flexible
Date: Mon, 10 Feb 2014 08:22:09 +0400
Message-ID: <1392006129-10227-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp30.i.mail.ru ([94.100.177.90]:52208 "EHLO smtp30.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612AbaBJEWQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Feb 2014 23:22:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Alexander Shiyan <shc_work@mail.ru>

Instead of define each button in separate variable, make an array
for storing all buttons. This change will help to add support for
other types of PMIC and add support for probing with devicetree
in the future.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/mach-mx31moboard.c   |  9 ++++--
 drivers/input/misc/mc13783-pwrbutton.c | 56 +++++++++++++++++-----------------
 include/linux/mfd/mc13xxx.h            | 28 +++++++++--------
 3 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index b3738e6..7f13c47 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -276,9 +276,12 @@ static struct mc13xxx_leds_platform_data moboard_leds = {
 };
 
 static struct mc13xxx_buttons_platform_data moboard_buttons = {
-	.b1on_flags = MC13783_BUTTON_DBNC_750MS | MC13783_BUTTON_ENABLE |
-			MC13783_BUTTON_POL_INVERT,
-	.b1on_key = KEY_POWER,
+	.buttons[0] = {
+		.keycode	= KEY_POWER,
+		.flags		= MC13XXX_BUTTON_ENABLE |
+				  MC13XXX_BUTTON_DBNC_750MS |
+				  MC13XXX_BUTTON_POL_INVERT,
+	},
 };
 
 static struct mc13xxx_codec_platform_data moboard_codec = {
diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
index 0df6e8d..60be67a 100644
--- a/drivers/input/misc/mc13783-pwrbutton.c
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -36,7 +36,7 @@ struct mc13783_pwrb {
 #define MC13783_PWRB_B2_POL_INVERT	(1 << 1)
 #define MC13783_PWRB_B3_POL_INVERT	(1 << 2)
 	int flags;
-	unsigned short keymap[3];
+	unsigned short keymap[MAX13XXX_NUM_BUTTONS];
 };
 
 #define MC13783_REG_INTERRUPT_SENSE_1		5
@@ -116,24 +116,24 @@ static int mc13783_pwrbutton_probe(struct platform_device *pdev)
 		goto free_input_dev;
 	}
 
-	reg |= (pdata->b1on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON1BDBNC;
-	reg |= (pdata->b2on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON2BDBNC;
-	reg |= (pdata->b3on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON3BDBNC;
+	reg |= (pdata->buttons[0].flags & 0x3) << MC13783_POWER_CONTROL_2_ON1BDBNC;
+	reg |= (pdata->buttons[1].flags & 0x3) << MC13783_POWER_CONTROL_2_ON2BDBNC;
+	reg |= (pdata->buttons[2].flags & 0x3) << MC13783_POWER_CONTROL_2_ON3BDBNC;
 
 	priv->pwr = pwr;
 	priv->mc13783 = mc13783;
 
 	mc13xxx_lock(mc13783);
 
-	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE) {
-		priv->keymap[0] = pdata->b1on_key;
-		if (pdata->b1on_key != KEY_RESERVED)
-			__set_bit(pdata->b1on_key, pwr->keybit);
+	if (pdata->buttons[0].flags & MC13XXX_BUTTON_ENABLE) {
+		priv->keymap[0] = pdata->buttons[0].keycode;
+		if (priv->keymap[0] != KEY_RESERVED)
+			__set_bit(priv->keymap[0], pwr->keybit);
 
-		if (pdata->b1on_flags & MC13783_BUTTON_POL_INVERT)
+		if (pdata->buttons[0].flags & MC13XXX_BUTTON_POL_INVERT)
 			priv->flags |= MC13783_PWRB_B1_POL_INVERT;
 
-		if (pdata->b1on_flags & MC13783_BUTTON_RESET_EN)
+		if (pdata->buttons[0].flags & MC13XXX_BUTTON_RESET_EN)
 			reg |= MC13783_POWER_CONTROL_2_ON1BRSTEN;
 
 		err = mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD1,
@@ -144,15 +144,15 @@ static int mc13783_pwrbutton_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE) {
-		priv->keymap[1] = pdata->b2on_key;
-		if (pdata->b2on_key != KEY_RESERVED)
-			__set_bit(pdata->b2on_key, pwr->keybit);
+	if (pdata->buttons[1].flags & MC13XXX_BUTTON_ENABLE) {
+		priv->keymap[1] = pdata->buttons[1].keycode;
+		if (priv->keymap[1] != KEY_RESERVED)
+			__set_bit(priv->keymap[1], pwr->keybit);
 
-		if (pdata->b2on_flags & MC13783_BUTTON_POL_INVERT)
+		if (pdata->buttons[1].flags & MC13XXX_BUTTON_POL_INVERT)
 			priv->flags |= MC13783_PWRB_B2_POL_INVERT;
 
-		if (pdata->b2on_flags & MC13783_BUTTON_RESET_EN)
+		if (pdata->buttons[1].flags & MC13XXX_BUTTON_RESET_EN)
 			reg |= MC13783_POWER_CONTROL_2_ON2BRSTEN;
 
 		err = mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD2,
@@ -163,15 +163,15 @@ static int mc13783_pwrbutton_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE) {
-		priv->keymap[2] = pdata->b3on_key;
-		if (pdata->b3on_key != KEY_RESERVED)
-			__set_bit(pdata->b3on_key, pwr->keybit);
+	if (pdata->buttons[2].flags & MC13XXX_BUTTON_ENABLE) {
+		priv->keymap[2] = pdata->buttons[2].keycode;
+		if (priv->keymap[2] != KEY_RESERVED)
+			__set_bit(priv->keymap[2], pwr->keybit);
 
-		if (pdata->b3on_flags & MC13783_BUTTON_POL_INVERT)
+		if (pdata->buttons[2].flags & MC13XXX_BUTTON_POL_INVERT)
 			priv->flags |= MC13783_PWRB_B3_POL_INVERT;
 
-		if (pdata->b3on_flags & MC13783_BUTTON_RESET_EN)
+		if (pdata->buttons[2].flags & MC13XXX_BUTTON_RESET_EN)
 			reg |= MC13783_POWER_CONTROL_2_ON3BRSTEN;
 
 		err = mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD3,
@@ -208,15 +208,15 @@ static int mc13783_pwrbutton_probe(struct platform_device *pdev)
 free_irq:
 	mc13xxx_lock(mc13783);
 
-	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
+	if (pdata->buttons[2].flags & MC13XXX_BUTTON_ENABLE)
 		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD3, priv);
 
 free_irq_b2:
-	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
+	if (pdata->buttons[1].flags & MC13XXX_BUTTON_ENABLE)
 		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD2, priv);
 
 free_irq_b1:
-	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
+	if (pdata->buttons[0].flags & MC13XXX_BUTTON_ENABLE)
 		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD1, priv);
 
 free_priv:
@@ -238,11 +238,11 @@ static int mc13783_pwrbutton_remove(struct platform_device *pdev)
 
 	mc13xxx_lock(priv->mc13783);
 
-	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
+	if (pdata->buttons[2].flags & MC13XXX_BUTTON_ENABLE)
 		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD3, priv);
-	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
+	if (pdata->buttons[1].flags & MC13XXX_BUTTON_ENABLE)
 		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD2, priv);
-	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
+	if (pdata->buttons[0].flags & MC13XXX_BUTTON_ENABLE)
 		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD1, priv);
 
 	mc13xxx_unlock(priv->mc13783);
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index a326c85..4cedec4 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -172,20 +172,22 @@ struct mc13xxx_leds_platform_data {
 	u32 led_control[MAX_LED_CONTROL_REGS];
 };
 
+#define MAX13XXX_NUM_BUTTONS	3
+
+struct mc13xxx_button {
+	u16		keycode;
+	unsigned int	flags;
+#define MC13XXX_BUTTON_DBNC_0MS		0
+#define MC13XXX_BUTTON_DBNC_30MS	1
+#define MC13XXX_BUTTON_DBNC_150MS	2
+#define MC13XXX_BUTTON_DBNC_750MS	3
+#define MC13XXX_BUTTON_ENABLE		(1 << 2)
+#define MC13XXX_BUTTON_POL_INVERT	(1 << 3)
+#define MC13XXX_BUTTON_RESET_EN		(1 << 4)
+};
+
 struct mc13xxx_buttons_platform_data {
-#define MC13783_BUTTON_DBNC_0MS		0
-#define MC13783_BUTTON_DBNC_30MS	1
-#define MC13783_BUTTON_DBNC_150MS	2
-#define MC13783_BUTTON_DBNC_750MS	3
-#define MC13783_BUTTON_ENABLE		(1 << 2)
-#define MC13783_BUTTON_POL_INVERT	(1 << 3)
-#define MC13783_BUTTON_RESET_EN		(1 << 4)
-	int b1on_flags;
-	unsigned short b1on_key;
-	int b2on_flags;
-	unsigned short b2on_key;
-	int b3on_flags;
-	unsigned short b3on_key;
+	struct mc13xxx_button	buttons[MAX13XXX_NUM_BUTTONS];
 };
 
 struct mc13xxx_ts_platform_data {
-- 
1.8.3.2

