From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] Input: pwm-beeper - switch to using managed resources
Date: Fri,  6 Jan 2017 10:20:49 -0800
Message-ID: <20170106182050.2772-2-dmitry.torokhov@gmail.com>
References: <20170106182050.2772-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34692 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936290AbdAFSUx (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2017 13:20:53 -0500
In-Reply-To: <20170106182050.2772-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>

e of managed resources (devm) simplifies error handling and teardown
of the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/pwm-beeper.c | 44 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index cb87e475bd23..14c52054f5b7 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -95,18 +95,19 @@ static void pwm_beeper_close(struct input_dev *input)
 
 static int pwm_beeper_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct pwm_beeper *beeper;
 	int error;
 
-	beeper = kzalloc(sizeof(*beeper), GFP_KERNEL);
+	beeper = devm_kzalloc(dev, sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
 		return -ENOMEM;
 
-	beeper->pwm = pwm_get(&pdev->dev, NULL);
+	beeper->pwm = devm_pwm_get(dev, NULL);
 	if (IS_ERR(beeper->pwm)) {
 		error = PTR_ERR(beeper->pwm);
-		dev_err(&pdev->dev, "Failed to request pwm device: %d\n", error);
-		goto err_free;
+		dev_err(dev, "Failed to request pwm device: %d\n", error);
+		return error;
 	}
 
 	/*
@@ -117,13 +118,11 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	INIT_WORK(&beeper->work, pwm_beeper_work);
 
-	beeper->input = input_allocate_device();
+	beeper->input = devm_input_allocate_device(dev);
 	if (!beeper->input) {
-		dev_err(&pdev->dev, "Failed to allocate input device\n");
-		error = -ENOMEM;
-		goto err_pwm_free;
+		dev_err(dev, "Failed to allocate input device\n");
+		return -ENOMEM;
 	}
-	beeper->input->dev.parent = &pdev->dev;
 
 	beeper->input->name = "pwm-beeper";
 	beeper->input->phys = "pwm/input0";
@@ -142,35 +141,13 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	error = input_register_device(beeper->input);
 	if (error) {
-		dev_err(&pdev->dev, "Failed to register input device: %d\n", error);
-		goto err_input_free;
+		dev_err(dev, "Failed to register input device: %d\n", error);
+		return error;
 	}
 
 	platform_set_drvdata(pdev, beeper);
 
 	return 0;
-
-err_input_free:
-	input_free_device(beeper->input);
-err_pwm_free:
-	pwm_free(beeper->pwm);
-err_free:
-	kfree(beeper);
-
-	return error;
-}
-
-static int pwm_beeper_remove(struct platform_device *pdev)
-{
-	struct pwm_beeper *beeper = platform_get_drvdata(pdev);
-
-	input_unregister_device(beeper->input);
-
-	pwm_free(beeper->pwm);
-
-	kfree(beeper);
-
-	return 0;
 }
 
 static int __maybe_unused pwm_beeper_suspend(struct device *dev)
@@ -205,7 +182,6 @@ MODULE_DEVICE_TABLE(of, pwm_beeper_match);
 
 static struct platform_driver pwm_beeper_driver = {
 	.probe	= pwm_beeper_probe,
-	.remove = pwm_beeper_remove,
 	.driver = {
 		.name	= "pwm-beeper",
 		.pm	= &pwm_beeper_pm_ops,
-- 
2.11.0.390.gc69c2f50cf-goog

