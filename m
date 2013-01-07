From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: touchscreen: mc13783_ts.c: Convert to platform driver
Date: Mon,  7 Jan 2013 18:32:57 -0200
Message-ID: <1357590777-7498-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45731 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3AGUdN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jan 2013 15:33:13 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so19790493vcd.5
        for <linux-input@vger.kernel.org>; Mon, 07 Jan 2013 12:33:10 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: s.hauer@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using module_platform_driver() can make the code smaller and cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/touchscreen/mc13783_ts.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index 02103b6..e881c25 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -243,6 +243,7 @@ static int mc13783_ts_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver mc13783_ts_driver = {
+	.probe		= mc13783_ts_probe,
 	.remove		= mc13783_ts_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
@@ -250,17 +251,7 @@ static struct platform_driver mc13783_ts_driver = {
 	},
 };
 
-static int __init mc13783_ts_init(void)
-{
-	return platform_driver_probe(&mc13783_ts_driver, &mc13783_ts_probe);
-}
-module_init(mc13783_ts_init);
-
-static void __exit mc13783_ts_exit(void)
-{
-	platform_driver_unregister(&mc13783_ts_driver);
-}
-module_exit(mc13783_ts_exit);
+module_platform_driver(mc13783_ts_driver);
 
 MODULE_DESCRIPTION("MC13783 input touchscreen driver");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-- 
1.7.9.5

