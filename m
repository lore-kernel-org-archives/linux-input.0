From: Philippe =?utf-8?q?R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH 5/6] mc13783: add power button support
Date: Fri, 22 Jul 2011 15:21:27 +0200
Message-ID: <201107221521.27625.philippe.retornaz@epfl.ch>
References: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch> <1311271463-4356-6-git-send-email-philippe.retornaz@epfl.ch> <4E28CD3F.5010006@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.219]:41590 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754262Ab1GVNVc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 09:21:32 -0400
In-Reply-To: <4E28CD3F.5010006@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de

Le vendredi 22 juillet 2011 03:07:11, Wanlong Gao a =C3=A9crit :
> On 07/22/2011 02:04 AM, Philippe R=C3=A9tornaz wrote:
> > This adds support for the power-on buttons of MC13783 PMIC.
> > This is done using a misc input device.
> >=20
> > Signed-off-by: Philippe R=C3=A9tornaz<philippe.retornaz@epfl.ch>
> > ---
> >=20
> >   drivers/input/misc/Kconfig             |   10 +
> >   drivers/input/misc/Makefile            |    1 +
> >   drivers/input/misc/mc13783-pwrbutton.c |  288
> >   ++++++++++++++++++++++++++++++++ drivers/mfd/mc13xxx-core.c      =
    =20
> >    |    4 +
> >   include/linux/mfd/mc13783.h            |    1 +
> >   include/linux/mfd/mc13xxx.h            |   17 ++
> >   6 files changed, 321 insertions(+), 0 deletions(-)
> >   create mode 100644 drivers/input/misc/mc13783-pwrbutton.c
> >=20
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfi=
g
> > index 45dc6aa..4272658 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -100,6 +100,16 @@ config INPUT_MAX8925_ONKEY
> >=20
> >   	  To compile this driver as a module, choose M here: the module
> >   	  will be called max8925_onkey.
> >=20
> > +struct mc13783_pwrb {
> > +	struct input_dev *pwr;
> > +	struct mc13xxx *mc13783;
> > +#define MC13783_PWRB_B1_POL_INVERT	(1<<  0)
> > +#define MC13783_PWRB_B2_POL_INVERT	(1<<  1)
> > +#define MC13783_PWRB_B3_POL_INVERT	(1<<  2)
> > +	int flags;
> > +	unsigned short keymap[3];
>=20
> It seems like you just use the keymap[0]?

No, keymap[0] is for button 0, keymap[1] if for button 1 and keymap[2] =
is for=20
button 3. The _probe() function wrongly initialized the two last button=
=2E I=20
will fix this in the next patch.

Thanks for spotting this.

Regards,

Philippe

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
