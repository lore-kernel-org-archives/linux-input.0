From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 1/3] input: pixcir_i2c_ts: simplify code with of_device_get_match_data
Date: Wed, 17 Aug 2016 15:22:12 +0200
Message-ID: <1471440134-23896-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32964 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbcHQNW3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2016 09:22:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>

The usage of of_device_get_match_data reduce the code size a bit.
Furthermore, it is better to use a standard function for
getting the match data.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index d159e14..b0a2dc2 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -431,13 +431,7 @@ static const struct of_device_id pixcir_of_match[];
 static int pixcir_parse_dt(struct device *dev,
 			   struct pixcir_i2c_ts_data *tsdata)
 {
-	const struct of_device_id *match;
-
-	match = of_match_device(of_match_ptr(pixcir_of_match), dev);
-	if (!match)
-		return -EINVAL;
-
-	tsdata->chip = (const struct pixcir_i2c_chip_data *)match->data;
+	tsdata->chip = of_device_get_match_data(dev);
 	if (!tsdata->chip)
 		return -EINVAL;
 
-- 
2.7.3

