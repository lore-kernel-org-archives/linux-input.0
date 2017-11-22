From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/6] Input: mouse: elan_i2c: remove unneeded MODULE_VERSION() usage
Date: Wed, 22 Nov 2017 18:49:18 +0100
Message-ID: <20171122174921.20192-4-gregkh@linuxfoundation.org>
References: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

MODULE_VERSION is useless for in-kernel drivers, so just remove all
usage of it in the elan_i2c mouse driver.  Now that this is gone, the
ELAN_DRIVER_VERSION define was also removed as it was pointless.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/elan_i2c_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 2111a85d0b17..75e757520ef0 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -42,7 +42,6 @@
 #include "elan_i2c.h"
 
 #define DRIVER_NAME		"elan_i2c"
-#define ELAN_DRIVER_VERSION	"1.6.3"
 #define ELAN_VENDOR_ID		0x04f3
 #define ETP_MAX_PRESSURE	255
 #define ETP_FWIDTH_REDUCE	90
@@ -1294,4 +1293,3 @@ module_i2c_driver(elan_driver);
 MODULE_AUTHOR("Duson Lin <dusonlin@emc.com.tw>");
 MODULE_DESCRIPTION("Elan I2C/SMBus Touchpad driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(ELAN_DRIVER_VERSION);
-- 
2.15.0
