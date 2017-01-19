From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 1/7] Input: pwm-beeper - remove calls to legacy pwm_request API
Date: Thu, 19 Jan 2017 14:40:51 -0800
Message-ID: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org

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
2.11.0.483.g087da7b7c-goog
