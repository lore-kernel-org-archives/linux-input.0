From: Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH v4 5/5] davinci: add tnetv107x touchscreen platform device
Date: Mon, 20 Sep 2010 12:26:44 -0400
Message-ID: <1285000004-9464-6-git-send-email-cyril@ti.com>
References: <1285000004-9464-1-git-send-email-cyril@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51165 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756843Ab0ITQ0v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 12:26:51 -0400
In-Reply-To: <1285000004-9464-1-git-send-email-cyril@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: shubhrajyoti@ti.com, dmitry.torokhov@gmail.com, khilman@deeprootsystems.com, Cyril Chemparathy <cyril@ti.com>

This patch adds a platform device definition for tnetv107x's touchscreen
controller.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/devices-tnetv107x.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index 086269f..c9a86d8 100644
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
@@ -323,12 +324,31 @@ static struct platform_device keypad_device = {
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
 
 	platform_device_register(&edma_device);
 	platform_device_register(&tnetv107x_wdt_device);
+	platform_device_register(&tsc_device);
 
 	if (info->serial_config)
 		davinci_serial_init(info->serial_config);
-- 
1.7.0.4

