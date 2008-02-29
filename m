From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/03] sh: SuperH KEYSC keypad data for Solution Engine 7722
Date: Fri, 29 Feb 2008 19:49:16 +0900
Message-ID: <20080229104916.22537.64480.sendpatchset@clockwork.opensource.se>
References: <20080229104847.22537.66432.sendpatchset@clockwork.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:21381 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbYB2KvW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Feb 2008 05:51:22 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3884095wff.4
        for <linux-input@vger.kernel.org>; Fri, 29 Feb 2008 02:51:22 -0800 (PST)
In-Reply-To: <20080229104847.22537.66432.sendpatchset@clockwork.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, akpm@linux-foundation.org, linux-sh@vger.kernel.org

This patch adds KEYSC platform data for the Solution Engine 7722 board.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/se/7722/setup.c |   41 ++++++++++++++++++++++++++++++++++++++++
 include/asm-sh/se7722.h        |    2 +
 2 files changed, 43 insertions(+)

--- 0001/arch/sh/boards/se/7722/setup.c
+++ work/arch/sh/boards/se/7722/setup.c	2008-02-28 18:05:09.000000000 +0900
@@ -13,10 +13,12 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
+#include <linux/input.h>
 #include <asm/machvec.h>
 #include <asm/se7722.h>
 #include <asm/io.h>
 #include <asm/heartbeat.h>
+#include <asm/sh_keysc.h>
 
 /* Heartbeat */
 static struct heartbeat_data heartbeat_data = {
@@ -92,10 +94,47 @@ static struct platform_device cf_ide_dev
 	.resource       = cf_ide_resources,
 };
 
+static struct sh_keysc_info sh_keysc_info = {
+	.mode = SH_KEYSC_MODE_1, /* KEYOUT0->5, KEYIN0->4 */
+	.scan_timing = 3,
+	.delay = 5,
+	.keycodes = { /* SW1 -> SW30 */
+		KEY_A, KEY_B, KEY_C, KEY_D, KEY_E,
+		KEY_F, KEY_G, KEY_H, KEY_I, KEY_J,
+		KEY_K, KEY_L, KEY_M, KEY_N, KEY_O,
+		KEY_P, KEY_Q, KEY_R, KEY_S, KEY_T,
+		KEY_U, KEY_V, KEY_W, KEY_X, KEY_Y,
+		KEY_Z,
+		KEY_HOME, KEY_SLEEP, KEY_WAKEUP, KEY_COFFEE, /* life */
+	},
+};
+
+static struct resource sh_keysc_resources[] = {
+	[0] = {
+		.start  = 0x044b0000,
+		.end    = 0x044b000f,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 79,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sh_keysc_device = {
+	.name           = "sh_keysc",
+	.num_resources  = ARRAY_SIZE(sh_keysc_resources),
+	.resource       = sh_keysc_resources,
+	.dev	= {
+		.platform_data	= &sh_keysc_info,
+	},
+};
+
 static struct platform_device *se7722_devices[] __initdata = {
 	&heartbeat_device,
 	&smc91x_eth_device,
 	&cf_ide_device,
+	&sh_keysc_device,
 };
 
 static int __init se7722_devices_setup(void)
@@ -136,6 +175,8 @@ static void __init se7722_setup(char **c
 	ctrl_outw(0x0A10, PORT_PSELA); /* BS,SHHID2 */
 	ctrl_outw(0x0000, PORT_PYCR);
 	ctrl_outw(0x0000, PORT_PZCR);
+	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x4000, PORT_HIZCRA);
+	ctrl_outw(ctrl_inw(PORT_HIZCRC) & ~0xc000, PORT_HIZCRC);
 }
 
 /*
--- 0001/include/asm-sh/se7722.h
+++ work/include/asm-sh/se7722.h	2008-02-28 18:05:09.000000000 +0900
@@ -77,6 +77,8 @@
 #define PORT_PSELA      0xA405014EUL
 #define PORT_PYCR       0xA405014AUL
 #define PORT_PZCR       0xA405014CUL
+#define PORT_HIZCRA     0xA4050158UL
+#define PORT_HIZCRC     0xA405015CUL
 
 /* IRQ */
 #define IRQ0_IRQ        32
