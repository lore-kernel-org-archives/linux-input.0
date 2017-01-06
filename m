From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: pwm-beeper - remove calls to legacy pwm_request API
Date: Fri,  6 Jan 2017 10:20:48 -0800
Message-ID: <20170106182050.2772-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36324 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936272AbdAFSUw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2017 13:20:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>

There are no more users of pwm-beeper driver in mainline relying on
this legacy API, so let's remove it and simplify the driver code.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/pwm-beeper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 5f9655d49a65..cb87e475bd23 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -95,7 +95,6 @@ static void pwm_beeper_close(struct input_dev *input)
 
 static int pwm_beeper_probe(struct platform_device *pdev)
 {
-	unsigned long pwm_id = (unsigned long)dev_get_platdata(&pdev->dev);
 	struct pwm_beeper *beeper;
 	int error;
 
@@ -105,11 +104,6 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	beeper->pwm = pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(beeper->pwm)) {
-		dev_dbg(&pdev->dev, "unable to request PWM, trying legacy API\n");
-		beeper->pwm = pwm_request(pwm_id, "pwm beeper");
-	}
-
-	if (IS_ERR(beeper->pwm)) {
 		error = PTR_ERR(beeper->pwm);
 		dev_err(&pdev->dev, "Failed to request pwm device: %d\n", error);
 		goto err_free;
-- 
2.11.0.390.gc69c2f50cf-goog

