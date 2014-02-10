From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 3/4] input: mc13783: Prepare driver to support MC13892
Date: Mon, 10 Feb 2014 08:22:26 +0400
Message-ID: <1392006146-10379-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp14.mail.ru ([94.100.176.91]:36800 "EHLO smtp14.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbaBJEWa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Feb 2014 23:22:30 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Alexander Shiyan <shc_work@mail.ru>

This patch rewrite driver code to be ready to add support for
MC13892 buttons and probe from devicetree.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/misc/mc13783-pwrbutton.c | 311 +++++++++++++--------------------
 1 file changed, 120 insertions(+), 191 deletions(-)

diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
index a1e45235..f9e2bfb 100644
--- a/drivers/input/misc/mc13783-pwrbutton.c
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -23,245 +23,174 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/input.h>
-#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/mc13783.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-
-struct mc13783_pwrb {
-	struct input_dev *pwr;
-	struct mc13xxx *mc13783;
-#define MC13783_PWRB_B1_POL_INVERT	(1 << 0)
-#define MC13783_PWRB_B2_POL_INVERT	(1 << 1)
-#define MC13783_PWRB_B3_POL_INVERT	(1 << 2)
-	int flags;
-	unsigned short keymap[MAX13XXX_NUM_BUTTONS];
+
+struct mc13xxx_button_def {
+	unsigned int	irq;
+	unsigned int	sense_bit;
+};
+
+struct mc13xxx_pwrb_devtype {
+	struct mc13xxx_button_def	btn_def[MAX13XXX_NUM_BUTTONS];
 };
 
-#define MC13783_REG_INTERRUPT_SENSE_1		5
-#define MC13783_IRQSENSE1_ONOFD1S		(1 << 3)
-#define MC13783_IRQSENSE1_ONOFD2S		(1 << 4)
-#define MC13783_IRQSENSE1_ONOFD3S		(1 << 5)
+struct mc13xxx_pwrb {
+	struct mc13xxx_pwrb_devtype	*devtype;
+	unsigned int			enabled;
+	unsigned int			inverted;
+	u16				btn_code[MAX13XXX_NUM_BUTTONS];
+	struct input_dev		*input;
+	struct mc13xxx			*mc13xxx;
+};
 
-#define MC13783_REG_POWER_CONTROL_2		15
-#define MC13783_POWER_CONTROL_2_ON1BDBNC	4
-#define MC13783_POWER_CONTROL_2_ON2BDBNC	6
-#define MC13783_POWER_CONTROL_2_ON3BDBNC	8
-#define MC13783_POWER_CONTROL_2_ON1BRSTEN	(1 << 1)
-#define MC13783_POWER_CONTROL_2_ON2BRSTEN	(1 << 2)
-#define MC13783_POWER_CONTROL_2_ON3BRSTEN	(1 << 3)
+#define MC13XXX_REG_INTERRUPT_SENSE_1	5
+#define MC13XXX_REG_POWER_CONTROL_2	15
 
-static irqreturn_t button_irq(int irq, void *_priv)
+static irqreturn_t mc13xxx_pwrbutton_irq(int irq, void *data)
 {
-	struct mc13783_pwrb *priv = _priv;
-	int val;
-
-	mc13xxx_irq_ack(priv->mc13783, irq);
-	mc13xxx_reg_read(priv->mc13783, MC13783_REG_INTERRUPT_SENSE_1, &val);
-
-	switch (irq) {
-	case MC13783_IRQ_ONOFD1:
-		val = val & MC13783_IRQSENSE1_ONOFD1S ? 1 : 0;
-		if (priv->flags & MC13783_PWRB_B1_POL_INVERT)
-			val ^= 1;
-		input_report_key(priv->pwr, priv->keymap[0], val);
-		break;
-
-	case MC13783_IRQ_ONOFD2:
-		val = val & MC13783_IRQSENSE1_ONOFD2S ? 1 : 0;
-		if (priv->flags & MC13783_PWRB_B2_POL_INVERT)
-			val ^= 1;
-		input_report_key(priv->pwr, priv->keymap[1], val);
-		break;
-
-	case MC13783_IRQ_ONOFD3:
-		val = val & MC13783_IRQSENSE1_ONOFD3S ? 1 : 0;
-		if (priv->flags & MC13783_PWRB_B3_POL_INVERT)
-			val ^= 1;
-		input_report_key(priv->pwr, priv->keymap[2], val);
-		break;
-	}
-
-	input_sync(priv->pwr);
+	struct mc13xxx_pwrb *priv = data;
+	unsigned int i, val;
+
+	mc13xxx_irq_ack(priv->mc13xxx, irq);
+	mc13xxx_reg_read(priv->mc13xxx, MC13XXX_REG_INTERRUPT_SENSE_1, &val);
+
+	for (i = 0; i < MAX13XXX_NUM_BUTTONS; i++)
+		if (irq == priv->devtype->btn_def[i].irq) {
+			val = !!(val & priv->devtype->btn_def[i].sense_bit);
+			if (priv->inverted & BIT(i))
+				val = !val;
+			input_report_key(priv->input, priv->btn_code[i], val);
+			input_sync(priv->input);
+			break;
+		}
 
 	return IRQ_HANDLED;
 }
 
 static int __init mc13xxx_pwrbutton_probe(struct platform_device *pdev)
 {
-	const struct mc13xxx_buttons_platform_data *pdata;
-	struct mc13xxx *mc13783 = dev_get_drvdata(pdev->dev.parent);
-	struct input_dev *pwr;
-	struct mc13783_pwrb *priv;
-	int err = 0;
-	int reg = 0;
-
-	pdata = dev_get_platdata(&pdev->dev);
+	struct mc13xxx_buttons_platform_data *pdata =
+		dev_get_platdata(&pdev->dev);
+	struct mc13xxx *mc13xxx = dev_get_drvdata(pdev->dev.parent);
+	struct mc13xxx_pwrb_devtype *devtype =
+		(struct mc13xxx_pwrb_devtype *)pdev->id_entry->driver_data;
+	struct mc13xxx_pwrb *priv;
+	int i, reg = 0;
+
 	if (!pdata) {
 		dev_err(&pdev->dev, "missing platform data\n");
 		return -ENODEV;
 	}
 
-	pwr = input_allocate_device();
-	if (!pwr) {
-		dev_dbg(&pdev->dev, "Can't allocate power button\n");
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
-	}
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		err = -ENOMEM;
-		dev_dbg(&pdev->dev, "Can't allocate power button\n");
-		goto free_input_dev;
-	}
-
-	reg |= (pdata->buttons[0].flags & 0x3) << MC13783_POWER_CONTROL_2_ON1BDBNC;
-	reg |= (pdata->buttons[1].flags & 0x3) << MC13783_POWER_CONTROL_2_ON2BDBNC;
-	reg |= (pdata->buttons[2].flags & 0x3) << MC13783_POWER_CONTROL_2_ON3BDBNC;
 
-	priv->pwr = pwr;
-	priv->mc13783 = mc13783;
-
-	mc13xxx_lock(mc13783);
-
-	if (pdata->buttons[0].flags & MC13XXX_BUTTON_ENABLE) {
-		priv->keymap[0] = pdata->buttons[0].keycode;
-		if (priv->keymap[0] != KEY_RESERVED)
-			__set_bit(priv->keymap[0], pwr->keybit);
-
-		if (pdata->buttons[0].flags & MC13XXX_BUTTON_POL_INVERT)
-			priv->flags |= MC13783_PWRB_B1_POL_INVERT;
-
-		if (pdata->buttons[0].flags & MC13XXX_BUTTON_RESET_EN)
-			reg |= MC13783_POWER_CONTROL_2_ON1BRSTEN;
-
-		err = mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD1,
-					  button_irq, "b1on", priv);
-		if (err) {
-			dev_dbg(&pdev->dev, "Can't request irq\n");
-			goto free_priv;
-		}
-	}
-
-	if (pdata->buttons[1].flags & MC13XXX_BUTTON_ENABLE) {
-		priv->keymap[1] = pdata->buttons[1].keycode;
-		if (priv->keymap[1] != KEY_RESERVED)
-			__set_bit(priv->keymap[1], pwr->keybit);
-
-		if (pdata->buttons[1].flags & MC13XXX_BUTTON_POL_INVERT)
-			priv->flags |= MC13783_PWRB_B2_POL_INVERT;
+	priv->input = devm_input_allocate_device(&pdev->dev);
+	if (!priv->input)
+		return -ENOMEM;
 
-		if (pdata->buttons[1].flags & MC13XXX_BUTTON_RESET_EN)
-			reg |= MC13783_POWER_CONTROL_2_ON2BRSTEN;
+	priv->mc13xxx = mc13xxx;
+	priv->devtype = devtype;
+	platform_set_drvdata(pdev, priv);
 
-		err = mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD2,
-					  button_irq, "b2on", priv);
-		if (err) {
-			dev_dbg(&pdev->dev, "Can't request irq\n");
-			goto free_irq_b1;
-		}
+	for (i = 0; i < MAX13XXX_NUM_BUTTONS; i++) {
+		u16 code, invert, reset, debounce;
+
+		if (!(pdata->buttons[i].flags & MC13XXX_BUTTON_ENABLE))
+			continue;
+		code = pdata->buttons[i].keycode;
+		invert = !!(pdata->buttons[i].flags &
+			    MC13XXX_BUTTON_POL_INVERT);
+		reset = !!(pdata->buttons[i].flags &
+			   MC13XXX_BUTTON_RESET_EN);
+		debounce = pdata->buttons[i].flags;
+
+		priv->btn_code[i] = code;
+		if (code != KEY_RESERVED)
+			__set_bit(code, priv->input->keybit);
+
+		priv->enabled |= BIT(i);
+		priv->inverted |= invert << i;
+		reg |= reset << (i + 1);
+		reg |= (debounce & 0x03) << (4 + i * 2);
 	}
 
-	if (pdata->buttons[2].flags & MC13XXX_BUTTON_ENABLE) {
-		priv->keymap[2] = pdata->buttons[2].keycode;
-		if (priv->keymap[2] != KEY_RESERVED)
-			__set_bit(priv->keymap[2], pwr->keybit);
+	mc13xxx_lock(mc13xxx);
 
-		if (pdata->buttons[2].flags & MC13XXX_BUTTON_POL_INVERT)
-			priv->flags |= MC13783_PWRB_B3_POL_INVERT;
+	mc13xxx_reg_rmw(mc13xxx, MC13XXX_REG_POWER_CONTROL_2, 0x3fe, reg);
 
-		if (pdata->buttons[2].flags & MC13XXX_BUTTON_RESET_EN)
-			reg |= MC13783_POWER_CONTROL_2_ON3BRSTEN;
+	for (i = 0; i < MAX13XXX_NUM_BUTTONS; i++)
+		if (priv->enabled & BIT(i)) {
+			int ret;
 
-		err = mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD3,
-					  button_irq, "b3on", priv);
-		if (err) {
-			dev_dbg(&pdev->dev, "Can't request irq: %d\n", err);
-			goto free_irq_b2;
+			ret = mc13xxx_irq_request(mc13xxx,
+						  devtype->btn_def[i].irq,
+						  mc13xxx_pwrbutton_irq, NULL,
+						  priv);
+			if (ret) {
+				dev_err(&pdev->dev, "Can't request IRQ%i: %i\n",
+					devtype->btn_def[i].irq, ret);
+				priv->enabled &= ~BIT(i);
+			}
 		}
-	}
-
-	mc13xxx_reg_rmw(mc13783, MC13783_REG_POWER_CONTROL_2, 0x3FE, reg);
-
-	mc13xxx_unlock(mc13783);
-
-	pwr->name = "mc13783_pwrbutton";
-	pwr->phys = "mc13783_pwrbutton/input0";
-	pwr->dev.parent = &pdev->dev;
-
-	pwr->keycode = priv->keymap;
-	pwr->keycodemax = ARRAY_SIZE(priv->keymap);
-	pwr->keycodesize = sizeof(priv->keymap[0]);
-	__set_bit(EV_KEY, pwr->evbit);
-
-	err = input_register_device(pwr);
-	if (err) {
-		dev_dbg(&pdev->dev, "Can't register power button: %d\n", err);
-		goto free_irq;
-	}
-
-	platform_set_drvdata(pdev, priv);
-
-	return 0;
 
-free_irq:
-	mc13xxx_lock(mc13783);
+	mc13xxx_unlock(mc13xxx);
 
-	if (pdata->buttons[2].flags & MC13XXX_BUTTON_ENABLE)
-		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD3, priv);
+	priv->input->name		= pdev->name;
+	priv->input->dev.parent		= &pdev->dev;
+	priv->input->id.bustype		= BUS_HOST;
+	priv->input->id.vendor		= 0x0001;
+	priv->input->id.product		= 0x0001;
+	priv->input->id.version		= 0x0100;
+	priv->input->keycode		= priv->btn_code;
+	priv->input->keycodemax		= ARRAY_SIZE(priv->btn_code);
+	priv->input->keycodesize	= sizeof(priv->btn_code[0]);
+	__set_bit(EV_KEY, priv->input->evbit);
 
-free_irq_b2:
-	if (pdata->buttons[1].flags & MC13XXX_BUTTON_ENABLE)
-		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD2, priv);
+	input_set_drvdata(priv->input, priv);
 
-free_irq_b1:
-	if (pdata->buttons[0].flags & MC13XXX_BUTTON_ENABLE)
-		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD1, priv);
-
-free_priv:
-	mc13xxx_unlock(mc13783);
-	kfree(priv);
-
-free_input_dev:
-	input_free_device(pwr);
-
-	return err;
+	return input_register_device(priv->input);
 }
 
 static int mc13xxx_pwrbutton_remove(struct platform_device *pdev)
 {
-	struct mc13783_pwrb *priv = platform_get_drvdata(pdev);
-	const struct mc13xxx_buttons_platform_data *pdata;
-
-	pdata = dev_get_platdata(&pdev->dev);
-
-	mc13xxx_lock(priv->mc13783);
-
-	if (pdata->buttons[2].flags & MC13XXX_BUTTON_ENABLE)
-		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD3, priv);
-	if (pdata->buttons[1].flags & MC13XXX_BUTTON_ENABLE)
-		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD2, priv);
-	if (pdata->buttons[0].flags & MC13XXX_BUTTON_ENABLE)
-		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD1, priv);
+	struct mc13xxx_pwrb *priv = platform_get_drvdata(pdev);
+	int i;
 
-	mc13xxx_unlock(priv->mc13783);
-
-	input_unregister_device(priv->pwr);
-	kfree(priv);
+	mc13xxx_lock(priv->mc13xxx);
+	for (i = 0; i < MAX13XXX_NUM_BUTTONS; i++)
+		if (priv->enabled & BIT(i))
+			mc13xxx_irq_free(priv->mc13xxx,
+					 priv->devtype->btn_def[i].irq, priv);
+	mc13xxx_unlock(priv->mc13xxx);
 
 	return 0;
 }
 
+static const struct mc13xxx_pwrb_devtype mc13783_pwrb_devtype = {
+	.btn_def[0] = { MC13783_IRQ_ONOFD1, BIT(3), },
+	.btn_def[1] = { MC13783_IRQ_ONOFD2, BIT(4), },
+	.btn_def[2] = { MC13783_IRQ_ONOFD3, BIT(5), },
+};
+
+static const struct platform_device_id mc13xxx_pwrbutton_id_table[] = {
+	{ "mc13783-pwrbutton", (kernel_ulong_t)&mc13783_pwrb_devtype },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, mc13xxx_pwrbutton_id_table);
+
 static struct platform_driver mc13xxx_pwrbutton_driver = {
 	.driver		= {
-		.name	= "mc13783-pwrbutton",
+		.name	= "mc13xxx-pwrbutton",
 		.owner	= THIS_MODULE,
 	},
+	.id_table	= mc13xxx_pwrbutton_id_table,
 	.remove		= mc13xxx_pwrbutton_remove,
 };
 module_platform_driver_probe(mc13xxx_pwrbutton_driver, mc13xxx_pwrbutton_probe);
 
-MODULE_DESCRIPTION("MC13783 Power Button");
+MODULE_DESCRIPTION("MC13XXX Power Button");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Philippe Retornaz");
-- 
1.8.3.2

