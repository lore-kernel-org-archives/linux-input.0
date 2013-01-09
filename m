From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Input: samsung-keypad: Remove input_unregister_device() call
Date: Wed,  9 Jan 2013 12:13:49 +0530
Message-ID: <1357713829-30273-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:35535 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190Ab3AIGwF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jan 2013 01:52:05 -0500
Received: by mail-pb0-f41.google.com with SMTP id xa7so750212pbc.14
        for <linux-input@vger.kernel.org>; Tue, 08 Jan 2013 22:52:04 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, patches@linaro.org

Since devm_input_allocate_device() is used, explicit unregistering
of device is not required as it is handled by devres infrastructure.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/samsung-keypad.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 22e357b..fab8972 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -501,8 +501,6 @@ static int samsung_keypad_remove(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 0);
 	platform_set_drvdata(pdev, NULL);
 
-	input_unregister_device(keypad->input_dev);
-
 	clk_unprepare(keypad->clk);
 
 	return 0;
-- 
1.7.4.1

