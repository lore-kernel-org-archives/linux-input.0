From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] Input: st1232 - Remove obsolete platform device support
Date: Thu, 12 Oct 2017 11:41:15 +0200
Message-ID: <1507801275-12668-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-input@vger.kernel.org

Commit 1fa59bda21c7fa36 ("ARM: shmobile: Remove legacy board code for
Armadillo-800 EVA"), removed the last user of st1232_pdata and the
"st1232-ts" platform device.  All remaining users use DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/touchscreen/st1232.c         | 16 +++-------------
 include/linux/platform_data/st1232_pdata.h | 13 -------------
 2 files changed, 3 insertions(+), 26 deletions(-)
 delete mode 100644 include/linux/platform_data/st1232_pdata.h

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index be5615c6bf8ff5e9..d5dfa4053bbf2359 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -29,7 +29,6 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/platform_data/st1232_pdata.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 
@@ -152,10 +151,9 @@ static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
 }
 
 static int st1232_ts_probe(struct i2c_client *client,
-					const struct i2c_device_id *id)
+			   const struct i2c_device_id *id)
 {
 	struct st1232_ts_data *ts;
-	struct st1232_pdata *pdata = dev_get_platdata(&client->dev);
 	struct input_dev *input_dev;
 	int error;
 
@@ -180,13 +178,7 @@ static int st1232_ts_probe(struct i2c_client *client,
 	ts->client = client;
 	ts->input_dev = input_dev;
 
-	if (pdata)
-		ts->reset_gpio = pdata->reset_gpio;
-	else if (client->dev.of_node)
-		ts->reset_gpio = of_get_gpio(client->dev.of_node, 0);
-	else
-		ts->reset_gpio = -ENODEV;
-
+	ts->reset_gpio = of_get_gpio(client->dev.of_node, 0);
 	if (gpio_is_valid(ts->reset_gpio)) {
 		error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);
 		if (error) {
@@ -281,13 +273,11 @@ static const struct i2c_device_id st1232_ts_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id st1232_ts_dt_ids[] = {
 	{ .compatible = "sitronix,st1232", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
-#endif
 
 static struct i2c_driver st1232_ts_driver = {
 	.probe		= st1232_ts_probe,
@@ -295,7 +285,7 @@ static struct i2c_driver st1232_ts_driver = {
 	.id_table	= st1232_ts_id,
 	.driver = {
 		.name	= ST1232_TS_NAME,
-		.of_match_table = of_match_ptr(st1232_ts_dt_ids),
+		.of_match_table = st1232_ts_dt_ids,
 		.pm	= &st1232_ts_pm_ops,
 	},
 };
diff --git a/include/linux/platform_data/st1232_pdata.h b/include/linux/platform_data/st1232_pdata.h
deleted file mode 100644
index cac3e7b4c45418aa..0000000000000000
--- a/include/linux/platform_data/st1232_pdata.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef _LINUX_ST1232_PDATA_H
-#define _LINUX_ST1232_PDATA_H
-
-/*
- * Optional platform data
- *
- * Use this if you want the driver to drive the reset pin.
- */
-struct st1232_pdata {
-	int reset_gpio;
-};
-
-#endif
-- 
2.7.4
