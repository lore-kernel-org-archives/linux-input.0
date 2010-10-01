From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 37/69] ST SPEAr 13xx : Adding support for SPEAr1310
Date: Fri,  1 Oct 2010 17:25:57 +0530
Message-ID: <99ee2c24fa9e2ec42bbb71ea3f21d4b67ad8634b.1285933332.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
In-Reply-To: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
References: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry
Cc: Bhupesh Sharma <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, shiraz.hashim-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Bhupesh Sharma <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>

This patch adds support for SPEAr1310 Machine and evaluation board

Signed-off-by: Bhupesh Sharma <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>
Signed-off-by: shiraz hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/Makefile                                |    1 +
 arch/arm/configs/spear13xx_defconfig             |    1 +
 arch/arm/mach-spear13xx/Kconfig                  |   11 ++
 arch/arm/mach-spear13xx/Makefile                 |    6 +
 arch/arm/mach-spear13xx/include/mach/generic.h   |   21 +++-
 arch/arm/mach-spear13xx/include/mach/irqs.h      |   37 ++++++
 arch/arm/mach-spear13xx/include/mach/spear.h     |    1 +
 arch/arm/mach-spear13xx/include/mach/spear1310.h |   31 +++++
 arch/arm/mach-spear13xx/spear1310.c              |   62 ++++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c          |  140 ++++++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h    |    2 +
 arch/arm/mach-spear3xx/spear320.c                |   37 ++++++
 arch/arm/mach-spear3xx/spear320_evb.c            |    2 +
 arch/arm/plat-spear/Makefile                     |    1 +
 14 files changed, 350 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1310.h
 create mode 100644 arch/arm/mach-spear13xx/spear1310.c
 create mode 100644 arch/arm/mach-spear13xx/spear1310_evb.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d5177d7..950a9b5 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -192,6 +192,7 @@ machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_ARCH_NUC93X)		:= nuc93x
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
 machine-$(CONFIG_MACH_SPEAR1300)	:= spear13xx
+machine-$(CONFIG_MACH_SPEAR1310)	:= spear13xx
 machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 10b1cf5..9f3baf8 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -9,6 +9,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR13XX=y
 CONFIG_BOARD_SPEAR1300_EVB=y
+CONFIG_BOARD_SPEAR1310_EVB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_AEABI=y
diff --git a/arch/arm/mach-spear13xx/Kconfig b/arch/arm/mach-spear13xx/Kconfig
index 3ea463d..229ef93 100644
--- a/arch/arm/mach-spear13xx/Kconfig
+++ b/arch/arm/mach-spear13xx/Kconfig
@@ -11,6 +11,12 @@ config BOARD_SPEAR1300_EVB
 	help
 	  Supports ST SPEAr1300 Evaluation Board
 
+config BOARD_SPEAR1310_EVB
+	bool "SPEAr1310 Evaluation Board"
+	select MACH_SPEAR1310
+	help
+	  Supports ST SPEAr1310 Evaluation Board
+
 endmenu
 
 config MACH_SPEAR1300
@@ -18,4 +24,9 @@ config MACH_SPEAR1300
 	help
 	  Supports ST SPEAr1300 Machine
 
+config MACH_SPEAR1310
+	bool "SPEAr1310"
+	help
+	  Supports ST SPEAr1310 Machine
+
 endif #ARCH_SPEAR13XX
diff --git a/arch/arm/mach-spear13xx/Makefile b/arch/arm/mach-spear13xx/Makefile
index 4f1cbc5..838405a 100644
--- a/arch/arm/mach-spear13xx/Makefile
+++ b/arch/arm/mach-spear13xx/Makefile
@@ -13,3 +13,9 @@ obj-$(CONFIG_MACH_SPEAR1300)		+= spear1300.o
 
 # spear1300 boards files
 obj-$(CONFIG_BOARD_SPEAR1300_EVB)	+= spear1300_evb.o
+
+# spear1310 specific files
+obj-$(CONFIG_MACH_SPEAR1310)		+= spear1310.o
+
+# spear1310 boards files
+obj-$(CONFIG_BOARD_SPEAR1310_EVB)	+= spear1310_evb.o
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index bfd0667..83be1f2 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -44,17 +44,32 @@ extern struct platform_device spear13xx_sdhci_device;
 extern struct platform_device spear13xx_smi_device;
 extern struct sys_timer spear13xx_timer;
 
-/* Add spear1300 machine device structure declarations here */
-
 /* Add spear13xx family function declarations here */
 void __init clk_init(void);
 void __init i2c_register_board_devices(void);
 void __init spear_setup_timer(void);
-void __init spear1300_init(void);
 void __init spear13xx_map_io(void);
 void __init spear13xx_init_irq(void);
 void __init spear13xx_init(void);
 void __init nand_mach_init(u32 busw);
 void spear13xx_secondary_startup(void);
 
+/* spear1300 declarations */
+#ifdef CONFIG_MACH_SPEAR1300
+/* Add spear1300 machine function declarations here */
+void __init spear1300_init(void);
+
+#endif /* CONFIG_MACH_SPEAR1300 */
+
+/* spear1310 declarations */
+#ifdef CONFIG_MACH_SPEAR1310
+/* Add spear1310 machine device structure declarations here */
+extern struct platform_device spear1310_can0_device;
+extern struct platform_device spear1310_can1_device;
+
+/* Add spear1310 machine function declarations here */
+void __init spear1310_init(void);
+
+#endif /* CONFIG_MACH_SPEAR1310 */
+
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
index d2bfbb1..1ca70a6 100644
--- a/arch/arm/mach-spear13xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2010 ST Microelectronics
  * Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
+ * Bhupesh Sharma <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -84,6 +85,42 @@
 #define IRQ_PCIE1		(IRQ_SHPI_START + 69)
 #define IRQ_PCIE2		(IRQ_SHPI_START + 70)
 
+/* Add spear1310 specific IRQs here */
+#ifdef CONFIG_MACH_SPEAR1310
+#define IRQ_FSMC_PC1		(IRQ_SHPI_START + 76)
+#define IRQ_FSMC_PC2		(IRQ_SHPI_START + 77)
+#define IRQ_FSMC_PC3		(IRQ_SHPI_START + 78)
+#define IRQ_FSMC_PC4		(IRQ_SHPI_START + 79)
+#define IRQ_RS4850		(IRQ_SHPI_START + 80)
+#define IRQ_RS4851		(IRQ_SHPI_START + 81)
+#define IRQ_CCAN0		(IRQ_SHPI_START + 82)
+#define IRQ_CCAN1		(IRQ_SHPI_START + 83)
+#define IRQ_TDM0		(IRQ_SHPI_START + 84)
+#define IRQ_TDM1		(IRQ_SHPI_START + 85)
+#define IRQ_UART0		(IRQ_SHPI_START + 86)
+#define IRQ_UART1		(IRQ_SHPI_START + 87)
+#define IRQ_UART2		(IRQ_SHPI_START + 88)
+#define IRQ_UART3		(IRQ_SHPI_START + 89)
+#define IRQ_UART4		(IRQ_SHPI_START + 90)
+#define IRQ_I2C_CNTR		(IRQ_SHPI_START + 91)
+#define IRQ_GMAC0_SBD		(IRQ_SHPI_START + 92)
+#define IRQ_GMAC0_PMT		(IRQ_SHPI_START + 93)
+#define IRQ_GMAC1_SBD		(IRQ_SHPI_START + 94)
+#define IRQ_GMAC1_PMT		(IRQ_SHPI_START + 95)
+#define IRQ_GMAC2_SBD		(IRQ_SHPI_START + 96)
+#define IRQ_GMAC2_PMT		(IRQ_SHPI_START + 97)
+#define IRQ_GMAC3_SBD		(IRQ_SHPI_START + 98)
+#define IRQ_GMAC3_PMT		(IRQ_SHPI_START + 99)
+#define IRQ_GPIO		(IRQ_SHPI_START + 100)
+#define IRQ_PCI_BRDG_HOST_FATAL (IRQ_SHPI_START + 101)
+#define IRQ_PCI_INTA		(IRQ_SHPI_START + 102)
+#define IRQ_PCI_INTB		(IRQ_SHPI_START + 103)
+#define IRQ_PCI_INTC		(IRQ_SHPI_START + 104)
+#define IRQ_PCI_INTD		(IRQ_SHPI_START + 105)
+#define IRQ_PCI_ME_TO_ARM	(IRQ_SHPI_START + 106)
+#define IRQ_PCI_SERR_TO_ARM	(IRQ_SHPI_START + 107)
+#endif /* CONFIG_MACH_SPEAR1310 */
+
 #define IRQ_GIC_END		(IRQ_SHPI_START + 128)
 
 #define VIRQ_START		IRQ_GIC_END
diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
index 1a1af72..cf25eb5 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -16,6 +16,7 @@
 
 #include <asm/memory.h>
 #include <mach/spear1300.h>
+#include <mach/spear1310.h>
 
 #define SPEAR13XX_L2CC_BASE		UL(0xED000000)
 
diff --git a/arch/arm/mach-spear13xx/include/mach/spear1310.h b/arch/arm/mach-spear13xx/include/mach/spear1310.h
new file mode 100644
index 0000000..e57c99a
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/spear1310.h
@@ -0,0 +1,31 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/spear1310.h
+ *
+ * SPEAr1310 Machine specific definition
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Bhupesh Sharma <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifdef CONFIG_MACH_SPEAR1310
+
+#ifndef __MACH_SPEAR1310_H
+#define __MACH_SPEAR1310_H
+
+#define SPEAR1310_CAN0_BASE		UL(0x6DA00000)
+#define SPEAR1310_CAN1_BASE		UL(0x6DB00000)
+#define SPEAR1310_RAS_BASE		UL(0x6C800000)
+
+/* RAS Area Control Register */
+#define SPEAR1310_RAS_CTRL_REG0		(SPEAR1310_RAS_BASE + 0x0)
+#define SPEAR1310_RAS_CTRL_REG1		(SPEAR1310_RAS_BASE + 0x4)
+#define SPEAR1310_PHY_CLK_MASK		0xF
+#define SPEAR1310_PHY_CLK_SHIFT		0
+
+#endif /* __MACH_SPEAR1310_H */
+
+#endif /* CONFIG_MACH_SPEAR1310 */
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
new file mode 100644
index 0000000..648dabc
--- /dev/null
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -0,0 +1,62 @@
+/*
+ * arch/arm/mach-spear13xx/spear1310.c
+ *
+ * SPEAr1310 machine source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Bhupesh Sharma <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/ptrace.h>
+#include <asm/irq.h>
+#include <mach/generic.h>
+#include <mach/hardware.h>
+
+/* Add spear1310 specific devices here */
+
+/* CAN device registeration */
+static struct resource can0_resources[] = {
+	{
+		.start = SPEAR1310_CAN0_BASE,
+		.end = SPEAR1310_CAN0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_CCAN0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear1310_can0_device = {
+	.name = "spear_can",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(can0_resources),
+	.resource = can0_resources,
+};
+
+static struct resource can1_resources[] = {
+	{
+		.start = SPEAR1310_CAN1_BASE,
+		.end = SPEAR1310_CAN1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_CCAN1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear1310_can1_device = {
+	.name = "spear_can",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(can1_resources),
+	.resource = can1_resources,
+};
+
+void __init spear1310_init(void)
+{
+	/* call spear13xx family common init function */
+	spear13xx_init();
+}
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
new file mode 100644
index 0000000..c1227bc
--- /dev/null
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -0,0 +1,140 @@
+/*
+ * arch/arm/mach-spear13xx/spear1310_evb.c
+ *
+ * SPEAr1310 evaluation board source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Bhupesh Sharma <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <linux/gpio.h>
+#include <linux/mtd/nand.h>
+#include <mtd/fsmc.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+#include <mach/pcie.h>
+#include <plat/keyboard.h>
+#include <plat/fsmc.h>
+#include <plat/smi.h>
+#include <plat/spi.h>
+
+static struct amba_device *amba_devs[] __initdata = {
+	/* spear13xx specific devices */
+	&spear13xx_gpio_device[0],
+	&spear13xx_gpio_device[1],
+	&spear13xx_ssp_device,
+	&spear13xx_uart_device,
+};
+
+static struct platform_device *plat_devs[] __initdata = {
+	/* spear13xx specific devices */
+	&spear13xx_ehci0_device,
+	&spear13xx_ehci1_device,
+	&spear13xx_i2c_device,
+	&spear13xx_kbd_device,
+	&spear13xx_nand_device,
+	&spear13xx_ohci0_device,
+	&spear13xx_ohci1_device,
+	&spear13xx_rtc_device,
+	&spear13xx_sdhci_device,
+	&spear13xx_smi_device,
+
+	/* spear1310 specific devices */
+	&spear1310_can0_device,
+	&spear1310_can1_device,
+};
+
+/* keyboard specific platform data */
+static DECLARE_KEYMAP(spear_keymap);
+
+static struct kbd_platform_data kbd_data = {
+	.keymap = spear_keymap,
+	.keymapsize = ARRAY_SIZE(spear_keymap),
+	.rep = 1,
+};
+
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
+#ifdef CONFIG_PCIEPORTBUS
+/* this function is needed for PCIE host and device driver. Same
+ * controller can not be programmed as host as well as device. So host
+ * driver must call this function and if this function returns 1 then
+ * only host should add that particular port as RC.
+ * A port to be added as device, one must also add device's information
+ * in plat_devs array defined in this file.
+ * it is the responsibility of calling function to not send port number
+ * greter than max no of controller(3)
+ */
+int spear1310_pcie_port_is_host(int port)
+{
+	switch (port) {
+	case 0:
+		return 0;
+	case 1:
+		return 1;
+	case 2:
+		return 1;
+	}
+	return -EINVAL;
+}
+#endif
+
+static void __init spear1310_evb_init(void)
+{
+	unsigned int i;
+
+	/* set keyboard plat data */
+	kbd_set_plat_data(&spear13xx_kbd_device, &kbd_data);
+
+	/* set nand device's plat data */
+	fsmc_nand_set_plat_data(&spear13xx_nand_device, NULL, 0,
+			NAND_SKIP_BBTSCAN, FSMC_NAND_BW8);
+	nand_mach_init(FSMC_NAND_BW8);
+
+	/* call spear1310 machine init function */
+	spear1310_init();
+
+	/* Register slave devices on the I2C buses */
+	i2c_register_board_devices();
+
+	/* initialize serial nor related data in smi plat data */
+	smi_init_board_info(&spear13xx_smi_device);
+
+#ifdef CONFIG_PCIEPORTBUS
+	/* Enable PCIE0 clk */
+	enable_pcie0_clk();
+	pcie_init(&spear1310_pcie_port_is_host);
+#endif
+
+	/* Add Platform Devices */
+	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
+
+	/* Add Amba Devices */
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
+		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
+}
+
+MACHINE_START(SPEAR1310, "ST-SPEAR1310-EVB")
+	.boot_params	=	0x00000100,
+	.map_io		=	spear13xx_map_io,
+	.init_irq	=	spear13xx_init_irq,
+	.timer		=	&spear13xx_timer,
+	.init_machine	=	spear1310_evb_init,
+MACHINE_END
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index ea170a6..0f7648b 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -189,6 +189,8 @@ extern struct amba_device clcd_device;
 extern struct amba_device ssp_device[];
 extern struct amba_device uart1_device;
 extern struct amba_device uart2_device;
+extern struct platform_device can0_device;
+extern struct platform_device can1_device;
 extern struct platform_device i2c1_device;
 extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 8ecad40..a6aa487 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -480,6 +480,43 @@ static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_count = SPEAR_PLGPIO_COUNT,
 };
 
+/* CAN device registeration */
+static struct resource can0_resources[] = {
+	{
+		.start = SPEAR320_CAN0_BASE,
+		.end = SPEAR320_CAN0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = VIRQ_CANU,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device can0_device = {
+	.name = "spear_can",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(can0_resources),
+	.resource = can0_resources,
+};
+
+static struct resource can1_resources[] = {
+	{
+		.start = SPEAR320_CAN1_BASE,
+		.end = SPEAR320_CAN1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = VIRQ_CANL,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device can1_device = {
+	.name = "spear_can",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(can1_resources),
+	.resource = can1_resources,
+};
+
 /* i2c1 device registeration */
 static struct resource i2c1_resources[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 2142ad9..1131f9b 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -67,6 +67,8 @@ static struct platform_device *plat_devs[] __initdata = {
 	&smi_device,
 
 	/* spear320 specific devices */
+	&can0_device,
+	&can1_device,
 	&i2c1_device,
 	&plgpio_device,
 	&pwm_device,
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index b8a7403..50c680c 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MACH_SPEAR310)	+= plgpio.o
 obj-$(CONFIG_MACH_SPEAR320)	+= plgpio.o
 obj-$(CONFIG_SPEAR_PWM)		+= pwm.o
 
+obj-$(CONFIG_BOARD_SPEAR1310_EVB)	+= i2c_eval_board.o
 obj-$(CONFIG_BOARD_SPEAR1300_EVB)	+= i2c_eval_board.o
 obj-$(CONFIG_BOARD_SPEAR300_EVB)	+= i2c_eval_board.o
 obj-$(CONFIG_BOARD_SPEAR310_EVB)	+= i2c_eval_board.o
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
