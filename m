From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 36/69] ST SPEAr: Adding miscellaneous devices
Date: Fri,  1 Oct 2010 17:25:56 +0530
Message-ID: <f230f323b2dc881014ae3e5759f3424af7c8aa75.1285933332.git.viresh.kumar@st.com>
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
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    7 ++
 arch/arm/mach-spear3xx/spear310.c             |  115 +++++++++++++++++++------
 arch/arm/mach-spear3xx/spear320.c             |   26 ++++++
 3 files changed, 123 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 9bd9424..ea170a6 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -161,6 +161,11 @@ extern struct clcd_board clcd_plat_data;
 /* spear310 declarations */
 #elif defined(CONFIG_MACH_SPEAR310)
 /* Add spear310 machine device structure declarations here */
+extern struct amba_device uart1_device;
+extern struct amba_device uart2_device;
+extern struct amba_device uart3_device;
+extern struct amba_device uart4_device;
+extern struct amba_device uart5_device;
 extern struct platform_device plgpio_device;
 extern struct platform_device nand_device;
 
@@ -182,6 +187,8 @@ void __init spear310_init(void);
 /* Add spear320 machine device structure declarations here */
 extern struct amba_device clcd_device;
 extern struct amba_device ssp_device[];
+extern struct amba_device uart1_device;
+extern struct amba_device uart2_device;
 extern struct platform_device i2c1_device;
 extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 189e3d4..25a0e94 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -142,6 +142,96 @@ struct pmx_driver pmx_driver = {
 };
 
 /* Add spear310 specific devices here */
+/* uart1 device registeration */
+struct amba_device uart1_device = {
+	.dev = {
+		.init_name = "uart1",
+	},
+	.res = {
+		.start = SPEAR310_UART1_BASE,
+		.end = SPEAR310_UART1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART1, NO_IRQ},
+};
+
+/* uart2 device registeration */
+struct amba_device uart2_device = {
+	.dev = {
+		.init_name = "uart2",
+	},
+	.res = {
+		.start = SPEAR310_UART2_BASE,
+		.end = SPEAR310_UART2_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART2, NO_IRQ},
+};
+
+/* uart3 device registeration */
+struct amba_device uart3_device = {
+	.dev = {
+		.init_name = "uart3",
+	},
+	.res = {
+		.start = SPEAR310_UART3_BASE,
+		.end = SPEAR310_UART3_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART3, NO_IRQ},
+};
+
+/* uart4 device registeration */
+struct amba_device uart4_device = {
+	.dev = {
+		.init_name = "uart4",
+	},
+	.res = {
+		.start = SPEAR310_UART4_BASE,
+		.end = SPEAR310_UART4_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART4, NO_IRQ},
+};
+
+/* uart5 device registeration */
+struct amba_device uart5_device = {
+	.dev = {
+		.init_name = "uart5",
+	},
+	.res = {
+		.start = SPEAR310_UART5_BASE,
+		.end = SPEAR310_UART5_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART5, NO_IRQ},
+};
+
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
 /* plgpio device registeration */
 /*
  * pin to offset and offset to pin converter functions
@@ -178,31 +268,6 @@ int spear300_o2p(int offset)
 		return offset + 2;
 }
 
-/* nand device registeration */
-static struct fsmc_nand_platform_data nand_platform_data;
-
-static struct resource nand_resources[] = {
-	{
-		.name = "nand_data",
-		.start = SPEAR310_NAND_BASE,
-		.end = SPEAR310_NAND_BASE + SZ_16 - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.name = "fsmc_regs",
-		.start = SPEAR310_FSMC_BASE,
-		.end = SPEAR310_FSMC_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device nand_device = {
-	.name = "nand",
-	.id = -1,
-	.resource = nand_resources,
-	.num_resources = ARRAY_SIZE(nand_resources),
-	.dev.platform_data = &nand_platform_data,
-};
-
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
 	.irq_base = SPEAR_PLGPIO_INT_BASE,
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 3f1c88b..8ecad40 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -447,6 +447,32 @@ struct amba_device ssp_device[] = {
 	}
 };
 
+/* uart1 device registeration */
+struct amba_device uart1_device = {
+	.dev = {
+		.init_name = "uart1",
+	},
+	.res = {
+		.start = SPEAR320_UART1_BASE,
+		.end = SPEAR320_UART1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART1, NO_IRQ},
+};
+
+/* uart2 device registeration */
+struct amba_device uart2_device = {
+	.dev = {
+		.init_name = "uart2",
+	},
+	.res = {
+		.start = SPEAR320_UART2_BASE,
+		.end = SPEAR320_UART2_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART2, NO_IRQ},
+};
+
 /* plgpio device registeration */
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
