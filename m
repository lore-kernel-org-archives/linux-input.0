From: Dan Carpenter <error27@gmail.com>
Subject: [patch] input: error handling bug in lm8323_probe()
Date: Thu, 10 Jun 2010 09:54:31 +0200
Message-ID: <20100610075431.GK5483@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56284 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab0FJHyz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jun 2010 03:54:55 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Richard Purdie <rpurdie@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

We reuse the "i" variable later on so if we goto fail3 or fail4 then "i"
will be set to the wrong thing and cause a crash.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 40b032f..f7c2a16 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -642,6 +642,7 @@ static int __devinit lm8323_probe(struct i2c_client *client,
 	struct lm8323_platform_data *pdata = client->dev.platform_data;
 	struct input_dev *idev;
 	struct lm8323_chip *lm;
+	int pwm;
 	int i, err;
 	unsigned long tmo;
 	u8 data[2];
@@ -710,8 +711,9 @@ static int __devinit lm8323_probe(struct i2c_client *client,
 		goto fail1;
 	}
 
-	for (i = 0; i < LM8323_NUM_PWMS; i++) {
-		err = init_pwm(lm, i + 1, &client->dev, pdata->pwm_names[i]);
+	for (pwm = 0; pwm < LM8323_NUM_PWMS; pwm++) {
+		err = init_pwm(lm, pwm + 1, &client->dev,
+			       pdata->pwm_names[pwm]);
 		if (err < 0)
 			goto fail2;
 	}
@@ -764,9 +766,9 @@ fail4:
 fail3:
 	device_remove_file(&client->dev, &dev_attr_disable_kp);
 fail2:
-	while (--i >= 0)
-		if (lm->pwm[i].enabled)
-			led_classdev_unregister(&lm->pwm[i].cdev);
+	while (--pwm >= 0)
+		if (lm->pwm[pwm].enabled)
+			led_classdev_unregister(&lm->pwm[pwm].cdev);
 fail1:
 	input_free_device(idev);
 	kfree(lm);
