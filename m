From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] intel_mid: Keypad Driver
Date: Tue, 8 Feb 2011 00:19:41 -0800
Message-ID: <20110208081941.GD865@core.coreip.homeip.net>
References: <20110201113513.24707.6283.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33449 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab1BHITs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Feb 2011 03:19:48 -0500
Received: by iwn9 with SMTP id 9so5480762iwn.19
        for <linux-input@vger.kernel.org>; Tue, 08 Feb 2011 00:19:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110201113513.24707.6283.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

On Tue, Feb 01, 2011 at 11:36:09AM +0000, Alan Cox wrote:
> From: Zheng Ba <zheng.ba@intel.com>
> 
> This is a single patch of the Intel Moorestown keypad driver made up from
> the following
> 
> 
> Zheng Ba <zheng.ba@intel.com>
> 	This patch adds the keypad support for the MID platform keypad
> 	interfaces.
> 
> 	Changes from Alpha2: solved "CRITICAL" issues marked by Klocwork
> 		     HSD sighting 3469242
> 
> 	(some tidying Alan Cox)
> 
> Jekyll Lai <jekyll_lai@wistron.com>
> 	Rewrite keypad driver to keep only one default matrix keymap. Also add
> 	an interface to pass the platform data via "mrst_keypad_set_pdata."
> 	Howerver, this keypad controller also provides direct key function.
> 	That one matrix keymap is not enough in this driver. It's necessary
> 	that adding another default keymap for direct key. So, there would
> 	be two default keymaps. One for the keypad matrix; one for direct
> 	keys.

There should be only one keymap per device. You can:

1. Add "direct" keys as an additional row to the main keymap
2. Set up a separate input device for direct keys.

> Alan Cox <alan@linux.intel.com>
> 	Fix abuse of disable_irq/enable_irq on a shared IRQ line.
> 
> Signed-off-by: Zheng Ba <zheng.ba@intel.com>
> Signed-off-by: Jekyll Lai <jekyll_lai@wistron.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/input/keyboard/Kconfig            |    7 
>  drivers/input/keyboard/Makefile           |    1 
>  drivers/input/keyboard/intel_mid_keypad.c |  700 +++++++++++++++++++++++++++++
>  include/linux/input/intel_mid_keypad.h    |   32 +
>  4 files changed, 740 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/keyboard/intel_mid_keypad.c
>  create mode 100644 include/linux/input/intel_mid_keypad.h
> 
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index c7a9202..0c8869b 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -324,6 +324,13 @@ config KEYBOARD_IMX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called imx_keypad.
>  
> +config KEYBOARD_INTEL_MID
> +	tristate "Intel MID keypad support"
> +	depends on GPIO_LANGWELL
> +	help
> +	  Say Y if you want support for Intel MID keypad devices
> +	  depends on GPIO_LANGWELL
> +

To compile this driver as a module...

>  config KEYBOARD_NEWTON
>  	tristate "Newton keyboard"
>  	select SERIO
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 468c627..15eff1b 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
>  obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
>  obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
>  obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
> +obj-$(CONFIG_KEYBOARD_INTEL_MID)	+= intel_mid_keypad.o

Alphabetic order please.

>  obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
>  obj-$(CONFIG_KEYBOARD_GPIO_POLLED)	+= gpio_keys_polled.o
>  obj-$(CONFIG_KEYBOARD_TCA6416)		+= tca6416-keypad.o
> diff --git a/drivers/input/keyboard/intel_mid_keypad.c b/drivers/input/keyboard/intel_mid_keypad.c
> new file mode 100644
> index 0000000..89ea025
> --- /dev/null
> +++ b/drivers/input/keyboard/intel_mid_keypad.c
> @@ -0,0 +1,700 @@
> +/*
> + * Driver for the matrix keypad controller on MID platform.
> + *
> + * Copyright (c) 2009 Intel Corporation.
> + * Created:	Sep 18, 2008
> + * Updated:	May 14, 2010
> + * Copyright (C) 2011 Jekyll Lai, Wistron <jekyll_lai@wistron.com>
> + *
> + * Based on pxa27x_keypad.c by Rodolfo Giometti <giometti@linux.it>
> + * pxa27x_keypad.c is based on a previous implementation by Kevin O'Connor
> + * <kevin_at_keconnor.net> and Alex Osborne <bobofdoom@gmail.com> and
> + * on some suggestions by Nicolas Pitre <nico@cam.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +
> +#define DRV_NAME	"mrst_keypad"
> +#define DRV_VERSION	"1.3"
> +#define MRST_KEYPAD_DRIVER_NAME   DRV_NAME " " DRV_VERSION
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/input/intel_mid_keypad.h>
> +
> +/*
> + * Keypad Controller registers
> + */
> +#define KPC             0x0000 /* Keypad Control register */
> +#define KPDK            0x0004 /* Keypad Direct Key register */
> +#define KPREC           0x0008 /* Keypad Rotary Encoder register */
> +#define KPMK            0x000C /* Keypad Matrix Key register */
> +#define KPAS            0x0010 /* Keypad Automatic Scan register */
> +
> +/* Keypad Automatic Scan Multiple Key Presser register 0-3 */
> +#define KPASMKP0        0x0014
> +#define KPASMKP1        0x0018
> +#define KPASMKP2        0x001C
> +#define KPASMKP3        0x0020
> +#define KPKDI           0x0024
> +
> +/* bit definitions */
> +#define KPC_MKRN(n)	((((n) - 1) & 0x7) << 26) /* matrix key row number */
> +#define KPC_MKCN(n)	((((n) - 1) & 0x7) << 23) /* matrix key col number */
> +#define KPC_DKN(n)	((((n) - 1) & 0x7) << 6)  /* direct key number */
> +
> +#define KPC_AS          (0x1 << 30)  /* Automatic Scan bit */
> +#define KPC_ASACT       (0x1 << 29)  /* Automatic Scan on Activity */
> +#define KPC_MI          (0x1 << 22)  /* Matrix interrupt bit */
> +#define KPC_IMKP        (0x1 << 21)  /* Ignore Multiple Key Press */
> +
> +#define KPC_MS(n)	(0x1 << (13 + (n)))	/* Matrix scan line 'n' */
> +#define KPC_MS_ALL      (0xff << 13)
> +
> +#define KPC_ME          (0x1 << 12)  /* Matrix Keypad Enable */
> +#define KPC_MIE         (0x1 << 11)  /* Matrix Interrupt Enable */
> +#define KPC_DK_DEB_SEL	(0x1 <<  9)  /* Direct Keypad Debounce Select */
> +#define KPC_DI          (0x1 <<  5)  /* Direct key interrupt bit */
> +#define KPC_RE_ZERO_DEB (0x1 <<  4)  /* Rotary Encoder Zero Debounce */
> +#define KPC_REE1        (0x1 <<  3)  /* Rotary Encoder1 Enable */
> +#define KPC_REE0        (0x1 <<  2)  /* Rotary Encoder0 Enable */
> +#define KPC_DE          (0x1 <<  1)  /* Direct Keypad Enable */
> +#define KPC_DIE         (0x1 <<  0)  /* Direct Keypad interrupt Enable */
> +
> +#define KPDK_DKP        (0x1 << 31)
> +#define KPDK_DK(n)	((n) & 0xff)
> +
> +#define KPREC_OF1       (0x1 << 31)
> +#define kPREC_UF1       (0x1 << 30)
> +#define KPREC_OF0       (0x1 << 15)
> +#define KPREC_UF0       (0x1 << 14)
> +
> +#define KPREC_RECOUNT0(n)	((n) & 0xff)
> +#define KPREC_RECOUNT1(n)	(((n) >> 16) & 0xff)
> +
> +#define KPMK_MKP        (0x1 << 31)
> +#define KPAS_SO         (0x1 << 31)
> +#define KPASMKPx_SO     (0x1 << 31)
> +
> +#define KPAS_MUKP(n)	(((n) >> 26) & 0x1f)
> +#define KPAS_RP(n)	(((n) >> 4) & 0xf)
> +#define KPAS_CP(n)	((n) & 0xf)
> +
> +#define KPASMKP_MKC_MASK	(0xff)
> +
> +#define	KEYPAD_MATRIX_GPIO_IN_PIN	24
> +#define	KEYPAD_MATRIX_GPIO_OUT_PIN	32
> +#define KEYPAD_DIRECT_GPIO_IN_PIN	40
> +
> +#define keypad_readl(off)	readl(keypad->mmio_base + (off))
> +#define keypad_writel(off, v)	writel((v), keypad->mmio_base + (off))
> +
> +#define MAX_MATRIX_KEY_NUM	(8 * 8)
> +#define MAX_DIRECT_KEY_NUM	(4)
> +
> +#define MAX_MATRIX_KEY_ROWS	(8)
> +#define MAX_MATRIX_KEY_COLS	(8)
> +#define MATRIX_ROW_SHIFT 3
> +#define DEBOUNCE_INTERVAL	100
> +
> +#define KEY_HALFSHUTTER		KEY_PROG1
> +#define KEY_FULLSHUTTER		KEY_CAMERA
> +
> +static unsigned int mrst_default_keymap[] = {
> +	KEY(0, 0, KEY_1),
> +	KEY(0, 1, KEY_8),
> +	KEY(0, 2, KEY_T),
> +	KEY(0, 3, KEY_S),
> +	KEY(0, 4, KEY_L),
> +	KEY(0, 5, KEY_N),
> +
> +	KEY(1, 0, KEY_2),
> +	KEY(1, 1, KEY_9),
> +	KEY(1, 2, KEY_Y),
> +	KEY(1, 3, KEY_D),
> +	KEY(1, 4, KEY_BACKSPACE),
> +	KEY(1, 5, KEY_M),
> +
> +	KEY(2, 0, KEY_3),
> +	KEY(2, 1, KEY_0),
> +	KEY(2, 2, KEY_U),
> +	KEY(2, 3, KEY_F),
> +	KEY(2, 4, KEY_Z),
> +	KEY(2, 5, KEY_F23),
> +
> +	KEY(3, 0, KEY_4),
> +	KEY(3, 1, KEY_Q),
> +	KEY(3, 2, KEY_I),
> +	KEY(3, 3, KEY_G),
> +	KEY(3, 4, KEY_X),
> +	KEY(3, 5, KEY_F24),
> +
> +	KEY(4, 0, KEY_5),
> +	KEY(4, 1, KEY_W),
> +	KEY(4, 2, KEY_O),
> +	KEY(4, 3, KEY_H),
> +	KEY(4, 4, KEY_C),
> +	KEY(4, 5, KEY_COMMA),
> +
> +	KEY(5, 0, KEY_6),
> +	KEY(5, 1, KEY_E),
> +	KEY(5, 2, KEY_P),
> +	KEY(5, 3, KEY_J),
> +	KEY(5, 4, KEY_V),
> +	KEY(5, 5, KEY_DOT),
> +
> +	KEY(6, 0, KEY_7),
> +	KEY(6, 1, KEY_R),
> +	KEY(6, 2, KEY_A),
> +	KEY(6, 3, KEY_K),
> +	KEY(6, 4, KEY_B),
> +	KEY(6, 5, KEY_SPACE),
> +
> +	KEY(7, 0, KEY_LEFTSHIFT),
> +	KEY(7, 1, KEY_RIGHTALT),
> +	KEY(7, 2, KEY_ENTER),
> +};
> +
> +/* default direct key map */
> +static const u32 mrst_default_direct_keymap[] = {
> +	KEY(0, 0, KEY_VOLUMEUP),
> +	KEY(0, 1, KEY_VOLUMEDOWN),
> +	KEY(0, 2, KEY_HALFSHUTTER),
> +	KEY(0, 3, KEY_FULLSHUTTER),
> +};
> +
> +static const struct mrst_keypad_platform_data *mrst_keypad_pdata;
> +
> +static const struct matrix_keymap_data mrst_default_keymap_data = {
> +	.keymap = mrst_default_keymap,
> +	.keymap_size = ARRAY_SIZE(mrst_default_keymap),
> +};
> +
> +static const struct matrix_keymap_data mrst_default_direct_keymap_data = {
> +	.keymap = mrst_default_direct_keymap,
> +	.keymap_size = ARRAY_SIZE(mrst_default_direct_keymap),
> +};
> +
> +struct mrst_keypad {
> +	struct input_dev *input_dev;
> +	void __iomem *mmio_base;
> +	unsigned int irq;
> +
> +	unsigned int	matrix_key_rows;
> +	unsigned int	matrix_key_cols;
> +	int		matrix_key_map_size;
> +
> +	/* key debounce interval */
> +	unsigned int	debounce_interval;
> +
> +	const struct matrix_keymap_data *keymap_data;
> +
> +	/* state row bits of each column scan */
> +	uint32_t matrix_key_state[MAX_MATRIX_KEY_COLS];
> +	uint32_t direct_key_state;
> +
> +	unsigned int direct_key_mask;
> +
> +	int direct_key_num;
> +
> +	const struct matrix_keymap_data *direct_keymap_data;
> +
> +	unsigned short keycode[MAX_MATRIX_KEY_NUM];
> +	unsigned short direct_keycode[MAX_DIRECT_KEY_NUM];
> +
> +	/* rotary encoders 0 */
> +	int enable_rotary0;
> +	int rotary0_rel_code;
> +	int rotary0_up_key;
> +	int rotary0_down_key;
> +
> +	/* rotary encoders 1 */
> +	int enable_rotary1;
> +	int rotary1_rel_code;
> +	int rotary1_up_key;
> +	int rotary1_down_key;
> +
> +	int rotary_rel_code[2];
> +	int rotary_up_key[2];
> +	int rotary_down_key[2];
> +};
> +
> +static void mrst_keypad_build_keycode(struct mrst_keypad *keypad)
> +{
> +	struct input_dev *input_dev = keypad->input_dev;
> +	const struct matrix_keymap_data *keymap_data;
> +	const struct matrix_keymap_data *direct_keymap_data;
> +
> +	keypad->matrix_key_rows = MAX_MATRIX_KEY_ROWS;
> +	keypad->matrix_key_cols = MAX_MATRIX_KEY_COLS;
> +	keypad->matrix_key_map_size = MAX_MATRIX_KEY_NUM;
> +	keypad->debounce_interval = DEBOUNCE_INTERVAL;
> +	keymap_data = &mrst_default_keymap_data;
> +
> +	if (mrst_keypad_pdata) {
> +		if (mrst_keypad_pdata->keymap_data)
> +			keymap_data = mrst_keypad_pdata->keymap_data;
> +
> +		if (mrst_keypad_pdata->direct_key_num) {
> +			keypad->direct_key_num =
> +				mrst_keypad_pdata->direct_key_num;
> +			direct_keymap_data =
> +				mrst_keypad_pdata->direct_keymap_data ?:
> +				&mrst_default_direct_keymap_data;
> +		}
> +		keypad->enable_rotary0 = mrst_keypad_pdata->enable_rotary0 ?: 0;
> +		keypad->enable_rotary1 = mrst_keypad_pdata->enable_rotary1 ?: 0;
> +	}
> +

Also need to set up input_dev->keycode, keycodemax, keycodesize so that
keymap is adjustable from userspace. Ah, wait, you already do this in
probe()...


> +	matrix_keypad_build_keymap(keymap_data, MATRIX_ROW_SHIFT,
> +		 input_dev->keycode, input_dev->keybit);
> +
> +	if (keypad->direct_key_num) {
> +		matrix_keypad_build_keymap(direct_keymap_data, MATRIX_ROW_SHIFT,
> +			 keypad->direct_keycode, input_dev->keybit);
> +	}
> +}
> +
> +int __init mrst_keypad_set_pdata(const struct mrst_keypad_platform_data *data)
> +{
> +	if (mrst_keypad_pdata)
> +		return -EBUSY;
> +	if (!data)
> +		return -EINVAL;
> +
> +	mrst_keypad_pdata = kmemdup(data, sizeof(*data), GFP_KERNEL);
> +	if (!mrst_keypad_pdata)
> +		return -ENOMEM;
> +

Surely there is a better way...

> +	return 0;
> +}
> +
> +static void mrst_keypad_scan_matrix(struct mrst_keypad *keypad)
> +{
> +	int row, col, code, num_keys_pressed = 0;
> +	uint32_t new_state[MAX_MATRIX_KEY_COLS];
> +	uint32_t kpas = keypad_readl(KPAS);
> +	int status;
> +
> +	num_keys_pressed = KPAS_MUKP(kpas);
> +
> +	memset(new_state, 0, sizeof(new_state));
> +
> +	if (num_keys_pressed == 0) {
> +		status = keypad->matrix_key_state[0] & (1 << 0);
> +		goto scan;
> +	}
> +
> +	if (num_keys_pressed == 1) {
> +		col = KPAS_CP(kpas);
> +		row = KPAS_RP(kpas);
> +
> +		/* if invalid row/col, treat as no key pressed */
> +		if (col < MAX_MATRIX_KEY_COLS &&
> +			row < MAX_MATRIX_KEY_ROWS) {
> +			status = keypad->matrix_key_state[col] & (1 << row);
> +			new_state[col] = (1 << row);
> +		}
> +
> +		goto scan;
> +	}
> +
> +	if (num_keys_pressed > 1) {
> +		uint32_t kpasmkp0 = keypad_readl(KPASMKP0);
> +		uint32_t kpasmkp1 = keypad_readl(KPASMKP1);
> +		uint32_t kpasmkp2 = keypad_readl(KPASMKP2);
> +		uint32_t kpasmkp3 = keypad_readl(KPASMKP3);
> +
> +		new_state[0] = kpasmkp0 & KPASMKP_MKC_MASK;
> +		new_state[1] = (kpasmkp0 >> 16) & KPASMKP_MKC_MASK;
> +		new_state[2] = kpasmkp1 & KPASMKP_MKC_MASK;
> +		new_state[3] = (kpasmkp1 >> 16) & KPASMKP_MKC_MASK;
> +		new_state[4] = kpasmkp2 & KPASMKP_MKC_MASK;
> +		new_state[5] = (kpasmkp2 >> 16) & KPASMKP_MKC_MASK;
> +		new_state[6] = kpasmkp3 & KPASMKP_MKC_MASK;
> +		new_state[7] = (kpasmkp3 >> 16) & KPASMKP_MKC_MASK;
> +	}
> +
> +scan:
> +	for (col = 0; col < keypad->matrix_key_cols; col++) {
> +		uint32_t bits_changed;
> +
> +		bits_changed = keypad->matrix_key_state[col] ^ new_state[col];
> +		if (bits_changed == 0)
> +			continue;
> +
> +		for (row = 0; row < keypad->matrix_key_rows; row++) {
> +			if ((bits_changed & (1 << row)) == 0)
> +				continue;
> +
> +			code = MATRIX_SCAN_CODE(row, col, MATRIX_ROW_SHIFT);

Please add reporting of MSC_SCAN as well.

> +			input_report_key(keypad->input_dev,
> +				keypad->keycode[code],
> +				new_state[col] & (1 << row));
> +		}
> +	}
> +	input_sync(keypad->input_dev);
> +	memcpy(keypad->matrix_key_state, new_state, sizeof(new_state));
> +}
> +
> +#define DEFAULT_KPREC	(0x007f007f)
> +
> +static inline int rotary_delta(uint32_t kprec)
> +{
> +	if (kprec & KPREC_OF0)
> +		return (kprec & 0xff) + 0x7f;
> +	else if (kprec & KPREC_UF0)
> +		return (kprec & 0xff) - 0x7f - 0xff;
> +	else
> +		return (kprec & 0xff) - 0x7f;
> +}
> +
> +static void report_rotary_event(struct mrst_keypad *keypad, int r, int delta)
> +{
> +	struct input_dev *dev = keypad->input_dev;
> +
> +	if (delta == 0)
> +		return;
> +
> +	if (keypad->rotary_up_key[r] && keypad->rotary_down_key[r]) {
> +		int keycode = (delta > 0) ? keypad->rotary_up_key[r] :
> +					    keypad->rotary_down_key[r];
> +
> +		/* simulate a press-n-release */
> +		input_report_key(dev, keycode, 1);
> +		input_sync(dev);
> +		input_report_key(dev, keycode, 0);
> +		input_sync(dev);
> +	} else {
> +		input_report_rel(dev, keypad->rotary_rel_code[r], delta);
> +		input_sync(dev);
> +	}
> +}
> +
> +static void mrst_keypad_scan_rotary(struct mrst_keypad *keypad)
> +{
> +	unsigned int kprec;
> +
> +	/* read and reset to default count value */
> +	kprec = keypad_readl(KPREC);
> +	keypad_writel(KPREC, DEFAULT_KPREC);
> +
> +	if (keypad->enable_rotary0)
> +		report_rotary_event(keypad, 0, rotary_delta(kprec));
> +
> +	if (keypad->enable_rotary1)
> +		report_rotary_event(keypad, 1, rotary_delta(kprec >> 16));
> +}
> +
> +static void mrst_keypad_scan_direct(struct mrst_keypad *keypad)
> +{
> +	unsigned int new_state;
> +	uint32_t kpdk, bits_changed;
> +	int i;
> +
> +	kpdk = keypad_readl(KPDK);
> +
> +	if (keypad->enable_rotary0 || keypad->enable_rotary1)
> +		mrst_keypad_scan_rotary(keypad);
> +
> +	if (!keypad->direct_key_num) {
> +		keypad->direct_key_state = 0;
> +		return;
> +	}
> +
> +	new_state = KPDK_DK(kpdk) & keypad->direct_key_mask;
> +	new_state = ~new_state;
> +	bits_changed = keypad->direct_key_state ^ new_state;
> +
> +	if (bits_changed == 0)
> +		return;
> +
> +	for (i = 0; i < keypad->direct_key_num; i++) {
> +		if (bits_changed & (1 << i)) {
> +			input_report_key(keypad->input_dev,
> +					 keypad->direct_keycode[i],
> +					 (new_state & (1 << i)));
> +		}
> +	}
> +
> +	input_sync(keypad->input_dev);
> +	keypad->direct_key_state = new_state;
> +}
> +
> +static irqreturn_t mrst_keypad_irq_handler(int irq, void *dev_id)
> +{
> +	struct mrst_keypad *keypad = dev_id;
> +	unsigned long kpc = keypad_readl(KPC);
> +
> +	if (kpc & KPC_DI)
> +		mrst_keypad_scan_direct(keypad);
> +
> +	if (kpc & KPC_MI)
> +		mrst_keypad_scan_matrix(keypad);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static int mrst_keypad_gpio_init(struct mrst_keypad *keypad)
> +{
> +	int i, err, cnt = 0;
> +	int pins = KEYPAD_MATRIX_GPIO_IN_PIN + MAX_MATRIX_KEY_ROWS +
> +	    MAX_MATRIX_KEY_COLS + keypad->direct_key_num;
> +
> +	/* explicitely tell which pins have been occupied... */
> +	for (i = KEYPAD_MATRIX_GPIO_IN_PIN; i < pins; i++, cnt++) {
> +		err = gpio_request(i, NULL);
> +		if (err) {
> +			pr_err(DRV_NAME "GPIO pin %d failed to request.\n", i);
> +			goto err_request;
> +		}
> +	}
> +
> +	for (i = 0; i < MAX_MATRIX_KEY_ROWS; i++)
> +		gpio_direction_input(KEYPAD_MATRIX_GPIO_IN_PIN + i);
> +
> +	for (i = 0; i < MAX_MATRIX_KEY_COLS; i++)
> +		/* __gpio_set_value(KEYPAD_GPIO_OUT_PIN + i, 1); */
> +		/* set action is executed in gpio_direction_output() */
> +		gpio_direction_output(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
> +
> +	for (i = 0; i < keypad->direct_key_num; i++)
> +		gpio_direction_input(KEYPAD_DIRECT_GPIO_IN_PIN + i);
> +
> +	return 0;
> +
> +err_request:
> +	/* free requested pins... */
> +	for (i = KEYPAD_MATRIX_GPIO_IN_PIN + cnt - 1;
> +	     i >= KEYPAD_MATRIX_GPIO_IN_PIN; i--)
> +		gpio_free(i);
> +	return err;
> +}
> +
> +static void mrst_keypad_config(struct mrst_keypad *keypad)
> +{
> +	unsigned int mask = 0, direct_key_num = 0;
> +	unsigned long kpc = 0;
> +
> +	/* enable matrix keys with automatic scan */
> +	if (keypad->matrix_key_rows && keypad->matrix_key_cols) {
> +		kpc |= KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
> +		kpc |= KPC_MKRN(keypad->matrix_key_rows) |
> +		       KPC_MKCN(keypad->matrix_key_cols);
> +	}
> +
> +	/* enable rotary key, debounce interval same as direct keys */
> +	if (keypad->enable_rotary0) {
> +		mask |= 0x03;
> +		direct_key_num = 2;
> +		kpc |= KPC_REE0;
> +	}
> +
> +	if (keypad->enable_rotary1) {
> +		mask |= 0x0c;
> +		direct_key_num = 4;
> +		kpc |= KPC_REE1;
> +	}
> +
> +	if (keypad->direct_key_num > direct_key_num)
> +		direct_key_num = keypad->direct_key_num;
> +
> +	keypad->direct_key_mask = ((2 << direct_key_num) - 1) & ~mask;
> +
> +	/* enable direct key */
> +	if (direct_key_num)
> +		kpc |= KPC_DE | KPC_DIE | KPC_DKN(direct_key_num);
> +
> +	keypad_writel(KPC, kpc);
> +	keypad_writel(KPREC, DEFAULT_KPREC);
> +	keypad_writel(KPKDI, keypad->debounce_interval);
> +}
> +
> +static int mrst_keypad_open(struct input_dev *dev)
> +{
> +	struct mrst_keypad *keypad = input_get_drvdata(dev);
> +	int err;
> +
> +	err = mrst_keypad_gpio_init(keypad);

Setting up gpios should be part of probe, not open. Just rename
mrst_keypad_config() to mrst_keypad_open.

> +	if (err)
> +		return err;
> +	mrst_keypad_config(keypad);
> +
> +	return 0;
> +}
> +
> +static void mrst_keypad_close(struct input_dev *dev)
> +{
> +	struct mrst_keypad *keypad = input_get_drvdata(dev);
> +	int pins = KEYPAD_MATRIX_GPIO_IN_PIN + MAX_MATRIX_KEY_ROWS +
> +	    MAX_MATRIX_KEY_COLS + keypad->direct_key_num;
> +
> +	int i;
> +
> +	/* free occupied pins */
> +	for (i = KEYPAD_MATRIX_GPIO_IN_PIN; i < pins; i++)
> +		gpio_free(i);

Should be done in remove(). close() should only shut off the device.

> +}
> +
> +static int __devinit mrst_keypad_probe(struct pci_dev *pdev,
> +			const struct pci_device_id *ent)
> +{
> +	struct mrst_keypad *keypad;
> +	struct input_dev *input_dev;
> +	int error;
> +
> +	/* Disable flag will turn off keypad support */
> +	if (mrst_keypad_pdata && mrst_keypad_pdata->disable)

Why would you have a flag in platform data? If you do not want to use
the driver do not compile/load it.

> +		return 0;
> +
> +	error = pci_enable_device(pdev);
> +	if (error || (pdev->irq < 0)) {

Extra parenthesis.

> +		dev_err(&pdev->dev, "failed to enable device/get irq\n");
> +		return -ENXIO;
> +	}
> +
> +	keypad = kzalloc(sizeof(struct mrst_keypad), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!keypad || !input_dev) {
> +		dev_err(&pdev->dev, "failed to allocate driver data\n");
> +		error = -ENOMEM;
> +		goto failed_free_mem;
> +	}
> +
> +	keypad->input_dev = input_dev;
> +	keypad->irq = pdev->irq;
> +
> +	error = pci_request_regions(pdev, DRV_NAME);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to request I/O memory\n");
> +		goto failed_free_mem;
> +	}
> +
> +	keypad->mmio_base = ioremap(pci_resource_start(pdev, 0),
> +		pci_resource_len(pdev, 0));
> +	if (!keypad->mmio_base) {
> +		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> +		error = -ENXIO;
> +		goto failed_free_mem_region;
> +	}
> +
> +	input_dev->name = pci_name(pdev);
> +	input_dev->id.bustype = BUS_PCI;
> +	input_dev->open = mrst_keypad_open;
> +	input_dev->close = mrst_keypad_close;
> +	input_dev->dev.parent = &pdev->dev;
> +	input_set_drvdata(input_dev, keypad);
> +
> +	input_dev->keycode = keypad->keycode;
> +	input_dev->keycodesize = sizeof(unsigned int);
> +	input_dev->keycodemax = ARRAY_SIZE(mrst_default_keymap);
> +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> +		BIT_MASK(EV_REL);
> +
> +	mrst_keypad_build_keycode(keypad);
> +	pci_set_drvdata(pdev, keypad);
> +
> +	/* Register the input device */
> +	error = input_register_device(input_dev);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		goto failed_free_iounmap;
> +	}
> +
> +	error = request_irq(pdev->irq, mrst_keypad_irq_handler, IRQF_SHARED,
> +		pci_name(pdev), keypad);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to request keyboard IRQ\n");
> +		goto failed_free_input;
> +	}
> +

If you move pci_set_drvdata() here you won't need to clear it in error
path.

> +
> +	return 0;
> +
> +failed_free_input:
> +	input_unregister_device(input_dev);
> +	input_dev = NULL;
> +	pci_set_drvdata(pdev, NULL);
> +failed_free_iounmap:
> +	iounmap(keypad->mmio_base);
> +failed_free_mem_region:
> +	pci_release_regions(pdev);
> +failed_free_mem:
> +	if (input_dev)

No need to check.

> +		input_free_device(input_dev);
> +	kfree(keypad);
> +
> +	return error;
> +}
> +
> +static void __devexit mrst_keypad_remove(struct pci_dev *pdev)
> +{
> +	struct mrst_keypad *keypad = pci_get_drvdata(pdev);
> +	int i;
> +	int pins = KEYPAD_MATRIX_GPIO_IN_PIN + MAX_MATRIX_KEY_ROWS +
> +	    MAX_MATRIX_KEY_COLS + keypad->direct_key_num;
> +
> +	free_irq(pdev->irq, keypad);
> +	for (i = pins - 1; i > KEYPAD_MATRIX_GPIO_IN_PIN; i--)
> +		gpio_free(i);

Begs for a function as is called in several places.

> +
> +	input_unregister_device(keypad->input_dev);
> +	iounmap(keypad->mmio_base);
> +	pci_release_regions(pdev);
> +	pci_set_drvdata(pdev, NULL);
> +	kfree(keypad);
> +}
> +
> +static const struct pci_device_id keypad_pci_tbl[] = {
> +	{0x8086, 0x0805, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> +	{0,}
> +};
> +MODULE_DEVICE_TABLE(pci, keypad_pci_tbl);
> +
> +static struct pci_driver mrst_keypad_driver = {
> +	.name		= DRV_NAME,
> +	.id_table	= keypad_pci_tbl,
> +	.probe		= mrst_keypad_probe,
> +	.remove		= __devexit_p(mrst_keypad_remove),
> +#ifdef CONFIG_PM
> +	.suspend	= NULL,
> +	.resume	= NULL,

Why?

> +#endif /* CONFIG_PM */
> +};
> +
> +static int __init mrst_keypad_init(void)
> +{
> +	return pci_register_driver(&mrst_keypad_driver);
> +}
> +
> +static void __exit mrst_keypad_exit(void)
> +{
> +	pci_unregister_driver(&mrst_keypad_driver);
> +}
> +
> +module_init(mrst_keypad_init);
> +module_exit(mrst_keypad_exit);
> +
> +MODULE_DESCRIPTION("MRST Keypad Controller Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Intel Corp, Jekyll Lai <jekyll_lai@wistron.com>");
> diff --git a/include/linux/input/intel_mid_keypad.h b/include/linux/input/intel_mid_keypad.h
> new file mode 100644
> index 0000000..4295db4
> --- /dev/null
> +++ b/include/linux/input/intel_mid_keypad.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (C) 2010 Jekyll Lai, Wistron <jekyll_lai@wistron.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/input/matrix_keypad.h>
> +
> +struct mrst_keypad_platform_data {
> +	const struct matrix_keymap_data *keymap_data;
> +	const struct matrix_keymap_data *direct_keymap_data;
> +	int disable;
> +	int direct_key_num;
> +	int enable_rotary0;
> +	int enable_rotary1;
> +};
> +
> +int mrst_keypad_set_pdata(const struct mrst_keypad_platform_data *data);
> 

Thanks.

-- 
Dmitry
