From: miguel.aguilar@ridgerun.com
Subject: [PATCH 2/2] DaVinci: DM365: Add the device_enable for the DaVinci Keyscan
Date: Fri, 13 Nov 2009 11:19:46 -0600
Message-ID: <1258132786-23321-1-git-send-email-miguel.aguilar@ridgerun.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:39392 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755887AbZKMRTm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2009 12:19:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org
Cc: todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

Adds the device_enable function to the DaVinci Keyscan platform data
to setup the PINMUX configuration.

It also removes #ifdef from the DM365 EVM board in order to load it
properly as a module.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c |   11 ++++++-----
 arch/arm/mach-davinci/dm365.c           |    1 -
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 8d23972..5abf89d 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -195,7 +195,11 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_delay	= 0	/* usec */,
 };
 
-#ifdef CONFIG_KEYBOARD_DAVINCI
+void dm365evm_keyscan_enable(struct device *dev)
+{
+	davinci_cfg_reg(DM365_KEYSCAN);
+}
+
 static unsigned short dm365evm_keymap[] = {
 	KEY_KP2,
 	KEY_LEFT,
@@ -217,6 +221,7 @@ static unsigned short dm365evm_keymap[] = {
 };
 
 static struct davinci_ks_platform_data dm365evm_ks_data = {
+	.device_enable	= dm365evm_keyscan_enable,
 	.keymap		= dm365evm_keymap,
 	.keymapsize	= ARRAY_SIZE(dm365evm_keymap),
 	.rep		= 1,
@@ -225,7 +230,6 @@ static struct davinci_ks_platform_data dm365evm_ks_data = {
 	.interval	= 0x2,
 	.matrix_type	= DAVINCI_KEYSCAN_MATRIX_4X4,
 };
-#endif
 
 static int cpld_mmc_get_cd(int module)
 {
@@ -514,10 +518,7 @@ static __init void dm365_evm_init(void)
 
 	dm365_init_asp(&dm365_evm_snd_data);
 	dm365_init_rtc();
-
-#ifdef CONFIG_KEYBOARD_DAVINCI
 	dm365_init_ks(&dm365evm_ks_data);
-#endif
 }
 
 static __init void dm365_evm_irq_init(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2ec619e..f53735c 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -993,7 +993,6 @@ void __init dm365_init_asp(struct snd_platform_data *pdata)
 
 void __init dm365_init_ks(struct davinci_ks_platform_data *pdata)
 {
-	davinci_cfg_reg(DM365_KEYSCAN);
 	dm365_ks_device.dev.platform_data = pdata;
 	platform_device_register(&dm365_ks_device);
 }
-- 
1.6.0.4

