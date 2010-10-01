From: Viresh KUMAR <viresh.kumar@st.com>
Subject: [PATCH V2 44/69] SPEAr CPU freq: Adding support for CPU Freq framework
Date: Fri,  1 Oct 2010 17:26:04 +0530
Message-ID: <0260f7ebc3d1dd80c3bb40faefc946e35f9436fd.1285933332.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:35277 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756696Ab0JAL6G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 07:58:06 -0400
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com, a.zummo@towertech.it, dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry
Cc: Deepak Sikri <deepak.sikri@st.com>, shiraz.hashim@st.com, vipin.kumar@st.com, armando.visconti@st.com, vipulkumar.samar@st.com, rajeev-dlh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, Viresh Kumar <viresh.kumar@st.com>

From: Deepak Sikri <deepak.sikri@st.com>

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/Kconfig                |    1 +
 arch/arm/mach-spear13xx/clock.c |    1 +
 arch/arm/mach-spear3xx/clock.c  |    1 +
 arch/arm/mach-spear6xx/clock.c  |    1 +
 arch/arm/plat-spear/Makefile    |    2 +-
 arch/arm/plat-spear/cpufreq.c   |  159 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 164 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-spear/cpufreq.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 158bf06..cdd0a2b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -821,6 +821,7 @@ config PLAT_SPEAR
 	select COMMON_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
+	select ARCH_HAS_CPUFREQ
 	help
 	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
 
diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 4f320fa..79942a9 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -91,6 +91,7 @@ static struct pll_clk_config pll1_config = {
 /* pll rate configuration table, in ascending order of rates */
 struct pll_rate_tbl pll_rtbl[] = {
 	/* PCLK 24MHz */
+	{.mode = 0, .m = 0x64, .n = 0x03, .p = 0x2}, /* 400 MHz */
 	{.mode = 0, .m = 0x7D, .n = 0x03, .p = 0x2}, /* 500 MHz */
 	{.mode = 0, .m = 0xA6, .n = 0x03, .p = 0x2}, /* 664 MHz */
 	{.mode = 0, .m = 0xC8, .n = 0x03, .p = 0x2}, /* 800 MHz */
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 4f049fe..64d9cdc 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -55,6 +55,7 @@ static struct pll_clk_masks pll_masks = {
 
 /* pll rate configuration table, in ascending order of rates */
 struct pll_rate_tbl pll_rtbl[] = {
+	{.mode = 0, .m = 0x53, .n = 0x0C, .p = 0x1}, /* 166 MHz */
 	{.mode = 0, .m = 0x85, .n = 0x0C, .p = 0x1}, /* 266 MHz */
 	{.mode = 0, .m = 0xA6, .n = 0x0C, .p = 0x1}, /* 332 MHz */
 };
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 99cc21d..f1429f5 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -55,6 +55,7 @@ static struct pll_clk_masks pll_masks = {
 
 /* pll rate configuration table, in ascending order of rates */
 struct pll_rate_tbl pll_rtbl[] = {
+	{.mode = 0, .m = 0x53, .n = 0x0C, .p = 0x1}, /* 166 MHz */
 	{.mode = 0, .m = 0x85, .n = 0x0C, .p = 0x1}, /* 266 MHz */
 	{.mode = 0, .m = 0xA6, .n = 0x0C, .p = 0x1}, /* 332 MHz */
 };
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index 1c8ee4a..c25e5b8 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -6,7 +6,7 @@
 obj-y	:= clcd.o clock.o pll_clk.o smi.o time.o
 
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
-
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_MACH_SPEAR310)	+= plgpio.o
 obj-$(CONFIG_MACH_SPEAR320)	+= plgpio.o
 obj-$(CONFIG_SPEAR_PWM)		+= pwm.o
diff --git a/arch/arm/plat-spear/cpufreq.c b/arch/arm/plat-spear/cpufreq.c
new file mode 100644
index 0000000..9384d65
--- /dev/null
+++ b/arch/arm/plat-spear/cpufreq.c
@@ -0,0 +1,159 @@
+/*
+ * arch/arm/plat-spear/cpufreq.c
+ *
+ * CPU Frequency Scaling for SPEAr platform
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Deepak Sikri<deepak.sikri@st.com>
+ *
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <asm/system.h>
+#include <mach/hardware.h>
+
+#define CPU_CLK		"cpu_clk"
+
+#ifdef CONFIG_ARCH_SPEAR13XX
+#define MIN_CPU_FREQ	200000
+#define MAX_CPU_FREQ	500000
+
+static u32 spear_cpu_freq[] = {
+	200000,	/* 200 MHZ */
+	250000,	/* 250 MHZ */
+	332000,	/* 332 MHZ */
+	400000,	/* 400 MHZ */
+	500000,	/* 500 MHZ */
+};
+#elif defined(CONFIG_ARCH_SPEAR6XX) || defined(CONFIG_ARCH_SPEAR3XX)
+#define MIN_CPU_FREQ	166000
+#define MAX_CPU_FREQ	332000
+
+static u32 spear_cpu_freq[] = {
+	166000,	/* 166 MHZ */
+	266000,	/* 266 MHZ */
+	332000,	/* 333 MHZ */
+};
+#endif
+
+static struct
+	cpufreq_frequency_table spear_freq_tbl[ARRAY_SIZE(spear_cpu_freq) + 1];
+static struct clk *cpu_clk;
+
+int spear_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, spear_freq_tbl);
+}
+
+unsigned int spear_cpufreq_get(unsigned int cpu)
+{
+	unsigned long rate;
+
+	if (cpu)
+		return 0;
+
+	rate = clk_get_rate(cpu_clk) / 1000;
+	return rate;
+}
+
+static int spear_cpufreq_target(struct cpufreq_policy *policy,
+		unsigned int target_freq, unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	int ret = 0;
+	int index;
+
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	if (cpufreq_frequency_table_target(policy, spear_freq_tbl,
+				target_freq, relation, &index))
+		return -EINVAL;
+
+	freqs.old = spear_cpufreq_get(0);
+	freqs.new = spear_cpu_freq[index];
+	freqs.cpu = policy->cpu;
+
+	if (freqs.old == target_freq)
+		return 0;
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return ret;
+}
+
+static int spear_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int result;
+	int i = 0;
+
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	cpu_clk = clk_get(NULL, CPU_CLK);
+	if (IS_ERR(cpu_clk))
+		return PTR_ERR(cpu_clk);
+
+	policy->cpuinfo.min_freq = MIN_CPU_FREQ;
+	policy->cpuinfo.max_freq = MAX_CPU_FREQ;
+	policy->cur = policy->min = policy->max = spear_cpufreq_get(0);
+
+	for (i = 0; i < ARRAY_SIZE(spear_cpu_freq); i++) {
+		spear_freq_tbl[i].index = i;
+		spear_freq_tbl[i].frequency = spear_cpu_freq[i];
+	}
+
+	spear_freq_tbl[i].index = i;
+	spear_freq_tbl[i].frequency = CPUFREQ_TABLE_END;
+	result = cpufreq_frequency_table_cpuinfo(policy, spear_freq_tbl);
+	if (!result)
+		cpufreq_frequency_table_get_attr(spear_freq_tbl,
+				policy->cpu);
+
+	policy->cpuinfo.transition_latency = 300*1000; /*250 uS*/
+
+	return 0;
+}
+
+static int spear_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	clk_put(cpu_clk);
+	return 0;
+}
+
+static struct freq_attr *spear_cpufreq_attr[] = {
+	 &cpufreq_freq_attr_scaling_available_freqs,
+	 NULL,
+};
+
+static struct cpufreq_driver spear_driver = {
+	.flags		= CPUFREQ_STICKY,
+	.verify		= spear_cpufreq_verify,
+	.target		= spear_cpufreq_target,
+	.get		= spear_cpufreq_get,
+	.init		= spear_cpufreq_init,
+	.exit		= spear_cpufreq_exit,
+	.name		= "spear_cpufreq",
+	.attr		= spear_cpufreq_attr,
+};
+
+static int __init spear_cpufreq_register(void)
+{
+	return cpufreq_register_driver(&spear_driver);
+}
+
+arch_initcall(spear_cpufreq_register);
-- 
1.7.2.2

