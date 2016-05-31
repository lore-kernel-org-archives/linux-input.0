From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/8] mfd: ti_am335x_tscadc: Use SIMPLE_DEV_PM_OPS helper macro
Date: Tue, 31 May 2016 12:00:06 -0500
Message-ID: <20160531170013.2649-2-afd@ti.com>
References: <20160531170013.2649-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60085 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204AbcEaRAf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2016 13:00:35 -0400
In-Reply-To: <20160531170013.2649-1-afd@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Dave Gerlach <d-gerlach@ti.com>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>

Replace ifdefs with SIMPLE_DEV_PM_OPS helper macro.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index e4e4b22..644128b 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -310,8 +310,7 @@ static int ti_tscadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int tscadc_suspend(struct device *dev)
+static int __maybe_unused tscadc_suspend(struct device *dev)
 {
 	struct ti_tscadc_dev	*tscadc_dev = dev_get_drvdata(dev);
 
@@ -321,7 +320,7 @@ static int tscadc_suspend(struct device *dev)
 	return 0;
 }
 
-static int tscadc_resume(struct device *dev)
+static int __maybe_unused tscadc_resume(struct device *dev)
 {
 	struct ti_tscadc_dev	*tscadc_dev = dev_get_drvdata(dev);
 	u32 ctrl;
@@ -347,14 +346,7 @@ static int tscadc_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops tscadc_pm_ops = {
-	.suspend = tscadc_suspend,
-	.resume = tscadc_resume,
-};
-#define TSCADC_PM_OPS (&tscadc_pm_ops)
-#else
-#define TSCADC_PM_OPS NULL
-#endif
+static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
 
 static const struct of_device_id ti_tscadc_dt_ids[] = {
 	{ .compatible = "ti,am3359-tscadc", },
@@ -365,7 +357,7 @@ MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
 static struct platform_driver ti_tscadc_driver = {
 	.driver = {
 		.name   = "ti_am3359-tscadc",
-		.pm	= TSCADC_PM_OPS,
+		.pm	= &tscadc_pm_ops,
 		.of_match_table = ti_tscadc_dt_ids,
 	},
 	.probe	= ti_tscadc_probe,
-- 
2.8.3

