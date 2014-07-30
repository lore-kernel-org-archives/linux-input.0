From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] Input: mcs5000_ts - Protect PM functions with CONFIG_PM_SLEEP
Date: Wed, 30 Jul 2014 13:17:18 -0300
Message-ID: <1406737039-1404-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:49020 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbaG3QRo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2014 12:17:44 -0400
Received: by mail-vc0-f175.google.com with SMTP id ik5so2178845vcb.34
        for <linux-input@vger.kernel.org>; Wed, 30 Jul 2014 09:17:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: beomho.seo@samsung.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

When a kernel has CONFIG_PM=y and CONFIG_PM_SLEEP=n the following warnings are 
seen:
drivers/input/touchscreen/mcs5000_ts.c:252:12: warning: 'mcs5000_ts_suspend' defined but not used [-Wunused-function]
 static int mcs5000_ts_suspend(struct device *dev)
            ^
drivers/input/touchscreen/mcs5000_ts.c:262:12: warning: 'mcs5000_ts_resume' defined but not used [-Wunused-function]
 static int mcs5000_ts_resume(struct device *dev)

Protect the suspend/resume functions with CONFIG_PM_SLEEP in order to fix these
build warnings.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/touchscreen/mcs5000_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 00510a9..1fb760c 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -248,7 +248,7 @@ static int mcs5000_ts_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int mcs5000_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-- 
1.9.1

