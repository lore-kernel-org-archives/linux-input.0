From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/4] Input: ad714x-spi - Remove redundant spi_set_drvdata
Date: Fri, 20 Sep 2013 10:12:50 +0530
Message-ID: <1379652173-32477-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48940 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab3ITEmn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Sep 2013 00:42:43 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so252435pab.6
        for <linux-input@vger.kernel.org>; Thu, 19 Sep 2013 21:42:42 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, sachin.kamat@linaro.org, Barry Song <21cnbao@gmail.com>

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Barry Song <21cnbao@gmail.com>
---
Series compile tested.
---
 drivers/input/misc/ad714x-spi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index 6189148..3a90b71 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -108,7 +108,6 @@ static int ad714x_spi_remove(struct spi_device *spi)
 	struct ad714x_chip *chip = spi_get_drvdata(spi);
 
 	ad714x_remove(chip);
-	spi_set_drvdata(spi, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

