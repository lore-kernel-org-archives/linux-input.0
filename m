From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] Input: gpio_mouse - Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 16:12:22 +0530
Message-ID: <1367577742-14712-3-git-send-email-sachin.kamat@linaro.org>
References: <1367577742-14712-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:48269 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762030Ab3ECKz0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:55:26 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so838505pbc.7
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:55:25 -0700 (PDT)
In-Reply-To: <1367577742-14712-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
 drivers/input/mouse/gpio_mouse.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 532eaca..6b44413 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -138,7 +138,6 @@ static int gpio_mouse_probe(struct platform_device *pdev)
 
  out_free_polldev:
 	input_free_polled_device(input_poll);
-	platform_set_drvdata(pdev, NULL);
 
  out_free_gpios:
 	while (--i >= 0) {
@@ -165,8 +164,6 @@ static int gpio_mouse_remove(struct platform_device *pdev)
 			gpio_free(pin);
 	}
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

