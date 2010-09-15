From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] input: add support for Nomadik SKE keypad
 controller
Date: Wed, 15 Sep 2010 00:55:14 -0700
Message-ID: <20100915075513.GB28348@core.coreip.homeip.net>
References: <1284535498-9954-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55976 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab0IOHzU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 03:55:20 -0400
Received: by pwi3 with SMTP id 3so62306pwi.19
        for <linux-input@vger.kernel.org>; Wed, 15 Sep 2010 00:55:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1284535498-9954-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-input@vger.kernel.org, Kwangwoo LEE <kwangwoo.lee@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

On Wed, Sep 15, 2010 at 12:54:58PM +0530, Sundar Iyer wrote:
> Add support for the keypad controller in the Scroll Key Encoder (SKE)
> module on the Nomadik family and the DB8500 SoC.
> 
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
> ---
> Thanx a bunch to Dmitry for being such a nice and persistent help :)
> 
> v4:
>  - IRQ handler is no longer threaded
>  - incorporated Dmitry's comments to make sure multikey is working
>  - assorted comments from Trilok
>  - pin configuration mistake pointed out thanx to Kwangwoo LEE
> 
> v3:
>  - fixed Dmitry's comments assorted comments,
>  - re-orged the IRQ to include a timer instead of cpu_relax()
> 
>  arch/arm/plat-nomadik/include/plat/ske.h    |   50 +++
>  drivers/input/keyboard/Kconfig              |   10 +
>  drivers/input/keyboard/Makefile             |    1 +
>  drivers/input/keyboard/nomadik-ske-keypad.c |  456 +++++++++++++++++++++++++++
>  4 files changed, 517 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-nomadik/include/plat/ske.h
>  create mode 100644 drivers/input/keyboard/nomadik-ske-keypad.c
> 
> diff --git a/arch/arm/plat-nomadik/include/plat/ske.h b/arch/arm/plat-nomadik/include/plat/ske.h
> new file mode 100644
> index 0000000..148b2bc
> --- /dev/null
> +++ b/arch/arm/plat-nomadik/include/plat/ske.h
> @@ -0,0 +1,50 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010
> + *
> + * License Terms: GNU General Public License v2
> + * Author: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> + *
> + * ux500 Scroll key and Keypad Encoder (SKE) header
> + */
> +
> +#ifndef __SKE_H
> +#define __SKE_H
> +
> +#include <linux/input/matrix_keypad.h>
> +
> +/* register definitions for SKE peripheral */
> +#define SKE_CR		0x00
> +#define SKE_VAL0	0x04
> +#define SKE_VAL1	0x08
> +#define SKE_DBCR	0x0C
> +#define SKE_IMSC	0x10
> +#define SKE_RIS		0x14
> +#define SKE_MIS		0x18
> +#define SKE_ICR		0x1C
> +
> +/*
> + * Keypad module
> + */
> +
> +/**
> + * struct keypad_platform_data - structure for platform specific data
> + * @init:	pointer to keypad init function
> + * @exit:	pointer to keypad deinitialisation function
> + * @keymap_data: matrix scan code table for keycodes
> + * @krow:	maximum number of rows
> + * @kcol:	maximum number of columns
> + * @debounce_ms: platform specific debounce time
> + * @no_autorepeat: flag for auto repetition
> + * @wakeup_enable: allow waking up the system
> + */
> +struct ske_keypad_platform_data {
> +	int (*init)(void);
> +	int (*exit)(void);
> +	struct matrix_keymap_data *keymap_data;
> +	u8 krow;
> +	u8 kcol;
> +	u8 debounce_ms;
> +	bool no_autorepeat;
> +	bool wakeup_enable;
> +};
> +#endif	/*__SKE_KPD_H*/
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 4f30048..d63f566 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -327,6 +327,16 @@ config KEYBOARD_NEWTON
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called newtonkbd.
>  
> +config KEYBOARD_NOMADIK
> +	tristate "ST-Ericsson Nomadik SKE keyboard"
> +	depends on PLAT_NOMADIK
> +	help
> +	  Say Y here if you want to use a keypad provided on the SKE controller
> +	  used on the Ux500 and Nomadik platforms
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called nmk-ske-keypad.
> +
>  config KEYBOARD_OPENCORES
>  	tristate "OpenCores Keyboard Controller"
>  	help
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 8ac01fb..c13809c 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
>  obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
>  obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
>  obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
> +obj-$(CONFIG_KEYBOARD_NOMADIK)		+= nomadik-ske-keypad.o
>  obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
>  obj-$(CONFIG_KEYBOARD_OMAP4)		+= omap4-keypad.o
>  obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
> diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
> new file mode 100644
> index 0000000..12cd1d2
> --- /dev/null
> +++ b/drivers/input/keyboard/nomadik-ske-keypad.c
> @@ -0,0 +1,456 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010
> + *
> + * Author: Naveen Kumar G <naveen.gaddipati@stericsson.com> for ST-Ericsson
> + * Author: Sundar Iyer <sundar.iyer@stericsson.com> for ST-Ericsson
> + *
> + * License terms:GNU General Public License (GPL) version 2
> + *
> + * Keypad controller driver for the SKE (Scroll Key Encoder) module used in
> + * the Nomadik 8815 and Ux500 platforms.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/io.h>
> +#include <linux/input.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +
> +#include <plat/ske.h>
> +
> +/* SKE_CR bits */
> +#define SKE_KPMLT	(0x1 << 6)
> +#define SKE_KPCN	(0x7 << 3)
> +#define SKE_KPASEN	(0x1 << 2)
> +#define SKE_KPASON	(0x1 << 7)
> +
> +/* SKE_IMSC bits */
> +#define SKE_KPIMA	(0x1 << 2)
> +
> +/* SKE_ICR bits */
> +#define SKE_KPICS	(0x1 << 3)
> +#define SKE_KPICA	(0x1 << 2)
> +
> +/* SKE_RIS bits */
> +#define SKE_KPRISA	(0x1 << 2)
> +
> +#define SKE_KEYPAD_ROW_SHIFT	3
> +#define SKE_KPD_KEYMAP_SIZE	(8 * 8)
> +
> +/* keypad auto scan registers */
> +#define SKE_ASR0	0x20
> +#define SKE_ASR1	0x24
> +#define SKE_ASR2	0x28
> +#define SKE_ASR3	0x2C
> +
> +#define SKE_NUM_ASRX_REGISTERS	(4)
> +
> +/**
> + * struct ske_keypad  - data structure used by keypad driver
> + * @irq:	irq no
> + * @reg_base:	ske regsiters base address
> + * @input:	pointer to input device object
> + * @board:	keypad platform device
> + * @keymap:	matrix scan code table for keycodes
> + * @clk:	clock structure pointer
> + */
> +struct ske_keypad {
> +	int irq;
> +	void __iomem *reg_base;
> +	struct input_dev *input;
> +	const struct ske_keypad_platform_data *board;
> +	unsigned short keymap[SKE_KPD_KEYMAP_SIZE];
> +	struct clk *clk;
> +	spinlock_t ske_keypad_lock;
> +	struct timer_list timer;
> +};
> +
> +static void ske_keypad_set_bits(struct ske_keypad *keypad, u16 addr,
> +		u8 mask, u8 data)
> +{
> +	u32 ret;
> +
> +	spin_lock(&keypad->ske_keypad_lock);
> +
> +	ret = readl(keypad->reg_base + addr);
> +	ret &= ~mask;
> +	ret |= data;
> +	writel(ret, keypad->reg_base + addr);
> +
> +	spin_unlock(&keypad->ske_keypad_lock);
> +}
> +
> +/*
> + * ske_keypad_chip_init : init keypad controller configuration
> + *
> + * Enable Multi key press detection, auto scan mode
> + */
> +static int __devinit ske_keypad_chip_init(struct ske_keypad *keypad)
> +{
> +	u32 value;
> +	int timeout = 50;
> +
> +	/* check SKE_RIS to be 0 */
> +	while ((readl(keypad->reg_base + SKE_RIS) != 0x00000000) && timeout--)
> +		cpu_relax();
> +
> +	if (!timeout)
> +		return -EINVAL;
> +
> +	/*
> +	 * set debounce value
> +	 * keypad dbounce is configured in DBCR[15:8]
> +	 * dbounce value in steps of 32/32.768 ms
> +	 */
> +	spin_lock(&keypad->ske_keypad_lock);
> +	value = readl(keypad->reg_base + SKE_DBCR);
> +	value = value & 0xff;
> +	value |= ((keypad->board->debounce_ms * 32000)/32768) << 8;
> +	writel(value, keypad->reg_base + SKE_DBCR);
> +	spin_unlock(&keypad->ske_keypad_lock);
> +
> +	/* enable multi key detection */
> +	ske_keypad_set_bits(keypad, SKE_CR, 0x0, SKE_KPMLT);
> +
> +	/*
> +	 * set up the number of columns
> +	 * KPCN[5:3] defines no. of keypad columns to be auto scanned
> +	 */
> +	value = (keypad->board->kcol - 1) << 3;
> +	ske_keypad_set_bits(keypad, SKE_CR, SKE_KPCN, value);
> +
> +	/* clear keypad interrupt for auto(and pending SW) scans */
> +	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA | SKE_KPICS);
> +
> +	/* un-mask keypad interrupts */
> +	ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
> +
> +	/* enable automatic scan */
> +	ske_keypad_set_bits(keypad, SKE_CR, 0x0, SKE_KPASEN);
> +
> +	return 0;
> +}
> +
> +static void ske_keypad_read_data(struct ske_keypad *keypad)
> +{
> +	struct input_dev *input = keypad->input;
> +	u16 status;
> +	int col = 0, row = 0, code;
> +	int ske_asr, ske_ris, key_pressed, i;
> +
> +	/*
> +	 * Read the auto scan registers
> +	 *
> +	 * Each SKE_ASRx (x=0 to x=3) contains two row values.
> +	 * lower byte contains row value for coloumn 2*x,
> +	 * upper byte contains row value for column 2*x + 1
> +	 */
> +	for (i = 0; i < SKE_NUM_ASRX_REGISTERS; i++) {
> +		ske_asr = readl(keypad->reg_base + SKE_ASR0 + (4 * i));
> +		if (!ske_asr)
> +			continue;
> +
> +		/* now that ASRx is zero, find out the coloumn x and row y*/
> +		if (ske_asr & 0xff) {
> +			col = i * 2;
> +			status = ske_asr & 0xff;
> +		} else {
> +			col = (i * 2) + 1;
> +			status = (ske_asr & 0xff00) >> 8;
> +		}
> +
> +		/* find out the row */
> +		row = __ffs(status);
> +
> +		code = MATRIX_SCAN_CODE(row, col, SKE_KEYPAD_ROW_SHIFT);
> +		ske_ris = readl(keypad->reg_base + SKE_RIS);
> +		key_pressed = ske_ris & SKE_KPRISA;
> +
> +		input_event(input, EV_MSC, MSC_SCAN, code);
> +		input_report_key(input, keypad->keymap[code], key_pressed);
> +		input_sync(input);
> +	}
> +}
> +
> +static void ske_keypad_timer(unsigned long data)
> +{
> +	struct ske_keypad *keypad = (struct ske_keypad *)data;
> +	int ske_kpason;
> +	int timeout = keypad->board->debounce_ms;
> +
> +	ske_kpason = readl(keypad->reg_base + SKE_CR) & SKE_KPASON;
> +	if (ske_kpason) {
> +		mod_timer(&keypad->timer, jiffies + msecs_to_jiffies(timeout));
> +	} else {
> +		/* read data registers and report event */
> +		ske_keypad_read_data(keypad);
> +
> +		/* enable auto scan interrupts */
> +		ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
> +	}
> +}
> +
> +static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
> +{
> +	struct ske_keypad *keypad = dev_id;
> +	int timeout = keypad->board->debounce_ms;
> +	int ske_kpason;
> +
> +	/* disable auto scan interrupt; mask the interrupt generated */
> +	ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
> +	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA);
> +
> +	mod_timer(&keypad->timer, jiffies + 2);
> +

I expected you would do "return IRQ_HANDLED;" here so that hardware
polling is done exclusively in timer handler.


> +	/*
> +	 * if KPASON is not ready, we cannot read data registers
> +	 * so schedule a timer to fire after a debounce period
> +	 */
> +	ske_kpason = readl(keypad->reg_base + SKE_CR) & SKE_KPASON;
> +	if (!ske_kpason) {
> +		/*
> +		 * KPASON behaved nicely and we can read data registers
> +		 * and report event
> +		 */
> +		ske_keypad_read_data(keypad);
> +
> +		/* enable auto scan interrupts */
> +		ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +

Thanks.

-- 
Dmitry
