From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/7] Input: gpio_keys - Include linux/of.h header
Date: Fri, 27 Sep 2013 17:22:03 +0530
Message-ID: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:63989 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab3I0LwP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Sep 2013 07:52:15 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so2687462pad.16
        for <linux-input@vger.kernel.org>; Fri, 27 Sep 2013 04:52:14 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/gpio_keys.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 440ce32..2db1324 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -26,6 +26,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/spinlock.h>
-- 
1.7.9.5

