From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] Input: wm831x-ts - Convert to devm_kzalloc()
Date: Wed, 18 Apr 2012 18:28:06 +0100
Message-ID: <1334770087-20616-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1334770087-20616-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36223 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754136Ab2DRR2K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 13:28:10 -0400
In-Reply-To: <1334770087-20616-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Saves a little code and eliminates the possibility of introducing some
leaks.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm831x-ts.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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
1.7.10

