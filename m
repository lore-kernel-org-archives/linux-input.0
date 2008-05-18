From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: [PATCH] Add support for HTC Shift Touchscreen
Date: Sun, 18 May 2008 11:26:50 +0200
Message-ID: <20080518092627.GA21237@joi>
References: <482ED31E.2000009@eslack.org> <482F09FC.9050403@eslack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:22082 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbYERJ1T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 May 2008 05:27:19 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1296888fkq.5
        for <linux-input@vger.kernel.org>; Sun, 18 May 2008 02:27:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <482F09FC.9050403@eslack.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pau Oliva Fora <pau@eslack.org>
Cc: dmitry.torokhov@gmail.com, sam@ravnborg.org, penberg@cs.helsinki.fi, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 17, 2008 at 06:38:20PM +0200, Pau Oliva Fora wrote:
> +static int __init htcpen_init(void)
> +{
> +	int err;
> +
> +	printk(KERN_INFO "htcpen: module inserted\n");
> +
> +	inb_p(HTCPEN_PORT_IRQ_CLEAR);
> +
> +	htcpen_dev = input_allocate_device();
> +	if (!htcpen_dev) {
> +		printk(KERN_ERR "htcpen: can't allocate device\n");
> +		err = -ENOMEM;
> +		goto fail1;

htcpen_dev is null here, so no need to call input_free_device

> +	}
> +
> +	htcpen_dev->name = "HTC Pen TouchScreen";
> +	htcpen_dev->id.bustype = BUS_ISA;
> +	htcpen_dev->id.vendor = 0;
> +	htcpen_dev->id.product = 0;
> +	htcpen_dev->id.version = 0;
> +
> +	input_set_abs_params(htcpen_dev, ABS_X, 0, X_AXIS_MAX, 0, 0);
> +	input_set_abs_params(htcpen_dev, ABS_Y, 0, Y_AXIS_MAX, 0, 0);
> +
> +	htcpen_dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
> +	htcpen_dev->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y);
> +	htcpen_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +
> +	err = request_irq(HTCPEN_IRQ, htcpen_interrupt, 0, "htcpen",
> +		htcpen_dev);
> +	if (err) {
> +		printk(KERN_ERR "htcpen: irq busy\n");
> +		err = -EBUSY;
> +		goto fail1;
> +	}
> +
> +	err = input_register_device(htcpen_dev);
> +	if (err)
> +		goto fail2;
> +
> +	outb_p(DEVICE_ENABLE, HTCPEN_PORT_INIT);
> +
> +	return 0;
> +
> + fail2:	free_irq(HTCPEN_IRQ, htcpen_dev);
> + fail1:	input_free_device(htcpen_dev);
> +	return err;
> +}
> +
> +static void __exit htcpen_exit(void)
> +{
> +	input_unregister_device(htcpen_dev);
> +	free_irq(HTCPEN_IRQ, htcpen_dev);

input_free_device ?

> +	printk(KERN_INFO "htcpen: module removed\n");
> +}

Marcin
