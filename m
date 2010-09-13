From: Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH 6/7] davinci: add tnetv107x touchscreen platform device
Date: Mon, 13 Sep 2010 12:29:47 -0400
Message-ID: <1284395388-32687-7-git-send-email-cyril@ti.com>
References: <1284395388-32687-1-git-send-email-cyril@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60488 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab0IMQ3y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 12:29:54 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8DGTrx2027556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Mon, 13 Sep 2010 11:29:53 -0500
In-Reply-To: <1284395388-32687-1-git-send-email-cyril@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Cyril Chemparathy <cyril@ti.com>

This patch adds a platform device definition for tnetv107x's touchscreen
controller.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/devices-tnetv107x.c      |   24 ++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/tnetv107x.h |   13 +++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index 086269f..018ca13 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -31,6 +31,7 @@
 #define TNETV107X_TPTC0_BASE			0x01c10000
 #define TNETV107X_TPTC1_BASE			0x01c10400
 #define TNETV107X_WDOG_BASE			0x08086700
+#define TNETV107X_TSC_BASE			0x08088500
 #define TNETV107X_SDIO0_BASE			0x08088700
 #define TNETV107X_SDIO1_BASE			0x08088800
 #define TNETV107X_KEYPAD_BASE			0x08088a00
@@ -323,6 +324,24 @@ static struct platform_device keypad_device = {
 	.resource	= keypad_resources,
 };
 
+static struct resource tsc_resources[] = {
+	{
+		.start	= TNETV107X_TSC_BASE,
+		.end	= TNETV107X_TSC_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_TNETV107X_TSC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tsc_device = {
+	.name		= "tnetv107x-ts",
+	.num_resources	= ARRAY_SIZE(tsc_resources),
+	.resource	= tsc_resources,
+};
+
 void __init tnetv107x_devices_init(struct tnetv107x_device_info *info)
 {
 	int i;
@@ -347,4 +366,9 @@ void __init tnetv107x_devices_init(struct tnetv107x_device_info *info)
 		keypad_device.dev.platform_data = info->keypad_config;
 		platform_device_register(&keypad_device);
 	}
+
+	if (info->tsc_config) {
+		tsc_device.dev.platform_data = info->tsc_config;
+		platform_device_register(&tsc_device);
+	}
 }
diff --git a/arch/arm/mach-davinci/include/mach/tnetv107x.h b/arch/arm/mach-davinci/include/mach/tnetv107x.h
index 9f5350f..7e33148 100644
--- a/arch/arm/mach-davinci/include/mach/tnetv107x.h
+++ b/arch/arm/mach-davinci/include/mach/tnetv107x.h
@@ -47,11 +47,24 @@ struct tnetv107x_keypad_data {
 	u32		stable;
 };
 
+struct tnetv107x_tsc_data {
+	int		xres, yres;
+
+	/*
+	 * Calibration info:
+	 *   out_x = (C0 * in_x + C1 * in_y + C2) / C6
+	 *   out_y = (C3 * in_x + C4 * in_y + C5) / C6
+	 */
+#define TSC_CAL_SIZE	7
+	int		calibration_data[TSC_CAL_SIZE];
+};
+
 struct tnetv107x_device_info {
 	struct davinci_uart_config	*serial_config;
 	struct davinci_mmc_config	*mmc_config[2];  /* 2 controllers */
 	struct davinci_nand_pdata	*nand_config[4]; /* 4 chipsels */
 	struct tnetv107x_keypad_data	*keypad_config;
+	struct tnetv107x_tsc_data	*tsc_config;
 };
 
 extern struct platform_device tnetv107x_wdt_device;
-- 
1.7.0.4

