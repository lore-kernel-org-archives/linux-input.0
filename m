From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] input: Convert wm831x-on to use genirq
Date: Wed, 10 Mar 2010 18:31:06 +0000
Message-ID: <1268245866-19285-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34260 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932698Ab0CJScw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Mar 2010 13:32:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Now that the WM831x core has been converted to use genirq for the
interrupt controller there is no need for the client drivers to
use a WM831x-specific API rather than just calling genirq directly.

Also fixes a leak of the IRQ during init failure - the error path
free_irq() was using NULL rather than the driver data as the data
pointer so free_irq() wouldn't have matched.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/misc/wm831x-on.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index ba4f5dd..1e54bce 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -97,8 +97,9 @@ static int __devinit wm831x_on_probe(struct platform_device *pdev)
 	wm831x_on->dev->phys = "wm831x_on/input0";
 	wm831x_on->dev->dev.parent = &pdev->dev;
 
-	ret = wm831x_request_irq(wm831x, irq, wm831x_on_irq,
-				 IRQF_TRIGGER_RISING, "wm831x_on", wm831x_on);
+	ret = request_threaded_irq(irq, NULL, wm831x_on_irq,
+				   IRQF_TRIGGER_RISING, "wm831x_on",
+				   wm831x_on);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to request IRQ: %d\n", ret);
 		goto err_input_dev;
@@ -114,7 +115,7 @@ static int __devinit wm831x_on_probe(struct platform_device *pdev)
 	return 0;
 
 err_irq:
-	wm831x_free_irq(wm831x, irq, NULL);
+	free_irq(irq, wm831x_on);
 err_input_dev:
 	input_free_device(wm831x_on->dev);
 err:
@@ -127,7 +128,7 @@ static int __devexit wm831x_on_remove(struct platform_device *pdev)
 	struct wm831x_on *wm831x_on = platform_get_drvdata(pdev);
 	int irq = platform_get_irq(pdev, 0);
 
-	wm831x_free_irq(wm831x_on->wm831x, irq, wm831x_on);
+	free_irq(irq, wm831x_on);
 	cancel_delayed_work_sync(&wm831x_on->work);
 	input_unregister_device(wm831x_on->dev);
 	kfree(wm831x_on);
-- 
1.7.0

