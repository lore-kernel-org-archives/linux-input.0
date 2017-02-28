From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/4] Input: ad7879 - do not manipulate capability bits directly
Date: Tue, 28 Feb 2017 14:08:48 -0800
Message-ID: <20170228220848.31185-4-dmitry.torokhov@gmail.com>
References: <20170228220848.31185-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36714 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdB1WPx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 17:15:53 -0500
In-Reply-To: <20170228220848.31185-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Instead of manipulating capabilities bits of input device directly, let's
use input_set_capability() API.

Also, stop setting ABS_X/Y bits explicitly as input_set_abs_params() does
this for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ad7879.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index c415614ada68..196028c45210 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -590,13 +590,7 @@ int ad7879_probe(struct device *dev, struct regmap *regmap,
 
 	input_set_drvdata(input_dev, ts);
 
-	__set_bit(EV_ABS, input_dev->evbit);
-	__set_bit(ABS_X, input_dev->absbit);
-	__set_bit(ABS_Y, input_dev->absbit);
-	__set_bit(ABS_PRESSURE, input_dev->absbit);
-
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(BTN_TOUCH, input_dev->keybit);
+	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
 
 	if (pdata) {
 		input_set_abs_params(input_dev, ABS_X,
@@ -614,6 +608,7 @@ int ad7879_probe(struct device *dev, struct regmap *regmap,
 	} else {
 		input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
 		input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
+		input_set_capability(input_dev, EV_ABS, ABS_PRESSURE);
 		touchscreen_parse_properties(input_dev, false, NULL);
 		if (!input_abs_get_max(input_dev, ABS_PRESSURE)) {
 			dev_err(dev, "Touchscreen pressure is not specified\n");
-- 
2.11.0.483.g087da7b7c-goog

