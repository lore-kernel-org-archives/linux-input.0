From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Thu, 16 Jun 2011 13:27:32 -0600
Message-ID: <20110616192732.GJ3795@ponder.secretlab.ca>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-4-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53394 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787Ab1FPThp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2011 15:37:45 -0400
Received: by pvg12 with SMTP id 12so1269153pvg.19
        for <linux-input@vger.kernel.org>; Thu, 16 Jun 2011 12:37:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308042491-20203-4-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
> Use a threaded interrupt handler in order to permit the handler to use
> a GPIO driver that causes things like I2C transactions being done inside
> the handler context.
> Also, gpio_keys_init needs to be declared as a late_initcall, to make sure
> all needed GPIO drivers have been loaded if the drivers are built into the
> kernel.

...which is a horrid hack, but until device dependencies can be
described, it isn't one that can be solved easily.

This patch looks okay to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/input/keyboard/gpio_keys.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 78aeeaa..d179861 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -3,7 +3,7 @@
>   *
>   * Copyright 2005 Phil Blundell
>   *
> - * Added OF support:
> + * Added OF support and enabled use with I2C GPIO expanders:
>   * Copyright 2010 David Jander <david@protonic.nl>
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -417,7 +417,7 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
>  	if (!button->can_disable)
>  		irqflags |= IRQF_SHARED;
>  
> -	error = request_any_context_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
> +	error = request_threaded_irq(irq, NULL, gpio_keys_isr, irqflags, desc, bdata);
>  	if (error < 0) {
>  		dev_err(dev, "Unable to claim irq %d; error %d\n",
>  			irq, error);
> @@ -767,10 +767,10 @@ static void __exit gpio_keys_exit(void)
>  	platform_driver_unregister(&gpio_keys_device_driver);
>  }
>  
> -module_init(gpio_keys_init);
> +late_initcall(gpio_keys_init);
>  module_exit(gpio_keys_exit);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
> -MODULE_DESCRIPTION("Keyboard driver for CPU GPIOs");
> +MODULE_DESCRIPTION("Keyboard driver for GPIOs");
>  MODULE_ALIAS("platform:gpio-keys");
> -- 
> 1.7.4.1
> 
