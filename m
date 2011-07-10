From: Philippe =?iso-8859-1?q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH 3/3] mc13xxx: implicitly enable leds and buttons
Date: Sun, 10 Jul 2011 13:33:09 +0200
Message-ID: <201107101333.10309.philippe.retornaz@epfl.ch>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch> <1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch> <20110710080450.GW29624@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.219]:41014 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755141Ab1GJLdR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jul 2011 07:33:17 -0400
In-Reply-To: <20110710080450.GW29624@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com

Le dimanche 10 juillet 2011 10:04:50, Uwe Kleine-K=F6nig a =E9crit :
> Hello,
>=20
> On Sun, Jul 10, 2011 at 01:06:36AM +0200, Philippe R=E9tornaz wrote:
> > The leds and buttons subdevices cannot be used without additional
> > platform data.
> >=20
> > Use the presence of the platform data to enable the device instead
> > of an additional flag.
>=20
> I guess you could make some people happy by splitting this patch into=
:
>=20
> 	- mfd/mc13xxx: implicitly enable leds and buttons (and
> 	  regulators?)
> 	- drop MC13XXX_USE_... in arch code

But this mean that between the two commit the build will be broken or t=
he=20
behavior will change.  Which will break bissections.

=46or the regulator stuff, I don't want to change the behavior of other=
s board as=20
some (mx31lite) enable the regualtor without platform data. That's why =
I did=20
not changed it.=20
Moreover for the mc13892 chip (which share the same flag), the probe() =
does=20
modify some registers, so it's not just some cosmetic change, it will c=
hange=20
the behavior on some boards.

BTW I will be on holydays next week so I won't be able to produce new p=
atches=20
soon.

Thanks,

Philippe
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
