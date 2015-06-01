From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: edt-ft5x06 - mark as direct input device
Date: Mon, 1 Jun 2015 10:50:12 -0700
Message-ID: <20150601175012.GA6994@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34763 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbFARuR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jun 2015 13:50:17 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Simon Budig <simon.budig@kernelconcepts.de>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org

edt-ft5x06 is a touchscreen and thus a direct input device; let's amrk it
as such. This also allows us to drop some initialization code as
input_init_mt_slots() will do that for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index e6aef3e..29d179a 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1035,11 +1035,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input->id.bustype = BUS_I2C;
 	input->dev.parent = &client->dev;
 
-	__set_bit(EV_KEY, input->evbit);
-	__set_bit(EV_ABS, input->evbit);
-	__set_bit(BTN_TOUCH, input->keybit);
-	input_set_abs_params(input, ABS_X, 0, tsdata->num_x * 64 - 1, 0, 0);
-	input_set_abs_params(input, ABS_Y, 0, tsdata->num_y * 64 - 1, 0, 0);
 	input_set_abs_params(input, ABS_MT_POSITION_X,
 			     0, tsdata->num_x * 64 - 1, 0, 0);
 	input_set_abs_params(input, ABS_MT_POSITION_Y,
@@ -1048,7 +1043,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	if (!pdata)
 		touchscreen_parse_of_params(input);
 
-	error = input_mt_init_slots(input, MAX_SUPPORT_POINTS, 0);
+	error = input_mt_init_slots(input, MAX_SUPPORT_POINTS, INPUT_MT_DIRECT);
 	if (error) {
 		dev_err(&client->dev, "Unable to init MT slots.\n");
 		return error;
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
