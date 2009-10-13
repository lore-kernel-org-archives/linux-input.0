From: <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
Subject: [PATCH v6 2/2] Davinci: DM365: Enable DaVinci Key Scan support for
	DM365 EVM
Date: Tue, 13 Oct 2009 13:57:07 -0600
Message-ID: <1255463827-31580-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, nsnehaprabha-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>

The general structures are defined at DM365 SoC file and the specific
platform data structure for the EVM is defined at board file.

Signed-off-by: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
---
 arch/arm/mach-davinci/board-dm365-evm.c    |   38 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/dm365.c              |   32 ++++++++++++++++++++++-
 arch/arm/mach-davinci/include/mach/dm365.h |    5 +++
 arch/arm/mach-davinci/include/mach/mux.h   |    4 +-
 4 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 13b85ec..45638c7 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
+#include <linux/input.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -38,6 +39,7 @@
 #include <mach/common.h>
 #include <mach/mmc.h>
 #include <mach/nand.h>
+#include <mach/keyscan.h>
 
 
 static inline int have_imager(void)
@@ -198,6 +200,38 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_delay	= 0	/* usec */,
 };
 
+#ifdef CONFIG_KEYBOARD_DAVINCI
+static unsigned short dm365evm_keymap[] = {
+	KEY_KP2,
+	KEY_LEFT,
+	KEY_EXIT,
+	KEY_DOWN,
+	KEY_ENTER,
+	KEY_UP,
+	KEY_KP1,
+	KEY_RIGHT,
+	KEY_MENU,
+	KEY_RECORD,
+	KEY_REWIND,
+	KEY_KPMINUS,
+	KEY_STOP,
+	KEY_FASTFORWARD,
+	KEY_KPPLUS,
+	KEY_PLAYPAUSE,
+	0
+};
+
+static struct davinci_ks_platform_data dm365evm_ks_data = {
+	.keymap		= dm365evm_keymap,
+	.keymapsize	= ARRAY_SIZE(dm365evm_keymap),
+	.rep		= 1,
+	/* Scan period = strobe + interval */
+	.strobe		= 0x5,
+	.interval	= 0x2,
+	.matrix_type	= DAVINCI_KEYSCAN_MATRIX_4X4,
+};
+#endif
+
 static int cpld_mmc_get_cd(int module)
 {
 	if (!cpld)
@@ -484,6 +518,10 @@ static __init void dm365_evm_init(void)
 	evm_init_cpld();
 
 	dm365_init_asp(&dm365_evm_snd_data);
+
+#ifdef CONFIG_KEYBOARD_DAVINCI
+	dm365_init_ks(&dm365evm_ks_data);
+#endif
 }
 
 static __init void dm365_evm_irq_init(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2674438..3eda695 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -33,6 +33,7 @@
 #include <mach/serial.h>
 #include <mach/common.h>
 #include <mach/asp.h>
+#include <mach/keyscan.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -532,7 +533,7 @@ MUX_CFG(DM365,  EMAC_CRS,	3,   2,     1,    1,     false)
 MUX_CFG(DM365,  EMAC_MDIO,	3,   1,     1,    1,     false)
 MUX_CFG(DM365,  EMAC_MDCLK,	3,   0,     1,    1,     false)
 
-MUX_CFG(DM365,	KEYPAD,		2,   0,     0x3f, 0x3f,  false)
+MUX_CFG(DM365,	KEYSCAN,	2,   0,     0x3f, 0x3f,  false)
 
 MUX_CFG(DM365,	PWM0,		1,   0,     3,    2,     false)
 MUX_CFG(DM365,	PWM0_G23,	3,   26,    3,    3,     false)
@@ -851,6 +852,28 @@ static struct map_desc dm365_io_desc[] = {
 	},
 };
 
+static struct resource dm365_ks_resources[] = {
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
+static struct platform_device dm365_ks_device = {
+	.name		= "davinci_keyscan",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(dm365_ks_resources),
+	.resource	= dm365_ks_resources,
+};
+
 /* Contents of JTAG ID register used to identify exact cpu type */
 static struct davinci_id dm365_ids[] = {
 	{
@@ -950,6 +973,13 @@ void __init dm365_init_asp(struct snd_platform_data *pdata)
 	platform_device_register(&dm365_asp_device);
 }
 
+void __init dm365_init_ks(struct davinci_ks_platform_data *pdata)
+{
+	davinci_cfg_reg(DM365_KEYSCAN);
+	dm365_ks_device.dev.platform_data = pdata;
+	platform_device_register(&dm365_ks_device);
+}
+
 void __init dm365_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
index 2291c0d..d8d988a 100644
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ b/arch/arm/mach-davinci/include/mach/dm365.h
@@ -17,6 +17,7 @@
 #include <mach/hardware.h>
 #include <mach/emac.h>
 #include <mach/asp.h>
+#include <mach/keyscan.h>
 
 #define DM365_EMAC_BASE			(0x01D07000)
 #define DM365_EMAC_CNTRL_OFFSET		(0x0000)
@@ -25,7 +26,11 @@
 #define DM365_EMAC_MDIO_OFFSET		(0x4000)
 #define DM365_EMAC_CNTRL_RAM_SIZE	(0x2000)
 
+/* Base of key scan register bank */
+#define DM365_KEYSCAN_BASE		(0x01C69400)
+
 void __init dm365_init(void);
 void __init dm365_init_asp(struct snd_platform_data *pdata);
+void __init dm365_init_ks(struct davinci_ks_platform_data *pdata);
 
 #endif /* __ASM_ARCH_DM365_H */
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index b2c1ad0..0eae777 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -237,8 +237,8 @@ enum davinci_dm365_index {
 	DM365_EMAC_MDIO,
 	DM365_EMAC_MDCLK,
 
-	/* Keypad */
-	DM365_KEYPAD,
+	/* Key Scan */
+	DM365_KEYSCAN,
 
 	/* PWM */
 	DM365_PWM0,
-- 
1.6.0.4
