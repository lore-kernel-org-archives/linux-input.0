From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: st1232 - switch to using SIMPLE_DEV_PM_OPS
Date: Fri, 30 Mar 2012 23:18:02 -0700
Message-ID: <20120331061801.GA20441@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Just compiled, not tested...

 drivers/input/touchscreen/st1232.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index e22e27e..a9be39f 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -218,7 +218,7 @@ static int __devexit st1232_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int st1232_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -243,12 +243,11 @@ static int st1232_ts_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops st1232_ts_pm_ops = {
-	.suspend	= st1232_ts_suspend,
-	.resume		= st1232_ts_resume,
-};
 #endif
 
+static SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
+			 st1232_ts_suspend, st1232_ts_resume);
+
 static const struct i2c_device_id st1232_ts_id[] = {
 	{ ST1232_TS_NAME, 0 },
 	{ }
@@ -269,9 +268,7 @@ static struct i2c_driver st1232_ts_driver = {
 		.name	= ST1232_TS_NAME,
 		.owner	= THIS_MODULE,
 		.of_match_table = st1232_ts_dt_ids,
-#ifdef CONFIG_PM
 		.pm	= &st1232_ts_pm_ops,
-#endif
 	},
 };
 
-- 
1.7.7.6


-- 
Dmitry
