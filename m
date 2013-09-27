From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 6/7] Input: egalax_ts - Include linux/of.h header
Date: Fri, 27 Sep 2013 17:22:08 +0530
Message-ID: <1380282729-26669-6-git-send-email-sachin.kamat@linaro.org>
References: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:39675 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab3I0Lw0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Sep 2013 07:52:26 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so2477907pbb.0
        for <linux-input@vger.kernel.org>; Fri, 27 Sep 2013 04:52:26 -0700 (PDT)
In-Reply-To: <1380282729-26669-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/egalax_ts.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index ef5fcb0..c856fbc 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/input/mt.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 
 /*
-- 
1.7.9.5

