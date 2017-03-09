From: yegorslists@googlemail.com
Subject: [PATCH v2 1/3] tps6507x-ts: update to devm_* API
Date: Thu,  9 Mar 2017 15:31:07 +0100
Message-ID: <1489069869-3849-2-git-send-email-yegorslists@googlemail.com>
References: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34830 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754542AbdCIOcH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2017 09:32:07 -0500
Received: by mail-wm0-f67.google.com with SMTP id z63so11232314wmg.2
        for <linux-input@vger.kernel.org>; Thu, 09 Mar 2017 06:31:40 -0800 (PST)
In-Reply-To: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, lee.jones@linaro.org, robh@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com, nsekhar@ti.com, khilman@baylibre.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Update the code to use devm_* API so that driver
core will manage resources.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/input/touchscreen/tps6507x-ts.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index a340bfc..fbaa2f68 100644
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
@@ -240,11 +240,10 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 	snprintf(tsc->phys, sizeof(tsc->phys),
 		 "%s/input0", dev_name(tsc->dev));
 
-	poll_dev = input_allocate_polled_device();
+	poll_dev = devm_input_allocate_polled_device(&pdev->dev);
 	if (!poll_dev) {
 		dev_err(tsc->dev, "Failed to allocate polled input device.\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	tsc->poll_dev = poll_dev;
@@ -274,34 +273,15 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 
 	error = tps6507x_adc_standby(tsc);
 	if (error)
-		goto err_free_polled_dev;
+		return error;
 
 	error = input_register_polled_device(poll_dev);
 	if (error)
-		goto err_free_polled_dev;
+		return error;
 
 	platform_set_drvdata(pdev, tsc);
 
 	return 0;
-
-err_free_polled_dev:
-	input_free_polled_device(poll_dev);
-err_free_mem:
-	kfree(tsc);
-	return error;
-}
-
-static int tps6507x_ts_remove(struct platform_device *pdev)
-{
-	struct tps6507x_ts *tsc = platform_get_drvdata(pdev);
-	struct input_polled_dev *poll_dev = tsc->poll_dev;
-
-	input_unregister_polled_device(poll_dev);
-	input_free_polled_device(poll_dev);
-
-	kfree(tsc);
-
-	return 0;
 }
 
 static struct platform_driver tps6507x_ts_driver = {
@@ -309,7 +289,6 @@ static struct platform_driver tps6507x_ts_driver = {
 		.name = "tps6507x-ts",
 	},
 	.probe = tps6507x_ts_probe,
-	.remove = tps6507x_ts_remove,
 };
 module_platform_driver(tps6507x_ts_driver);
 
-- 
2.1.4

