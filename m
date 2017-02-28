From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/4] Input: ad7879 - try parsing properties on non-DT systems
Date: Tue, 28 Feb 2017 14:08:47 -0800
Message-ID: <20170228220848.31185-3-dmitry.torokhov@gmail.com>
References: <20170228220848.31185-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34918 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbdB1WQe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 17:16:34 -0500
In-Reply-To: <20170228220848.31185-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

We have switched the driver to use generic device properties API, so there
is no need to check for presence of DT node before trying parse properties.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ad7879.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 7118f611e222..c415614ada68 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -560,11 +560,10 @@ int ad7879_probe(struct device *dev, struct regmap *regmap,
 		ts->averaging = pdata->averaging;
 		ts->pen_down_acc_interval = pdata->pen_down_acc_interval;
 		ts->median = pdata->median;
-	} else if (dev->of_node) {
-		ad7879_parse_dt(dev, ts);
 	} else {
-		dev_err(dev, "No platform data\n");
-		return -EINVAL;
+		err = ad7879_parse_dt(dev, ts);
+		if (err)
+			return err;
 	}
 
 	input_dev = devm_input_allocate_device(dev);
-- 
2.11.0.483.g087da7b7c-goog

