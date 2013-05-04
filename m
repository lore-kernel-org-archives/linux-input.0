From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 8/9] Input: pwm-beeper - Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 20:21:57 +0530
Message-ID: <1367679118-2980-8-git-send-email-sachin.kamat@linaro.org>
References: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:55805 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760393Ab3EDOwa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 May 2013 10:52:30 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so1193381dad.23
        for <linux-input@vger.kernel.org>; Sat, 04 May 2013 07:52:30 -0700 (PDT)
In-Reply-To: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Lars-Peter Clausen <lars@metafoo.de>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/input/misc/pwm-beeper.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 0808868..a37f0c9 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -133,7 +133,6 @@ static int pwm_beeper_remove(struct platform_device *pdev)
 {
 	struct pwm_beeper *beeper = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	input_unregister_device(beeper->input);
 
 	pwm_disable(beeper->pwm);
-- 
1.7.4.1

