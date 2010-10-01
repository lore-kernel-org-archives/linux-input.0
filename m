From: Viresh KUMAR <viresh.kumar@st.com>
Subject: [PATCH V2 27/69] ST SPEAr: Adding Watchdog support
Date: Fri,  1 Oct 2010 17:25:47 +0530
Message-ID: <f6ad85aed3e22835920ff6bb4461ee082611d0c4.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:42298 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755634Ab0JAL6B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 07:58:01 -0400
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com, a.zummo@towertech.it, dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry
Cc: Viresh Kumar <viresh.kumar@st.com>, shiraz.hashim@st.com, vipin.kumar@st.com, deepak.sikri@st.com, armando.visconti@st.com, vipulkumar.samar@st.com, rajeev-dlh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear3xx/spear300_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear310_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear3xx.c             |   12 ++++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c         |    1 +
 arch/arm/mach-spear6xx/spear6xx.c             |   12 ++++++++++++
 8 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 9317af8..91c0c09 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -33,6 +33,7 @@
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device gpio_device;
 extern struct amba_device uart_device;
+extern struct amba_device wdt_device;
 extern struct platform_device ehci_device;
 extern struct platform_device i2c_device;
 extern struct platform_device ohci0_device;
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index c948289..7bd8963 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -38,6 +38,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
 	&uart_device,
+	&wdt_device,
 
 	/* spear300 specific devices */
 	&clcd_device,
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 2a88cd2..cd076c9 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -45,6 +45,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
 	&uart_device,
+	&wdt_device,
 
 	/* spear310 specific devices */
 };
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index d0cfd96..7f7b5dd 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -42,6 +42,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
 	&uart_device,
+	&wdt_device,
 
 	/* spear320 specific devices */
 	&clcd_device,
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index ff9f6e9..88a6bd4 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -54,6 +54,18 @@ struct amba_device uart_device = {
 	.irq = {IRQ_UART, NO_IRQ},
 };
 
+/* watchdog device registeration */
+struct amba_device wdt_device = {
+	.dev = {
+		.init_name = "wdt",
+	},
+	.res = {
+		.start = SPEAR3XX_ICM3_WDT_BASE,
+		.end = SPEAR3XX_ICM3_WDT_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
 /* i2c device registeration */
 static struct resource i2c_resources[] = {
 	{
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 8aee3ad..f885898 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -32,6 +32,7 @@
 extern struct amba_device clcd_device;
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
+extern struct amba_device wdt_device;
 extern struct platform_device ehci0_device;
 extern struct platform_device ehci1_device;
 extern struct platform_device i2c_device;
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index bd4be34..0eb5f50 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -24,6 +24,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	&gpio_device[2],
 	&uart_device[0],
 	&uart_device[1],
+	&wdt_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 000b3a8..2eec8ac 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -118,6 +118,18 @@ struct amba_device gpio_device[] = {
 	}
 };
 
+/* watchdog device registeration */
+struct amba_device wdt_device = {
+	.dev = {
+		.init_name = "wdt",
+	},
+	.res = {
+		.start = SPEAR6XX_ICM3_WDT_BASE,
+		.end = SPEAR6XX_ICM3_WDT_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
 /* i2c device registeration */
 static struct resource i2c_resources[] = {
 	{
-- 
1.7.2.2

