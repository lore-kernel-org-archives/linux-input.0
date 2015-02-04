From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/3] bfin_rotary: replace bfin specific MMR function
 with generic IO function
Date: Wed, 4 Feb 2015 11:46:49 -0800
Message-ID: <20150204194649.GC15782@dtor-ws>
References: <1423036686-31891-1-git-send-email-sonic.adi@gmail.com>
 <1423036686-31891-2-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:51113 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986AbbBDTqy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 14:46:54 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so37281631igk.1
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 11:46:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423036686-31891-2-git-send-email-sonic.adi@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

On Wed, Feb 04, 2015 at 03:58:05PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> - use readw and writew to access rotary MMRs
> - remap rotary register physical address into kernel space in probe
> 
> v2-changes:
> - replace kzalloc with devm_kzalloc
> - replace request_irq with devm_request_irq
> - remove memory free and irq free from the device remove function
> 
> v3-changes:
> - move managed resources to a separate patch
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/input/misc/bfin_rotary.c |   53 ++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
> index dd62fc9..defddca 100644
> --- a/drivers/input/misc/bfin_rotary.c
> +++ b/drivers/input/misc/bfin_rotary.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/pm.h>
>  #include <linux/platform_device.h>
> @@ -16,8 +17,18 @@
>  
>  #include <asm/portmux.h>
>  
> +#define CNT_CONFIG_OFF		0	/* CNT Config Offset */
> +#define CNT_IMASK_OFF		4	/* CNT Interrupt Mask Offset */
> +#define CNT_STATUS_OFF		8	/* CNT Status Offset */
> +#define CNT_COMMAND_OFF		12	/* CNT Command Offset */
> +#define CNT_DEBOUNCE_OFF	16	/* CNT Debounce Offset */
> +#define CNT_COUNTER_OFF		20	/* CNT Counter Offset */
> +#define CNT_MAX_OFF		24	/* CNT Maximum Count Offset */
> +#define CNT_MIN_OFF		28	/* CNT Minimum Count Offset */
> +
>  struct bfin_rot {
>  	struct input_dev *input;
> +	void __iomem *base;

Who is populating this member? Remember, patches must be complete.

Thanks.

>  	int irq;
>  	unsigned int up_key;
>  	unsigned int down_key;
> @@ -56,14 +67,14 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
>  	struct bfin_rot *rotary = platform_get_drvdata(pdev);
>  	int delta;
>  
> -	switch (bfin_read_CNT_STATUS()) {
> +	switch (readw(rotary->base + CNT_STATUS_OFF)) {
>  
>  	case ICII:
>  		break;
>  
>  	case UCII:
>  	case DCII:
> -		delta = bfin_read_CNT_COUNTER();
> +		delta = readl(rotary->base + CNT_COUNTER_OFF);
>  		if (delta)
>  			report_rotary_event(rotary, delta);
>  		break;
> @@ -76,8 +87,8 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
>  		break;
>  	}
>  
> -	bfin_write_CNT_COMMAND(W1LCNT_ZERO);	/* Clear COUNTER */
> -	bfin_write_CNT_STATUS(-1);	/* Clear STATUS */
> +	writew(W1LCNT_ZERO, rotary->base + CNT_COMMAND_OFF); /* Clear COUNTER */
> +	writew(-1, rotary->base + CNT_STATUS_OFF); /* Clear STATUS */
>  
>  	return IRQ_HANDLED;
>  }
> @@ -161,17 +172,21 @@ static int bfin_rotary_probe(struct platform_device *pdev)
>  	}
>  
>  	if (pdata->rotary_button_key)
> -		bfin_write_CNT_IMASK(CZMIE);
> +		writew(CZMIE, rotary->base + CNT_IMASK_OFF);
>  
>  	if (pdata->mode & ROT_DEBE)
> -		bfin_write_CNT_DEBOUNCE(pdata->debounce & DPRESCALE);
> +		writew(pdata->debounce & DPRESCALE,
> +			rotary->base + CNT_DEBOUNCE_OFF);
>  
>  	if (pdata->mode)
> -		bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() |
> -					(pdata->mode & ~CNTE));
> +		writew(readw(rotary->base + CNT_CONFIG_OFF) |
> +			(pdata->mode & ~CNTE),
> +			rotary->base + CNT_CONFIG_OFF);
>  
> -	bfin_write_CNT_IMASK(bfin_read_CNT_IMASK() | UCIE | DCIE);
> -	bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() | CNTE);
> +	writew(readw(rotary->base + CNT_IMASK_OFF) | UCIE | DCIE,
> +		rotary->base + CNT_IMASK_OFF);
> +	writew(readw(rotary->base + CNT_CONFIG_OFF) | CNTE,
> +		rotary->base + CNT_CONFIG_OFF);
>  
>  	platform_set_drvdata(pdev, rotary);
>  	device_init_wakeup(&pdev->dev, 1);
> @@ -193,8 +208,8 @@ static int bfin_rotary_remove(struct platform_device *pdev)
>  	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct bfin_rot *rotary = platform_get_drvdata(pdev);
>  
> -	bfin_write_CNT_CONFIG(0);
> -	bfin_write_CNT_IMASK(0);
> +	writew(0, rotary->base + CNT_CONFIG_OFF);
> +	writew(0, rotary->base + CNT_IMASK_OFF);
>  
>  	free_irq(rotary->irq, pdev);
>  	input_unregister_device(rotary->input);
> @@ -211,9 +226,9 @@ static int bfin_rotary_suspend(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct bfin_rot *rotary = platform_get_drvdata(pdev);
>  
> -	rotary->cnt_config = bfin_read_CNT_CONFIG();
> -	rotary->cnt_imask = bfin_read_CNT_IMASK();
> -	rotary->cnt_debounce = bfin_read_CNT_DEBOUNCE();
> +	rotary->cnt_config = readw(rotary->base + CNT_CONFIG_OFF);
> +	rotary->cnt_imask = readw(rotary->base + CNT_IMASK_OFF);
> +	rotary->cnt_debounce = readw(rotary->base + CNT_DEBOUNCE_OFF);
>  
>  	if (device_may_wakeup(&pdev->dev))
>  		enable_irq_wake(rotary->irq);
> @@ -226,15 +241,15 @@ static int bfin_rotary_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct bfin_rot *rotary = platform_get_drvdata(pdev);
>  
> -	bfin_write_CNT_DEBOUNCE(rotary->cnt_debounce);
> -	bfin_write_CNT_IMASK(rotary->cnt_imask);
> -	bfin_write_CNT_CONFIG(rotary->cnt_config & ~CNTE);
> +	writew(rotary->cnt_debounce, rotary->base + CNT_DEBOUNCE_OFF);
> +	writew(rotary->cnt_imask, rotary->base + CNT_IMASK_OFF);
> +	writew(rotary->cnt_config & ~CNTE, rotary->base + CNT_CONFIG_OFF);
>  
>  	if (device_may_wakeup(&pdev->dev))
>  		disable_irq_wake(rotary->irq);
>  
>  	if (rotary->cnt_config & CNTE)
> -		bfin_write_CNT_CONFIG(rotary->cnt_config);
> +		writew(rotary->cnt_config, rotary->base + CNT_CONFIG_OFF);
>  
>  	return 0;
>  }
> -- 
> 1.7.9.5
> 

-- 
Dmitry
