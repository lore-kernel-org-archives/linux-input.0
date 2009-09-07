From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
 series SoCs
Date: Mon, 07 Sep 2009 14:38:27 +0900
Message-ID: <4AA49C53.3030400@samsung.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35798 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758856AbZIGF71 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 01:59:27 -0400
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPL00L0R6C3AF@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 14:38:27 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPL004AY6C30H@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 14:38:27 +0900 (KST)
In-reply-to: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>
Cc: linux-input@vger.kernel.org, laforge@gnumonks.org, ben-linux@fluff.org, =?UTF-8?B?Iuq5gOqyveydvC9BUOqwnOuwnO2MgChTWVMuTFNJKQ==?= =?UTF-8?B?L0UzKOyCrOybkCkv7IK87ISx7KCE7J6QIg==?= <ki0351.kim@samsung.com>, =?UTF-8?B?IifquYDqta3sp4QvQVDqsJzrsJztjIAoU1lT?= =?UTF-8?B?LkxTSSkvRTUo7LGF7J6EKS/sgrzshLHsoITsnpAnIg==?= <kgene.kim@samsung.com>, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

On 9/5/2009 10:55 PM, =EC=96=91=EC=A7=84=EC=84=B1 wrote:
> This keypad driver supports Samsung s3c based SoCs such as s3c6410.
> This driver is written with input device compatibles.
>=20
> Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
> Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
> ---
>  drivers/input/keyboard/s3c-keypad.c |  468 +++++++++++++++++++++++++=
++++++++++
>  1 files changed, 468 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/keyboard/s3c-keypad.c

Hi,

We already implemented and tested the keypad driver for s5pc100 &
s5pc110 and maybe it will operate on s3c64xx. We use the samsung prefix
to support three cpu. Because there is no the arch for s5pc100 and
s5pc110, this driver doesn't compile yet on upstream kernel.


=46rom 0582cd271637aaebed29f2982f941bcf80d84179 Mon Sep 17 00:00:00 200=
1
=46rom: Joonyoung Shim <jy0922.shim@samsung.com>
Date: Mon, 7 Sep 2009 14:35:12 +0900
Subject: [PATCH] Input: add samsung keypad driver for S3C64XX and S5PC1=
XX cpu

This patch adds support for keypad driver running on Samsung S3C64XX an=
d
S5PC1XX cpu.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/keyboard/Kconfig          |    9 +
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/samsung-keypad.c |  366 +++++++++++++++++++++++=
++++++++
 3 files changed, 376 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/samsung-keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
index 3525c19..b2cec96 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -278,6 +278,15 @@ config KEYBOARD_PXA930_ROTARY
 	  To compile this driver as a module, choose M here: the
 	  module will be called pxa930_rotary.
=20
+config KEYBOARD_SAMSUNG
+	tristate "Samsung keypad support"
+	depends on ARCH_S3C64XX || ARCH_S5PC1XX
+	help
+	  Say Y here if you want to use the Samsung keypad.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called samsung-keypad.
+
 config KEYBOARD_SPITZ
 	tristate "Spitz keyboard"
 	depends on PXA_SHARPSL
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/M=
akefile
index 8a7a22b..2fa54a7 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_KEYBOARD_NEWTON)		+=3D newtonkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+=3D omap-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+=3D pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+=3D pxa930_rotary.o
+obj-$(CONFIG_KEYBOARD_SAMSUNG)		+=3D samsung-keypad.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+=3D sh_keysc.o
 obj-$(CONFIG_KEYBOARD_SPITZ)		+=3D spitzkbd.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+=3D stowaway.o
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/ke=
yboard/samsung-keypad.c
new file mode 100644
index 0000000..ad025f7
--- /dev/null
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -0,0 +1,366 @@
+/*
+ * samsung-keypad.c  --  Samsung keypad driver
+ *
+ * Copyright (C) 2009 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ * Author: Jaehoon Chung <jh80.chung@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or mod=
ify it
+ *  under  the terms of  the GNU General  Public License as published =
by the
+ *  Free Software Foundation;  either version 2 of the  License, or (a=
t your
+ *  option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <mach/cpu.h>
+#include <plat/keypad.h>
+#include <plat/regs-keypad.h>
+
+struct samsung_keypad {
+	struct input_dev *input_dev;
+	struct clk *clk;
+	struct delayed_work work;
+	void __iomem *base;
+	unsigned short *keycodes;
+	unsigned int num_cols;
+	unsigned int last_rows_state;
+	unsigned int last_cols_val[SAMSUNG_MAX_ROWS];
+	int irq;
+	atomic_t irq_disable;
+};
+
+static void samsung_kp_scan(struct work_struct *work)
+{
+	struct samsung_keypad *keypad =3D container_of(work,
+			struct samsung_keypad, work.work);
+	unsigned int row, col, val;
+	unsigned int mask;
+	unsigned int released =3D 0;
+
+	val =3D readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
+
+	if (cpu_is_s5pc110())
+		mask =3D S5PC110_R_INT_MASK;
+	else
+		mask =3D SAMSUNG_R_INT_MASK;
+
+	if (val & mask)
+		released =3D 1;
+
+	if (released) {
+		if (cpu_is_s5pc110()) {
+			val &=3D ~S5PC110_P_INT_MASK;
+			val =3D val >> S5PC110_R_INT_OFFSET;
+		} else {
+			val &=3D ~SAMSUNG_P_INT_MASK;
+			val =3D val >> SAMSUNG_R_INT_OFFSET;
+		}
+
+		if (!(keypad->last_rows_state & val))
+			goto end;
+
+		row =3D 0;
+		while (!(val & 1)) {
+			val =3D val >> 1;
+			row++;
+		}
+
+		col =3D keypad->last_cols_val[row];
+		keypad->last_rows_state &=3D ~(1 << row);
+		dev_dbg(&keypad->input_dev->dev,
+				"key released, row: %d, col: %d\n", row, col);
+	} else {
+		row =3D 0;
+		while (!(val & 1)) {
+			val =3D val >> 1;
+			row++;
+		}
+
+		for (col =3D 0; col < keypad->num_cols; col++) {
+			val =3D readl(keypad->base + SAMSUNG_KEYIFCOL);
+			val |=3D SAMSUNG_KEYIFCOL_MASK;
+			val &=3D ~(1 << col);
+			writel(val, keypad->base + SAMSUNG_KEYIFCOL);
+
+			val =3D readl(keypad->base + SAMSUNG_KEYIFROW);
+			if (!(val & (1 << row))) {
+				keypad->last_rows_state |=3D (1 << row);
+				keypad->last_cols_val[row] =3D col;
+				dev_dbg(&keypad->input_dev->dev,
+					"key pressed, row: %d, col: %d\n",
+					row, col);
+				goto found;
+			}
+		}
+		goto end;
+	}
+
+found:
+	val =3D (row << keypad->num_cols) + col;
+	input_report_key(keypad->input_dev, keypad->keycodes[val], !released)=
;
+	input_sync(keypad->input_dev);
+
+end:
+	/* KEYIFCOL reg clear */
+	if (cpu_is_s5pc110()) {
+		val =3D ~(SAMSUNG_KEYIFCOL_MASK | S5PC110_KEYIFCOLEN_MASK);
+		writel(val, keypad->base + SAMSUNG_KEYIFCOL);
+	} else {
+		val =3D ~SAMSUNG_KEYIFCOL_MASK;
+		writel(val, keypad->base + SAMSUNG_KEYIFCOL);
+	}
+
+	/* interrupt clear */
+	if (cpu_is_s5pc110())
+		val =3D S5PC110_P_INT_MASK | S5PC110_R_INT_MASK;
+	else
+		val =3D SAMSUNG_P_INT_MASK | SAMSUNG_R_INT_MASK;
+	writel(val, keypad->base + SAMSUNG_KEYIFSTSCLR);
+
+	atomic_dec(&keypad->irq_disable);
+	enable_irq(keypad->irq);
+}
+
+static irqreturn_t samsung_kp_interrupt(int irq, void *dev_id)
+{
+	struct samsung_keypad *keypad =3D dev_id;
+
+	if (!work_pending(&keypad->work.work)) {
+		disable_irq_nosync(keypad->irq);
+		atomic_inc(&keypad->irq_disable);
+		schedule_delayed_work(&keypad->work, msecs_to_jiffies(10));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit samsung_kp_probe(struct platform_device *pdev)
+{
+	const struct samsung_keypad_platdata *pdata;
+	struct samsung_keypad *keypad;
+	struct resource *res;
+	struct input_dev *input_dev;
+	unsigned short *keycodes;
+	unsigned int max_keymap_size;
+	unsigned int val;
+	int i;
+	int ret;
+
+	pdata =3D pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	if ((pdata->num_rows <=3D 0) || (pdata->num_rows > SAMSUNG_MAX_ROWS))
+		return -EINVAL;
+
+	if ((pdata->num_cols <=3D 0) || (pdata->num_cols > SAMSUNG_MAX_COLS))
+		return -EINVAL;
+
+	/* initialize the gpio */
+	if (pdata->cfg_gpio)
+		pdata->cfg_gpio(pdata->num_rows, pdata->num_cols);
+
+	max_keymap_size =3D pdata->num_rows * pdata->num_cols;
+	keypad =3D devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
+	keycodes =3D devm_kzalloc(&pdev->dev,
+			max_keymap_size * sizeof(*keycodes), GFP_KERNEL);
+	input_dev =3D input_allocate_device();
+	if (!keypad || !keycodes || !input_dev)
+		return -ENOMEM;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret =3D -ENODEV;
+		goto err_free_mem;
+	}
+
+	keypad->base =3D devm_ioremap(&pdev->dev, res->start, resource_size(r=
es));
+	if (!keypad->base) {
+		ret =3D -EBUSY;
+		goto err_free_mem;
+	}
+
+	if (pdata->clock) {
+		keypad->clk =3D clk_get(&pdev->dev, pdata->clock);
+		if (IS_ERR(keypad->clk)) {
+			dev_err(&pdev->dev, "failed to get keypad clk\n");
+			ret =3D PTR_ERR(keypad->clk);
+			goto err_unmap_base;
+		}
+		clk_enable(keypad->clk);
+	}
+
+	keypad->input_dev =3D input_dev;
+	keypad->keycodes =3D keycodes;
+	keypad->num_cols =3D pdata->num_cols;
+	INIT_DELAYED_WORK(&keypad->work, samsung_kp_scan);
+
+	/* enable interrupt and debouncing filter and wakeup bit */
+	val =3D SAMSUNG_INT_F_EN | SAMSUNG_INT_R_EN | SAMSUNG_DF_EN |
+		SAMSUNG_WAKEUPEN;
+	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+
+	keypad->irq =3D platform_get_irq(pdev, 0);
+	if (keypad->irq < 0) {
+		ret =3D keypad->irq;
+		goto err_disable_clk;
+	}
+
+	ret =3D devm_request_irq(&pdev->dev, keypad->irq,
+			samsung_kp_interrupt,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			dev_name(&pdev->dev), keypad);
+
+	if (ret)
+		goto err_disable_clk;
+
+	input_dev->name		=3D pdev->name;
+	input_dev->id.bustype	=3D BUS_HOST;
+	input_dev->dev.parent	=3D &pdev->dev;
+	input_dev->evbit[0]	=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+
+	input_dev->keycode	=3D keycodes;
+	input_dev->keycodesize	=3D sizeof(*keycodes);
+	input_dev->keycodemax	=3D max_keymap_size;
+
+	for (i =3D 0; i < pdata->keymap_size; i++) {
+		unsigned int key =3D pdata->keymap[i];
+		unsigned int row =3D KEY_ROW(key);
+		unsigned int col =3D KEY_COL(key);
+		unsigned short code =3D KEY_VAL(key);
+		unsigned int index =3D row * keypad->num_cols + col;
+
+		keycodes[index] =3D code;
+		set_bit(code, input_dev->keybit);
+	}
+
+	ret =3D input_register_device(keypad->input_dev);
+	if (ret)
+		goto err_free_irq;
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	platform_set_drvdata(pdev, keypad);
+
+	return 0;
+
+err_free_irq:
+	devm_free_irq(&pdev->dev, keypad->irq, keypad);
+err_disable_clk:
+	if (keypad->clk) {
+		clk_disable(keypad->clk);
+		clk_put(keypad->clk);
+	}
+err_unmap_base:
+	devm_iounmap(&pdev->dev, keypad->base);
+err_free_mem:
+	input_free_device(input_dev);
+	devm_kfree(&pdev->dev, keycodes);
+	devm_kfree(&pdev->dev, keypad);
+
+	return ret;
+}
+
+static int __devexit samsung_kp_remove(struct platform_device *pdev)
+{
+	struct samsung_keypad *keypad =3D platform_get_drvdata(pdev);
+
+	devm_free_irq(&pdev->dev, keypad->irq, keypad);
+	cancel_delayed_work_sync(&keypad->work);
+
+	/*
+	 * If work indeed has been cancelled, disable_irq() will have been le=
ft
+	 * unbalanced from samsung_kp_interrupt().
+	 */
+	while (atomic_dec_return(&keypad->irq_disable) >=3D 0)
+		enable_irq(keypad->irq);
+
+	platform_set_drvdata(pdev, NULL);
+	input_unregister_device(keypad->input_dev);
+
+	if (keypad->clk) {
+		clk_disable(keypad->clk);
+		clk_put(keypad->clk);
+	}
+
+	devm_iounmap(&pdev->dev, keypad->base);
+	devm_kfree(&pdev->dev, keypad->keycodes);
+	devm_kfree(&pdev->dev, keypad);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int samsung_kp_suspend(struct platform_device *pdev, pm_message=
_t state)
+{
+	struct samsung_keypad *keypad =3D platform_get_drvdata(pdev);
+
+	disable_irq(keypad->irq);
+	enable_irq_wake(keypad->irq);
+
+	if (keypad->clk)
+		clk_disable(keypad->clk);
+
+	return 0;
+}
+
+static int samsung_kp_resume(struct platform_device *pdev)
+{
+	struct samsung_keypad *keypad =3D platform_get_drvdata(pdev);
+	unsigned int val;
+
+	if (keypad->clk)
+		clk_enable(keypad->clk);
+
+	/* enable interrupt and debouncing filter and wakeup bit */
+	val =3D SAMSUNG_INT_F_EN | SAMSUNG_INT_R_EN | SAMSUNG_DF_EN |
+		SAMSUNG_WAKEUPEN;
+	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+
+	disable_irq_wake(keypad->irq);
+	enable_irq(keypad->irq);
+
+	return 0;
+}
+#else
+#define samsung_kp_suspend	NULL
+#define samsung_kp_resume	NULL
+#endif
+
+static struct platform_driver samsung_kp_driver =3D {
+	.probe		=3D samsung_kp_probe,
+	.remove		=3D __devexit_p(samsung_kp_remove),
+	.suspend	=3D samsung_kp_suspend,
+	.resume		=3D samsung_kp_resume,
+	.driver		=3D {
+		.name	=3D "samsung-keypad",
+		.owner	=3D THIS_MODULE,
+	},
+};
+
+static int __init samsung_kp_init(void)
+{
+	return platform_driver_register(&samsung_kp_driver);
+}
+
+static void __exit samsung_kp_exit(void)
+{
+	platform_driver_unregister(&samsung_kp_driver);
+}
+
+module_init(samsung_kp_init);
+module_exit(samsung_kp_exit);
+
+MODULE_DESCRIPTION("Samsung keypad driver");
+MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
+MODULE_AUTHOR("Jaehoon Chung <jh80.chung@samsung.com>");
+MODULE_LICENSE("GPL");
--=20
1.6.0.4
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
