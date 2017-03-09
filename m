From: Jingkui Wang <jkwang@google.com>
Subject: [PATCH] drivers: Remove OF dependency in drv260x driver
Date: Wed,  8 Mar 2017 17:24:36 -0800
Message-ID: <1489022677-52409-1-git-send-email-jkwang@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34968 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754781AbdCIBdS (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 8 Mar 2017 20:33:18 -0500
Received: by mail-pg0-f52.google.com with SMTP id b129so19783320pgc.2
        for <linux-input@vger.kernel.org>; Wed, 08 Mar 2017 17:33:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jingkui Wang <jkwang@google.com>, dmitry.torokhov@gmail.com

As the driver is using generic device properties, it should work
properly when CONFIG_OF is turned off. This patch removes the
ifdef CONFIGOF and make sure the driver always have of_match_table.

Signed-off-by: Jingkui Wang <jkwang@google.com>
---
 drivers/input/misc/drv260x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index fb089d3..17eb84a 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -652,7 +652,6 @@ static const struct i2c_device_id drv260x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, drv260x_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id drv260x_of_match[] = {
 	{ .compatible = "ti,drv2604", },
 	{ .compatible = "ti,drv2604l", },
@@ -661,13 +660,12 @@ static const struct of_device_id drv260x_of_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, drv260x_of_match);
-#endif
 
 static struct i2c_driver drv260x_driver = {
 	.probe		= drv260x_probe,
 	.driver		= {
 		.name	= "drv260x-haptics",
-		.of_match_table = of_match_ptr(drv260x_of_match),
+		.of_match_table = drv260x_of_match,
 		.pm	= &drv260x_pm_ops,
 	},
 	.id_table = drv260x_id,
-- 
2.6.6

