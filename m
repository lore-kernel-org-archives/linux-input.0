From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/7] Input: pwm-beeper - Include linux/of.h header
Date: Fri, 27 Sep 2013 17:22:06 +0530
Message-ID: <1380282729-26669-4-git-send-email-sachin.kamat@linaro.org>
References: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:63511 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3I0LwW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Sep 2013 07:52:22 -0400
Received: by mail-pa0-f51.google.com with SMTP id kp14so2671294pab.38
        for <linux-input@vger.kernel.org>; Fri, 27 Sep 2013 04:52:21 -0700 (PDT)
In-Reply-To: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/misc/pwm-beeper.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 2ff4d1c..940566e 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -16,6 +16,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
-- 
1.7.9.5

