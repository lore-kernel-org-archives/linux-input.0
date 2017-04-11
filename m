From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH 1/3] input: touchscreen: ar1021_i2c: add support for AR1020
Date: Tue, 11 Apr 2017 12:27:57 +0200
Message-ID: <1491906479-17639-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, christian.gmeiner@gmail.com
Cc: linux@roeck-us.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

ar1021_i2c simply also supports the ar1020 device we use. This is tested.
They also share the same datasheet:

   http://ww1.microchip.com/downloads/en/DeviceDoc/40001393C.pdf

We differentiate not only to make it obvious that we support both devices,
but also to be able to implement the few model specific things in the
future.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 drivers/input/touchscreen/Kconfig      |  4 ++--
 drivers/input/touchscreen/ar1021_i2c.c | 13 ++++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 33c62e5..535b91a 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -96,8 +96,8 @@ config TOUCHSCREEN_AR1021_I2C
 	tristate "Microchip AR1021 i2c touchscreen"
 	depends on I2C && OF
 	help
-	  Say Y here if you have the Microchip AR1021 touchscreen controller
-	  chip in your system.
+	  Say Y here if you have the Microchip AR1020 or AR1021 touchscreen
+	  controller chip in your system.
 
 	  If unsure, say N.
 
diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index 6562b17..1767257 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -1,5 +1,5 @@
 /*
- * Microchip AR1021 driver for I2C
+ * Microchip AR1020 and AR1021 driver for I2C
  *
  * Author: Christian Gmeiner <christian.gmeiner@gmail.com>
  *
@@ -24,6 +24,11 @@ struct ar1021_i2c {
 	u8 data[AR1021_TOCUH_PKG_SIZE];
 };
 
+enum {
+	ar1021,
+	ar1020,
+};
+
 static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
 {
 	struct ar1021_i2c *ar1021 = dev_id;
@@ -151,13 +156,15 @@ static int __maybe_unused ar1021_i2c_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ar1021_i2c_pm, ar1021_i2c_suspend, ar1021_i2c_resume);
 
 static const struct i2c_device_id ar1021_i2c_id[] = {
-	{ "MICROCHIP_AR1021_I2C", 0 },
+	{ "MICROCHIP_AR1021_I2C", ar1021 },
+	{ "MICROCHIP_AR1020_I2C", ar1020 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);
 
 static const struct of_device_id ar1021_i2c_of_match[] = {
 	{ .compatible = "microchip,ar1021-i2c", },
+	{ .compatible = "microchip,ar1020-i2c", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ar1021_i2c_of_match);
@@ -175,5 +182,5 @@ static struct i2c_driver ar1021_i2c_driver = {
 module_i2c_driver(ar1021_i2c_driver);
 
 MODULE_AUTHOR("Christian Gmeiner <christian.gmeiner@gmail.com>");
-MODULE_DESCRIPTION("Microchip AR1021 I2C Driver");
+MODULE_DESCRIPTION("Microchip AR1020 and AR1021 I2C Driver");
 MODULE_LICENSE("GPL");
-- 
2.1.4
