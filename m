From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: add da9034 touchscreen support
Date: Tue, 23 Dec 2008 04:34:29 -0500
Message-ID: <20081223093428.GD14302@anvil.corenet.prv>
References: <f17812d70812041810o57726d24j4feabfbe89e7c271@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:35199 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYLWJeg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Dec 2008 04:34:36 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1514301qwe.37
        for <linux-input@vger.kernel.org>; Tue, 23 Dec 2008 01:34:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f17812d70812041810o57726d24j4feabfbe89e7c271@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Dec 05, 2008 at 10:10:35AM +0800, Eric Miao wrote:
> From a3259123035102444c5868d825aa06fd9a49fad4 Mon Sep 17 00:00:00 2001
> From: Eric Miao <eric.miao@marvell.com>
> Date: Wed, 3 Dec 2008 13:39:28 +0800
> Subject: [PATCH] input: add da9034 touchscreen support
> 
> Add support for the built-in touchscreen controller in DA9034 (aka Micco),
> usually found on platforms with xscale processors.
> 
> Signed-off-by: Eric Miao <eric.miao@marvell.com>

Applied with the following changes, thank you Eric.

-- 
Dmitry

diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
index 9164d2d..fd00067 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -2,8 +2,8 @@
  * Touchscreen driver for Dialog Semiconductor DA9034
  *
  * Copyright (C) 2006-2008 Marvell International Ltd.
- * 	Fengwei Yin <fengwei.yin@marvell.com>
- * 	Eric Miao <eric.miao@marvell.com>
+ *	Fengwei Yin <fengwei.yin@marvell.com>
+ *	Eric Miao <eric.miao@marvell.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -98,6 +98,7 @@ static int read_tsi(struct da9034_touch *touch)
 
 	touch->last_x = ((_x << 2) & 0x3fc) | (_v & 0x3);
 	touch->last_y = ((_y << 2) & 0x3fc) | ((_v & 0xc) >> 2);
+
 	return 0;
 }
 
@@ -118,12 +119,15 @@ static inline void report_pen_down(struct da9034_touch *touch)
 	int x = touch->last_x;
 	int y = touch->last_y;
 
-	x &= 0xfff; x = touch->x_inverted ? (1024 - x) : x;
-	y &= 0xfff; y = touch->y_inverted ? (1024 - y) : y;
+	x &= 0xfff;
+	if (touch->x_inverted)
+		x = 1024 - x;
+	y &= 0xfff;
+	if (touch->y_inverted)
+		y = 1024 - y;
 
 	input_report_abs(touch->input_dev, ABS_X, x);
 	input_report_abs(touch->input_dev, ABS_Y, y);
-	input_report_abs(touch->input_dev, ABS_PRESSURE, 255);
 	input_report_key(touch->input_dev, BTN_TOUCH, 1);
 
 	input_sync(touch->input_dev);
@@ -131,15 +135,13 @@ static inline void report_pen_down(struct da9034_touch *touch)
 
 static inline void report_pen_up(struct da9034_touch *touch)
 {
-	input_report_abs(touch->input_dev, ABS_PRESSURE, 0);
 	input_report_key(touch->input_dev, BTN_TOUCH, 0);
-
 	input_sync(touch->input_dev);
 }
 
 static void da9034_event_handler(struct da9034_touch *touch, int event)
 {
-	int err = 0;
+	int err;
 
 	switch (touch->state) {
 	case STATE_IDLE:
@@ -163,7 +165,7 @@ static void da9034_event_handler(struct da9034_touch *touch, int event)
 		err = read_tsi(touch);
 		if (err)
 			goto err_reset;
-		
+
 		/* Disable auto measurement of the TSI, so that
 		 * pen down status will be available
 		 */
@@ -263,6 +265,7 @@ static int da9034_touch_open(struct input_dev *dev)
 
 	touch->state = STATE_IDLE;
 	detect_pen_down(touch, 1);
+
 	return 0;
 }
 
@@ -290,7 +293,7 @@ static int __devinit da9034_touch_probe(struct platform_device *pdev)
 	struct da9034_touch_pdata *pdata = pdev->dev.platform_data;
 	struct da9034_touch *touch;
 	struct input_dev *input_dev;
-	int ret = 0;
+	int ret;
 
 	touch = kzalloc(sizeof(struct da9034_touch), GFP_KERNEL);
 	if (touch == NULL) {
@@ -298,7 +301,7 @@ static int __devinit da9034_touch_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	touch->da9034_dev	= pdev->dev.parent;
+	touch->da9034_dev = pdev->dev.parent;
 
 	if (pdata) {
 		touch->interval_ms	= pdata->interval_ms;
@@ -323,14 +326,14 @@ static int __devinit da9034_touch_probe(struct platform_device *pdev)
 	input_dev->close	= da9034_touch_close;
 	input_dev->dev.parent	= &pdev->dev;
 
-	set_bit(EV_ABS, input_dev->evbit);
-	set_bit(ABS_X, input_dev->absbit);
-	set_bit(ABS_Y, input_dev->absbit);
-	set_bit(ABS_PRESSURE, input_dev->absbit);
-
+	__set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(ABS_X, input_dev->absbit);
+	__set_bit(ABS_Y, input_dev->absbit);
 	input_set_abs_params(input_dev, ABS_X, 0, 1023, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y, 0, 1023, 0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 255, 0, 0);
+
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
 
 	touch->input_dev = input_dev;
 	input_set_drvdata(input_dev, touch);
@@ -353,7 +356,7 @@ static int __devexit da9034_touch_remove(struct platform_device *pdev)
 {
 	struct da9034_touch *touch = platform_get_drvdata(pdev);
 
-	input_free_device(touch->input_dev);
+	input_unregister_device(touch->input_dev);
 	kfree(touch);
 	return 0;
 }
@@ -364,7 +367,7 @@ static struct platform_driver da9034_touch_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= da9034_touch_probe,
-	.remove		= da9034_touch_remove,
+	.remove		= __devexit_p(da9034_touch_remove),
 };
 
 static int __init da9034_touch_init(void)
