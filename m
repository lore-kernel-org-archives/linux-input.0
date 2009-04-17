From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH, v2] input/imx2x: generic keypad handler for i.MX SoCs
Date: Fri, 17 Apr 2009 09:04:11 -0700
Message-ID: <20090417160409.GB20999@dtor-d630.eng.vmware.com>
References: <200904171640.14294.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:50537 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbZDQQE0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2009 12:04:26 -0400
Received: by rv-out-0506.google.com with SMTP id f9so973801rvb.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2009 09:04:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200904171640.14294.hs4233@mail.mn-solutions.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: linux-input@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.arm.linux.org.uk

Hi Holger,

On Fri, Apr 17, 2009 at 04:40:14PM +0200, Holger Schurig wrote:
> The i.MX21 SoC has a built-in keypad controller, which this driver
> utilizes. As the keypad usually doesn't connect to a standard PC
> keyboard, but to the keyboard of a PDA-like device, I wrote the
> driver in a keyboard-layout agnostic way.
> 
> Instead, the driver reports each row/column key press and release
> via a platform-data supplied function. Board-specific code can than
> decode the input events from this and submit them.
> 

It looks very nice, thank you. I wonder however whether a separate
method for scancode to keycode conversion is really needed. Why can't
you have platform code supply a keymap table and set up keycode,
keycodesize and keycodemax fields of the input_dev structure? The
generic code can easily set up keybits based on provided keymap. If you
do this then input core will allow changing keymap at runtime with
EVIOCGKEYCODE/EVIOCSKEYCODE.

> +++ linux/arch/arm/plat-mxc/include/mach/mxc_keypad.h
> @@ -0,0 +1,20 @@
> +#ifndef __MACH_MXC_KEYPAD_H
> +#define __MACH_MXC_KEYPAD_H
> +
> +#include <linux/input.h>
> +
> +#define MAX_MATRIX_KEY_ROWS	(8)
> +#define MAX_MATRIX_KEY_COLS	(8)
> +
> +struct input_dev;

I don't think you need both linux/input.h and forward declaration of
input_dev.

> +
> +#if 0

Why is this code disabled?

> +static int mxc_keypad_open(struct input_dev *dev)
> +{
> +	struct mxc_keypad *kp = input_get_drvdata(dev);
> +	struct clk *clk;
> +
> +	/* Enable unit clock */
> +	clk = clk_get(&pdev->dev, "kpp");
> +	if (IS_ERR(clk))
> +		return -ENODEV;
> +	clk_enable(clk);
> +
> +	/* configure keypad */
> +	__raw_writew(kp->pdata->output_pins |
> +		kp->pdata->input_pins, kp->base + KPCR);
> +	__raw_writew(0, kp->base + KPDR);
> +	__raw_writew(kp->pdata->output_pins, kp->base + KDDR);
> +	__raw_writew(KPSR_KPP_EN | KPSR_KDIE |
> +		KPSR_KPKD | KPSR_KRSS | KPSR_KDSC, kp->base + KPSR);
> +
> +	return 0;
> +}
> +
> +static void mxc_keypad_close(struct input_dev *dev)
> +{
> +	struct mxc_keypad *kp = input_get_drvdata(dev);
> +	u16 stat;
> +	struct clk *clk;
> +
> +	/* Mask interrupts */
> +	stat = __raw_readw(kp->base + KPSR);
> +	stat &= ~KPSR_INT_MASK;
> +	__raw_writew(stat | KPSR_KPKD | KPSR_KPKR, kp->base + KPSR);
> +
> +	clk = clk_get(&dev->dev, "kpp");
> +	if (clk)
> +		clk_disable(clk);
> +}
> +#endif
> +
> +static int __devinit mxc_keypad_probe(struct platform_device *pdev)
> +{
> +	struct mxc_keypad *kp;
> +	struct input_dev *input_dev;
> +	struct mxc_keypad_platform_data *pdata;
> +	struct resource *res;
> +	struct clk *clk;
> +	int irq, error;
> +
> +	pdata = pdev->dev.platform_data;
> +	if (!pdata || !pdata->handle_key)
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irq = platform_get_irq(pdev, 0);
> +	if (!res || !irq)
> +		return -ENXIO;
> +
> +	res = request_mem_region(res->start, resource_size(res), pdev->name);
> +	if (!res)
> +		return -EBUSY;
> +
> +	kp = kzalloc(sizeof(struct mxc_keypad), GFP_KERNEL);
> +	if (!kp) {
> +		error = -ENOMEM;
> +		goto failed_release;
> +	}
> +
> +	kp->res = res;
> +	kp->pdata = pdata;
> +
> +	/* Create and register the input driver. */
> +	input_dev = kp->input_dev = input_allocate_device();
> +	if (!input_dev) {
> +		dev_err(&pdev->dev, "input_allocate_device\n");
> +		error = -ENOMEM;
> +		goto failed_put_clk;
> +	}
> +
> +	kp->base = ioremap(res->start, resource_size(res));
> +	if (!kp->base) {
> +		dev_err(&pdev->dev, "ioremap\n");
> +		error = -ENOMEM;
> +		goto failed_free_dev;
> +	}
> +
> +	clk = clk_get(&pdev->dev, "kpp");
> +	if (IS_ERR(clk)) {
> +		error = -ENODEV;
> +		goto failed_unmap;
> +	}
> +
> +	input_dev->name = pdev->name;
> +	input_dev->dev.parent = &pdev->dev;
> +	input_dev->id.bustype = BUS_HOST;
> +	input_dev->id.vendor = 0x0001;
> +	input_dev->id.product = 0x0001;
> +	input_dev->id.version = 0x0100;
> +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +	input_set_drvdata(input_dev, kp);
> +
> +	platform_set_drvdata(pdev, kp);
> +
> +	/* should call input_set_capability(input_dev, EV_KEY, code); */
> +	if (kp->pdata->init)
> +		kp->pdata->init(input_dev, pdev);

Hmm.. I wonder if the init() method should be returning error code. We
don't really know the extent of setup needed by a particular board and
whetehr any of the steps could fail.

> +
> +	error = request_irq(irq, mxc_keypad_irq_handler,
> +		IRQF_DISABLED, pdev->name, kp);
> +	if (error) {
> +		dev_err(&pdev->dev, "request_irq\n");
> +		goto failed_clk_put;
> +	}
> +
> +	kp->irq = irq;
> +
> +	/* Register the input device */
> +	error = input_register_device(input_dev);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		goto failed_free_irq;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	/* configure keypad */
> +	clk_enable(clk);
> +	__raw_writew(kp->pdata->output_pins |
> +		kp->pdata->input_pins, kp->base + KPCR);
> +	__raw_writew(0, kp->base + KPDR);
> +	__raw_writew(kp->pdata->output_pins, kp->base + KDDR);
> +	__raw_writew(KPSR_KPP_EN | KPSR_KDIE |
> +		KPSR_KPKD | KPSR_KRSS | KPSR_KDSC, kp->base + KPSR);
> +
> +	return 0;
> +
> +failed_free_irq:
> +	free_irq(irq, pdev);
> +	platform_set_drvdata(pdev, NULL);
> +failed_clk_put:
> +	clk_disable(clk);
> +	clk_put(clk);
> +failed_unmap:
> +	iounmap(kp->base);
> +failed_free_dev:
> +	input_free_device(input_dev);
> +failed_put_clk:
> +	kfree(kp);
> +failed_release:
> +	release_mem_region(res->start, resource_size(res));
> +	return error;
> +}
> +
> +static int __devexit mxc_keypad_remove(struct platform_device *pdev)
> +{
> +	struct mxc_keypad *kp = platform_get_drvdata(pdev);
> +
> +	device_init_wakeup(&pdev->dev, 0);
> +
> +	if (kp) {

Can' kp actually ever be NULL when this function is invoked?

> +		/* Mask interrupts */
> +		u16 stat = __raw_readw(kp->base + KPSR);
> +		stat &= ~KPSR_INT_MASK;
> +		__raw_writew(stat | KPSR_KPKD | KPSR_KPKR, kp->base + KPSR);
> +
> +		free_irq(kp->irq, pdev);
> +
> +		if (kp->pdata->exit)
> +			kp->pdata->exit(pdev);

Hmm, we do init() before requesting IRQ and enabling clock... Maybe move
exit() after disabling clock?

> +
> +		if (kp->base)
> +			iounmap(kp->base);
> +
> +		clk_disable(kp->clk);
> +		clk_put(kp->clk);
> +
> +		input_unregister_device(kp->input_dev);
> +		release_mem_region(kp->res->start, resource_size(kp->res));
> +	}
> +
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(kp);
> +	return 0;
> +}
> +
> +/* work with hotplug and coldplug */
> +MODULE_ALIAS("platform:mxc-keypad");
> +
> +static struct platform_driver mxc_keypad_driver = {
> +	.probe		= mxc_keypad_probe,
> +	.remove		= __devexit_p(mxc_keypad_remove),

With this code is likely being used in a PDA does it need suspendresume
handlers by any chance?

-- 
Dmitry
