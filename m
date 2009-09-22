From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: make gpio-keys use IRQF_SHARED
Date: Tue, 22 Sep 2009 09:41:36 -0700
Message-ID: <20090922164136.GA22639@core.coreip.homeip.net>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com> <20090916162853.GA4970@core.coreip.homeip.net> <87hbuvggfl.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:46739 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbZIVQln (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 12:41:43 -0400
Received: by pzk17 with SMTP id 17so265823pzk.1
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2009 09:41:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87hbuvggfl.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-input@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>

On Tue, Sep 22, 2009 at 05:14:22PM +0200, Ferenc Wagner wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>=20
> > On Wed, Sep 16, 2009 at 07:03:18PM +0400, Dmitry Eremin-Solenikov w=
rote:
> >> There is nothing that disallows gpio-keys to share it's IRQ line
> >> w/ other drivers. Make it use IRQF_SHARED in request_irq().
> >>=20
> >> An example of other driver with which I'd like to share IRQ line
> >> for GPIO buttons is ledtrig-gpio.
> >>=20
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
> >>  drivers/input/keyboard/gpio_keys.c |    1 +
> >>  1 files changed, 1 insertions(+), 0 deletions(-)
> >>=20
> >> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/ke=
yboard/gpio_keys.c
> >> index efed0c9..9fc2fab 100644
> >> --- a/drivers/input/keyboard/gpio_keys.c
> >> +++ b/drivers/input/keyboard/gpio_keys.c
> >> @@ -147,6 +147,7 @@ static int __devinit gpio_keys_probe(struct pl=
atform_device *pdev)
> >>  		}
> >> =20
> >>  		error =3D request_irq(irq, gpio_keys_isr,
> >> +				    IRQF_SHARED |
> >>  				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> >>  				    button->desc ? button->desc : "gpio_keys",
> >>  				    bdata);
> >
> > How will you determine which device generated the interrupt? Becaus=
e you
> > can't return IRQ_HANDLED unconditionally and expect both devices wo=
rk
> > reliably.
>=20
> It would be possible, but commit
> da0d03fe6cecde837f113a8a587f5a872d0fade0 states that:
>=20
>     The gpio_get_value function may sleep, so it should not be called=
 in a
>     timer function.
>=20
> But I don't see why it could sleep, is that really the case?

There are things like i2c gpio extenders that require access to slow
buses and can't sleep.

>  Because
> that makes acknowledging the interrupt very hard.  Actually, I need
> and tested interrupt sharing.  What are the "cansleep wrappers" in
> asm-generic/gpio.h if these function can sleep as well?  I'd be
> grateful for some explanation.  Also, commit
> 57ffe9d539e0eb741bb9ca8f2834d210e70ee2e3 removed the possibility of
> telling apart different keys, so that should be reverted during the
> process.  I already asked Uwe Kleine-K=F6nig about the whys, but didn=
't
> get a reply.

I don't see why you say that... You request IRQ per button and you get
that button structure as argument in the interrupt handler.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
