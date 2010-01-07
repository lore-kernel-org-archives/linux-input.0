From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [Uclinux-dist-devel] [PATCH] Input: ad7879: support auxiliary GPIOs via gpiolib
Date: Thu, 7 Jan 2010 12:43:41 -0500
Message-ID: <201001071243.41191.rgetz@blackfin.uclinux.org>
References: <1262848702-24968-1-git-send-email-vapier@gentoo.org> <8bd0f97a1001070846s26a98899sbb9c6caaffd57c68@mail.gmail.com> <20100107170707.GA3439@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:21507 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab0AGRnn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 12:43:43 -0500
In-Reply-To: <20100107170707.GA3439@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier.adi@gmail.com>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu 7 Jan 2010 12:07, Dmitry Torokhov pondered:
> On Thu, Jan 07, 2010 at 11:46:15AM -0500, Mike Frysinger wrote:
> > On Thu, Jan 7, 2010 at 11:16, Robin Getz wrote:
> > > On Thu 7 Jan 2010 02:31, Dmitry Torokhov pondered:
> > >> On Thu, Jan 07, 2010 at 02:18:22AM -0500, Mike Frysinger wrote:
> > >> > From: Michael Hennerich <michael.hennerich@analog.com>
> > >> >
> > >> > Drop the simple fancy sysfs hooks for the aux GPIOs and expose=
 these=20
via
> > >> > the gpiolib interface so that other drivers can use them.
> > >>
> > >> Would not that mess up current users (if any) that may rely on t=
he
> > >> existing sysfs attributes?
> > >
> > > We have talked =A0to the existing users of this (that we know of)=
, and=20
they
> > > agreed that doing things the "standard" way with gpiolib is the b=
etter=20
way to
> > > move forward on things.
> >=20
> > there is a standard sysfs interface for accessing gpios already too
> > which this change allows people to utilize
>=20
> Using (and providing) standard interfaces are laudible goal, however
> that does not mean we can screw existing users over. Now Robin sais t=
hat
> you talked to users (at least some) and this being an embedded platfo=
rm
> taht might be OK but generally sysfs is userspace interface and thus =
are
> not to be changed lightly, only extended.

I agree - but in this case - the driver in question has only been in ma=
inline=20
a few kernel versions (since March'09).

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
history;f=3Ddrivers/input/touchscreen/ad7879.c;hb=3DHEAD

And the only feedback we have gotten was to make this change - so peopl=
e could=20
use the gpio in other drivers more than requests about userspace...

-Robin

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
