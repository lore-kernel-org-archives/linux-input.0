From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] Input: eeti_ts - Remove redundant null check
Date: Thu, 28 Mar 2013 13:23:42 +0530
Message-ID: <1364457222-4381-2-git-send-email-sachin.kamat@linaro.org>
References: <1364457222-4381-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:64241 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab3C1IFK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Mar 2013 04:05:10 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so1929409pab.38
        for <linux-input@vger.kernel.org>; Thu, 28 Mar 2013 01:05:09 -0700 (PDT)
In-Reply-To: <1364457222-4381-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

'pdata' is already dereferenced earlier. Hence this check is
meaningless.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/eeti_ts.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 55255a9..8fe5086 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -206,8 +206,7 @@ static int eeti_ts_probe(struct i2c_client *client,
 	if (err < 0)
 		goto err1;
 
-	if (pdata)
-		priv->irq_active_high = pdata->irq_active_high;
+	priv->irq_active_high = pdata->irq_active_high;
 
 	irq_flags = priv->irq_active_high ?
 		IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
-- 
1.7.4.1

