From: yegorslists@googlemail.com
Subject: [PATCH v2 2/3] tps6507x-ts: add DT support
Date: Thu,  9 Mar 2017 15:31:08 +0100
Message-ID: <1489069869-3849-3-git-send-email-yegorslists@googlemail.com>
References: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36428 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbdCIOcH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2017 09:32:07 -0500
Received: by mail-wm0-f68.google.com with SMTP id v190so11224443wme.3
        for <linux-input@vger.kernel.org>; Thu, 09 Mar 2017 06:31:42 -0800 (PST)
In-Reply-To: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, lee.jones@linaro.org, robh@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com, nsekhar@ti.com, khilman@baylibre.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

This patch adds support for DT to tps6507x-ts driver.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/input/touchscreen/tps6507x-ts.c | 40 ++++++++++-----------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index fbaa2f68..502ed0c 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -22,6 +22,8 @@
 #include <linux/mfd/tps6507x.h>
 #include <linux/input/tps6507x-ts.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #define TSC_DEFAULT_POLL_PERIOD 30 /* ms */
 #define TPS_DEFAULT_MIN_PRESSURE 0x30
@@ -202,30 +204,11 @@ static void tps6507x_ts_poll(struct input_polled_dev *poll_dev)
 static int tps6507x_ts_probe(struct platform_device *pdev)
 {
 	struct tps6507x_dev *tps6507x_dev = dev_get_drvdata(pdev->dev.parent);
-	const struct tps6507x_board *tps_board;
-	const struct touchscreen_init_data *init_data;
 	struct tps6507x_ts *tsc;
 	struct input_polled_dev *poll_dev;
 	struct input_dev *input_dev;
 	int error;
 
-	/*
-	 * tps_board points to pmic related constants
-	 * coming from the board-evm file.
-	 */
-	tps_board = dev_get_platdata(tps6507x_dev->dev);
-	if (!tps_board) {
-		dev_err(tps6507x_dev->dev,
-			"Could not find tps6507x platform data\n");
-		return -ENODEV;
-	}
-
-	/*
-	 * init_data points to array of regulator_init structures
-	 * coming from the board-evm file.
-	 */
-	init_data = tps_board->tps6507x_ts_init_data;
-
 	tsc = devm_kzalloc(&pdev->dev, sizeof(struct tps6507x_ts), GFP_KERNEL);
 	if (!tsc) {
 		dev_err(tps6507x_dev->dev, "failed to allocate driver data\n");
@@ -234,8 +217,6 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 
 	tsc->mfd = tps6507x_dev;
 	tsc->dev = tps6507x_dev->dev;
-	tsc->min_pressure = init_data ?
-			init_data->min_pressure : TPS_DEFAULT_MIN_PRESSURE;
 
 	snprintf(tsc->phys, sizeof(tsc->phys),
 		 "%s/input0", dev_name(tsc->dev));
@@ -250,8 +231,6 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 
 	poll_dev->private = tsc;
 	poll_dev->poll = tps6507x_ts_poll;
-	poll_dev->poll_interval = init_data ?
-			init_data->poll_period : TSC_DEFAULT_POLL_PERIOD;
 
 	input_dev = poll_dev->input;
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
@@ -265,11 +244,16 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 	input_dev->phys = tsc->phys;
 	input_dev->dev.parent = tsc->dev;
 	input_dev->id.bustype = BUS_I2C;
-	if (init_data) {
-		input_dev->id.vendor = init_data->vendor;
-		input_dev->id.product = init_data->product;
-		input_dev->id.version = init_data->version;
-	}
+	input_dev->id.vendor = 0;
+	input_dev->id.product = 65070;
+	input_dev->id.version = 0x100;
+
+	tsc->poll_dev->poll_interval = TSC_DEFAULT_POLL_PERIOD;
+	tsc->min_pressure = TPS_DEFAULT_MIN_PRESSURE;
+	device_property_read_u32_array(tsc->dev, "ti,poll-period",
+				       &tsc->poll_dev->poll_interval, 1);
+	device_property_read_u16_array(tsc->dev, "ti,min-pressure",
+				       &tsc->min_pressure, 1);
 
 	error = tps6507x_adc_standby(tsc);
 	if (error)
-- 
2.1.4

