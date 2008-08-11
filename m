From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] input: migor_ts compile and detection fix
Date: Mon, 11 Aug 2008 14:53:49 +0900
Message-ID: <20080811055349.19913.70612.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

The i2c layer got changed while the migor_ts driver was in the input
tree waiting to get merged upstream. Fix current compile issue by using
struct i2c_client member "name" instead of "driver_name". Also, add
id_table to make sure the device gets properly detected.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Paul, can you pick up this one together with other SuperH fixes?

 drivers/input/touchscreen/migor_ts.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- 0001/drivers/input/touchscreen/migor_ts.c
+++ work/drivers/input/touchscreen/migor_ts.c	2008-08-04 11:19:21.000000000 +0900
@@ -173,7 +173,7 @@ static int migor_ts_probe(struct i2c_cli
 	input_set_abs_params(input, ABS_X, 95, 955, 0, 0);
 	input_set_abs_params(input, ABS_Y, 85, 935, 0, 0);
 
-	input->name = client->driver_name;
+	input->name = client->name;
 	input->id.bustype = BUS_I2C;
 	input->dev.parent = &client->dev;
 
@@ -192,7 +192,7 @@ static int migor_ts_probe(struct i2c_cli
 		goto err1;
 
 	error = request_irq(priv->irq, migor_ts_isr, IRQF_TRIGGER_LOW,
-			    client->driver_name, priv);
+			    client->name, priv);
 	if (error) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
 		goto err2;
@@ -224,12 +224,19 @@ static int migor_ts_remove(struct i2c_cl
 	return 0;
 }
 
+static const struct i2c_device_id migor_ts_id[] = {
+	{ "migor_ts", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, migor_ts);
+
 static struct i2c_driver migor_ts_driver = {
 	.driver = {
 		.name = "migor_ts",
 	},
 	.probe = migor_ts_probe,
 	.remove = migor_ts_remove,
+	.id_table = migor_ts_id,
 };
 
 static int __init migor_ts_init(void)
