From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 3/12] pxa: introduce driver structure and use KEY() to define matrix keys
Date: Tue, 29 Jan 2008 01:33:51 -0500
Message-ID: <200801290133.52434.dtor@insightbb.com>
References: <f17812d70801222324s1eaeb67fl84c1dc598a41a025@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mxsf09.insightbb.com ([74.128.0.79]:64401 "EHLO
	mxsf09.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbYA2Gdz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jan 2008 01:33:55 -0500
In-Reply-To: <f17812d70801222324s1eaeb67fl84c1dc598a41a025@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: eric miao <eric.y.miao@gmail.com>
Cc: linux-input@vger.kernel.org, Rodolfo Giometti <giometti@linux.it>

Hi Eric,

On Wednesday 23 January 2008 02:24, eric miao wrote:
> From 606a2f30cd7086c5f193b3d92e9f7f06c0b62603 Mon Sep 17 00:00:00 2001
> From: eric miao <eric.miao@marvell.com>
> Date: Tue, 22 Jan 2008 18:09:10 +0800
> Subject: [PATCH] pxa: introduce driver structure and use KEY() to
> define matrix keys
> 
> 1. introduce the "struct pxa27x_keypad" structure for driver specific
>    information, such as "struct clk", generated matrix key codes and
>    so on
> 
> 2. use KEY() macro to define matrix keys, instead of original 8x8 map
>    this makes definition easier with keypad where keys are sparse
>

I am a bit concerned with loss of backward compatibility with the driver.
While there are currently no users of it inside the mainline kernel there
may be people using it in the wild. Let's ask Rodolfo if he can cope
with this change...

Alternative woudl be do something like:

#define KEY(row, col, code)  [((row) << 3) + (col)] = (code)

which would allow defining starse keymaps.

 
> 3. keep a generated array in "struct pxa27x_keypad" for fast lookup
> 
> 4. separate the matrix scan into a dedicated function for readability
>    and report only those keys whose state has been changed, instead
>    of report all states
> 
> 5. make use of KPAS to decide the faster path if only one key has been
>    detected
> 
> Signed-off-by: eric miao <eric.miao@marvell.com>
> ---
>  drivers/input/keyboard/pxa27x_keypad.c   |  224 ++++++++++++++++++++++--------
>  include/asm-arm/arch-pxa/pxa27x_keypad.h |   21 +++-
>  2 files changed, 184 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c
> b/drivers/input/keyboard/pxa27x_keypad.c
> index 43fb63d..8de35b0 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -37,20 +37,120 @@
> 
>  #define DRIVER_NAME		"pxa27x-keypad"
> 
> -#define KPASMKP(col)		(col/2 == 0 ? KPASMKP0 : \
> -				 col/2 == 1 ? KPASMKP1 : \
> -				 col/2 == 2 ? KPASMKP2 : KPASMKP3)
> -#define KPASMKPx_MKC(row, col)	(1 << (row + 16 * (col % 2)))
> +#define KPAS_MUKP(n)		(((n) >> 26) & 0x1f)
> +#define KPAS_RP(n)		(((n) >> 4) & 0xf)
> +#define KPAS_CP(n)		((n) & 0xf)
> 
> -static struct clk *pxa27x_keypad_clk;
> +#define KPASMKP_MKC_MASK	(0xff)
> +
> +#define MAX_MATRIX_KEY_NUM	(8 * 8)
> +
> +struct pxa27x_keypad {
> +	struct pxa27x_keypad_platform_data *pdata;
> +
> +	struct clk *clk;
> +	struct input_dev *input_dev;
> +
> +	/* matrix key code map */
> +	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
> +
> +	/* state row bits of each column scan */
> +	uint32_t matrix_key_state[MAX_MATRIX_KEY_COLS];
> +};
> +
> +static void pxa27x_keypad_build_keycode(struct pxa27x_keypad *keypad)
> +{
> +	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
> +	struct input_dev *input_dev = keypad->input_dev;
> +	unsigned int *key;
> +	int i;
> +
> +	key = &pdata->matrix_key_map[0];
> +	for (i = 0; i < pdata->matrix_key_map_size; i++, key++) {
> +		int row = ((*key) >> 28) & 0xf;
> +		int col = ((*key) >> 24) & 0xf;
> +		int code = (*key) & 0xffffff;
> +
> +		keypad->matrix_keycodes[(row << 3) + col] = code;
> +		set_bit(code, input_dev->keybit);
> +	}
> +}
> +
> +static inline unsigned int lookup_matrix_keycode(
> +		struct pxa27x_keypad *keypad, int row, int col)
> +{
> +	return keypad->matrix_keycodes[(row << 3) + col];
> +}
> +
> +static void pxa27x_keypad_scan_matrix(struct pxa27x_keypad *keypad)
> +{
> +	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
> +	int row, col, num_keys_pressed = 0;
> +	uint32_t new_state[MAX_MATRIX_KEY_COLS];
> +	uint32_t kpas = KPAS;
> +
> +	num_keys_pressed = KPAS_MUKP(kpas);
> +
> +	memset(new_state, 0, sizeof(new_state));
> +
> +	if (num_keys_pressed == 0)
> +		goto scan;
> +
> +	if (num_keys_pressed == 1) {
> +		col = KPAS_CP(kpas);
> +		row = KPAS_RP(kpas);
> +
> +		/* if invalid row/col, treat as no key pressed */
> +		if (col >= pdata->matrix_key_cols ||
> +		    row >= pdata->matrix_key_rows)
> +			goto scan;
> +
> +		new_state[col] = (1 << row);
> +		goto scan;
> +	}
> +
> +	if (num_keys_pressed > 1) {
> +		uint32_t kpasmkp0 = KPASMKP0;
> +		uint32_t kpasmkp1 = KPASMKP1;
> +		uint32_t kpasmkp2 = KPASMKP2;
> +		uint32_t kpasmkp3 = KPASMKP3;
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
> +scan:
> +	for (col = 0; col < pdata->matrix_key_cols; col++) {
> +		uint32_t bits_changed;
> +
> +		bits_changed = keypad->matrix_key_state[col] ^ new_state[col];
> +		if (bits_changed == 0)
> +			continue;
> +
> +		for (row = 0; row < pdata->matrix_key_rows; row++) {
> +			if ((bits_changed & (1 << row)) == 0)
> +				continue;
> +
> +			input_report_key(keypad->input_dev,
> +				lookup_matrix_keycode(keypad, row, col),
> +				new_state[col] & (1 << row));
> +		}
> +	}
> +	input_sync(keypad->input_dev);
> +	memcpy(keypad->matrix_key_state, new_state, sizeof(new_state));
> +}
> 
>  static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *dev_id)
>  {
> -	struct platform_device *pdev = dev_id;
> -	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
> -	struct input_dev *input_dev = platform_get_drvdata(pdev);
> +	struct pxa27x_keypad *keypad = dev_id;
> +	struct input_dev *input_dev = keypad->input_dev;
>  	unsigned long kpc = KPC;
> -	int p, row, col, rel;
> +	int rel;
> 
>  	if (kpc & KPC_DI) {
>  		unsigned long kpdk = KPDK;
> @@ -75,26 +175,16 @@ static irqreturn_t pxa27x_keypad_irq_handler(int
> irq, void *dev_id)
>  		}
>  	}
> 
> -	if (kpc & KPC_MI) {
> -		/* report the status of every button */
> -		for (row = 0; row < pdata->nr_rows; row++) {
> -			for (col = 0; col < pdata->nr_cols; col++) {
> -				p = KPASMKP(col) & KPASMKPx_MKC(row, col) ?
> -					1 : 0;
> -				pr_debug("keycode %x - pressed %x\n",
> -						pdata->keycodes[row][col], p);
> -				input_report_key(input_dev,
> -						pdata->keycodes[row][col], p);
> -			}
> -		}
> -		input_sync(input_dev);
> -	}
> +	if (kpc & KPC_MI)
> +		pxa27x_keypad_scan_matrix(keypad);
> 
>  	return IRQ_HANDLED;
>  }
> 
>  static int pxa27x_keypad_open(struct input_dev *dev)
>  {
> +	struct pxa27x_keypad *keypad = input_get_drvdata(dev);
> +
>  	/* Set keypad control register */
>  	KPC |= (KPC_ASACT |
>  		KPC_MS_ALL |
> @@ -108,21 +198,24 @@ static int pxa27x_keypad_open(struct input_dev *dev)
>  	KPREC = 0x7F;
> 
>  	/* Enable unit clock */
> -	clk_enable(pxa27x_keypad_clk);
> +	clk_enable(keypad->clk);
> 
>  	return 0;
>  }
> 
>  static void pxa27x_keypad_close(struct input_dev *dev)
>  {
> +	struct pxa27x_keypad *keypad = input_get_drvdata(dev);
> +
>  	/* Disable clock unit */
> -	clk_disable(pxa27x_keypad_clk);
> +	clk_disable(keypad->clk);
>  }
> 
>  #ifdef CONFIG_PM
>  static int pxa27x_keypad_suspend(struct platform_device *pdev,
> pm_message_t state)
>  {
> -	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
> +	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
> +	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
> 
>  	/* Save controller status */
>  	pdata->reg_kpc = KPC;
> @@ -133,8 +226,9 @@ static int pxa27x_keypad_suspend(struct
> platform_device *pdev, pm_message_t stat
> 
>  static int pxa27x_keypad_resume(struct platform_device *pdev)
>  {
> -	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
> -	struct input_dev *input_dev = platform_get_drvdata(pdev);
> +	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
> +	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
> +	struct input_dev *input_dev = keypad->input_dev;
> 
>  	mutex_lock(&input_dev->mutex);
> 
> @@ -144,8 +238,7 @@ static int pxa27x_keypad_resume(struct
> platform_device *pdev)
>  		KPREC = pdata->reg_kprec;
> 
>  		/* Enable unit clock */
> -		clk_disable(pxa27x_keypad_clk);
> -		clk_enable(pxa27x_keypad_clk);
> +		clk_enable(keypad->clk);
>  	}
> 
>  	mutex_unlock(&input_dev->mutex);
> @@ -159,22 +252,36 @@ static int pxa27x_keypad_resume(struct
> platform_device *pdev)
> 
>  static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
>  {
> -	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
> +	struct pxa27x_keypad *keypad;
>  	struct input_dev *input_dev;
> -	int i, row, col, error;
> +	int col, error;
> 
> -	pxa27x_keypad_clk = clk_get(&pdev->dev, "KBDCLK");
> -	if (IS_ERR(pxa27x_keypad_clk)) {
> -		error = PTR_ERR(pxa27x_keypad_clk);
> -		goto err_clk;
> +	keypad = kzalloc(sizeof(struct pxa27x_keypad), GFP_KERNEL);
> +	if (keypad == NULL) {
> +		dev_err(&pdev->dev, "failed to allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +
> +	keypad->pdata = pdev->dev.platform_data;
> +	if (keypad->pdata == NULL) {
> +		dev_err(&pdev->dev, "no platform data defined\n");
> +		error = -EINVAL;
> +		goto failed_free;
> +	}
> +
> +	keypad->clk = clk_get(&pdev->dev, "KBDCLK");
> +	if (IS_ERR(keypad->clk)) {
> +		dev_err(&pdev->dev, "failed to get keypad clock\n");
> +		error = PTR_ERR(keypad->clk);
> +		goto failed_free;
>  	}
> 
>  	/* Create and register the input driver. */
>  	input_dev = input_allocate_device();
>  	if (!input_dev) {
> -		printk(KERN_ERR "Cannot request keypad device\n");
> +		dev_err(&pdev->dev, "failed to allocate input device\n");
>  		error = -ENOMEM;
> -		goto err_alloc;
> +		goto failed_put_clk;
>  	}
> 
>  	input_dev->name = DRIVER_NAME;
> @@ -183,25 +290,23 @@ static int __devinit pxa27x_keypad_probe(struct
> platform_device *pdev)
>  	input_dev->close = pxa27x_keypad_close;
>  	input_dev->dev.parent = &pdev->dev;
> 
> +	keypad->input_dev = input_dev;
> +	input_set_drvdata(input_dev, keypad);
> +
>  	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
>  		BIT_MASK(EV_REL);
>  	input_dev->relbit[BIT_WORD(REL_WHEEL)] = BIT_MASK(REL_WHEEL);
> -	for (row = 0; row < pdata->nr_rows; row++) {
> -		for (col = 0; col < pdata->nr_cols; col++) {
> -			int code = pdata->keycodes[row][col];
> -			if (code > 0)
> -				set_bit(code, input_dev->keybit);
> -		}
> -	}
> +
> +	pxa27x_keypad_build_keycode(keypad);
> 
>  	error = request_irq(IRQ_KEYPAD, pxa27x_keypad_irq_handler, IRQF_DISABLED,
> -			    DRIVER_NAME, pdev);
> +			    DRIVER_NAME, keypad);
>  	if (error) {
>  		printk(KERN_ERR "Cannot request keypad IRQ\n");
>  		goto err_free_dev;
>  	}
> 
> -	platform_set_drvdata(pdev, input_dev);
> +	platform_set_drvdata(pdev, keypad);
> 
>  	/* Register the input device */
>  	error = input_register_device(input_dev);
> @@ -212,10 +317,10 @@ static int __devinit pxa27x_keypad_probe(struct
> platform_device *pdev)
>  	 * Store rows/cols info into keyboard registers.
>  	 */
> 
> -	KPC |= (pdata->nr_rows - 1) << 26;
> -	KPC |= (pdata->nr_cols - 1) << 23;
> +	KPC |= (keypad->pdata->matrix_key_rows - 1) << 26;
> +	KPC |= (keypad->pdata->matrix_key_cols - 1) << 23;
> 
> -	for (col = 0; col < pdata->nr_cols; col++)
> +	for (col = 0; col < keypad->pdata->matrix_key_cols; col++)
>  		KPC |= KPC_MS0 << col;
> 
>  	return 0;
> @@ -225,21 +330,26 @@ static int __devinit pxa27x_keypad_probe(struct
> platform_device *pdev)
>  	free_irq(IRQ_KEYPAD, pdev);
>   err_free_dev:
>  	input_free_device(input_dev);
> - err_alloc:
> -	clk_put(pxa27x_keypad_clk);
> - err_clk:
> +failed_put_clk:
> +	clk_put(keypad->clk);
> +failed_free:
> +	kfree(keypad);
>  	return error;
>  }
> 
>  static int __devexit pxa27x_keypad_remove(struct platform_device *pdev)
>  {
> -	struct input_dev *input_dev = platform_get_drvdata(pdev);
> +	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
> 
> -	input_unregister_device(input_dev);
>  	free_irq(IRQ_KEYPAD, pdev);
> -	clk_put(pxa27x_keypad_clk);
> -	platform_set_drvdata(pdev, NULL);
> 
> +	clk_disable(keypad->clk);
> +	clk_put(keypad->clk);
> +
> +	input_unregister_device(keypad->input_dev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(keypad);
>  	return 0;
>  }
> 
> diff --git a/include/asm-arm/arch-pxa/pxa27x_keypad.h
> b/include/asm-arm/arch-pxa/pxa27x_keypad.h
> index ef17db6..1b1bf9f 100644
> --- a/include/asm-arm/arch-pxa/pxa27x_keypad.h
> +++ b/include/asm-arm/arch-pxa/pxa27x_keypad.h
> @@ -1,12 +1,25 @@
> -#define PXAKBD_MAXROW		8
> -#define PXAKBD_MAXCOL		8
> +#ifndef __ASM_ARCH_PXA27x_KEYPAD_H
> +#define __ASM_ARCH_PXA27x_KEYPAD_H
> +
> +#include <linux/input.h>
> +
> +#define MAX_MATRIX_KEY_ROWS	(8)
> +#define MAX_MATRIX_KEY_COLS	(8)
> 
>  struct pxa27x_keypad_platform_data {
> -	int nr_rows, nr_cols;
> -	int keycodes[PXAKBD_MAXROW][PXAKBD_MAXCOL];
> +
> +	/* code map for the matrix keys */
> +	unsigned int	matrix_key_rows;
> +	unsigned int	matrix_key_cols;
> +	unsigned int	*matrix_key_map;
> +	int		matrix_key_map_size;
> 
>  #ifdef CONFIG_PM
>  	u32 reg_kpc;
>  	u32 reg_kprec;
>  #endif
>  };
> +
> +#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
> +
> +#endif /* __ASM_ARCH_PXA27x_KEYPAD_H */
> -- 
> 1.5.2.5.GIT
> 
> 
> 

-- 
Dmitry
