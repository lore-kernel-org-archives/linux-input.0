From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH 3/7] input: use module_i2c_driver in misc i2c driver
Date: Mon, 19 Dec 2011 22:23:21 +0800
Message-ID: <1324304605-18193-4-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40758 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab1LSOYu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Dec 2011 09:24:50 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so8615511iae.19
        for <linux-input@vger.kernel.org>; Mon, 19 Dec 2011 06:24:50 -0800 (PST)
In-Reply-To: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Greg Kroah-Hartman <gregkh@suse.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

use module_i2c_driver in misc i2c driver since commit:
http://git.kernel.org/?p=linux/kernel/git/gregkh/driver-core.git;a=commitdiff;h=7c92784a546d2945b6d6973a30f7134be78eb7a4
has added this to driver-core-next.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/misc/ad714x-i2c.c      |   12 +-----------
 drivers/input/misc/adxl34x-i2c.c     |   12 +-----------
 drivers/input/misc/bma150.c          |   13 +------------
 drivers/input/misc/cma3000_d0x_i2c.c |   13 +------------
 drivers/input/misc/gp2ap002a00f.c    |   13 +------------
 drivers/input/misc/kxtj9.c           |   12 +-----------
 drivers/input/misc/mma8450.c         |   12 +-----------
 drivers/input/misc/mpu3050.c         |   12 +-----------
 drivers/input/misc/pcf8574_keypad.c  |   12 +-----------
 9 files changed, 9 insertions(+), 102 deletions(-)

diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index 56810fb..c8a7901 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -116,17 +116,7 @@ static struct i2c_driver ad714x_i2c_driver = {
 	.id_table = ad714x_id,
 };
 
-static int __init ad714x_i2c_init(void)
-{
-	return i2c_add_driver(&ad714x_i2c_driver);
-}
-module_init(ad714x_i2c_init);
-
-static void __exit ad714x_i2c_exit(void)
-{
-	i2c_del_driver(&ad714x_i2c_driver);
-}
-module_exit(ad714x_i2c_exit);
+module_i2c_driver(ad714x_i2c_driver);
 
 MODULE_DESCRIPTION("Analog Devices AD714X Capacitance Touch Sensor I2C Bus Driver");
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index ccacf2b..dd1d1c1 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -148,17 +148,7 @@ static struct i2c_driver adxl34x_driver = {
 	.id_table = adxl34x_id,
 };
 
-static int __init adxl34x_i2c_init(void)
-{
-	return i2c_add_driver(&adxl34x_driver);
-}
-module_init(adxl34x_i2c_init);
-
-static void __exit adxl34x_i2c_exit(void)
-{
-	i2c_del_driver(&adxl34x_driver);
-}
-module_exit(adxl34x_i2c_exit);
+module_i2c_driver(adxl34x_driver);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("ADXL345/346 Three-Axis Digital Accelerometer I2C Bus Driver");
diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 8f55b54..e2f1e9f 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -673,19 +673,8 @@ static struct i2c_driver bma150_driver = {
 	.remove		= __devexit_p(bma150_remove),
 };
 
-static int __init BMA150_init(void)
-{
-	return i2c_add_driver(&bma150_driver);
-}
-
-static void __exit BMA150_exit(void)
-{
-	i2c_del_driver(&bma150_driver);
-}
+module_i2c_driver(bma150_driver);
 
 MODULE_AUTHOR("Albert Zhang <xu.zhang@bosch-sensortec.com>");
 MODULE_DESCRIPTION("BMA150 driver");
 MODULE_LICENSE("GPL");
-
-module_init(BMA150_init);
-module_exit(BMA150_exit);
diff --git a/drivers/input/misc/cma3000_d0x_i2c.c b/drivers/input/misc/cma3000_d0x_i2c.c
index d100cc5..fe9b85f 100644
--- a/drivers/input/misc/cma3000_d0x_i2c.c
+++ b/drivers/input/misc/cma3000_d0x_i2c.c
@@ -125,18 +125,7 @@ static struct i2c_driver cma3000_i2c_driver = {
 	},
 };
 
-static int __init cma3000_i2c_init(void)
-{
-	return i2c_add_driver(&cma3000_i2c_driver);
-}
-
-static void __exit cma3000_i2c_exit(void)
-{
-	i2c_del_driver(&cma3000_i2c_driver);
-}
-
-module_init(cma3000_i2c_init);
-module_exit(cma3000_i2c_exit);
+module_i2c_driver(cma3000_i2c_driver);
 
 MODULE_DESCRIPTION("CMA3000-D0x Accelerometer I2C Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index 71fba8c..b6664cf 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -281,18 +281,7 @@ static struct i2c_driver gp2a_i2c_driver = {
 	.id_table	= gp2a_i2c_id,
 };
 
-static int __init gp2a_init(void)
-{
-	return i2c_add_driver(&gp2a_i2c_driver);
-}
-
-static void __exit gp2a_exit(void)
-{
-	i2c_del_driver(&gp2a_i2c_driver);
-}
-
-module_init(gp2a_init);
-module_exit(gp2a_exit);
+module_i2c_driver(gp2a_i2c_driver);
 
 MODULE_AUTHOR("Courtney Cavin <courtney.cavin@sonyericsson.com>");
 MODULE_DESCRIPTION("Sharp GP2AP002A00F I2C Proximity/Opto sensor driver");
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 783597a..1c15900 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -655,17 +655,7 @@ static struct i2c_driver kxtj9_driver = {
 	.id_table	= kxtj9_id,
 };
 
-static int __init kxtj9_init(void)
-{
-	return i2c_add_driver(&kxtj9_driver);
-}
-module_init(kxtj9_init);
-
-static void __exit kxtj9_exit(void)
-{
-	i2c_del_driver(&kxtj9_driver);
-}
-module_exit(kxtj9_exit);
+module_i2c_driver(kxtj9_driver);
 
 MODULE_DESCRIPTION("KXTJ9 accelerometer driver");
 MODULE_AUTHOR("Chris Hudson <chudson@kionix.com>");
diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index 4d60080..873ebce 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -247,17 +247,7 @@ static struct i2c_driver mma8450_driver = {
 	.id_table	= mma8450_id,
 };
 
-static int __init mma8450_init(void)
-{
-	return i2c_add_driver(&mma8450_driver);
-}
-module_init(mma8450_init);
-
-static void __exit mma8450_exit(void)
-{
-	i2c_del_driver(&mma8450_driver);
-}
-module_exit(mma8450_exit);
+module_i2c_driver(mma8450_driver);
 
 MODULE_AUTHOR("Freescale Semiconductor, Inc.");
 MODULE_DESCRIPTION("MMA8450 3-Axis Accelerometer Driver");
diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index f71dc72..bd9e1f4 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -359,17 +359,7 @@ static struct i2c_driver mpu3050_i2c_driver = {
 	.id_table	= mpu3050_ids,
 };
 
-static int __init mpu3050_init(void)
-{
-	return i2c_add_driver(&mpu3050_i2c_driver);
-}
-module_init(mpu3050_init);
-
-static void __exit mpu3050_exit(void)
-{
-	i2c_del_driver(&mpu3050_i2c_driver);
-}
-module_exit(mpu3050_exit);
+module_i2c_driver(mpu3050_i2c_driver);
 
 MODULE_AUTHOR("Wistron Corp.");
 MODULE_DESCRIPTION("MPU3050 Tri-axis gyroscope driver");
diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
index 08be1a3..544c663 100644
--- a/drivers/input/misc/pcf8574_keypad.c
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -216,17 +216,7 @@ static struct i2c_driver pcf8574_kp_driver = {
 	.id_table = pcf8574_kp_id,
 };
 
-static int __init pcf8574_kp_init(void)
-{
-	return i2c_add_driver(&pcf8574_kp_driver);
-}
-module_init(pcf8574_kp_init);
-
-static void __exit pcf8574_kp_exit(void)
-{
-	i2c_del_driver(&pcf8574_kp_driver);
-}
-module_exit(pcf8574_kp_exit);
+module_i2c_driver(pcf8574_kp_driver);
 
 MODULE_AUTHOR("Michael Hennerich");
 MODULE_DESCRIPTION("Keypad input driver for 16 keys connected to PCF8574");
-- 
1.7.8

