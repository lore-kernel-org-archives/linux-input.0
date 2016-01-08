From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: omap-keypad - drop empty PM stubs
Date: Thu, 7 Jan 2016 22:41:57 -0800
Message-ID: <20160108064157.GA30935@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34802 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbcAHGmA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 01:42:00 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-kernel@vger.kernel.org

There is no reason to have empty suspend and resume stubs.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/omap-keypad.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index d115acf..8dc34ee 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -212,25 +212,6 @@ static ssize_t omap_kp_enable_store(struct device *dev, struct device_attribute
 
 static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, omap_kp_enable_show, omap_kp_enable_store);
 
-#ifdef CONFIG_PM
-static int omap_kp_suspend(struct platform_device *dev, pm_message_t state)
-{
-	/* Nothing yet */
-
-	return 0;
-}
-
-static int omap_kp_resume(struct platform_device *dev)
-{
-	/* Nothing yet */
-
-	return 0;
-}
-#else
-#define omap_kp_suspend	NULL
-#define omap_kp_resume	NULL
-#endif
-
 static int omap_kp_probe(struct platform_device *pdev)
 {
 	struct omap_kp *omap_kp;
@@ -367,8 +348,6 @@ static int omap_kp_remove(struct platform_device *pdev)
 static struct platform_driver omap_kp_driver = {
 	.probe		= omap_kp_probe,
 	.remove		= omap_kp_remove,
-	.suspend	= omap_kp_suspend,
-	.resume		= omap_kp_resume,
 	.driver		= {
 		.name	= "omap-keypad",
 	},
-- 
2.6.0.rc2.230.g3dd15c0


-- 
Dmitry
