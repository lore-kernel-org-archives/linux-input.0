From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 6/8] Input: at32psif: Use module_platform_driver_probe macro
Date: Tue,  5 Mar 2013 08:53:45 +0530
Message-ID: <1362453827-18129-6-git-send-email-sachin.kamat@linaro.org>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:56623 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab3CEDea (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Mar 2013 22:34:30 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so3805417pbb.34
        for <linux-input@vger.kernel.org>; Mon, 04 Mar 2013 19:34:30 -0800 (PST)
In-Reply-To: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

module_platform_driver_probe() eliminates the boilerplate and simplifies
the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/serio/at32psif.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
index 36e799c..190ce35 100644
--- a/drivers/input/serio/at32psif.c
+++ b/drivers/input/serio/at32psif.c
@@ -359,18 +359,7 @@ static struct platform_driver psif_driver = {
 	},
 };
 
-static int __init psif_init(void)
-{
-	return platform_driver_probe(&psif_driver, psif_probe);
-}
-
-static void __exit psif_exit(void)
-{
-	platform_driver_unregister(&psif_driver);
-}
-
-module_init(psif_init);
-module_exit(psif_exit);
+module_platform_driver_probe(psif_driver, psif_probe);
 
 MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
 MODULE_DESCRIPTION("Atmel AVR32 PSIF PS/2 driver");
-- 
1.7.4.1

