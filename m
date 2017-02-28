From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 04/10] Input: eeti_ts - use input_set_capability()
Date: Tue, 28 Feb 2017 14:46:26 -0800
Message-ID: <20170228224632.3401-4-dmitry.torokhov@gmail.com>
References: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Use input_set_capability() instead of manipulating evbit/keybit
masks directly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/eeti_ts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 0e4b19236d68..b472e0e467e8 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -186,8 +186,7 @@ static int eeti_ts_probe(struct i2c_client *client,
 		goto err1;
 	}
 
-	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_capability(input, EV_KEY, BTN_TOUCH);
 
 	input_set_abs_params(input, ABS_X, 0, EETI_MAXVAL, 0, 0);
 	input_set_abs_params(input, ABS_Y, 0, EETI_MAXVAL, 0, 0);
-- 
2.11.0.483.g087da7b7c-goog
