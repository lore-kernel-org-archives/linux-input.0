From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH]  Input: pwm-beeper - Use devm functions
Date: Thu, 19 Feb 2015 09:26:02 -0200
Message-ID: <1424345162-17260-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bbn0106.outbound.protection.outlook.com ([157.56.111.106]:8266
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752514AbbBSMAO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Feb 2015 07:00:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, lars@metafoo.de, Fabio Estevam <fabio.estevam@freescale.com>

By using devm functions the code can be simplified a bit.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/misc/pwm-beeper.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index a28ee70..c5ccaee 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -72,11 +72,11 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	struct pwm_beeper *beeper;
 	int error;
 
-	beeper = kzalloc(sizeof(*beeper), GFP_KERNEL);
+	beeper = devm_kzalloc(&pdev->dev, sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
 		return -ENOMEM;
 
-	beeper->pwm = pwm_get(&pdev->dev, NULL);
+	beeper->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(beeper->pwm)) {
 		dev_dbg(&pdev->dev, "unable to request PWM, trying legacy API\n");
 		beeper->pwm = pwm_request(pwm_id, "pwm beeper");
@@ -85,14 +85,13 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	if (IS_ERR(beeper->pwm)) {
 		error = PTR_ERR(beeper->pwm);
 		dev_err(&pdev->dev, "Failed to request pwm device: %d\n", error);
-		goto err_free;
+		return error;
 	}
 
-	beeper->input = input_allocate_device();
+	beeper->input = devm_input_allocate_device(&pdev->dev);
 	if (!beeper->input) {
 		dev_err(&pdev->dev, "Failed to allocate input device\n");
-		error = -ENOMEM;
-		goto err_pwm_free;
+		return -ENOMEM;
 	}
 	beeper->input->dev.parent = &pdev->dev;
 
@@ -122,10 +121,6 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 err_input_free:
 	input_free_device(beeper->input);
-err_pwm_free:
-	pwm_free(beeper->pwm);
-err_free:
-	kfree(beeper);
 
 	return error;
 }
@@ -137,9 +132,6 @@ static int pwm_beeper_remove(struct platform_device *pdev)
 	input_unregister_device(beeper->input);
 
 	pwm_disable(beeper->pwm);
-	pwm_free(beeper->pwm);
-
-	kfree(beeper);
 
 	return 0;
 }
-- 
1.9.1

