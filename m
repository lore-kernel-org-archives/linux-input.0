From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5/5] Input: touchscreen - drop unnecessary calls to input_set_drvdata
Date: Sun, 22 Jan 2017 16:48:24 -0800
Message-ID: <1485132505-14562-6-git-send-email-linux@roeck-us.net>
References: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Since there is no call to dev_get_drvdata() or input_get_drvdata(),
the call to input_set_drvdata() is unnecessary and can be dropped.

The conversion was done automatically using the following coccinelle
script.

@used@
@@

(
input_get_drvdata(...)
|
dev_get_drvdata(...)
)

@depends on !used@
@@

- input_set_drvdata(...);

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/edt-ft5x06.c     | 1 -
 drivers/input/touchscreen/egalax_ts.c      | 2 --
 drivers/input/touchscreen/elants_i2c.c     | 2 --
 drivers/input/touchscreen/ili210x.c        | 1 -
 drivers/input/touchscreen/mcs5000_ts.c     | 1 -
 drivers/input/touchscreen/raydium_i2c_ts.c | 2 --
 6 files changed, 9 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 8fc629fb023f..8cf8d8d5d4ef 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -982,7 +982,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
-	input_set_drvdata(input, tsdata);
 	i2c_set_clientdata(client, tsdata);
 
 	irq_flags = irq_get_trigger_type(client->irq);
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 3592a946950b..752ae9cf4514 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -214,8 +214,6 @@ static int egalax_ts_probe(struct i2c_client *client,
 			     ABS_MT_POSITION_Y, 0, EGALAX_MAX_Y, 0, 0);
 	input_mt_init_slots(input_dev, MAX_SUPPORT_POINTS, 0);
 
-	input_set_drvdata(input_dev, ts);
-
 	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 					  egalax_ts_interrupt,
 					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 3e6003d32e56..872750eeca93 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1260,8 +1260,6 @@ static int elants_i2c_probe(struct i2c_client *client,
 	input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->x_res);
 	input_abs_set_res(ts->input, ABS_MT_POSITION_Y, ts->y_res);
 
-	input_set_drvdata(ts->input, ts);
-
 	error = input_register_device(ts->input);
 	if (error) {
 		dev_err(&client->dev,
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 91dc5fb34fe1..6f76eeedf465 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -256,7 +256,6 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 	input_set_abs_params(input, ABS_MT_POSITION_X, 0, xmax, 0, 0);
 	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ymax, 0, 0);
 
-	input_set_drvdata(input, priv);
 	i2c_set_clientdata(client, priv);
 
 	error = request_irq(client->irq, ili210x_irq, pdata->irq_flags,
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 8b47e1fecb25..90fc07dc98a6 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -221,7 +221,6 @@ static int mcs5000_ts_probe(struct i2c_client *client,
 	input_set_abs_params(input_dev, ABS_X, 0, MCS5000_MAX_XC, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y, 0, MCS5000_MAX_YC, 0, 0);
 
-	input_set_drvdata(input_dev, data);
 	data->input_dev = input_dev;
 
 	if (pdata->cfg_pin)
diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 2658afa016c9..1252e49ccfa1 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -1087,8 +1087,6 @@ static int raydium_i2c_probe(struct i2c_client *client,
 	ts->input->name = "Raydium Touchscreen";
 	ts->input->id.bustype = BUS_I2C;
 
-	input_set_drvdata(ts->input, ts);
-
 	input_set_abs_params(ts->input, ABS_MT_POSITION_X,
 			     0, le16_to_cpu(ts->info.x_max), 0, 0);
 	input_set_abs_params(ts->input, ABS_MT_POSITION_Y,
-- 
2.7.4
