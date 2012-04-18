From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] Input: wm831x-on - Convert to devm_kzalloc()
Date: Wed, 18 Apr 2012 18:28:07 +0100
Message-ID: <1334770087-20616-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1334770087-20616-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36224 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754231Ab2DRR2K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 13:28:10 -0400
In-Reply-To: <1334770087-20616-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Saves a small amount of code and reduces the potential for leaks.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/misc/wm831x-on.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index 47f18d6..aee53fb 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -76,7 +76,8 @@ static int __devinit wm831x_on_probe(struct platform_device *pdev)
 	int irq = platform_get_irq(pdev, 0);
 	int ret;
 
-	wm831x_on = kzalloc(sizeof(struct wm831x_on), GFP_KERNEL);
+	wm831x_on = devm_kzalloc(&pdev->dev, sizeof(struct wm831x_on),
+				 GFP_KERNEL);
 	if (!wm831x_on) {
 		dev_err(&pdev->dev, "Can't allocate data\n");
 		return -ENOMEM;
@@ -120,7 +121,6 @@ err_irq:
 err_input_dev:
 	input_free_device(wm831x_on->dev);
 err:
-	kfree(wm831x_on);
 	return ret;
 }
 
@@ -132,7 +132,6 @@ static int __devexit wm831x_on_remove(struct platform_device *pdev)
 	free_irq(irq, wm831x_on);
 	cancel_delayed_work_sync(&wm831x_on->work);
 	input_unregister_device(wm831x_on->dev);
-	kfree(wm831x_on);
 
 	return 0;
 }
-- 
1.7.10

