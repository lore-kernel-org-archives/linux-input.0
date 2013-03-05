From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/8] Input: nomadik-ske-keypad: Use module_platform_driver_probe macro
Date: Tue,  5 Mar 2013 08:53:43 +0530
Message-ID: <1362453827-18129-4-git-send-email-sachin.kamat@linaro.org>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:50614 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab3CEDeZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Mar 2013 22:34:25 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so3806074pbc.11
        for <linux-input@vger.kernel.org>; Mon, 04 Mar 2013 19:34:25 -0800 (PST)
In-Reply-To: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

module_platform_driver_probe() eliminates the boilerplate and simplifies
the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/nomadik-ske-keypad.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 0e6a815..c7d505c 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -430,17 +430,7 @@ static struct platform_driver ske_keypad_driver = {
 	.remove = ske_keypad_remove,
 };
 
-static int __init ske_keypad_init(void)
-{
-	return platform_driver_probe(&ske_keypad_driver, ske_keypad_probe);
-}
-module_init(ske_keypad_init);
-
-static void __exit ske_keypad_exit(void)
-{
-	platform_driver_unregister(&ske_keypad_driver);
-}
-module_exit(ske_keypad_exit);
+module_platform_driver_probe(ske_keypad_driver, ske_keypad_probe);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Naveen Kumar <naveen.gaddipati@stericsson.com> / Sundar Iyer <sundar.iyer@stericsson.com>");
-- 
1.7.4.1

