From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: wm831x-ts - Convert to devm_kzalloc()
Date: Thu, 22 Dec 2011 10:22:07 +0000
Message-ID: <1324549327-4494-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39910 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753867Ab1LVKWO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Dec 2011 05:22:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dimitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pathes@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

Saves a little code and eliminates the possibility of introducing some
leaks.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm831x-ts.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index d81482e..e34c10a 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -245,7 +245,8 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
 	if (core_pdata)
 		pdata = core_pdata->touch;
 
-	wm831x_ts = kzalloc(sizeof(struct wm831x_ts), GFP_KERNEL);
+	wm831x_ts = devm_kzalloc(&pdev->dev, sizeof(struct wm831x_ts),
+				 GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!wm831x_ts || !input_dev) {
 		error = -ENOMEM;
@@ -375,7 +376,6 @@ err_data_irq:
 	free_irq(wm831x_ts->data_irq, wm831x_ts);
 err_alloc:
 	input_free_device(input_dev);
-	kfree(wm831x_ts);
 
 	return error;
 }
@@ -387,7 +387,6 @@ static __devexit int wm831x_ts_remove(struct platform_device *pdev)
 	free_irq(wm831x_ts->pd_irq, wm831x_ts);
 	free_irq(wm831x_ts->data_irq, wm831x_ts);
 	input_unregister_device(wm831x_ts->input_dev);
-	kfree(wm831x_ts);
 
 	return 0;
 }
-- 
1.7.7.3

