From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/9] Input: intel-mid-touch: Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:58:37 +0530
Message-ID: <1367576922-31459-4-git-send-email-sachin.kamat@linaro.org>
References: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46617 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3ECKl5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:41:57 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so860894pad.25
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:41:57 -0700 (PDT)
In-Reply-To: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, "Sreedhara Murthy. D.S." <sreedhara.ds@intel.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Sreedhara Murthy. D.S. <sreedhara.ds@intel.com>
---
 drivers/input/touchscreen/intel-mid-touch.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/intel-mid-touch.c b/drivers/input/touchscreen/intel-mid-touch.c
index 465db5d..e30d837 100644
--- a/drivers/input/touchscreen/intel-mid-touch.c
+++ b/drivers/input/touchscreen/intel-mid-touch.c
@@ -651,8 +651,6 @@ static int mrstouch_remove(struct platform_device *pdev)
 	input_unregister_device(tsdev->input);
 	kfree(tsdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

