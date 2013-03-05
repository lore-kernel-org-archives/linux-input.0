From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 7/8] Input: q40kbd: Use module_platform_driver_probe macro
Date: Tue,  5 Mar 2013 08:53:46 +0530
Message-ID: <1362453827-18129-7-git-send-email-sachin.kamat@linaro.org>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:42310 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab3CEDed (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Mar 2013 22:34:33 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so3816731pbc.39
        for <linux-input@vger.kernel.org>; Mon, 04 Mar 2013 19:34:32 -0800 (PST)
In-Reply-To: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

module_platform_driver_probe() eliminates the boilerplate and simplifies
the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/serio/q40kbd.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index 70fe542..436a343 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -193,15 +193,4 @@ static struct platform_driver q40kbd_driver = {
 	.remove		= q40kbd_remove,
 };
 
-static int __init q40kbd_init(void)
-{
-	return platform_driver_probe(&q40kbd_driver, q40kbd_probe);
-}
-
-static void __exit q40kbd_exit(void)
-{
-	platform_driver_unregister(&q40kbd_driver);
-}
-
-module_init(q40kbd_init);
-module_exit(q40kbd_exit);
+module_platform_driver_probe(q40kbd_driver, q40kbd_probe);
-- 
1.7.4.1

