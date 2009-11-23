From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to specify
	exact irq flags
Date: Mon, 23 Nov 2009 09:24:52 -0800
Message-ID: <20091123172451.GD17813@core.coreip.homeip.net>
References: <20091120084054.GC3009@core.coreip.homeip.net> <cover.1258976669.git.ext-mika.1.westerberg@nokia.com> <cover.1258976669.git.ext-mika.1.westerberg@nokia.com> <8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com> <87y6lxchwf.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:51786 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbZKWRYw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 12:24:52 -0500
Received: by pwi3 with SMTP id 3so3552613pwi.21
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2009 09:24:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87y6lxchwf.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-input@vger.kernel.org

On Mon, Nov 23, 2009 at 05:42:08PM +0100, Ferenc Wagner wrote:
> Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
> 
> > Added new field to struct gpio_keys_button: irqflags which can
> > be used to specify exact irqflags the platform wants. If not specified,
> > it defaults to: IRQF_SHARED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING.
> >
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -106,10 +107,14 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
> >  		goto fail3;
> >  	}
> >  
> > -	error = request_irq(irq, gpio_keys_isr,
> > -			    IRQF_SHARED |
> > -			    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> > -			    desc, bdata);
> > +	if (button->irqflags == 0) {
> > +		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> > +			   IRQF_SHARED;
> > +	} else {
> > +		irqflags = button->irqflags;
> > +	}
> > +
> > +	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
> >  	if (error) {
> >  		dev_err(dev, "Unable to claim irq %d; error %d\n",
> >  			irq, error);
> 
> Hi Mika,
> 
> linux/interrupt.h says:
> 
>     When requesting an interrupt without specifying a IRQF_TRIGGER, the
>     setting should be assumed to be "as already configured", which may
>     be as per machine or firmware initialisation. 
> 
> So I'm not sure it's a good idea to exclude 0 from the possible irqflag
> values.

Hmm... OTOH we can't just require the new irq flags to be always
specified, that would break all current users. Do we need a flag
indicating that the button will be using custom IRQ flags?

-- 
Dmitry
