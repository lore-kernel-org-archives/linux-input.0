From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/6] Input: pixcir_i2c_ts - simplify input device initialization
Date: Mon,  6 Jul 2015 17:30:10 -0700
Message-ID: <1436229011-29655-5-git-send-email-dmitry.torokhov@gmail.com>
References: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Roger Quadros <rogerq@ti.com>
Cc: Jianchun Bian <jcbian@pixcir.com.cn>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

input_mt_init_slots() will perform necessary settings for performing
multi-touch to single-touch emulation, we do not need to do that ourselves.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 9d9ac08..043d219 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -510,11 +510,6 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 	input->close = pixcir_input_close;
 	input->dev.parent = &client->dev;
 
-	__set_bit(EV_KEY, input->evbit);
-	__set_bit(EV_ABS, input->evbit);
-	__set_bit(BTN_TOUCH, input->keybit);
-	input_set_abs_params(input, ABS_X, 0, pdata->x_max, 0, 0);
-	input_set_abs_params(input, ABS_Y, 0, pdata->y_max, 0, 0);
 	input_set_abs_params(input, ABS_MT_POSITION_X, 0, pdata->x_max, 0, 0);
 	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, pdata->y_max, 0, 0);
 
-- 
2.4.3.573.g4eafbef
