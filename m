From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 5/6] mc13783: add power button support
Date: Fri, 22 Jul 2011 16:17:11 +0200
Message-ID: <1311344232-29902-6-git-send-email-philippe.retornaz@epfl.ch>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-2-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-3-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-4-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-5-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.epfl.ch ([128.178.224.226]:59344 "HELO smtp3.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754286Ab1GVORY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 10:17:24 -0400
In-Reply-To: <1311344232-29902-5-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch, gaowanlong@cn.fujitsu.com, shawn.guo@freescale.com

This adds support for the power-on buttons of MC13783 PMIC.
This is done using a misc input device.

Signed-off-by: Philippe R=C3=A9tornaz <philippe.retornaz@epfl.ch>
Acked-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/Kconfig             |   10 +
 drivers/input/misc/Makefile            |    1 +
 drivers/input/misc/mc13783-pwrbutton.c |  282 ++++++++++++++++++++++++=
++++++++
 drivers/mfd/mc13xxx-core.c             |    9 +
 include/linux/mfd/mc13783.h            |    1 +
 include/linux/mfd/mc13xxx.h            |   17 ++
 6 files changed, 320 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/mc13783-pwrbutton.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 45dc6aa..4272658 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -100,6 +100,16 @@ config INPUT_MAX8925_ONKEY
 	  To compile this driver as a module, choose M here: the module
 	  will be called max8925_onkey.
=20
+config INPUT_MC13783_PWRBUTTON
+	tristate "MC13783 ON buttons"
+	depends on MFD_MC13783
+	help
+	  Support the ON buttons of MC13783 PMIC as an input device
+	  reporting power button status.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mc13783-pwrbutton.
+
 config INPUT_APANEL
 	tristate "Fujitsu Lifebook Application Panel buttons"
 	depends on X86 && I2C && LEDS_CLASS
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 38efb2c..ecced4c 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+=3D ixp4xx-beeper.=
o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+=3D keyspan_remote.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+=3D m68kspkr.o
 obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+=3D max8925_onkey.o
+obj-$(CONFIG_INPUT_MC13783_PWRBUTTON)	+=3D mc13783-pwrbutton.o
 obj-$(CONFIG_INPUT_PCAP)		+=3D pcap_keys.o
 obj-$(CONFIG_INPUT_PCF50633_PMU)	+=3D pcf50633-input.o
 obj-$(CONFIG_INPUT_PCF8574)		+=3D pcf8574_keypad.o
diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/mis=
c/mc13783-pwrbutton.c
new file mode 100644
index 0000000..09b0522
--- /dev/null
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -0,0 +1,282 @@
+/**
+ * Copyright (C) 2011 Philippe R=C3=A9tornaz
+ *
+ * Based on twl4030-pwrbutton driver by:
+ *     Peter De Schrijver <peter.de-schrijver@nokia.com>
+ *     Felipe Balbi <felipe.balbi@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of thi=
s
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110-1=
335  USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/mc13783.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+struct mc13783_pwrb {
+	struct input_dev *pwr;
+	struct mc13xxx *mc13783;
+#define MC13783_PWRB_B1_POL_INVERT	(1 << 0)
+#define MC13783_PWRB_B2_POL_INVERT	(1 << 1)
+#define MC13783_PWRB_B3_POL_INVERT	(1 << 2)
+	int flags;
+	unsigned short keymap[3];
+};
+
+#define MC13783_REG_INTERRUPT_SENSE_1		5
+#define MC13783_IRQSENSE1_ONOFD1S		(1 << 3)
+#define MC13783_IRQSENSE1_ONOFD2S		(1 << 4)
+#define MC13783_IRQSENSE1_ONOFD3S		(1 << 5)
+
+#define MC13783_REG_POWER_CONTROL_2		15
+#define MC13783_POWER_CONTROL_2_ON1BDBNC	4
+#define MC13783_POWER_CONTROL_2_ON2BDBNC	6
+#define MC13783_POWER_CONTROL_2_ON3BDBNC	8
+#define MC13783_POWER_CONTROL_2_ON1BRSTEN	(1 << 1)
+#define MC13783_POWER_CONTROL_2_ON2BRSTEN	(1 << 2)
+#define MC13783_POWER_CONTROL_2_ON3BRSTEN	(1 << 3)
+
+static irqreturn_t button_irq(int irq, void *_priv)
+{
+	struct mc13783_pwrb *priv =3D _priv;
+	int val;
+
+	mc13xxx_irq_ack(priv->mc13783, irq);
+	mc13xxx_reg_read(priv->mc13783, MC13783_REG_INTERRUPT_SENSE_1, &val);
+
+	switch (irq) {
+	case MC13783_IRQ_ONOFD1:
+		val =3D val & MC13783_IRQSENSE1_ONOFD1S ? 1 : 0;
+		if (priv->flags & MC13783_PWRB_B1_POL_INVERT)
+			val ^=3D 1;
+		input_report_key(priv->pwr, priv->keymap[0], val);
+		break;
+
+	case MC13783_IRQ_ONOFD2:
+		val =3D val & MC13783_IRQSENSE1_ONOFD2S ? 1 : 0;
+		if (priv->flags & MC13783_PWRB_B2_POL_INVERT)
+			val ^=3D 1;
+		input_report_key(priv->pwr, priv->keymap[1], val);
+		break;
+
+	case MC13783_IRQ_ONOFD3:
+		val =3D val & MC13783_IRQSENSE1_ONOFD3S ? 1 : 0;
+		if (priv->flags & MC13783_PWRB_B3_POL_INVERT)
+			val ^=3D 1;
+		input_report_key(priv->pwr, priv->keymap[2], val);
+		break;
+	}
+
+	input_sync(priv->pwr);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit mc13783_pwrbutton_probe(struct platform_device *p=
dev)
+{
+	const struct mc13xxx_buttons_platform_data *pdata;
+	struct mc13xxx *mc13783 =3D dev_get_drvdata(pdev->dev.parent);
+	struct input_dev *pwr;
+	struct mc13783_pwrb *priv;
+	int err =3D 0;
+	int reg =3D 0;
+
+	pdata =3D dev_get_platdata(&pdev->dev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "missing platform data\n");
+		return -ENODEV;
+	}
+
+	pwr =3D input_allocate_device();
+	if (!pwr) {
+		dev_dbg(&pdev->dev, "Can't allocate power button\n");
+		return -ENOMEM;
+	}
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		err =3D -ENOMEM;
+		dev_dbg(&pdev->dev, "Can't allocate power button\n");
+		goto free_input_dev;
+	}
+
+	reg |=3D (pdata->b1on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON1BDBN=
C;
+	reg |=3D (pdata->b2on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON2BDBN=
C;
+	reg |=3D (pdata->b3on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON3BDBN=
C;
+
+	priv->pwr =3D pwr;
+	priv->mc13783 =3D mc13783;
+
+	mc13xxx_lock(mc13783);
+
+	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE) {
+		priv->keymap[0] =3D pdata->b1on_key;
+		if (pdata->b1on_key !=3D KEY_RESERVED)
+			__set_bit(pdata->b1on_key, pwr->keybit);
+
+		if (pdata->b1on_flags & MC13783_BUTTON_POL_INVERT)
+			priv->flags |=3D MC13783_PWRB_B1_POL_INVERT;
+
+		if (pdata->b1on_flags & MC13783_BUTTON_RESET_EN)
+			reg |=3D MC13783_POWER_CONTROL_2_ON1BRSTEN;
+
+		err =3D mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD1,
+					  button_irq, "b1on", priv);
+		if (err) {
+			dev_dbg(&pdev->dev, "Can't request irq\n");
+			goto free_priv;
+		}
+	}
+
+	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE) {
+		priv->keymap[1] =3D pdata->b2on_key;
+		if (pdata->b2on_key !=3D KEY_RESERVED)
+			__set_bit(pdata->b2on_key, pwr->keybit);
+
+		if (pdata->b2on_flags & MC13783_BUTTON_POL_INVERT)
+			priv->flags |=3D MC13783_PWRB_B2_POL_INVERT;
+
+		if (pdata->b2on_flags & MC13783_BUTTON_RESET_EN)
+			reg |=3D MC13783_POWER_CONTROL_2_ON2BRSTEN;
+
+		err =3D mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD2,
+					  button_irq, "b2on", priv);
+		if (err) {
+			dev_dbg(&pdev->dev, "Can't request irq\n");
+			goto free_irq_b1;
+		}
+	}
+
+	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE) {
+		priv->keymap[2] =3D pdata->b3on_key;
+		if (pdata->b3on_key !=3D KEY_RESERVED)
+			__set_bit(pdata->b3on_key, pwr->keybit);
+
+		if (pdata->b3on_flags & MC13783_BUTTON_POL_INVERT)
+			priv->flags |=3D MC13783_PWRB_B3_POL_INVERT;
+
+		if (pdata->b3on_flags & MC13783_BUTTON_RESET_EN)
+			reg |=3D MC13783_POWER_CONTROL_2_ON3BRSTEN;
+
+		err =3D mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD3,
+					  button_irq, "b3on", priv);
+		if (err) {
+			dev_dbg(&pdev->dev, "Can't request irq: %d\n", err);
+			goto free_irq_b2;
+		}
+	}
+
+	mc13xxx_reg_rmw(mc13783, MC13783_REG_POWER_CONTROL_2, 0x3FE, reg);
+
+	mc13xxx_unlock(mc13783);
+
+	pwr->name =3D "mc13783_pwrbutton";
+	pwr->phys =3D "mc13783_pwrbutton/input0";
+	pwr->dev.parent =3D &pdev->dev;
+
+	pwr->keycode =3D priv->keymap;
+	pwr->keycodemax =3D ARRAY_SIZE(priv->keymap);
+	pwr->keycodesize =3D sizeof(priv->keymap[0]);
+	__set_bit(EV_KEY, pwr->evbit);
+
+	err =3D input_register_device(pwr);
+	if (err) {
+		dev_dbg(&pdev->dev, "Can't register power button: %d\n", err);
+		goto free_irq;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+free_irq:
+	mc13xxx_lock(mc13783);
+
+	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
+		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD3, priv);
+
+free_irq_b2:
+	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
+		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD2, priv);
+
+free_irq_b1:
+	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
+		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD1, priv);
+
+free_priv:
+	mc13xxx_unlock(mc13783);
+	kfree(priv);
+
+free_input_dev:
+	input_free_device(pwr);
+
+	return err;
+}
+
+static int __devexit mc13783_pwrbutton_remove(struct platform_device *=
pdev)
+{
+	struct mc13783_pwrb *priv =3D platform_get_drvdata(pdev);
+	const struct mc13xxx_buttons_platform_data *pdata;
+
+	pdata =3D dev_get_platdata(&pdev->dev);
+
+	mc13xxx_lock(priv->mc13783);
+
+	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
+		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD3, priv);
+	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
+		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD2, priv);
+	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
+		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD1, priv);
+
+	mc13xxx_unlock(priv->mc13783);
+
+	input_unregister_device(priv->pwr);
+	kfree(priv);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+struct platform_driver mc13783_pwrbutton_driver =3D {
+	.probe		=3D mc13783_pwrbutton_probe,
+	.remove		=3D __devexit_p(mc13783_pwrbutton_remove),
+	.driver		=3D {
+		.name	=3D "mc13783-pwrbutton",
+		.owner	=3D THIS_MODULE,
+	},
+};
+
+static int __init mc13783_pwrbutton_init(void)
+{
+	return platform_driver_register(&mc13783_pwrbutton_driver);
+}
+module_init(mc13783_pwrbutton_init);
+
+static void __exit mc13783_pwrbutton_exit(void)
+{
+	platform_driver_unregister(&mc13783_pwrbutton_driver);
+}
+module_exit(mc13783_pwrbutton_exit);
+
+MODULE_ALIAS("platform:mc13783-pwrbutton");
+MODULE_DESCRIPTION("MC13783 Power Button");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Philippe Retornaz");
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 2867c21..ce4377f 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -716,6 +716,11 @@ static int mc13xxx_probe(struct spi_device *spi)
 	enum mc13xxx_id id;
 	int ret;
=20
+	if (!pdata) {
+		dev_err(&spi->dev, "invalid platform data\n");
+		return -EINVAL;
+	}
+
 	mc13xxx =3D kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
 	if (!mc13xxx)
 		return -ENOMEM;
@@ -776,6 +781,10 @@ err_revision:
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
 				pdata->leds, sizeof(*pdata->leds));
=20
+	if (pdata->buttons)
+		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
+				pdata->buttons, sizeof(*pdata->buttons));
+
 	return 0;
 }
=20
diff --git a/include/linux/mfd/mc13783.h b/include/linux/mfd/mc13783.h
index 3756a30..aa824d0 100644
--- a/include/linux/mfd/mc13783.h
+++ b/include/linux/mfd/mc13783.h
@@ -106,6 +106,7 @@ static inline int mc13783_irq_ack(struct mc13783 *m=
c13783, int irq)
 #define mc13783_regulator_platform_data mc13xxx_regulator_platform_dat=
a
 #define mc13783_led_platform_data mc13xxx_led_platform_data
 #define mc13783_leds_platform_data mc13xxx_leds_platform_data
+#define mc13783_buttons_platform_data mc13xxx_buttons_platform_data
=20
 #define mc13783_platform_data mc13xxx_platform_data
 #define MC13783_USE_TOUCHSCREEN	MC13XXX_USE_TOUCHSCREEN
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index cef1497..f24be68 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -137,6 +137,22 @@ struct mc13xxx_leds_platform_data {
 	char tc3_period;
 };
=20
+struct mc13xxx_buttons_platform_data {
+#define MC13783_BUTTON_DBNC_0MS		0
+#define MC13783_BUTTON_DBNC_30MS	1
+#define MC13783_BUTTON_DBNC_150MS	2
+#define MC13783_BUTTON_DBNC_750MS	3
+#define MC13783_BUTTON_ENABLE		(1 << 2)
+#define MC13783_BUTTON_POL_INVERT	(1 << 3)
+#define MC13783_BUTTON_RESET_EN		(1 << 4)
+	int b1on_flags;
+	unsigned short b1on_key;
+	int b2on_flags;
+	unsigned short b2on_key;
+	int b3on_flags;
+	unsigned short b3on_key;
+};
+
 struct mc13xxx_platform_data {
 #define MC13XXX_USE_TOUCHSCREEN (1 << 0)
 #define MC13XXX_USE_CODEC	(1 << 1)
@@ -146,6 +162,7 @@ struct mc13xxx_platform_data {
=20
 	struct mc13xxx_regulator_platform_data regulators;
 	struct mc13xxx_leds_platform_data *leds;
+	struct mc13xxx_buttons_platform_data *buttons;
 };
=20
 #endif /* ifndef __LINUX_MFD_MC13XXX_H */
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
