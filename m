From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] input: egalax_ts: remove bogus OF dependency
Date: Thu, 25 Apr 2013 12:15:30 +0300
Message-ID: <1366881330-8788-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

There are platforms using this driver which do not have OF. However, commit
ae495e84 ("Input: egalax_ts - get gpio from devicetree") added a Kconfig
dependency on OF and broke OF-less setups.

The mentioned commit does actually two things. It makes device tree mandatory
which is quite wrong approach, and it appends check for wake up function, which
is correct. The wake up function uses dedicated gpio lines to prepare
touchscreen device. However this is not the case when touchscreen is connected
via USB, there is no gpio lines for that.

This patch allows to use the device in non-DT environment properly.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: stable@vger.kernel.org # v3.7+
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/touchscreen/Kconfig     | 2 +-
 drivers/input/touchscreen/egalax_ts.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index f9a5fd8..006111b 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -227,7 +227,7 @@ config TOUCHSCREEN_EETI
 
 config TOUCHSCREEN_EGALAX
 	tristate "EETI eGalax multi-touch panel support"
-	depends on I2C && OF
+	depends on I2C
 	help
 	  Say Y here to enable support for I2C connected EETI
 	  eGalax multi-touch panels.
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 17c9097..f85c074 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -128,7 +128,11 @@ static int egalax_wake_up_device(struct i2c_client *client)
 	int ret;
 
 	if (!np)
-		return -ENODEV;
+		/*
+		 * Do not try to wake up device on non-DT compatible platforms.
+		 * For example this is the case for USB connected touchscreen.
+		 */
+		return 0;
 
 	gpio = of_get_named_gpio(np, "wakeup-gpios", 0);
 	if (!gpio_is_valid(gpio))
@@ -287,10 +291,12 @@ static int egalax_ts_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(egalax_ts_pm_ops, egalax_ts_suspend, egalax_ts_resume);
 
+#ifdef CONFIG_OF
 static struct of_device_id egalax_ts_dt_ids[] = {
 	{ .compatible = "eeti,egalax_ts" },
 	{ /* sentinel */ }
 };
+#endif
 
 static struct i2c_driver egalax_ts_driver = {
 	.driver = {
-- 
1.8.2.rc0.22.gb3600c3
