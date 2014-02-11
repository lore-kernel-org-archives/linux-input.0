From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] input: mc13783: Make mc13xxx_buttons_platform_data
 more flexible
Date: Tue, 11 Feb 2014 09:17:35 +0000
Message-ID: <20140211091735.GF32042@lee--X1>
References: <1392006129-10227-1-git-send-email-shc_work@mail.ru>
 <20140210112917.GD21522@lee--X1>
 <1392101218.989322000@f169.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:55527 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaBKJRl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Feb 2014 04:17:41 -0500
Received: by mail-we0-f178.google.com with SMTP id q59so5150450wes.23
        for <linux-input@vger.kernel.org>; Tue, 11 Feb 2014 01:17:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392101218.989322000@f169.i.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>

> > > Instead of define each button in separate variable, make an array
> > > for storing all buttons. This change will help to add support for
> > > other types of PMIC and add support for probing with devicetree
> > > in the future.
> > >=20
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  arch/arm/mach-imx/mach-mx31moboard.c   |  9 ++++--
> > >  drivers/input/misc/mc13783-pwrbutton.c | 56
> > +++++++++++++++++-----------------
> > >  include/linux/mfd/mc13xxx.h            | 28 +++++++++--------
> >=20
> > Are all the changes in these files entangled? If there is any way t=
o
> > make them orthogonal, then all the better.
>=20
> Can you say the same thing in other words, I didn't understand a bit
> of your comment.

Do all of this changes in each of the files listed above depend on
each other?

> ...
> > > +struct mc13xxx_button {
> > > +	u16		keycode;
> > > +	unsigned int	flags;
> > > +#define MC13XXX_BUTTON_DBNC_0MS		0
> > > +#define MC13XXX_BUTTON_DBNC_30MS	1
> > > +#define MC13XXX_BUTTON_DBNC_150MS	2
> > > +#define MC13XXX_BUTTON_DBNC_750MS	3
> > > +#define MC13XXX_BUTTON_ENABLE		(1 << 2)
> > > +#define MC13XXX_BUTTON_POL_INVERT	(1 << 3)
> > > +#define MC13XXX_BUTTON_RESET_EN		(1 << 4)
> > > +};
> > > +
> >=20
> > Please take the opportunity to remove this slab list of #defines fr=
om
> > the centre of the struct definition. Just above will be fine.
>=20
> I would like to make it in a separate patch for the whole header file=
 later.

You may as well do it in this commit?  Just add them outside of the
struct definition instead of inside.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
