From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v12 4/5] Input: goodix - fix reset sequence
Date: Sat, 10 Sep 2016 20:57:36 +0300
Message-ID: <1473530257-7495-5-git-send-email-irina.tirdea@intel.com>
References: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26075 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932228AbcIJR6z (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 10 Sep 2016 13:58:55 -0400
In-Reply-To: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>

According to the Goodix datasheet, the reset sequence will leave
the reset line set to output high. To end the selection of the I2C
address, we just need to set the input line to low for at least
50 ms and then set it to input floating (already implemented by
goodix_int_sync).

Remove setting the reset line to input from the reset sequence,
since that is not reflected in the datasheet.

This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
driver gt9xx.c for Android (publicly available in Android kernel
trees for various devices).

Suggested-by: Troy Kisky <troy.kisky@boundarydevices.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 182ff9c..6fba804 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -454,10 +454,6 @@ static int goodix_reset(struct goodix_ts_data *ts)
 	usleep_range(6000, 10000);		/* T4: > 5ms */
 
 	/* end select I2C slave addr */
-	error = gpiod_direction_input(ts->gpiod_rst);
-	if (error)
-		return error;
-
 	error = goodix_int_sync(ts);
 	if (error)
 		return error;
-- 
1.9.1

