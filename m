From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 32/69] ST SPEAr: Adding support for SDHCI (SDIO)
Date: Fri,  1 Oct 2010 17:25:52 +0530
Message-ID: <df88865302536cd3d2f9defaaf00f178633fd96b.1285933332.git.viresh.kumar@st.com>
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
Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |    1 +
 arch/arm/mach-spear13xx/spear13xx.c            |   34 +++++++++++++-
 arch/arm/mach-spear3xx/include/mach/generic.h  |   13 ++++--
 arch/arm/mach-spear3xx/include/mach/irqs.h     |    4 +-
 arch/arm/mach-spear3xx/include/mach/spear300.h |    4 +-
 arch/arm/mach-spear3xx/include/mach/spear320.h |    6 +-
 arch/arm/mach-spear3xx/spear300.c              |   62 ++++++++++++++++++++----
 arch/arm/mach-spear3xx/spear300_evb.c          |   18 +++++++-
 arch/arm/mach-spear3xx/spear320.c              |   43 +++++++++++++----
 arch/arm/mach-spear3xx/spear320_evb.c          |   15 +++++-
 11 files changed, 167 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 7419e0b..bfd0667 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -40,6 +40,7 @@ extern struct platform_device spear13xx_nand_device;
 extern struct platform_device spear13xx_ohci0_device;
 extern struct platform_device spear13xx_ohci1_device;
 extern struct platform_device spear13xx_rtc_device;
+extern struct platform_device spear13xx_sdhci_device;
 extern struct platform_device spear13xx_smi_device;
 extern struct sys_timer spear13xx_timer;
 
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index ba46f61..269d9b0 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -43,6 +43,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
+	&spear13xx_sdhci_device,
 	&spear13xx_smi_device,
 };
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 6455ebb..b058c3b 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -349,6 +349,16 @@ struct platform_device spear13xx_smi_device = {
 	.resource = smi_resources,
 };
 
+static void sdhci_enable(void)
+{
+	unsigned val = readl(PERIP_CFG);
+
+	/* This function enables SD/MMC interface out of SD/MMC, CF, XD */
+	val &= ~(MCIF_SEL_MASK << MCIF_SEL_SHIFT);
+	val |= SD_MMC_ACTIVE << MCIF_SEL_SHIFT;
+	writel(val, PERIP_CFG);
+}
+
 #ifdef CONFIG_PCIEPORTBUS
 /* PCIE0 clock always needs to be enabled if any of the three PCIE port
  * have to be used. So call this function from the board initilization
@@ -377,10 +387,32 @@ int enable_pcie0_clk(void)
 }
 #endif
 
+/* sdhci (sdio) device declaration */
+static struct resource sdhci_resources[] = {
+	{
+		.start	= SPEAR13XX_MCIF_SDHCI_BASE,
+		.end	= SPEAR13XX_MCIF_SDHCI_BASE + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_SDHCI,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device spear13xx_sdhci_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.name = "sdhci",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(sdhci_resources),
+	.resource = sdhci_resources,
+};
+
 /* Do spear13xx familiy common initialization part here */
 void __init spear13xx_init(void)
 {
-	/* nothing to do for now */
+	sdhci_enable();
 }
 
 /* This will initialize vic */
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 04ce8700..9bd9424 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -116,6 +116,7 @@ extern struct platform_device nand0_device;
 extern struct platform_device nand1_device;
 extern struct platform_device nand2_device;
 extern struct platform_device nand3_device;
+extern struct platform_device sdhci_device;
 
 /* pad mux modes */
 extern struct pmx_mode nand_mode;
@@ -144,12 +145,15 @@ extern struct pmx_dev pmx_telecom_camera;
 extern struct pmx_dev pmx_telecom_dac;
 extern struct pmx_dev pmx_telecom_i2s;
 extern struct pmx_dev pmx_telecom_boot_pins;
-extern struct pmx_dev pmx_telecom_sdio_4bit;
-extern struct pmx_dev pmx_telecom_sdio_8bit;
+extern struct pmx_dev pmx_telecom_sdhci_4bit;
+extern struct pmx_dev pmx_telecom_sdhci_8bit;
 extern struct pmx_dev pmx_gpio1;
 
 /* Add spear300 machine function declarations here */
 void __init spear300_init(void);
+#define SDHCI_MEM_ENB	0x1
+#define I2S_MEM_ENB	0x2
+void sdhci_i2s_mem_enable(u8 mask);
 
 /* Add misc structure declarations here */
 extern struct clcd_board clcd_plat_data;
@@ -182,6 +186,7 @@ extern struct platform_device i2c1_device;
 extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
 extern struct platform_device pwm_device;
+extern struct platform_device sdhci_device;
 
 /* pad mux modes */
 extern struct pmx_mode auto_net_smii_mode;
@@ -194,14 +199,14 @@ extern struct pmx_dev pmx_clcd;
 extern struct pmx_dev pmx_emi;
 extern struct pmx_dev pmx_fsmc;
 extern struct pmx_dev pmx_spp;
-extern struct pmx_dev pmx_sdio;
+extern struct pmx_dev pmx_sdhci;
 extern struct pmx_dev pmx_i2s;
 extern struct pmx_dev pmx_uart1;
 extern struct pmx_dev pmx_uart1_modem;
 extern struct pmx_dev pmx_uart2;
 extern struct pmx_dev pmx_touchscreen;
 extern struct pmx_dev pmx_can;
-extern struct pmx_dev pmx_sdio_led;
+extern struct pmx_dev pmx_sdhci_led;
 extern struct pmx_dev pmx_pwm0;
 extern struct pmx_dev pmx_pwm1;
 extern struct pmx_dev pmx_pwm2;
diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
index 5ad7574..df0c1f3 100644
--- a/arch/arm/mach-spear3xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
@@ -69,7 +69,7 @@
 #define IRQ_CLCD				IRQ_GEN_RAS_3
 
 /* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
-#define IRQ_SDIO				IRQ_INTRCOMM_RAS_ARM
+#define IRQ_SDHCI				IRQ_INTRCOMM_RAS_ARM
 
 /* GPIO pins virtual irqs */
 #define SPEAR_GPIO_INT_BASE			(VIRQ_START + 9)
@@ -115,7 +115,7 @@
 #define VIRQ_SPP				(VIRQ_START + 2)
 
 /* IRQs sharing IRQ_GEN_RAS_2 */
-#define IRQ_SDIO				IRQ_GEN_RAS_2
+#define IRQ_SDHCI				IRQ_GEN_RAS_2
 
 /* IRQs sharing IRQ_GEN_RAS_3 */
 #define VIRQ_PLGPIO				(VIRQ_START + 3)
diff --git a/arch/arm/mach-spear3xx/include/mach/spear300.h b/arch/arm/mach-spear3xx/include/mach/spear300.h
index ccaa765..1059d5a 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear300.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear300.h
@@ -39,8 +39,8 @@
 #define SPEAR300_CLCD_BASE		0x60000000
 #define SPEAR300_CLCD_SIZE		0x10000000
 
-#define SPEAR300_SDIO_BASE		0x70000000
-#define SPEAR300_SDIO_SIZE		0x10000000
+#define SPEAR300_SDHCI_BASE		0x70000000
+#define SPEAR300_SDHCI_SIZE		0x10000000
 
 #define SPEAR300_NAND_0_BASE		0x80000000
 #define SPEAR300_NAND_0_SIZE		0x04000000
diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
index aa6727c..89f5bfb 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear320.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
@@ -28,8 +28,8 @@
 #define SPEAR320_I2S_BASE		0x60000000
 #define SPEAR320_I2S_SIZE		0x10000000
 
-#define SPEAR320_SDIO_BASE		0x70000000
-#define SPEAR320_SDIO_SIZE		0x10000000
+#define SPEAR320_SDHCI_BASE		0x70000000
+#define SPEAR320_SDHCI_SIZE		0x10000000
 
 #define SPEAR320_CLCD_BASE		0x90000000
 #define SPEAR320_CLCD_SIZE		0x10000000
@@ -77,7 +77,7 @@
 #define EMI_IRQ_MASK			(1 << 7)
 #define CLCD_IRQ_MASK			(1 << 8)
 #define SPP_IRQ_MASK			(1 << 9)
-#define SDIO_IRQ_MASK			(1 << 10)
+#define SDHCI_IRQ_MASK			(1 << 10)
 #define CAN_U_IRQ_MASK			(1 << 11)
 #define CAN_L_IRQ_MASK			(1 << 12)
 #define UART1_IRQ_MASK			(1 << 13)
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index c213614..fd83f53 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -311,7 +311,7 @@ struct pmx_dev pmx_telecom_boot_pins = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_sdio_4bit_modes[] = {
+struct pmx_dev_mode pmx_telecom_sdhci_4bit_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
 			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE |
@@ -324,14 +324,14 @@ struct pmx_dev_mode pmx_telecom_sdio_4bit_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_sdio_4bit = {
-	.name = "telecom_sdio_4bit",
-	.modes = pmx_telecom_sdio_4bit_modes,
-	.mode_count = ARRAY_SIZE(pmx_telecom_sdio_4bit_modes),
+struct pmx_dev pmx_telecom_sdhci_4bit = {
+	.name = "telecom_sdhci_4bit",
+	.modes = pmx_telecom_sdhci_4bit_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_sdhci_4bit_modes),
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_sdio_8bit_modes[] = {
+struct pmx_dev_mode pmx_telecom_sdhci_8bit_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
 			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE |
@@ -343,10 +343,10 @@ struct pmx_dev_mode pmx_telecom_sdio_8bit_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_sdio_8bit = {
-	.name = "telecom_sdio_8bit",
-	.modes = pmx_telecom_sdio_8bit_modes,
-	.mode_count = ARRAY_SIZE(pmx_telecom_sdio_8bit_modes),
+struct pmx_dev pmx_telecom_sdhci_8bit = {
+	.name = "telecom_sdhci_8bit",
+	.modes = pmx_telecom_sdhci_8bit_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_sdhci_8bit_modes),
 	.enb_on_reset = 1,
 };
 
@@ -524,6 +524,28 @@ struct platform_device nand3_device = {
 	.dev.platform_data = &nand3_platform_data,
 };
 
+/* sdhci (sdio) device declaration */
+static struct resource sdhci_resources[] = {
+	{
+		.start	= SPEAR300_SDHCI_BASE,
+		.end	= SPEAR300_SDHCI_BASE + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_SDHCI,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device sdhci_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.name = "sdhci",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(sdhci_resources),
+	.resource = sdhci_resources,
+};
+
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
@@ -577,6 +599,26 @@ struct spear_shirq shirq_ras1 = {
 	},
 };
 
+/* Function handling sdhci and i2s memory sharing */
+#define SDHCI_MEM_SELECT	0x20000000
+void sdhci_i2s_mem_enable(u8 mask)
+{
+	u32 val;
+	void __iomem *base = ioremap(SPEAR300_SOC_CONFIG_BASE,
+			SPEAR300_SOC_CONFIG_SIZE);
+	if (!base) {
+		pr_debug("sdhci_i2s_enb: ioremap fail\n");
+		return;
+	}
+
+	val = readl(base + MODE_CONFIG_REG);
+	if (mask == SDHCI_MEM_ENB)
+		val |= SDHCI_MEM_SELECT;
+	else
+		val &= ~SDHCI_MEM_SELECT;
+	writel(val, base + MODE_CONFIG_REG);
+}
+
 /* spear300 routines */
 void __init spear300_init(void)
 {
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index c702cc3..2bcb55f 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -17,6 +17,7 @@
 #include <asm/mach-types.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
+#include <linux/mmc/sdhci-spear.h>
 #include <mach/generic.h>
 #include <mach/gpio.h>
 #include <mach/spear.h>
@@ -37,7 +38,7 @@ static struct pmx_dev *pmx_devs[] = {
 	/* spear300 specific devices */
 	&pmx_fsmc_2_chips,
 	&pmx_clcd,
-	&pmx_telecom_sdio_4bit,
+	&pmx_telecom_sdhci_4bit,
 	&pmx_gpio1,
 };
 
@@ -65,6 +66,15 @@ static struct platform_device *plat_devs[] __initdata = {
 
 	/* spear300 specific devices */
 	&kbd_device,
+	&sdhci_device,
+};
+
+/* sdhci board specific information */
+static struct sdhci_plat_data sdhci_plat_data = {
+	.card_power_gpio = RAS_GPIO_2,
+	.power_active_high = 0,
+	.power_always_enb = 0,
+	.card_int_gpio = RAS_GPIO_0,
 };
 
 /* keyboard specific platform data */
@@ -115,6 +125,12 @@ static void __init spear300_evb_init(void)
 	fsmc_nand_set_plat_data(&nand0_device, NULL, 0, NAND_SKIP_BBTSCAN,
 			FSMC_NAND_BW8);
 
+	/* set sdhci device platform data */
+	sdhci_set_plat_data(&sdhci_device, &sdhci_plat_data);
+
+	/* Enable sdhci memory */
+	sdhci_i2s_mem_enable(SDHCI_MEM_ENB);
+
 	/* call spear300 machine init function */
 	spear300_init();
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index f87cc97..e14e201 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -13,6 +13,8 @@
 
 #include <linux/amba/pl022.h>
 #include <linux/ptrace.h>
+#include <linux/types.h>
+#include <linux/mmc/sdhci-spear.h>
 #include <mtd/fsmc.h>
 #include <asm/irq.h>
 #include <mach/generic.h>
@@ -113,7 +115,7 @@ struct pmx_dev pmx_spp = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_sdio_modes[] = {
+struct pmx_dev_mode pmx_sdhci_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE |
 			SMALL_PRINTERS_MODE,
@@ -121,10 +123,10 @@ struct pmx_dev_mode pmx_sdio_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_sdio = {
-	.name = "sdio",
-	.modes = pmx_sdio_modes,
-	.mode_count = ARRAY_SIZE(pmx_sdio_modes),
+struct pmx_dev pmx_sdhci = {
+	.name = "sdhci",
+	.modes = pmx_sdhci_modes,
+	.mode_count = ARRAY_SIZE(pmx_sdhci_modes),
 	.enb_on_reset = 1,
 };
 
@@ -218,17 +220,17 @@ struct pmx_dev pmx_can = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_sdio_led_modes[] = {
+struct pmx_dev_mode pmx_sdhci_led_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
 		.mask = PMX_SSP_CS_MASK,
 	},
 };
 
-struct pmx_dev pmx_sdio_led = {
-	.name = "sdio_led",
-	.modes = pmx_sdio_led_modes,
-	.mode_count = ARRAY_SIZE(pmx_sdio_led_modes),
+struct pmx_dev pmx_sdhci_led = {
+	.name = "sdhci_led",
+	.modes = pmx_sdhci_led_modes,
+	.mode_count = ARRAY_SIZE(pmx_sdhci_led_modes),
 	.enb_on_reset = 1,
 };
 
@@ -536,6 +538,27 @@ struct platform_device pwm_device = {
 	.resource = pwm_resources,
 };
 
+/* sdhci (sdio) device registeration */
+static struct resource sdhci_resources[] = {
+	{
+		.start	= SPEAR320_SDHCI_BASE,
+		.end	= SPEAR320_SDHCI_BASE + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_SDHCI,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device sdhci_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.name = "sdhci",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(sdhci_resources),
+	.resource = sdhci_resources,
+};
 
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index dcca84e..2142ad9 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -16,6 +16,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <linux/spi/flash.h>
+#include <linux/mmc/sdhci-spear.h>
 #include <linux/spi/spi.h>
 #include <mach/generic.h>
 #include <mach/gpio.h>
@@ -34,7 +35,7 @@ static struct pmx_dev *pmx_devs[] = {
 
 	/* spear320 specific devices */
 	&pmx_fsmc,
-	&pmx_sdio,
+	&pmx_sdhci,
 	&pmx_i2s,
 	&pmx_uart1,
 	&pmx_uart2,
@@ -69,6 +70,15 @@ static struct platform_device *plat_devs[] __initdata = {
 	&i2c1_device,
 	&plgpio_device,
 	&pwm_device,
+	&sdhci_device,
+};
+
+/* sdhci board specific information */
+static struct sdhci_plat_data sdhci_plat_data = {
+	.card_power_gpio = PLGPIO_61,
+	.power_active_high = 0,
+	.power_always_enb = 1,
+	.card_int_gpio = -1,
 };
 
 static struct spi_board_info __initdata spi_board_info[] = {
@@ -83,6 +93,9 @@ static void __init spear320_evb_init(void)
 {
 	unsigned int i;
 
+	/* set sdhci device platform data */
+	sdhci_set_plat_data(&sdhci_device, &sdhci_plat_data);
+
 	/* padmux initialization, must be done before spear320_init */
 	pmx_driver.mode = &auto_net_mii_mode;
 	pmx_driver.devs = pmx_devs;
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
