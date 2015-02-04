From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/3] bfin_rotary: replace bfin specific MMR function
 with generic IO function
Date: Tue, 3 Feb 2015 17:24:23 -0800
Message-ID: <20150204012423.GD23942@dtor-ws>
References: <1421225654-27872-1-git-send-email-sonic.adi@gmail.com>
 <1421225654-27872-3-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:39831 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbbBDBY2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Feb 2015 20:24:28 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so29700557ieb.2
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2015 17:24:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421225654-27872-3-git-send-email-sonic.adi@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

On Wed, Jan 14, 2015 at 04:54:14PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> - use readw and writew to access rotary MMRs
> - remap rotary register physical address into kernel space in probe
> 
> v2-changes:
> - replace kzalloc with devm_kzalloc
> - replace request_irq with devm_request_irq
> - remove memory free and irq free from the device remove function

This needs to be split in 2 as these are 2 separate changes - using
generic IO accessors and converting to use managed resources.

By the way, you can also use devm_input_allocate_device() and not need
free/unregister it.

Thanks.

> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  arch/blackfin/mach-bf527/boards/ad7160eval.c |    5 ++
>  arch/blackfin/mach-bf527/boards/ezkit.c      |    5 ++
>  arch/blackfin/mach-bf548/boards/ezkit.c      |    5 ++
>  arch/blackfin/mach-bf609/boards/ezkit.c      |    5 ++
>  drivers/input/misc/bfin_rotary.c             |  113 +++++++++++++++-----------
>  5 files changed, 87 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
> index 029a050..68f2a8a 100644
> --- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
> +++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
> @@ -688,6 +688,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
>  
>  static struct resource bfin_rotary_resources[] = {
>  	{
> +		.start = CNT_CONFIG,
> +		.end   = CNT_CONFIG + 0xff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
>  		.start = IRQ_CNT,
>  		.end = IRQ_CNT,
>  		.flags = IORESOURCE_IRQ,
> diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
> index cc80c5b..d4219e8 100644
> --- a/arch/blackfin/mach-bf527/boards/ezkit.c
> +++ b/arch/blackfin/mach-bf527/boards/ezkit.c
> @@ -1114,6 +1114,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
>  
>  static struct resource bfin_rotary_resources[] = {
>  	{
> +		.start = CNT_CONFIG,
> +		.end   = CNT_CONFIG + 0xff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
>  		.start = IRQ_CNT,
>  		.end = IRQ_CNT,
>  		.flags = IORESOURCE_IRQ,
> diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
> index 0b68781..aaee1af 100644
> --- a/arch/blackfin/mach-bf548/boards/ezkit.c
> +++ b/arch/blackfin/mach-bf548/boards/ezkit.c
> @@ -181,6 +181,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
>  
>  static struct resource bfin_rotary_resources[] = {
>  	{
> +		.start = CNT_CONFIG,
> +		.end   = CNT_CONFIG + 0xff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
>  		.start = IRQ_CNT,
>  		.end = IRQ_CNT,
>  		.flags = IORESOURCE_IRQ,
> diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
> index 4ac72c6..57ce0a8 100644
> --- a/arch/blackfin/mach-bf609/boards/ezkit.c
> +++ b/arch/blackfin/mach-bf609/boards/ezkit.c
> @@ -96,6 +96,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
>  
>  static struct resource bfin_rotary_resources[] = {
>  	{
> +		.start = CNT_CONFIG,
> +		.end   = CNT_CONFIG + 0xff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
>  		.start = IRQ_CNT,
>  		.end = IRQ_CNT,
>  		.flags = IORESOURCE_IRQ,
> diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
> index dd62fc9..83a69bc 100644
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
> @@ -76,19 +87,46 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
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
>  
>  static int bfin_rotary_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct bfin_rot *rotary;
> +	struct resource *res;
>  	struct input_dev *input;
>  	int error;
>  
> +	rotary = devm_kzalloc(dev, sizeof(struct bfin_rot), GFP_KERNEL);
> +	if (!rotary) {
> +		dev_err(dev, "fail to malloc bfin_rot\n");
> +		return -ENOMEM;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	rotary->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(rotary->base))
> +		return PTR_ERR(rotary->base);
> +
> +	rotary->irq = platform_get_irq(pdev, 0);
> +	if (rotary->irq < 0) {
> +		dev_err(dev, "No rotary IRQ specified\n");
> +		return -ENOENT;
> +	}
> +
> +	error = devm_request_irq(dev, rotary->irq, bfin_rotary_isr,
> +			    0, dev_name(&pdev->dev), pdev);
> +	if (error) {
> +		dev_err(dev, "unable to claim irq %d; error %d\n",
> +			rotary->irq, error);
> +		return error;
> +	}
> +
>  	/* Basic validation */
>  	if ((pdata->rotary_up_key && !pdata->rotary_down_key) ||
>  	    (!pdata->rotary_up_key && pdata->rotary_down_key)) {
> @@ -97,15 +135,14 @@ static int bfin_rotary_probe(struct platform_device *pdev)
>  
>  	error = peripheral_request_list(pdata->pin_list, dev_name(&pdev->dev));
>  	if (error) {
> -		dev_err(&pdev->dev, "requesting peripherals failed\n");
> +		dev_err(dev, "requesting peripherals failed\n");
>  		return error;
>  	}
>  
> -	rotary = kzalloc(sizeof(struct bfin_rot), GFP_KERNEL);
>  	input = input_allocate_device();
> -	if (!rotary || !input) {
> +	if (!input) {
>  		error = -ENOMEM;
> -		goto out1;
> +		goto out;
>  	}
>  
>  	rotary->input = input;
> @@ -115,10 +152,6 @@ static int bfin_rotary_probe(struct platform_device *pdev)
>  	rotary->button_key = pdata->rotary_button_key;
>  	rotary->rel_code = pdata->rotary_rel_code;
>  
> -	error = rotary->irq = platform_get_irq(pdev, 0);
> -	if (error < 0)
> -		goto out1;
> -
>  	input->name = pdev->name;
>  	input->phys = "bfin-rotary/input0";
>  	input->dev.parent = &pdev->dev;
> @@ -144,45 +177,36 @@ static int bfin_rotary_probe(struct platform_device *pdev)
>  		__set_bit(rotary->button_key, input->keybit);
>  	}
>  
> -	error = request_irq(rotary->irq, bfin_rotary_isr,
> -			    0, dev_name(&pdev->dev), pdev);
> -	if (error) {
> -		dev_err(&pdev->dev,
> -			"unable to claim irq %d; error %d\n",
> -			rotary->irq, error);
> -		goto out1;
> -	}
> -
>  	error = input_register_device(input);
>  	if (error) {
> -		dev_err(&pdev->dev,
> -			"unable to register input device (%d)\n", error);
> -		goto out2;
> +		dev_err(dev, "unable to register input device (%d)\n", error);
> +		goto out;
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
>  
>  	return 0;
>  
> -out2:
> -	free_irq(rotary->irq, pdev);
> -out1:
> +out:
>  	input_free_device(input);
> -	kfree(rotary);
>  	peripheral_free_list(per_cnt);
>  
>  	return error;
> @@ -193,15 +217,12 @@ static int bfin_rotary_remove(struct platform_device *pdev)
>  	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct bfin_rot *rotary = platform_get_drvdata(pdev);
>  
> -	bfin_write_CNT_CONFIG(0);
> -	bfin_write_CNT_IMASK(0);
> +	writew(0, rotary->base + CNT_CONFIG_OFF);
> +	writew(0, rotary->base + CNT_IMASK_OFF);
>  
> -	free_irq(rotary->irq, pdev);
>  	input_unregister_device(rotary->input);
>  	peripheral_free_list(pdata->pin_list);
>  
> -	kfree(rotary);
> -
>  	return 0;
>  }
>  
> @@ -211,9 +232,9 @@ static int bfin_rotary_suspend(struct device *dev)
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
> @@ -226,15 +247,15 @@ static int bfin_rotary_resume(struct device *dev)
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
