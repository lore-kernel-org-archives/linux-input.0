From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/8] Input: twl4030-pwrbutton: module_platform_driver_probe macro
Date: Tue,  5 Mar 2013 08:53:41 +0530
Message-ID: <1362453827-18129-2-git-send-email-sachin.kamat@linaro.org>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:56849 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab3CEDeU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Mar 2013 22:34:20 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so3792588pbc.38
        for <linux-input@vger.kernel.org>; Mon, 04 Mar 2013 19:34:20 -0800 (PST)
In-Reply-To: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

module_platform_driver_probe() eliminates the boilerplate and simplifies
the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/misc/twl4030-pwrbutton.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index 27c2bc8..b9a05fd 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -114,18 +114,8 @@ static struct platform_driver twl4030_pwrbutton_driver = {
 	},
 };
 
-static int __init twl4030_pwrbutton_init(void)
-{
-	return platform_driver_probe(&twl4030_pwrbutton_driver,
+module_platform_driver_probe(twl4030_pwrbutton_driver,
 			twl4030_pwrbutton_probe);
-}
-module_init(twl4030_pwrbutton_init);
-
-static void __exit twl4030_pwrbutton_exit(void)
-{
-	platform_driver_unregister(&twl4030_pwrbutton_driver);
-}
-module_exit(twl4030_pwrbutton_exit);
 
 MODULE_ALIAS("platform:twl4030_pwrbutton");
 MODULE_DESCRIPTION("Triton2 Power Button");
-- 
1.7.4.1

