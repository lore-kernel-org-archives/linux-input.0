From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 39/69] ST SPEAr : EMI (Extrenal Memory Interface) controller driver
Date: Fri,  1 Oct 2010 17:25:59 +0530
Message-ID: <027f942df7073593a3b14406be48590f0ad460eb.1285933332.git.viresh.kumar@st.com>
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

2 SPEAr platform SoCs(spear310 and spear320) support an External Memory
Interface controller. This controller is used to interface with
Parallel NOR Flash devices.

This patch adds just the platform code needed for EMI (mainly EMI
initialization). The driver being used is driver/mtd/maps/physmap.c

Signed-off-by: Vipin Kumar <vipin.kumar-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/mach-spear3xx/Makefile                |    4 +
 arch/arm/mach-spear3xx/emi.c                   |  101 ++++++++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/emi.h      |   64 +++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    2 +
 arch/arm/mach-spear3xx/include/mach/spear310.h |    9 ++
 arch/arm/mach-spear3xx/include/mach/spear320.h |    6 ++
 arch/arm/mach-spear3xx/spear310.c              |    9 ++
 arch/arm/mach-spear3xx/spear310_evb.c          |   28 +++++++
 arch/arm/mach-spear3xx/spear320.c              |    9 ++
 arch/arm/mach-spear3xx/spear320_evb.c          |   27 ++++++
 10 files changed, 259 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spear3xx/emi.c
 create mode 100644 arch/arm/mach-spear3xx/include/mach/emi.h

diff --git a/arch/arm/mach-spear3xx/Makefile b/arch/arm/mach-spear3xx/Makefile
index b248624..d38ae47 100644
--- a/arch/arm/mach-spear3xx/Makefile
+++ b/arch/arm/mach-spear3xx/Makefile
@@ -24,3 +24,7 @@ obj-$(CONFIG_MACH_SPEAR320) += spear320.o
 
 # spear320 boards files
 obj-$(CONFIG_BOARD_SPEAR320_EVB) += spear320_evb.o
+
+# specific files
+obj-$(CONFIG_MACH_SPEAR310) += emi.o
+obj-$(CONFIG_MACH_SPEAR320) += emi.o
diff --git a/arch/arm/mach-spear3xx/emi.c b/arch/arm/mach-spear3xx/emi.c
new file mode 100644
index 0000000..7b62ff0
--- /dev/null
+++ b/arch/arm/mach-spear3xx/emi.c
@@ -0,0 +1,101 @@
+/*
+ * arch/arm/mach-spear3xx/emi.c
+ *
+ * EMI (External Memory Interface) file
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
+#include <linux/io.h>
+#include <mach/emi.h>
+
+int __init emi_init(struct platform_device *pdev, unsigned long base,
+		u32 bank, u32 width)
+{
+	void __iomem *emi_reg_base;
+	struct clk *clk;
+	int ret;
+
+	if (bank > (EMI_MAX_BANKS - 1))
+		return -EINVAL;
+
+	emi_reg_base = ioremap(base, EMI_REG_SIZE);
+	if (!emi_reg_base)
+		return -ENOMEM;
+
+	clk = clk_get(NULL, "emi");
+	if (IS_ERR(clk)) {
+		iounmap(emi_reg_base);
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_enable(clk);
+	if (ret) {
+		iounmap(emi_reg_base);
+		return ret;
+	}
+
+	/*
+	 * Note: These are relaxed NOR device timings. Nor devices on spear
+	 * eval machines are working fine with these timings. Specific board
+	 * files can optimize these timings based on devices found on board.
+	 */
+	writel(0x10, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TAP_REG);
+	writel(0x05, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TSDP_REG);
+	writel(0x0a, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDPW_REG);
+	writel(0x0a, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDPR_REG);
+	writel(0x05, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDCS_REG);
+
+	switch (width) {
+	case EMI_FLASH_WIDTH8:
+		width = EMI_CNTL_WIDTH8;
+		break;
+
+	case EMI_FLASH_WIDTH16:
+		width = EMI_CNTL_WIDTH16;
+		break;
+
+	case EMI_FLASH_WIDTH32:
+		width = EMI_CNTL_WIDTH32;
+		break;
+	default:
+		width = EMI_CNTL_WIDTH8;
+		break;
+	}
+	/* set the data width */
+	writel(width | EMI_CNTL_ENBBYTERW,
+		emi_reg_base + (EMI_BANK_REG_SIZE * bank) + CTRL_REG);
+
+	/* disable all the acks */
+	writel(0x3f, emi_reg_base + ack_reg);
+
+	iounmap(emi_reg_base);
+
+	return 0;
+}
+
+void __init
+emi_init_board_info(struct platform_device *pdev, struct resource *resources,
+		int res_num, struct mtd_partition *partitions,
+		unsigned int nr_partitions, unsigned int width)
+{
+	struct physmap_flash_data *emi_plat_data = dev_get_platdata(&pdev->dev);
+
+	pdev->resource = resources;
+	pdev->num_resources = res_num;
+
+	if (partitions) {
+		emi_plat_data->parts = partitions;
+		emi_plat_data->nr_parts = nr_partitions;
+	}
+
+	emi_plat_data->width = width;
+}
diff --git a/arch/arm/mach-spear3xx/include/mach/emi.h b/arch/arm/mach-spear3xx/include/mach/emi.h
new file mode 100644
index 0000000..b620bf5
--- /dev/null
+++ b/arch/arm/mach-spear3xx/include/mach/emi.h
@@ -0,0 +1,64 @@
+/*
+ * arch/arm/mach-spear3xx/include/mach/emi.h
+ *
+ * EMI macros for SPEAr platform
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Vipin Kumar <vipin.kumar-qxv4g6HH51o@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_EMI_H
+#define __MACH_EMI_H
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+
+#define EMI_FLASH_WIDTH8	1
+#define EMI_FLASH_WIDTH16	2
+#define EMI_FLASH_WIDTH32	4
+
+#define EMI_REG_SIZE		0x100
+#define EMI_BANK_REG_SIZE	0x18
+
+#define TAP_REG			(0x0)
+#define TSDP_REG		(0x4)
+#define TDPW_REG		(0x8)
+#define TDPR_REG		(0xC)
+#define TDCS_REG		(0x10)
+#define CTRL_REG		(0x14)
+
+#if defined(CONFIG_MACH_SPEAR310)
+#define TIMEOUT_REG		(0x90)
+#define ACK_REG			(0x94)
+#define IRQ_REG			(0x98)
+
+#define EMI_MAX_BANKS		6
+
+#elif defined(CONFIG_MACH_SPEAR320)
+#define TIMEOUT_REG		(0x60)
+#define ACK_REG			(0x64)
+#define IRQ_REG			(0x68)
+
+#define EMI_MAX_BANKS		4
+
+#endif
+
+/* Control register definitions */
+#define EMI_CNTL_WIDTH8		(0 << 0)
+#define EMI_CNTL_WIDTH16	(1 << 0)
+#define EMI_CNTL_WIDTH32	(2 << 0)
+#define EMI_CNTL_ENBBYTEW	(1 << 2)
+#define EMI_CNTL_ENBBYTER	(1 << 3)
+#define EMI_CNTL_ENBBYTERW	(EMI_CNTL_ENBBYTER | EMI_CNTL_ENBBYTEW)
+
+extern int __init emi_init(struct platform_device *pdev, unsigned long base,
+		u32 bank, u32 width);
+extern void __init emi_init_board_info(struct platform_device *pdev,
+		struct resource *resources, int res_num, struct mtd_partition
+		*partitions, unsigned int nr_partitions, unsigned int width);
+#endif
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 7b83197..1462944 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -166,6 +166,7 @@ extern struct amba_device uart2_device;
 extern struct amba_device uart3_device;
 extern struct amba_device uart4_device;
 extern struct amba_device uart5_device;
+extern struct platform_device emi_nor_device;
 extern struct platform_device plgpio_device;
 extern struct platform_device nand_device;
 
@@ -191,6 +192,7 @@ extern struct amba_device uart1_device;
 extern struct amba_device uart2_device;
 extern struct platform_device can0_device;
 extern struct platform_device can1_device;
+extern struct platform_device emi_nor_device;
 extern struct platform_device i2c1_device;
 extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
diff --git a/arch/arm/mach-spear3xx/include/mach/spear310.h b/arch/arm/mach-spear3xx/include/mach/spear310.h
index 1e85347..37556b6 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear310.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear310.h
@@ -18,6 +18,15 @@
 
 #define SPEAR310_NAND_BASE		UL(0x40000000)
 #define SPEAR310_FSMC_BASE		UL(0x44000000)
+#define SPEAR310_EMI_REG_BASE		UL(0x4F000000)
+#define SPEAR310_EMI_MEM_0_BASE		UL(0x50000000)
+#define SPEAR310_EMI_MEM_1_BASE		UL(0x60000000)
+#define SPEAR310_EMI_MEM_2_BASE		UL(0x70000000)
+#define SPEAR310_EMI_MEM_3_BASE		UL(0x80000000)
+#define SPEAR310_EMI_MEM_4_BASE		UL(0x90000000)
+#define SPEAR310_EMI_MEM_5_BASE		UL(0xA0000000)
+#define SPEAR310_EMI_MEM_SIZE		UL(0x10000000)
+
 #define SPEAR310_UART1_BASE		UL(0xB2000000)
 #define SPEAR310_UART2_BASE		UL(0xB2080000)
 #define SPEAR310_UART3_BASE		UL(0xB2100000)
diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
index 940f0d8..4f60073 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear320.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
@@ -17,6 +17,12 @@
 #define __MACH_SPEAR320_H
 
 #define SPEAR320_EMI_CTRL_BASE		UL(0x40000000)
+#define SPEAR320_EMI_MEM_0_BASE		UL(0x44000000)
+#define SPEAR320_EMI_MEM_1_BASE		UL(0x45000000)
+#define SPEAR320_EMI_MEM_2_BASE		UL(0x46000000)
+#define SPEAR320_EMI_MEM_3_BASE		UL(0x47000000)
+#define SPEAR320_EMI_MEM_SIZE		UL(0x01000000)
+
 #define SPEAR320_FSMC_BASE		UL(0x4C000000)
 #define SPEAR320_NAND_BASE		UL(0x50000000)
 #define SPEAR320_I2S_BASE		UL(0x60000000)
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 25a0e94..0d12ee3 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/mtd/physmap.h>
 #include <linux/ptrace.h>
 #include <mtd/fsmc.h>
 #include <asm/irq.h>
@@ -268,6 +269,14 @@ int spear300_o2p(int offset)
 		return offset + 2;
 }
 
+/* emi nor flash device registeration */
+static struct physmap_flash_data emi_norflash_data;
+struct platform_device emi_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev.platform_data = &emi_norflash_data,
+};
+
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
 	.irq_base = SPEAR_PLGPIO_INT_BASE,
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index bff90b3..49aca18 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -17,6 +17,7 @@
 #include <asm/mach-types.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
+#include <mach/emi.h>
 #include <mach/generic.h>
 #include <mach/gpio.h>
 #include <mach/spear.h>
@@ -24,6 +25,24 @@
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
+/* emi nor flash resources registeration */
+static struct resource emi_nor_resources[] = {
+	{
+		.start	= SPEAR310_EMI_MEM_0_BASE,
+		.end	= SPEAR310_EMI_MEM_0_BASE + SPEAR310_EMI_MEM_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
 	/* spear3xx specific devices */
@@ -61,6 +80,7 @@ static struct amba_device *amba_devs[] __initdata = {
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&ehci_device,
+	&emi_nor_device,
 	&i2c_device,
 	&nand_device,
 	&ohci0_device,
@@ -129,6 +149,11 @@ static void __init spear310_evb_init(void)
 	/* initialize serial nor related data in smi plat data */
 	smi_init_board_info(&smi_device);
 
+	/* initialize emi related data in emi plat data */
+	emi_init_board_info(&emi_nor_device, emi_nor_resources,
+			ARRAY_SIZE(emi_nor_resources), partition_info,
+			ARRAY_SIZE(partition_info), EMI_FLASH_WIDTH32);
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
@@ -136,6 +161,9 @@ static void __init spear310_evb_init(void)
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
 
+	/* Initialize emi regiters */
+	emi_init(&emi_nor_device, SPEAR310_EMI_REG_BASE, 0, EMI_FLASH_WIDTH32);
+
 	spi_init();
 }
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index a6aa487..ae09245 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/amba/pl022.h>
+#include <linux/mtd/physmap.h>
 #include <linux/ptrace.h>
 #include <linux/types.h>
 #include <linux/mmc/sdhci-spear.h>
@@ -473,6 +474,14 @@ struct amba_device uart2_device = {
 	.irq = {VIRQ_UART2, NO_IRQ},
 };
 
+/* emi nor flash device registeration */
+static struct physmap_flash_data emi_norflash_data;
+struct platform_device emi_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev.platform_data = &emi_norflash_data,
+};
+
 /* plgpio device registeration */
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 1131f9b..04361fc 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -18,6 +18,7 @@
 #include <linux/spi/flash.h>
 #include <linux/mmc/sdhci-spear.h>
 #include <linux/spi/spi.h>
+#include <mach/emi.h>
 #include <mach/generic.h>
 #include <mach/gpio.h>
 #include <mach/spear.h>
@@ -25,6 +26,24 @@
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
+/* emi nor flash resources registeration */
+static struct resource emi_nor_resources[] = {
+	{
+		.start	= SPEAR310_EMI_MEM_0_BASE,
+		.end	= SPEAR310_EMI_MEM_0_BASE + SPEAR310_EMI_MEM_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
 	/* spear3xx specific devices */
@@ -116,6 +135,11 @@ static void __init spear320_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_board_devices();
 
+	/* initialize emi related data in emi plat data */
+	emi_init_board_info(&emi_nor_device, emi_nor_resources,
+			ARRAY_SIZE(emi_nor_resources), partition_info,
+			ARRAY_SIZE(partition_info), EMI_FLASH_WIDTH16);
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
@@ -123,6 +147,9 @@ static void __init spear320_evb_init(void)
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
 
+	/* Initialize emi regiters */
+	emi_init(&emi_nor_device, SPEAR320_EMI_CTRL_BASE, 0, EMI_FLASH_WIDTH16);
+
 	spi_init();
 }
 
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
