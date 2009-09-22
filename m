From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH] input: make gpio-keys use IRQF_SHARED
Date: Tue, 22 Sep 2009 17:14:22 +0200
Message-ID: <87hbuvggfl.fsf@tac.ki.iif.hu>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
	<20090916162853.GA4970@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:50340 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbZIVPod convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 11:44:33 -0400
In-Reply-To: <20090916162853.GA4970@core.coreip.homeip.net> (Dmitry Torokhov's
	message of "Wed, 16 Sep 2009 09:28:54 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-input@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Wed, Sep 16, 2009 at 07:03:18PM +0400, Dmitry Eremin-Solenikov wro=
te:
>> There is nothing that disallows gpio-keys to share it's IRQ line
>> w/ other drivers. Make it use IRQF_SHARED in request_irq().
>>=20
>> An example of other driver with which I'd like to share IRQ line
>> for GPIO buttons is ledtrig-gpio.
>>=20
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  drivers/input/keyboard/gpio_keys.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyb=
oard/gpio_keys.c
>> index efed0c9..9fc2fab 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -147,6 +147,7 @@ static int __devinit gpio_keys_probe(struct plat=
form_device *pdev)
>>  		}
>> =20
>>  		error =3D request_irq(irq, gpio_keys_isr,
>> +				    IRQF_SHARED |
>>  				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>>  				    button->desc ? button->desc : "gpio_keys",
>>  				    bdata);
>
> How will you determine which device generated the interrupt? Because =
you
> can't return IRQ_HANDLED unconditionally and expect both devices work
> reliably.

It would be possible, but commit
da0d03fe6cecde837f113a8a587f5a872d0fade0 states that:

    The gpio_get_value function may sleep, so it should not be called i=
n a
    timer function.

But I don't see why it could sleep, is that really the case?  Because
that makes acknowledging the interrupt very hard.  Actually, I need
and tested interrupt sharing.  What are the "cansleep wrappers" in
asm-generic/gpio.h if these function can sleep as well?  I'd be
grateful for some explanation.  Also, commit
57ffe9d539e0eb741bb9ca8f2834d210e70ee2e3 removed the possibility of
telling apart different keys, so that should be reverted during the
process.  I already asked Uwe Kleine-K=C3=B6nig about the whys, but did=
n't
get a reply.
--=20
Regards,
=46eri.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
