From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/6] Input: nspire-keypad - Remove redundant of_match_ptr
Date: Sat, 28 Sep 2013 17:58:10 +0530
Message-ID: <1380371294-10289-2-git-send-email-sachin.kamat@linaro.org>
References: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37329 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab3I1M2Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Sep 2013 08:28:24 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so3878988pad.5
        for <linux-input@vger.kernel.org>; Sat, 28 Sep 2013 05:28:24 -0700 (PDT)
In-Reply-To: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/nspire-keypad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/nspire-keypad.c b/drivers/input/keyboard/nspire-keypad.c
index b3e3eda..9981928 100644
--- a/drivers/input/keyboard/nspire-keypad.c
+++ b/drivers/input/keyboard/nspire-keypad.c
@@ -267,7 +267,7 @@ static struct platform_driver nspire_keypad_driver = {
 	.driver = {
 		.name = "nspire-keypad",
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(nspire_keypad_dt_match),
+		.of_match_table = nspire_keypad_dt_match,
 	},
 	.probe = nspire_keypad_probe,
 };
-- 
1.7.9.5

