From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v6 1/3] ARM: SAMSUNG: Add keypad device support
Date: Mon, 28 Jun 2010 20:33:42 +0900
Message-ID: <1277724824-13308-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40496 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0F1LeQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 07:34:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, ben-linux@fluff.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, kgene.kim@samsung.com

This patch adds samsung keypad device definition for samsung cpus.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/Kconfig               |    5 ++
 arch/arm/plat-samsung/Makefile              |    1 +
 arch/arm/plat-samsung/dev-keypad.c          |   58 ++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h   |    2 +
 arch/arm/plat-samsung/include/plat/keypad.h |   59 +++++++++++++++++++++++++++
 5 files changed, 125 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev-keypad.c
 create mode 100644 arch/arm/plat-samsung/include/plat/keypad.h

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 2753fb3..bd007e3 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -227,6 +227,11 @@ config SAMSUNG_DEV_TS
 	help
 	    Common in platform device definitions for touchscreen device
 
+config SAMSUNG_DEV_KEYPAD
+	bool
+	help
+	  Compile in platform device definitions for keypad
+
 # DMA
 
 config S3C_DMA
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index b1d82cc..8269d80 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_S3C_DEV_RTC)	+= dev-rtc.o
 
 obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
 obj-$(CONFIG_SAMSUNG_DEV_TS)	+= dev-ts.o
+obj-$(CONFIG_SAMSUNG_DEV_KEYPAD)	+= dev-keypad.o
 
 # DMA support
 
diff --git a/arch/arm/plat-samsung/dev-keypad.c b/arch/arm/plat-samsung/dev-keypad.c
new file mode 100644
index 0000000..679b444
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-keypad.c
@@ -0,0 +1,58 @@
+/*
+ * linux/arch/arm/plat-samsung/dev-keypad.c
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <mach/irqs.h>
+#include <mach/map.h>
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/keypad.h>
+
+static struct resource samsung_keypad_resources[] = {
+	[0] = {
+		.start	= SAMSUNG_PA_KEYPAD,
+		.end	= SAMSUNG_PA_KEYPAD + 0x20 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_KEYPAD,
+		.end	= IRQ_KEYPAD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device samsung_device_keypad = {
+	.name		= "samsung-keypad",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(samsung_keypad_resources),
+	.resource	= samsung_keypad_resources,
+};
+
+void __init samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd)
+{
+	struct samsung_keypad_platdata *npd;
+
+	if (!pd) {
+		printk(KERN_ERR "%s: no platform data\n", __func__);
+		return;
+	}
+
+	npd = kmemdup(pd, sizeof(struct samsung_keypad_platdata), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+
+	if (!npd->cfg_gpio)
+		npd->cfg_gpio = samsung_keypad_cfg_gpio;
+
+	samsung_device_keypad.dev.platform_data = npd;
+}
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index e6144e4..6d9f01b 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -100,6 +100,8 @@ extern struct platform_device s5pc100_device_iis0;
 extern struct platform_device s5pc100_device_iis1;
 extern struct platform_device s5pc100_device_iis2;
 
+extern struct platform_device samsung_device_keypad;
+
 /* s3c2440 specific devices */
 
 #ifdef CONFIG_CPU_S3C2440
diff --git a/arch/arm/plat-samsung/include/plat/keypad.h b/arch/arm/plat-samsung/include/plat/keypad.h
new file mode 100644
index 0000000..f87646b
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/keypad.h
@@ -0,0 +1,59 @@
+/*
+ * linux/arch/arm/plat-samsung/include/plat/keypad.h
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ * Samsung Platform - Keypad platform data definitions
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __PLAT_SAMSUNG_KEYPAD_H
+#define __PLAT_SAMSUNG_KEYPAD_H
+
+#include <linux/input/matrix_keypad.h>
+
+#define SAMSUNG_MAX_ROWS	8
+#define SAMSUNG_MAX_COLS	8
+
+/**
+ * struct samsung_keypad_platdata - Platform device data for Samsung Keypad.
+ * @keymap_data: pointer to &matrix_keymap_data.
+ * @rows: number of keypad row supported.
+ * @cols: number of keypad col supported.
+ * @no_autorepeat: disable key autorepeat.
+ * @wakeup: controls whether the device should be set up as wakeup source.
+ * @cfg_gpio: configure the GPIO.
+ *
+ * Initialisation data specific to either the machine or the platform
+ * for the device driver to use or call-back when configuring gpio.
+ */
+struct samsung_keypad_platdata {
+	const struct matrix_keymap_data	*keymap_data;
+	unsigned int rows;
+	unsigned int cols;
+	bool no_autorepeat;
+	bool wakeup;
+
+	void (*cfg_gpio)(unsigned int rows, unsigned int cols);
+};
+
+/**
+ * samsung_keypad_set_platdata - Set platform data for Samsung Keypad device.
+ * @pd: Platform data to register to device.
+ *
+ * Register the given platform data for use with Samsung Keypad device.
+ * The call will copy the platform data, so the board definitions can
+ * make the structure itself __initdata.
+ */
+extern void samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd);
+
+/* defined by architecture to configure gpio. */
+extern void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols);
+
+#endif /* __PLAT_SAMSUNG_KEYPAD_H */
-- 
1.7.0.4

