From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/03] sh: SuperH KEYSC keypad data for MigoR
Date: Fri, 29 Feb 2008 19:49:06 +0900
Message-ID: <20080229104906.22537.73906.sendpatchset@clockwork.opensource.se>
References: <20080229104847.22537.66432.sendpatchset@clockwork.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:21588 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555AbYB2KvM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Feb 2008 05:51:12 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3884096wff.4
        for <linux-input@vger.kernel.org>; Fri, 29 Feb 2008 02:51:12 -0800 (PST)
In-Reply-To: <20080229104847.22537.66432.sendpatchset@clockwork.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, akpm@linux-foundation.org, linux-sh@vger.kernel.org

This patch adds KEYSC platform data for the sh7722 MigoR board.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c |   56 +++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-02-28 18:02:14.000000000 +0900
@@ -10,8 +10,10 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/input.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
+#include <asm/sh_keysc.h>
 
 /* Address     IRQ  Size  Bus  Description
  * 0x00000000       64MB  16   NOR Flash (SP29PL256N)
@@ -40,8 +42,43 @@ static struct platform_device smc91x_eth
 	.resource       = smc91x_eth_resources,
 };
 
+static struct sh_keysc_info sh_keysc_info = {
+	.mode = SH_KEYSC_MODE_2, /* KEYOUT0->4, KEYIN1->5 */
+	.scan_timing = 3,
+	.delay = 5,
+	.keycodes = {
+		0, KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_ENTER,
+		0, KEY_F, KEY_C, KEY_D,	KEY_H, KEY_1,
+		0, KEY_2, KEY_3, KEY_4,	KEY_5, KEY_6,
+		0, KEY_7, KEY_8, KEY_9, KEY_S, KEY_0,
+		0, KEY_P, KEY_STOP, KEY_REWIND, KEY_PLAY, KEY_FASTFORWARD,
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
 static struct platform_device *migor_devices[] __initdata = {
 	&smc91x_eth_device,
+	&sh_keysc_device,
 };
 
 static int __init migor_devices_setup(void)
@@ -50,9 +87,26 @@ static int __init migor_devices_setup(vo
 }
 __initcall(migor_devices_setup);
 
+#define PORT_PJCR       0xA4050110UL
+#define PORT_PSELA      0xA405014EUL
+#define PORT_PYCR       0xA405014AUL
+#define PORT_PZCR       0xA405014CUL
+#define PORT_HIZCRA     0xA4050158UL
+#define PORT_HIZCRC     0xA405015CUL
+#define MSTPCR2         0xA4150038UL
+
 static void __init migor_setup(char **cmdline_p)
 {
-	ctrl_outw(0x1000, 0xa4050110); /* Enable IRQ0 in PJCR */
+	/* SMC91C111 - Enable IRQ0 */
+	ctrl_outw(ctrl_inw(PORT_PJCR) & ~0x0003, PORT_PJCR);
+
+	/* KEYSC */
+	ctrl_outw(ctrl_inw(PORT_PYCR) & ~0x0fff, PORT_PYCR);
+	ctrl_outw(ctrl_inw(PORT_PZCR) & ~0x0ff0, PORT_PZCR);
+	ctrl_outw(ctrl_inw(PORT_PSELA) & ~0x4100, PORT_PSELA);
+	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x4000, PORT_HIZCRA);
+	ctrl_outw(ctrl_inw(PORT_HIZCRC) & ~0xc000, PORT_HIZCRC);
+	ctrl_outl(ctrl_inl(MSTPCR2) & ~0x00004000, MSTPCR2);
 }
 
 static struct sh_machine_vector mv_migor __initmv = {
