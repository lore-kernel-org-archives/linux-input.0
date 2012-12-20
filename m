From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: wm831x-on - Convert to devm_input_allocate_device()
Date: Thu, 20 Dec 2012 13:15:58 +0000
Message-ID: <1356009358-4638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37594 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751628Ab2LTNQB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Dec 2012 08:16:01 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/misc/wm831x-on.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index 558767d..caa2c406 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -86,7 +86,7 @@ static int wm831x_on_probe(struct platform_device *pdev)
 	wm831x_on->wm831x = wm831x;
 	INIT_DELAYED_WORK(&wm831x_on->work, wm831x_poll_on);
 
-	wm831x_on->dev = input_allocate_device();
+	wm831x_on->dev = devm_input_allocate_device(&pdev->dev);
 	if (!wm831x_on->dev) {
 		dev_err(&pdev->dev, "Can't allocate input dev\n");
 		ret = -ENOMEM;
@@ -119,7 +119,6 @@ static int wm831x_on_probe(struct platform_device *pdev)
 err_irq:
 	free_irq(irq, wm831x_on);
 err_input_dev:
-	input_free_device(wm831x_on->dev);
 err:
 	return ret;
 }
@@ -131,7 +130,6 @@ static int wm831x_on_remove(struct platform_device *pdev)
 
 	free_irq(irq, wm831x_on);
 	cancel_delayed_work_sync(&wm831x_on->work);
-	input_unregister_device(wm831x_on->dev);
 
 	return 0;
 }
-- 
1.7.10.4

