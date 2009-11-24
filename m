From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Tue, 24 Nov 2009 12:05:57 +0100
Message-ID: <87my2cp4h6.fsf@tac.ki.iif.hu>
References: <20091120084054.GC3009@core.coreip.homeip.net>
	<cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
	<cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
	<8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com>
	<87y6lxchwf.fsf@tac.ki.iif.hu>
	<20091123172451.GD17813@core.coreip.homeip.net>
	<87tywlcbyr.fsf@tac.ki.iif.hu>
	<20091124063711.GL17675@esdhcp04058.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:57405 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932193AbZKXLFx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2009 06:05:53 -0500
In-Reply-To: <20091124063711.GL17675@esdhcp04058.research.nokia.com> (Mika
	Westerberg's message of "Tue, 24 Nov 2009 08:37:11 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:

> On Mon, Nov 23, 2009 at 07:50:20PM +0100, ext Ferenc Wagner wrote:
>> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>> 
>>> On Mon, Nov 23, 2009 at 05:42:08PM +0100, Ferenc Wagner wrote:
>>>> Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
>>>> 
>>>>> Added new field to struct gpio_keys_button: irqflags which can
>>>>> be used to specify exact irqflags the platform wants. If not specified,
>>>>> it defaults to: IRQF_SHARED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING.
>>>>>
>>>>> --- a/drivers/input/keyboard/gpio_keys.c
>>>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>>>> @@ -106,10 +107,14 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
>>>>>  		goto fail3;
>>>>>  	}
>>>>>  
>>>>> -	error = request_irq(irq, gpio_keys_isr,
>>>>> -			    IRQF_SHARED |
>>>>> -			    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>>>>> -			    desc, bdata);
>>>>> +	if (button->irqflags == 0) {
>>>>> +		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
>>>>> +			   IRQF_SHARED;
>>>>> +	} else {
>>>>> +		irqflags = button->irqflags;
>>>>> +	}
>>>>> +
>>>>> +	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
>>>>>  	if (error) {
>>>>>  		dev_err(dev, "Unable to claim irq %d; error %d\n",
>>>>>  			irq, error);
>>>> 
>>>> linux/interrupt.h says:
>>>> 
>>>>     When requesting an interrupt without specifying a IRQF_TRIGGER, the
>>>>     setting should be assumed to be "as already configured", which may
>>>>     be as per machine or firmware initialisation. 
>>>> 
>>>> So I'm not sure it's a good idea to exclude 0 from the possible irqflag
>>>> values.
>>>
>>> Hmm... OTOH we can't just require the new irq flags to be always
>>> specified, that would break all current users. Do we need a flag
>>> indicating that the button will be using custom IRQ flags?
>> 
>> Or let for example -1 mean 0, which is ugly, to say the least.
>
> How about adding (again) new field: bool custom_irqflags?

Thinking about it, since multiple buttons can share a single IRQ, this
can't be a per-button field after all.  Perhaps a better solution would
be adding a new mapping to the platform data:

struct gpio_keys_irq {
        int irq;
        int irqflags;
        int wakeup;                 /* replace the per-button field */
}

struct gpio_keys_platform_data {
        struct gpio_keys_button *buttons;
        int nbuttons;
        unsigned int rep:1;
        struct gpio_keys_irq *irqs; /* new member */
        int nirqs;                  /* new member */
};

>> Anyway, I'd much prefer an implementation which doesn't work against
>> having multiple buttons on a single IRQ line, which is the case for
>> example in arch/mips/bcm47xx/gpio.c.  Then the IRQ could still be
>> disabled if all its buttons are disabled, unless it's shared with
>> another driver (and IRQF_SHARED would control this aspect sharing).
>
> Do you mean something like:
>
> 	if (button->custom_irqflags) {
> 		if (button->irqflags & IRQF_SHARED) {
> 			/* cannot mute this button */
> 		} else {
> 			...
> 	}

Not quite, because the default irqflags contain IRQF_SHARED.  More like:

disable_button (this);
if (button->custom_irqflags && !(button->irqflags & IRQF_SHARED)
    && (all buttons on this IRQ are disabled)) {
        disable_irq (gpio_to_irq (this));
}

> In our case, we only have 1:1 mapping between GPIO lines and buttons so
> current version works but if there are any (possible) users for this kind
> of setup I can implement it.

I quoted (and own) a platform with such arrangement.  I'm somewhat short
on time to work on this hobby project, but of course I don't expect you
to do the heavy lifting.  Unfortunately I haven't yet managed to get a
clear picture about how to properly attack it (the problem is GPIO
access from the IRQ handler, if you didn't read the thread), so I
couldn't produce acceptable code (even though in my case gpio_get_value
can't sleep, so I've got working code).  Meanwhile, I'm trying to do my
best to not let things go in a direction which makes this change harder
that it currently is.  I'm really sorry this hurts your efforts.

> Dmitry, what do you think?

Yep.
-- 
Thanks,
Feri.
