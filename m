From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] input/mc13xxx_ts.c: Add support for mc13892
Date: Mon, 26 Sep 2011 16:57:37 +0200
Message-ID: <1317049057-4936-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54946 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab1IZO5x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Sep 2011 10:57:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Jander <david@protonic.nl>

The mc13892 has almost the same touchscreen controller as the mc13783.
This patch adds support for mc13892.

Based on an earlier patch by David Jander.

Cc: David Jander <david@protonic.nl>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/input/touchscreen/Kconfig      |   10 +-
 drivers/input/touchscreen/Makefile     |    2 +-
 drivers/input/touchscreen/mc13783_ts.c |  259 ------------------------=
-----
 drivers/input/touchscreen/mc13xxx_ts.c |  282 ++++++++++++++++++++++++=
++++++++
 4 files changed, 288 insertions(+), 265 deletions(-)
 delete mode 100644 drivers/input/touchscreen/mc13783_ts.c
 create mode 100644 drivers/input/touchscreen/mc13xxx_ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index cabd9e5..3daeae6 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -548,17 +548,17 @@ config TOUCHSCREEN_USB_COMPOSITE
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbtouchscreen.
=20
-config TOUCHSCREEN_MC13783
-	tristate "Freescale MC13783 touchscreen input driver"
-	depends on MFD_MC13783
+config TOUCHSCREEN_MC13XXX
+	tristate "Freescale MC13783/MC13892 touchscreen input driver"
+	depends on MFD_MC13XXX
 	help
-	  Say Y here if you have an Freescale MC13783 PMIC on your
+	  Say Y here if you have an Freescale MC13783/MC13892 PMIC on your
 	  board and want to use its touchscreen
=20
 	  If unsure, say N.
=20
 	  To compile this driver as a module, choose M here: the
-	  module will be called mc13783_ts.
+	  module will be called mc13xxx_ts.
=20
 config TOUCHSCREEN_USB_EGALAX
 	default y
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
index 282d6f7..2e90c01 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+=3D inexio.o
 obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+=3D intel-mid-touch.o
 obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+=3D lpc32xx_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+=3D max11801_ts.o
-obj-$(CONFIG_TOUCHSCREEN_MC13783)	+=3D mc13783_ts.o
+obj-$(CONFIG_TOUCHSCREEN_MC13XXX)	+=3D mc13xxx_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MCS5000)	+=3D mcs5000_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+=3D migor_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+=3D mtouch.o
diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/tou=
chscreen/mc13783_ts.c
deleted file mode 100644
index ede0274..0000000
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ /dev/null
@@ -1,259 +0,0 @@
-/*
- * Driver for the Freescale Semiconductor MC13783 touchscreen.
- *
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserv=
ed.
- * Copyright (C) 2009 Sascha Hauer, Pengutronix
- *
- * Initial development of this code was funded by
- * Phytec Messtechnik GmbH, http://www.phytec.de/
- *
- * This program is free software; you can redistribute it and/or modif=
y it
- * under the terms of the GNU General Public License version 2 as publ=
ished by
- * the Free Software Foundation.
- */
-#include <linux/platform_device.h>
-#include <linux/mfd/mc13783.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/input.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-
-#define MC13783_TS_NAME	"mc13783-ts"
-
-#define DEFAULT_SAMPLE_TOLERANCE 300
-
-static unsigned int sample_tolerance =3D DEFAULT_SAMPLE_TOLERANCE;
-module_param(sample_tolerance, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(sample_tolerance,
-		"If the minimal and maximal value read out for one axis (out "
-		"of three) differ by this value (default: "
-		__stringify(DEFAULT_SAMPLE_TOLERANCE) ") or more, the reading "
-		"is supposed to be wrong and is discarded.  Set to 0 to "
-		"disable this check.");
-
-struct mc13783_ts_priv {
-	struct input_dev *idev;
-	struct mc13xxx *mc13xxx;
-	struct delayed_work work;
-	struct workqueue_struct *workq;
-	unsigned int sample[4];
-};
-
-static irqreturn_t mc13783_ts_handler(int irq, void *data)
-{
-	struct mc13783_ts_priv *priv =3D data;
-
-	mc13xxx_irq_ack(priv->mc13xxx, irq);
-
-	/*
-	 * Kick off reading coordinates. Note that if work happens already
-	 * be queued for future execution (it rearms itself) it will not
-	 * be rescheduled for immediate execution here. However the rearm
-	 * delay is HZ / 50 which is acceptable.
-	 */
-	queue_delayed_work(priv->workq, &priv->work, 0);
-
-	return IRQ_HANDLED;
-}
-
-#define sort3(a0, a1, a2) ({						\
-		if (a0 > a1)						\
-			swap(a0, a1);					\
-		if (a1 > a2)						\
-			swap(a1, a2);					\
-		if (a0 > a1)						\
-			swap(a0, a1);					\
-		})
-
-static void mc13783_ts_report_sample(struct mc13783_ts_priv *priv)
-{
-	struct input_dev *idev =3D priv->idev;
-	int x0, x1, x2, y0, y1, y2;
-	int cr0, cr1;
-
-	/*
-	 * the values are 10-bit wide only, but the two least significant
-	 * bits are for future 12 bit use and reading yields 0
-	 */
-	x0 =3D priv->sample[0] & 0xfff;
-	x1 =3D priv->sample[1] & 0xfff;
-	x2 =3D priv->sample[2] & 0xfff;
-	y0 =3D priv->sample[3] & 0xfff;
-	y1 =3D (priv->sample[0] >> 12) & 0xfff;
-	y2 =3D (priv->sample[1] >> 12) & 0xfff;
-	cr0 =3D (priv->sample[2] >> 12) & 0xfff;
-	cr1 =3D (priv->sample[3] >> 12) & 0xfff;
-
-	dev_dbg(&idev->dev,
-		"x: (% 4d,% 4d,% 4d) y: (% 4d, % 4d,% 4d) cr: (% 4d, % 4d)\n",
-		x0, x1, x2, y0, y1, y2, cr0, cr1);
-
-	sort3(x0, x1, x2);
-	sort3(y0, y1, y2);
-
-	cr0 =3D (cr0 + cr1) / 2;
-
-	if (!cr0 || !sample_tolerance ||
-			(x2 - x0 < sample_tolerance &&
-			 y2 - y0 < sample_tolerance)) {
-		/* report the median coordinate and average pressure */
-		if (cr0) {
-			input_report_abs(idev, ABS_X, x1);
-			input_report_abs(idev, ABS_Y, y1);
-
-			dev_dbg(&idev->dev, "report (%d, %d, %d)\n",
-					x1, y1, 0x1000 - cr0);
-			queue_delayed_work(priv->workq, &priv->work, HZ / 50);
-		} else
-			dev_dbg(&idev->dev, "report release\n");
-
-		input_report_abs(idev, ABS_PRESSURE,
-				cr0 ? 0x1000 - cr0 : cr0);
-		input_report_key(idev, BTN_TOUCH, cr0);
-		input_sync(idev);
-	} else
-		dev_dbg(&idev->dev, "discard event\n");
-}
-
-static void mc13783_ts_work(struct work_struct *work)
-{
-	struct mc13783_ts_priv *priv =3D
-		container_of(work, struct mc13783_ts_priv, work.work);
-	unsigned int mode =3D MC13XXX_ADC_MODE_TS;
-	unsigned int channel =3D 12;
-
-	if (mc13xxx_adc_do_conversion(priv->mc13xxx,
-				mode, channel, priv->sample) =3D=3D 0)
-		mc13783_ts_report_sample(priv);
-}
-
-static int mc13783_ts_open(struct input_dev *dev)
-{
-	struct mc13783_ts_priv *priv =3D input_get_drvdata(dev);
-	int ret;
-
-	mc13xxx_lock(priv->mc13xxx);
-
-	mc13xxx_irq_ack(priv->mc13xxx, MC13XXX_IRQ_TS);
-
-	ret =3D mc13xxx_irq_request(priv->mc13xxx, MC13XXX_IRQ_TS,
-		mc13783_ts_handler, MC13783_TS_NAME, priv);
-	if (ret)
-		goto out;
-
-	ret =3D mc13xxx_reg_rmw(priv->mc13xxx, MC13XXX_ADC0,
-			MC13XXX_ADC0_TSMOD_MASK, MC13XXX_ADC0_TSMOD0);
-	if (ret)
-		mc13xxx_irq_free(priv->mc13xxx, MC13XXX_IRQ_TS, priv);
-out:
-	mc13xxx_unlock(priv->mc13xxx);
-	return ret;
-}
-
-static void mc13783_ts_close(struct input_dev *dev)
-{
-	struct mc13783_ts_priv *priv =3D input_get_drvdata(dev);
-
-	mc13xxx_lock(priv->mc13xxx);
-	mc13xxx_reg_rmw(priv->mc13xxx, MC13XXX_ADC0,
-			MC13XXX_ADC0_TSMOD_MASK, 0);
-	mc13xxx_irq_free(priv->mc13xxx, MC13XXX_IRQ_TS, priv);
-	mc13xxx_unlock(priv->mc13xxx);
-
-	cancel_delayed_work_sync(&priv->work);
-}
-
-static int __init mc13783_ts_probe(struct platform_device *pdev)
-{
-	struct mc13783_ts_priv *priv;
-	struct input_dev *idev;
-	int ret =3D -ENOMEM;
-
-	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
-	idev =3D input_allocate_device();
-	if (!priv || !idev)
-		goto err_free_mem;
-
-	INIT_DELAYED_WORK(&priv->work, mc13783_ts_work);
-	priv->mc13xxx =3D dev_get_drvdata(pdev->dev.parent);
-	priv->idev =3D idev;
-
-	/*
-	 * We need separate workqueue because mc13783_adc_do_conversion
-	 * uses keventd and thus would deadlock.
-	 */
-	priv->workq =3D create_singlethread_workqueue("mc13783_ts");
-	if (!priv->workq)
-		goto err_free_mem;
-
-	idev->name =3D MC13783_TS_NAME;
-	idev->dev.parent =3D &pdev->dev;
-
-	idev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	idev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
-	input_set_abs_params(idev, ABS_X, 0, 0xfff, 0, 0);
-	input_set_abs_params(idev, ABS_Y, 0, 0xfff, 0, 0);
-	input_set_abs_params(idev, ABS_PRESSURE, 0, 0xfff, 0, 0);
-
-	idev->open =3D mc13783_ts_open;
-	idev->close =3D mc13783_ts_close;
-
-	input_set_drvdata(idev, priv);
-
-	ret =3D input_register_device(priv->idev);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"register input device failed with %d\n", ret);
-		goto err_destroy_wq;
-	}
-
-	platform_set_drvdata(pdev, priv);
-	return 0;
-
-err_destroy_wq:
-	destroy_workqueue(priv->workq);
-err_free_mem:
-	input_free_device(idev);
-	kfree(priv);
-	return ret;
-}
-
-static int __devexit mc13783_ts_remove(struct platform_device *pdev)
-{
-	struct mc13783_ts_priv *priv =3D platform_get_drvdata(pdev);
-
-	platform_set_drvdata(pdev, NULL);
-
-	destroy_workqueue(priv->workq);
-	input_unregister_device(priv->idev);
-	kfree(priv);
-
-	return 0;
-}
-
-static struct platform_driver mc13783_ts_driver =3D {
-	.remove		=3D __devexit_p(mc13783_ts_remove),
-	.driver		=3D {
-		.owner	=3D THIS_MODULE,
-		.name	=3D MC13783_TS_NAME,
-	},
-};
-
-static int __init mc13783_ts_init(void)
-{
-	return platform_driver_probe(&mc13783_ts_driver, &mc13783_ts_probe);
-}
-module_init(mc13783_ts_init);
-
-static void __exit mc13783_ts_exit(void)
-{
-	platform_driver_unregister(&mc13783_ts_driver);
-}
-module_exit(mc13783_ts_exit);
-
-MODULE_DESCRIPTION("MC13783 input touchscreen driver");
-MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" MC13783_TS_NAME);
diff --git a/drivers/input/touchscreen/mc13xxx_ts.c b/drivers/input/tou=
chscreen/mc13xxx_ts.c
new file mode 100644
index 0000000..2eda31b
--- /dev/null
+++ b/drivers/input/touchscreen/mc13xxx_ts.c
@@ -0,0 +1,282 @@
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
+#include <linux/slab.h>
+#include <linux/init.h>
+
+#define DRIVER_NAME	"mc13xxx-ts"
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
+#define MC13XXX_TWO_SAMPLES	1
+
+struct mc13783_ts_priv {
+	struct platform_device *pdev;
+	struct input_dev *idev;
+	struct mc13xxx *mc13xxx;
+	struct delayed_work work;
+	struct workqueue_struct *workq;
+	unsigned int sample[4];
+};
+
+static irqreturn_t mc13783_ts_handler(int irq, void *data)
+{
+	struct mc13783_ts_priv *priv =3D data;
+
+	mc13xxx_irq_ack(priv->mc13xxx, irq);
+
+	/*
+	 * Kick off reading coordinates. Note that if work happens already
+	 * be queued for future execution (it rearms itself) it will not
+	 * be rescheduled for immediate execution here. However the rearm
+	 * delay is HZ / 50 which is acceptable.
+	 */
+	queue_delayed_work(priv->workq, &priv->work, 0);
+
+	return IRQ_HANDLED;
+}
+
+#define sort3(a0, a1, a2) ({						\
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
+	struct platform_device *pdev =3D priv->pdev;
+	struct input_dev *idev =3D priv->idev;
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
+	/* On the mc13892, x2 and y2 are invalid */
+	if (platform_get_device_id(pdev)->driver_data & MC13XXX_TWO_SAMPLES) =
{
+		/* better use x2 =3D (x1 + x0) / 2 ? */
+		x2 =3D x1;
+		y2 =3D y1;
+	}
+
+	dev_dbg(&idev->dev,
+		"x: (% 4d,% 4d,% 4d) y: (% 4d, % 4d,% 4d) cr: (% 4d, % 4d)\n",
+		x0, x1, x2, y0, y1, y2, cr0, cr1);
+
+	sort3(x0, x1, x2);
+	sort3(y0, y1, y2);
+
+	cr0 =3D (cr0 + cr1) / 2;
+
+	if (!cr0 || !sample_tolerance ||
+			(x2 - x0 < sample_tolerance &&
+			 y2 - y0 < sample_tolerance)) {
+		/* report the median coordinate and average pressure */
+		if (cr0) {
+			input_report_abs(idev, ABS_X, x1);
+			input_report_abs(idev, ABS_Y, y1);
+
+			dev_dbg(&idev->dev, "report (%d, %d, %d)\n",
+					x1, y1, 0x1000 - cr0);
+			queue_delayed_work(priv->workq, &priv->work, HZ / 50);
+		} else
+			dev_dbg(&idev->dev, "report release\n");
+
+		input_report_abs(idev, ABS_PRESSURE,
+				cr0 ? 0x1000 - cr0 : cr0);
+		input_report_key(idev, BTN_TOUCH, cr0);
+		input_sync(idev);
+	} else
+		dev_dbg(&idev->dev, "discard event\n");
+}
+
+static void mc13783_ts_work(struct work_struct *work)
+{
+	struct mc13783_ts_priv *priv =3D
+		container_of(work, struct mc13783_ts_priv, work.work);
+	unsigned int mode =3D MC13XXX_ADC_MODE_TS;
+	unsigned int channel =3D 12;
+
+	if (mc13xxx_adc_do_conversion(priv->mc13xxx,
+				mode, channel, priv->sample) =3D=3D 0)
+		mc13783_ts_report_sample(priv);
+}
+
+static int mc13783_ts_open(struct input_dev *dev)
+{
+	struct mc13783_ts_priv *priv =3D input_get_drvdata(dev);
+	int ret;
+
+	mc13xxx_lock(priv->mc13xxx);
+
+	mc13xxx_irq_ack(priv->mc13xxx, MC13XXX_IRQ_TS);
+
+	ret =3D mc13xxx_irq_request(priv->mc13xxx, MC13XXX_IRQ_TS,
+		mc13783_ts_handler, DRIVER_NAME, priv);
+	if (ret)
+		goto out;
+
+	ret =3D mc13xxx_reg_rmw(priv->mc13xxx, MC13XXX_ADC0,
+			MC13XXX_ADC0_TSMOD_MASK, MC13XXX_ADC0_TSMOD0);
+	if (ret)
+		mc13xxx_irq_free(priv->mc13xxx, MC13XXX_IRQ_TS, priv);
+out:
+	mc13xxx_unlock(priv->mc13xxx);
+	return ret;
+}
+
+static void mc13783_ts_close(struct input_dev *dev)
+{
+	struct mc13783_ts_priv *priv =3D input_get_drvdata(dev);
+
+	mc13xxx_lock(priv->mc13xxx);
+	mc13xxx_reg_rmw(priv->mc13xxx, MC13XXX_ADC0,
+			MC13XXX_ADC0_TSMOD_MASK, 0);
+	mc13xxx_irq_free(priv->mc13xxx, MC13XXX_IRQ_TS, priv);
+	mc13xxx_unlock(priv->mc13xxx);
+
+	cancel_delayed_work_sync(&priv->work);
+}
+
+static int __init mc13783_ts_probe(struct platform_device *pdev)
+{
+	struct mc13783_ts_priv *priv;
+	struct input_dev *idev;
+	int ret =3D -ENOMEM;
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	idev =3D input_allocate_device();
+	if (!priv || !idev)
+		goto err_free_mem;
+
+	INIT_DELAYED_WORK(&priv->work, mc13783_ts_work);
+	priv->pdev =3D pdev;
+	priv->mc13xxx =3D dev_get_drvdata(pdev->dev.parent);
+	priv->idev =3D idev;
+
+	/*
+	 * We need separate workqueue because mc13783_adc_do_conversion
+	 * uses keventd and thus would deadlock.
+	 */
+	priv->workq =3D create_singlethread_workqueue(pdev->name);
+	if (!priv->workq)
+		goto err_free_mem;
+
+	idev->name =3D pdev->name;
+	idev->dev.parent =3D &pdev->dev;
+
+	idev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	idev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(idev, ABS_X, 0, 0xfff, 0, 0);
+	input_set_abs_params(idev, ABS_Y, 0, 0xfff, 0, 0);
+	input_set_abs_params(idev, ABS_PRESSURE, 0, 0xfff, 0, 0);
+
+	idev->open =3D mc13783_ts_open;
+	idev->close =3D mc13783_ts_close;
+
+	input_set_drvdata(idev, priv);
+
+	ret =3D input_register_device(priv->idev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"register input device failed with %d\n", ret);
+		goto err_destroy_wq;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	return 0;
+
+err_destroy_wq:
+	destroy_workqueue(priv->workq);
+err_free_mem:
+	input_free_device(idev);
+	kfree(priv);
+	return ret;
+}
+
+static int __devexit mc13783_ts_remove(struct platform_device *pdev)
+{
+	struct mc13783_ts_priv *priv =3D platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	destroy_workqueue(priv->workq);
+	input_unregister_device(priv->idev);
+	kfree(priv);
+
+	return 0;
+}
+static const struct platform_device_id mc13xxx_ts_idtable[] =3D {
+	{
+		.name =3D "mc13783-ts",
+	}, {
+		.name =3D "mc13892-ts",
+		.driver_data =3D MC13XXX_TWO_SAMPLES,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, mc13xxx_ts_idtable);
+
+static struct platform_driver mc13783_ts_driver =3D {
+	.id_table	=3D mc13xxx_ts_idtable,
+	.remove		=3D __devexit_p(mc13783_ts_remove),
+	.driver		=3D {
+		.owner	=3D THIS_MODULE,
+		.name	=3D DRIVER_NAME,
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
--=20
1.7.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
