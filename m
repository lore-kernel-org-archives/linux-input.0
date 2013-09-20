From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/4] Input: ad7877 - Remove redundant spi_set_drvdata
Date: Fri, 20 Sep 2013 10:12:51 +0530
Message-ID: <1379652173-32477-2-git-send-email-sachin.kamat@linaro.org>
References: <1379652173-32477-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:63095 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab3ITEoG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Sep 2013 00:44:06 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so9228710pbc.32
        for <linux-input@vger.kernel.org>; Thu, 19 Sep 2013 21:44:04 -0700 (PDT)
In-Reply-To: <1379652173-32477-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, sachin.kamat@linaro.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/ad7877.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index f3a174a..69834dd 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -806,7 +806,6 @@ err_free_irq:
 err_free_mem:
 	input_free_device(input_dev);
 	kfree(ts);
-	spi_set_drvdata(spi, NULL);
 	return err;
 }
 
@@ -823,7 +822,6 @@ static int ad7877_remove(struct spi_device *spi)
 	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
-	spi_set_drvdata(spi, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

