From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/4] input: sirfsoc-onkey - namespace pwrc_resume function
Date: Thu, 13 Feb 2014 14:40:22 +0800
Message-ID: <1392273624-22920-3-git-send-email-21cnbao@gmail.com>
References: <1392273624-22920-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:48057 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaBMGlA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 01:41:00 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so10090478pde.13
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 22:40:59 -0800 (PST)
In-Reply-To: <1392273624-22920-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Xianglong Du <Xianglong.Du@csr.com>

this function lost namespace, this patch fixes it.

Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/input/misc/sirfsoc-onkey.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 4d54744..097c10a 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -155,7 +155,7 @@ static int sirfsoc_pwrc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int pwrc_resume(struct device *dev)
+static int sirfsoc_pwrc_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sirfsoc_pwrc_drvdata *pwrcdrv = platform_get_drvdata(pdev);
@@ -173,7 +173,7 @@ static int pwrc_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(sirfsoc_pwrc_pm_ops, NULL, pwrc_resume);
+static SIMPLE_DEV_PM_OPS(sirfsoc_pwrc_pm_ops, NULL, sirfsoc_pwrc_resume);
 
 static struct platform_driver sirfsoc_pwrc_driver = {
 	.probe		= sirfsoc_pwrc_probe,
-- 
1.7.5.4

