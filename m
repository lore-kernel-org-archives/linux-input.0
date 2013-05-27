From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 12/19] iio & mfd & input: ti_tscadc: Match mfd sub devices to regmap interface
Date: Mon, 27 May 2013 21:11:59 +0200
Message-ID: <1369681926-22185-13-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48459 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3E0TN2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 May 2013 15:13:28 -0400
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, Pantelis Antoniou <panto@antoniou-consulting.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Pantelis Antoniou <panto@antoniou-consulting.com>

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c           |   26 +++++++++++++++++---------
 drivers/input/touchscreen/ti_am335x_tsc.c |   13 ++++++++++---
 drivers/mfd/ti_am335x_tscadc.c            |    1 +
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index cceff09..72ffe89 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -25,7 +25,9 @@
 #include <linux/of_device.h>
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
+#include <linux/regmap.h>
 
+#include <linux/io.h>
 #include <linux/mfd/ti_am335x_tscadc.h>
 
 struct tiadc_device {
@@ -37,13 +39,17 @@ struct tiadc_device {
 
 static unsigned int tiadc_readl(struct tiadc_device *adc, unsigned int reg)
 {
-	return readl(adc->mfd_tscadc->tscadc_base + reg);
+	unsigned int val;
+
+	val = (unsigned int)-1;
+	regmap_read(adc->mfd_tscadc->regmap_tscadc, reg, &val);
+	return val;
 }
 
 static void tiadc_writel(struct tiadc_device *adc, unsigned int reg,
 					unsigned int val)
 {
-	writel(val, adc->mfd_tscadc->tscadc_base + reg);
+	regmap_write(adc->mfd_tscadc->regmap_tscadc, reg, val);
 }
 
 static void tiadc_step_config(struct tiadc_device *adc_dev)
@@ -76,22 +82,24 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
 	tiadc_writel(adc_dev, REG_SE, STPENB_STEPENB);
 }
 
-static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
+static int tiadc_channel_init(struct iio_dev *indio_dev,
+		struct tiadc_device *adc_dev)
 {
 	struct iio_chan_spec *chan_array;
 	struct iio_chan_spec *chan;
 	char *s;
 	int i, len, size, ret;
+	int channels = adc_dev->channels;
 
-	size = indio_dev->num_channels * (sizeof(struct iio_chan_spec) + 6);
+	size = channels * (sizeof(struct iio_chan_spec) + 6);
 	chan_array = kzalloc(size, GFP_KERNEL);
 	if (chan_array == NULL)
 		return -ENOMEM;
 
 	/* buffer space is after the array */
-	s = (char *)(chan_array + indio_dev->num_channels);
+	s = (char *)(chan_array + channels);
 	chan = chan_array;
-	for (i = 0; i < indio_dev->num_channels; i++, chan++, s += len + 1) {
+	for (i = 0; i < channels; i++, chan++, s += len + 1) {
 
 		len = sprintf(s, "AIN%d", i);
 
@@ -107,8 +115,9 @@ static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
 	}
 
 	indio_dev->channels = chan_array;
+	indio_dev->num_channels = channels;
 
-	size = (indio_dev->num_channels + 1) * sizeof(struct iio_map);
+	size = (channels + 1) * sizeof(struct iio_map);
 	adc_dev->map = kzalloc(size, GFP_KERNEL);
 	if (adc_dev->map == NULL) {
 		kfree(chan_array);
@@ -214,7 +223,7 @@ static int tiadc_probe(struct platform_device *pdev)
 
 	tiadc_step_config(adc_dev);
 
-	err = tiadc_channel_init(indio_dev, adc_dev->channels);
+	err = tiadc_channel_init(indio_dev, adc_dev);
 	if (err < 0)
 		goto err_free_device;
 
@@ -223,7 +232,6 @@ static int tiadc_probe(struct platform_device *pdev)
 		goto err_free_channels;
 
 	platform_set_drvdata(pdev, indio_dev);
-
 	return 0;
 
 err_free_channels:
diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index b467196..0dbf3df 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 
@@ -65,13 +66,17 @@ struct titsc {
 
 static unsigned int titsc_readl(struct titsc *ts, unsigned int reg)
 {
-	return readl(ts->mfd_tscadc->tscadc_base + reg);
+	unsigned int val;
+
+	val = (unsigned int)-1;
+	regmap_read(ts->mfd_tscadc->regmap_tscadc, reg, &val);
+	return val;
 }
 
 static void titsc_writel(struct titsc *tsc, unsigned int reg,
 					unsigned int val)
 {
-	writel(val, tsc->mfd_tscadc->tscadc_base + reg);
+	regmap_write(tsc->mfd_tscadc->regmap_tscadc, reg, val);
 }
 
 /*
@@ -484,8 +489,10 @@ static int titsc_probe(struct platform_device *pdev)
 
 	/* register to the input system */
 	err = input_register_device(input_dev);
-	if (err)
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register input device\n");
 		goto err_free_irq;
+	}
 
 	platform_set_drvdata(pdev, ts_dev);
 	return 0;
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index bd127bd..a27401a 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -31,6 +31,7 @@ static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsigned int reg)
 {
 	unsigned int val;
 
+	val = (unsigned int)-1;
 	regmap_read(tsadc->regmap_tscadc, reg, &val);
 	return val;
 }
-- 
1.7.10.4

