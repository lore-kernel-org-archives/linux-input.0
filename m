From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/6] Input: ucb1400-ts - switch to using dev_xxx() for diagnostic messages
Date: Mon, 14 Nov 2011 00:36:11 -0800
Message-ID: <1321259771-10925-6-git-send-email-dmitry.torokhov@gmail.com>
References: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41283 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab1KNIgW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:36:22 -0500
Received: by mail-gy0-f174.google.com with SMTP id 15so4644489gyc.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:36:22 -0800 (PST)
In-Reply-To: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marek.vasut@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/ucb1400_ts.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 1862633..67f56a5 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -274,7 +274,8 @@ static void ucb1400_ts_close(struct input_dev *idev)
  * Try to probe our interrupt, rather than relying on lots of
  * hard-coded machine dependencies.
  */
-static int __devinit ucb1400_ts_detect_irq(struct ucb1400_ts *ucb)
+static int __devinit ucb1400_ts_detect_irq(struct ucb1400_ts *ucb,
+					   struct platform_device *pdev)
 {
 	unsigned long mask, timeout;
 
@@ -296,7 +297,7 @@ static int __devinit ucb1400_ts_detect_irq(struct ucb1400_ts *ucb)
 						UCB_ADC_DAT_VALID)) {
 		cpu_relax();
 		if (time_after(jiffies, timeout)) {
-			printk(KERN_ERR "ucb1400: timed out in IRQ probe\n");
+			dev_err(&pdev->dev, "timed out in IRQ probe\n");
 			probe_irq_off(mask);
 			return -ENODEV;
 		}
@@ -331,13 +332,13 @@ static int __devinit ucb1400_ts_probe(struct platform_device *pdev)
 
 	/* Only in case the IRQ line wasn't supplied, try detecting it */
 	if (ucb->irq < 0) {
-		error = ucb1400_ts_detect_irq(ucb);
+		error = ucb1400_ts_detect_irq(ucb, pdev);
 		if (error) {
-			printk(KERN_ERR "UCB1400: IRQ probe failed\n");
+			dev_err(&pdev->dev, "IRQ probe failed\n");
 			goto err_free_devs;
 		}
 	}
-	printk(KERN_DEBUG "UCB1400: found IRQ %d\n", ucb->irq);
+	dev_dbg(&pdev->dev, "found IRQ %d\n", ucb->irq);
 
 	init_waitqueue_head(&ucb->ts_wait);
 
@@ -365,7 +366,7 @@ static int __devinit ucb1400_ts_probe(struct platform_device *pdev)
 	x_res = ucb1400_ts_read_xres(ucb);
 	y_res = ucb1400_ts_read_yres(ucb);
 	ucb1400_adc_disable(ucb->ac97);
-	printk(KERN_DEBUG "UCB1400: x/y = %d/%d\n", x_res, y_res);
+	dev_dbg(&pdev->dev, "x/y = %d/%d\n", x_res, y_res);
 
 	input_set_abs_params(ucb->ts_idev, ABS_X, 0, x_res, 0, 0);
 	input_set_abs_params(ucb->ts_idev, ABS_Y, 0, y_res, 0, 0);
@@ -377,8 +378,8 @@ static int __devinit ucb1400_ts_probe(struct platform_device *pdev)
 				     IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 				     "UCB1400", ucb);
 	if (error) {
-		printk(KERN_ERR "ucb1400: unable to grab irq%d: %d\n",
-				ucb->irq, error);
+		dev_err(&pdev->dev,
+			"unable to grab irq%d: %d\n", ucb->irq, error);
 		goto err_free_devs;
 	}
 
-- 
1.7.6.4

