From: miguel.aguilar@ridgerun.com
Subject: [PATCH 2/2] Davinci: DM365: Enable DaVinci Keypad support for DM365 EVM
Date: Tue, 22 Sep 2009 15:27:50 -0600
Message-ID: <1253654870-17986-1-git-send-email-miguel.aguilar@ridgerun.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:33315 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbZIVV1v (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 17:27:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org
Cc: todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

The general structures are defined at DM365 SoC file and the specific
platform data structure for the EVM is defined at board file.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c    |   54 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/dm365.c              |   30 +++++++++++++++
 arch/arm/mach-davinci/include/mach/dm365.h |    5 +++
 3 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 77f815c..611b5f3 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -38,6 +38,7 @@
 #include <mach/common.h>
 #include <mach/mmc.h>
 #include <mach/nand.h>
+#include <mach/keypad.h>
 
 
 static inline int have_imager(void)
@@ -197,6 +198,55 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_delay	= 0	/* usec */,
 };
 
+/* Masks for the various keys on the DM365 EVM */
+#define KEY_DM365_KEY2		0
+#define KEY_DM365_LEFT		1
+#define KEY_DM365_EXIT		2
+#define KEY_DM365_DOWN		3
+#define KEY_DM365_ENTER		4
+#define KEY_DM365_UP		5
+#define KEY_DM365_KEY1		6
+#define KEY_DM365_RIGHT		7
+#define KEY_DM365_MENU		8
+#define KEY_DM365_REC		9
+#define KEY_DM365_REW		10
+#define KEY_DM365_SKIPMINUS	11
+#define KEY_DM365_STOP		12
+#define KEY_DM365_FF		13
+#define KEY_DM365_SKIPPLUL	14
+#define KEY_DM365_PLAYPAUSE	15
+
+#ifdef CONFIG_KEYBOARD_DAVINCI
+static int dm365evm_keymap[] = {
+	KEY_DM365_KEY2,
+	KEY_DM365_LEFT,
+	KEY_DM365_EXIT,
+	KEY_DM365_DOWN,
+	KEY_DM365_ENTER,
+	KEY_DM365_UP,
+	KEY_DM365_KEY1,
+	KEY_DM365_RIGHT,
+	KEY_DM365_MENU,
+	KEY_DM365_REC,
+	KEY_DM365_REW,
+	KEY_DM365_SKIPMINUS,
+	KEY_DM365_STOP,
+	KEY_DM365_FF,
+	KEY_DM365_SKIPPLUL,
+	KEY_DM365_PLAYPAUSE,
+	0
+};
+
+static struct davinci_kp_platform_data dm365evm_kp_data = {
+	.keymap		= dm365evm_keymap,
+	.keymapsize	= ARRAY_SIZE(dm365evm_keymap),
+	.rep		= 1,
+	/* Scan period = strobe + interval */
+	.strobe		= 0x5,
+	.interval	= 0x2,
+};
+#endif
+
 static int cpld_mmc_get_cd(int module)
 {
 	if (!cpld)
@@ -483,6 +533,10 @@ static __init void dm365_evm_init(void)
 	evm_init_cpld();
 
 	dm365_init_asp(&dm365_evm_snd_data);
+
+#ifdef CONFIG_KEYBOARD_DAVINCI
+	dm365_init_kp(&dm365evm_kp_data);
+#endif
 }
 
 static __init void dm365_evm_irq_init(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2674438..4372532 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -33,6 +33,7 @@
 #include <mach/serial.h>
 #include <mach/common.h>
 #include <mach/asp.h>
+#include <mach/keypad.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -851,6 +852,28 @@ static struct map_desc dm365_io_desc[] = {
 	},
 };
 
+static struct resource dm365_kp_resources[] = {
+	{
+		/* registers */
+		.start = DM365_KEYSCAN_BASE,
+		.end = DM365_KEYSCAN_BASE + SZ_1K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		/* interrupt */
+		.start = IRQ_DM365_KEYINT,
+		.end = IRQ_DM365_KEYINT,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dm365_kp_device = {
+	.name		= "davinci_keypad",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(dm365_kp_resources),
+	.resource	= dm365_kp_resources,
+};
+
 /* Contents of JTAG ID register used to identify exact cpu type */
 static struct davinci_id dm365_ids[] = {
 	{
@@ -950,6 +973,13 @@ void __init dm365_init_asp(struct snd_platform_data *pdata)
 	platform_device_register(&dm365_asp_device);
 }
 
+void __init dm365_init_kp(struct davinci_kp_platform_data *pdata)
+{
+	davinci_cfg_reg(DM365_KEYPAD);
+	dm365_kp_device.dev.platform_data = pdata;
+	platform_device_register(&dm365_kp_device);
+}
+
 void __init dm365_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
index 2291c0d..fa8f182 100644
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ b/arch/arm/mach-davinci/include/mach/dm365.h
@@ -17,6 +17,7 @@
 #include <mach/hardware.h>
 #include <mach/emac.h>
 #include <mach/asp.h>
+#include <mach/keypad.h>
 
 #define DM365_EMAC_BASE			(0x01D07000)
 #define DM365_EMAC_CNTRL_OFFSET		(0x0000)
@@ -25,7 +26,11 @@
 #define DM365_EMAC_MDIO_OFFSET		(0x4000)
 #define DM365_EMAC_CNTRL_RAM_SIZE	(0x2000)
 
+/* Base of keypad register bank */
+#define DM365_KEYSCAN_BASE		(0x01C69400)
+
 void __init dm365_init(void);
 void __init dm365_init_asp(struct snd_platform_data *pdata);
+void __init dm365_init_kp(struct davinci_kp_platform_data *pdata);
 
 #endif /* __ASM_ARCH_DM365_H */
-- 
1.6.0.4

