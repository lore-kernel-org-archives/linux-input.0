From: Marc Reilly <marc@cpdesign.com.au>
Subject: [PATCH 2/4] input: mc13xxx_ts: add support for mc13892
Date: Mon, 30 Jan 2012 09:51:02 +1100
Message-ID: <1327877464-23526-3-git-send-email-marc@cpdesign.com.au>
References: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36735 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab2A2Wvl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 17:51:41 -0500
Received: by mail-pz0-f46.google.com with SMTP id i2so3053851dad.19
        for <linux-input@vger.kernel.org>; Sun, 29 Jan 2012 14:51:41 -0800 (PST)
In-Reply-To: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: s.hauer@pengutronuix.de, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Marc Reilly <marc@cpdesign.com.au>

The way the raw touchscreen co-ordinates are sampled have some minor
differences for the mc13892 and mc13873. This patch introduces an IC
specific handler to convert the raw samples into x, y, pressure readings
for the input sub-system.
The mc13892 ignores samples that have too high a contact resistance.
Behaviour for the mc13873 is (intended to be) preserved.

Help text for the config item changes to reflect support for both IC
types

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/input/touchscreen/Kconfig      |    2 +-
 drivers/input/touchscreen/mc13xxx_ts.c |  132 +++++++++++++++++++++++++++-----
 2 files changed, 115 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 79831d9..0c44b37 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -552,7 +552,7 @@ config TOUCHSCREEN_MC13XXX
 	tristate "Freescale MC13xxx touchscreen input driver"
 	depends on MFD_MC13XXX
 	help
-	  Say Y here if you have an Freescale MC13783 PMIC on your
+	  Say Y here if you have an Freescale MC13xxx PMIC on your
 	  board and want to use its touchscreen
 
 	  If unsure, say N.
diff --git a/drivers/input/touchscreen/mc13xxx_ts.c b/drivers/input/touchscreen/mc13xxx_ts.c
index 2c000a9..264b977 100644
--- a/drivers/input/touchscreen/mc13xxx_ts.c
+++ b/drivers/input/touchscreen/mc13xxx_ts.c
@@ -3,6 +3,7 @@
  *
  * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
  * Copyright (C) 2009 Sascha Hauer, Pengutronix
+ * Copyright 2011 Marc Reilly, Creative Product Design
  *
  * Initial development of this code was funded by
  * Phytec Messtechnik GmbH, http://www.phytec.de/
@@ -27,8 +28,8 @@
 static unsigned int sample_tolerance = DEFAULT_SAMPLE_TOLERANCE;
 module_param(sample_tolerance, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(sample_tolerance,
-		"If the minimal and maximal value read out for one axis (out "
-		"of three) differ by this value (default: "
+		"If the minimal and maximal value read out for one axis "
+		"differ by this value (default: "
 		__stringify(DEFAULT_SAMPLE_TOLERANCE) ") or more, the reading "
 		"is supposed to be wrong and is discarded.  Set to 0 to "
 		"disable this check.");
@@ -36,9 +37,14 @@ MODULE_PARM_DESC(sample_tolerance,
 struct mc13xxx_ts_priv {
 	struct input_dev *idev;
 	struct mc13xxx *mc13xxx;
+
 	struct delayed_work work;
 	struct workqueue_struct *workq;
+
 	unsigned int sample[4];
+
+	bool (*convert_and_check_samples)(struct mc13xxx_ts_priv *priv,
+			int *x, int *y, int *pressure);
 };
 
 static irqreturn_t mc13xxx_ts_handler(int irq, void *data)
@@ -67,9 +73,9 @@ static irqreturn_t mc13xxx_ts_handler(int irq, void *data)
 			swap(a0, a1);					\
 		})
 
-static void mc13xxx_ts_report_sample(struct mc13xxx_ts_priv *priv)
+static bool mc13783_convert_and_check_samples(struct mc13xxx_ts_priv *priv,
+		int *x, int *y, int *pressure)
 {
-	struct input_dev *idev = priv->idev;
 	int x0, x1, x2, y0, y1, y2;
 	int cr0, cr1;
 
@@ -86,32 +92,100 @@ static void mc13xxx_ts_report_sample(struct mc13xxx_ts_priv *priv)
 	cr0 = (priv->sample[2] >> 12) & 0xfff;
 	cr1 = (priv->sample[3] >> 12) & 0xfff;
 
-	dev_dbg(&idev->dev,
+	dev_dbg(&priv->idev->dev,
 		"x: (% 4d,% 4d,% 4d) y: (% 4d, % 4d,% 4d) cr: (% 4d, % 4d)\n",
 		x0, x1, x2, y0, y1, y2, cr0, cr1);
 
 	sort3(x0, x1, x2);
 	sort3(y0, y1, y2);
 
+	if (sample_tolerance && ((x2 - x0 >= sample_tolerance)
+				|| (y2 - y0 >= sample_tolerance)))
+		return false;
+
+	/* report the median coordinate and average pressure */
+	*x = x1;
+	*y = y1;
 	cr0 = (cr0 + cr1) / 2;
+	*pressure = cr0 ? 0x1000 - cr0 : cr0;
 
-	if (!cr0 || !sample_tolerance ||
-			(x2 - x0 < sample_tolerance &&
-			 y2 - y0 < sample_tolerance)) {
-		/* report the median coordinate and average pressure */
-		if (cr0) {
-			input_report_abs(idev, ABS_X, x1);
-			input_report_abs(idev, ABS_Y, y1);
+	return true;
+}
+
+/*
+ * Any ADC readings for contact pressure are only valid below if they are
+ * below TOUCHED_ADC_THRESH. We don't use the full scale of the ADC because
+ * the touchscreen doesn't always read 0xfff when the ts is not touched.
+ */
+#define TOUCHED_ADC_THRESH 2048
+static bool mc13892_convert_and_check_samples(struct mc13xxx_ts_priv *priv,
+		int *x, int *y, int *pressure)
+{
+	int x0, x1, y0, y1;
+	int cr0, cr1;
+	bool both_cr_invalid;
+
+	/*
+	 * the values are 10-bit wide only, but the two least significant
+	 * bits are for future 12 bit use and reading yields 0
+	 */
+	x0 = priv->sample[0] & 0xfff;
+	x1 = priv->sample[1] & 0xfff;
+	y0 = priv->sample[3] & 0xfff;
+	y1 = (priv->sample[0] >> 12) & 0xfff;
+	cr0 = (priv->sample[2] >> 12) & 0xfff;
+	cr1 = (priv->sample[3] >> 12) & 0xfff;
+
+	dev_dbg(&priv->idev->dev,
+		"x: (%4d,%4d) y: (%4d, %4d) cr: (%4d, %4d)\n",
+		x0, x1, y0, y1, cr0, cr1);
+
+	/*
+	 * if both cr values are above threshold then the pen up has occurred,
+	 * but the values can often be quite far apart, so don't filter them
+	 * out based on sample tolerance in this case.
+	 */
+	both_cr_invalid = (cr0 > TOUCHED_ADC_THRESH)
+			&& (cr1 > TOUCHED_ADC_THRESH);
+
+	if (sample_tolerance &&
+			(((abs(x1 - x0) >= sample_tolerance)
+			|| (abs(y1 - y0) >= sample_tolerance))
+			|| (!both_cr_invalid
+				&& (abs(cr0 - cr1) >= sample_tolerance))))
+		return false;
+
+	*x = (x0 + x1) / 2;
+	*y = (y0 + y1) / 2;
+	cr0 = (cr0 + cr1) / 2;
+
+	/* turn contact resistance into pressure. */
+	if (both_cr_invalid || (cr0 >= TOUCHED_ADC_THRESH))
+		*pressure = 0;
+	else
+		*pressure = TOUCHED_ADC_THRESH - cr0;
+
+	return true;
+}
+
+static void mc13xxx_ts_report_sample(struct mc13xxx_ts_priv *priv)
+{
+	struct input_dev *idev = priv->idev;
+	int x, y, pressure;
+
+	if (priv->convert_and_check_samples(priv, &x, &y, &pressure)) {
+		if (pressure) {
+			input_report_abs(idev, ABS_X, x);
+			input_report_abs(idev, ABS_Y, y);
 
 			dev_dbg(&idev->dev, "report (%d, %d, %d)\n",
-					x1, y1, 0x1000 - cr0);
+					x, y, pressure);
 			queue_delayed_work(priv->workq, &priv->work, HZ / 50);
 		} else
 			dev_dbg(&idev->dev, "report release\n");
 
-		input_report_abs(idev, ABS_PRESSURE,
-				cr0 ? 0x1000 - cr0 : cr0);
-		input_report_key(idev, BTN_TOUCH, cr0);
+		input_report_abs(idev, ABS_PRESSURE, pressure);
+		input_report_key(idev, BTN_TOUCH, pressure ? 1 : 0);
 		input_sync(idev);
 	} else
 		dev_dbg(&idev->dev, "discard event\n");
@@ -165,10 +239,14 @@ static void mc13xxx_ts_close(struct input_dev *dev)
 	cancel_delayed_work_sync(&priv->work);
 }
 
+#define DRIVERID_MC13783	0
+#define DRIVERID_MC13892	1
+
 static int __init mc13xxx_ts_probe(struct platform_device *pdev)
 {
 	struct mc13xxx_ts_priv *priv;
 	struct input_dev *idev;
+	const struct platform_device_id *devid;
 	int ret = -ENOMEM;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -195,11 +273,26 @@ static int __init mc13xxx_ts_probe(struct platform_device *pdev)
 	idev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 	input_set_abs_params(idev, ABS_X, 0, 0xfff, 0, 0);
 	input_set_abs_params(idev, ABS_Y, 0, 0xfff, 0, 0);
-	input_set_abs_params(idev, ABS_PRESSURE, 0, 0xfff, 0, 0);
 
 	idev->open = mc13xxx_ts_open;
 	idev->close = mc13xxx_ts_close;
 
+	devid = platform_get_device_id(pdev);
+
+	if (devid->driver_data == DRIVERID_MC13783) {
+		input_set_abs_params(idev, ABS_PRESSURE, 0, 0xfff, 0, 0);
+		priv->convert_and_check_samples =
+				mc13783_convert_and_check_samples;
+	} else if (devid->driver_data == DRIVERID_MC13892) {
+		input_set_abs_params(idev, ABS_PRESSURE, 0,
+				TOUCHED_ADC_THRESH - 1, 0, 0);
+		priv->convert_and_check_samples =
+				mc13892_convert_and_check_samples;
+	} else {
+		ret = -ENODEV;
+		goto err_destroy_wq;
+	}
+
 	input_set_drvdata(idev, priv);
 
 	ret = input_register_device(priv->idev);
@@ -232,10 +325,13 @@ static int __devexit mc13xxx_ts_remove(struct platform_device *pdev)
 
 	return 0;
 }
-
 const struct platform_device_id mc13xxx_ts_idtable[] = {
 	{
 		.name = "mc13783-ts",
+		.driver_data = DRIVERID_MC13783,
+	}, {
+		.name = "mc13892-ts",
+		.driver_data = DRIVERID_MC13892,
 	},
 	{ }
 };
-- 
1.7.3.4

