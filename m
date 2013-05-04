From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/9] Input: gpio_tilt_polled - Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 20:21:52 +0530
Message-ID: <1367679118-2980-3-git-send-email-sachin.kamat@linaro.org>
References: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:48492 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760081Ab3EDOwR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 May 2013 10:52:17 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so1373731pab.41
        for <linux-input@vger.kernel.org>; Sat, 04 May 2013 07:52:16 -0700 (PDT)
In-Reply-To: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Heiko Stuebner <heiko@sntech.de>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
---
 drivers/input/misc/gpio_tilt_polled.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/misc/gpio_tilt_polled.c
index da05cca..714c683 100644
--- a/drivers/input/misc/gpio_tilt_polled.c
+++ b/drivers/input/misc/gpio_tilt_polled.c
@@ -184,8 +184,6 @@ static int gpio_tilt_polled_remove(struct platform_device *pdev)
 	struct gpio_tilt_polled_dev *tdev = platform_get_drvdata(pdev);
 	const struct gpio_tilt_platform_data *pdata = tdev->pdata;
 
-	platform_set_drvdata(pdev, NULL);
-
 	input_unregister_polled_device(tdev->poll_dev);
 	input_free_polled_device(tdev->poll_dev);
 
-- 
1.7.4.1

