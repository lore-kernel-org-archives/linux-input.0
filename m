From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] Input: touchscreen: mc13783_ts.c: Convert to platform driver
Date: Mon,  7 Jan 2013 18:53:22 -0200
Message-ID: <1357592002-6802-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:59688 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755644Ab3AGUxb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jan 2013 15:53:31 -0500
Received: by mail-vc0-f173.google.com with SMTP id f13so20006264vcb.18
        for <linux-input@vger.kernel.org>; Mon, 07 Jan 2013 12:53:30 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: s.hauer@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using module_platform_driver() can make the code smaller and cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Remove __init from probe function in order to avoid a section mismatch
 drivers/input/touchscreen/mc13783_ts.c |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index 02103b6..9c2f74b 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -168,7 +168,7 @@ static void mc13783_ts_close(struct input_dev *dev)
 	cancel_delayed_work_sync(&priv->work);
 }
 
-static int __init mc13783_ts_probe(struct platform_device *pdev)
+static int mc13783_ts_probe(struct platform_device *pdev)
 {
 	struct mc13783_ts_priv *priv;
 	struct input_dev *idev;
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

