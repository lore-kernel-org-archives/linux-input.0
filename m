From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 40/69] ST SPEAr : FSMC (Flexible Static Memory Controller) NOR interface driver
Date: Fri,  1 Oct 2010 17:26:00 +0530
Message-ID: <001f1c5109c19d2ef6517c78daf560cc2f300180.1285933332.git.viresh.kumar@st.com>
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

SPEAr1300 SoC supports FSMC to interface with various memories
(NOR/NAND/SRAM). This patch adds the support for FSMC over NOR interface.

The driver being used is driver/mtd/maps/physmap.c

Signed-off-by: Vipin Kumar <vipin.kumar-qxv4g6HH51o@public.gmane.org>
Signed-off-by: shiraz hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/mach-spear13xx/Makefile               |    2 +-
 arch/arm/mach-spear13xx/fsmc-nor.c             |   85 ++++++++++++++++++++++++
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |   17 +++++
 arch/arm/mach-spear13xx/spear1310_evb.c        |   17 +++++
 arch/arm/mach-spear13xx/spear13xx.c            |   20 ++++++
 arch/arm/plat-spear/include/plat/fsmc.h        |   15 ++++
 include/mtd/fsmc.h                             |    2 +
 8 files changed, 158 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/fsmc-nor.c

diff --git a/arch/arm/mach-spear13xx/Makefile b/arch/arm/mach-spear13xx/Makefile
index 838405a..9312fcd 100644
--- a/arch/arm/mach-spear13xx/Makefile
+++ b/arch/arm/mach-spear13xx/Makefile
@@ -3,7 +3,7 @@
 #
 
 # common files
-obj-y					+= spear13xx.o clock.o
+obj-y					+= spear13xx.o clock.o fsmc-nor.o
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
 obj-$(CONFIG_PCIEPORTBUS)		+= pcie.o
diff --git a/arch/arm/mach-spear13xx/fsmc-nor.c b/arch/arm/mach-spear13xx/fsmc-nor.c
new file mode 100644
index 0000000..03234b6
--- /dev/null
+++ b/arch/arm/mach-spear13xx/fsmc-nor.c
@@ -0,0 +1,85 @@
+/*
+ * arch/arm/mach-spear13xx/fsmc-nor.c
+ *
+ * FSMC (Flexible Static Memory Controller) interface for NOR
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Vipin Kumar<vipin.kumar-qxv4g6HH51o@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <plat/fsmc.h>
+
+int __init fsmc_nor_init(struct platform_device *pdev, unsigned long base,
+		u32 bank, u32 width)
+{
+	void __iomem *fsmc_nor_base;
+	struct fsmc_regs *regs;
+	struct clk *clk;
+	int ret;
+	u32 ctrl;
+
+	if (bank > (FSMC_MAX_NOR_BANKS - 1))
+		return -EINVAL;
+
+	fsmc_nor_base = ioremap(base, FSMC_NOR_REG_SIZE);
+	if (!fsmc_nor_base)
+		return -ENOMEM;
+
+	clk = clk_get(NULL, "fsmc");
+	if (IS_ERR(clk)) {
+		iounmap(fsmc_nor_base);
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_enable(clk);
+	if (ret) {
+		iounmap(fsmc_nor_base);
+		return ret;
+	}
+
+	regs = (struct fsmc_regs *)fsmc_nor_base;
+
+	ctrl = WAIT_ENB | WRT_ENABLE | WPROT | NOR_DEV | BANK_ENABLE;
+
+	switch (width) {
+	case FSMC_FLASH_WIDTH8:
+		ctrl |= WIDTH_8;
+		break;
+
+	case FSMC_FLASH_WIDTH16:
+		ctrl |= WIDTH_16;
+		break;
+
+	case FSMC_FLASH_WIDTH32:
+		ctrl |= WIDTH_32;
+		break;
+
+	default:
+		ctrl |= WIDTH_8;
+		break;
+	}
+
+	writel(ctrl, &regs->nor_bank_regs[bank].ctrl);
+	writel(0x0FFFFFFF, &regs->nor_bank_regs[bank].ctrl_tim);
+	writel(ctrl | RSTPWRDWN, &regs->nor_bank_regs[bank].ctrl);
+
+	iounmap(fsmc_nor_base);
+
+	return 0;
+}
+
+void __init fsmc_init_board_info(struct platform_device *pdev,
+		struct mtd_partition *partitions, unsigned int nr_partitions,
+		unsigned int width)
+{
+	fsmc_nor_set_plat_data(pdev, partitions, nr_partitions, width);
+}
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index cd54e62..9b0f009 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -34,6 +34,7 @@ extern struct amba_device spear13xx_ssp_device;
 extern struct amba_device spear13xx_uart_device;
 extern struct platform_device spear13xx_ehci0_device;
 extern struct platform_device spear13xx_ehci1_device;
+extern struct platform_device spear13xx_fsmc_nor_device;
 extern struct platform_device spear13xx_i2c_device;
 extern struct platform_device spear13xx_kbd_device;
 extern struct platform_device spear13xx_nand_device;
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 269d9b0..e56fbd4 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -22,11 +22,21 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 #include <mach/pcie.h>
+#include <plat/fsmc.h>
 #include <plat/keyboard.h>
 #include <plat/fsmc.h>
 #include <plat/smi.h>
 #include <plat/spi.h>
 
+#define PARTITION(n, off, sz)	{.name = n, .offset = off, .size = sz}
+
+static struct mtd_partition partition_info[] = {
+	PARTITION("X-loader", 0, 1 * 0x20000),
+	PARTITION("U-Boot", 0x20000, 3 * 0x20000),
+	PARTITION("Kernel", 0x80000, 24 * 0x20000),
+	PARTITION("Root File System", 0x380000, 84 * 0x20000),
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	&spear13xx_gpio_device[0],
 	&spear13xx_gpio_device[1],
@@ -114,6 +124,13 @@ static void __init spear1300_evb_init(void)
 	enable_pcie0_clk();
 	pcie_init(&spear1300_pcie_port_is_host);
 #endif
+	/* initialize fsmc related data in fsmc plat data */
+	fsmc_init_board_info(&spear13xx_fsmc_nor_device, partition_info,
+			ARRAY_SIZE(partition_info), FSMC_FLASH_WIDTH8);
+
+	/* Initialize fsmc regiters */
+	fsmc_nor_init(&spear13xx_fsmc_nor_device, SPEAR13XX_FSMC_BASE, 0,
+			FSMC_FLASH_WIDTH8);
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index c1227bc..f6b4323 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -27,6 +27,15 @@
 #include <plat/smi.h>
 #include <plat/spi.h>
 
+#define PARTITION(n, off, sz)	{.name = n, .offset = off, .size = sz}
+
+static struct mtd_partition partition_info[] = {
+	PARTITION("X-loader", 0, 1 * 0x20000),
+	PARTITION("U-Boot", 0x20000, 3 * 0x20000),
+	PARTITION("Kernel", 0x80000, 24 * 0x20000),
+	PARTITION("Root File System", 0x380000, 84 * 0x20000),
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear13xx specific devices */
 	&spear13xx_gpio_device[0],
@@ -115,6 +124,14 @@ static void __init spear1310_evb_init(void)
 	/* initialize serial nor related data in smi plat data */
 	smi_init_board_info(&spear13xx_smi_device);
 
+	/* initialize fsmc related data in fsmc plat data */
+	fsmc_init_board_info(&spear13xx_fsmc_nor_device, partition_info,
+			ARRAY_SIZE(partition_info), FSMC_FLASH_WIDTH8);
+
+	/* Initialize fsmc regiters */
+	fsmc_nor_init(&spear13xx_fsmc_nor_device, SPEAR13XX_FSMC_BASE, 0,
+			FSMC_FLASH_WIDTH8);
+
 #ifdef CONFIG_PCIEPORTBUS
 	/* Enable PCIE0 clk */
 	enable_pcie0_clk();
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 76920ec..cdf132e 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
+#include <linux/mtd/physmap.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
 #include <mtd/fsmc.h>
@@ -130,6 +131,25 @@ struct platform_device spear13xx_i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* fsmc nor flash device registeration */
+static struct physmap_flash_data fsmc_norflash_data;
+
+static struct resource fsmc_nor_resources[] = {
+	{
+		.start	= SPEAR13XX_FSMC_MEM_BASE,
+		.end	= SPEAR13XX_FSMC_MEM_BASE + SZ_16M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device spear13xx_fsmc_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.resource = fsmc_nor_resources,
+	.num_resources = ARRAY_SIZE(fsmc_nor_resources),
+	.dev.platform_data = &fsmc_norflash_data,
+};
+
 /* nand device registeration */
 void __init nand_mach_init(u32 busw)
 {
diff --git a/arch/arm/plat-spear/include/plat/fsmc.h b/arch/arm/plat-spear/include/plat/fsmc.h
index bb161fb..6ecf2e7 100644
--- a/arch/arm/plat-spear/include/plat/fsmc.h
+++ b/arch/arm/plat-spear/include/plat/fsmc.h
@@ -14,6 +14,7 @@
 #ifndef __PLAT_FSMC_H
 #define __PLAT_FSMC_H
 
+#include <linux/mtd/physmap.h>
 #include <mtd/fsmc.h>
 
 /* This function is used to set platform data field of pdev->dev */
@@ -33,4 +34,18 @@ static inline void fsmc_nand_set_plat_data(struct platform_device *pdev,
 	plat_data->width = width;
 }
 
+static inline void fsmc_nor_set_plat_data(struct platform_device *pdev,
+		struct mtd_partition *partitions, unsigned int nr_partitions,
+		unsigned int width)
+{
+	struct physmap_flash_data *plat_data;
+	plat_data = dev_get_platdata(&pdev->dev);
+
+	if (partitions) {
+		plat_data->parts = partitions;
+		plat_data->nr_parts = nr_partitions;
+	}
+
+	plat_data->width = width;
+}
 #endif /* __PLAT_FSMC_H */
diff --git a/include/mtd/fsmc.h b/include/mtd/fsmc.h
index 7b8921b..95725d9 100644
--- a/include/mtd/fsmc.h
+++ b/include/mtd/fsmc.h
@@ -44,6 +44,7 @@
 
 #define FSMC_FLASH_WIDTH8	1
 #define FSMC_FLASH_WIDTH16	2
+#define FSMC_FLASH_WIDTH32	4
 
 struct fsmc_nor_bank_regs {
 	u32 ctrl;
@@ -56,6 +57,7 @@ struct fsmc_nor_bank_regs {
 #define NOR_DEV			(2 << 2)
 #define WIDTH_8			(0 << 4)
 #define WIDTH_16		(1 << 4)
+#define WIDTH_32		(2 << 4)
 #define RSTPWRDWN		(1 << 6)
 #define WPROT			(1 << 7)
 #define WRT_ENABLE		(1 << 12)
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
