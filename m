From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH] Input: ad7879: support auxiliary
 GPIOs via gpiolib
Date: Sat, 9 Jan 2010 23:48:27 -0800
Message-ID: <20100110074826.GA16057@core.coreip.homeip.net>
References: <1262848702-24968-1-git-send-email-vapier@gentoo.org>
 <8bd0f97a1001070846s26a98899sbb9c6caaffd57c68@mail.gmail.com>
 <20100107170707.GA3439@core.coreip.homeip.net>
 <201001071243.41191.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:37563 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab0AJHsc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jan 2010 02:48:32 -0500
Received: by pzk26 with SMTP id 26so11613199pzk.4
        for <linux-input@vger.kernel.org>; Sat, 09 Jan 2010 23:48:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201001071243.41191.rgetz@blackfin.uclinux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: Mike Frysinger <vapier.adi@gmail.com>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Jan 07, 2010 at 12:43:41PM -0500, Robin Getz wrote:
> On Thu 7 Jan 2010 12:07, Dmitry Torokhov pondered:
> > On Thu, Jan 07, 2010 at 11:46:15AM -0500, Mike Frysinger wrote:
> > > On Thu, Jan 7, 2010 at 11:16, Robin Getz wrote:
> > > > On Thu 7 Jan 2010 02:31, Dmitry Torokhov pondered:
> > > >> On Thu, Jan 07, 2010 at 02:18:22AM -0500, Mike Frysinger wrote=
:
> > > >> > From: Michael Hennerich <michael.hennerich@analog.com>
> > > >> >
> > > >> > Drop the simple fancy sysfs hooks for the aux GPIOs and expo=
se these=20
> via
> > > >> > the gpiolib interface so that other drivers can use them.
> > > >>
> > > >> Would not that mess up current users (if any) that may rely on=
 the
> > > >> existing sysfs attributes?
> > > >
> > > > We have talked =A0to the existing users of this (that we know o=
f), and=20
> they
> > > > agreed that doing things the "standard" way with gpiolib is the=
 better=20
> way to
> > > > move forward on things.
> > >=20
> > > there is a standard sysfs interface for accessing gpios already t=
oo
> > > which this change allows people to utilize
> >=20
> > Using (and providing) standard interfaces are laudible goal, howeve=
r
> > that does not mean we can screw existing users over. Now Robin sais=
 that
> > you talked to users (at least some) and this being an embedded plat=
form
> > taht might be OK but generally sysfs is userspace interface and thu=
s are
> > not to be changed lightly, only extended.
>=20
> I agree - but in this case - the driver in question has only been in =
mainline=20
> a few kernel versions (since March'09).
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
history;f=3Ddrivers/input/touchscreen/ad7879.c;hb=3DHEAD
>=20
> And the only feedback we have gotten was to make this change - so peo=
ple could=20
> use the gpio in other drivers more than requests about userspace...
>=20

OK, fair enough. ANd to limit exposure we probably want to get it into
=2E33... So is there an updated version of the patch coming (addressing
missing gpiochip_remove)?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
