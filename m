From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 7/7] Input: st1232 - Include linux/of.h header
Date: Fri, 27 Sep 2013 17:22:09 +0530
Message-ID: <1380282729-26669-7-git-send-email-sachin.kamat@linaro.org>
References: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48815 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab3I0Lw2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Sep 2013 07:52:28 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so2656163pad.23
        for <linux-input@vger.kernel.org>; Fri, 27 Sep 2013 04:52:28 -0700 (PDT)
In-Reply-To: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/st1232.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 1740a24..2f03b2f 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -24,6 +24,7 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
-- 
1.7.9.5

