From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Mon, 23 Nov 2009 17:42:08 +0100
Message-ID: <87y6lxchwf.fsf@tac.ki.iif.hu>
References: <20091120084054.GC3009@core.coreip.homeip.net>
	<cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
	<cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
	<8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:36399 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561AbZKWQmR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 11:42:17 -0500
In-Reply-To: <8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com>
	(Mika Westerberg's message of "Mon, 23 Nov 2009 14:39:39 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:

> Added new field to struct gpio_keys_button: irqflags which can
> be used to specify exact irqflags the platform wants. If not specified,
> it defaults to: IRQF_SHARED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING.
>
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -106,10 +107,14 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
>  		goto fail3;
>  	}
>  
> -	error = request_irq(irq, gpio_keys_isr,
> -			    IRQF_SHARED |
> -			    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -			    desc, bdata);
> +	if (button->irqflags == 0) {
> +		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> +			   IRQF_SHARED;
> +	} else {
> +		irqflags = button->irqflags;
> +	}
> +
> +	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
>  	if (error) {
>  		dev_err(dev, "Unable to claim irq %d; error %d\n",
>  			irq, error);

Hi Mika,

linux/interrupt.h says:

    When requesting an interrupt without specifying a IRQF_TRIGGER, the
    setting should be assumed to be "as already configured", which may
    be as per machine or firmware initialisation. 

So I'm not sure it's a good idea to exclude 0 from the possible irqflag
values.
-- 
Regards,
Feri.
