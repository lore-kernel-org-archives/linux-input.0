From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/9] Input: jornada720_ts - Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:58:38 +0530
Message-ID: <1367576922-31459-5-git-send-email-sachin.kamat@linaro.org>
References: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:56706 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3ECKmA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:42:00 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so838081pbc.35
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:42:00 -0700 (PDT)
In-Reply-To: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Kristoffer Ericson <Kristoffer.Ericson@gmail.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
---
 drivers/input/touchscreen/jornada720_ts.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
index 282d7c7..e463a79 100644
--- a/drivers/input/touchscreen/jornada720_ts.c
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -145,7 +145,6 @@ static int jornada720_ts_probe(struct platform_device *pdev)
  fail2:
 	free_irq(IRQ_GPIO9, pdev);
  fail1:
-	platform_set_drvdata(pdev, NULL);
 	input_free_device(input_dev);
 	kfree(jornada_ts);
 	return error;
@@ -156,7 +155,6 @@ static int jornada720_ts_remove(struct platform_device *pdev)
 	struct jornada_ts *jornada_ts = platform_get_drvdata(pdev);
 
 	free_irq(IRQ_GPIO9, pdev);
-	platform_set_drvdata(pdev, NULL);
 	input_unregister_device(jornada_ts->dev);
 	kfree(jornada_ts);
 
-- 
1.7.9.5

