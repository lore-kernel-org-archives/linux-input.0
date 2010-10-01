From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 28/69] ST SPEAr: Adding machine support for nand
Date: Fri,  1 Oct 2010 17:25:48 +0530
Message-ID: <1076320a0194c19ef0b4beefdf3c43a44e200439.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
In-Reply-To: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
References: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry
Cc: Vipin Kumar <vipin.kumar-qxv4g6HH51o@public.gmane.org>, shiraz.hashim-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Vipin Kumar <vipin.kumar-qxv4g6HH51o@public.gmane.org>

Signed-off-by: Vipin Kumar <vipin.kumar-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/mach-spear13xx/include/mach/generic.h   |    2 +
 arch/arm/mach-spear13xx/include/mach/misc_regs.h |   10 ++
 arch/arm/mach-spear13xx/spear1300_evb.c          |    9 ++
 arch/arm/mach-spear13xx/spear13xx.c              |   58 +++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h    |   15 ++--
 arch/arm/mach-spear3xx/include/mach/spear320.h   |    3 +
 arch/arm/mach-spear3xx/spear300.c                |   98 ++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear300_evb.c            |    8 ++
 arch/arm/mach-spear3xx/spear310.c                |   26 ++++++
 arch/arm/mach-spear3xx/spear310_evb.c            |    8 ++
 arch/arm/mach-spear3xx/spear320.c                |   26 ++++++
 arch/arm/mach-spear3xx/spear320_evb.c            |    8 ++
 arch/arm/mach-spear6xx/include/mach/generic.h    |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c            |    8 ++
 arch/arm/mach-spear6xx/spear6xx.c                |   26 ++++++
 arch/arm/plat-spear/include/plat/fsmc.h          |   36 ++++++++
 16 files changed, 336 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/fsmc.h

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 960ff06..745dd99 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -35,6 +35,7 @@ extern struct platform_device spear13xx_ehci0_device;
 extern struct platform_device spear13xx_ehci1_device;
 extern struct platform_device spear13xx_i2c_device;
 extern struct platform_device spear13xx_kbd_device;
+extern struct platform_device spear13xx_nand_device;
 extern struct platform_device spear13xx_ohci0_device;
 extern struct platform_device spear13xx_ohci1_device;
 extern struct platform_device spear13xx_rtc_device;
@@ -51,6 +52,7 @@ void __init spear1300_init(void);
 void __init spear13xx_map_io(void);
 void __init spear13xx_init_irq(void);
 void __init spear13xx_init(void);
+void __init nand_mach_init(u32 busw);
 void spear13xx_secondary_startup(void);
 
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/misc_regs.h b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
index a8a1119..e6823db 100644
--- a/arch/arm/mach-spear13xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
@@ -210,6 +210,16 @@
 	#define CF_MMC_ACTIVE	0x2
 	#define XD_MMC_ACTIVE	0x3
 #define FSMC_CFG		((unsigned int *)(MISC_BASE + 0x330))
+	/* FSMC_CFG register masks */
+	#define FSMC_MEMSEL_MASK	0x3
+	#define FSMC_MEMSEL_SHIFT	0
+	#define FSMC_MEM_NOR		0
+	#define FSMC_MEM_NAND		1
+	#define FSMC_MEM_SRAM		2
+	#define NAND_BANK_MASK		0x3
+	#define NAND_BANK_SHIFT		2
+	#define NAND_DEV_WIDTH16	4
+
 #define MPMC_CTR_STS		((unsigned int *)(MISC_BASE + 0x334))
 
 /* Inter-Processor Communication Registers */
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 1e637fa..56a4294 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -12,11 +12,14 @@
  */
 
 #include <linux/types.h>
+#include <linux/mtd/nand.h>
+#include <mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
 #include <plat/keyboard.h>
+#include <plat/fsmc.h>
 #include <plat/smi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -30,6 +33,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ehci1_device,
 	&spear13xx_i2c_device,
 	&spear13xx_kbd_device,
+	&spear13xx_nand_device,
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
@@ -52,6 +56,11 @@ static void __init spear1300_evb_init(void)
 	/* set keyboard plat data */
 	kbd_set_plat_data(&spear13xx_kbd_device, &kbd_data);
 
+	/* set nand device's plat data */
+	fsmc_nand_set_plat_data(&spear13xx_nand_device, NULL, 0,
+			NAND_SKIP_BBTSCAN, FSMC_NAND_BW8);
+	nand_mach_init(FSMC_NAND_BW8);
+
 	/* call spear1300 machine init function */
 	spear1300_init();
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index f7d30a9..55d654f 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -15,6 +15,7 @@
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
+#include <mtd/fsmc.h>
 #include <asm/hardware/gic.h>
 #include <asm/irq.h>
 #include <asm/localtimer.h>
@@ -23,6 +24,7 @@
 #include <mach/irqs.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
+#include <mach/misc_regs.h>
 
 /* Add spear13xx machines common devices here */
 /* gpio device registeration */
@@ -97,6 +99,62 @@ struct platform_device spear13xx_i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* nand device registeration */
+void __init nand_mach_init(u32 busw)
+{
+	u32 fsmc_cfg = readl(FSMC_CFG);
+	fsmc_cfg &= ~(FSMC_MEMSEL_MASK << FSMC_MEMSEL_SHIFT);
+	fsmc_cfg |= (FSMC_MEM_NAND << FSMC_MEMSEL_SHIFT);
+
+	if (busw == FSMC_NAND_BW16)
+		fsmc_cfg |= 1 << NAND_DEV_WIDTH16;
+	else
+		fsmc_cfg &= ~(1 << NAND_DEV_WIDTH16);
+
+	writel(fsmc_cfg, FSMC_CFG);
+}
+
+static void nand_select_bank(u32 bank, u32 busw)
+{
+	u32 fsmc_cfg = readl(FSMC_CFG);
+
+	fsmc_cfg &= ~(NAND_BANK_MASK << NAND_BANK_SHIFT);
+	fsmc_cfg |= (bank << NAND_BANK_SHIFT);
+
+	if (busw)
+		fsmc_cfg |= 1 << NAND_DEV_WIDTH16;
+	else
+		fsmc_cfg &= ~(1 << NAND_DEV_WIDTH16);
+
+	writel(fsmc_cfg, FSMC_CFG);
+}
+
+static struct fsmc_nand_platform_data nand_platform_data = {
+	.select_bank = nand_select_bank,
+};
+
+static struct resource nand_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR13XX_FSMC_MEM_BASE,
+		.end = SPEAR13XX_FSMC_MEM_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR13XX_FSMC_BASE,
+		.end = SPEAR13XX_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device spear13xx_nand_device = {
+	.name = "nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+	.dev.platform_data = &nand_platform_data,
+};
+
 /* usb host device registeration */
 static struct resource ehci0_resources[] = {
 	[0] = {
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 91c0c09..6aac229 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -111,6 +111,10 @@ extern struct pmx_driver pmx_driver;
 extern struct amba_device clcd_device;
 extern struct amba_device gpio1_device;
 extern struct platform_device kbd_device;
+extern struct platform_device nand0_device;
+extern struct platform_device nand1_device;
+extern struct platform_device nand2_device;
+extern struct platform_device nand3_device;
 
 /* pad mux modes */
 extern struct pmx_mode nand_mode;
@@ -148,12 +152,12 @@ void __init spear300_init(void);
 
 /* Add misc structure declarations here */
 extern struct clcd_board clcd_plat_data;
-#endif /* CONFIG_MACH_SPEAR300 */
 
 /* spear310 declarations */
-#ifdef CONFIG_MACH_SPEAR310
+#elif defined(CONFIG_MACH_SPEAR310)
 /* Add spear310 machine device structure declarations here */
 extern struct platform_device plgpio_device;
+extern struct platform_device nand_device;
 
 /* pad mux devices */
 extern struct pmx_dev pmx_emi_cs_0_1_4_5;
@@ -168,13 +172,12 @@ extern struct pmx_dev pmx_tdm0;
 /* Add spear310 machine function declarations here */
 void __init spear310_init(void);
 
-#endif /* CONFIG_MACH_SPEAR310 */
-
 /* spear320 declarations */
-#ifdef CONFIG_MACH_SPEAR320
+#elif defined(CONFIG_MACH_SPEAR320)
 /* Add spear320 machine device structure declarations here */
 extern struct amba_device clcd_device;
 extern struct platform_device i2c1_device;
+extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
 extern struct platform_device pwm_device;
 
@@ -213,6 +216,6 @@ void __init spear320_init(void);
 
 /* Add misc structure declarations here */
 extern struct clcd_board clcd_plat_data;
-#endif /* CONFIG_MACH_SPEAR320 */
+#endif
 
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
index 53677e4..aa6727c 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear320.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
@@ -22,6 +22,9 @@
 #define SPEAR320_FSMC_BASE		0x4C000000
 #define SPEAR320_FSMC_SIZE		0x01000000
 
+#define SPEAR320_NAND_BASE		0x50000000
+#define SPEAR320_NAND_SIZE		0x04000000
+
 #define SPEAR320_I2S_BASE		0x60000000
 #define SPEAR320_I2S_SIZE		0x10000000
 
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index c80d4e1..c213614 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
+#include <mtd/fsmc.h>
 #include <asm/irq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
@@ -426,6 +427,103 @@ struct platform_device kbd_device = {
 	.resource = kbd_resources,
 };
 
+/* nand device registeration */
+static struct fsmc_nand_platform_data nand0_platform_data;
+
+static struct resource nand0_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR300_NAND_0_BASE,
+		.end = SPEAR300_NAND_0_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR300_FSMC_BASE,
+		.end = SPEAR300_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand0_device = {
+	.name = "nand",
+	.id = 0,
+	.resource = nand0_resources,
+	.num_resources = ARRAY_SIZE(nand0_resources),
+	.dev.platform_data = &nand0_platform_data,
+};
+
+static struct fsmc_nand_platform_data nand1_platform_data;
+
+static struct resource nand1_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR300_NAND_1_BASE,
+		.end = SPEAR300_NAND_1_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR300_FSMC_BASE,
+		.end = SPEAR300_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand1_device = {
+	.name = "nand",
+	.id = 1,
+	.resource = nand1_resources,
+	.num_resources = ARRAY_SIZE(nand1_resources),
+	.dev.platform_data = &nand1_platform_data,
+};
+
+static struct fsmc_nand_platform_data nand2_platform_data;
+
+static struct resource nand2_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR300_NAND_2_BASE,
+		.end = SPEAR300_NAND_2_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR300_FSMC_BASE,
+		.end = SPEAR300_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand2_device = {
+	.name = "nand",
+	.id = 2,
+	.resource = nand2_resources,
+	.num_resources = ARRAY_SIZE(nand2_resources),
+	.dev.platform_data = &nand2_platform_data,
+};
+
+static struct fsmc_nand_platform_data nand3_platform_data;
+
+static struct resource nand3_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR300_NAND_3_BASE,
+		.end = SPEAR300_NAND_3_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR300_FSMC_BASE,
+		.end = SPEAR300_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand3_device = {
+	.name = "nand",
+	.id = 3,
+	.resource = nand3_resources,
+	.num_resources = ARRAY_SIZE(nand3_resources),
+	.dev.platform_data = &nand3_platform_data,
+};
+
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 7bd8963..41ad013 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -11,10 +11,13 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
+#include <mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/fsmc.h>
 #include <plat/keyboard.h>
 #include <plat/smi.h>
 
@@ -49,6 +52,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&ehci_device,
 	&i2c_device,
+	&nand0_device,
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
@@ -79,6 +83,10 @@ static void __init spear300_evb_init(void)
 	/* set keyboard plat data */
 	kbd_set_plat_data(&kbd_device, &kbd_data);
 
+	/* set nand0 device's plat data */
+	fsmc_nand_set_plat_data(&nand0_device, NULL, 0, NAND_SKIP_BBTSCAN,
+			FSMC_NAND_BW8);
+
 	/* call spear300 machine init function */
 	spear300_init();
 
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 88b55b5..1c84303 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/ptrace.h>
+#include <mtd/fsmc.h>
 #include <asm/irq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
@@ -177,6 +178,31 @@ int spear300_o2p(int offset)
 		return offset + 2;
 }
 
+/* nand device registeration */
+static struct fsmc_nand_platform_data nand_platform_data;
+
+static struct resource nand_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR310_NAND_BASE,
+		.end = SPEAR310_NAND_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR310_FSMC_BASE,
+		.end = SPEAR310_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand_device = {
+	.name = "nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+	.dev.platform_data = &nand_platform_data,
+};
+
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
 	.irq_base = SPEAR_PLGPIO_INT_BASE,
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index cd076c9..857afae 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -11,10 +11,13 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
+#include <mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/fsmc.h>
 #include <plat/smi.h>
 
 /* padmux devices to enable */
@@ -54,6 +57,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&ehci_device,
 	&i2c_device,
+	&nand_device,
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
@@ -72,6 +76,10 @@ static void __init spear310_evb_init(void)
 	pmx_driver.devs = pmx_devs;
 	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
 
+	/* set nand device's plat data */
+	fsmc_nand_set_plat_data(&nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
+			FSMC_NAND_BW8);
+
 	/* call spear310 machine init function */
 	spear310_init();
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 75e7890..3def755 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/ptrace.h>
+#include <mtd/fsmc.h>
 #include <asm/irq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
@@ -431,6 +432,31 @@ struct platform_device i2c1_device = {
 	.resource = i2c1_resources,
 };
 
+/* nand device registeration */
+static struct fsmc_nand_platform_data nand_platform_data;
+
+static struct resource nand_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR320_NAND_BASE,
+		.end = SPEAR320_NAND_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR320_FSMC_BASE,
+		.end = SPEAR320_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand_device = {
+	.name = "nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+	.dev.platform_data = &nand_platform_data,
+};
+
 static struct resource plgpio_resources[] = {
 	{
 		.start = SPEAR320_SOC_CONFIG_BASE,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 7f7b5dd..3a066bb 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -11,10 +11,13 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
+#include <mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/fsmc.h>
 #include <plat/smi.h>
 
 /* padmux devices to enable */
@@ -52,6 +55,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&ehci_device,
 	&i2c_device,
+	&nand_device,
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
@@ -72,6 +76,10 @@ static void __init spear320_evb_init(void)
 	pmx_driver.devs = pmx_devs;
 	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
 
+	/* set nand device's plat data */
+	fsmc_nand_set_plat_data(&nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
+			FSMC_NAND_BW8);
+
 	/* call spear320 machine init function */
 	spear320_init();
 
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index f885898..ff90419 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -36,6 +36,7 @@ extern struct amba_device wdt_device;
 extern struct platform_device ehci0_device;
 extern struct platform_device ehci1_device;
 extern struct platform_device i2c_device;
+extern struct platform_device nand_device;
 extern struct platform_device ohci0_device;
 extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index 0eb5f50..f3b1fb4 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -11,10 +11,13 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/nand.h>
+#include <mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/fsmc.h>
 #include <plat/smi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -33,6 +36,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&i2c_device,
 	&ohci0_device,
 	&ohci1_device,
+	&nand_device,
 	&rtc_device,
 	&smi_device,
 };
@@ -41,6 +45,10 @@ static void __init spear600_evb_init(void)
 {
 	unsigned int i;
 
+	/* set nand device's plat data */
+	fsmc_nand_set_plat_data(&nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
+			FSMC_NAND_BW8);
+
 	/* call spear600 machine init function */
 	spear600_init();
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 2eec8ac..cc4fd39 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -15,6 +15,7 @@
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
+#include <mtd/fsmc.h>
 #include <asm/hardware/vic.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
@@ -152,6 +153,31 @@ struct platform_device i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* nand device registeration */
+static struct fsmc_nand_platform_data nand_platform_data;
+
+static struct resource nand_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR6XX_ICM1_NAND_BASE,
+		.end = SPEAR6XX_ICM1_NAND_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR6XX_ICM1_FSMC_BASE,
+		.end = SPEAR6XX_ICM1_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand_device = {
+	.name = "nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+	.dev.platform_data = &nand_platform_data,
+};
+
 /* usb host device registeration */
 static struct resource ehci0_resources[] = {
 	[0] = {
diff --git a/arch/arm/plat-spear/include/plat/fsmc.h b/arch/arm/plat-spear/include/plat/fsmc.h
new file mode 100644
index 0000000..bb161fb
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/fsmc.h
@@ -0,0 +1,36 @@
+/*
+ * arch/arm/plat-spear/include/plat/fsmc.h
+ *
+ * FSMC definitions for SPEAr platform
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Vipin Kumar <vipin.kumar-qxv4g6HH51o@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_FSMC_H
+#define __PLAT_FSMC_H
+
+#include <mtd/fsmc.h>
+
+/* This function is used to set platform data field of pdev->dev */
+static inline void fsmc_nand_set_plat_data(struct platform_device *pdev,
+		struct mtd_partition *partitions, unsigned int nr_partitions,
+		unsigned int options, unsigned int width)
+{
+	struct fsmc_nand_platform_data *plat_data;
+	plat_data = dev_get_platdata(&pdev->dev);
+
+	if (partitions) {
+		plat_data->partitions = partitions;
+		plat_data->nr_partitions = nr_partitions;
+	}
+
+	plat_data->options = options;
+	plat_data->width = width;
+}
+
+#endif /* __PLAT_FSMC_H */
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
