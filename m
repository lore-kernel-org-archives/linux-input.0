From: Viresh KUMAR <viresh.kumar@st.com>
Subject: [PATCH V2 26/69] ST SPEAr: Adding support for serial nor flash in all spear platforms
Date: Fri,  1 Oct 2010 17:25:46 +0530
Message-ID: <76fc3473e51833e5058c5323c5cf50f7b1c8a219.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:60560 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756741Ab0JAL6S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 07:58:18 -0400
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com, a.zummo@towertech.it, dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry
Cc: Shiraz Hashim <shiraz.hashim@st.com>, vipin.kumar@st.com, deepak.sikri@st.com, armando.visconti@st.com, vipulkumar.samar@st.com, rajeev-dlh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, Viresh Kumar <viresh.kumar@st.com>

From: Shiraz Hashim <shiraz.hashim@st.com>

Adding smi device support and enumerating all serial nor flashes present
in spear(spear3xx/spear6xx/spear13xx) evaluation boards.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |    5 ++
 arch/arm/mach-spear13xx/spear13xx.c            |   19 +++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear3xx/spear300_evb.c          |    5 ++
 arch/arm/mach-spear3xx/spear310_evb.c          |    5 ++
 arch/arm/mach-spear3xx/spear320_evb.c          |    5 ++
 arch/arm/mach-spear3xx/spear3xx.c              |   19 +++++++
 arch/arm/mach-spear6xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c          |    5 ++
 arch/arm/mach-spear6xx/spear6xx.c              |   19 +++++++
 arch/arm/plat-spear/Makefile                   |    2 +-
 arch/arm/plat-spear/include/plat/smi.h         |    3 +
 arch/arm/plat-spear/smi.c                      |   63 ++++++++++++++++++++++++
 14 files changed, 152 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-spear/smi.c

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index f3e6d95..960ff06 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -38,6 +38,7 @@ extern struct platform_device spear13xx_kbd_device;
 extern struct platform_device spear13xx_ohci0_device;
 extern struct platform_device spear13xx_ohci1_device;
 extern struct platform_device spear13xx_rtc_device;
+extern struct platform_device spear13xx_smi_device;
 extern struct sys_timer spear13xx_timer;
 
 /* Add spear1300 machine device structure declarations here */
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 2b2598c..1e637fa 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -17,6 +17,7 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 #include <plat/keyboard.h>
+#include <plat/smi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
 	&spear13xx_gpio_device[0],
@@ -32,6 +33,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
+	&spear13xx_smi_device,
 };
 
 /* keyboard specific platform data */
@@ -56,6 +58,9 @@ static void __init spear1300_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_board_devices();
 
+	/* initialize serial nor related data in smi plat data */
+	smi_init_board_info(&spear13xx_smi_device);
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 2037cd2..f7d30a9 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -241,6 +241,25 @@ struct platform_device spear13xx_rtc_device = {
 	.resource = rtc_resources,
 };
 
+/* smi device registration */
+static struct resource smi_resources[] = {
+	{
+		.start = SPEAR13XX_SMI_CTRL_BASE,
+		.end = SPEAR13XX_SMI_CTRL_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_SMI,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear13xx_smi_device = {
+	.name = "smi",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(smi_resources),
+	.resource = smi_resources,
+};
+
 /* Do spear13xx familiy common initialization part here */
 void __init spear13xx_init(void)
 {
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 447de7e..9317af8 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -38,6 +38,7 @@ extern struct platform_device i2c_device;
 extern struct platform_device ohci0_device;
 extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
+extern struct platform_device smi_device;
 extern struct sys_timer spear3xx_timer;
 
 /* Add spear3xx family function declarations here */
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index afb773e..c948289 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -16,6 +16,7 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 #include <plat/keyboard.h>
+#include <plat/smi.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -50,6 +51,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
+	&smi_device,
 
 	/* spear300 specific devices */
 	&kbd_device,
@@ -82,6 +84,9 @@ static void __init spear300_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_board_devices();
 
+	/* initialize serial nor related data in smi plat data */
+	smi_init_board_info(&smi_device);
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index d523040..2a88cd2 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -15,6 +15,7 @@
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/smi.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -55,6 +56,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
+	&smi_device,
 
 	/* spear310 specific devices */
 	&plgpio_device,
@@ -75,6 +77,9 @@ static void __init spear310_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_board_devices();
 
+	/* initialize serial nor related data in smi plat data */
+	smi_init_board_info(&smi_device);
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 943eddc..d0cfd96 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -15,6 +15,7 @@
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/smi.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -53,6 +54,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
+	&smi_device,
 
 	/* spear320 specific devices */
 	&i2c1_device,
@@ -72,6 +74,9 @@ static void __init spear320_evb_init(void)
 	/* call spear320 machine init function */
 	spear320_init();
 
+	/* initialize serial nor related data in smi plat data */
+	smi_init_board_info(&smi_device);
+
 	/* Register slave devices on the I2C buses */
 	i2c_register_board_devices();
 
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 61d607b..ff9f6e9 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -175,6 +175,25 @@ struct platform_device rtc_device = {
 	.resource = rtc_resources,
 };
 
+/* smi device registration */
+static struct resource smi_resources[] = {
+	{
+		.start = SPEAR3XX_ICM3_SMI_CTRL_BASE,
+		.end = SPEAR3XX_ICM3_SMI_CTRL_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_BASIC_SMI,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device smi_device = {
+	.name = "smi",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(smi_resources),
+	.resource = smi_resources,
+};
+
 /* Do spear3xx familiy common initialization part here */
 void __init spear3xx_init(void)
 {
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 3b15289..8aee3ad 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -38,6 +38,7 @@ extern struct platform_device i2c_device;
 extern struct platform_device ohci0_device;
 extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
+extern struct platform_device smi_device;
 extern struct sys_timer spear6xx_timer;
 
 /* Add spear6xx family function declarations here */
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index b4dfd25..bd4be34 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -15,6 +15,7 @@
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/smi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
 	&clcd_device,
@@ -32,6 +33,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
+	&smi_device,
 };
 
 static void __init spear600_evb_init(void)
@@ -44,6 +46,9 @@ static void __init spear600_evb_init(void)
 	/* Register slave devices on the I2C buses */
 	i2c_register_board_devices();
 
+	/* initialize serial nor related data in smi plat data */
+	smi_init_board_info(&smi_device);
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index e78c2e5..000b3a8 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -267,6 +267,25 @@ struct platform_device rtc_device = {
 	.resource = rtc_resources,
 };
 
+/* smi device registration */
+static struct resource smi_resources[] = {
+	{
+		.start = SPEAR6XX_ICM3_SMI_CTRL_BASE,
+		.end = SPEAR6XX_ICM3_SMI_CTRL_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_BASIC_SMI,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device smi_device = {
+	.name = "smi",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(smi_resources),
+	.resource = smi_resources,
+};
+
 /* This will add devices, and do machine specific tasks */
 void __init spear6xx_init(void)
 {
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index 0e29587..b8a7403 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y	:= clcd.o clock.o time.o
+obj-y	:= clcd.o clock.o time.o smi.o
 
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
 obj-$(CONFIG_MACH_SPEAR310)	+= plgpio.o
diff --git a/arch/arm/plat-spear/include/plat/smi.h b/arch/arm/plat-spear/include/plat/smi.h
index 4c74df7..37dbd5e 100644
--- a/arch/arm/plat-spear/include/plat/smi.h
+++ b/arch/arm/plat-spear/include/plat/smi.h
@@ -65,4 +65,7 @@ static inline void smi_set_plat_data(struct platform_device *pdev,
 	pdev->dev.platform_data = pdata;
 }
 
+/* function used to initialize default smi platform data */
+void smi_init_board_info(struct platform_device *pdev);
+
 #endif /* __PLAT_SMI_H */
diff --git a/arch/arm/plat-spear/smi.c b/arch/arm/plat-spear/smi.c
new file mode 100644
index 0000000..ebdaeec
--- /dev/null
+++ b/arch/arm/plat-spear/smi.c
@@ -0,0 +1,63 @@
+/*
+ * arch/arm/plat-spear/smi.c
+ *
+ * spear smi platform intialization
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <asm/mach-types.h>
+#include <plat/smi.h>
+#include <mach/spear.h>
+
+/*
+ * physical base address of flash/bank mem map base associated with smi
+ * depends on SoC
+ */
+
+#if defined(CONFIG_ARCH_SPEAR13XX)
+#define FLASH_MEM_BASE	SPEAR13XX_SMI_MEM_BASE
+
+#elif defined(CONFIG_ARCH_SPEAR3XX)
+#define FLASH_MEM_BASE	SPEAR3XX_ICM3_SMEM_BASE
+
+#elif defined(CONFIG_ARCH_SPEAR6XX)
+#define FLASH_MEM_BASE	SPEAR6XX_ICM3_SMEM_BASE
+
+#endif
+
+/* serial nor flash specific board data */
+static struct mtd_partition nor_partition_info[] = {
+	DEFINE_PARTS("Xloader", 0x00, 0x10000),
+	DEFINE_PARTS("UBoot", 0x10000, 0x40000),
+	DEFINE_PARTS("Kernel", 0x50000, 0x2C0000),
+	DEFINE_PARTS("Root File System", 0x310000, 0x4F0000),
+};
+
+static struct spear_smi_flash_info nor_flash_info[] = {
+	{
+		.name = "m25p64",
+		.fast_mode = 1,
+		.mem_base = FLASH_MEM_BASE,
+		.size = 8 * 1024 * 1024,
+		.num_parts = ARRAY_SIZE(nor_partition_info),
+		.parts = nor_partition_info,
+	},
+};
+
+/* smi specific board data */
+static struct spear_smi_plat_data smi_plat_data = {
+	.clk_rate = 50000000,	/* 50MHz */
+	.num_flashes = ARRAY_SIZE(nor_flash_info),
+	.board_flash_info = nor_flash_info,
+};
+
+void smi_init_board_info(struct platform_device *pdev)
+{
+	smi_set_plat_data(pdev, &smi_plat_data);
+}
-- 
1.7.2.2

