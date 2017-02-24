From: yegorslists@googlemail.com
Subject: [PATCH 1/3] tps6507x-ts: update to devm_* API
Date: Fri, 24 Feb 2017 16:42:24 +0100
Message-ID: <1487950946-18590-2-git-send-email-yegorslists@googlemail.com>
References: <1487950946-18590-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36386 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdBXPmv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Feb 2017 10:42:51 -0500
Received: by mail-wr0-f195.google.com with SMTP id o22so1829025wro.3
        for <linux-input@vger.kernel.org>; Fri, 24 Feb 2017 07:42:50 -0800 (PST)
In-Reply-To: <1487950946-18590-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Update the code to use devm_* API so that driver
core will manage resources.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/input/touchscreen/tps6507x-ts.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index a340bfc..5bf1ec6 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -226,7 +226,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 	 */
 	init_data = tps_board->tps6507x_ts_init_data;
 
-	tsc = kzalloc(sizeof(struct tps6507x_ts), GFP_KERNEL);
+	tsc = devm_kzalloc(&pdev->dev, sizeof(struct tps6507x_ts), GFP_KERNEL);
 	if (!tsc) {
 		dev_err(tps6507x_dev->dev, "failed to allocate driver data\n");
 		return -ENOMEM;
@@ -244,7 +244,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 	if (!poll_dev) {
 		dev_err(tsc->dev, "Failed to allocate polled input device.\n");
 		error = -ENOMEM;
-		goto err_free_mem;
+		goto err;
 	}
 
 	tsc->poll_dev = poll_dev;
@@ -286,8 +286,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 
 err_free_polled_dev:
 	input_free_polled_device(poll_dev);
-err_free_mem:
-	kfree(tsc);
+err:
 	return error;
 }
 
@@ -299,8 +298,6 @@ static int tps6507x_ts_remove(struct platform_device *pdev)
 	input_unregister_polled_device(poll_dev);
 	input_free_polled_device(poll_dev);
 
-	kfree(tsc);
-
 	return 0;
 }
 
-- 
2.1.4

