From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/7] Input: gpio_keys_polled - Include linux/of.h header
Date: Fri, 27 Sep 2013 17:22:04 +0530
Message-ID: <1380282729-26669-2-git-send-email-sachin.kamat@linaro.org>
References: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:63587 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3I0LwR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Sep 2013 07:52:17 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so2720035pab.1
        for <linux-input@vger.kernel.org>; Fri, 27 Sep 2013 04:52:17 -0700 (PDT)
In-Reply-To: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/gpio_keys_polled.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index cd5ed9e..4e42819 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 
-- 
1.7.9.5

