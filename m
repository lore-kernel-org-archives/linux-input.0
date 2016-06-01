From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: raydium_i2c_ts - do not ignore EPROBE_DEFER from
 gpiod_get_optional
Date: Tue, 31 May 2016 18:30:07 -0700
Message-ID: <20160601013007.GA13021@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35754 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757040AbcFABaL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2016 21:30:11 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jeffrey Lin <jeffrey.lin@rad-ic.com>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org

We should not be ignoring -EPROBE_DEFER reported by
devm_gpiod_get_optional(), but report it as any other error to the upper
layers. While we are at it simplify check for the presence of reset GPIO
and instead of using IS_ERR_OR_NULL just use boolean.

Also do not return -ENOMEM from suspend handler when the device in
bootloader mode as that does not make sense and switch to -EBUSY instead.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 1ae65f6..f3076d9 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -930,7 +930,7 @@ static int raydium_i2c_power_on(struct raydium_data *ts)
 {
 	int error;
 
-	if (IS_ERR_OR_NULL(ts->reset_gpio))
+	if (!ts->reset_gpio)
 		return 0;
 
 	gpiod_set_value_cansleep(ts->reset_gpio, 1);
@@ -967,7 +967,7 @@ static void raydium_i2c_power_off(void *_data)
 {
 	struct raydium_data *ts = _data;
 
-	if (!IS_ERR_OR_NULL(ts->reset_gpio)) {
+	if (ts->reset_gpio) {
 		gpiod_set_value_cansleep(ts->reset_gpio, 1);
 		regulator_disable(ts->vccio);
 		regulator_disable(ts->avdd);
@@ -1018,11 +1018,10 @@ static int raydium_i2c_probe(struct i2c_client *client,
 						 GPIOD_OUT_LOW);
 	if (IS_ERR(ts->reset_gpio)) {
 		error = PTR_ERR(ts->reset_gpio);
-		if (error != -EPROBE_DEFER) {
+		if (error != -EPROBE_DEFER)
 			dev_err(&client->dev,
 				"failed to get reset gpio: %d\n", error);
-			return error;
-		}
+		return error;
 	}
 
 	error = raydium_i2c_power_on(ts);
@@ -1138,7 +1137,7 @@ static int __maybe_unused raydium_i2c_suspend(struct device *dev)
 
 	/* Sleep is not available in BLDR recovery mode */
 	if (ts->boot_mode != RAYDIUM_TS_MAIN)
-		return -ENOMEM;
+		return -EBUSY;
 
 	disable_irq(client->irq);
 
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
