From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/6] Input: usb1400_ts - add __devinit/__devexit section annotations
Date: Mon, 14 Nov 2011 00:36:08 -0800
Message-ID: <1321259771-10925-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61575 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab1KNIgT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:36:19 -0500
Received: by yenr9 with SMTP id r9so4903733yen.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:36:18 -0800 (PST)
In-Reply-To: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marek.vasut@gmail.com>

Add __devinit/__devexit sections annotations so parts of code could be
discarded after completing driver initialization.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/ucb1400_ts.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 550249b..db525ac 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -299,7 +299,7 @@ static void ucb1400_ts_close(struct input_dev *idev)
  * Try to probe our interrupt, rather than relying on lots of
  * hard-coded machine dependencies.
  */
-static int ucb1400_ts_detect_irq(struct ucb1400_ts *ucb)
+static int __devinit ucb1400_ts_detect_irq(struct ucb1400_ts *ucb)
 {
 	unsigned long mask, timeout;
 
@@ -342,7 +342,7 @@ static int ucb1400_ts_detect_irq(struct ucb1400_ts *ucb)
 	return 0;
 }
 
-static int ucb1400_ts_probe(struct platform_device *dev)
+static int __devinit ucb1400_ts_probe(struct platform_device *dev)
 {
 	int error, x_res, y_res;
 	u16 fcsr;
@@ -416,15 +416,15 @@ err_free_devs:
 	input_free_device(ucb->ts_idev);
 err:
 	return error;
-
 }
 
-static int ucb1400_ts_remove(struct platform_device *dev)
+static int __devexit ucb1400_ts_remove(struct platform_device *dev)
 {
 	struct ucb1400_ts *ucb = dev->dev.platform_data;
 
 	free_irq(ucb->irq, ucb);
 	input_unregister_device(ucb->ts_idev);
+
 	return 0;
 }
 
@@ -450,7 +450,7 @@ static SIMPLE_DEV_PM_OPS(ucb1400_ts_pm_ops, NULL, ucb1400_ts_resume);
 
 static struct platform_driver ucb1400_ts_driver = {
 	.probe	= ucb1400_ts_probe,
-	.remove	= ucb1400_ts_remove,
+	.remove	= __devexit_p(ucb1400_ts_remove),
 	.driver	= {
 		.name	= "ucb1400_ts",
 		.owner	= THIS_MODULE,
-- 
1.7.6.4

