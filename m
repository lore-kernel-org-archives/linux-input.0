From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] Input: wm831x-ts - Remove unneeded clearing of driver data
Date: Wed, 18 Apr 2012 18:28:05 +0100
Message-ID: <1334770087-20616-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36222 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753810Ab2DRR2K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 13:28:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

This is unneeded, only a bound driver can use driver data and a driver
relying on the state prior to probe() is buggy.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm831x-ts.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 4bc851a..d81482e 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -389,7 +389,6 @@ static __devexit int wm831x_ts_remove(struct platform_device *pdev)
 	input_unregister_device(wm831x_ts->input_dev);
 	kfree(wm831x_ts);
 
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-- 
1.7.10

