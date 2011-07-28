From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: lm8323: add missing device_remove_file for
 dev_attr_time
Date: Thu, 28 Jul 2011 17:07:01 +0800
Message-ID: <1311844021.31725.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39987 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab1G1JHK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 05:07:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Add missing device_remove_file() for dev_attr_time in lm8323_remove().
Also calling device_remove_file() in lm8323_probe() error path to
remove sysfs attribute file.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/keyboard/lm8323.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index ab0acaf..756348a 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -754,8 +754,11 @@ fail3:
 	device_remove_file(&client->dev, &dev_attr_disable_kp);
 fail2:
 	while (--pwm >= 0)
-		if (lm->pwm[pwm].enabled)
+		if (lm->pwm[pwm].enabled) {
+			device_remove_file(lm->pwm[pwm].cdev.dev,
+					   &dev_attr_time);
 			led_classdev_unregister(&lm->pwm[pwm].cdev);
+		}
 fail1:
 	input_free_device(idev);
 	kfree(lm);
@@ -775,8 +778,10 @@ static int __devexit lm8323_remove(struct i2c_client *client)
 	device_remove_file(&lm->client->dev, &dev_attr_disable_kp);
 
 	for (i = 0; i < 3; i++)
-		if (lm->pwm[i].enabled)
+		if (lm->pwm[i].enabled) {
+			device_remove_file(lm->pwm[i].cdev.dev, &dev_attr_time);
 			led_classdev_unregister(&lm->pwm[i].cdev);
+		}
 
 	kfree(lm);
 
-- 
1.7.4.1



