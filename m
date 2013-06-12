From: Alexander Shiyan <shc_work@mail.ru>
Subject: [RFC] input: mc13783: Prepare driver to support MC13892 and OF
Date: Wed, 12 Jun 2013 17:55:20 +0400
Message-ID: <1371045320-12269-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:37435 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FLNzy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jun 2013 09:55:54 -0400
Received: from smtp19.mail.ru (smtp19.mail.ru [94.100.176.156])
	by fallback2.mail.ru (mPOP.Fallback_MX) with ESMTP id 84DEEDD70039
	for <linux-input@vger.kernel.org>; Wed, 12 Jun 2013 17:55:52 +0400 (MSK)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bill Pemberton <wfp5p@virginia.edu>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Alexander Shiyan <shc_work@mail.ru>

This is a complete rewritten driver for handle buttons on mc13xxx PMICs
and prepare to support probe via DT, so comments are welcome.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/misc/mc13783-pwrbutton.c | 327 +++++++++++++------------=
--------
 include/linux/mfd/mc13xxx.h            |  29 +--
 2 files changed, 146 insertions(+), 210 deletions(-)

diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/mis=
c/mc13783-pwrbutton.c
index d0277a7..d23235f 100644
--- a/drivers/input/misc/mc13783-pwrbutton.c
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -1,4 +1,6 @@
-/**
+/*
+ * Button driver for Freescale MC13783
+ *
  * Copyright (C) 2011 Philippe R=C3=A9tornaz
  *
  * Based on twl4030-pwrbutton driver by:
@@ -13,10 +15,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110-1=
335  USA
  */
=20
 #include <linux/module.h>
@@ -24,248 +22,183 @@
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
-	unsigned short keymap[3];
+
+struct mc13xxx_button_def {
+	int	irq;
+	int	sense_bit;
 };
=20
-#define MC13783_REG_INTERRUPT_SENSE_1		5
-#define MC13783_IRQSENSE1_ONOFD1S		(1 << 3)
-#define MC13783_IRQSENSE1_ONOFD2S		(1 << 4)
-#define MC13783_IRQSENSE1_ONOFD3S		(1 << 5)
+struct mc13xxx_pwrb_devtype {
+	struct mc13xxx_button_def	btn_def[MAX13XXX_NUM_BUTTONS];
+};
+
+struct mc13xxx_pwrb {
+	struct mc13xxx_pwrb_devtype	*devtype;
+	u32				irq_enabled;
+	u32				btn_inverted;
+	u16				btn_code[MAX13XXX_NUM_BUTTONS];
+	struct input_dev		*input;
+	struct mc13xxx			*mc13xxx;
+};
=20
-#define MC13783_REG_POWER_CONTROL_2		15
-#define MC13783_POWER_CONTROL_2_ON1BDBNC	4
-#define MC13783_POWER_CONTROL_2_ON2BDBNC	6
-#define MC13783_POWER_CONTROL_2_ON3BDBNC	8
-#define MC13783_POWER_CONTROL_2_ON1BRSTEN	(1 << 1)
-#define MC13783_POWER_CONTROL_2_ON2BRSTEN	(1 << 2)
-#define MC13783_POWER_CONTROL_2_ON3BRSTEN	(1 << 3)
+#define MC13XXX_REG_INTERRUPT_SENSE_1	5
+#define MC13XXX_REG_POWER_CONTROL_2	15
=20
-static irqreturn_t button_irq(int irq, void *_priv)
+static irqreturn_t mc13xxx_pwrbutton_irq(int irq, void *data)
 {
-	struct mc13783_pwrb *priv =3D _priv;
-	int val;
-
-	mc13xxx_irq_ack(priv->mc13783, irq);
-	mc13xxx_reg_read(priv->mc13783, MC13783_REG_INTERRUPT_SENSE_1, &val);
-
-	switch (irq) {
-	case MC13783_IRQ_ONOFD1:
-		val =3D val & MC13783_IRQSENSE1_ONOFD1S ? 1 : 0;
-		if (priv->flags & MC13783_PWRB_B1_POL_INVERT)
-			val ^=3D 1;
-		input_report_key(priv->pwr, priv->keymap[0], val);
-		break;
-
-	case MC13783_IRQ_ONOFD2:
-		val =3D val & MC13783_IRQSENSE1_ONOFD2S ? 1 : 0;
-		if (priv->flags & MC13783_PWRB_B2_POL_INVERT)
-			val ^=3D 1;
-		input_report_key(priv->pwr, priv->keymap[1], val);
-		break;
-
-	case MC13783_IRQ_ONOFD3:
-		val =3D val & MC13783_IRQSENSE1_ONOFD3S ? 1 : 0;
-		if (priv->flags & MC13783_PWRB_B3_POL_INVERT)
-			val ^=3D 1;
-		input_report_key(priv->pwr, priv->keymap[2], val);
-		break;
-	}
+	struct mc13xxx_pwrb *priv =3D data;
+	int i, val;
+
+	mc13xxx_irq_ack(priv->mc13xxx, irq);
+
+	mc13xxx_reg_read(priv->mc13xxx, MC13XXX_REG_INTERRUPT_SENSE_1, &val);
=20
-	input_sync(priv->pwr);
+	for (i =3D 0; i < MAX13XXX_NUM_BUTTONS; i++)
+		if (irq =3D=3D priv->devtype->btn_def[i].irq) {
+			val =3D !!(val & priv->devtype->btn_def[i].sense_bit);
+			if (priv->btn_inverted & (1 << i))
+				val ^=3D 1;
+			input_report_key(priv->input, priv->btn_code[i], val);
+			break;
+		}
+
+	input_sync(priv->input);
=20
 	return IRQ_HANDLED;
 }
=20
-static int mc13783_pwrbutton_probe(struct platform_device *pdev)
+static int __init mc13xxx_pwrbutton_probe(struct platform_device *pdev=
)
 {
-	const struct mc13xxx_buttons_platform_data *pdata;
-	struct mc13xxx *mc13783 =3D dev_get_drvdata(pdev->dev.parent);
-	struct input_dev *pwr;
-	struct mc13783_pwrb *priv;
-	int err =3D 0;
-	int reg =3D 0;
-
-	pdata =3D dev_get_platdata(&pdev->dev);
+	struct mc13xxx_buttons_platform_data *pdata =3D
+		dev_get_platdata(&pdev->dev);
+	struct mc13xxx *mc13xxx =3D dev_get_drvdata(pdev->dev.parent);
+	struct mc13xxx_pwrb_devtype *devtype =3D
+		(struct mc13xxx_pwrb_devtype *)pdev->id_entry->driver_data;
+	struct mc13xxx_pwrb *priv;
+	int i, ret =3D 0, reg =3D 0;
+
 	if (!pdata) {
-		dev_err(&pdev->dev, "missing platform data\n");
+		dev_err(&pdev->dev, "Missing platform data\n");
 		return -ENODEV;
 	}
=20
-	pwr =3D input_allocate_device();
-	if (!pwr) {
-		dev_dbg(&pdev->dev, "Can't allocate power button\n");
+	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
-	}
=20
-	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		err =3D -ENOMEM;
+	priv->input =3D devm_input_allocate_device(&pdev->dev);
+	if (!priv->input) {
 		dev_dbg(&pdev->dev, "Can't allocate power button\n");
-		goto free_input_dev;
-	}
-
-	reg |=3D (pdata->b1on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON1BDBN=
C;
-	reg |=3D (pdata->b2on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON2BDBN=
C;
-	reg |=3D (pdata->b3on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON3BDBN=
C;
-
-	priv->pwr =3D pwr;
-	priv->mc13783 =3D mc13783;
-
-	mc13xxx_lock(mc13783);
-
-	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE) {
-		priv->keymap[0] =3D pdata->b1on_key;
-		if (pdata->b1on_key !=3D KEY_RESERVED)
-			__set_bit(pdata->b1on_key, pwr->keybit);
-
-		if (pdata->b1on_flags & MC13783_BUTTON_POL_INVERT)
-			priv->flags |=3D MC13783_PWRB_B1_POL_INVERT;
-
-		if (pdata->b1on_flags & MC13783_BUTTON_RESET_EN)
-			reg |=3D MC13783_POWER_CONTROL_2_ON1BRSTEN;
-
-		err =3D mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD1,
-					  button_irq, "b1on", priv);
-		if (err) {
-			dev_dbg(&pdev->dev, "Can't request irq\n");
-			goto free_priv;
-		}
+		return -ENOMEM;
 	}
=20
-	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE) {
-		priv->keymap[1] =3D pdata->b2on_key;
-		if (pdata->b2on_key !=3D KEY_RESERVED)
-			__set_bit(pdata->b2on_key, pwr->keybit);
-
-		if (pdata->b2on_flags & MC13783_BUTTON_POL_INVERT)
-			priv->flags |=3D MC13783_PWRB_B2_POL_INVERT;
-
-		if (pdata->b2on_flags & MC13783_BUTTON_RESET_EN)
-			reg |=3D MC13783_POWER_CONTROL_2_ON2BRSTEN;
-
-		err =3D mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD2,
-					  button_irq, "b2on", priv);
-		if (err) {
-			dev_dbg(&pdev->dev, "Can't request irq\n");
-			goto free_irq_b1;
-		}
-	}
+	priv->mc13xxx =3D mc13xxx;
+	priv->devtype =3D devtype;
+	platform_set_drvdata(pdev, priv);
=20
-	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE) {
-		priv->keymap[2] =3D pdata->b3on_key;
-		if (pdata->b3on_key !=3D KEY_RESERVED)
-			__set_bit(pdata->b3on_key, pwr->keybit);
+	mc13xxx_lock(mc13xxx);
+	for (i =3D 0; i < MAX13XXX_NUM_BUTTONS; i++) {
+		u16 keycode =3D pdata->buttons[i].keycode;
+		int reset =3D pdata->buttons[i].reset;
+		int debounce =3D pdata->buttons[i].debounce;
=20
-		if (pdata->b3on_flags & MC13783_BUTTON_POL_INVERT)
-			priv->flags |=3D MC13783_PWRB_B3_POL_INVERT;
+		if (!pdata->buttons[i].enabled)
+			continue;
=20
-		if (pdata->b3on_flags & MC13783_BUTTON_RESET_EN)
-			reg |=3D MC13783_POWER_CONTROL_2_ON3BRSTEN;
+		priv->btn_code[i] =3D keycode;
+		if (priv->btn_code[i] !=3D KEY_RESERVED)
+			__set_bit(priv->btn_code[i], priv->input->keybit);
=20
-		err =3D mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD3,
-					  button_irq, "b3on", priv);
-		if (err) {
-			dev_dbg(&pdev->dev, "Can't request irq: %d\n", err);
-			goto free_irq_b2;
+		ret =3D mc13xxx_irq_request(mc13xxx, devtype->btn_def[i].irq,
+					  mc13xxx_pwrbutton_irq, NULL, priv);
+		if (ret) {
+			dev_dbg(&pdev->dev, "Can't request IRQ: %i\n", ret);
+			break;
 		}
-	}
-
-	mc13xxx_reg_rmw(mc13783, MC13783_REG_POWER_CONTROL_2, 0x3FE, reg);
-
-	mc13xxx_unlock(mc13783);
-
-	pwr->name =3D "mc13783_pwrbutton";
-	pwr->phys =3D "mc13783_pwrbutton/input0";
-	pwr->dev.parent =3D &pdev->dev;
=20
-	pwr->keycode =3D priv->keymap;
-	pwr->keycodemax =3D ARRAY_SIZE(priv->keymap);
-	pwr->keycodesize =3D sizeof(priv->keymap[0]);
-	__set_bit(EV_KEY, pwr->evbit);
-
-	err =3D input_register_device(pwr);
-	if (err) {
-		dev_dbg(&pdev->dev, "Can't register power button: %d\n", err);
-		goto free_irq;
+		priv->irq_enabled |=3D 1 << i;
+		reg |=3D reset ? (1 < (i + 1)) : 0;
+		reg |=3D debounce << (4 + i * 2);
 	}
=20
-	platform_set_drvdata(pdev, priv);
+	if (ret)
+		goto err_irq;
=20
-	return 0;
+	mc13xxx_reg_rmw(mc13xxx, MC13XXX_REG_POWER_CONTROL_2, 0x3fe, reg);
=20
-free_irq:
-	mc13xxx_lock(mc13783);
+	mc13xxx_unlock(mc13xxx);
=20
-	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
-		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD3, priv);
+	priv->input->name		=3D "mc13xxx_pwrbutton";
+	priv->input->phys		=3D "mc13xxx_pwrbutton/input0";
+	priv->input->dev.parent		=3D &pdev->dev;
+	priv->input->id.bustype		=3D BUS_HOST;
+	priv->input->id.vendor		=3D 0x0001;
+	priv->input->id.product		=3D 0x0001;
+	priv->input->id.version		=3D 0x0100;
+	priv->input->keycode		=3D priv->btn_code;
+	priv->input->keycodemax		=3D ARRAY_SIZE(priv->btn_code);
+	priv->input->keycodesize	=3D sizeof(priv->btn_code[0]);
+	__set_bit(EV_KEY, priv->input->evbit);
=20
-free_irq_b2:
-	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
-		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD2, priv);
+	ret =3D input_register_device(priv->input);
+	if (!ret)
+		return 0;
=20
-free_irq_b1:
-	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
-		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD1, priv);
+	dev_dbg(&pdev->dev, "Can't register power button: %i\n", ret);
=20
-free_priv:
-	mc13xxx_unlock(mc13783);
-	kfree(priv);
+	mc13xxx_lock(mc13xxx);
=20
-free_input_dev:
-	input_free_device(pwr);
+err_irq:
+	for (i =3D 0; i < MAX13XXX_NUM_BUTTONS; i++)
+		if (priv->irq_enabled & (1 << i))
+			mc13xxx_irq_free(priv->mc13xxx,
+					 devtype->btn_def[i].irq, priv);
+	mc13xxx_unlock(mc13xxx);
=20
-	return err;
+	return ret;
 }
=20
-static int mc13783_pwrbutton_remove(struct platform_device *pdev)
+static int mc13xxx_pwrbutton_remove(struct platform_device *pdev)
 {
-	struct mc13783_pwrb *priv =3D platform_get_drvdata(pdev);
-	const struct mc13xxx_buttons_platform_data *pdata;
-
-	pdata =3D dev_get_platdata(&pdev->dev);
-
-	mc13xxx_lock(priv->mc13783);
-
-	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
-		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD3, priv);
-	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
-		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD2, priv);
-	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
-		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD1, priv);
+	struct mc13xxx_pwrb *priv =3D platform_get_drvdata(pdev);
+	int i;
=20
-	mc13xxx_unlock(priv->mc13783);
+	mc13xxx_lock(priv->mc13xxx);
+	for (i =3D 0; i < MAX13XXX_NUM_BUTTONS; i++)
+		if (priv->irq_enabled & (1 << i))
+			mc13xxx_irq_free(priv->mc13xxx,
+					 priv->devtype->btn_def[i].irq, priv);
+	mc13xxx_unlock(priv->mc13xxx);
=20
-	input_unregister_device(priv->pwr);
-	kfree(priv);
+	input_unregister_device(priv->input);
=20
 	return 0;
 }
=20
-static struct platform_driver mc13783_pwrbutton_driver =3D {
-	.probe		=3D mc13783_pwrbutton_probe,
-	.remove		=3D mc13783_pwrbutton_remove,
-	.driver		=3D {
-		.name	=3D "mc13783-pwrbutton",
+static const struct mc13xxx_pwrb_devtype mc13783_pwrb_devtype =3D {
+	.btn_def[0] =3D { MC13783_IRQ_ONOFD1, (1 << 3) },
+	.btn_def[1] =3D { MC13783_IRQ_ONOFD2, (1 << 4) },
+	.btn_def[2] =3D { MC13783_IRQ_ONOFD3, (1 << 5) }
+};
+
+static const struct platform_device_id mc13xxx_pwrbutton_id_table[] =3D=
 {
+	{ "mc13783-pwrbutton", (kernel_ulong_t)&mc13783_pwrb_devtype },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, mc13xxx_pwrbutton_id_table);
+
+static struct platform_driver mc13xxx_pwrbutton_driver =3D {
+	.driver	=3D {
+		.name	=3D "mc13xxx-pwrbutton",
 		.owner	=3D THIS_MODULE,
 	},
+	.remove		=3D mc13xxx_pwrbutton_remove,
+	.id_table	=3D mc13xxx_pwrbutton_id_table,
 };
+module_platform_driver_probe(mc13xxx_pwrbutton_driver, mc13xxx_pwrbutt=
on_probe);
=20
-module_platform_driver(mc13783_pwrbutton_driver);
-
-MODULE_ALIAS("platform:mc13783-pwrbutton");
-MODULE_DESCRIPTION("MC13783 Power Button");
+MODULE_DESCRIPTION("Button driver for Freescale MC13XXX PMIC");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Philippe Retornaz");
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 41ed592..f737240 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -142,20 +142,23 @@ struct mc13xxx_leds_platform_data {
 	u32 led_control[MAX_LED_CONTROL_REGS];
 };
=20
+#define MAX13XXX_NUM_BUTTONS	3
+
+struct mc13xxx_button {
+	int	enabled:1;
+	int	inverted:1;
+	int	reset:1;
+	int	debounce:2;
+	u16	keycode;
+};
+
+#define MC13XXX_BUTTON_DBNC_0MS		0
+#define MC13XXX_BUTTON_DBNC_30MS	1
+#define MC13XXX_BUTTON_DBNC_150MS	2
+#define MC13XXX_BUTTON_DBNC_750MS	3
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
=20
 struct mc13xxx_ts_platform_data {
--=20
1.8.1.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
