From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] input: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 15:00:33 +0900
Message-ID: <1436508033-11519-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60862 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbGJGAi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2015 02:00:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Ferruh Yigit <fery@cypress.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/input/keyboard/adp5589-keys.c       | 1 -
 drivers/input/keyboard/cap11xx.c            | 1 -
 drivers/input/keyboard/lm8333.c             | 1 -
 drivers/input/keyboard/mcs_touchkey.c       | 1 -
 drivers/input/keyboard/mpr121_touchkey.c    | 1 -
 drivers/input/keyboard/qt1070.c             | 1 -
 drivers/input/keyboard/qt2160.c             | 1 -
 drivers/input/keyboard/tca8418_keypad.c     | 1 -
 drivers/input/misc/adxl34x-i2c.c            | 1 -
 drivers/input/misc/bma150.c                 | 1 -
 drivers/input/misc/cma3000_d0x_i2c.c        | 1 -
 drivers/input/misc/drv260x.c                | 1 -
 drivers/input/misc/drv2665.c                | 1 -
 drivers/input/misc/drv2667.c                | 1 -
 drivers/input/misc/gp2ap002a00f.c           | 1 -
 drivers/input/misc/kxtj9.c                  | 1 -
 drivers/input/misc/mpu3050.c                | 1 -
 drivers/input/misc/pcf8574_keypad.c         | 1 -
 drivers/input/mouse/cyapa.c                 | 1 -
 drivers/input/mouse/elan_i2c_core.c         | 1 -
 drivers/input/mouse/synaptics_i2c.c         | 1 -
 drivers/input/touchscreen/ad7879-i2c.c      | 1 -
 drivers/input/touchscreen/ar1021_i2c.c      | 1 -
 drivers/input/touchscreen/atmel_mxt_ts.c    | 1 -
 drivers/input/touchscreen/auo-pixcir-ts.c   | 1 -
 drivers/input/touchscreen/bu21013_ts.c      | 1 -
 drivers/input/touchscreen/chipone_icn8318.c | 1 -
 drivers/input/touchscreen/cy8ctmg110_ts.c   | 1 -
 drivers/input/touchscreen/cyttsp4_i2c.c     | 1 -
 drivers/input/touchscreen/cyttsp_i2c.c      | 1 -
 drivers/input/touchscreen/edt-ft5x06.c      | 1 -
 drivers/input/touchscreen/egalax_ts.c       | 1 -
 drivers/input/touchscreen/elants_i2c.c      | 1 -
 drivers/input/touchscreen/goodix.c          | 1 -
 drivers/input/touchscreen/ili210x.c         | 1 -
 drivers/input/touchscreen/max11801_ts.c     | 1 -
 drivers/input/touchscreen/mms114.c          | 1 -
 drivers/input/touchscreen/pixcir_i2c_ts.c   | 1 -
 drivers/input/touchscreen/st1232.c          | 1 -
 drivers/input/touchscreen/tsc2007.c         | 1 -
 drivers/input/touchscreen/wacom_i2c.c       | 1 -
 drivers/input/touchscreen/zforce_ts.c       | 1 -
 42 files changed, 42 deletions(-)

diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 6ed83cf8b74e..4d446d5085aa 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -1097,7 +1097,6 @@ MODULE_DEVICE_TABLE(i2c, adp5589_id);
 static struct i2c_driver adp5589_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
-		.owner = THIS_MODULE,
 		.pm = &adp5589_dev_pm_ops,
 	},
 	.probe = adp5589_probe,
diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index f07461a64d85..b58fd9d72d92 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -361,7 +361,6 @@ MODULE_DEVICE_TABLE(i2c, cap11xx_i2c_ids);
 static struct i2c_driver cap11xx_i2c_driver = {
 	.driver = {
 		.name	= "cap11xx",
-		.owner	= THIS_MODULE,
 		.of_match_table = cap11xx_dt_ids,
 	},
 	.id_table	= cap11xx_i2c_ids,
diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 0ad422b8a260..c717e8f3c964 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -223,7 +223,6 @@ MODULE_DEVICE_TABLE(i2c, lm8333_id);
 static struct i2c_driver lm8333_driver = {
 	.driver = {
 		.name		= "lm8333",
-		.owner		= THIS_MODULE,
 	},
 	.probe		= lm8333_probe,
 	.remove		= lm8333_remove,
diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 375b05ca8e2a..31090d71a685 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -265,7 +265,6 @@ MODULE_DEVICE_TABLE(i2c, mcs_touchkey_id);
 static struct i2c_driver mcs_touchkey_driver = {
 	.driver = {
 		.name	= "mcs_touchkey",
-		.owner	= THIS_MODULE,
 		.pm	= &mcs_touchkey_pm_ops,
 	},
 	.probe		= mcs_touchkey_probe,
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 3aa2ec45bcab..0fd612dd76ed 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -305,7 +305,6 @@ MODULE_DEVICE_TABLE(i2c, mpr121_id);
 static struct i2c_driver mpr_touchkey_driver = {
 	.driver = {
 		.name	= "mpr121",
-		.owner	= THIS_MODULE,
 		.pm	= &mpr121_touchkey_pm_ops,
 	},
 	.id_table	= mpr121_id,
diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index 52cd6e88acd7..5a5778729e37 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -277,7 +277,6 @@ MODULE_DEVICE_TABLE(i2c, qt1070_id);
 static struct i2c_driver qt1070_driver = {
 	.driver	= {
 		.name	= "qt1070",
-		.owner	= THIS_MODULE,
 		.pm	= &qt1070_pm_ops,
 	},
 	.id_table	= qt1070_id,
diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 819b22897c13..43b86482dda0 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -497,7 +497,6 @@ MODULE_DEVICE_TABLE(i2c, qt2160_idtable);
 static struct i2c_driver qt2160_driver = {
 	.driver = {
 		.name	= "qt2160",
-		.owner  = THIS_MODULE,
 	},
 
 	.id_table	= qt2160_idtable,
diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 4e491c1762cf..9002298698fc 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -404,7 +404,6 @@ MODULE_ALIAS("i2c:tca8418");
 static struct i2c_driver tca8418_keypad_driver = {
 	.driver = {
 		.name	= TCA8418_NAME,
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(tca8418_dt_ids),
 	},
 	.probe		= tca8418_keypad_probe,
diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index bdb5d03b296e..a8b0a2eec344 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -158,7 +158,6 @@ MODULE_DEVICE_TABLE(of, adxl34x_of_id);
 static struct i2c_driver adxl34x_driver = {
 	.driver = {
 		.name = "adxl34x",
-		.owner = THIS_MODULE,
 		.pm = &adxl34x_i2c_pm,
 		.of_match_table = of_match_ptr(adxl34x_of_id),
 	},
diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index c2780493b0ed..1d0e61d7c131 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -653,7 +653,6 @@ MODULE_DEVICE_TABLE(i2c, bma150_id);
 
 static struct i2c_driver bma150_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= BMA150_DRIVER,
 		.pm	= &bma150_pm,
 	},
diff --git a/drivers/input/misc/cma3000_d0x_i2c.c b/drivers/input/misc/cma3000_d0x_i2c.c
index 4fdef98ceb56..c7021916b64b 100644
--- a/drivers/input/misc/cma3000_d0x_i2c.c
+++ b/drivers/input/misc/cma3000_d0x_i2c.c
@@ -118,7 +118,6 @@ static struct i2c_driver cma3000_i2c_driver = {
 	.id_table	= cma3000_i2c_id,
 	.driver = {
 		.name	= "cma3000_i2c_accl",
-		.owner	= THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm	= &cma3000_i2c_pm_ops,
 #endif
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index e5d60ecd29a4..64c33d1d5fca 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -720,7 +720,6 @@ static struct i2c_driver drv260x_driver = {
 	.probe		= drv260x_probe,
 	.driver		= {
 		.name	= "drv260x-haptics",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(drv260x_of_match),
 		.pm	= &drv260x_pm_ops,
 	},
diff --git a/drivers/input/misc/drv2665.c b/drivers/input/misc/drv2665.c
index 0afaa33de07d..c9e3f6dddced 100644
--- a/drivers/input/misc/drv2665.c
+++ b/drivers/input/misc/drv2665.c
@@ -309,7 +309,6 @@ static struct i2c_driver drv2665_driver = {
 	.probe		= drv2665_probe,
 	.driver		= {
 		.name	= "drv2665-haptics",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(drv2665_of_match),
 		.pm	= &drv2665_pm_ops,
 	},
diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
index fc0fddf0896a..df15bfd779bd 100644
--- a/drivers/input/misc/drv2667.c
+++ b/drivers/input/misc/drv2667.c
@@ -484,7 +484,6 @@ static struct i2c_driver drv2667_driver = {
 	.probe		= drv2667_probe,
 	.driver		= {
 		.name	= "drv2667-haptics",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(drv2667_of_match),
 		.pm	= &drv2667_pm_ops,
 	},
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index 0ac176d66a6f..ba301af91b95 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -271,7 +271,6 @@ static const struct i2c_device_id gp2a_i2c_id[] = {
 static struct i2c_driver gp2a_i2c_driver = {
 	.driver = {
 		.name	= GP2A_I2C_NAME,
-		.owner	= THIS_MODULE,
 		.pm	= &gp2a_pm,
 	},
 	.probe		= gp2a_probe,
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 6e29349da537..e058d711256a 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -658,7 +658,6 @@ MODULE_DEVICE_TABLE(i2c, kxtj9_id);
 static struct i2c_driver kxtj9_driver = {
 	.driver = {
 		.name	= NAME,
-		.owner	= THIS_MODULE,
 		.pm	= &kxtj9_pm_ops,
 	},
 	.probe		= kxtj9_probe,
diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index 5e5051351c3a..f088db31cfc7 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -466,7 +466,6 @@ MODULE_DEVICE_TABLE(of, mpu3050_of_match);
 static struct i2c_driver mpu3050_i2c_driver = {
 	.driver	= {
 		.name	= "mpu3050",
-		.owner	= THIS_MODULE,
 		.pm	= &mpu3050_pm,
 		.of_match_table = mpu3050_of_match,
 	},
diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
index 97f711a7bd20..4abdf1efb3e0 100644
--- a/drivers/input/misc/pcf8574_keypad.c
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -208,7 +208,6 @@ MODULE_DEVICE_TABLE(i2c, pcf8574_kp_id);
 static struct i2c_driver pcf8574_kp_driver = {
 	.driver = {
 		.name  = DRV_NAME,
-		.owner = THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm = &pcf8574_kp_pm_ops,
 #endif
diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index efe148474e7f..dfbfd494bb1f 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1382,7 +1382,6 @@ MODULE_DEVICE_TABLE(acpi, cyapa_acpi_id);
 static struct i2c_driver cyapa_driver = {
 	.driver = {
 		.name = "cyapa",
-		.owner = THIS_MODULE,
 		.pm = &cyapa_pm_ops,
 		.acpi_match_table = ACPI_PTR(cyapa_acpi_id),
 	},
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 5b5f403d8ce6..4ecb16cd961a 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1181,7 +1181,6 @@ MODULE_DEVICE_TABLE(of, elan_of_match);
 static struct i2c_driver elan_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
-		.owner	= THIS_MODULE,
 		.pm	= &elan_pm_ops,
 		.acpi_match_table = ACPI_PTR(elan_acpi_id),
 		.of_match_table = of_match_ptr(elan_of_match),
diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index ffceedcaf3c8..aa7c5da60800 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -655,7 +655,6 @@ MODULE_DEVICE_TABLE(i2c, synaptics_i2c_id_table);
 static struct i2c_driver synaptics_i2c_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
-		.owner	= THIS_MODULE,
 		.pm	= &synaptics_i2c_pm,
 	},
 
diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index dcf390771549..d66962c5b1c2 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -94,7 +94,6 @@ MODULE_DEVICE_TABLE(i2c, ad7879_id);
 static struct i2c_driver ad7879_i2c_driver = {
 	.driver = {
 		.name	= "ad7879",
-		.owner	= THIS_MODULE,
 		.pm	= &ad7879_pm_ops,
 	},
 	.probe		= ad7879_i2c_probe,
diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index f0b954d46a25..71b5a634cf6d 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -166,7 +166,6 @@ MODULE_DEVICE_TABLE(of, ar1021_i2c_of_match);
 static struct i2c_driver ar1021_i2c_driver = {
 	.driver	= {
 		.name	= "ar1021_i2c",
-		.owner	= THIS_MODULE,
 		.pm	= &ar1021_i2c_pm,
 		.of_match_table = ar1021_i2c_of_match,
 	},
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index dfc7309e3d38..8efe7a002f1e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2666,7 +2666,6 @@ MODULE_DEVICE_TABLE(i2c, mxt_id);
 static struct i2c_driver mxt_driver = {
 	.driver = {
 		.name	= "atmel_mxt_ts",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(mxt_of_match),
 		.acpi_match_table = ACPI_PTR(mxt_acpi_id),
 		.pm	= &mxt_pm_ops,
diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 40e02dd5b2f9..38c06f754acd 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -686,7 +686,6 @@ MODULE_DEVICE_TABLE(of, auo_pixcir_ts_dt_idtable);
 
 static struct i2c_driver auo_pixcir_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "auo_pixcir_ts",
 		.pm	= &auo_pixcir_pm_ops,
 		.of_match_table	= of_match_ptr(auo_pixcir_ts_dt_idtable),
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index b9b5ddad6658..931417eb4f5a 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -716,7 +716,6 @@ MODULE_DEVICE_TABLE(i2c, bu21013_id);
 static struct i2c_driver bu21013_driver = {
 	.driver	= {
 		.name	=	DRIVER_TP,
-		.owner	=	THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm	=	&bu21013_dev_pm_ops,
 #endif
diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index 32e9db0e04bf..22a6fead8cfb 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -300,7 +300,6 @@ MODULE_DEVICE_TABLE(i2c, icn8318_i2c_id);
 
 static struct i2c_driver icn8318_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "chipone_icn8318",
 		.pm	= &icn8318_pm_ops,
 		.of_match_table = icn8318_of_match,
diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index f2119ee0e21b..cc1d1350074e 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -347,7 +347,6 @@ MODULE_DEVICE_TABLE(i2c, cy8ctmg110_idtable);
 
 static struct i2c_driver cy8ctmg110_driver = {
 	.driver		= {
-		.owner	= THIS_MODULE,
 		.name	= CY8CTMG110_DRIVER_NAME,
 		.pm	= &cy8ctmg110_pm,
 	},
diff --git a/drivers/input/touchscreen/cyttsp4_i2c.c b/drivers/input/touchscreen/cyttsp4_i2c.c
index 8e2012c79058..9a323dd915de 100644
--- a/drivers/input/touchscreen/cyttsp4_i2c.c
+++ b/drivers/input/touchscreen/cyttsp4_i2c.c
@@ -74,7 +74,6 @@ MODULE_DEVICE_TABLE(i2c, cyttsp4_i2c_id);
 static struct i2c_driver cyttsp4_i2c_driver = {
 	.driver = {
 		.name	= CYTTSP4_I2C_NAME,
-		.owner	= THIS_MODULE,
 		.pm	= &cyttsp4_pm_ops,
 	},
 	.probe		= cyttsp4_i2c_probe,
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 63104a86a9bd..519e2de2f8df 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -74,7 +74,6 @@ MODULE_DEVICE_TABLE(i2c, cyttsp_i2c_id);
 static struct i2c_driver cyttsp_i2c_driver = {
 	.driver = {
 		.name	= CY_I2C_NAME,
-		.owner	= THIS_MODULE,
 		.pm	= &cyttsp_pm_ops,
 	},
 	.probe		= cyttsp_i2c_probe,
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 394b1de9a2a3..df30502e8200 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1134,7 +1134,6 @@ MODULE_DEVICE_TABLE(of, edt_ft5x06_of_match);
 
 static struct i2c_driver edt_ft5x06_ts_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "edt_ft5x06",
 		.of_match_table = of_match_ptr(edt_ft5x06_of_match),
 		.pm = &edt_ft5x06_ts_pm_ops,
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 4c56299284ef..7bce2d90ec74 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -268,7 +268,6 @@ static const struct of_device_id egalax_ts_dt_ids[] = {
 static struct i2c_driver egalax_ts_driver = {
 	.driver = {
 		.name	= "egalax_ts",
-		.owner	= THIS_MODULE,
 		.pm	= &egalax_ts_pm_ops,
 		.of_match_table	= egalax_ts_dt_ids,
 	},
diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 0efd766a545b..746137694137 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1261,7 +1261,6 @@ static struct i2c_driver elants_i2c_driver = {
 	.id_table = elants_i2c_id,
 	.driver = {
 		.name = DEVICE_NAME,
-		.owner = THIS_MODULE,
 		.pm = &elants_i2c_pm_ops,
 		.acpi_match_table = ACPI_PTR(elants_acpi_id),
 		.of_match_table = of_match_ptr(elants_of_match),
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index b4d12e29abff..ccd9dca61195 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -412,7 +412,6 @@ static struct i2c_driver goodix_ts_driver = {
 	.id_table = goodix_ts_id,
 	.driver = {
 		.name = "Goodix-TS",
-		.owner = THIS_MODULE,
 		.acpi_match_table = ACPI_PTR(goodix_acpi_match),
 		.of_match_table = of_match_ptr(goodix_of_match),
 	},
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index da6dc819c846..cf0dc2f0b1be 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -343,7 +343,6 @@ MODULE_DEVICE_TABLE(i2c, ili210x_i2c_id);
 static struct i2c_driver ili210x_ts_driver = {
 	.driver = {
 		.name = "ili210x_i2c",
-		.owner = THIS_MODULE,
 		.pm = &ili210x_i2c_pm,
 	},
 	.id_table = ili210x_i2c_id,
diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index a68ec142ee9a..82079cde849c 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -229,7 +229,6 @@ MODULE_DEVICE_TABLE(i2c, max11801_ts_id);
 static struct i2c_driver max11801_ts_driver = {
 	.driver = {
 		.name	= "max11801_ts",
-		.owner	= THIS_MODULE,
 	},
 	.id_table	= max11801_ts_id,
 	.probe		= max11801_ts_probe,
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 67c0d31613d8..6b69f461733c 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -577,7 +577,6 @@ static const struct of_device_id mms114_dt_match[] = {
 static struct i2c_driver mms114_driver = {
 	.driver = {
 		.name	= "mms114",
-		.owner	= THIS_MODULE,
 		.pm	= &mms114_pm_ops,
 		.of_match_table = of_match_ptr(mms114_dt_match),
 	},
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 8f3e243a62bf..66c82e38e799 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -602,7 +602,6 @@ MODULE_DEVICE_TABLE(of, pixcir_of_match);
 
 static struct i2c_driver pixcir_i2c_ts_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "pixcir_ts",
 		.pm	= &pixcir_dev_pm_ops,
 		.of_match_table = of_match_ptr(pixcir_of_match),
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 697e26e52d54..e943678ce54c 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -296,7 +296,6 @@ static struct i2c_driver st1232_ts_driver = {
 	.id_table	= st1232_ts_id,
 	.driver = {
 		.name	= ST1232_TS_NAME,
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(st1232_ts_dt_ids),
 		.pm	= &st1232_ts_pm_ops,
 	},
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index ccc8aa615709..5d0cd51c6f41 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -482,7 +482,6 @@ MODULE_DEVICE_TABLE(of, tsc2007_of_match);
 
 static struct i2c_driver tsc2007_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "tsc2007",
 		.of_match_table = of_match_ptr(tsc2007_of_match),
 	},
diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
index 32f8ac003936..8d7a2852caef 100644
--- a/drivers/input/touchscreen/wacom_i2c.c
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -271,7 +271,6 @@ MODULE_DEVICE_TABLE(i2c, wacom_i2c_id);
 static struct i2c_driver wacom_i2c_driver = {
 	.driver	= {
 		.name	= "wacom_i2c",
-		.owner	= THIS_MODULE,
 		.pm	= &wacom_i2c_pm,
 	},
 
diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index f58a196521a9..e3c7e0d85336 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -917,7 +917,6 @@ MODULE_DEVICE_TABLE(of, zforce_dt_idtable);
 
 static struct i2c_driver zforce_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "zforce-ts",
 		.pm	= &zforce_pm_ops,
 		.of_match_table	= of_match_ptr(zforce_dt_idtable),
-- 
1.9.1

