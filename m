From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/8] Input: amimouse: Use module_platform_driver_probe macro
Date: Tue,  5 Mar 2013 08:53:44 +0530
Message-ID: <1362453827-18129-5-git-send-email-sachin.kamat@linaro.org>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47122 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab3CEDe2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Mar 2013 22:34:28 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so3782800pbc.5
        for <linux-input@vger.kernel.org>; Mon, 04 Mar 2013 19:34:27 -0800 (PST)
In-Reply-To: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

module_platform_driver_probe() eliminates the boilerplate and simplifies
the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/mouse/amimouse.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/input/mouse/amimouse.c b/drivers/input/mouse/amimouse.c
index 5fa9934..b55d5af 100644
--- a/drivers/input/mouse/amimouse.c
+++ b/drivers/input/mouse/amimouse.c
@@ -146,18 +146,6 @@ static struct platform_driver amimouse_driver = {
 	},
 };
 
-static int __init amimouse_init(void)
-{
-	return platform_driver_probe(&amimouse_driver, amimouse_probe);
-}
-
-module_init(amimouse_init);
-
-static void __exit amimouse_exit(void)
-{
-	platform_driver_unregister(&amimouse_driver);
-}
-
-module_exit(amimouse_exit);
+module_platform_driver_probe(amimouse_driver, amimouse_probe);
 
 MODULE_ALIAS("platform:amiga-mouse");
-- 
1.7.4.1

