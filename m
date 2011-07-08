From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] mc13783: add power button support
Date: Fri, 8 Jul 2011 17:25:29 +0200
Message-ID: <20110708152529.GV29624@pengutronix.de>
References: <1310135037-24289-1-git-send-email-philippe.retornaz@epfl.ch>
 <1310135037-24289-2-git-send-email-philippe.retornaz@epfl.ch>
 <20110708143032.GT29624@pengutronix.de>
 <201107081645.00724.philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33126 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab1GHPZg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2011 11:25:36 -0400
Content-Disposition: inline
In-Reply-To: <201107081645.00724.philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com

Hello Philippe,

On Fri, Jul 08, 2011 at 04:45:00PM +0200, Philippe R=E9tornaz wrote:
> > > +config INPUT_MC13783_ON
> > > +	tristate "MC13783 ON buttons"
> > > +	depends on MFD_MC13783
> > > +	help
> > > +	  Support the ON buttons of MC13783 PMIC as an input device
> > > +	  reporting power button status.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called mc13783-pwrbutton.
> >=20
> > Why not use INPUT_MC13783_PWRBUTTON to match the source file (and s=
o
> > module) name.
>=20
> Ok.
>=20
> >=20
> > > +
> > > +
> >=20
> > one empty line should be enough
>=20
> Ok.
>=20
> > > diff --git a/drivers/input/misc/mc13783-pwrbutton.c
> > > b/drivers/input/misc/mc13783-pwrbutton.c new file mode 100644
> > > index 0000000..6aee01c
> > > --- /dev/null
> > > +++ b/drivers/input/misc/mc13783-pwrbutton.c
> > > @@ -0,0 +1,288 @@
> > > +/**
> > > + * mc13783-pwrbutton.c - MC13783 Power Button Input Driver
> > > + *
> > > + * Copyright (C) 2011 Philippe R=E9tornaz
> > > + *
> > > + * Based on twl4030-pwrbutton driver by:
> > > + *     Peter De Schrijver <peter.de-schrijver@nokia.com>
> > > + *     Felipe Balbi <felipe.balbi@nokia.com>
> > > + *
> > > + * This file is subject to the terms and conditions of the GNU G=
eneral
> > > + * Public License. See the file "COPYING" in the main directory =
of this
> > > + * archive for more details.
> >=20
> > This implies GPL v2 only? So you either need to clearify here or yo=
u
> > need to adapt the MODULE_LICENSE line below to read
> >=20
> > 	MODULE_LICENSE("GPL v2");
>=20
> Well, I took exactly the same license than the twl4030-pwrbutton.=20
> This driver is: MODULE_LICENSE("GPL"), why should I change it ?
So this driver is wrong, too. According to include/linux/module.h, "GPL=
"
means "GNU Public License v2 or later" and "GPL v2" means "GNU Public
License v2".

> > > --- a/drivers/mfd/mc13xxx-core.c
> > > +++ b/drivers/mfd/mc13xxx-core.c
> > >=20
> > > @@ -778,6 +778,10 @@ err_revision:
> > >  		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
> > >  	=09
> > >  				pdata->leds, sizeof(*pdata->leds));
> > >=20
> > > +	if (pdata->flags & MC13XXX_USE_BUTTON)
> >=20
> > Why not use
> >=20
> > 	if (pdata->buttons)
> >=20
> > to detect if the pwrbutton device should be registered?
>=20
> To keep consistancy as the others sub-device are registered the same =
way=20
> (regulator, led). I can do it as you propose for the button but IMHO =
it's a=20
> bit strange to have a MC13XXX_USE_* for all the subdevice except the =
buttons.=20
> So should I change ?
It would be a third patch for your commit count to convert regulator an=
d
led, too ;-)

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
