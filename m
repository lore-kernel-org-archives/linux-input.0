From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ti_am335x_tsc - use SIMPLE_DEV_PM_OPS
Date: Thu, 7 Jan 2016 17:33:29 -0800
Message-ID: <20160108013329.GA33290@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35084 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbcAHBde (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2016 20:33:34 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Vignesh R <vigneshr@ti.com>, Brad Griffis <bgriffis@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org

Instead of doing the dance with macro that either resolves to a pointer or
NULL, let's switch to using SIMPLE_DEV_PM_OPS().

Also let's mark suspend and resume methods as __maybe_unused instead of
guarding them with an #ifdef and rely on linker to drop unused code. Doing
so should allow better compile coverage.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index a21a07c..8b3f15c 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -487,8 +487,7 @@ static int titsc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int titsc_suspend(struct device *dev)
+static int __maybe_unused titsc_suspend(struct device *dev)
 {
 	struct titsc *ts_dev = dev_get_drvdata(dev);
 	struct ti_tscadc_dev *tscadc_dev;
@@ -504,7 +503,7 @@ static int titsc_suspend(struct device *dev)
 	return 0;
 }
 
-static int titsc_resume(struct device *dev)
+static int __maybe_unused titsc_resume(struct device *dev)
 {
 	struct titsc *ts_dev = dev_get_drvdata(dev);
 	struct ti_tscadc_dev *tscadc_dev;
@@ -521,14 +520,7 @@ static int titsc_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops titsc_pm_ops = {
-	.suspend = titsc_suspend,
-	.resume  = titsc_resume,
-};
-#define TITSC_PM_OPS (&titsc_pm_ops)
-#else
-#define TITSC_PM_OPS NULL
-#endif
+static SIMPLE_DEV_PM_OPS(titsc_pm_ops, titsc_suspend, titsc_resume);
 
 static const struct of_device_id ti_tsc_dt_ids[] = {
 	{ .compatible = "ti,am3359-tsc", },
@@ -541,7 +533,7 @@ static struct platform_driver ti_tsc_driver = {
 	.remove	= titsc_remove,
 	.driver	= {
 		.name   = "TI-am335x-tsc",
-		.pm	= TITSC_PM_OPS,
+		.pm	= &titsc_pm_ops,
 		.of_match_table = ti_tsc_dt_ids,
 	},
 };
-- 
2.6.0.rc2.230.g3dd15c0


-- 
Dmitry
