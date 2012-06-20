From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] input: gpio_keys: added setup call for extending functionality of driver
Date: Wed, 20 Jun 2012 20:09:57 +0400
Message-ID: <1340208597-31865-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback6.mail.ru ([94.100.176.134]:56761 "EHLO
	fallback6.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076Ab2FTQVD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jun 2012 12:21:03 -0400
Received: from smtp2.mail.ru (smtp2.mail.ru [94.100.176.130])
	by fallback6.mail.ru (mPOP.Fallback_MX) with ESMTP id 949CC8B7F3F9
	for <linux-input@vger.kernel.org>; Wed, 20 Jun 2012 20:10:11 +0400 (MSK)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Alexander Shiyan <shc_work@mail.ru>

This additional call can be used for extending functionality of
driver. For example we can add EV_SND, EV_LED, etc. handlers.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/keyboard/gpio_keys.c |    3 +++
 include/linux/gpio_keys.h          |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 62bfce4..2b1bcb2 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -707,6 +707,9 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 			wakeup = 1;
 	}
 
+	if (pdata->setup)
+		pdata->setup(input);
+
 	error = sysfs_create_group(&pdev->dev.kobj, &gpio_keys_attr_group);
 	if (error) {
 		dev_err(dev, "Unable to export keys/switches, error: %d\n",
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index a7e977f..0dfd3fe 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -2,6 +2,7 @@
 #define _GPIO_KEYS_H
 
 struct device;
+struct input_dev;
 
 struct gpio_keys_button {
 	/* Configuration parameters */
@@ -25,6 +26,7 @@ struct gpio_keys_platform_data {
 	unsigned int rep:1;		/* enable input subsystem auto repeat */
 	int (*enable)(struct device *dev);
 	void (*disable)(struct device *dev);
+	int (*setup)(struct input_dev *input);
 	const char *name;		/* input device name */
 };
 
-- 
1.7.3.4

