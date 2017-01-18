From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 28/33] Input: egalax_ts - Drop unnecessary call to i2c_set_clientdata and other changes
Date: Wed, 18 Jan 2017 09:46:49 -0800
Message-ID: <1484761614-12225-29-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

There is no call to i2c_get_clientdata() or dev_get_drvdata().
Drop the unnecessary call to i2c_set_clientdata().
Other relevant changes:
  Simplify error return
  Drop error messages after memory allocation failures

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop unused variables
- Drop unnecessary braces around conditional return statements
- Drop error message after devm_kzalloc() failure
- Replace 'if (e) return e; return 0;' with 'return e;'
- Drop i2c_set_clientdata()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/egalax_ts.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 1afc08b08155..05ba1a6dc7fc 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -82,10 +82,9 @@ static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
 	if (ret < 0)
 		return IRQ_HANDLED;
 
-	if (buf[0] != REPORT_MODE_MTTOUCH) {
+	if (buf[0] != REPORT_MODE_MTTOUCH)
 		/* ignore mouse events and vendor events */
 		return IRQ_HANDLED;
-	}
 
 	state = buf[1];
 	x = (buf[3] << 8) | buf[2];
@@ -155,13 +154,8 @@ static int egalax_wake_up_device(struct i2c_client *client)
 static int egalax_firmware_version(struct i2c_client *client)
 {
 	static const u8 cmd[MAX_I2C_DATA_LEN] = { 0x03, 0x03, 0xa, 0x01, 0x41 };
-	int ret;
-
-	ret = i2c_master_send(client, cmd, MAX_I2C_DATA_LEN);
-	if (ret < 0)
-		return ret;
 
-	return 0;
+	return i2c_master_send(client, cmd, MAX_I2C_DATA_LEN);
 }
 
 static int egalax_ts_probe(struct i2c_client *client,
@@ -172,10 +166,8 @@ static int egalax_ts_probe(struct i2c_client *client,
 	int error;
 
 	ts = devm_kzalloc(&client->dev, sizeof(struct egalax_ts), GFP_KERNEL);
-	if (!ts) {
-		dev_err(&client->dev, "Failed to allocate memory\n");
+	if (!ts)
 		return -ENOMEM;
-	}
 
 	input_dev = devm_input_allocate_device(&client->dev);
 	if (!input_dev) {
@@ -225,12 +217,7 @@ static int egalax_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = input_register_device(ts->input_dev);
-	if (error)
-		return error;
-
-	i2c_set_clientdata(client, ts);
-	return 0;
+	return input_register_device(ts->input_dev);
 }
 
 static const struct i2c_device_id egalax_ts_id[] = {
-- 
2.7.4
