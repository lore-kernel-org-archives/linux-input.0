From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 5/8] Input: s3c24xx_ts - Implement generic GPIO configuration callback
Date: Wed, 19 May 2010 07:12:19 +0100
Message-ID: <1274249542-28795-6-git-send-email-ben-linux@fluff.org>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:57050 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab0ESGMk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 02:12:40 -0400
In-Reply-To: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: kgene.kim@samsung.com, ch.naveen@samsubng.com, dmitry.torokhov@gmail.com, Naveen Krishna <ch.naveen@samsung.com>, Ben Dooks <ben-linux@fluff.org>

From: Naveen Krishna <ch.naveen@samsung.com>

This patch implements generic GPIO configuration function in Samsung
touchscreen driver. And makes the touchscreen driver s3c24xx-ts.c
generic to all the Samsung SoCs.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
[ben-linux@fluff.org: fixed title ]
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/input/touchscreen/s3c2410_ts.c |   23 +++--------------------
 1 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index a2e1228..86086a4 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -39,8 +39,6 @@
 #include <plat/regs-adc.h>
 #include <plat/ts.h>
 
-#include <mach/regs-gpio.h>
-
 #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
 
 #define INT_DOWN	(0)
@@ -88,21 +86,6 @@ struct s3c2410ts {
 static struct s3c2410ts ts;
 
 /**
- * s3c2410_ts_connect - configure gpio for s3c2410 systems
- *
- * Configure the GPIO for the S3C2410 system, where we have external FETs
- * connected to the device (later systems such as the S3C2440 integrate
- * these into the device).
-*/
-static inline void s3c2410_ts_connect(void)
-{
-	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
-	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
-	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
-	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
-}
-
-/**
  * get_down - return the down state of the pen
  * @data0: The data read from ADCDAT0 register.
  * @data1: The data read from ADCDAT1 register.
@@ -296,9 +279,9 @@ static int __devinit s3c2410ts_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	/* Configure the touchscreen external FETs on the S3C2410 */
-	if (!platform_get_device_id(pdev)->driver_data)
-		s3c2410_ts_connect();
+	/* inititalise the gpio */
+	if (info->cfg_gpio)
+		info->cfg_gpio(to_platform_device(ts.dev));
 
 	ts.client = s3c_adc_register(pdev, s3c24xx_ts_select,
 				     s3c24xx_ts_conversion, 1);
-- 
1.6.3.3

