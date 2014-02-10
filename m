From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/4] input: mc13783: Use module_platform_driver_probe()
Date: Mon, 10 Feb 2014 08:22:18 +0400
Message-ID: <1392006138-10341-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp24.mail.ru ([94.100.176.177]:58667 "EHLO smtp24.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612AbaBJEW3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Feb 2014 23:22:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Alexander Shiyan <shc_work@mail.ru>

Driver should be probed from MC13XXX MFD core only, so change
driver declaration to use module_platform_driver_probe().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/misc/mc13783-pwrbutton.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
index 60be67a..a1e45235 100644
--- a/drivers/input/misc/mc13783-pwrbutton.c
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -88,7 +88,7 @@ static irqreturn_t button_irq(int irq, void *_priv)
 	return IRQ_HANDLED;
 }
 
-static int mc13783_pwrbutton_probe(struct platform_device *pdev)
+static int __init mc13xxx_pwrbutton_probe(struct platform_device *pdev)
 {
 	const struct mc13xxx_buttons_platform_data *pdata;
 	struct mc13xxx *mc13783 = dev_get_drvdata(pdev->dev.parent);
@@ -229,7 +229,7 @@ free_input_dev:
 	return err;
 }
 
-static int mc13783_pwrbutton_remove(struct platform_device *pdev)
+static int mc13xxx_pwrbutton_remove(struct platform_device *pdev)
 {
 	struct mc13783_pwrb *priv = platform_get_drvdata(pdev);
 	const struct mc13xxx_buttons_platform_data *pdata;
@@ -253,18 +253,15 @@ static int mc13783_pwrbutton_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver mc13783_pwrbutton_driver = {
-	.probe		= mc13783_pwrbutton_probe,
-	.remove		= mc13783_pwrbutton_remove,
+static struct platform_driver mc13xxx_pwrbutton_driver = {
 	.driver		= {
 		.name	= "mc13783-pwrbutton",
 		.owner	= THIS_MODULE,
 	},
+	.remove		= mc13xxx_pwrbutton_remove,
 };
+module_platform_driver_probe(mc13xxx_pwrbutton_driver, mc13xxx_pwrbutton_probe);
 
-module_platform_driver(mc13783_pwrbutton_driver);
-
-MODULE_ALIAS("platform:mc13783-pwrbutton");
 MODULE_DESCRIPTION("MC13783 Power Button");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Philippe Retornaz");
-- 
1.8.3.2

