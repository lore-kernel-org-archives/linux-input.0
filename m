From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 21/74] ST SPEAr : Added keyboard support
Date: Mon, 30 Aug 2010 09:48:25 -0700
Message-ID: <20100830164825.GA28186@core.coreip.homeip.net>
References: <cover.1283161023.git.viresh.kumar@st.com>
 <b62c01f06f5090775271a5f779db8508638eff15.1283161023.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38917 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010Ab0H3Qsb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Aug 2010 12:48:31 -0400
Received: by pzk9 with SMTP id 9so2136172pzk.19
        for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 09:48:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b62c01f06f5090775271a5f779db8508638eff15.1283161023.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh KUMAR <viresh.kumar@st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, shiraz.hashim@st.com, vipin.kumar@st.com, deepak.sikri@st.com, armando.visconti@st.com, vipulkumar.samar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com

Hi Rajeev,

On Mon, Aug 30, 2010 at 04:13:01PM +0530, Viresh KUMAR wrote:
> From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> 
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/mach-spear13xx/clock.c                |    2 +-
>  arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
>  arch/arm/mach-spear13xx/spear1300_evb.c        |   14 +
>  arch/arm/mach-spear13xx/spear13xx.c            |   19 ++
>  arch/arm/mach-spear3xx/clock.c                 |   12 +
>  arch/arm/mach-spear3xx/include/mach/generic.h  |    1 +
>  arch/arm/mach-spear3xx/spear300.c              |   19 ++
>  arch/arm/mach-spear3xx/spear300_evb.c          |   14 +
>  arch/arm/plat-spear/include/plat/keyboard.h    |  154 +++++++++++
>  drivers/input/keyboard/Kconfig                 |    8 +
>  drivers/input/keyboard/Makefile                |    1 +
>  drivers/input/keyboard/spear-keyboard.c        |  335 ++++++++++++++++++++++++
>  12 files changed, 579 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/plat-spear/include/plat/keyboard.h
>  create mode 100644 drivers/input/keyboard/spear-keyboard.c
> 

First of all, please split platform modifications from the driver itself
(as I care about the latter but less about the former).

> diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
> index 9252940..c48b779 100644
> --- a/arch/arm/mach-spear13xx/clock.c
> +++ b/arch/arm/mach-spear13xx/clock.c
> @@ -801,7 +801,7 @@ static struct clk_lookup spear_clk_lookups[] = {
>  	{.dev_id = "ssp",		.clk = &ssp_clk},
>  	{.dev_id = "gpio0",		.clk = &gpio0_clk},
>  	{.dev_id = "gpio1",		.clk = &gpio1_clk},
> -	{.dev_id = "kbd",		.clk = &kbd_clk},
> +	{.dev_id = "keyboard",		.clk = &kbd_clk},
>  	{.dev_id = "wdt",		.clk = &wdt_clk},
>  };
>  
> diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
> index 7e5d7e1..19c5de0 100644
> --- a/arch/arm/mach-spear13xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear13xx/include/mach/generic.h
> @@ -33,6 +33,7 @@ extern struct amba_device uart_device;
>  extern struct platform_device ehci0_device;
>  extern struct platform_device ehci1_device;
>  extern struct platform_device i2c_device;
> +extern struct platform_device kbd_device;
>  extern struct platform_device ohci0_device;
>  extern struct platform_device ohci1_device;
>  extern struct platform_device rtc_device;
> diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
> index 0a6d26f..0cdad7a 100644
> --- a/arch/arm/mach-spear13xx/spear1300_evb.c
> +++ b/arch/arm/mach-spear13xx/spear1300_evb.c
> @@ -16,6 +16,7 @@
>  #include <asm/mach-types.h>
>  #include <mach/generic.h>
>  #include <mach/spear.h>
> +#include <plat/keyboard.h>
>  
>  static struct amba_device *amba_devs[] __initdata = {
>  	&uart_device,
> @@ -25,15 +26,28 @@ static struct platform_device *plat_devs[] __initdata = {
>  	&ehci0_device,
>  	&ehci1_device,
>  	&i2c_device,
> +	&kbd_device,
>  	&ohci0_device,
>  	&ohci1_device,
>  	&rtc_device,
>  };
>  
> +/* keyboard specific platform data */
> +static DECLARE_KEYMAP(spear_keymap);
> +
> +static struct kbd_platform_data kbd_data = {
> +	.keymap = spear_keymap,
> +	.keymapsize = ARRAY_SIZE(spear_keymap),
> +	.rep = 1,
> +};
> +
>  static void __init spear1300_evb_init(void)
>  {
>  	unsigned int i;
>  
> +	/* set keyboard plat data */
> +	kbd_set_plat_data(&kbd_device, &kbd_data);
> +
>  	/* call spear1300 machine init function */
>  	spear1300_init();
>  
> diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
> index c8f1aff..342fcd9 100644
> --- a/arch/arm/mach-spear13xx/spear13xx.c
> +++ b/arch/arm/mach-spear13xx/spear13xx.c
> @@ -166,6 +166,25 @@ struct platform_device ohci1_device = {
>  	.resource = ohci1_resources,
>  };
>  
> +/* keyboard device registration */
> +static struct resource kbd_resources[] = {
> +	{
> +		.start = SPEAR13XX_KBD_BASE,
> +		.end = SPEAR13XX_KBD_BASE + SZ_1K - 1,
> +		.flags = IORESOURCE_MEM,
> +	}, {
> +		.start = IRQ_KBD,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device kbd_device = {
> +	.name = "keyboard",
> +	.id = -1,
> +	.num_resources = ARRAY_SIZE(kbd_resources),
> +	.resource = kbd_resources,
> +};
> +
>  /* rtc device registration */
>  static struct resource rtc_resources[] = {
>  	{
> diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
> index 79f0159..3a26622 100644
> --- a/arch/arm/mach-spear3xx/clock.c
> +++ b/arch/arm/mach-spear3xx/clock.c
> @@ -470,6 +470,15 @@ static struct clk i2c1_clk = {
>  };
>  #endif
>  
> +#ifdef CONFIG_MACH_SPEAR300
> +/* keyboard clock */
> +static struct clk kbd_clk = {
> +	.flags = ALWAYS_ENABLED,
> +	.pclk = &apb_clk,
> +	.recalc = &follow_parent,
> +};
> +#endif
> +
>  /* array of all spear 3xx clock lookups */
>  static struct clk_lookup spear_clk_lookups[] = {
>  	{ .con_id = "apb_pclk",	.clk = &dummy_apb_pclk},
> @@ -511,6 +520,9 @@ static struct clk_lookup spear_clk_lookups[] = {
>  	{ .dev_id = "adc",		.clk = &adc_clk},
>  	{ .dev_id = "ssp",		.clk = &ssp_clk},
>  	{ .dev_id = "gpio",		.clk = &gpio_clk},
> +#ifdef CONFIG_MACH_SPEAR300
> +	{ .dev_id = "keyboard",		.clk = &kbd_clk},
> +#endif
>  #ifdef CONFIG_MACH_SPEAR320
>  	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
>  #endif
> diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
> index 3eb2737..70f7ee2 100644
> --- a/arch/arm/mach-spear3xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear3xx/include/mach/generic.h
> @@ -108,6 +108,7 @@ extern struct pmx_driver pmx_driver;
>  /* Add spear300 machine device structure declarations here */
>  extern struct amba_device clcd_device;
>  extern struct amba_device gpio1_device;
> +extern struct platform_device kbd_device;
>  
>  /* pad mux modes */
>  extern struct pmx_mode nand_mode;
> diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
> index 5d8df00..fa314e9 100644
> --- a/arch/arm/mach-spear3xx/spear300.c
> +++ b/arch/arm/mach-spear3xx/spear300.c
> @@ -407,6 +407,25 @@ struct amba_device gpio1_device = {
>  	.irq = {VIRQ_GPIO1, NO_IRQ},
>  };
>  
> +/* keyboard device registration */
> +static struct resource kbd_resources[] = {
> +	{
> +		.start = SPEAR300_KEYBOARD_BASE,
> +		.end = SPEAR300_KEYBOARD_BASE + SZ_1K - 1,
> +		.flags = IORESOURCE_MEM,
> +	}, {
> +		.start = VIRQ_KEYBOARD,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device kbd_device = {
> +	.name = "keyboard",
> +	.id = -1,
> +	.num_resources = ARRAY_SIZE(kbd_resources),
> +	.resource = kbd_resources,
> +};
> +
>  /* spear3xx shared irq */
>  struct shirq_dev_config shirq_ras1_config[] = {
>  	{
> diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
> index 3b3c6ce..afb773e 100644
> --- a/arch/arm/mach-spear3xx/spear300_evb.c
> +++ b/arch/arm/mach-spear3xx/spear300_evb.c
> @@ -15,6 +15,7 @@
>  #include <asm/mach-types.h>
>  #include <mach/generic.h>
>  #include <mach/spear.h>
> +#include <plat/keyboard.h>
>  
>  /* padmux devices to enable */
>  static struct pmx_dev *pmx_devs[] = {
> @@ -51,6 +52,16 @@ static struct platform_device *plat_devs[] __initdata = {
>  	&rtc_device,
>  
>  	/* spear300 specific devices */
> +	&kbd_device,
> +};
> +
> +/* keyboard specific platform data */
> +static DECLARE_KEYMAP(spear_keymap);
> +
> +static struct kbd_platform_data kbd_data = {
> +	.keymap = spear_keymap,
> +	.keymapsize = ARRAY_SIZE(spear_keymap),
> +	.rep = 1,
>  };
>  
>  static void __init spear300_evb_init(void)
> @@ -62,6 +73,9 @@ static void __init spear300_evb_init(void)
>  	pmx_driver.devs = pmx_devs;
>  	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
>  
> +	/* set keyboard plat data */
> +	kbd_set_plat_data(&kbd_device, &kbd_data);
> +
>  	/* call spear300 machine init function */
>  	spear300_init();
>  
> diff --git a/arch/arm/plat-spear/include/plat/keyboard.h b/arch/arm/plat-spear/include/plat/keyboard.h
> new file mode 100644
> index 0000000..8345770
> --- /dev/null
> +++ b/arch/arm/plat-spear/include/plat/keyboard.h
> @@ -0,0 +1,154 @@
> +/*
> + * arch/arm/plat-spear/include/plat/keyboard.h
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Rajeev Kumar<rajeev-dlh.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __PLAT_KEYBOARD_H
> +#define __PLAT_KEYBOARD_H
> +
> +#include <linux/bitops.h>
> +#include <linux/input.h>
> +#include <mach/misc_regs.h>
> +
> +#define KEY(row, col, val) (((row) << 28 | ((col) << 24) | (val)))
> +

Please use definitions from include/linux/input/matrix_keypad.h

> +#define DECLARE_KEYMAP(name) \
> +int name[] = {\
> +	KEY(0, 0, KEY_ESC), \
> +	KEY(0, 1, KEY_1), \
> +	KEY(0, 2, KEY_2), \
> +	KEY(0, 3, KEY_3), \
> +	KEY(0, 4, KEY_4), \
> +	KEY(0, 5, KEY_5), \
> +	KEY(0, 6, KEY_6), \
> +	KEY(0, 7, KEY_7), \
> +	KEY(0, 8, KEY_8), \
> +	KEY(1, 0, KEY_9), \
> +	KEY(1, 1, KEY_MINUS), \
> +	KEY(1, 2, KEY_EQUAL), \
> +	KEY(1, 3, KEY_BACKSPACE), \
> +	KEY(1, 4, KEY_TAB), \
> +	KEY(1, 5, KEY_Q), \
> +	KEY(1, 6, KEY_W), \
> +	KEY(1, 7, KEY_E), \
> +	KEY(1, 8, KEY_R), \
> +	KEY(2, 0, KEY_T), \
> +	KEY(2, 1, KEY_Y), \
> +	KEY(2, 2, KEY_U), \
> +	KEY(2, 3, KEY_I), \
> +	KEY(2, 4, KEY_O), \
> +	KEY(2, 5, KEY_P), \
> +	KEY(2, 6, KEY_LEFTBRACE), \
> +	KEY(2, 7, KEY_RIGHTBRACE), \
> +	KEY(2, 8, KEY_ENTER), \
> +	KEY(3, 0, KEY_LEFTCTRL), \
> +	KEY(3, 1, KEY_A), \
> +	KEY(3, 2, KEY_S), \
> +	KEY(3, 3, KEY_D), \
> +	KEY(3, 4, KEY_F), \
> +	KEY(3, 5, KEY_G), \
> +	KEY(3, 6, KEY_H), \
> +	KEY(3, 7, KEY_J), \
> +	KEY(3, 8, KEY_K), \
> +	KEY(4, 0, KEY_L), \
> +	KEY(4, 1, KEY_SEMICOLON), \
> +	KEY(4, 2, KEY_APOSTROPHE), \
> +	KEY(4, 3, KEY_GRAVE), \
> +	KEY(4, 4, KEY_LEFTSHIFT), \
> +	KEY(4, 5, KEY_BACKSLASH), \
> +	KEY(4, 6, KEY_Z), \
> +	KEY(4, 7, KEY_X), \
> +	KEY(4, 8, KEY_C), \
> +	KEY(4, 0, KEY_L), \
> +	KEY(4, 1, KEY_SEMICOLON), \
> +	KEY(4, 2, KEY_APOSTROPHE), \
> +	KEY(4, 3, KEY_GRAVE), \
> +	KEY(4, 4, KEY_LEFTSHIFT), \
> +	KEY(4, 5, KEY_BACKSLASH), \
> +	KEY(4, 6, KEY_Z), \
> +	KEY(4, 7, KEY_X), \
> +	KEY(4, 8, KEY_C), \
> +	KEY(4, 0, KEY_L), \
> +	KEY(4, 1, KEY_SEMICOLON), \
> +	KEY(4, 2, KEY_APOSTROPHE), \
> +	KEY(4, 3, KEY_GRAVE), \
> +	KEY(4, 4, KEY_LEFTSHIFT), \
> +	KEY(4, 5, KEY_BACKSLASH), \
> +	KEY(4, 6, KEY_Z), \
> +	KEY(4, 7, KEY_X), \
> +	KEY(4, 8, KEY_C), \
> +	KEY(5, 0, KEY_V), \
> +	KEY(5, 1, KEY_B), \
> +	KEY(5, 2, KEY_N), \
> +	KEY(5, 3, KEY_M), \
> +	KEY(5, 4, KEY_COMMA), \
> +	KEY(5, 5, KEY_DOT), \
> +	KEY(5, 6, KEY_SLASH), \
> +	KEY(5, 7, KEY_RIGHTSHIFT), \
> +	KEY(5, 8, KEY_KPASTERISK), \
> +	KEY(6, 0, KEY_LEFTALT), \
> +	KEY(6, 1, KEY_SPACE), \
> +	KEY(6, 2, KEY_CAPSLOCK), \
> +	KEY(6, 3, KEY_F1), \
> +	KEY(6, 4, KEY_F2), \
> +	KEY(6, 5, KEY_F3), \
> +	KEY(6, 6, KEY_F4), \
> +	KEY(6, 7, KEY_F5), \
> +	KEY(6, 8, KEY_F6), \
> +	KEY(7, 0, KEY_F7), \
> +	KEY(7, 1, KEY_F8), \
> +	KEY(7, 2, KEY_F9), \
> +	KEY(7, 3, KEY_F10), \
> +	KEY(7, 4, KEY_NUMLOCK), \
> +	KEY(7, 5, KEY_SCROLLLOCK), \
> +	KEY(7, 6, KEY_KP7), \
> +	KEY(7, 7, KEY_KP8), \
> +	KEY(7, 8, KEY_KP9), \
> +	KEY(8, 0, KEY_KPMINUS), \
> +	KEY(8, 1, KEY_KP4), \
> +	KEY(8, 2, KEY_KP5), \
> +	KEY(8, 3, KEY_KP6), \
> +	KEY(8, 4, KEY_KPPLUS), \
> +	KEY(8, 5, KEY_KP1), \
> +	KEY(8, 6, KEY_KP2), \
> +	KEY(8, 7, KEY_KP3), \
> +	KEY(8, 8, KEY_KP0), \
> +};

Hm, I'd expect this to be in particular board code, not in the header
file.

> +/**
> + * struct kbd_platform_data - keymap for spear keyboards
> + * keymap: pointer to array of values encoded with KEY() macro representing
> + * keymap
> + * keymapsize: number of entries (initialized) in this keymap
> + * rep: current values for autorepeat parameters
> + *
> + * This structure is supposed to be used by platform code to supply
> + * keymaps to drivers that implement keyboards.
> + */
> +struct kbd_platform_data {
> +	int *keymap;
> +	unsigned int keymapsize;
> +	unsigned int rep:1;

Bool please.

> +};
> +
> +/* This function is used to set platform data field of pdev->dev */
> +static inline void
> +kbd_set_plat_data(struct platform_device *pdev, struct kbd_platform_data *data)
> +{
> +#ifdef CONFIG_ARCH_SPEAR13XX
> +#define KBD_PAD_SEL	(BIT(18) | BIT(20) | BIT(22) | BIT(24) | BIT(26))
> +
> +	u32 val;
> +	/* Workaround:Setting bit for routing it to the IP */
> +	val = readl(PAD_FUNCTION_EN_2);
> +	val &= ~KBD_PAD_SEL;
> +	writel(val, PAD_FUNCTION_EN_2);

Why does it belong here?

> +#endif
> +	pdev->dev.platform_data = data;
> +}
> +#endif /* __PLAT_KEYBOARD_H */
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 9cc488d..2d7e3a8 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -424,6 +424,14 @@ config KEYBOARD_OMAP
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called omap-keypad.
>  
> +config KEYBOARD_SPEAR
> +	tristate "ST SPEAR keyboard support"

No arch/platform dependencies?

> +	help
> +	  Say Y here if you want to use the SPEAR keyboard.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called spear-keboard.
> +
>  config KEYBOARD_TWL4030
>  	tristate "TI TWL4030/TWL5030/TPS659x0 keypad support"
>  	depends on TWL4030_CORE
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 504b591..b21c54d 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
>  obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
>  obj-$(CONFIG_KEYBOARD_SAMSUNG)		+= samsung-keypad.o
>  obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
> +obj-$(CONFIG_KEYBOARD_SPEAR)		+= spear-keyboard.o
>  obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
>  obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
>  obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> new file mode 100644
> index 0000000..4f5c734
> --- /dev/null
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -0,0 +1,335 @@
> +/*
> + * drivers/input/keyboard/keyboard-spear.c
> + *
> + * SPEAr Keyboard Driver
> + * Based on omap-keypad driver
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Rajeev Kumar<rajeev-dlh.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <plat/keyboard.h>
> +
> +/* Keyboard Regsiters */
> +#define MODE_REG	0x00	/* 16 bit reg */
> +#define STATUS_REG	0x0C	/* 2 bit reg */
> +#define DATA_REG	0x10	/* 8 bit reg */
> +#define INTR_MASK	0x54
> +
> +/* Register Values */
> +/*
> + * pclk freq mask = (APB FEQ -1)= 82 MHZ.Programme bit 15-9 in mode
> + * control register as 1010010(82MHZ)
> + */
> +#define PCLK_FREQ_MSK	0xA400	/* 82 MHz */
> +#define START_SCAN	0x0100
> +#define SCAN_RATE_10	0x0000
> +#define SCAN_RATE_20	0x0004
> +#define SCAN_RATE_40	0x0008
> +#define SCAN_RATE_80	0x000C
> +#define MODE_KEYBOARD	0x0002
> +#define DATA_AVAIL	0x2
> +
> +#define KEY_MASK	0xFF000000
> +#define KEY_VALUE	0x00FFFFFF
> +#define ROW_MASK	0xF0
> +#define COLUMN_MASK	0x0F
> +#define ROW_SHIFT	4
> +
> +struct spear_kbd {
> +	struct input_dev *input;
> +	void __iomem *io_base;		/* Keyboard Base Address */
> +	struct clk *clk;
> +	int *keymap;

You need a copy of keymap here so that userspace can modify it safely
via EVIOCSKEYCODE.

> +};
> +/* TODO: Need to optimize this function */
> +static inline int get_key_value(struct spear_kbd *dev, int row, int col)
> +{
> +	int i, key;
> +	int *keymap = dev->keymap;
> +
> +	key = KEY(row, col, 0);
> +	for (i = 0; keymap[i] != 0; i++)
> +		if ((keymap[i] & KEY_MASK) == key)
> +			return keymap[i] & KEY_VALUE;
> +	return -ENOKEY;
> +}
> +
> +static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
> +{
> +	struct spear_kbd *dev = dev_id;
> +	static u8 last_key ;
> +	static u8 last_event;

No statics please, pull it into spear_kbd structure.

> +	int key;
> +	u8 sts, val = 0;
> +
> +	if (dev == NULL) {

How can it be?

> +		pr_err("Keyboard: Invalid dev_id in irq handler\n");
> +		return IRQ_NONE;
> +	}
> +
> +	sts = readb(dev->io_base + STATUS_REG);
> +	if (sts & DATA_AVAIL) {
> +		/* following reads active (row, col) pair */
> +		val = readb(dev->io_base + DATA_REG);
> +		key = get_key_value(dev, (val & ROW_MASK)>>ROW_SHIFT, (val
> +					& COLUMN_MASK));
> +
> +		/* valid key press event */
> +		if (key >= 0) {
> +			if (last_event == 1) {
> +				/* check if we missed a release event */
> +				input_report_key(dev->input, last_key,
> +						!last_event);
> +			}
> +			/* notify key press */
> +			last_event = 1;
> +			last_key = key;
> +			input_report_key(dev->input, key, last_event);
> +		} else {
> +			/* notify key release */
> +			last_event = 0;
> +			input_report_key(dev->input, last_key, last_event);
> +		}
> +	} else

Don't you need to clear interrupt here? You got it somehow...

> +		return IRQ_NONE;
> +
> +	/* clear interrupt */
> +	writeb(0, dev->io_base + STATUS_REG);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init spear_kbd_probe(struct platform_device *pdev)
> +{
> +	struct spear_kbd *kbd;
> +	struct kbd_platform_data *pdata = pdev->dev.platform_data;
> +	struct resource *res;
> +	int i, ret, irq;
> +	u16 val = 0;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Invalid platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no keyboard resource defined\n");
> +		return -EBUSY;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
> +		dev_err(&pdev->dev, "keyboard region already claimed\n");
> +		return -EBUSY;
> +	}
> +
> +	kbd = kzalloc(sizeof(*kbd), GFP_KERNEL);
> +	if (!kbd) {
> +		dev_err(&pdev->dev, "out of memory\n");
> +		ret = -ENOMEM;
> +		goto err_release_mem_region;
> +	}
> +
> +	kbd->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(kbd->clk)) {
> +		ret = PTR_ERR(kbd->clk);
> +		goto err_kfree;
> +	}
> +
> +	ret = clk_enable(kbd->clk);
> +	if (ret < 0)
> +		goto err_clk_put;
> +
> +	platform_set_drvdata(pdev, kbd);
> +	kbd->keymap = pdata->keymap; /* key mappings */
> +
> +	kbd->io_base = ioremap(res->start, resource_size(res));
> +	if (!kbd->io_base) {
> +		dev_err(&pdev->dev, "ioremap fail for kbd_region\n");
> +		ret = -ENOMEM;
> +		goto err_clear_plat_data;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "not able to get irq for the device\n");
> +		ret = irq;
> +		goto err_iounmap;
> +	}
> +
> +	ret = request_irq(irq, spear_kbd_interrupt, 0, "keyboard",
> +			kbd);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request_irq fail\n");
> +		goto err_iounmap;
> +	}
> +

Are you 100% sure the device is shut off at this point? Because if it
isn't you risk to get interrupt before you allocated your input device.

> +	kbd->input = input_allocate_device();
> +	if (!kbd->input) {
> +		ret = -ENOMEM;
> +		dev_err(&pdev->dev, "input device allocation fail\n");
> +		goto err_free_irq;
> +	}
> +
> +	if (pdata->rep)
> +		__set_bit(EV_REP, kbd->input->evbit);
> +
> +	/* setup input device */
> +	__set_bit(EV_KEY, kbd->input->evbit);
> +
> +	for (i = 0; kbd->keymap[i] != 0; i++)
> +		__set_bit(kbd->keymap[i] & KEY_MAX, kbd->input->keybit);
> +
> +	kbd->input->name = "keyboard";
> +	kbd->input->phys = "keyboard/input0";
> +	kbd->input->dev.parent = &pdev->dev;
> +	kbd->input->id.bustype = BUS_HOST;
> +	kbd->input->id.vendor = 0x0001;
> +	kbd->input->id.product = 0x0001;
> +	kbd->input->id.version = 0x0100;
> +
> +	ret = input_register_device(kbd->input);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Unable to register keyboard device\n");
> +		goto err_free_dev;
> +	}
> +
> +	/* program keyboard */
> +	val |= SCAN_RATE_80 | MODE_KEYBOARD | PCLK_FREQ_MSK;
> +	writew(val, kbd->io_base + MODE_REG);
> +
> +	writeb(1, kbd->io_base + STATUS_REG);
> +
> +	/* start key scan */
> +	val |= START_SCAN;
> +	writew(val, kbd->io_base + MODE_REG);

This should go into open() method.

> +
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	return 0;
> +
> +err_free_dev:
> +	input_free_device(kbd->input);
> +err_free_irq:
> +	free_irq(irq, pdev);
> +err_iounmap:
> +	iounmap(kbd->io_base);
> +err_clear_plat_data:
> +	platform_set_drvdata(pdev, NULL);
> +	clk_disable(kbd->clk);
> +err_clk_put:
> +	clk_put(kbd->clk);
> +err_kfree:
> +	kfree(kbd);
> +err_release_mem_region:
> +	release_mem_region(res->start, resource_size(res));
> +
> +	return ret;
> +}
> +
> +static int spear_kbd_remove(struct platform_device *pdev)
> +{
> +	struct spear_kbd *kbd = platform_get_drvdata(pdev);
> +	struct resource *res;
> +	u16 val;
> +	int irq;
> +
> +	val = readw(kbd->io_base + MODE_REG);
> +	val &= ~START_SCAN;
> +	writew(val, kbd->io_base + MODE_REG);

Need to go into close() method.

> +
> +	/* unregister input device */
> +	input_unregister_device(kbd->input);
> +	input_free_device(kbd->input);

No free after unregister.

> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq)
> +		free_irq(irq, pdev);

Can it ever be 0 here?

> +
> +	iounmap(kbd->io_base);
> +	platform_set_drvdata(pdev, NULL);
> +	clk_disable(kbd->clk);
> +	clk_put(kbd->clk);
> +	kfree(kbd);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res)
> +		release_mem_region(res->start, resource_size(res));
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int spear_kbd_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct spear_kbd *kbd = platform_get_drvdata(pdev);
> +	int irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	clk_disable(kbd->clk);
> +	if (device_may_wakeup(&pdev->dev))
> +		enable_irq_wake(irq);
> +
> +	return 0;
> +}
> +
> +static int spear_kbd_resume(struct platform_device *pdev)
> +{
> +	struct spear_kbd *kbd = platform_get_drvdata(pdev);
> +	int irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (device_may_wakeup(&pdev->dev))
> +		disable_irq_wake(irq);
> +	clk_enable(kbd->clk);
> +
> +	return 0;
> +}
> +#else
> +#define spear_kbd_suspend	NULL
> +#define spear_kbd_resume	NULL
> +#endif
> +
> +static struct platform_driver spear_kbd_driver = {
> +	.probe		= spear_kbd_probe,
> +	.remove		= spear_kbd_remove,
> +	.suspend	= spear_kbd_suspend,
> +	.resume		= spear_kbd_resume,

Switch to dev_pm_ops please.

> +	.driver		= {
> +		.name	= "keyboard",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __devinit spear_kbd_init(void)
> +{
> +	return platform_driver_register(&spear_kbd_driver);
> +}
> +module_init(spear_kbd_init);
> +
> +static void __exit spear_kbd_exit(void)
> +{
> +	platform_driver_unregister(&spear_kbd_driver);
> +}
> +module_exit(spear_kbd_exit);
> +
> +MODULE_AUTHOR("Rajeev Kumar");
> +MODULE_DESCRIPTION("SPEAr Keyboard Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.2.2
> 

Thanks.

-- 
Dmitry
