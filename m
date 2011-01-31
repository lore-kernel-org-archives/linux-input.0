From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: wm831x-ts - Remove use of ternery operator
Date: Mon, 31 Jan 2011 12:01:55 +0000
Message-ID: <1296475315-15704-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42364 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755719Ab1AaMB6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Jan 2011 07:01:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolsfonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

While being applied the driver was modified to add use of the ternery
operator. Write the conditionals out longhand as I find it terribly
unhelpful for legibility.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This is a bit of a preference issue but as I'm most likely to be
updating the code it would be very helpful if you could apply it.

 drivers/input/touchscreen/wm831x-ts.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index a6121bd..1022f71 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -76,9 +76,14 @@ static irqreturn_t wm831x_ts_data_irq(int irq, void *irq_data)
 	struct wm831x *wm831x = wm831x_ts->wm831x;
 	static int data_types[] = { ABS_X, ABS_Y, ABS_PRESSURE };
 	u16 data[3];
-	int count = wm831x_ts->pressure ? 3 : 2;
+	int count;
 	int i, ret;
 
+	if (wm831x_ts->pressure)
+		count = 3;
+	else
+		count = 2;
+
 	wm831x_set_bits(wm831x, WM831X_INTERRUPT_STATUS_1,
 			WM831X_TCHDATA_EINT, WM831X_TCHDATA_EINT);
 
@@ -134,10 +139,11 @@ static irqreturn_t wm831x_ts_pen_down_irq(int irq, void *irq_data)
 {
 	struct wm831x_ts *wm831x_ts = irq_data;
 	struct wm831x *wm831x = wm831x_ts->wm831x;
-	int ena;
+	int ena = 0;
 
 	/* Start collecting data */
-	ena = wm831x_ts->pressure ? WM831X_TCH_Z_ENA : 0;
+	if (wm831x_ts->pressure)
+		ena |= WM831X_TCH_Z_ENA;
 
 	wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
 			WM831X_TCH_X_ENA | WM831X_TCH_Y_ENA | WM831X_TCH_Z_ENA,
@@ -188,11 +194,13 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
 	struct wm831x_ts *wm831x_ts;
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_pdata *core_pdata = dev_get_platdata(pdev->dev.parent);
-	struct wm831x_touch_pdata *pdata =
-			core_pdata ? core_pdata->touch : NULL;
+	struct wm831x_touch_pdata *pdata = NULL;
 	struct input_dev *input_dev;
 	int error;
 
+	if (core_pdata)
+		pdata = core_pdata->touch;
+
 	wm831x_ts = kzalloc(sizeof(struct wm831x_ts), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!wm831x_ts || !input_dev) {
-- 
1.7.2.3

