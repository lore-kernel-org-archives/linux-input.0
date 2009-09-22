From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH] input: make gpio-keys use IRQF_SHARED
Date: Tue, 22 Sep 2009 21:06:05 +0200
Message-ID: <87fxae3ile.fsf@tac.ki.iif.hu>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
	<20090916162853.GA4970@core.coreip.homeip.net>
	<87hbuvggfl.fsf@tac.ki.iif.hu>
	<20090922164136.GA22639@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:57561 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbZIVTGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 15:06:04 -0400
In-Reply-To: <20090922164136.GA22639@core.coreip.homeip.net> (Dmitry
	Torokhov's message of "Tue, 22 Sep 2009 09:41:36 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-input@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Tue, Sep 22, 2009 at 05:14:22PM +0200, Ferenc Wagner wrote:
>> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>>=20
>>> On Wed, Sep 16, 2009 at 07:03:18PM +0400, Dmitry Eremin-Solenikov w=
rote:
>>>> There is nothing that disallows gpio-keys to share it's IRQ line
>>>> w/ other drivers. Make it use IRQF_SHARED in request_irq().
>>>>=20
>>>> An example of other driver with which I'd like to share IRQ line
>>>> for GPIO buttons is ledtrig-gpio.
>>>>=20
>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>> ---
>>>>  drivers/input/keyboard/gpio_keys.c |    1 +
>>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>>=20
>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/ke=
yboard/gpio_keys.c
>>>> index efed0c9..9fc2fab 100644
>>>> --- a/drivers/input/keyboard/gpio_keys.c
>>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>>> @@ -147,6 +147,7 @@ static int __devinit gpio_keys_probe(struct pl=
atform_device *pdev)
>>>>  		}
>>>> =20
>>>>  		error =3D request_irq(irq, gpio_keys_isr,
>>>> +				    IRQF_SHARED |
>>>>  				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>>>>  				    button->desc ? button->desc : "gpio_keys",
>>>>  				    bdata);
>>>
>>> How will you determine which device generated the interrupt? Becaus=
e you
>>> can't return IRQ_HANDLED unconditionally and expect both devices wo=
rk
>>> reliably.
>>=20
>> It would be possible, but commit
>> da0d03fe6cecde837f113a8a587f5a872d0fade0 states that:
>>=20
>>     The gpio_get_value function may sleep, so it should not be calle=
d in a
>>     timer function.
>>=20
>> But I don't see why it could sleep, is that really the case?
>
> There are things like i2c gpio extenders that require access to slow
> buses and can't sleep.

I assume you mean "can sleep".  Please read my other reply in this
thread before the following.  All this seems to mean that using level
triggered interrupts on such devices is impossible, unless we find a
way to acknowledge the interrupt without GPIO access.  But level
triggering is needed for sharing.  Maybe we could make this
configurable on a per-button basis?  Or by a module parameter?
Anyway, a gpio_cansleep test should go into the module initialisation
routine.

>> Also, commit 57ffe9d539e0eb741bb9ca8f2834d210e70ee2e3 removed the
>> possibility of telling apart different keys, so that should be
>> reverted during the process.  I already asked Uwe Kleine-K=C3=B6nig
>> about the whys, but didn't get a reply.
>
> I don't see why you say that... You request IRQ per button and you ge=
t
> that button structure as argument in the interrupt handler.

In practice, several buttons often share a single IRQ line, possibly
even with other hardware, like the serial port in my case (as
described in my other reply).  So generally you need the full platform
data for all GPIO buttons in the handler, to find out which generated
the interrupt.
--=20
Thanks,
=46eri.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
