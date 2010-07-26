From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 26/36]  [Driver][Qualcomm 1070][EC_BL] New EC backlight driver porting
Date: Mon, 26 Jul 2010 16:30:35 +0800
Message-ID: <1280133045-25945-26-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52573 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab0GZId0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:26 -0400
Received: by pwi5 with SMTP id 5so4323272pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:26 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 drivers/leds/Kconfig              |   20 +++++-----
 drivers/leds/Makefile             |    1 +
 drivers/leds/leds-qci-backlight.c |   77 +++++++++++++++++++++++++++++++++++++
 drivers/leds/leds-qci-backlight.h |   34 ++++++++++++++++
 4 files changed, 122 insertions(+), 10 deletions(-)
 create mode 100755 drivers/leds/leds-qci-backlight.c
 create mode 100755 drivers/leds/leds-qci-backlight.h

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index e4f599f..7d29ec7 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -150,9 +150,9 @@ config LEDS_LP3944
 	tristate "LED Support for N.S. LP3944 (Fun Light) I2C chip"
 	depends on LEDS_CLASS && I2C
 	help
-	  This option enables support for LEDs connected to the National
-	  Semiconductor LP3944 Lighting Management Unit (LMU) also known as
-	  Fun Light Chip.
+    This option enables support for LEDs connected to the National
+    Semiconductor LP3944 Lighting Management Unit (LMU) also known as
+    Fun Light Chip.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called leds-lp3944.
@@ -195,13 +195,6 @@ config LEDS_PCA955X
 	  LED driver chips accessed via the I2C bus.  Supported
 	  devices include PCA9550, PCA9551, PCA9552, and PCA9553.
 
-config LEDS_WM831X_STATUS
-	tristate "LED support for status LEDs on WM831x PMICs"
-	depends on LEDS_CLASS && MFD_WM831X
-	help
-	  This option enables support for the status LEDs of the WM831x
-          series of PMICs.
-
 config LEDS_WM8350
 	tristate "LED Support for WM8350 AudioPlus PMIC"
 	depends on LEDS_CLASS && MFD_WM8350
@@ -236,6 +229,13 @@ config LEDS_BD2802
 	  This option enables support for BD2802GU RGB LED driver chips
 	  accessed via the I2C bus.
 
+config LEDS_QCIBL
+	tristate "LED Support for Quanta LCD backlight"
+	depends on SENSORS_NPCE781X
+	default n
+	help
+	  Say Y here if you want to use the Quanta backlight driver for ST 1.5 platform.
+
 comment "LED Triggers"
 
 config LEDS_TRIGGERS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 46d7270..a7a8df8 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_LEDS_DA903X)		+= leds-da903x.o
 obj-$(CONFIG_LEDS_WM831X_STATUS)	+= leds-wm831x-status.o
 obj-$(CONFIG_LEDS_WM8350)		+= leds-wm8350.o
 obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
+obj-$(CONFIG_LEDS_QCIBL)		+= leds-qci-backlight.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-qci-backlight.c b/drivers/leds/leds-qci-backlight.c
new file mode 100755
index 0000000..d4b404d
--- /dev/null
+++ b/drivers/leds/leds-qci-backlight.c
@@ -0,0 +1,77 @@
+/*Quanta I2C Backlight Driver
+ *
+ * Copyright (C) 2009 Quanta Computer Inc.
+ * Author: Austin Lai <austin.lai@quantatw.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ *
+ *  The Driver with I/O communications via the I2C Interface for ON2 of AP BU.
+ *  And it is only working on the nuvoTon WPCE775x Embedded Controller.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include "leds-qci-backlight.h"
+
+static void qci_backlight_store(struct led_classdev *led_cdev,
+	enum led_brightness val);
+static int qci_backlight_show(struct led_classdev *led_cdev);
+
+static struct platform_device *bl_pdev;
+static struct led_classdev lcd_backlight = {
+	.name = "lcd-backlight",
+	.brightness = 147,
+	.brightness_get = qci_backlight_show,
+	.brightness_set = qci_backlight_store,
+};
+
+static int qci_backlight_show(struct led_classdev *led_cdev)
+{
+	return npce_read_ecram(EC_CMD_SET_BACKLIGHT);
+}
+
+static void qci_backlight_store(struct led_classdev *led_cdev,
+	enum led_brightness val)
+{
+	u16 value = val;
+	npce_smbus_write_word_data(EC_CMD_SET_BACKLIGHT, value);
+	mdelay(10);
+
+	pr_info("[backlight_store] : value  = %d\n", value);
+}
+
+static int __init qci_backlight_init(void)
+{
+	int err = 0;
+	bl_pdev = platform_device_register_simple("backlight", 0, NULL, 0);
+	err = led_classdev_register(&bl_pdev->dev, &lcd_backlight);
+	return err;
+}
+
+static void __exit qci_backlight_exit(void)
+{
+	led_classdev_unregister(&lcd_backlight);
+	platform_device_unregister(bl_pdev);
+}
+
+module_init(qci_backlight_init);
+module_exit(qci_backlight_exit);
+
+MODULE_AUTHOR("Quanta Computer Inc.");
+MODULE_DESCRIPTION("Quanta Embedded Controller I2C Touch Pad Driver");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/leds/leds-qci-backlight.h b/drivers/leds/leds-qci-backlight.h
new file mode 100755
index 0000000..b6ccfd5
--- /dev/null
+++ b/drivers/leds/leds-qci-backlight.h
@@ -0,0 +1,34 @@
+/* arm\mach-msm\include\mach\leds-qci-backlight.h
+ * Header file for Quanta lcd backlight Driver
+ *
+ * Copyright (C) 2009 Quanta Computer Inc.
+ * Author: Austin Lai <austin.lai@quantatw.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+  /*
+ *
+ *  The Driver with I/O communications via the I2C Interface for ON2 of AP BU.
+ *  And it is only working on the nuvoTon WPCE775x Embedded Controller.
+ *
+ */
+
+#ifndef __LEDS_QCI_BACKLIGHT_H__
+#define __LEDS_QCI_BACKLIGHT_H__
+
+//#define EC_CMD_SET_BACKLIGHT 0xB1
+#define EC_CMD_SET_BACKLIGHT 0xC4
+
+extern int npce_smbus_write_word_data(u8 command, u16 value);
+extern int npce_read_ecram(u8 ecram);
+
+#endif
-- 
1.7.0.4

