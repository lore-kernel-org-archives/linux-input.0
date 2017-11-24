From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5] ARM: imx: Give all GPIO chips a unique name
Date: Fri, 24 Nov 2017 10:30:44 +0100
Message-ID: <20171124093045.5961-5-linus.walleij@linaro.org>
References: <20171124093045.5961-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43072 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752897AbdKXJa5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Nov 2017 04:30:57 -0500
Received: by mail-lf0-f67.google.com with SMTP id 73so24709412lfu.10
        for <linux-input@vger.kernel.org>; Fri, 24 Nov 2017 01:30:56 -0800 (PST)
In-Reply-To: <20171124093045.5961-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

The name/label of the GPIO chips is used in GPIO lookup tables
so these need to be unique per chip. Suffix each GPIO chip with
an instance number so these lookups will work as expected.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-imx/mm-imx21.c | 12 ++++++------
 arch/arm/mach-imx/mm-imx27.c | 12 ++++++------
 arch/arm/mach-imx/mm-imx3.c  | 12 ++++++------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 2e91ab2ca378..9e7ec6f17d01 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -84,12 +84,12 @@ void __init imx21_soc_init(void)
 	mxc_arch_reset_init(MX21_IO_ADDRESS(MX21_WDOG_BASE_ADDR));
 	mxc_device_init();
 
-	mxc_register_gpio("imx21-gpio", 0, MX21_GPIO1_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 1, MX21_GPIO2_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 2, MX21_GPIO3_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 3, MX21_GPIO4_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 4, MX21_GPIO5_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 5, MX21_GPIO6_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-0", 0, MX21_GPIO1_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-1", 1, MX21_GPIO2_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-2", 2, MX21_GPIO3_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-3", 3, MX21_GPIO4_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-4", 4, MX21_GPIO5_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-5", 5, MX21_GPIO6_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
 
 	pinctrl_provide_dummies();
 	imx_add_imx_dma("imx21-dma", MX21_DMA_BASE_ADDR,
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 862b9b7762c7..e2eb5dec659e 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -85,12 +85,12 @@ void __init imx27_soc_init(void)
 	mxc_device_init();
 
 	/* i.mx27 has the i.mx21 type gpio */
-	mxc_register_gpio("imx21-gpio", 0, MX27_GPIO1_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 1, MX27_GPIO2_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 2, MX27_GPIO3_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 3, MX27_GPIO4_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 4, MX27_GPIO5_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 5, MX27_GPIO6_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-0", 0, MX27_GPIO1_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-1", 1, MX27_GPIO2_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-2", 2, MX27_GPIO3_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-3", 3, MX27_GPIO4_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-4", 4, MX27_GPIO5_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio-5", 5, MX27_GPIO6_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
 
 	pinctrl_provide_dummies();
 	imx_add_imx_dma("imx27-dma", MX27_DMA_BASE_ADDR,
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 7638a35b3b36..9568300f7554 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -188,9 +188,9 @@ void __init imx31_soc_init(void)
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
 	mxc_device_init();
 
-	mxc_register_gpio("imx31-gpio", 0, MX31_GPIO1_BASE_ADDR, SZ_16K, MX31_INT_GPIO1, 0);
-	mxc_register_gpio("imx31-gpio", 1, MX31_GPIO2_BASE_ADDR, SZ_16K, MX31_INT_GPIO2, 0);
-	mxc_register_gpio("imx31-gpio", 2, MX31_GPIO3_BASE_ADDR, SZ_16K, MX31_INT_GPIO3, 0);
+	mxc_register_gpio("imx31-gpio-0", 0, MX31_GPIO1_BASE_ADDR, SZ_16K, MX31_INT_GPIO1, 0);
+	mxc_register_gpio("imx31-gpio-1", 1, MX31_GPIO2_BASE_ADDR, SZ_16K, MX31_INT_GPIO2, 0);
+	mxc_register_gpio("imx31-gpio-2", 2, MX31_GPIO3_BASE_ADDR, SZ_16K, MX31_INT_GPIO3, 0);
 
 	pinctrl_provide_dummies();
 
@@ -298,9 +298,9 @@ void __init imx35_soc_init(void)
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
 	mxc_device_init();
 
-	mxc_register_gpio("imx35-gpio", 0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
-	mxc_register_gpio("imx35-gpio", 1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
-	mxc_register_gpio("imx35-gpio", 2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
+	mxc_register_gpio("imx35-gpio-0", 0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
+	mxc_register_gpio("imx35-gpio-1", 1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
+	mxc_register_gpio("imx35-gpio-2", 2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
 
 	pinctrl_provide_dummies();
 	if (to_version == 1) {
-- 
2.14.3

