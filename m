From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Input: soc_button_array - Remove duplicate inclusion of input.h
Date: Wed, 28 May 2014 17:14:19 +0530
Message-ID: <1401277459-31247-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42103 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbaE1Lqk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2014 07:46:40 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so10870003pad.4
        for <linux-input@vger.kernel.org>; Wed, 28 May 2014 04:46:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

input.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/misc/soc_button_array.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 20c80f543d5e..5a6334be30b8 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -17,7 +17,6 @@
 #include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio_keys.h>
-#include <linux/input.h>
 #include <linux/platform_device.h>
 #include <linux/pnp.h>
 
-- 
1.7.9.5

