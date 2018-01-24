From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/4] Input: mms114 - mark as direct input device
Date: Wed, 24 Jan 2018 11:38:02 -0800
Message-ID: <20180124193804.155654-3-dmitry.torokhov@gmail.com>
References: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Shields <simon@lineageos.org>, Andi Shyti <andi.shyti@samsung.com>
Cc: Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

mms14 is a touchscreen and thus a direct input device; let's mark it
as such. This also allows us to drop some initialization code as
input_init_mt_slots() will do that for us.

Also add error handling for input_mt_init_slots().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 92f2e9da351f1..c3480db5d21ed 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -462,14 +462,6 @@ static int mms114_probe(struct i2c_client *client,
 	input_dev->open = mms114_input_open;
 	input_dev->close = mms114_input_close;
 
-	__set_bit(EV_ABS, input_dev->evbit);
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(BTN_TOUCH, input_dev->keybit);
-	input_set_abs_params(input_dev, ABS_X, 0, data->pdata->x_size, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, data->pdata->y_size, 0, 0);
-
-	/* For multi touch */
-	input_mt_init_slots(input_dev, MMS114_MAX_TOUCH, 0);
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
 			     0, MMS114_MAX_AREA, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
@@ -478,6 +470,11 @@ static int mms114_probe(struct i2c_client *client,
 			     0, data->pdata->y_size, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
 
+	error = input_mt_init_slots(input_dev, MMS114_MAX_TOUCH,
+				    INPUT_MT_DIRECT);
+	if (error)
+		return error;
+
 	input_set_drvdata(input_dev, data);
 	i2c_set_clientdata(client, data);
 
-- 
2.16.0.rc1.238.g530d649a79-goog
