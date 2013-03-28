From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] Input: edt-ft5x06 - Remove redundant null check before kfree
Date: Thu, 28 Mar 2013 13:23:41 +0530
Message-ID: <1364457222-4381-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:51399 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab3C1IFI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Mar 2013 04:05:08 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so1390670pab.21
        for <linux-input@vger.kernel.org>; Thu, 28 Mar 2013 01:05:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

kfree on a null pointer is a no-op. Hence null check is not
necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/edt-ft5x06.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index a917015..83fa1b1 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -440,8 +440,7 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 		return -EIO;
 	}
 
-	if (tsdata->raw_buffer)
-		kfree(tsdata->raw_buffer);
+	kfree(tsdata->raw_buffer);
 	tsdata->raw_buffer = NULL;
 
 	/* restore parameters */
-- 
1.7.4.1

