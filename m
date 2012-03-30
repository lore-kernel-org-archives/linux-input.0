From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] input: st1232 device tree support
Date: Fri, 30 Mar 2012 17:47:49 +0900
Message-ID: <20120330084749.19624.84121.sendpatchset@w520>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: arnd@arndb.de, linux-sh@vger.kernel.org, dmitry.torokhov@gmail.com, rjw@sisk.pl, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch enables DT support for the st1232 driver
which is primarily used on the sh7372 Mackerel board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/touchscreen/st1232.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0001/drivers/input/touchscreen/st1232.c
+++ work/drivers/input/touchscreen/st1232.c	2012-03-29 14:43:13.000000000 +0900
@@ -255,6 +255,12 @@ static const struct i2c_device_id st1232
 };
 MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
 
+static const struct of_device_id st1232_ts_dt_ids[] __devinitconst = {
+	{ .compatible = "sitronix,st1232", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
+
 static struct i2c_driver st1232_ts_driver = {
 	.probe		= st1232_ts_probe,
 	.remove		= __devexit_p(st1232_ts_remove),
@@ -262,6 +268,7 @@ static struct i2c_driver st1232_ts_drive
 	.driver = {
 		.name	= ST1232_TS_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = st1232_ts_dt_ids,
 #ifdef CONFIG_PM
 		.pm	= &st1232_ts_pm_ops,
 #endif
