From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/7] Input: rotary_encoder - Include linux/of.h header
Date: Fri, 27 Sep 2013 17:22:07 +0530
Message-ID: <1380282729-26669-5-git-send-email-sachin.kamat@linaro.org>
References: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54041 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab3I0LwY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Sep 2013 07:52:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2474592pbb.33
        for <linux-input@vger.kernel.org>; Fri, 27 Sep 2013 04:52:23 -0700 (PDT)
In-Reply-To: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/misc/rotary_encoder.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 5b1aff8..f920ba7 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/rotary_encoder.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 
-- 
1.7.9.5

