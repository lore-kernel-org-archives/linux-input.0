From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/4] input: sirfsoc-onkey - drop the IRQF_SHARED flag
Date: Thu, 13 Feb 2014 14:40:21 +0800
Message-ID: <1392273624-22920-2-git-send-email-21cnbao@gmail.com>
References: <1392273624-22920-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:39359 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaBMGky (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 01:40:54 -0500
Received: by mail-pa0-f51.google.com with SMTP id ld10so10378962pab.38
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 22:40:54 -0800 (PST)
In-Reply-To: <1392273624-22920-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

since the irq handler always return IRQ_HANDLED, it means this irq is not
a shared IRQ at all. or at least, the SW is not self-consistent now.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/input/misc/sirfsoc-onkey.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 4d13903..4d54744 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -114,7 +114,7 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 
 	pwrcdrv->irq = platform_get_irq(pdev, 0);
 	error = devm_request_irq(&pdev->dev, pwrcdrv->irq,
-				 sirfsoc_pwrc_isr, IRQF_SHARED,
+				 sirfsoc_pwrc_isr, 0,
 				 "sirfsoc_pwrc_int", pwrcdrv);
 	if (error) {
 		dev_err(&pdev->dev, "unable to claim irq %d, error: %d\n",
-- 
1.7.5.4

