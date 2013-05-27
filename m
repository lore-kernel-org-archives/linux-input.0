From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/4] Input: pcspkr - Remove redundant platform_set_drvdata()
Date: Mon, 27 May 2013 17:07:07 +0530
Message-ID: <1369654628-20714-3-git-send-email-sachin.kamat@linaro.org>
References: <1369654628-20714-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:37475 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab3E0LvJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 May 2013 07:51:09 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so6700286pbc.29
        for <linux-input@vger.kernel.org>; Mon, 27 May 2013 04:51:09 -0700 (PDT)
In-Reply-To: <1369654628-20714-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/misc/pcspkr.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
index 199db78..7288b26 100644
--- a/drivers/input/misc/pcspkr.c
+++ b/drivers/input/misc/pcspkr.c
@@ -100,7 +100,6 @@ static int pcspkr_remove(struct platform_device *dev)
 	struct input_dev *pcspkr_dev = platform_get_drvdata(dev);
 
 	input_unregister_device(pcspkr_dev);
-	platform_set_drvdata(dev, NULL);
 	/* turn off the speaker */
 	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
 
-- 
1.7.9.5

