From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/4] Input: tsc2005 - Remove redundant spi_set_drvdata
Date: Fri, 20 Sep 2013 10:14:49 +0530
Message-ID: <1379652289-300-2-git-send-email-sachin.kamat@linaro.org>
References: <1379652289-300-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40076 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab3ITEol (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Sep 2013 00:44:41 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so9261985pdj.22
        for <linux-input@vger.kernel.org>; Thu, 19 Sep 2013 21:44:40 -0700 (PDT)
In-Reply-To: <1379652289-300-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, sachin.kamat@linaro.org, Lauri Leukkunen <lauri.leukkunen@nokia.com>

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 drivers/input/touchscreen/tsc2005.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 7213e8b..8113533 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -678,7 +678,6 @@ static int tsc2005_probe(struct spi_device *spi)
 err_remove_sysfs:
 	sysfs_remove_group(&spi->dev.kobj, &tsc2005_attr_group);
 err_clear_drvdata:
-	spi_set_drvdata(spi, NULL);
 	free_irq(spi->irq, ts);
 err_free_mem:
 	input_free_device(input_dev);
@@ -696,7 +695,6 @@ static int tsc2005_remove(struct spi_device *spi)
 	input_unregister_device(ts->idev);
 	kfree(ts);
 
-	spi_set_drvdata(spi, NULL);
 	return 0;
 }
 
-- 
1.7.9.5

