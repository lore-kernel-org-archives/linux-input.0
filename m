From: Philippe =?iso-8859-1?q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH 1/2] mc13783: add power button support
Date: Fri, 8 Jul 2011 16:45:00 +0200
Message-ID: <201107081645.00724.philippe.retornaz@epfl.ch>
References: <1310135037-24289-1-git-send-email-philippe.retornaz@epfl.ch> <1310135037-24289-2-git-send-email-philippe.retornaz@epfl.ch> <20110708143032.GT29624@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.epfl.ch ([128.178.224.226]:41199 "HELO smtp3.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753213Ab1GHOpF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2011 10:45:05 -0400
In-Reply-To: <20110708143032.GT29624@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com

Hi

> > +config INPUT_MC13783_ON
> > +	tristate "MC13783 ON buttons"
> > +	depends on MFD_MC13783
> > +	help
> > +	  Support the ON buttons of MC13783 PMIC as an input device
> > +	  reporting power button status.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called mc13783-pwrbutton.
>=20
> Why not use INPUT_MC13783_PWRBUTTON to match the source file (and so
> module) name.

Ok.

>=20
> > +
> > +
>=20
> one empty line should be enough

Ok.

> > diff --git a/drivers/input/misc/mc13783-pwrbutton.c
> > b/drivers/input/misc/mc13783-pwrbutton.c new file mode 100644
> > index 0000000..6aee01c
> > --- /dev/null
> > +++ b/drivers/input/misc/mc13783-pwrbutton.c
> > @@ -0,0 +1,288 @@
> > +/**
> > + * mc13783-pwrbutton.c - MC13783 Power Button Input Driver
> > + *
> > + * Copyright (C) 2011 Philippe R=E9tornaz
> > + *
> > + * Based on twl4030-pwrbutton driver by:
> > + *     Peter De Schrijver <peter.de-schrijver@nokia.com>
> > + *     Felipe Balbi <felipe.balbi@nokia.com>
> > + *
> > + * This file is subject to the terms and conditions of the GNU Gen=
eral
> > + * Public License. See the file "COPYING" in the main directory of=
 this
> > + * archive for more details.
>=20
> This implies GPL v2 only? So you either need to clearify here or you
> need to adapt the MODULE_LICENSE line below to read
>=20
> 	MODULE_LICENSE("GPL v2");

Well, I took exactly the same license than the twl4030-pwrbutton.=20
This driver is: MODULE_LICENSE("GPL"), why should I change it ?

> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public Licen=
se
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111=
-1307=20
> > USA
>=20
> This is not the recent address of the FSF.

Ok, will update to 51 Franklin Street, Suite 500, Boston, MA 02110-1335


> > --- a/drivers/mfd/mc13xxx-core.c
> > +++ b/drivers/mfd/mc13xxx-core.c
> >=20
> > @@ -778,6 +778,10 @@ err_revision:
> >  		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
> >  	=09
> >  				pdata->leds, sizeof(*pdata->leds));
> >=20
> > +	if (pdata->flags & MC13XXX_USE_BUTTON)
>=20
> Why not use
>=20
> 	if (pdata->buttons)
>=20
> to detect if the pwrbutton device should be registered?

To keep consistancy as the others sub-device are registered the same wa=
y=20
(regulator, led). I can do it as you propose for the button but IMHO it=
's a=20
bit strange to have a MC13XXX_USE_* for all the subdevice except the bu=
ttons.=20
So should I change ?

Thanks for the review !=20

Philippe

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
