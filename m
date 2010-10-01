From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 31/69] ST SPEAr: Adding support for SSP PL022
Date: Fri,  1 Oct 2010 17:25:51 +0530
Message-ID: <bc7b13eec3a7c657da55f6699695b609cc371594.1285933332.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
In-Reply-To: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
References: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, shiraz.hashim-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |   15 +++++
 arch/arm/mach-spear13xx/spear13xx.c            |   31 ++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    2 +
 arch/arm/mach-spear3xx/spear300_evb.c          |   30 +++++++++
 arch/arm/mach-spear3xx/spear310_evb.c          |   42 +++++++++++++
 arch/arm/mach-spear3xx/spear320.c              |   42 +++++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c          |   14 ++++
 arch/arm/mach-spear3xx/spear3xx.c              |   31 ++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear6xx/include/mach/spear.h    |    4 +-
 arch/arm/mach-spear6xx/spear600_evb.c          |   18 ++++++
 arch/arm/mach-spear6xx/spear6xx.c              |   68 +++++++++++++++++++++
 arch/arm/plat-spear/include/plat/spi.h         |   77 ++++++++++++++++++++++++
 14 files changed, 374 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/spi.h

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 745dd99..7419e0b 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -30,6 +30,7 @@
 
 /* Add spear13xx family device structure declarations here */
 extern struct amba_device spear13xx_gpio_device[];
+extern struct amba_device spear13xx_ssp_device;
 extern struct amba_device spear13xx_uart_device;
 extern struct platform_device spear13xx_ehci0_device;
 extern struct platform_device spear13xx_ehci1_device;
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index d8698e0..ba46f61 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -12,7 +12,10 @@
  */
 
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/mtd/nand.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -22,10 +25,12 @@
 #include <plat/keyboard.h>
 #include <plat/fsmc.h>
 #include <plat/smi.h>
+#include <plat/spi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
 	&spear13xx_gpio_device[0],
 	&spear13xx_gpio_device[1],
+	&spear13xx_ssp_device,
 	&spear13xx_uart_device,
 };
 
@@ -50,6 +55,14 @@ static struct kbd_platform_data kbd_data = {
 	.rep = 1,
 };
 
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
 #ifdef CONFIG_PCIEPORTBUS
 /* this function is needed for PCIE host and device driver. Same
  * controller can not be programmed as host as well as device. So host
@@ -107,6 +120,8 @@ static void __init spear1300_evb_init(void)
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
 }
 
 MACHINE_START(SPEAR1300, "ST-SPEAR1300-EVB")
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 25a1964..6455ebb 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
@@ -64,6 +65,36 @@ struct amba_device spear13xx_gpio_device[] = {
 	}
 };
 
+/* ssp device registeration */
+static struct pl022_ssp_controller ssp_platform_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	/*
+	 * This is number of spi devices that can be connected to spi. There are
+	 * two type of chipselects on which slave devices can work. One is chip
+	 * select provided by spi masters other is controlled through external
+	 * gpio's. We can't use chipselect provided from spi master (because as
+	 * soon as FIFO becomes empty, CS is disabled and transfer ends). So
+	 * this number now depends on number of gpios available for spi. each
+	 * slave on each master requires a separate gpio pin.
+	 */
+	.num_chipselect = 2,
+};
+
+struct amba_device spear13xx_ssp_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.init_name = "ssp-pl022",
+		.platform_data = &ssp_platform_data,
+	},
+	.res = {
+		.start = SPEAR13XX_SSP_BASE,
+		.end = SPEAR13XX_SSP_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_SSP, NO_IRQ},
+};
+
 /* uart device registeration */
 struct amba_device spear13xx_uart_device = {
 	.dev = {
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 6aac229..04ce8700 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -32,6 +32,7 @@
 
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device gpio_device;
+extern struct amba_device ssp0_device;
 extern struct amba_device uart_device;
 extern struct amba_device wdt_device;
 extern struct platform_device ehci_device;
@@ -176,6 +177,7 @@ void __init spear310_init(void);
 #elif defined(CONFIG_MACH_SPEAR320)
 /* Add spear320 machine device structure declarations here */
 extern struct amba_device clcd_device;
+extern struct amba_device ssp_device[];
 extern struct platform_device i2c1_device;
 extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 41ad013..c702cc3 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -15,11 +15,15 @@
 #include <mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <mach/generic.h>
+#include <mach/gpio.h>
 #include <mach/spear.h>
 #include <plat/fsmc.h>
 #include <plat/keyboard.h>
 #include <plat/smi.h>
+#include <plat/spi.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -40,6 +44,7 @@ static struct pmx_dev *pmx_devs[] = {
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
+	&ssp0_device,
 	&uart_device,
 	&wdt_device,
 
@@ -71,6 +76,29 @@ static struct kbd_platform_data kbd_data = {
 	.rep = 1,
 };
 
+/* spi board information */
+/* spi0 flash Chip Select Control function, controlled by gpio pin mentioned */
+DECLARE_SPI_CS_CONTROL(0, flash, RAS_GPIO_3);
+/* spi0 flash Chip Info structure */
+DECLARE_SPI_CHIP_INFO(0, flash, spi0_flash_cs_control);
+
+static struct spi_board_info __initdata spi_board_info[] = {
+	/* spi0 board info */
+	{
+		.modalias = "m25p80",
+		.controller_data = &spi0_flash_chip_info,
+		.max_speed_hz = 400000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.mode = 0,
+	}
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
 static void __init spear300_evb_init(void)
 {
 	unsigned int i;
@@ -102,6 +130,8 @@ static void __init spear300_evb_init(void)
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
 }
 
 MACHINE_START(SPEAR300, "ST-SPEAR300-EVB")
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 857afae..bff90b3 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -15,10 +15,14 @@
 #include <mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <mach/generic.h>
+#include <mach/gpio.h>
 #include <mach/spear.h>
 #include <plat/fsmc.h>
 #include <plat/smi.h>
+#include <plat/spi.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -47,6 +51,7 @@ static struct pmx_dev *pmx_devs[] = {
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
+	&ssp0_device,
 	&uart_device,
 	&wdt_device,
 
@@ -67,6 +72,41 @@ static struct platform_device *plat_devs[] __initdata = {
 	&plgpio_device,
 };
 
+/* spi board information */
+/* spi0 flash Chip Select Control function, controlled by gpio pin mentioned */
+DECLARE_SPI_CS_CONTROL(0, flash, BASIC_GPIO_3);
+/* spi0 flash Chip Info structure */
+DECLARE_SPI_CHIP_INFO(0, flash, spi0_flash_cs_control);
+
+/* spi0 spidev Chip Select Control function, controlled by gpio pin mentioned */
+DECLARE_SPI_CS_CONTROL(0, dev, BASIC_GPIO_4);
+/* spi0 spidev Chip Info structure */
+DECLARE_SPI_CHIP_INFO(0, dev, spi0_dev_cs_control);
+
+static struct spi_board_info __initdata spi_board_info[] = {
+	/* spi0 board info */
+	{
+		.modalias = "spidev",
+		.controller_data = &spi0_dev_chip_info,
+		.max_speed_hz = 10000000,
+		.bus_num = 0,
+		.chip_select = 0,
+		.mode = 0,
+	}, {
+		.modalias = "m25p80",
+		.controller_data = &spi0_flash_chip_info,
+		.max_speed_hz = 400000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.mode = 0,
+	}
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
 static void __init spear310_evb_init(void)
 {
 	unsigned int i;
@@ -95,6 +135,8 @@ static void __init spear310_evb_init(void)
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
 }
 
 MACHINE_START(SPEAR310, "ST-SPEAR310-EVB")
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 3def755..f87cc97 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/amba/pl022.h>
 #include <linux/ptrace.h>
 #include <mtd/fsmc.h>
 #include <asm/irq.h>
@@ -403,6 +404,47 @@ struct amba_device clcd_device = {
 	.irq = {VIRQ_CLCD, NO_IRQ},
 };
 
+/* ssp device registeration */
+static struct pl022_ssp_controller ssp_platform_data[] = {
+	{
+		.bus_id = 1,
+		.enable_dma = 0,
+		.num_chipselect = 2,
+	}, {
+		.bus_id = 2,
+		.enable_dma = 0,
+		.num_chipselect = 2,
+	}
+};
+
+struct amba_device ssp_device[] = {
+	{
+		.dev = {
+			.coherent_dma_mask = ~0,
+			.init_name = "ssp-pl022.1",
+			.platform_data = &ssp_platform_data[0],
+		},
+		.res = {
+			.start = SPEAR320_SSP0_BASE,
+			.end = SPEAR320_SSP0_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {VIRQ_SSP1, NO_IRQ},
+	}, {
+		.dev = {
+			.coherent_dma_mask = ~0,
+			.init_name = "ssp-pl022.2",
+			.platform_data = &ssp_platform_data[1],
+		},
+		.res = {
+			.start = SPEAR320_SSP1_BASE,
+			.end = SPEAR320_SSP1_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {VIRQ_SSP2, NO_IRQ},
+	}
+};
+
 /* plgpio device registeration */
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 3a066bb..dcca84e 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -15,10 +15,14 @@
 #include <mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <mach/generic.h>
+#include <mach/gpio.h>
 #include <mach/spear.h>
 #include <plat/fsmc.h>
 #include <plat/smi.h>
+#include <plat/spi.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -67,6 +71,14 @@ static struct platform_device *plat_devs[] __initdata = {
 	&pwm_device,
 };
 
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
 static void __init spear320_evb_init(void)
 {
 	unsigned int i;
@@ -95,6 +107,8 @@ static void __init spear320_evb_init(void)
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
 }
 
 MACHINE_START(SPEAR320, "ST-SPEAR320-EVB")
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 88a6bd4..b4c3ad7 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
@@ -41,6 +42,36 @@ struct amba_device gpio_device = {
 	.irq = {IRQ_BASIC_GPIO, NO_IRQ},
 };
 
+/* ssp device registeration */
+static struct pl022_ssp_controller ssp_platform_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	/*
+	 * This is number of spi devices that can be connected to spi. There are
+	 * two type of chipselects on which slave devices can work. One is chip
+	 * select provided by spi masters other is controlled through external
+	 * gpio's. We can't use chipselect provided from spi master (because as
+	 * soon as FIFO becomes empty, CS is disabled and transfer ends). So
+	 * this number now depends on number of gpios available for spi. each
+	 * slave on each master requires a separate gpio pin.
+	 */
+	.num_chipselect = 2,
+};
+
+struct amba_device ssp0_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.init_name = "ssp-pl022.0",
+		.platform_data = &ssp_platform_data,
+	},
+	.res = {
+		.start = SPEAR3XX_ICM1_SSP_BASE,
+		.end = SPEAR3XX_ICM1_SSP_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_SSP, NO_IRQ},
+};
+
 /* uart device registeration */
 struct amba_device uart_device = {
 	.dev = {
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index ff90419..dd29298 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -31,6 +31,7 @@
 /* Add spear6xx family device structure declarations here */
 extern struct amba_device clcd_device;
 extern struct amba_device gpio_device[];
+extern struct amba_device ssp_device[];
 extern struct amba_device uart_device[];
 extern struct amba_device wdt_device;
 extern struct platform_device ehci0_device;
diff --git a/arch/arm/mach-spear6xx/include/mach/spear.h b/arch/arm/mach-spear6xx/include/mach/spear.h
index a835f5b..31486e5 100644
--- a/arch/arm/mach-spear6xx/include/mach/spear.h
+++ b/arch/arm/mach-spear6xx/include/mach/spear.h
@@ -68,8 +68,8 @@
 #define SPEAR6XX_ICM2_GPIO_BASE		0xD8100000
 #define SPEAR6XX_ICM2_GPIO_SIZE		0x00080000
 
-#define SPEAR6XX_ICM2_SPI2_BASE		0xD8180000
-#define SPEAR6XX_ICM2_SPI2_SIZE		0x00080000
+#define SPEAR6XX_ICM2_SSP2_BASE		0xD8180000
+#define SPEAR6XX_ICM2_SSP2_SIZE		0x00080000
 
 #define SPEAR6XX_ICM2_ADC_BASE		0xD8200000
 #define SPEAR6XX_ICM2_ADC_SIZE		0x00080000
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index f3b1fb4..a98d7d6 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -15,16 +15,24 @@
 #include <mtd/fsmc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/gpio.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <mach/generic.h>
+#include <mach/gpio.h>
 #include <mach/spear.h>
 #include <plat/fsmc.h>
 #include <plat/smi.h>
+#include <plat/spi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
 	&clcd_device,
 	&gpio_device[0],
 	&gpio_device[1],
 	&gpio_device[2],
+	&ssp_device[0],
+	&ssp_device[1],
+	&ssp_device[2],
 	&uart_device[0],
 	&uart_device[1],
 	&wdt_device,
@@ -41,6 +49,14 @@ static struct platform_device *plat_devs[] __initdata = {
 	&smi_device,
 };
 
+static struct spi_board_info __initdata spi_board_info[] = {
+};
+
+static void __init spi_init(void)
+{
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
 static void __init spear600_evb_init(void)
 {
 	unsigned int i;
@@ -64,6 +80,8 @@ static void __init spear600_evb_init(void)
 	/* Add Amba Devices */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_init();
 }
 
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index cc4fd39..82788e1 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
@@ -41,6 +42,73 @@ struct amba_device clcd_device = {
 	.irq = {IRQ_BASIC_CLCD, NO_IRQ},
 };
 
+/* ssp device registeration */
+static struct pl022_ssp_controller ssp_platform_data[] = {
+	{
+		.bus_id = 0,
+		.enable_dma = 0,
+		/*
+		 * This is number of spi devices that can be connected to spi.
+		 * There are two type of chipselects on which slave devices can
+		 * work. One is chip select provided by spi masters other is
+		 * controlled through external gpio's. We can't use chipselect
+		 * provided from spi master (because as soon as FIFO becomes
+		 * empty, CS is disabled and transfer ends). So this number now
+		 * depends on number of gpios available for spi. each slave on
+		 * each master requires a separate gpio pin.
+		 */
+		.num_chipselect = 2,
+	}, {
+		.bus_id = 1,
+		.enable_dma = 0,
+		.num_chipselect = 2,
+	}, {
+		.bus_id = 2,
+		.enable_dma = 0,
+		.num_chipselect = 2,
+	}
+};
+
+struct amba_device ssp_device[] = {
+	{
+		.dev = {
+			.coherent_dma_mask = ~0,
+			.init_name = "ssp-pl022.0",
+			.platform_data = &ssp_platform_data[0],
+		},
+		.res = {
+			.start = SPEAR6XX_ICM1_SSP0_BASE,
+			.end = SPEAR6XX_ICM1_SSP0_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_SSP_1, NO_IRQ},
+	}, {
+		.dev = {
+			.coherent_dma_mask = ~0,
+			.init_name = "ssp-pl022.1",
+			.platform_data = &ssp_platform_data[1],
+		},
+		.res = {
+			.start = SPEAR6XX_ICM1_SSP1_BASE,
+			.end = SPEAR6XX_ICM1_SSP1_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_SSP_2, NO_IRQ},
+	}, {
+		.dev = {
+			.coherent_dma_mask = ~0,
+			.init_name = "ssp-pl022.2",
+			.platform_data = &ssp_platform_data[2],
+		},
+		.res = {
+			.start = SPEAR6XX_ICM2_SSP2_BASE,
+			.end = SPEAR6XX_ICM2_SSP2_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_APPL_SSP, NO_IRQ},
+	}
+};
+
 /* uart device registeration */
 struct amba_device uart_device[] = {
 	{
diff --git a/arch/arm/plat-spear/include/plat/spi.h b/arch/arm/plat-spear/include/plat/spi.h
new file mode 100644
index 0000000..a2c53f3
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/spi.h
@@ -0,0 +1,77 @@
+/*
+ * arch/arm/plat-spear/include/plat/spi.h
+ *
+ * SPI board specific definitions common to multiple boards on multiple
+ * machines.
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Viresh Kumar<viresh.kumar-qxv4g6HH51o@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_SPI_H
+#define __PLAT_SPI_H
+
+#include <linux/amba/pl022.h>
+#include <linux/gpio.h>
+
+/* spi board information */
+static inline int spi_cs_gpio_request(u32 gpio_pin)
+{
+	int ret;
+
+	ret = gpio_request(gpio_pin, "SPI_CS");
+	if (ret < 0) {
+		printk(KERN_ERR "SPI: gpio:%d request fail\n", gpio_pin);
+		return ret;
+	} else {
+		ret = gpio_direction_output(gpio_pin, 1);
+		if (ret) {
+			printk(KERN_ERR "SPI: gpio:%d direction set fail\n",
+					gpio_pin);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+/* This will define cs_control function for a specific spi slave */
+#define DECLARE_SPI_CS_CONTROL(id, type, gpio)		\
+static void spi##id##_##type##_cs_control(u32 control)	\
+{							\
+	static int count, ret;				\
+							\
+	if (unlikely(!count)) {				\
+		count++;				\
+		ret = spi_cs_gpio_request(gpio);	\
+	}						\
+							\
+	if (!ret)					\
+		gpio_set_value(gpio, control);		\
+}
+
+/* This will define CHIP_INFO structure for a specific spi slave */
+#define DECLARE_SPI_CHIP_INFO(id, type, chip_select_control)	\
+struct pl022_config_chip spi##id##_##type##_chip_info = {	\
+	.lbm = LOOPBACK_DISABLED,			\
+	.iface = SSP_INTERFACE_MOTOROLA_SPI,		\
+	.hierarchy = SSP_MASTER,			\
+	.slave_tx_disable = 0,				\
+	.endian_tx = SSP_TX_LSB,			\
+	.endian_rx = SSP_RX_LSB,			\
+	.data_size = SSP_DATA_BITS_8,			\
+	.com_mode = INTERRUPT_TRANSFER,			\
+	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,		\
+	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,	\
+	.clk_phase = SSP_CLK_SECOND_EDGE,		\
+	.clk_pol = SSP_CLK_POL_IDLE_LOW,		\
+	.cs_control = chip_select_control,		\
+};
+
+#define DECLARE_SPI_CHIP_INFO_NULL_ID(chip_select_control)	\
+DECLARE_SPI_CHIP_INFO(, chip_select_control)
+
+#endif /* __PLAT_SPI_H */
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
