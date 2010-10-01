From: Viresh KUMAR <viresh.kumar@st.com>
Subject: [PATCH V2 22/69] ST SPEAr: Adding machine support for keyboard
Date: Fri,  1 Oct 2010 17:25:42 +0530
Message-ID: <5eb8338cba759ba92beaeb5d1cca301ab0077582.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:48597 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756517Ab0JAL6E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 07:58:04 -0400
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com, a.zummo@towertech.it, dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry
Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>, shiraz.hashim@st.com, vipin.kumar@st.com, deepak.sikri@st.com, armando.visconti@st.com, vipulkumar.samar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |   14 +++
 arch/arm/mach-spear13xx/spear13xx.c            |   19 +++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear3xx/spear300.c              |   19 +++
 arch/arm/mach-spear3xx/spear300_evb.c          |   14 +++
 arch/arm/plat-spear/include/plat/keyboard.h    |  144 ++++++++++++++++++++++++
 7 files changed, 212 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/keyboard.h

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index a75ed3a..fd9f9a6 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -33,6 +33,7 @@ extern struct amba_device spear13xx_uart_device;
 extern struct platform_device spear13xx_ehci0_device;
 extern struct platform_device spear13xx_ehci1_device;
 extern struct platform_device spear13xx_i2c_device;
+extern struct platform_device spear13xx_kbd_device;
 extern struct platform_device spear13xx_ohci0_device;
 extern struct platform_device spear13xx_ohci1_device;
 extern struct platform_device spear13xx_rtc_device;
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 9f53361..0c7c996 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -16,6 +16,7 @@
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/keyboard.h>
 
 static struct amba_device *amba_devs[] __initdata = {
 	&spear13xx_uart_device,
@@ -25,15 +26,28 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ehci0_device,
 	&spear13xx_ehci1_device,
 	&spear13xx_i2c_device,
+	&spear13xx_kbd_device,
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
 };
 
+/* keyboard specific platform data */
+static DECLARE_KEYMAP(spear_keymap);
+
+static struct kbd_platform_data kbd_data = {
+	.keymap = spear_keymap,
+	.keymapsize = ARRAY_SIZE(spear_keymap),
+	.rep = 1,
+};
+
 static void __init spear1300_evb_init(void)
 {
 	unsigned int i;
 
+	/* set keyboard plat data */
+	kbd_set_plat_data(&spear13xx_kbd_device, &kbd_data);
+
 	/* call spear1300 machine init function */
 	spear1300_init();
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index c201e31..d19e325 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -166,6 +166,25 @@ struct platform_device spear13xx_ohci1_device = {
 	.resource = ohci1_resources,
 };
 
+/* keyboard device registration */
+static struct resource kbd_resources[] = {
+	{
+		.start = SPEAR13XX_KBD_BASE,
+		.end = SPEAR13XX_KBD_BASE + SZ_1K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_KBD,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear13xx_kbd_device = {
+	.name = "keyboard",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(kbd_resources),
+	.resource = kbd_resources,
+};
+
 /* rtc device registration */
 static struct resource rtc_resources[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 3eb2737..70f7ee2 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -108,6 +108,7 @@ extern struct pmx_driver pmx_driver;
 /* Add spear300 machine device structure declarations here */
 extern struct amba_device clcd_device;
 extern struct amba_device gpio1_device;
+extern struct platform_device kbd_device;
 
 /* pad mux modes */
 extern struct pmx_mode nand_mode;
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index fb7d5f1..44ba52e 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -407,6 +407,25 @@ struct amba_device gpio1_device = {
 	.irq = {VIRQ_GPIO1, NO_IRQ},
 };
 
+/* keyboard device registration */
+static struct resource kbd_resources[] = {
+	{
+		.start = SPEAR300_KEYBOARD_BASE,
+		.end = SPEAR300_KEYBOARD_BASE + SZ_1K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = VIRQ_KEYBOARD,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device kbd_device = {
+	.name = "keyboard",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(kbd_resources),
+	.resource = kbd_resources,
+};
+
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 3b3c6ce..afb773e 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -15,6 +15,7 @@
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/keyboard.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -51,6 +52,16 @@ static struct platform_device *plat_devs[] __initdata = {
 	&rtc_device,
 
 	/* spear300 specific devices */
+	&kbd_device,
+};
+
+/* keyboard specific platform data */
+static DECLARE_KEYMAP(spear_keymap);
+
+static struct kbd_platform_data kbd_data = {
+	.keymap = spear_keymap,
+	.keymapsize = ARRAY_SIZE(spear_keymap),
+	.rep = 1,
 };
 
 static void __init spear300_evb_init(void)
@@ -62,6 +73,9 @@ static void __init spear300_evb_init(void)
 	pmx_driver.devs = pmx_devs;
 	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
 
+	/* set keyboard plat data */
+	kbd_set_plat_data(&kbd_device, &kbd_data);
+
 	/* call spear300 machine init function */
 	spear300_init();
 
diff --git a/arch/arm/plat-spear/include/plat/keyboard.h b/arch/arm/plat-spear/include/plat/keyboard.h
new file mode 100644
index 0000000..29448bc
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/keyboard.h
@@ -0,0 +1,144 @@
+/*
+ * arch/arm/plat-spear/include/plat/keyboard.h
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_KEYBOARD_H
+#define __PLAT_KEYBOARD_H
+
+#include <linux/bitops.h>
+#include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/types.h>
+
+#define DECLARE_KEYMAP(name) \
+int name[] = {\
+	KEY(0, 0, KEY_ESC), \
+	KEY(0, 1, KEY_1), \
+	KEY(0, 2, KEY_2), \
+	KEY(0, 3, KEY_3), \
+	KEY(0, 4, KEY_4), \
+	KEY(0, 5, KEY_5), \
+	KEY(0, 6, KEY_6), \
+	KEY(0, 7, KEY_7), \
+	KEY(0, 8, KEY_8), \
+	KEY(1, 0, KEY_9), \
+	KEY(1, 1, KEY_MINUS), \
+	KEY(1, 2, KEY_EQUAL), \
+	KEY(1, 3, KEY_BACKSPACE), \
+	KEY(1, 4, KEY_TAB), \
+	KEY(1, 5, KEY_Q), \
+	KEY(1, 6, KEY_W), \
+	KEY(1, 7, KEY_E), \
+	KEY(1, 8, KEY_R), \
+	KEY(2, 0, KEY_T), \
+	KEY(2, 1, KEY_Y), \
+	KEY(2, 2, KEY_U), \
+	KEY(2, 3, KEY_I), \
+	KEY(2, 4, KEY_O), \
+	KEY(2, 5, KEY_P), \
+	KEY(2, 6, KEY_LEFTBRACE), \
+	KEY(2, 7, KEY_RIGHTBRACE), \
+	KEY(2, 8, KEY_ENTER), \
+	KEY(3, 0, KEY_LEFTCTRL), \
+	KEY(3, 1, KEY_A), \
+	KEY(3, 2, KEY_S), \
+	KEY(3, 3, KEY_D), \
+	KEY(3, 4, KEY_F), \
+	KEY(3, 5, KEY_G), \
+	KEY(3, 6, KEY_H), \
+	KEY(3, 7, KEY_J), \
+	KEY(3, 8, KEY_K), \
+	KEY(4, 0, KEY_L), \
+	KEY(4, 1, KEY_SEMICOLON), \
+	KEY(4, 2, KEY_APOSTROPHE), \
+	KEY(4, 3, KEY_GRAVE), \
+	KEY(4, 4, KEY_LEFTSHIFT), \
+	KEY(4, 5, KEY_BACKSLASH), \
+	KEY(4, 6, KEY_Z), \
+	KEY(4, 7, KEY_X), \
+	KEY(4, 8, KEY_C), \
+	KEY(4, 0, KEY_L), \
+	KEY(4, 1, KEY_SEMICOLON), \
+	KEY(4, 2, KEY_APOSTROPHE), \
+	KEY(4, 3, KEY_GRAVE), \
+	KEY(4, 4, KEY_LEFTSHIFT), \
+	KEY(4, 5, KEY_BACKSLASH), \
+	KEY(4, 6, KEY_Z), \
+	KEY(4, 7, KEY_X), \
+	KEY(4, 8, KEY_C), \
+	KEY(4, 0, KEY_L), \
+	KEY(4, 1, KEY_SEMICOLON), \
+	KEY(4, 2, KEY_APOSTROPHE), \
+	KEY(4, 3, KEY_GRAVE), \
+	KEY(4, 4, KEY_LEFTSHIFT), \
+	KEY(4, 5, KEY_BACKSLASH), \
+	KEY(4, 6, KEY_Z), \
+	KEY(4, 7, KEY_X), \
+	KEY(4, 8, KEY_C), \
+	KEY(5, 0, KEY_V), \
+	KEY(5, 1, KEY_B), \
+	KEY(5, 2, KEY_N), \
+	KEY(5, 3, KEY_M), \
+	KEY(5, 4, KEY_COMMA), \
+	KEY(5, 5, KEY_DOT), \
+	KEY(5, 6, KEY_SLASH), \
+	KEY(5, 7, KEY_RIGHTSHIFT), \
+	KEY(5, 8, KEY_KPASTERISK), \
+	KEY(6, 0, KEY_LEFTALT), \
+	KEY(6, 1, KEY_SPACE), \
+	KEY(6, 2, KEY_CAPSLOCK), \
+	KEY(6, 3, KEY_F1), \
+	KEY(6, 4, KEY_F2), \
+	KEY(6, 5, KEY_F3), \
+	KEY(6, 6, KEY_F4), \
+	KEY(6, 7, KEY_F5), \
+	KEY(6, 8, KEY_F6), \
+	KEY(7, 0, KEY_F7), \
+	KEY(7, 1, KEY_F8), \
+	KEY(7, 2, KEY_F9), \
+	KEY(7, 3, KEY_F10), \
+	KEY(7, 4, KEY_NUMLOCK), \
+	KEY(7, 5, KEY_SCROLLLOCK), \
+	KEY(7, 6, KEY_KP7), \
+	KEY(7, 7, KEY_KP8), \
+	KEY(7, 8, KEY_KP9), \
+	KEY(8, 0, KEY_KPMINUS), \
+	KEY(8, 1, KEY_KP4), \
+	KEY(8, 2, KEY_KP5), \
+	KEY(8, 3, KEY_KP6), \
+	KEY(8, 4, KEY_KPPLUS), \
+	KEY(8, 5, KEY_KP1), \
+	KEY(8, 6, KEY_KP2), \
+	KEY(8, 7, KEY_KP3), \
+	KEY(8, 8, KEY_KP0), \
+};
+/**
+ * struct kbd_platform_data - keymap for spear keyboards
+ * keymap: pointer to array of values encoded with KEY() macro representing
+ * keymap
+ * keymapsize: number of entries (initialized) in this keymap
+ * rep: current values for autorepeat parameters
+ *
+ * This structure is supposed to be used by platform code to supply
+ * keymaps to drivers that implement keyboards.
+ */
+struct kbd_platform_data {
+	int *keymap;
+	unsigned int keymapsize;
+	bool rep;
+};
+
+/* This function is used to set platform data field of pdev->dev */
+static inline void
+kbd_set_plat_data(struct platform_device *pdev, struct kbd_platform_data *data)
+{
+	pdev->dev.platform_data = data;
+}
+#endif /* __PLAT_KEYBOARD_H */
-- 
1.7.2.2

