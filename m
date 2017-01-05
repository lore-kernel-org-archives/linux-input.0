From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] input/wm97xx: make missing platform data non-fatal
Date: Thu,  5 Jan 2017 16:43:22 +0100
Message-ID: <20170105154322.28943-1-manuel.lauss@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36635 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968105AbdAEPn1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2017 10:43:27 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so97130980wma.3
        for <linux-input@vger.kernel.org>; Thu, 05 Jan 2017 07:43:26 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Manuel Lauss <manuel.lauss@gmail.com>

Commit 6480af4915d6 ("power_supply: wm97xx_battery: use
power_supply_get_drvdata") made wm97xx platform data mandatory,
although it's still optional.

This patch fixes an oops during driver probe on one
of my MIPS boards with a wm9712.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/input/touchscreen/wm97xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 83cf11312fd9..c9d1c91e1887 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -682,7 +682,7 @@ static int wm97xx_probe(struct device *dev)
 	}
 	platform_set_drvdata(wm->battery_dev, wm);
 	wm->battery_dev->dev.parent = dev;
-	wm->battery_dev->dev.platform_data = pdata->batt_pdata;
+	wm->battery_dev->dev.platform_data = pdata ? pdata->batt_pdata : NULL;
 	ret = platform_device_add(wm->battery_dev);
 	if (ret < 0)
 		goto batt_reg_err;
-- 
2.11.0

