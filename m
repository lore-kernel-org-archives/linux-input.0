From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 8/8] Input: s3c24xx_ts - fix selection of S3C_ADC
Date: Wed, 19 May 2010 07:12:22 +0100
Message-ID: <1274249542-28795-9-git-send-email-ben-linux@fluff.org>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:57023 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330Ab0ESGMc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 02:12:32 -0400
In-Reply-To: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: kgene.kim@samsung.com, ch.naveen@samsubng.com, dmitry.torokhov@gmail.com, Ben Dooks <ben-linux@fluff.org>

The change from S3C24XX_ADC to S3C_ADC missed changing the input
driver entry for the s3c2410 touchscreen, so fix the selection
of CONFIG_S3C_ADC.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 77a50d9..af57d3f 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -160,7 +160,7 @@ config TOUCHSCREEN_FUJITSU
 config TOUCHSCREEN_S3C2410
 	tristate "Samsung S3C2410/generic touchscreen input driver"
 	depends on ARCH_S3C2410 || SAMSUNG_DEV_TS
-	select S3C24XX_ADC
+	select S3C_ADC
 	help
 	  Say Y here if you have the s3c2410 touchscreen.
 
-- 
1.6.3.3

