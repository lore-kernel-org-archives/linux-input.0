From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 6/8] Input: s3c24xx_ts - Add FEAT for Samsung touchscreen support
Date: Wed, 19 May 2010 07:12:20 +0100
Message-ID: <1274249542-28795-7-git-send-email-ben-linux@fluff.org>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:56996 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab0ESGMZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 02:12:25 -0400
In-Reply-To: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: kgene.kim@samsung.com, ch.naveen@samsubng.com, dmitry.torokhov@gmail.com, Naveen Krishna <ch.naveen@samsung.com>, Ben Dooks <ben-linux@fluff.org>

From: Naveen Krishna <ch.naveen@samsung.com>

This patch adds a feature bit field in the touchscreen driver for Samsung SoCs.
Which can be used to distinguish the TSADC module features.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
[ben-linux@fluff.org: minor fix to title]
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/input/touchscreen/s3c2410_ts.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 86086a4..e0b7c83 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -55,6 +55,8 @@
 			 S3C2410_ADCTSC_AUTO_PST | \
 			 S3C2410_ADCTSC_XY_PST(0))
 
+#define FEAT_PEN_IRQ	(1 << 0)	/* HAS ADCCLRINTPNDNUP */
+
 /* Per-touchscreen data. */
 
 /**
@@ -69,6 +71,7 @@
  * @irq_tc: The interrupt number for pen up/down interrupt
  * @count: The number of samples collected.
  * @shift: The log2 of the maximum count to read in one go.
+ * @features: The features supported by the TSADC MOdule.
  */
 struct s3c2410ts {
 	struct s3c_adc_client *client;
@@ -81,6 +84,7 @@ struct s3c2410ts {
 	int irq_tc;
 	int count;
 	int shift;
+	int features;
 };
 
 static struct s3c2410ts ts;
@@ -171,6 +175,11 @@ static irqreturn_t stylus_irq(int irq, void *dev_id)
 	else
 		dev_info(ts.dev, "%s: count=%d\n", __func__, ts.count);
 
+	if (ts.features & FEAT_PEN_IRQ) {
+		/* Clear pen down/up interrupt */
+		writel(0x0, ts.io + S3C64XX_ADCCLRINTPNDNUP);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -317,6 +326,7 @@ static int __devinit s3c2410ts_probe(struct platform_device *pdev)
 	ts.input->id.version = 0x0102;
 
 	ts.shift = info->oversampling_shift;
+	ts.features = platform_get_device_id(pdev)->driver_data;
 
 	ret = request_irq(ts.irq_tc, stylus_irq, IRQF_DISABLED,
 			  "s3c2410_ts_pen", ts.input);
@@ -403,15 +413,14 @@ static struct dev_pm_ops s3c_ts_pmops = {
 #endif
 
 static struct platform_device_id s3cts_driver_ids[] = {
-	{ "s3c2410-ts", 0 },
-	{ "s3c2440-ts", 1 },
+	{ "s3c64xx-ts", FEAT_PEN_IRQ },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, s3cts_driver_ids);
 
 static struct platform_driver s3c_ts_driver = {
 	.driver         = {
-		.name   = "s3c24xx-ts",
+		.name   = "samsung-ts",
 		.owner  = THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm	= &s3c_ts_pmops,
-- 
1.6.3.3

