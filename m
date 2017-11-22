From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/6] Input: rmi4: remove unneeded MODULE_VERSION() usage
Date: Wed, 22 Nov 2017 18:49:16 +0100
Message-ID: <20171122174921.20192-2-gregkh@linuxfoundation.org>
References: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

MODULE_VERSION is useless for in-kernel drivers, so just remove all
usage of it in the rmi4 drivers.  Now that this is gone, the
RMI_DRIVER_VERSION macro was also removed as it was pointless.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/rmi4/rmi_bus.c    | 1 -
 drivers/input/rmi4/rmi_driver.h | 2 --
 drivers/input/rmi4/rmi_i2c.c    | 1 -
 drivers/input/rmi4/rmi_spi.c    | 1 -
 4 files changed, 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index ae1bffe45c75..c5fa53adba8d 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -427,4 +427,3 @@ MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com");
 MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com");
 MODULE_DESCRIPTION("RMI bus");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(RMI_DRIVER_VERSION);
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index f1a2a2266022..d31793ae83f0 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -16,8 +16,6 @@
 #include <linux/input.h>
 #include "rmi_bus.h"
 
-#define RMI_DRIVER_VERSION "2.0"
-
 #define SYNAPTICS_INPUT_DEVICE_NAME "Synaptics RMI4 Touch Sensor"
 #define SYNAPTICS_VENDOR_ID 0x06cb
 
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index e28663ef9e5a..d4b3f9d0dc2e 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -391,4 +391,3 @@ MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com>");
 MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com>");
 MODULE_DESCRIPTION("RMI I2C driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(RMI_DRIVER_VERSION);
diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index d97a85907ed6..76edbf2c1bce 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -528,4 +528,3 @@ MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com>");
 MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com>");
 MODULE_DESCRIPTION("RMI SPI driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(RMI_DRIVER_VERSION);
-- 
2.15.0
