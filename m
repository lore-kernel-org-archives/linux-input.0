From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/4] Input: cobalt_btns - Remove redundant dev_set_drvdata
Date: Fri,  6 Sep 2013 23:38:05 +0530
Message-ID: <1378490888-5083-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61647 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab3IFSIV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Sep 2013 14:08:21 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so3645544pab.11
        for <linux-input@vger.kernel.org>; Fri, 06 Sep 2013 11:08:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Yoichi Yuasa <yuasa@linux-mips.org>

Driver core sets the data to NULL upon release or probe
failure. Hence explicit setting is not necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Yoichi Yuasa <yuasa@linux-mips.org>
---
 drivers/input/misc/cobalt_btns.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/cobalt_btns.c b/drivers/input/misc/cobalt_btns.c
index 4f77f87..b5d71d2 100644
--- a/drivers/input/misc/cobalt_btns.c
+++ b/drivers/input/misc/cobalt_btns.c
@@ -131,7 +131,6 @@ static int cobalt_buttons_probe(struct platform_device *pdev)
  err_free_mem:
 	input_free_polled_device(poll_dev);
 	kfree(bdev);
-	dev_set_drvdata(&pdev->dev, NULL);
 	return error;
 }
 
@@ -144,7 +143,6 @@ static int cobalt_buttons_remove(struct platform_device *pdev)
 	input_free_polled_device(bdev->poll_dev);
 	iounmap(bdev->reg);
 	kfree(bdev);
-	dev_set_drvdata(dev, NULL);
 
 	return 0;
 }
-- 
1.7.4.1

