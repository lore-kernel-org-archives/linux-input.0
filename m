From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/6] Input: touchscreen: remove unneeded MODULE_VERSION() usage
Date: Wed, 22 Nov 2017 18:49:19 +0100
Message-ID: <20171122174921.20192-5-gregkh@linuxfoundation.org>
References: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sangwon Jee <jeesw@melfas.com>
List-Id: linux-input@vger.kernel.org

MODULE_VERSION is useless for in-kernel drivers, so just remove all
usage of it in the touchscreen drivers.  Along with this, some
DRV_VERSION macros were removed as they are also pointless.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sangwon Jee <jeesw@melfas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/colibri-vf50-ts.c | 2 --
 drivers/input/touchscreen/elants_i2c.c      | 2 --
 drivers/input/touchscreen/melfas_mip4.c     | 1 -
 drivers/input/touchscreen/wdt87xx_i2c.c     | 2 --
 4 files changed, 7 deletions(-)

diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/input/touchscreen/colibri-vf50-ts.c
index 69c08acae264..82ca5ab65cec 100644
--- a/drivers/input/touchscreen/colibri-vf50-ts.c
+++ b/drivers/input/touchscreen/colibri-vf50-ts.c
@@ -28,7 +28,6 @@
 #include <linux/types.h>
 
 #define DRIVER_NAME			"colibri-vf50-ts"
-#define DRV_VERSION			"1.0"
 
 #define VF_ADC_MAX			((1 << 12) - 1)
 
@@ -382,4 +381,3 @@ module_platform_driver(vf50_touch_driver);
 MODULE_AUTHOR("Sanchayan Maity");
 MODULE_DESCRIPTION("Colibri VF50 Touchscreen driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index e102d7764bc2..a174b8c79ef5 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -44,7 +44,6 @@
 
 /* Device, Driver information */
 #define DEVICE_NAME	"elants_i2c"
-#define DRV_VERSION	"1.0.9"
 
 /* Convert from rows or columns into resolution */
 #define ELAN_TS_RESOLUTION(n, m)   (((n) - 1) * (m))
@@ -1402,5 +1401,4 @@ module_i2c_driver(elants_i2c_driver);
 
 MODULE_AUTHOR("Scott Liu <scott.liu@emc.com.tw>");
 MODULE_DESCRIPTION("Elan I2c Touchscreen driver");
-MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 6892f0e28918..430a2bc5f7ca 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1611,6 +1611,5 @@ static struct i2c_driver mip4_driver = {
 module_i2c_driver(mip4_driver);
 
 MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
-MODULE_VERSION("2016.10.31");
 MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index d351efd18f89..20f7f3902757 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -23,7 +23,6 @@
 #include <asm/unaligned.h>
 
 #define WDT87XX_NAME		"wdt87xx_i2c"
-#define WDT87XX_DRV_VER		"0.9.8"
 #define WDT87XX_FW_NAME		"wdt87xx_fw.bin"
 #define WDT87XX_CFG_NAME	"wdt87xx_cfg.bin"
 
@@ -1183,5 +1182,4 @@ module_i2c_driver(wdt87xx_driver);
 
 MODULE_AUTHOR("HN Chen <hn.chen@weidahitech.com>");
 MODULE_DESCRIPTION("WeidaHiTech WDT87XX Touchscreen driver");
-MODULE_VERSION(WDT87XX_DRV_VER);
 MODULE_LICENSE("GPL");
-- 
2.15.0
