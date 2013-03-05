From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/8] Input: amikbd: Use module_platform_driver_probe macro
Date: Tue,  5 Mar 2013 08:53:42 +0530
Message-ID: <1362453827-18129-3-git-send-email-sachin.kamat@linaro.org>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64498 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490Ab3CEDeX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Mar 2013 22:34:23 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so3782713pbc.5
        for <linux-input@vger.kernel.org>; Mon, 04 Mar 2013 19:34:22 -0800 (PST)
In-Reply-To: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

module_platform_driver_probe() eliminates the boilerplate and simplifies
the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/amikbd.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
index 79172af..ba0b36f 100644
--- a/drivers/input/keyboard/amikbd.c
+++ b/drivers/input/keyboard/amikbd.c
@@ -260,18 +260,6 @@ static struct platform_driver amikbd_driver = {
 	},
 };
 
-static int __init amikbd_init(void)
-{
-	return platform_driver_probe(&amikbd_driver, amikbd_probe);
-}
-
-module_init(amikbd_init);
-
-static void __exit amikbd_exit(void)
-{
-	platform_driver_unregister(&amikbd_driver);
-}
-
-module_exit(amikbd_exit);
+module_platform_driver_probe(amikbd_driver, amikbd_probe);
 
 MODULE_ALIAS("platform:amiga-keyboard");
-- 
1.7.4.1

