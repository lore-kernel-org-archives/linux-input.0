From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 3/4] input: sirfsoc-onkey - use dev_get_drvdata instead of platform_get_drvdata
Date: Thu, 13 Feb 2014 14:40:23 +0800
Message-ID: <1392273624-22920-4-git-send-email-21cnbao@gmail.com>
References: <1392273624-22920-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:61535 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaBMGlG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 01:41:06 -0500
Received: by mail-pb0-f54.google.com with SMTP id uo5so10472740pbc.27
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 22:41:04 -0800 (PST)
In-Reply-To: <1392273624-22920-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Xianglong Du <Xianglong.Du@csr.com>

In resume entry, use dev_get_drvdata() instead of to_platform_device(dev) +
platform_get_drvdata(pdev).

Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/input/misc/sirfsoc-onkey.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 097c10a..8e45bf11 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -157,8 +157,7 @@ static int sirfsoc_pwrc_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int sirfsoc_pwrc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sirfsoc_pwrc_drvdata *pwrcdrv = platform_get_drvdata(pdev);
+	struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(dev);
 
 	/*
 	 * Do not mask pwrc interrupt as we want pwrc work as a wakeup source
-- 
1.7.5.4

