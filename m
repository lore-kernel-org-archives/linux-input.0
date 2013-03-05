From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/8] Input: davinci_keyscan: Use module_platform_driver_probe macro
Date: Tue,  5 Mar 2013 08:53:40 +0530
Message-ID: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46495 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759081Ab3CEDeS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Mar 2013 22:34:18 -0500
Received: by mail-pb0-f49.google.com with SMTP id xa12so3755863pbc.8
        for <linux-input@vger.kernel.org>; Mon, 04 Mar 2013 19:34:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

module_platform_driver_probe() simplifies the code by eliminating
boilerplate code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/davinci_keyscan.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index 4e4e453..8297537 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -329,17 +329,7 @@ static struct platform_driver davinci_ks_driver = {
 	.remove	= davinci_ks_remove,
 };
 
-static int __init davinci_ks_init(void)
-{
-	return platform_driver_probe(&davinci_ks_driver, davinci_ks_probe);
-}
-module_init(davinci_ks_init);
-
-static void __exit davinci_ks_exit(void)
-{
-	platform_driver_unregister(&davinci_ks_driver);
-}
-module_exit(davinci_ks_exit);
+module_platform_driver_probe(davinci_ks_driver, davinci_ks_probe);
 
 MODULE_AUTHOR("Miguel Aguilar");
 MODULE_DESCRIPTION("Texas Instruments DaVinci Key Scan Driver");
-- 
1.7.4.1

