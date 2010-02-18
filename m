From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 4/4] s3c24xx_ts: re-enable IRQ on resume
Date: Thu, 18 Feb 2010 18:32:30 +0200
Message-ID: <1266510750-9846-5-git-send-email-anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:51002 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481Ab0BRQdo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 11:33:44 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so9209314fxm.21
        for <linux-input@vger.kernel.org>; Thu, 18 Feb 2010 08:33:44 -0800 (PST)
In-Reply-To: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: ben-linux@fluff.org, linux-input@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>

IRQ should be enabled on resume, otherwise driver doesn't
report events.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/input/touchscreen/s3c2410_ts.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index e2fe2ed..6738c26 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -401,6 +401,7 @@ static int s3c2410ts_resume(struct device *dev)
 	struct s3c2410_ts_mach_info *info = pdev->dev.platform_data;
 
 	clk_enable(ts.clock);
+	enable_irq(ts.irq_tc);
 
 	/* Initialise registers */
 	if ((info->delay & 0xffff) > 0)
-- 
1.7.0

