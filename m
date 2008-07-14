From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: [PATCH RESENT] [RFC] gpio-keys: let platform code specify the trigger type
Date: Mon, 14 Jul 2008 07:33:09 +0200
Message-ID: <20080714053309.GA26232@digi.com>
References: <1215070080-13755-1-git-send-email-Uwe.Kleine-Koenig@digi.com> <1215680324-32164-1-git-send-email-Uwe.Kleine-Koenig@digi.com> <20080710135426.GA3125@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail164.messagelabs.com ([216.82.253.131]:25458 "EHLO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbYGNFdQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2008 01:33:16 -0400
Content-Disposition: inline
In-Reply-To: <20080710135426.GA3125@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Kay Sievers <kay.sievers@vrfy.org>, David Brownell <dbrownell@users.sourceforge.net>, Herbert Valerio Riedel <hvr@gnu.org>

Hello Dmitry,

Dmitry Torokhov wrote:
> On Thu, Jul 10, 2008 at 10:58:44AM +0200, Uwe Kleine-K=F6nig wrote:
> > The intend for this change is that not all platform's irqs support
> > triggering on both edges.  Examples are ns9xxx[1] and txx9[2], and =
I
> > expect that there are more.
> >
> > Provided that the platform data is initialized with zeros there is =
no
> > change in behavior if the new struct member 'trigger' isn't set in
> > platform code.
> >
>=20
> OK, makes sense. Unfortunately the patch conflicts with debounce supp=
ort
> that is in 'next' branch of my tree so I can't apply it as is. Actual=
ly,
> with debounce support is may not even be needed in the present form.
So I will resend an updated version when the details are resolved.

> > open points:
> >  - if only one trigger direction is used it should match active_low=
 such
> >    that the button press generates the irq.
> >  - poll for button release instead of generate the release event
> >    directly after the press?
>=20
> Yes, I think that would be the best option.
OK.

> >  - is it correct to input_sync() between press and release event?
> Yes, button press and release are 2 distinct states of the device and=
 so
> it is prudent to have input_sync in between.
OK.
=20
> >  - sanitize button->trigger &=3D IRQF_TRIGGER_EDGE in gpio_keys_pro=
be
> >    before passing it to request_irq?
>=20
> Would be nice, together with WARN() in case it needed stanitizing.
OK.
=20
> >  - a comment describing the trigger member of struct gpio_keys_butt=
on
> >
> > I'd like to have polling support in this driver.  This could use
> > button->trigger =3D=3D 0, so it might be sensible to add a
> > WARN_ON(!button->trigger) for now and wait some time before impleme=
nting
> > it.
> >
>=20
> I am not sure if addin a pure polling mode to this driver is a best
> idea. Maybe writing a separate one based on input-polldev will allow
> keep them both simpler than combined one.
So you suggest to implement polling in gpio-keys only for button releas=
e
(if triggering for both doesn't work) and add a new driver that does
polling only?

I havn't looked deeply, but maybe it makes sense to export some
functions from drivers/input/input-polldev.c and use them as applicable
in the gpio-keys driver?

Thanks and best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
