From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1 03/10] Input: atmel_mxt_ts - remove duplicate setup of ABS_MT_PRESSURE
Date: Fri, 20 Jul 2018 22:51:15 +0100
Message-ID: <20180720215122.23558-3-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 9555947a2d46..dcafb812ee7e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2055,12 +2055,6 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 				     0, 255, 0, 0);
 	}
 
-	if (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
-	    data->t100_aux_ampl) {
-		input_set_abs_params(input_dev, ABS_MT_PRESSURE,
-				     0, 255, 0, 0);
-	}
-
 	if (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
 	    data->t100_aux_vect) {
 		input_set_abs_params(input_dev, ABS_MT_ORIENTATION,
-- 
2.17.1
