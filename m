From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 38/69] ST SPEAr: Adding support for DDR in clock framework
Date: Fri,  1 Oct 2010 17:25:58 +0530
Message-ID: <d62d10bc768767f7ef0537328bdce43c273dd88e.1285933332.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
In-Reply-To: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
References: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, shiraz.hashim-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org
List-Id: linux-input@vger.kernel.org

Changing rate of clk, which is ancestor of DDR requires to put DDR in refresh
mode before changing parents rate. For this DDR support is added in clock
framework. Now at boot time all ancestors of DDR is marked specially and
changing their rate must be first acked by ddr (i.e. ddr will run on that
clock). This patch adds support for this.

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Signed-off-by: shiraz hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/mach-spear13xx/clock.c                  |   69 ++++++++---
 arch/arm/mach-spear13xx/include/mach/generic.h   |    2 +-
 arch/arm/mach-spear13xx/include/mach/misc_regs.h |    4 +
 arch/arm/mach-spear13xx/spear13xx.c              |    2 +-
 arch/arm/mach-spear3xx/clock.c                   |  105 ++++++++++++++----
 arch/arm/mach-spear3xx/include/mach/generic.h    |    2 +-
 arch/arm/mach-spear3xx/include/mach/misc_regs.h  |    7 +
 arch/arm/mach-spear3xx/spear3xx.c                |    2 +-
 arch/arm/mach-spear6xx/clock.c                   |  105 ++++++++++++++----
 arch/arm/mach-spear6xx/include/mach/generic.h    |    2 +-
 arch/arm/mach-spear6xx/include/mach/misc_regs.h  |    7 +
 arch/arm/mach-spear6xx/spear6xx.c                |    2 +-
 arch/arm/plat-spear/clock.c                      |  133 ++++++++++++++++++---
 arch/arm/plat-spear/include/plat/clock.h         |   42 +++++--
 14 files changed, 385 insertions(+), 99 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index ca80c46..4f320fa 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -23,19 +23,19 @@
 /* root clks */
 /* 24 MHz oscillator clock */
 static struct clk osc1_24m_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.rate = 24000000,
 };
 
 /* 32 KHz oscillator clock */
 static struct clk osc2_32k_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.rate = 32000,
 };
 
 /* 25 MHz MIPHY oscillator clock */
 static struct clk osc3_25m_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.rate = 25000000,
 };
 
@@ -99,7 +99,7 @@ struct pll_rate_tbl pll_rtbl[] = {
 
 /* pll1 clock */
 static struct clk pll1_clk = {
-	.flags = ENABLED_ON_INIT,
+	.flags = ENABLED_ON_INIT | SYSTEM_CLK,
 	.pclk_sel = &pll_pclk_sel,
 	.pclk_sel_shift = PLL1_CLK_SHIFT,
 	.en_reg = PLL1_CTR,
@@ -113,7 +113,7 @@ static struct clk pll1_clk = {
 
 /* pll1div2 clock */
 static struct clk pll1div2_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &pll1_clk,
 	.div_factor = 2,
 	.recalc = &follow_parent,
@@ -121,7 +121,7 @@ static struct clk pll1div2_clk = {
 
 /* pll1div4 clock */
 static struct clk pll1div4_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &pll1_clk,
 	.div_factor = 4,
 	.recalc = &follow_parent,
@@ -136,6 +136,7 @@ static struct pll_clk_config pll2_config = {
 
 /* pll2 clock */
 static struct clk pll2_clk = {
+	.flags = SYSTEM_CLK,
 	.pclk_sel = &pll_pclk_sel,
 	.pclk_sel_shift = PLL2_CLK_SHIFT,
 	.en_reg = PLL2_CTR,
@@ -156,6 +157,7 @@ static struct pll_clk_config pll3_config = {
 
 /* pll3 clock */
 static struct clk pll3_clk = {
+	.flags = SYSTEM_CLK,
 	.pclk_sel = &pll_pclk_sel,
 	.pclk_sel_shift = PLL3_CLK_SHIFT,
 	.en_reg = PLL3_CTR,
@@ -184,7 +186,7 @@ struct pll_rate_tbl pll4_rtbl[] = {
 
 /* pll4 (DDR) clock */
 static struct clk pll4_clk = {
-	.flags = ENABLED_ON_INIT,
+	.flags = ENABLED_ON_INIT | SYSTEM_CLK,
 	.pclk = &osc1_24m_clk,
 	.en_reg = PLL4_CTR,
 	.en_reg_bit = PLL_ENABLE,
@@ -197,22 +199,54 @@ static struct clk pll4_clk = {
 
 /* pll5 USB 48 MHz clock */
 static struct clk pll5_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &osc1_24m_clk,
 	.rate = 48000000,
 };
 
 /* pll6 (MIPHY) clock */
 static struct clk pll6_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &osc3_25m_clk,
 	.rate = 25000000,
 };
 
 /* clocks derived from pll1 clk */
+/* ddr clock */
+struct ddr_rate_tbl ddr_rate_tbl = {
+	.minrate = 332000000,
+	.maxrate = 500000000,
+};
+
+static struct pclk_info ddr_pclk_info[] = {
+	{
+		.pclk = &pll1_clk,
+		.pclk_val = MCTR_CLK_PLL1_VAL,
+	}, {
+		.pclk = &pll4_clk,
+		.pclk_val = MCTR_CLK_PLL4_VAL,
+	},
+};
+
+/* ddr parent select structure */
+static struct pclk_sel ddr_pclk_sel = {
+	.pclk_info = ddr_pclk_info,
+	.pclk_count = ARRAY_SIZE(ddr_pclk_info),
+	.pclk_sel_reg = PERIP_CLK_CFG,
+	.pclk_sel_mask = MCTR_CLK_MASK,
+};
+
+static struct clk ddr_clk = {
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
+	.recalc = &follow_parent,
+	.pclk_sel = &ddr_pclk_sel,
+	.pclk_sel_shift = MCTR_CLK_SHIFT,
+	.private_data = &ddr_rate_tbl,
+};
+
 /* cpu clock */
 static struct clk cpu_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &pll1_clk,
 	.div_factor = 2,
 	.recalc = &follow_parent,
@@ -220,7 +254,7 @@ static struct clk cpu_clk = {
 
 /* ahb clock */
 static struct clk ahb_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &pll1_clk,
 	.div_factor = 6,
 	.recalc = &follow_parent,
@@ -228,7 +262,7 @@ static struct clk ahb_clk = {
 
 /* apb clock */
 static struct clk apb_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &pll1_clk,
 	.div_factor = 12,
 	.recalc = &follow_parent,
@@ -845,6 +879,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{.con_id = "pll6_clk",		.clk = &pll6_clk},
 
 	/* clock derived from pll1 clk */
+	{.con_id = "ddr_clk",		.clk = &ddr_clk},
 	{.con_id = "cpu_clk",		.clk = &cpu_clk},
 	{.con_id = "ahb_clk",		.clk = &ahb_clk},
 	{.con_id = "apb_clk",		.clk = &apb_clk},
@@ -911,12 +946,8 @@ static struct clk_lookup spear_clk_lookups[] = {
 #endif
 };
 
-void __init clk_init(void)
+/* machine clk init */
+void __init spear13xx_clk_init(void)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
-		clk_register(&spear_clk_lookups[i]);
-
-	recalc_root_clocks();
+	clk_init(spear_clk_lookups, ARRAY_SIZE(spear_clk_lookups), &ddr_clk);
 }
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 83be1f2..cd54e62 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -45,7 +45,7 @@ extern struct platform_device spear13xx_smi_device;
 extern struct sys_timer spear13xx_timer;
 
 /* Add spear13xx family function declarations here */
-void __init clk_init(void);
+void __init spear13xx_clk_init(void);
 void __init i2c_register_board_devices(void);
 void __init spear_setup_timer(void);
 void __init spear13xx_map_io(void);
diff --git a/arch/arm/mach-spear13xx/include/mach/misc_regs.h b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
index a7ba6cb..3cfd4fc 100644
--- a/arch/arm/mach-spear13xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
@@ -98,6 +98,10 @@
 	#define CLCD_CLK_SHIFT		2
 	#define C3_CLK_MASK		1
 	#define C3_CLK_SHIFT		1
+	#define MCTR_CLK_SHIFT		10
+	#define MCTR_CLK_MASK		0x1
+	#define MCTR_CLK_PLL1_VAL	0x0
+	#define MCTR_CLK_PLL4_VAL	0x1
 
 #define GMAC_CLK_CFG		((unsigned int *)(MISC_BASE + 0x248))
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index b058c3b..76920ec 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -453,7 +453,7 @@ void __init spear13xx_map_io(void)
 	iotable_init(spear13xx_io_desc, ARRAY_SIZE(spear13xx_io_desc));
 
 	/* This will initialize clock framework */
-	clk_init();
+	spear13xx_clk_init();
 }
 
 static void __init spear13xx_timer_init(void)
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 0a7a548..4f049fe 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -19,13 +19,13 @@
 /* root clks */
 /* 32 KHz oscillator clock */
 static struct clk osc_32k_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.rate = 32000,
 };
 
 /* 24 MHz oscillator clock */
 static struct clk osc_24m_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.rate = 24000000,
 };
 
@@ -40,7 +40,7 @@ static struct clk rtc_clk = {
 
 /* clock derived from 24 MHz osc clk */
 /* pll masks structure */
-static struct pll_clk_masks pll1_masks = {
+static struct pll_clk_masks pll_masks = {
 	.mode_mask = PLL_MODE_MASK,
 	.mode_shift = PLL_MODE_SHIFT,
 	.norm_fdbk_m_mask = PLL_NORM_FDBK_M_MASK,
@@ -53,22 +53,22 @@ static struct pll_clk_masks pll1_masks = {
 	.div_n_shift = PLL_DIV_N_SHIFT,
 };
 
-/* pll1 configuration structure */
-static struct pll_clk_config pll1_config = {
-	.mode_reg = PLL1_CTR,
-	.cfg_reg = PLL1_FRQ,
-	.masks = &pll1_masks,
-};
-
 /* pll rate configuration table, in ascending order of rates */
 struct pll_rate_tbl pll_rtbl[] = {
 	{.mode = 0, .m = 0x85, .n = 0x0C, .p = 0x1}, /* 266 MHz */
 	{.mode = 0, .m = 0xA6, .n = 0x0C, .p = 0x1}, /* 332 MHz */
 };
 
+/* pll1 configuration structure */
+static struct pll_clk_config pll1_config = {
+	.mode_reg = PLL1_CTR,
+	.cfg_reg = PLL1_FRQ,
+	.masks = &pll_masks,
+};
+
 /* PLL1 clock */
 static struct clk pll1_clk = {
-	.flags = ENABLED_ON_INIT,
+	.flags = ENABLED_ON_INIT | SYSTEM_CLK,
 	.pclk = &osc_24m_clk,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
@@ -79,9 +79,29 @@ static struct clk pll1_clk = {
 	.private_data = &pll1_config,
 };
 
+/* pll2 configuration structure */
+static struct pll_clk_config pll2_config = {
+	.mode_reg = PLL2_CTR,
+	.cfg_reg = PLL2_FRQ,
+	.masks = &pll_masks,
+};
+
+/* PLL2 clock */
+static struct clk pll2_clk = {
+	.flags = ENABLED_ON_INIT | SYSTEM_CLK,
+	.pclk = &osc_24m_clk,
+	.en_reg = PLL2_CTR,
+	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
+	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 1},
+	.private_data = &pll2_config,
+};
+
 /* PLL3 48 MHz clock */
 static struct clk pll3_48m_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &osc_24m_clk,
 	.rate = 48000000,
 };
@@ -96,7 +116,7 @@ static struct clk wdt_clk = {
 /* clock derived from pll1 clk */
 /* cpu clock */
 static struct clk cpu_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &pll1_clk,
 	.recalc = &follow_parent,
 };
@@ -123,7 +143,7 @@ struct bus_rate_tbl bus_rtbl[] = {
 
 /* ahb clock */
 static struct clk ahb_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &pll1_clk,
 	.calc_rate = &bus_calc_rate,
 	.recalc = &bus_clk_recalc,
@@ -410,6 +430,48 @@ static struct clk usbd_clk = {
 };
 
 /* clock derived from ahb clk */
+/* ahb multiplied by 2 clock */
+static struct clk ahbmult2_clk = {
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
+	.pclk = &ahb_clk,
+	.recalc = &ahbmult2_clk_recalc,
+};
+
+/* ddr clock */
+struct ddr_rate_tbl ddr_rate_tbl = {
+	.minrate = 166000000,
+	.maxrate = 332000000,
+};
+
+static struct pclk_info ddr_pclk_info[] = {
+	{
+		.pclk = &ahb_clk,
+		.pclk_val = MCTR_CLK_HCLK_VAL,
+	}, {
+		.pclk = &ahbmult2_clk,
+		.pclk_val = MCTR_CLK_2HCLK_VAL,
+	}, {
+		.pclk = &pll2_clk,
+		.pclk_val = MCTR_CLK_PLL2_VAL,
+	},
+};
+
+/* ddr parent select structure */
+static struct pclk_sel ddr_pclk_sel = {
+	.pclk_info = ddr_pclk_info,
+	.pclk_count = ARRAY_SIZE(ddr_pclk_info),
+	.pclk_sel_reg = PLL_CLK_CFG,
+	.pclk_sel_mask = MCTR_CLK_MASK,
+};
+
+static struct clk ddr_clk = {
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
+	.recalc = &follow_parent,
+	.pclk_sel = &ddr_pclk_sel,
+	.pclk_sel_shift = MCTR_CLK_SHIFT,
+	.private_data = &ddr_rate_tbl,
+};
+
 /* apb masks structure */
 static struct bus_clk_masks apb_masks = {
 	.mask = HCLK_PCLK_RATIO_MASK,
@@ -424,7 +486,7 @@ static struct bus_clk_config apb_config = {
 
 /* apb clock */
 static struct clk apb_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &ahb_clk,
 	.calc_rate = &bus_calc_rate,
 	.recalc = &bus_clk_recalc,
@@ -658,6 +720,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "rtc-spear",	.clk = &rtc_clk},
 	/* clock derived from 24 MHz osc clk */
 	{ .con_id = "pll1_clk",		.clk = &pll1_clk},
+	{ .con_id = "pll2_clk",		.clk = &pll2_clk},
 	{ .con_id = "pll3_48m_clk",	.clk = &pll3_48m_clk},
 	{ .dev_id = "wdt",		.clk = &wdt_clk},
 	/* clock derived from pll1 clk */
@@ -677,6 +740,8 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .con_id = "usbh_clk",		.clk = &usbh_clk},
 	{ .dev_id = "usbd",		.clk = &usbd_clk},
 	/* clock derived from ahb clk */
+	{ .con_id = "ahbmult2_clk",	.clk = &ahbmult2_clk},
+	{ .con_id = "ddr_clk",		.clk = &ddr_clk},
 	{ .con_id = "apb_clk",		.clk = &apb_clk},
 	{ .dev_id = "i2c_designware.0",	.clk = &i2c_clk},
 	{ .dev_id = "dma",		.clk = &dma_clk},
@@ -732,12 +797,8 @@ static struct clk_lookup spear_clk_lookups[] = {
 #endif
 };
 
-void __init clk_init(void)
+/* machine clk init */
+void __init spear3xx_clk_init(void)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
-		clk_register(&spear_clk_lookups[i]);
-
-	recalc_root_clocks();
+	clk_init(spear_clk_lookups, ARRAY_SIZE(spear_clk_lookups), &ddr_clk);
 }
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 0f7648b..7b83197 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -44,7 +44,7 @@ extern struct platform_device smi_device;
 extern struct sys_timer spear3xx_timer;
 
 /* Add spear3xx family function declarations here */
-void __init clk_init(void);
+void __init spear3xx_clk_init(void);
 void __init i2c_register_board_devices(void);
 void __init spear_setup_timer(void);
 void __init spear3xx_map_io(void);
diff --git a/arch/arm/mach-spear3xx/include/mach/misc_regs.h b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
index 6cb4f3c..6316900 100644
--- a/arch/arm/mach-spear3xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear3xx/include/mach/misc_regs.h
@@ -46,6 +46,13 @@
 
 #define PLL2_MOD		((unsigned int *)(MISC_BASE + 0x01C))
 #define PLL_CLK_CFG		((unsigned int *)(MISC_BASE + 0x020))
+/* PLL_CLK_CFG register masks */
+#define MCTR_CLK_SHIFT		28
+#define MCTR_CLK_MASK		0x7
+#define MCTR_CLK_HCLK_VAL	0x0
+#define MCTR_CLK_2HCLK_VAL	0x1
+#define MCTR_CLK_PLL2_VAL	0x3
+
 #define CORE_CLK_CFG		((unsigned int *)(MISC_BASE + 0x024))
 /* CORE CLK CFG register masks */
 #define PLL_HCLK_RATIO_SHIFT	10
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index f7b8915..dcbe020 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -280,7 +280,7 @@ void __init spear3xx_map_io(void)
 	iotable_init(spear3xx_io_desc, ARRAY_SIZE(spear3xx_io_desc));
 
 	/* This will initialize clock framework */
-	clk_init();
+	spear3xx_clk_init();
 }
 
 /* pad multiplexing support */
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 9171952..99cc21d 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -19,13 +19,13 @@
 /* root clks */
 /* 32 KHz oscillator clock */
 static struct clk osc_32k_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.rate = 32000,
 };
 
 /* 30 MHz oscillator clock */
 static struct clk osc_30m_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.rate = 30000000,
 };
 
@@ -40,7 +40,7 @@ static struct clk rtc_clk = {
 
 /* clock derived from 30 MHz osc clk */
 /* pll masks structure */
-static struct pll_clk_masks pll1_masks = {
+static struct pll_clk_masks pll_masks = {
 	.mode_mask = PLL_MODE_MASK,
 	.mode_shift = PLL_MODE_SHIFT,
 	.norm_fdbk_m_mask = PLL_NORM_FDBK_M_MASK,
@@ -53,22 +53,22 @@ static struct pll_clk_masks pll1_masks = {
 	.div_n_shift = PLL_DIV_N_SHIFT,
 };
 
-/* pll1 configuration structure */
-static struct pll_clk_config pll1_config = {
-	.mode_reg = PLL1_CTR,
-	.cfg_reg = PLL1_FRQ,
-	.masks = &pll1_masks,
-};
-
 /* pll rate configuration table, in ascending order of rates */
 struct pll_rate_tbl pll_rtbl[] = {
 	{.mode = 0, .m = 0x85, .n = 0x0C, .p = 0x1}, /* 266 MHz */
 	{.mode = 0, .m = 0xA6, .n = 0x0C, .p = 0x1}, /* 332 MHz */
 };
 
+/* pll1 configuration structure */
+static struct pll_clk_config pll1_config = {
+	.mode_reg = PLL1_CTR,
+	.cfg_reg = PLL1_FRQ,
+	.masks = &pll_masks,
+};
+
 /* PLL1 clock */
 static struct clk pll1_clk = {
-	.flags = ENABLED_ON_INIT,
+	.flags = ENABLED_ON_INIT | SYSTEM_CLK,
 	.pclk = &osc_30m_clk,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
@@ -79,9 +79,29 @@ static struct clk pll1_clk = {
 	.private_data = &pll1_config,
 };
 
+/* pll2 configuration structure */
+static struct pll_clk_config pll2_config = {
+	.mode_reg = PLL2_CTR,
+	.cfg_reg = PLL2_FRQ,
+	.masks = &pll_masks,
+};
+
+/* PLL2 clock */
+static struct clk pll2_clk = {
+	.flags = ENABLED_ON_INIT | SYSTEM_CLK,
+	.pclk = &osc_30m_clk,
+	.en_reg = PLL2_CTR,
+	.en_reg_bit = PLL_ENABLE,
+	.calc_rate = &pll_calc_rate,
+	.recalc = &pll_clk_recalc,
+	.set_rate = &pll_clk_set_rate,
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 1},
+	.private_data = &pll2_config,
+};
+
 /* PLL3 48 MHz clock */
 static struct clk pll3_48m_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &osc_30m_clk,
 	.rate = 48000000,
 };
@@ -96,7 +116,7 @@ static struct clk wdt_clk = {
 /* clock derived from pll1 clk */
 /* cpu clock */
 static struct clk cpu_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &pll1_clk,
 	.recalc = &follow_parent,
 };
@@ -123,7 +143,7 @@ struct bus_rate_tbl bus_rtbl[] = {
 
 /* ahb clock */
 static struct clk ahb_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &pll1_clk,
 	.calc_rate = &bus_calc_rate,
 	.recalc = &bus_clk_recalc,
@@ -491,6 +511,48 @@ static struct clk usbd_clk = {
 };
 
 /* clock derived from ahb clk */
+/* ahb multiplied by 2 clock */
+static struct clk ahbmult2_clk = {
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
+	.pclk = &ahb_clk,
+	.recalc = &ahbmult2_clk_recalc,
+};
+
+/* ddr clock */
+struct ddr_rate_tbl ddr_rate_tbl = {
+	.minrate = 166000000,
+	.maxrate = 332000000,
+};
+
+static struct pclk_info ddr_pclk_info[] = {
+	{
+		.pclk = &ahb_clk,
+		.pclk_val = MCTR_CLK_HCLK_VAL,
+	}, {
+		.pclk = &ahbmult2_clk,
+		.pclk_val = MCTR_CLK_2HCLK_VAL,
+	}, {
+		.pclk = &pll2_clk,
+		.pclk_val = MCTR_CLK_PLL2_VAL,
+	},
+};
+
+/* ddr parent select structure */
+static struct pclk_sel ddr_pclk_sel = {
+	.pclk_info = ddr_pclk_info,
+	.pclk_count = ARRAY_SIZE(ddr_pclk_info),
+	.pclk_sel_reg = PLL_CLK_CFG,
+	.pclk_sel_mask = MCTR_CLK_MASK,
+};
+
+static struct clk ddr_clk = {
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
+	.recalc = &follow_parent,
+	.pclk_sel = &ddr_pclk_sel,
+	.pclk_sel_shift = MCTR_CLK_SHIFT,
+	.private_data = &ddr_rate_tbl,
+};
+
 /* apb masks structure */
 static struct bus_clk_masks apb_masks = {
 	.mask = HCLK_PCLK_RATIO_MASK,
@@ -505,7 +567,7 @@ static struct bus_clk_config apb_config = {
 
 /* apb clock */
 static struct clk apb_clk = {
-	.flags = ALWAYS_ENABLED,
+	.flags = ALWAYS_ENABLED | SYSTEM_CLK,
 	.pclk = &ahb_clk,
 	.calc_rate = &bus_calc_rate,
 	.recalc = &bus_clk_recalc,
@@ -630,6 +692,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "rtc-spear",	.clk = &rtc_clk},
 	/* clock derived from 30 MHz os		 clk */
 	{ .con_id = "pll1_clk",		.clk = &pll1_clk},
+	{ .con_id = "pll2_clk",		.clk = &pll2_clk},
 	{ .con_id = "pll3_48m_clk",	.clk = &pll3_48m_clk},
 	{ .dev_id = "wdt",		.clk = &wdt_clk},
 	/* clock derived from pll1 clk */
@@ -654,6 +717,8 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .con_id = "usbh.1_clk",	.clk = &usbh1_clk},
 	{ .dev_id = "usbd",		.clk = &usbd_clk},
 	/* clock derived from ahb clk */
+	{ .con_id = "ahbmult2_clk",	.clk = &ahbmult2_clk},
+	{ .con_id = "ddr_clk",		.clk = &ddr_clk},
 	{ .con_id = "apb_clk",		.clk = &apb_clk},
 	{ .dev_id = "i2c_designware.0",	.clk = &i2c_clk},
 	{ .dev_id = "dma",		.clk = &dma_clk},
@@ -671,12 +736,8 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "gpio2",		.clk = &gpio2_clk},
 };
 
-void __init clk_init(void)
+/* machine clk init */
+void __init spear6xx_clk_init(void)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
-		clk_register(&spear_clk_lookups[i]);
-
-	recalc_root_clocks();
+	clk_init(spear_clk_lookups, ARRAY_SIZE(spear_clk_lookups), &ddr_clk);
 }
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index dd29298..4d1d326 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -51,7 +51,7 @@ void __init spear6xx_map_io(void);
 void __init spear6xx_init_irq(void);
 void __init spear6xx_init(void);
 void __init spear600_init(void);
-void __init clk_init(void);
+void __init spear6xx_clk_init(void);
 
 /* Add spear600 machine device structure declarations here */
 
diff --git a/arch/arm/mach-spear6xx/include/mach/misc_regs.h b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
index bd71e72..0f4562b 100644
--- a/arch/arm/mach-spear6xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear6xx/include/mach/misc_regs.h
@@ -47,6 +47,13 @@
 #define PLL2_MOD		((unsigned int *)(MISC_BASE + 0x01C))
 #define PLL_CLK_CFG		((unsigned int *)(MISC_BASE + 0x020))
 #define CORE_CLK_CFG		((unsigned int *)(MISC_BASE + 0x024))
+/* PLL_CLK_CFG register masks */
+#define MCTR_CLK_SHIFT		28
+#define MCTR_CLK_MASK		0x7
+#define MCTR_CLK_HCLK_VAL	0x0
+#define MCTR_CLK_2HCLK_VAL	0x1
+#define MCTR_CLK_PLL2_VAL	0x3
+
 /* CORE CLK CFG register masks */
 #define PLL_HCLK_RATIO_SHIFT	10
 #define PLL_HCLK_RATIO_MASK	0x3
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index f91380e..cd2153c 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -439,7 +439,7 @@ void __init spear6xx_map_io(void)
 	iotable_init(spear6xx_io_desc, ARRAY_SIZE(spear6xx_io_desc));
 
 	/* This will initialize clock framework */
-	clk_init();
+	spear6xx_clk_init();
 }
 
 static void __init spear6xx_timer_init(void)
diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index 7d3338f..fb1c87b 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -21,6 +21,8 @@
 #include <linux/spinlock.h>
 #include <plat/clock.h>
 
+/* pointer to ddr clock structure */
+static struct clk *ddr_clk;
 static DEFINE_SPINLOCK(clocks_lock);
 static LIST_HEAD(root_clks);
 #ifdef CONFIG_DEBUG_FS
@@ -160,7 +162,7 @@ static int do_clk_enable(struct clk *clk)
 		 * time please reclac
 		 */
 		if (clk->recalc) {
-			ret = clk->recalc(clk);
+			ret = clk->recalc(clk, &clk->rate, clk->pclk->rate);
 			if (ret)
 				goto err;
 		}
@@ -298,7 +300,16 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 			propagate_rate(clk, 0);
 		spin_unlock_irqrestore(&clocks_lock, flags);
 	} else if (clk->pclk) {
-		u32 mult = clk->div_factor ? clk->div_factor : 1;
+		u32 mult;
+		/*
+		 * if pclk is SYSTEM_CLK and clk is not SYSTEM_CLK then return
+		 * error
+		 */
+		if (clk->pclk->flags & SYSTEM_CLK)
+			if (!(clk->flags & SYSTEM_CLK))
+				return -EPERM;
+
+		mult = clk->div_factor ? clk->div_factor : 1;
 		ret = clk_set_rate(clk->pclk, mult * rate);
 	}
 
@@ -371,7 +382,7 @@ void propagate_rate(struct clk *pclk, int on_init)
 
 	list_for_each_entry_safe(clk, _temp, &pclk->children, sibling) {
 		if (clk->recalc) {
-			ret = clk->recalc(clk);
+			ret = clk->recalc(clk, &clk->rate, clk->pclk->rate);
 			/*
 			 * recalc will return error if clk out is not programmed
 			 * In this case configure default rate.
@@ -390,6 +401,47 @@ void propagate_rate(struct clk *pclk, int on_init)
 	}
 }
 
+/* updates "rate" pointer with current_clk's output for input "rate" */
+static void rate_calc(struct clk *current_clk, struct clk *ancestor_clk,
+		unsigned long *rate)
+{
+	if (current_clk->pclk != ancestor_clk)
+		rate_calc(current_clk->pclk, ancestor_clk, rate);
+
+	if (current_clk->recalc)
+		current_clk->recalc(current_clk, rate, *rate);
+}
+
+/*
+ * Check if ancestor clk rate is acceptable to ddr or not.
+ * This will call recursive rate_calc function, starting from ddr upto ancestor
+ * clk mentioned. This will calculate divisions / multiplications by all
+ * intermediate ancestor clocks and return the final rate of ddr if ancestor clk
+ * sets its rate to "rate", value passed in function.
+ */
+static int ddr_rate_acceptable(struct clk *aclk, unsigned long rate)
+{
+	struct ddr_rate_tbl *tbl = ddr_clk->private_data;
+
+	rate_calc(ddr_clk, aclk, &rate);
+	if ((rate >= tbl->minrate) && (rate <= tbl->maxrate))
+		return true;
+
+	return false;
+}
+
+/* mark all ddr ancestors with DDR_ANCESTOR flag */
+static void mark_ddr_ancestors(struct clk *dclk)
+{
+	struct clk *clk = dclk->pclk;
+
+	/* mark all ancestors of DDR */
+	while (clk != NULL) {
+		clk->flags |= DDR_ANCESTOR;
+		clk = clk->pclk;
+	}
+}
+
 /**
  * round_rate - Returns index of closest programmable rate in rate_config tbl
  * @clk: ptr to clock structure
@@ -475,7 +527,7 @@ unsigned long pll_calc_rate(struct clk *clk, int index)
  * In Dithered mode
  * rate = (2 * M[15:0] * Fin)/(256 * N * 2^P)
  */
-int pll_clk_recalc(struct clk *clk)
+int pll_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate)
 {
 	struct pll_clk_config *config = clk->private_data;
 	unsigned int num = 2, den = 0, val, mode = 0;
@@ -504,7 +556,7 @@ int pll_clk_recalc(struct clk *clk)
 	if (!den)
 		return -EINVAL;
 
-	clk->rate = (((clk->pclk->rate/10000) * num) / den) * 10000;
+	*rate = (((prate/10000) * num) / den) * 10000;
 	return 0;
 }
 
@@ -522,6 +574,25 @@ int pll_clk_set_rate(struct clk *clk, unsigned long desired_rate)
 	if (i < 0)
 		return i;
 
+	/* if clk is ddrs ancestor, check if rate is acceptable to ddr */
+	if (ddr_clk && (clk->flags & DDR_ANCESTOR)) {
+		int ret;
+
+		ret = ddr_rate_acceptable(clk, rate);
+		if (ret == false)
+			return -EPERM;
+		else {
+			/*
+			 * call routine to put ddr in refresh mode, and
+			 * configure pll.
+			 */
+			/* TBD */
+			clk->rate = rate;
+		}
+
+		return ret;
+	}
+
 	val = readl(config->mode_reg) &
 		~(config->masks->mode_mask << config->masks->mode_shift);
 	val |= (tbls[i].mode & config->masks->mode_mask) <<
@@ -563,7 +634,7 @@ unsigned long bus_calc_rate(struct clk *clk, int index)
 }
 
 /* calculates current programmed rate of ahb or apb bus */
-int bus_clk_recalc(struct clk *clk)
+int bus_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate)
 {
 	struct bus_clk_config *config = clk->private_data;
 	unsigned int div;
@@ -574,7 +645,7 @@ int bus_clk_recalc(struct clk *clk)
 	if (!div)
 		return -EINVAL;
 
-	clk->rate = (unsigned long)clk->pclk->rate / div;
+	*rate = prate / div;
 	return 0;
 }
 
@@ -600,6 +671,14 @@ int bus_clk_set_rate(struct clk *clk, unsigned long desired_rate)
 	return 0;
 }
 
+/* calculates current programmed rate of ahbmult2 */
+int
+ahbmult2_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate)
+{
+	*rate = prate * 2;
+	return 0;
+}
+
 /*
  * gives rate for different values of eq, x and y
  *
@@ -627,7 +706,7 @@ unsigned long aux_calc_rate(struct clk *clk, int index)
  *
  * Selection of eqn 1 or 2 is programmed in register
  */
-int aux_clk_recalc(struct clk *clk)
+int aux_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate)
 {
 	struct aux_clk_config *config = clk->private_data;
 	unsigned int num = 1, den = 1, val, eqn;
@@ -650,7 +729,7 @@ int aux_clk_recalc(struct clk *clk)
 	if (!den)
 		return -EINVAL;
 
-	clk->rate = (((clk->pclk->rate/10000) * num) / den) * 10000;
+	*rate = (((prate / 10000) * num) / den) * 10000;
 	return 0;
 }
 
@@ -704,7 +783,7 @@ unsigned long gpt_calc_rate(struct clk *clk, int index)
  * Fout from synthesizer can be given from below equations:
  * Fout= Fin/((2 ^ (N+1)) * (M+1))
  */
-int gpt_clk_recalc(struct clk *clk)
+int gpt_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate)
 {
 	struct gpt_clk_config *config = clk->private_data;
 	unsigned int div = 1, val;
@@ -718,7 +797,7 @@ int gpt_clk_recalc(struct clk *clk)
 	if (!div)
 		return -EINVAL;
 
-	clk->rate = (unsigned long)clk->pclk->rate / div;
+	*rate = prate / div;
 	return 0;
 }
 
@@ -786,11 +865,10 @@ unsigned long clcd_calc_rate(struct clk *clk, int index)
  * complete div (including fractional part) and then right shift the
  * result by 14 places.
  */
-int clcd_clk_recalc(struct clk *clk)
+int clcd_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate)
 {
 	struct clcd_clk_config *config = clk->private_data;
 	unsigned int div = 1;
-	unsigned long prate;
 	unsigned int val;
 
 	val = readl(config->synth_reg);
@@ -800,10 +878,10 @@ int clcd_clk_recalc(struct clk *clk)
 	if (!div)
 		return -EINVAL;
 
-	prate = clk->pclk->rate / 1000; /* first level division, make it KHz */
+	prate = prate / 1000; /* first level division, make it KHz */
 
-	clk->rate = (((unsigned long)prate << 12) / (2 * div)) >> 12;
-	clk->rate *= 1000;
+	*rate = (((unsigned long)prate << 12) / (2 * div)) >> 12;
+	*rate *= 1000;
 	return 0;
 }
 
@@ -834,11 +912,11 @@ int clcd_clk_set_rate(struct clk *clk, unsigned long desired_rate)
  * Used for clocks that always have value as the parent clock divided by a
  * fixed divisor
  */
-int follow_parent(struct clk *clk)
+int follow_parent(struct clk *clk, unsigned long *rate, unsigned long prate)
 {
 	unsigned int div_factor = (clk->div_factor < 1) ? 1 : clk->div_factor;
 
-	clk->rate = clk->pclk->rate/div_factor;
+	*rate = prate / div_factor;
 	return 0;
 }
 
@@ -857,7 +935,7 @@ void recalc_root_clocks(void)
 	spin_lock_irqsave(&clocks_lock, flags);
 	list_for_each_entry(pclk, &root_clks, sibling) {
 		if (pclk->recalc) {
-			ret = pclk->recalc(pclk);
+			ret = pclk->recalc(pclk, &pclk->rate, pclk->pclk->rate);
 			/*
 			 * recalc will return error if clk out is not programmed
 			 * In this case configure default clock.
@@ -873,6 +951,23 @@ void recalc_root_clocks(void)
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
+void __init
+clk_init(struct clk_lookup *clk_lookups, u32 count, struct clk *dclk)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		clk_register(&clk_lookups[i]);
+
+	recalc_root_clocks();
+
+	/* Mark all ancestors of DDR with special flag */
+	if (dclk) {
+		ddr_clk = dclk;
+		mark_ddr_ancestors(dclk);
+	}
+}
+
 #ifdef CONFIG_DEBUG_FS
 /*
  *	debugfs support to trace clock tree hierarchy and attributes
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index 621c17c..6ddcf93 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -19,9 +19,12 @@
 #include <asm/clkdev.h>
 
 /* clk structure flags */
-#define	ALWAYS_ENABLED		(1 << 0) /* clock always enabled */
-#define	RESET_TO_ENABLE		(1 << 1) /* reset register bit to enable clk */
-#define	ENABLED_ON_INIT		(1 << 2) /* clocks enabled at init */
+#define ALWAYS_ENABLED		(1 << 0) /* clock always enabled */
+#define RESET_TO_ENABLE		(1 << 1) /* reset register bit to enable clk */
+#define ENABLED_ON_INIT		(1 << 2) /* clocks enabled at init */
+/* Only System clocks can call other sytem clocks set rate function */
+#define SYSTEM_CLK		(1 << 3)
+#define DDR_ANCESTOR		(1 << 4) /* ancestor clks of DDR */
 
 /**
  * struct clkops - clock operations
@@ -99,8 +102,9 @@ struct clk {
 	unsigned int *en_reg;
 	u8 en_reg_bit;
 	const struct clkops *ops;
-	int (*recalc) (struct clk *);
-	int (*set_rate) (struct clk *, unsigned long rate);
+	int (*recalc) (struct clk *clk, unsigned long *rate,
+			unsigned long prate);
+	int (*set_rate) (struct clk *clk, unsigned long rate);
 	unsigned long (*calc_rate)(struct clk *, int index);
 	struct rate_config rate_config;
 	unsigned int div_factor;
@@ -223,26 +227,42 @@ struct clcd_rate_tbl {
 	u16 div;
 };
 
+/* ddr min, max clk rate table */
+struct ddr_rate_tbl {
+	unsigned long minrate;
+	unsigned long maxrate;
+};
+
 /* platform specific clock functions */
+/*
+ * must be called from machine clock.c file, dclk is pointer to ddr_clk
+ * strucutre. Which is required by clock framework.
+ *
+ * Actually before changing rate of DDRs ancestor, we must put ddr in refresh
+ * state and then change parent.
+ */
+void clk_init(struct clk_lookup *clk_lookups, u32 count, struct clk *dclk);
 void clk_register(struct clk_lookup *cl);
 void recalc_root_clocks(void);
 
 /* clock recalc & set rate functions */
-int follow_parent(struct clk *clk);
+int follow_parent(struct clk *clk, unsigned long *rate, unsigned long prate);
 unsigned long pll_calc_rate(struct clk *clk, int index);
-int pll_clk_recalc(struct clk *clk);
+int pll_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate);
 int pll_clk_set_rate(struct clk *clk, unsigned long desired_rate);
 unsigned long bus_calc_rate(struct clk *clk, int index);
-int bus_clk_recalc(struct clk *clk);
+int bus_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate);
 int bus_clk_set_rate(struct clk *clk, unsigned long desired_rate);
+int ahbmult2_clk_recalc(struct clk *clk, unsigned long *rate,
+		unsigned long prate);
 unsigned long gpt_calc_rate(struct clk *clk, int index);
-int gpt_clk_recalc(struct clk *clk);
+int gpt_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate);
 int gpt_clk_set_rate(struct clk *clk, unsigned long desired_rate);
 unsigned long aux_calc_rate(struct clk *clk, int index);
-int aux_clk_recalc(struct clk *clk);
+int aux_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate);
 int aux_clk_set_rate(struct clk *clk, unsigned long desired_rate);
 unsigned long clcd_calc_rate(struct clk *clk, int index);
-int clcd_clk_recalc(struct clk *clk);
+int clcd_clk_recalc(struct clk *clk, unsigned long *rate, unsigned long prate);
 int clcd_clk_set_rate(struct clk *clk, unsigned long desired_rate);
 
 #endif /* __PLAT_CLOCK_H */
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
