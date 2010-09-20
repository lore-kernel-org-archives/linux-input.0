From: Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH v3 2/5] davinci: add tnetv107x keypad platform device
Date: Mon, 20 Sep 2010 11:07:29 -0400
Message-ID: <1284995252-23337-3-git-send-email-cyril@ti.com>
References: <1284995252-23337-1-git-send-email-cyril@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44992 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654Ab0ITPHm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 11:07:42 -0400
In-Reply-To: <1284995252-23337-1-git-send-email-cyril@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: shubhrajyoti@ti.com, dmitry.torokhov@gmail.com, khilman@deeprootsystems.com, Cyril Chemparathy <cyril@ti.com>

This patch adds a platform device definition for tnetv107x's keypad
controller.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/devices-tnetv107x.c      |   30 ++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    3 ++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index 2718a3a..086269f 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -33,6 +33,7 @@
 #define TNETV107X_WDOG_BASE			0x08086700
 #define TNETV107X_SDIO0_BASE			0x08088700
 #define TNETV107X_SDIO1_BASE			0x08088800
+#define TNETV107X_KEYPAD_BASE			0x08088a00
 #define TNETV107X_ASYNC_EMIF_CNTRL_BASE		0x08200000
 #define TNETV107X_ASYNC_EMIF_DATA_CE0_BASE	0x30000000
 #define TNETV107X_ASYNC_EMIF_DATA_CE1_BASE	0x40000000
@@ -298,6 +299,30 @@ static int __init nand_init(int chipsel, struct davinci_nand_pdata *data)
 	return platform_device_register(pdev);
 }
 
+static struct resource keypad_resources[] = {
+	{
+		.start	= TNETV107X_KEYPAD_BASE,
+		.end	= TNETV107X_KEYPAD_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_TNETV107X_KEYPAD,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "press",
+	},
+	{
+		.start	= IRQ_TNETV107X_KEYPAD_FREE,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "release",
+	},
+};
+
+static struct platform_device keypad_device = {
+	.name		= "tnetv107x-keypad",
+	.num_resources	= ARRAY_SIZE(keypad_resources),
+	.resource	= keypad_resources,
+};
+
 void __init tnetv107x_devices_init(struct tnetv107x_device_info *info)
 {
 	int i;
@@ -317,4 +342,9 @@ void __init tnetv107x_devices_init(struct tnetv107x_device_info *info)
 	for (i = 0; i < 4; i++)
 		if (info->nand_config[i])
 			nand_init(i, info->nand_config[i]);
+
+	if (info->keypad_config) {
+		keypad_device.dev.platform_data = info->keypad_config;
+		platform_device_register(&keypad_device);
+	}
 }
diff --git a/arch/arm/mach-davinci/include/mach/tnetv107x.h b/arch/arm/mach-davinci/include/mach/tnetv107x.h
index c720647..5a681d8 100644
--- a/arch/arm/mach-davinci/include/mach/tnetv107x.h
+++ b/arch/arm/mach-davinci/include/mach/tnetv107x.h
@@ -33,6 +33,8 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/serial_8250.h>
+#include <linux/input/matrix_keypad.h>
+
 #include <mach/mmc.h>
 #include <mach/nand.h>
 #include <mach/serial.h>
@@ -41,6 +43,7 @@ struct tnetv107x_device_info {
 	struct davinci_uart_config	*serial_config;
 	struct davinci_mmc_config	*mmc_config[2];  /* 2 controllers */
 	struct davinci_nand_pdata	*nand_config[4]; /* 4 chipsels */
+	struct matrix_keypad_platform_data *keypad_config;
 };
 
 extern struct platform_device tnetv107x_wdt_device;
-- 
1.7.0.4

