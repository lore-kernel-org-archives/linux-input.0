From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 6/9] Input: pm8xxx-vibrator - Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 20:21:55 +0530
Message-ID: <1367679118-2980-6-git-send-email-sachin.kamat@linaro.org>
References: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:47167 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760343Ab3EDOwY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 May 2013 10:52:24 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so1331359pbc.7
        for <linux-input@vger.kernel.org>; Sat, 04 May 2013 07:52:24 -0700 (PDT)
In-Reply-To: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Amy Maloche <amaloche@codeaurora.org>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Amy Maloche <amaloche@codeaurora.org>
---
 drivers/input/misc/pm8xxx-vibrator.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index a9da65e..ec086f6 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -249,8 +249,6 @@ static int pm8xxx_vib_remove(struct platform_device *pdev)
 	input_unregister_device(vib->vib_input_dev);
 	kfree(vib);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.4.1

