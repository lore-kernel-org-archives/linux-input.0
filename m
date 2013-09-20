From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/4] Input: ad7879-spi - Remove redundant spi_set_drvdata
Date: Fri, 20 Sep 2013 10:14:48 +0530
Message-ID: <1379652289-300-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:56455 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab3ITEoi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Sep 2013 00:44:38 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so9263416pbc.15
        for <linux-input@vger.kernel.org>; Thu, 19 Sep 2013 21:44:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, sachin.kamat@linaro.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/ad7879-spi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index 606da5b..1a7b114 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -142,7 +142,6 @@ static int ad7879_spi_remove(struct spi_device *spi)
 	struct ad7879 *ts = spi_get_drvdata(spi);
 
 	ad7879_remove(ts);
-	spi_set_drvdata(spi, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

