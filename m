From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH] Input: ad7879: support auxiliary
 GPIOs via gpiolib
Date: Thu, 7 Jan 2010 09:07:08 -0800
Message-ID: <20100107170707.GA3439@core.coreip.homeip.net>
References: <1262848702-24968-1-git-send-email-vapier@gentoo.org>
 <20100107073114.GC2314@core.coreip.homeip.net>
 <201001071116.19616.rgetz@blackfin.uclinux.org>
 <8bd0f97a1001070846s26a98899sbb9c6caaffd57c68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:35897 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab0AGRHR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 12:07:17 -0500
Received: by pzk1 with SMTP id 1so3070676pzk.33
        for <linux-input@vger.kernel.org>; Thu, 07 Jan 2010 09:07:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a1001070846s26a98899sbb9c6caaffd57c68@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>, uclinux-dist-devel@blackfin.uclinux.org, "Hennerich, Michael" <Michael.Hennerich@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Jan 07, 2010 at 11:46:15AM -0500, Mike Frysinger wrote:
> On Thu, Jan 7, 2010 at 11:16, Robin Getz wrote:
> > On Thu 7 Jan 2010 02:31, Dmitry Torokhov pondered:
> >> On Thu, Jan 07, 2010 at 02:18:22AM -0500, Mike Frysinger wrote:
> >> > From: Michael Hennerich <michael.hennerich@analog.com>
> >> >
> >> > Drop the simple fancy sysfs hooks for the aux GPIOs and expose t=
hese via
> >> > the gpiolib interface so that other drivers can use them.
> >>
> >> Would not that mess up current users (if any) that may rely on the
> >> existing sysfs attributes?
> >
> > We have talked =A0to the existing users of this (that we know of), =
and they
> > agreed that doing things the "standard" way with gpiolib is the bet=
ter way to
> > move forward on things.
>=20
> there is a standard sysfs interface for accessing gpios already too
> which this change allows people to utilize

Using (and providing) standard interfaces are laudible goal, however
that does not mean we can screw existing users over. Now Robin sais tha=
t
you talked to users (at least some) and this being an embedded platform
taht might be OK but generally sysfs is userspace interface and thus ar=
e
not to be changed lightly, only extended.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
