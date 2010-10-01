From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 23/69] ST SPEAr: Added ARM PL061 GPIO Support on SPEAr13xx and modified resource size
Date: Fri,  1 Oct 2010 17:25:43 +0530
Message-ID: <c33de42441410537175db463dbaff5652e3b1f7e.1285933331.git.viresh.kumar@st.com>
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
Signed-off-by: shiraz hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/include/mach/gpio.h    |   18 +++++++++++
 arch/arm/mach-spear13xx/include/mach/irqs.h    |   10 ++++++-
 arch/arm/mach-spear13xx/include/mach/spear.h   |    4 +-
 arch/arm/mach-spear13xx/spear1300_evb.c        |    2 +
 arch/arm/mach-spear13xx/spear13xx.c            |   37 ++++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear300.c              |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c              |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c              |    9 ++----
 9 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index fd9f9a6..f3e6d95 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -29,6 +29,7 @@
 #define SPEAR_GPT0_CHAN1_IRQ	IRQ_GPT0_TMR1
 
 /* Add spear13xx family device structure declarations here */
+extern struct amba_device spear13xx_gpio_device[];
 extern struct amba_device spear13xx_uart_device;
 extern struct platform_device spear13xx_ehci0_device;
 extern struct platform_device spear13xx_ehci1_device;
diff --git a/arch/arm/mach-spear13xx/include/mach/gpio.h b/arch/arm/mach-spear13xx/include/mach/gpio.h
index 43fa541..2f8ad23 100644
--- a/arch/arm/mach-spear13xx/include/mach/gpio.h
+++ b/arch/arm/mach-spear13xx/include/mach/gpio.h
@@ -16,4 +16,22 @@
 
 #include <plat/gpio.h>
 
+#define GPIO0_0			0
+#define GPIO0_1			1
+#define GPIO0_2			2
+#define GPIO0_3			3
+#define GPIO0_4			4
+#define GPIO0_5			5
+#define GPIO0_6			6
+#define GPIO0_7			7
+
+#define GPIO1_0			8
+#define GPIO1_1			9
+#define GPIO1_2			10
+#define GPIO1_3			11
+#define GPIO1_4			12
+#define GPIO1_5			13
+#define GPIO1_6			14
+#define GPIO1_7			15
+
 #endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
index 036bfc6..10b64c1 100644
--- a/arch/arm/mach-spear13xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -86,6 +86,14 @@
 
 #define IRQ_GIC_END		(IRQ_SHPI_START + 128)
 
-#define NR_IRQS			IRQ_GIC_END
+#define VIRQ_START		IRQ_GIC_END
+
+/* GPIO pins virtual irqs */
+#define SPEAR_GPIO0_INT_BASE	(VIRQ_START + 0)
+#define SPEAR_GPIO1_INT_BASE	(SPEAR_GPIO0_INT_BASE + 8)
+#define SPEAR_GPIO_INT_END	(SPEAR_GPIO1_INT_BASE + 8)
+
+#define VIRQ_END		SPEAR_GPIO_INT_END
+#define NR_IRQS			VIRQ_END
 
 #endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
index d4b11a4..282ef2f 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -43,8 +43,8 @@
 #define SPEAR13XX_GPT2_BASE		0xE0480000
 #define SPEAR13XX_GPT3_BASE		0xE0500000
 #define SPEAR13XX_RTC_BASE		0xE0580000
-#define SPEAR13XX_GPIOA_BASE		0xE0600000
-#define SPEAR13XX_GPIOB_BASE		0xE0680000
+#define SPEAR13XX_GPIO0_BASE		0xE0600000
+#define SPEAR13XX_GPIO1_BASE		0xE0680000
 #define SPEAR13XX_MISC_BASE		0xE0700000
 #define VA_SPEAR13XX_MISC_BASE		IO_ADDRESS(SPEAR13XX_MISC_BASE)
 
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 0c7c996..2b2598c 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -19,6 +19,8 @@
 #include <plat/keyboard.h>
 
 static struct amba_device *amba_devs[] __initdata = {
+	&spear13xx_gpio_device[0],
+	&spear13xx_gpio_device[1],
 	&spear13xx_uart_device,
 };
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index d19e325..2037cd2 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
 #include <asm/hardware/gic.h>
@@ -24,6 +25,42 @@
 #include <mach/hardware.h>
 
 /* Add spear13xx machines common devices here */
+/* gpio device registeration */
+static struct pl061_platform_data gpio_plat_data[] = {
+	{
+		.gpio_base	= 0,
+		.irq_base	= SPEAR_GPIO0_INT_BASE,
+	}, {
+		.gpio_base	= 8,
+		.irq_base	= SPEAR_GPIO1_INT_BASE,
+	},
+};
+
+struct amba_device spear13xx_gpio_device[] = {
+	{
+		.dev = {
+			.init_name = "gpio0",
+			.platform_data = &gpio_plat_data[0],
+		},
+		.res = {
+			.start = SPEAR13XX_GPIO0_BASE,
+			.end = SPEAR13XX_GPIO0_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_GPIO0, NO_IRQ},
+	}, {
+		.dev = {
+			.init_name = "gpio1",
+			.platform_data = &gpio_plat_data[1],
+		},
+		.res = {
+			.start = SPEAR13XX_GPIO1_BASE,
+			.end = SPEAR13XX_GPIO1_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_GPIO1, NO_IRQ},
+	}
+};
 
 /* uart device registeration */
 struct amba_device spear13xx_uart_device = {
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 44ba52e..c80d4e1 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -401,7 +401,7 @@ struct amba_device gpio1_device = {
 	},
 	.res = {
 		.start = SPEAR300_GPIO_BASE,
-		.end = SPEAR300_GPIO_BASE + SPEAR300_GPIO_SIZE - 1,
+		.end = SPEAR300_GPIO_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.irq = {VIRQ_GPIO1, NO_IRQ},
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 588004f..61d607b 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -35,7 +35,7 @@ struct amba_device gpio_device = {
 	},
 	.res = {
 		.start = SPEAR3XX_ICM3_GPIO_BASE,
-		.end = SPEAR3XX_ICM3_GPIO_BASE + SPEAR3XX_ICM3_GPIO_SIZE - 1,
+		.end = SPEAR3XX_ICM3_GPIO_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.irq = {IRQ_BASIC_GPIO, NO_IRQ},
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 94bbcdf..e78c2e5 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -89,8 +89,7 @@ struct amba_device gpio_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_CPU_GPIO_BASE,
-			.end = SPEAR6XX_CPU_GPIO_BASE +
-				SPEAR6XX_CPU_GPIO_SIZE - 1,
+			.end = SPEAR6XX_CPU_GPIO_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_LOCAL_GPIO, NO_IRQ},
@@ -101,8 +100,7 @@ struct amba_device gpio_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_ICM3_GPIO_BASE,
-			.end = SPEAR6XX_ICM3_GPIO_BASE +
-				SPEAR6XX_ICM3_GPIO_SIZE - 1,
+			.end = SPEAR6XX_ICM3_GPIO_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_BASIC_GPIO, NO_IRQ},
@@ -113,8 +111,7 @@ struct amba_device gpio_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_ICM2_GPIO_BASE,
-			.end = SPEAR6XX_ICM2_GPIO_BASE +
-				SPEAR6XX_ICM2_GPIO_SIZE - 1,
+			.end = SPEAR6XX_ICM2_GPIO_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_APPL_GPIO, NO_IRQ},
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
