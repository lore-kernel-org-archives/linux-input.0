From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 7/8] Input: s3c24xx_ts - depend on SAMSUNG_DEV_TS and update menu entry
Date: Wed, 19 May 2010 07:12:21 +0100
Message-ID: <1274249542-28795-8-git-send-email-ben-linux@fluff.org>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:56998 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab0ESGMZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 02:12:25 -0400
In-Reply-To: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: kgene.kim@samsung.com, ch.naveen@samsubng.com, dmitry.torokhov@gmail.com, Ben Dooks <ben-linux@fluff.org>

Make the driver depend on either ARCH_S3C2410 (as legacy) or the new
device selection of SAMSUNG_DEV_TS.

Change the menuconfig name to reflect this driver is now handling more
devices that just the s3c2410.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/input/touchscreen/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 8a8fa4d..77a50d9 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -158,8 +158,8 @@ config TOUCHSCREEN_FUJITSU
 	  module will be called fujitsu-ts.
 
 config TOUCHSCREEN_S3C2410
-	tristate "Samsung S3C2410 touchscreen input driver"
-	depends on ARCH_S3C2410
+	tristate "Samsung S3C2410/generic touchscreen input driver"
+	depends on ARCH_S3C2410 || SAMSUNG_DEV_TS
 	select S3C24XX_ADC
 	help
 	  Say Y here if you have the s3c2410 touchscreen.
-- 
1.6.3.3

