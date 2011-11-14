From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/6] Input: ucb1400_ts - convert to use dev_pm_ops
Date: Mon, 14 Nov 2011 00:36:06 -0800
Message-ID: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56522 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab1KNIgQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:36:16 -0500
Received: by ywt32 with SMTP id 32so1950780ywt.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:36:15 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marek.vasut@gmail.com>

Instead of using legacy PM interfaces switch to using dev_pm_ops.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/ucb1400_ts.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 3b5b5df..ead7123 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -428,10 +428,10 @@ static int ucb1400_ts_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ucb1400_ts_resume(struct platform_device *dev)
+#ifdef CONFIG_PM_SLEEP
+static int ucb1400_ts_resume(struct device *dev)
 {
-	struct ucb1400_ts *ucb = dev->dev.platform_data;
+	struct ucb1400_ts *ucb = dev->platform_data;
 
 	if (ucb->ts_task) {
 		/*
@@ -444,16 +444,16 @@ static int ucb1400_ts_resume(struct platform_device *dev)
 	}
 	return 0;
 }
-#else
-#define ucb1400_ts_resume NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(ucb1400_ts_pm_ops, NULL, ucb1400_ts_resume);
+
 static struct platform_driver ucb1400_ts_driver = {
 	.probe	= ucb1400_ts_probe,
 	.remove	= ucb1400_ts_remove,
-	.resume	= ucb1400_ts_resume,
 	.driver	= {
 		.name	= "ucb1400_ts",
+		.pm	= &ucb1400_ts_pm_ops,
 	},
 };
 
-- 
1.7.6.4

