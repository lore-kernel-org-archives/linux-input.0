From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: max11801_ts - drop call to input_set_drvdata()
Date: Sat, 21 Jan 2017 23:38:46 -0800
Message-ID: <20170122073846.GA30131@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Nobody calls input_get_drvdata() so setting it is not required.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/max11801_ts.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index d87b89da114e..a595ae5284e3 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -199,7 +199,6 @@ static int max11801_ts_probe(struct i2c_client *client,
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 	input_set_abs_params(input_dev, ABS_X, 0, MAX11801_MAX_X, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y, 0, MAX11801_MAX_Y, 0, 0);
-	input_set_drvdata(input_dev, data);
 
 	max11801_ts_phy_init(data);
 
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
