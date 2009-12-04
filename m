From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] [input] add mc13783 touchscreen driver
Date: Fri,  4 Dec 2009 20:52:57 +0100
Message-ID: <1259956377-32173-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090813162321.5A2F5526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36994 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbZLDTxK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 14:53:10 -0500
In-Reply-To: <20090813162321.5A2F5526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

=46rom: Sascha Hauer <s.hauer@pengutronix.de>

This driver provides support for the touchscreen interface
integrated into the Freescale MC13783.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Luotao Fu <l.fu@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/touchscreen/Kconfig      |   12 ++
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/mc13783_ts.c |  259 ++++++++++++++++++++++++=
++++++++
 3 files changed, 272 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/mc13783_ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index 8cc453c..cdee9ca 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -425,6 +425,18 @@ config TOUCHSCREEN_USB_COMPOSITE
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbtouchscreen.
=20
+config TOUCHSCREEN_MC13783
+	tristate "Freescale MC13783 touchscreen input driver"
+	depends on MFD_MC13783
+	help
+	  Say Y here if you have an Freescale MC13783 PMIC on your
+	  board and want to use its touchscreen
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mc13783_ts.
+
 config TOUCHSCREEN_USB_EGALAX
 	default y
 	bool "eGalax, eTurboTouch CT-410/510/700 device support" if EMBEDDED
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
index 15fa62c..ac5ecaf 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_TOUCHSCREEN_MCS5000)	+=3D mcs5000_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+=3D migor_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+=3D mtouch.o
 obj-$(CONFIG_TOUCHSCREEN_MK712)		+=3D mk712.o
+obj-$(CONFIG_TOUCHSCREEN_MC13783)	+=3D mc13783_ts.o
 obj-$(CONFIG_TOUCHSCREEN_HP600)		+=3D hp680_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+=3D jornada720_ts.o
 obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+=3D htcpen.o
diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/tou=
chscreen/mc13783_ts.c
new file mode 100644
index 0000000..a36b2ad
--- /dev/null
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -0,0 +1,259 @@
+/*
+ * Driver for the Freescale Semiconductor MC13783 touchscreen.
+ *
+ * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserv=
ed.
+ * Copyright (C) 2009 Sascha Hauer, Pengutronix
+ *
+ * Initial development of this code was funded by
+ * Phytec Messtechnik GmbH, http://www.phytec.de/
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
+ * the Free Software Foundation.
+ */
+#include <linux/platform_device.h>
+#include <linux/mfd/mc13783.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+
+#define MC13783_TS_NAME	"mc13783-ts"
+
+#define DEFAULT_SAMPLE_TOLERANCE 300
+
+static unsigned int sample_tolerance =3D DEFAULT_SAMPLE_TOLERANCE;
+module_param(sample_tolerance, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(sample_tolerance,
+		"If the minimal and maximal value read out for one axis (out "
+		"of three) differ by this value (default: "
+		__stringify(DEFAULT_SAMPLE_TOLERANCE) ") or more, the reading "
+		"is supposed to be wrong and is discarded.  Set to 0 to "
+		"disable this check.");
+
+struct mc13783_ts_priv {
+	struct input_dev *idev;
+	struct mc13783 *mc13783;
+	struct delayed_work work;
+	struct workqueue_struct *workq;
+	unsigned int sample[4];
+};
+
+static irqreturn_t mc13783_ts_handler(int irq, void *data)
+{
+	struct mc13783_ts_priv *priv =3D data;
+
+	mc13783_ackirq(priv->mc13783, irq);
+
+	queue_delayed_work(priv->workq, &priv->work, 0);
+
+	return IRQ_HANDLED;
+}
+
+#define sort3(a0, a1, a2) ({ 						\
+		if (a0 > a1)						\
+			swap(a0, a1);					\
+		if (a1 > a2)						\
+			swap(a1, a2);					\
+		if (a0 > a1)						\
+			swap(a0, a1);					\
+		})
+
+static void mc13783_ts_report_sample(struct mc13783_ts_priv *priv)
+{
+	int x0, x1, x2, y0, y1, y2;
+	int cr0, cr1;
+
+	/*
+	 * the values are 10-bit wide only, but the two least significant
+	 * bits are for future 12 bit use and reading yields 0
+	 */
+	x0 =3D priv->sample[0] & 0xfff;
+	x1 =3D priv->sample[1] & 0xfff;
+	x2 =3D priv->sample[2] & 0xfff;
+	y0 =3D priv->sample[3] & 0xfff;
+	y1 =3D (priv->sample[0] >> 12) & 0xfff;
+	y2 =3D (priv->sample[1] >> 12) & 0xfff;
+	cr0 =3D (priv->sample[2] >> 12) & 0xfff;
+	cr1 =3D (priv->sample[3] >> 12) & 0xfff;
+
+	dev_dbg(&priv->idev->dev, "x: (% 4d,% 4d,% 4d) y: (% 4d, % 4d,% 4d) "
+			"cr: (% 4d, % 4d)\n", x0, x1, x2, y0, y1, y2, cr0, cr1);
+
+	sort3(x0, x1, x2);
+	sort3(y0, y1, y2);
+
+	cr0 =3D (cr0 + cr1) / 2;
+
+	if (!cr0 || !sample_tolerance ||
+			(x2 - x0 < sample_tolerance &&
+			 y2 - y0 < sample_tolerance))
+	{
+		/* report the median coordinate and average pressure */
+		if (cr0) {
+			input_report_abs(priv->idev, ABS_X, x1);
+			input_report_abs(priv->idev, ABS_Y, y1);
+
+			dev_dbg(&priv->idev->dev, "report (%d, %d, %d)\n",
+					x1, y1, 0x1000 - cr0);
+			queue_delayed_work(priv->workq, &priv->work, HZ / 50);
+		} else
+			dev_dbg(&priv->idev->dev, "report release\n");
+
+		input_report_abs(priv->idev, ABS_PRESSURE,
+				cr0 ? 0x1000 - cr0 : cr0);
+		input_report_key(priv->idev, BTN_TOUCH, !!cr0);
+		input_sync(priv->idev);
+	} else
+		dev_dbg(&priv->idev->dev, "discard event\n");
+}
+
+static void mc13783_ts_work(struct work_struct *work)
+{
+	struct mc13783_ts_priv *priv =3D
+		container_of(work, struct mc13783_ts_priv, work.work);
+	unsigned int mode =3D MC13783_ADC_MODE_TS;
+	unsigned int channel =3D 12;
+	int ret;
+
+	ret =3D mc13783_adc_do_conversion(priv->mc13783, mode, channel,
+			priv->sample);
+
+	if (!ret)
+		mc13783_ts_report_sample(priv);
+}
+
+static int mc13783_ts_open(struct input_dev *dev)
+{
+	struct mc13783_ts_priv *priv =3D input_get_drvdata(dev);
+	int ret;
+
+	mc13783_lock(priv->mc13783);
+
+	mc13783_ackirq(priv->mc13783, MC13783_IRQ_TS);
+
+	ret =3D mc13783_irq_request(priv->mc13783, MC13783_IRQ_TS,
+		mc13783_ts_handler, MC13783_TS_NAME, priv);
+	if (ret)
+		goto out;
+
+	ret =3D mc13783_reg_rmw(priv->mc13783, MC13783_ADC0,
+			MC13783_ADC0_TSMOD_MASK, MC13783_ADC0_TSMOD0);
+
+out:
+	mc13783_unlock(priv->mc13783);
+
+	return ret;
+}
+
+static void mc13783_ts_close(struct input_dev *dev)
+{
+	struct mc13783_ts_priv *priv =3D input_get_drvdata(dev);
+
+	mc13783_lock(priv->mc13783);
+	mc13783_reg_rmw(priv->mc13783, MC13783_ADC0,
+			MC13783_ADC0_TSMOD_MASK, 0);
+	mc13783_irq_free(priv->mc13783, MC13783_IRQ_TS, priv);
+	mc13783_unlock(priv->mc13783);
+}
+
+static int __init mc13783_ts_probe(struct platform_device *pdev)
+{
+	struct mc13783_ts_priv *priv;
+	struct input_dev *idev;
+	int ret;
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->mc13783 =3D dev_get_drvdata(pdev->dev.parent);
+
+	idev =3D input_allocate_device();
+	if (!idev) {
+		ret =3D -ENOMEM;
+		goto err_input_alloc;
+	}
+
+	priv->idev =3D idev;
+	idev->name =3D MC13783_TS_NAME;
+	idev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	idev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
+	idev->open =3D mc13783_ts_open;
+	idev->close =3D mc13783_ts_close;
+	input_set_abs_params(idev, ABS_X, 0, 0xfff, 0, 0);
+	input_set_abs_params(idev, ABS_Y, 0, 0xfff, 0, 0);
+	input_set_abs_params(idev, ABS_PRESSURE, 0, 0xfff, 0, 0);
+
+	platform_set_drvdata(pdev, priv);
+
+	INIT_DELAYED_WORK(&priv->work, mc13783_ts_work);
+
+	priv->workq =3D create_singlethread_workqueue("mc13783_ts");
+	if (!priv->workq) {
+		ret =3D -ENOMEM;
+		goto err_input_alloc;
+	}
+
+	input_set_drvdata(idev, priv);
+
+	ret =3D input_register_device(priv->idev);
+	if (ret) {
+		dev_err(&pdev->dev,
+				"register input device failed with %d\n", ret);
+		goto err_failed_register;
+	}
+
+	return 0;
+
+err_failed_register:
+	input_free_device(priv->idev);
+
+err_input_alloc:
+	platform_set_drvdata(pdev, NULL);
+	kfree(priv);
+
+	return ret;
+}
+
+static int __devexit mc13783_ts_remove(struct platform_device *pdev)
+{
+	struct mc13783_ts_priv *priv =3D platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	cancel_delayed_work(&priv->work);
+	destroy_workqueue(priv->workq);
+
+	input_unregister_device(priv->idev);
+
+	kfree(priv);
+
+	return 0;
+}
+
+static struct platform_driver mc13783_ts_driver =3D {
+	.remove		=3D __devexit_p(mc13783_ts_remove),
+	.driver		=3D {
+		.owner	=3D THIS_MODULE,
+		.name	=3D MC13783_TS_NAME,
+	},
+};
+
+static int __init mc13783_ts_init(void)
+{
+	return platform_driver_probe(&mc13783_ts_driver, &mc13783_ts_probe);
+}
+module_init(mc13783_ts_init);
+
+static void __exit mc13783_ts_exit(void)
+{
+	platform_driver_unregister(&mc13783_ts_driver);
+}
+module_exit(mc13783_ts_exit);
+
+MODULE_DESCRIPTION("MC13783 input touchscreen driver");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" MC13783_TS_NAME);
--=20
1.6.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
