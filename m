From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 9/12] pxa: add pxa27x_keypad device and pxa_set_keypad_info()
Date: Wed, 23 Jan 2008 15:30:13 +0800
Message-ID: <f17812d70801222330r45678a8al6ef9383ffd3bad3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:64821 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbYAWHaQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:30:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4886613wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:30:13 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>From 378f65ece25aae2252616d3e1cc7c0ca874ac4c2 Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Wed, 23 Jan 2008 13:39:13 +0800
Subject: [PATCH] pxa: add pxa27x_keypad device and pxa_set_keypad_info()

also update the clk definitions in pxa27x and pxa3xx.

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/devices.c              |   25 +++++++++++++++++++++++++
 arch/arm/mach-pxa/devices.h              |    1 +
 arch/arm/mach-pxa/pxa27x.c               |    2 +-
 arch/arm/mach-pxa/pxa3xx.c               |    1 +
 include/asm-arm/arch-pxa/pxa27x_keypad.h |    2 ++
 5 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 50ff453..127817a 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -395,6 +395,31 @@ struct platform_device pxa25x_device_assp = {

 #if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)

+static struct resource pxa27x_resource_keypad[] = {
+	[0] = {
+		.start	= 0x41500000,
+		.end	= 0x4150004c,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_KEYPAD,
+		.end	= IRQ_KEYPAD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa27x_device_keypad = {
+	.name		= "pxa27x-keypad",
+	.id		= -1,
+	.resource	= pxa27x_resource_keypad,
+	.num_resources	= ARRAY_SIZE(pxa27x_resource_keypad),
+};
+
+void __init pxa_set_keypad_info(struct pxa27x_keypad_platform_data *info)
+{
+	pxa_register_device(&pxa27x_device_keypad, info);
+}
+
 static u64 pxa27x_ohci_dma_mask = DMA_BIT_MASK(32);

 static struct resource pxa27x_resource_ohci[] = {
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 96c7c89..fcab017 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -14,6 +14,7 @@ extern struct platform_device pxa_device_rtc;

 extern struct platform_device pxa27x_device_i2c_power;
 extern struct platform_device pxa27x_device_ohci;
+extern struct platform_device pxa27x_device_keypad;

 extern struct platform_device pxa25x_device_ssp;
 extern struct platform_device pxa25x_device_nssp;
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index f33c9d7..a98eea9 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -149,7 +149,7 @@ static struct clk pxa27x_clks[] = {

 	INIT_CKEN("USBCLK", USBHOST, 48000000, 0, &pxa27x_device_ohci.dev),
 	INIT_CKEN("I2CCLK", PWRI2C, 13000000, 0, &pxa27x_device_i2c_power.dev),
-	INIT_CKEN("KBDCLK", KEYPAD, 32768, 0, NULL),
+	INIT_CKEN("KBDCLK", KEYPAD, 32768, 0, &pxa27x_device_keypad.dev),

 	INIT_CKEN("SSPCLK", SSP1, 13000000, 0, &pxa27x_device_ssp1.dev),
 	INIT_CKEN("SSPCLK", SSP2, 13000000, 0, &pxa27x_device_ssp2.dev),
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 0b2a15e..a3061c9 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -191,6 +191,7 @@ static struct clk pxa3xx_clks[] = {
 	PXA3xx_CKEN("I2CCLK", I2C,  32842000, 0, &pxa_device_i2c.dev),
 	PXA3xx_CKEN("UDCCLK", UDC,  48000000, 5, &pxa_device_udc.dev),
 	PXA3xx_CKEN("USBCLK", USBH, 48000000, 0, &pxa27x_device_ohci.dev),
+	PXA3xx_CKEN("KBDCLK", KEYPAD,  32768, 0, &pxa27x_device_keypad.dev),

 	PXA3xx_CKEN("SSPCLK", SSP1, 13000000, 0, &pxa27x_device_ssp1.dev),
 	PXA3xx_CKEN("SSPCLK", SSP2, 13000000, 0, &pxa27x_device_ssp2.dev),
diff --git a/include/asm-arm/arch-pxa/pxa27x_keypad.h
b/include/asm-arm/arch-pxa/pxa27x_keypad.h
index 644f760..d5a48a9 100644
--- a/include/asm-arm/arch-pxa/pxa27x_keypad.h
+++ b/include/asm-arm/arch-pxa/pxa27x_keypad.h
@@ -53,4 +53,6 @@ struct pxa27x_keypad_platform_data {

 #define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))

+extern void pxa_set_keypad_info(struct pxa27x_keypad_platform_data *info);
+
 #endif /* __ASM_ARCH_PXA27x_KEYPAD_H */
-- 
1.5.2.5.GIT



-- 
Cheers
- eric
