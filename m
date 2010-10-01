From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 33/69] ST SPEAr: Changing resource size of amba devices to SZ_4K
Date: Fri,  1 Oct 2010 17:25:53 +0530
Message-ID: <1243c267fb4511427b22adaf6824d9cad25d3b36.1285933332.git.viresh.kumar@st.com>
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
---
 arch/arm/mach-spear3xx/spear300.c |    2 +-
 arch/arm/mach-spear3xx/spear320.c |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c |    8 +++-----
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index fd83f53..c299e52 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -382,7 +382,7 @@ struct amba_device clcd_device = {
 	},
 	.res = {
 		.start = SPEAR300_CLCD_BASE,
-		.end = SPEAR300_CLCD_BASE + SPEAR300_CLCD_SIZE - 1,
+		.end = SPEAR300_CLCD_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.dma_mask = ~0,
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index e14e201..c228286 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -399,7 +399,7 @@ struct amba_device clcd_device = {
 	},
 	.res = {
 		.start = SPEAR320_CLCD_BASE,
-		.end = SPEAR320_CLCD_BASE + SPEAR320_CLCD_SIZE - 1,
+		.end = SPEAR320_CLCD_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.dma_mask = ~0,
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index b4c3ad7..34d8286 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -79,7 +79,7 @@ struct amba_device uart_device = {
 	},
 	.res = {
 		.start = SPEAR3XX_ICM1_UART_BASE,
-		.end = SPEAR3XX_ICM1_UART_BASE + SPEAR3XX_ICM1_UART_SIZE - 1,
+		.end = SPEAR3XX_ICM1_UART_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.irq = {IRQ_UART, NO_IRQ},
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 82788e1..e64fc57 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -35,7 +35,7 @@ struct amba_device clcd_device = {
 	},
 	.res = {
 		.start = SPEAR6XX_ICM3_CLCD_BASE,
-		.end = SPEAR6XX_ICM3_CLCD_BASE + SPEAR6XX_ICM3_CLCD_SIZE - 1,
+		.end = SPEAR6XX_ICM3_CLCD_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.dma_mask = ~0,
@@ -117,8 +117,7 @@ struct amba_device uart_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_ICM1_UART0_BASE,
-			.end = SPEAR6XX_ICM1_UART0_BASE +
-				SPEAR6XX_ICM1_UART0_SIZE - 1,
+			.end = SPEAR6XX_ICM1_UART0_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_UART_0, NO_IRQ},
@@ -128,8 +127,7 @@ struct amba_device uart_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_ICM1_UART1_BASE,
-			.end = SPEAR6XX_ICM1_UART1_BASE +
-				SPEAR6XX_ICM1_UART1_SIZE - 1,
+			.end = SPEAR6XX_ICM1_UART1_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_UART_1, NO_IRQ},
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
