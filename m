From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] mc13xxx: implicitly enable leds and buttons
Date: Sun, 10 Jul 2011 16:15:00 +0200
Message-ID: <20110710141500.GX29624@pengutronix.de>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
 <1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
 <20110710080450.GW29624@pengutronix.de>
 <201107101333.10309.philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46513 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab1GJOPH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jul 2011 10:15:07 -0400
Content-Disposition: inline
In-Reply-To: <201107101333.10309.philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com

Hello Philippe,

On Sun, Jul 10, 2011 at 01:33:09PM +0200, Philippe R=E9tornaz wrote:
> Le dimanche 10 juillet 2011 10:04:50, Uwe Kleine-K=F6nig a =E9crit :
> > Hello,
> >=20
> > On Sun, Jul 10, 2011 at 01:06:36AM +0200, Philippe R=E9tornaz wrote=
:
> > > The leds and buttons subdevices cannot be used without additional
> > > platform data.
> > >=20
> > > Use the presence of the platform data to enable the device instea=
d
> > > of an additional flag.
> >=20
> > I guess you could make some people happy by splitting this patch in=
to:
> >=20
> > 	- mfd/mc13xxx: implicitly enable leds and buttons (and
> > 	  regulators?)
> > 	- drop MC13XXX_USE_... in arch code
>=20
> But this mean that between the two commit the build will be broken or=
 the=20
> behavior will change.  Which will break bissections.
If you don't remove the MC13XXX_USE_... constants the unconverted board=
s
should still compile.
>=20
> For the regulator stuff, I don't want to change the behavior of other=
s
> board as some (mx31lite) enable the regualtor without platform data.
> That's why I did not changed it.=20
If having pdata=3DNULL is a valid config then either we need to keep th=
e
constant for regulators or (as Mark suggested) register unconditionally=
=2E

> Moreover for the mc13892 chip (which share the same flag), the probe(=
) does=20
> modify some registers, so it's not just some cosmetic change, it will=
 change=20
> the behavior on some boards.
no fear, that's what the -rc phase is there for. When improving
something you often have to change behaviour.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
