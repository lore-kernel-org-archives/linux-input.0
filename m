From: Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH] drivers: input: use module_platform_driver_probe()
Date: Thu, 14 Mar 2013 18:49:09 +0100
Message-ID: <1363283349-26058-1-git-send-email-fabio.porcedda@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39946 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758195Ab3CNRtO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Mar 2013 13:49:14 -0400
Received: by mail-ee0-f46.google.com with SMTP id e49so1218065eek.33
        for <linux-input@vger.kernel.org>; Thu, 14 Mar 2013 10:49:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This patch converts the drivers to use the
module_platform_driver_probe() macro which makes the code smaller and
a bit simpler.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
v3:
  - removed already converted drivers

 drivers/input/touchscreen/mc13783_ts.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index 02103b6..89308fe 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -250,17 +250,7 @@ static struct platform_driver mc13783_ts_driver = {
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
+module_platform_driver_probe(mc13783_ts_driver, mc13783_ts_probe);
 
 MODULE_DESCRIPTION("MC13783 input touchscreen driver");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-- 
1.8.1.5

