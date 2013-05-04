From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/9] Input: bfin_rotary - Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 20:21:51 +0530
Message-ID: <1367679118-2980-2-git-send-email-sachin.kamat@linaro.org>
References: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:44315 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760081Ab3EDOwO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 May 2013 10:52:14 -0400
Received: by mail-da0-f44.google.com with SMTP id z8so1220631daj.3
        for <linux-input@vger.kernel.org>; Sat, 04 May 2013 07:52:13 -0700 (PDT)
In-Reply-To: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Michael Hennerich <hennerich@blackfin.uclinux.org>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
 drivers/input/misc/bfin_rotary.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index a6666e1..cd139cb 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -208,7 +208,6 @@ static int bfin_rotary_remove(struct platform_device *pdev)
 	peripheral_free_list(per_cnt);
 
 	kfree(rotary);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.4.1

