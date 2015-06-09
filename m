From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: goodix - do not explicitly set evbits in input device
Date: Tue, 9 Jun 2015 11:52:19 -0700
Message-ID: <20150609185219.GA33366@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Irina Tirdea <irina.tirdea@intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

input_mt_init_slots() will do that for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/goodix.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 73ade35..b4d12e2 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -301,10 +301,6 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts, u16 version,
 		return -ENOMEM;
 	}
 
-	ts->input_dev->evbit[0] = BIT_MASK(EV_SYN) |
-				  BIT_MASK(EV_KEY) |
-				  BIT_MASK(EV_ABS);
-
 	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
 			     0, ts->abs_x_max, 0, 0);
 	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
