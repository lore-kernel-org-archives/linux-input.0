From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH] gpio_mouse: use standard driver registration method
Date: Wed, 24 Jun 2009 11:31:39 +0300
Message-ID: <1245832299-23608-1-git-send-email-saeed@marvell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:61437 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751721AbZFXIbi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2009 04:31:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: saeed.bishara@gmail.com, Saeed Bishara <saeed@marvell.com>

This patch is needed when the gpio's became available only at late
stages, for example, when using i2c gpio expander.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/input/mouse/gpio_mouse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 5e5eb88..f468864 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -175,6 +175,7 @@ MODULE_ALIAS("platform:gpio_mouse");
 
 static struct platform_driver gpio_mouse_device_driver = {
 	.remove		= __devexit_p(gpio_mouse_remove),
+	.probe		= gpio_mouse_probe,
 	.driver		= {
 		.name	= "gpio_mouse",
 		.owner	= THIS_MODULE,
@@ -183,8 +184,7 @@ static struct platform_driver gpio_mouse_device_driver = {
 
 static int __init gpio_mouse_init(void)
 {
-	return platform_driver_probe(&gpio_mouse_device_driver,
-			gpio_mouse_probe);
+	return platform_driver_register(&gpio_mouse_device_driver);
 }
 module_init(gpio_mouse_init);
 
-- 
1.6.0.4

