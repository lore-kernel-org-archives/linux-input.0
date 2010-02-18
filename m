From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 3/4] s3c24xx_adc: disable/enable IRQ on suspend/resume
Date: Thu, 18 Feb 2010 18:32:29 +0200
Message-ID: <1266510750-9846-4-git-send-email-anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:51002 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758488Ab0BRQdk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 11:33:40 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so9209314fxm.21
        for <linux-input@vger.kernel.org>; Thu, 18 Feb 2010 08:33:40 -0800 (PST)
In-Reply-To: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: ben-linux@fluff.org, linux-input@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>

IRQ should be disabled on suspend and re-enabled on resume.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/plat-s3c24xx/adc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c24xx/adc.c
index ce47627..284f653 100644
--- a/arch/arm/plat-s3c24xx/adc.c
+++ b/arch/arm/plat-s3c24xx/adc.c
@@ -388,6 +388,7 @@ static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
 	con |= S3C2410_ADCCON_STDBM;
 	writel(con, adc->regs + S3C2410_ADCCON);
 
+	disable_irq(adc->irq);
 	clk_disable(adc->clk);
 
 	return 0;
@@ -398,6 +399,7 @@ static int s3c_adc_resume(struct platform_device *pdev)
 	struct adc_device *adc = platform_get_drvdata(pdev);
 
 	clk_enable(adc->clk);
+	enable_irq(adc->irq);
 
 	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
 	       adc->regs + S3C2410_ADCCON);
-- 
1.7.0

