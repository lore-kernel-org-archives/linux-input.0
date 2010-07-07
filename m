From: Markus Lehtonen <markus.lehtonen@nokia.com>
Subject: [PATCH] Input: twl4030-pwrbutton - replace __devinit with __init
Date: Wed,  7 Jul 2010 16:24:23 +0300
Message-ID: <1278509063-30362-1-git-send-email-markus.lehtonen@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56009 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab0GGNYy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Jul 2010 09:24:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dtor@mail.ru, felipe.balbi@nokia.com

Power button is not hot-pluggable so we can save some memory by
using __init.

Signed-off-by: Markus Lehtonen <markus.lehtonen@nokia.com>
---
 drivers/input/misc/twl4030-pwrbutton.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index e9069b8..353cfea 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -52,7 +52,7 @@ static irqreturn_t powerbutton_irq(int irq, void *_pwr)
 	return IRQ_HANDLED;
 }
 
-static int __devinit twl4030_pwrbutton_probe(struct platform_device *pdev)
+static int __init twl4030_pwrbutton_probe(struct platform_device *pdev)
 {
 	struct input_dev *pwr;
 	int irq = platform_get_irq(pdev, 0);
@@ -107,7 +107,6 @@ static int __devexit twl4030_pwrbutton_remove(struct platform_device *pdev)
 }
 
 struct platform_driver twl4030_pwrbutton_driver = {
-	.probe		= twl4030_pwrbutton_probe,
 	.remove		= __devexit_p(twl4030_pwrbutton_remove),
 	.driver		= {
 		.name	= "twl4030_pwrbutton",
@@ -117,7 +116,8 @@ struct platform_driver twl4030_pwrbutton_driver = {
 
 static int __init twl4030_pwrbutton_init(void)
 {
-	return platform_driver_register(&twl4030_pwrbutton_driver);
+	return platform_driver_probe(&twl4030_pwrbutton_driver,
+			twl4030_pwrbutton_probe);
 }
 module_init(twl4030_pwrbutton_init);
 
-- 
1.7.0.4

