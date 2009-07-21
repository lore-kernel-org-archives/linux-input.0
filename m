From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: A few changes to pxa27x_keypad
Date: Tue, 21 Jul 2009 13:44:56 +0300
Message-ID: <4A659C28.3040305@compulab.co.il>
References: <20090721080845.GD10168@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from compulab.site5.com ([67.18.134.219]:39182 "EHLO compulab.co.il"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbZGUMCn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 08:02:43 -0400
In-Reply-To: <20090721080845.GD10168@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-input@vger.kernel.org

Hi Dmitry,

Dmitry Torokhov wrote:
> Hi Eric,
> 
> I made a few adjustments to the pxa27x_keypad driver and was wondering
> if you would be able to give it a sping and check if I broke it or not.

Apparently not :)
Tested-by: Mike Rapoport <mike@compulab.co.il>

> Thanks!
> 
> -- 
> Dmitry
> 
> Input: pxa27x_keypad - remove extra clk_disable
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> clk_disable() in remove method is not needed since we already
> have clk_disable in pxa27x_keypad_close().
> 
> Also make sure the driver uses resource_size() and helpers from
> include/input/matrix_keypad.h
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  arch/arm/mach-pxa/include/mach/pxa27x_keypad.h |    3 +-
>  drivers/input/keyboard/pxa27x_keypad.c         |   43 +++++++++++-------------
>  2 files changed, 21 insertions(+), 25 deletions(-)
> 
> 
> diff --git a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h b/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> index d5a48a9..63e8965 100644
> --- a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> +++ b/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> @@ -2,6 +2,7 @@
>  #define __ASM_ARCH_PXA27x_KEYPAD_H
>  
>  #include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
>  
>  #define MAX_MATRIX_KEY_ROWS	(8)
>  #define MAX_MATRIX_KEY_COLS	(8)
> @@ -51,8 +52,6 @@ struct pxa27x_keypad_platform_data {
>  	unsigned int	debounce_interval;
>  };
>  
> -#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
> -
>  extern void pxa_set_keypad_info(struct pxa27x_keypad_platform_data *info);
>  
>  #endif /* __ASM_ARCH_PXA27x_KEYPAD_H */
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index 0d2fc64..0943238 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -25,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/input/matrix_keypad.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -107,7 +108,7 @@ struct pxa27x_keypad {
>  	int irq;
>  
>  	/* matrix key code map */
> -	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
> +	unsigned short matrix_keycodes[MAX_MATRIX_KEY_NUM];
>  
>  	/* state row bits of each column scan */
>  	uint32_t matrix_key_state[MAX_MATRIX_KEY_COLS];
> @@ -124,21 +125,21 @@ static void pxa27x_keypad_build_keycode(struct pxa27x_keypad *keypad)
>  {
>  	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
>  	struct input_dev *input_dev = keypad->input_dev;
> -	unsigned int *key;
>  	int i;
>  
> -	key = &pdata->matrix_key_map[0];
> -	for (i = 0; i < pdata->matrix_key_map_size; i++, key++) {
> -		int row = ((*key) >> 28) & 0xf;
> -		int col = ((*key) >> 24) & 0xf;
> -		int code = (*key) & 0xffffff;
> +	for (i = 0; i < pdata->matrix_key_map_size; i++) {
> +		unsigned int key = pdata->matrix_key_map[i];
> +		unsigned int row = KEY_ROW(key);
> +		unsigned int col = KEY_COL(key);
> +		unsigned short code = KEY_VAL(key);
>  
>  		keypad->matrix_keycodes[(row << 3) + col] = code;
> -		set_bit(code, input_dev->keybit);
> +		__set_bit(code, input_dev->keybit);
>  	}
> +	__clear_bit(KEY_RESERVED, input_dev->keybit);
>  
>  	for (i = 0; i < pdata->direct_key_num; i++)
> -		set_bit(pdata->direct_key_map[i], input_dev->keybit);
> +		__set_bit(pdata->direct_key_map[i], input_dev->keybit);
>  
>  	keypad->rotary_up_key[0] = pdata->rotary0_up_key;
>  	keypad->rotary_up_key[1] = pdata->rotary1_up_key;
> @@ -149,18 +150,18 @@ static void pxa27x_keypad_build_keycode(struct pxa27x_keypad *keypad)
>  
>  	if (pdata->enable_rotary0) {
>  		if (pdata->rotary0_up_key && pdata->rotary0_down_key) {
> -			set_bit(pdata->rotary0_up_key, input_dev->keybit);
> -			set_bit(pdata->rotary0_down_key, input_dev->keybit);
> +			__set_bit(pdata->rotary0_up_key, input_dev->keybit);
> +			__set_bit(pdata->rotary0_down_key, input_dev->keybit);
>  		} else
> -			set_bit(pdata->rotary0_rel_code, input_dev->relbit);
> +			__set_bit(pdata->rotary0_rel_code, input_dev->relbit);
>  	}
>  
>  	if (pdata->enable_rotary1) {
>  		if (pdata->rotary1_up_key && pdata->rotary1_down_key) {
> -			set_bit(pdata->rotary1_up_key, input_dev->keybit);
> -			set_bit(pdata->rotary1_down_key, input_dev->keybit);
> +			__set_bit(pdata->rotary1_up_key, input_dev->keybit);
> +			__set_bit(pdata->rotary1_down_key, input_dev->keybit);
>  		} else
> -			set_bit(pdata->rotary1_rel_code, input_dev->relbit);
> +			__set_bit(pdata->rotary1_rel_code, input_dev->relbit);
>  	}
>  }
>  
> @@ -425,8 +426,6 @@ static int pxa27x_keypad_resume(struct platform_device *pdev)
>  #define pxa27x_keypad_resume	NULL
>  #endif
>  
> -#define res_size(res)	((res)->end - (res)->start + 1)
> -
>  static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
>  {
>  	struct pxa27x_keypad *keypad;
> @@ -461,14 +460,14 @@ static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
>  		goto failed_free;
>  	}
>  
> -	res = request_mem_region(res->start, res_size(res), pdev->name);
> +	res = request_mem_region(res->start, resource_size(res), pdev->name);
>  	if (res == NULL) {
>  		dev_err(&pdev->dev, "failed to request I/O memory\n");
>  		error = -EBUSY;
>  		goto failed_free;
>  	}
>  
> -	keypad->mmio_base = ioremap(res->start, res_size(res));
> +	keypad->mmio_base = ioremap(res->start, resource_size(res));
>  	if (keypad->mmio_base == NULL) {
>  		dev_err(&pdev->dev, "failed to remap I/O memory\n");
>  		error = -ENXIO;
> @@ -540,7 +539,7 @@ failed_put_clk:
>  failed_free_io:
>  	iounmap(keypad->mmio_base);
>  failed_free_mem:
> -	release_mem_region(res->start, res_size(res));
> +	release_mem_region(res->start, resource_size(res));
>  failed_free:
>  	kfree(keypad);
>  	return error;
> @@ -552,8 +551,6 @@ static int __devexit pxa27x_keypad_remove(struct platform_device *pdev)
>  	struct resource *res;
>  
>  	free_irq(keypad->irq, pdev);
> -
> -	clk_disable(keypad->clk);
>  	clk_put(keypad->clk);
>  
>  	input_unregister_device(keypad->input_dev);
> @@ -562,7 +559,7 @@ static int __devexit pxa27x_keypad_remove(struct platform_device *pdev)
>  	iounmap(keypad->mmio_base);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, res_size(res));
> +	release_mem_region(res->start, resource_size(res));
>  
>  	platform_set_drvdata(pdev, NULL);
>  	kfree(keypad);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.


