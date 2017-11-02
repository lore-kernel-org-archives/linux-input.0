From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] Input: ar1021_i2c - set INPUT_PROP_DIRECT
Date: Thu,  2 Nov 2017 11:30:25 +0100
Message-ID: <20171102103025.19580-1-martink@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux@roeck-us.net
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

If INPUT_PROP_DIRECT is set, userspace doesn't have to fall back to old
ways of identifying touchscreen devices. Let's add it.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/touchscreen/ar1021_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index f9dcbd63e598..b35b640fdadf 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -117,6 +117,7 @@ static int ar1021_i2c_probe(struct i2c_client *client,
 	input->open = ar1021_i2c_open;
 	input->close = ar1021_i2c_close;
 
+	__set_bit(INPUT_PROP_DIRECT, input->propbit);
 	input_set_capability(input, EV_KEY, BTN_TOUCH);
 	input_set_abs_params(input, ABS_X, 0, AR1021_MAX_X, 0, 0);
 	input_set_abs_params(input, ABS_Y, 0, AR1021_MAX_Y, 0, 0);
-- 
2.11.0
