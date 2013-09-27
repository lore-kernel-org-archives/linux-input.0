From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/7] Input: pxa27x_keypad - Include linux/of.h header
Date: Fri, 27 Sep 2013 17:22:05 +0530
Message-ID: <1380282729-26669-3-git-send-email-sachin.kamat@linaro.org>
References: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59818 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab3I0LwT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Sep 2013 07:52:19 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so2501493pdj.32
        for <linux-input@vger.kernel.org>; Fri, 27 Sep 2013 04:52:19 -0700 (PDT)
In-Reply-To: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/pxa27x_keypad.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index a2e758d..186138c 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-- 
1.7.9.5

