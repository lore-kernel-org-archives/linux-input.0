From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] input/nomadik-ske: cleanup of probe and some more
 code style
Date: Mon, 25 Jun 2012 00:43:25 -0700
Message-ID: <20120625074325.GH13876@core.coreip.homeip.net>
References: <1339942685-20194-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38291 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab2FYHna (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 03:43:30 -0400
Received: by pbbrp8 with SMTP id rp8so6193566pbb.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 00:43:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339942685-20194-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-input@vger.kernel.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Naga Radesh Y <naga.radheshy@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Linus,

On Sun, Jun 17, 2012 at 04:18:05PM +0200, Linus Walleij wrote:
> From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> 
> This fixes some kerneldoc, and clean up the probe function so we
> split it in two parts: first allocate all resources and then start
> the clock and begin initializing the hardware. We exit quickly
> with negative error if the probe is unsucessful when getting
> resources. We add a pointer to the device's struct device to be
> used for dev_* prints and similar.
> 
> Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> Signed-off-by: Naga Radesh Y <naga.radheshy@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/input/keyboard/nomadik-ske-keypad.c |  152 +++++++++++++++------------
>  1 file changed, 83 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
> index ca802fe..a2f2479 100644
> --- a/drivers/input/keyboard/nomadik-ske-keypad.c
> +++ b/drivers/input/keyboard/nomadik-ske-keypad.c
> @@ -53,14 +53,17 @@
>  
>  /**
>   * struct ske_keypad  - data structure used by keypad driver
> - * @irq:	irq no
> - * @reg_base:	ske regsiters base address
> - * @input:	pointer to input device object
> - * @board:	keypad platform device
> - * @keymap:	matrix scan code table for keycodes
> - * @clk:	clock structure pointer
> + * @dev:		Pointer to the structure device
> + * @irq:		irq no
> + * @reg_base:		ske regsiters base address
> + * @input:		pointer to input device object
> + * @board:		keypad platform device
> + * @keymap:		matrix scan code table for keycodes
> + * @clk:		clock structure pointer
> + * @ske_keypad_lock:    lock used while writting into registers
>   */
>  struct ske_keypad {
> +	struct device *dev;
>  	int irq;
>  	void __iomem *reg_base;
>  	struct input_dev *input;
> @@ -85,9 +88,9 @@ static void ske_keypad_set_bits(struct ske_keypad *keypad, u16 addr,
>  	spin_unlock(&keypad->ske_keypad_lock);
>  }
>  
> -/*
> - * ske_keypad_chip_init: init keypad controller configuration
> - *
> +/**
> + * ske_keypad_chip_init() - init keypad controller configuration
> + * @keypad: pointer to device structure
>   * Enable Multi key press detection, auto scan mode
>   */
>  static int __init ske_keypad_chip_init(struct ske_keypad *keypad)
> @@ -225,6 +228,9 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
>  	struct ske_keypad *keypad;
>  	struct input_dev *input;
>  	struct resource *res;
> +	struct clk *clk;
> +	void __iomem *reg_base;
> +	int ret = 0;

Now you have some error paths using 'error' and some using your new
'ret' with main exit using 'ret'. If 'error' cause fail you'll end up
returning 0 which is bad. Also, I'd prefer if you've kept using 'error'
everywhere.

Also I do not see benefits of the new probe sequence, old on works just
as well, right?

>  	int irq;
>  	int error;
>  
> @@ -242,40 +248,42 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_err(&pdev->dev, "missing platform resources\n");
> -		return -EINVAL;
> +		return -ENXIO;
>  	}
>  
> -	keypad = kzalloc(sizeof(struct ske_keypad), GFP_KERNEL);
> -	input = input_allocate_device();
> -	if (!keypad || !input) {
> -		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
> -		error = -ENOMEM;
> -		goto err_free_mem;
> +	res = request_mem_region(res->start, resource_size(res), pdev->name);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to request I/O memory\n");
> +		return -EBUSY;
>  	}
>  
> -	keypad->irq = irq;
> -	keypad->board = plat;
> -	keypad->input = input;
> -	spin_lock_init(&keypad->ske_keypad_lock);
> +	reg_base = ioremap(res->start, resource_size(res));
> +	if (!reg_base) {
> +		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> +		ret = -ENXIO;
> +		goto out_freerequest_memregions;
> +	}
>  
> -	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
> -		dev_err(&pdev->dev, "failed to request I/O memory\n");
> -		error = -EBUSY;
> -		goto err_free_mem;
> +	clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "failed to clk_get\n");
> +		ret = PTR_ERR(clk);
> +		goto out_freeioremap;
>  	}
>  
> -	keypad->reg_base = ioremap(res->start, resource_size(res));
> -	if (!keypad->reg_base) {
> -		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> -		error = -ENXIO;
> -		goto err_free_mem_region;
> +	/* resources are sane; we begin allocation */
> +	keypad = kzalloc(sizeof(struct ske_keypad), GFP_KERNEL);
> +	if (!keypad) {
> +		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
> +		goto out_freeclk;
>  	}
> +	keypad->dev = &pdev->dev;
>  
> -	keypad->clk = clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(keypad->clk)) {
> -		dev_err(&pdev->dev, "failed to get clk\n");
> -		error = PTR_ERR(keypad->clk);
> -		goto err_iounmap;
> +	input = input_allocate_device();
> +	if (!input) {
> +		dev_err(&pdev->dev, "failed to input_allocate_device\n");
> +		ret = -ENOMEM;
> +		goto out_freekeypad;
>  	}
>  
>  	input->id.bustype = BUS_HOST;
> @@ -287,37 +295,43 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
>  					   keypad->keymap, input);
>  	if (error) {
>  		dev_err(&pdev->dev, "Failed to build keymap\n");
> -		goto err_iounmap;
> +		goto out_freekeypad;
>  	}
>  
>  	input_set_capability(input, EV_MSC, MSC_SCAN);
> +	input_set_drvdata(input, keypad);
> +
> +	__set_bit(EV_KEY, input->evbit);
>  	if (!plat->no_autorepeat)
>  		__set_bit(EV_REP, input->evbit);
>  
> -	clk_enable(keypad->clk);
> +	ret = input_register_device(input);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"unable to register input device: %d\n", ret);
> +		goto out_freeinput;
> +	}
>  
> -	/* go through board initialization helpers */
> -	if (keypad->board->init)
> -		keypad->board->init();
> +	keypad->irq	= irq;
> +	keypad->board	= plat;
> +	keypad->input	= input;
> +	keypad->reg_base = reg_base;
> +	keypad->clk	= clk;
>  
> -	error = ske_keypad_chip_init(keypad);
> -	if (error) {
> -		dev_err(&pdev->dev, "unable to init keypad hardware\n");
> -		goto err_clk_disable;
> -	}
> +	/* allocations are sane, we begin HW initialization */
> +	clk_enable(keypad->clk);
>  
> -	error = request_threaded_irq(keypad->irq, NULL, ske_keypad_irq,
> -				     IRQF_ONESHOT, "ske-keypad", keypad);
> -	if (error) {
> -		dev_err(&pdev->dev, "allocate irq %d failed\n", keypad->irq);
> -		goto err_clk_disable;
> +	if (keypad->board->init && keypad->board->init() < 0) {
> +		dev_err(&pdev->dev, "keyboard init config failed\n");
> +		ret = -EINVAL;
> +		goto out_unregisterinput;
>  	}
>  
> -	error = input_register_device(input);
> -	if (error) {
> -		dev_err(&pdev->dev,
> -				"unable to register input device: %d\n", error);
> -		goto err_free_irq;
> +	ret =  request_threaded_irq(keypad->irq, NULL, ske_keypad_irq,
> +				IRQF_ONESHOT, "ske-keypad", keypad);
> +	if (ret) {
> +		dev_err(&pdev->dev, "allocate irq %d failed\n", keypad->irq);
> +		goto out_unregisterinput;
>  	}
>  
>  	if (plat->wakeup_enable)
> @@ -327,19 +341,21 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -err_free_irq:
> -	free_irq(keypad->irq, keypad);
> -err_clk_disable:
> +out_unregisterinput:
> +	input_unregister_device(input);
> +	input = NULL;
>  	clk_disable(keypad->clk);
> -	clk_put(keypad->clk);
> -err_iounmap:
> -	iounmap(keypad->reg_base);
> -err_free_mem_region:
> -	release_mem_region(res->start, resource_size(res));
> -err_free_mem:
> +out_freeinput:
>  	input_free_device(input);
> +out_freekeypad:
>  	kfree(keypad);
> -	return error;
> +out_freeclk:
> +	clk_put(clk);
> +out_freeioremap:
> +	iounmap(reg_base);
> +out_freerequest_memregions:
> +	release_mem_region(res->start, resource_size(res));
> +	return ret;
>  }
>  
>  static int __devexit ske_keypad_remove(struct platform_device *pdev)
> @@ -347,8 +363,6 @@ static int __devexit ske_keypad_remove(struct platform_device *pdev)
>  	struct ske_keypad *keypad = platform_get_drvdata(pdev);
>  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  
> -	free_irq(keypad->irq, keypad);
> -

This change is broken: you unregister input device but still have IRQ
registered. What stops that IRQ to be delivered and access freed memory?

>  	input_unregister_device(keypad->input);
>  

Thanks.

-- 
Dmitry
