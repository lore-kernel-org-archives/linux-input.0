From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: [PATCH] gpio-keys: Add input device name support
Date: Sun, 10 Apr 2011 17:26:26 +0200
Message-ID: <1302449186-20441-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jessica.hrz.tu-chemnitz.de ([134.109.132.47]:44441 "EHLO
	jessica.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753995Ab1DJP0W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Apr 2011 11:26:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>

This patch allows to set a device name which helps distinguishing several
gpio-keys devices.

Signed-off-by: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
---
 drivers/input/keyboard/gpio_keys.c |    2 +-
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f319884..3a923b3 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -473,7 +473,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ddata);
 	input_set_drvdata(input, ddata);
 
-	input->name = pdev->name;
+	input->name = pdata->name ? : pdev->name;
 	input->phys = "gpio-keys/input0";
 	input->dev.parent = &pdev->dev;
 	input->open = gpio_keys_open;
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index c09d7fb..cedc39f 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -22,6 +22,7 @@ struct gpio_keys_platform_data {
 	unsigned int rep:1;		/* enable input subsystem auto repeat */
 	int (*enable)(struct device *dev);
 	void (*disable)(struct device *dev);
+	char *name;			/* input device name */
 };
 
 #endif
-- 
1.7.4.1

