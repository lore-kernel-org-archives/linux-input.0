From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH] Input: s3c2410_ts: Make s3c_ts_pmops const
Date: Fri, 31 Aug 2012 15:17:17 +0530
Message-ID: <1346406437-19213-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37953 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab2HaJtv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Aug 2012 05:49:51 -0400
Received: by pbbrr13 with SMTP id rr13so4557727pbb.19
        for <linux-input@vger.kernel.org>; Fri, 31 Aug 2012 02:49:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, patches@linaro.org

Fixes the following warning:
WARNING: struct dev_pm_ops should normally be const

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/s3c2410_ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index bf1a064..b3c66d4 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -406,7 +406,7 @@ static int s3c2410ts_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops s3c_ts_pmops = {
+static const struct dev_pm_ops s3c_ts_pmops = {
 	.suspend	= s3c2410ts_suspend,
 	.resume		= s3c2410ts_resume,
 };
-- 
1.7.4.1

