From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 8/8] Input: atmel-wm97xx: Use module_platform_driver_probe macro
Date: Tue,  5 Mar 2013 08:53:47 +0530
Message-ID: <1362453827-18129-8-git-send-email-sachin.kamat@linaro.org>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:46105 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab3CEDeg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Mar 2013 22:34:36 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so3805346pbc.2
        for <linux-input@vger.kernel.org>; Mon, 04 Mar 2013 19:34:35 -0800 (PST)
In-Reply-To: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

module_platform_driver_probe() eliminates the boilerplate and simplifies
the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/atmel-wm97xx.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/atmel-wm97xx.c b/drivers/input/touchscreen/atmel-wm97xx.c
index c5c2dbb..2c1e46b 100644
--- a/drivers/input/touchscreen/atmel-wm97xx.c
+++ b/drivers/input/touchscreen/atmel-wm97xx.c
@@ -432,17 +432,7 @@ static struct platform_driver atmel_wm97xx_driver = {
 	},
 };
 
-static int __init atmel_wm97xx_init(void)
-{
-	return platform_driver_probe(&atmel_wm97xx_driver, atmel_wm97xx_probe);
-}
-module_init(atmel_wm97xx_init);
-
-static void __exit atmel_wm97xx_exit(void)
-{
-	platform_driver_unregister(&atmel_wm97xx_driver);
-}
-module_exit(atmel_wm97xx_exit);
+module_platform_driver_probe(atmel_wm97xx_driver, atmel_wm97xx_probe);
 
 MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
 MODULE_DESCRIPTION("wm97xx continuous touch driver for Atmel AT91 and AVR32");
-- 
1.7.4.1

