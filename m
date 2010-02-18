From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 1/4] Add resources description for s3c24xx ts driver
Date: Thu, 18 Feb 2010 18:32:27 +0200
Message-ID: <1266510750-9846-2-git-send-email-anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:43140 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926Ab0BRQdh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 11:33:37 -0500
Received: by fg-out-1718.google.com with SMTP id l26so520305fgb.1
        for <linux-input@vger.kernel.org>; Thu, 18 Feb 2010 08:33:36 -0800 (PST)
In-Reply-To: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: ben-linux@fluff.org, linux-input@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>

Without resources description driver fails during initialization.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/plat-s3c24xx/devs.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 7f686a3..83c1507 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -185,9 +185,27 @@ void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *pd)
 }
 
 /* Touchscreen */
+
+static struct resource s3c_ts_resource[] = {
+	[0] = {
+		.start = S3C24XX_PA_ADC,
+		.end   = S3C24XX_PA_ADC + S3C24XX_SZ_ADC - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_TC,
+		.end   = IRQ_TC,
+		.flags = IORESOURCE_IRQ,
+	},
+
+};
+
 struct platform_device s3c_device_ts = {
 	.name		  = "s3c2410-ts",
 	.id		  = -1,
+	.dev.parent	= &s3c_device_adc.dev,
+	.num_resources	  = ARRAY_SIZE(s3c_ts_resource),
+	.resource	  = s3c_ts_resource,
 };
 EXPORT_SYMBOL(s3c_device_ts);
 
-- 
1.7.0

