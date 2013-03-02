From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: ads7864 - Check return value of regulator enable
Date: Sat,  2 Mar 2013 15:04:41 +0800
Message-ID: <1362207881-25259-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42104 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819Ab3CBHqD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Mar 2013 02:46:03 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

At least print a warning if we can't power the device up.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/ads7846.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4f702b3..e0c8b7a 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -236,7 +236,12 @@ static void __ads7846_disable(struct ads7846 *ts)
 /* Must be called with ts->lock held */
 static void __ads7846_enable(struct ads7846 *ts)
 {
-	regulator_enable(ts->reg);
+	int ret;
+
+	ret = regulator_enable(ts->reg);
+	if (ret != 0)
+		dev_err(&ts->spi->dev, "Failed to enable supply: %d\n", ret);
+
 	ads7846_restart(ts);
 }
 
-- 
1.7.10.4

