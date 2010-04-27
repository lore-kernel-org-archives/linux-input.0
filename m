From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] hid: add PM support to PicoLCD device
Date: Tue, 27 Apr 2010 22:57:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004272256160.9849@pobox.suse.cz>
References: <20100425214003.7e87c6a3@neptune.home> <20100425214306.5d7be049@neptune.home> <alpine.LNX.2.00.1004271525330.9849@pobox.suse.cz> <20100427221648.39735c41@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38911 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885Ab0D0U5O (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Apr 2010 16:57:14 -0400
In-Reply-To: <20100427221648.39735c41@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Oliver Neukum <oliver@neukum.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Nicu Pavel <npavel@ituner.com>, Jaya Kumar <jayakumar.lkml@gmail.com>, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>

On Tue, 27 Apr 2010, Bruno Pr=C3=A9mont wrote:

> > > +#ifdef CONFIG_PM
> > > +static void picolcd_suspend_backlight(struct picolcd_data *data)
> > > +{
> > > +	int bl_power =3D data->lcd_power;
> > > +	if (!data->backlight)
> > > +		return;
> > > +
> > > +	data->backlight->props.power =3D FB_BLANK_POWERDOWN;
> > > +	picolcd_set_brightness(data->backlight);
> > > +	data->lcd_power =3D data->backlight->props.power =3D bl_power;
> > > +}
> > > +#else
> > > +#define picolcd_suspend_backlight(a)
> > > +#endif /* CONFIG_PM */
> >=20
> > Stylistic thing -- it would be nice if this was actually=20
> >=20
> > static inline void picolcd_suspend_backlight(struct picolcd_data *d=
ata)
> > {
> > 	return 0;
> > }
> >=20
> > But why do you need to have it defined in !CONFIG_PM situation anyw=
ay?=20
> > It's not used otherwise at all.
>=20
> Yeah, I could drop the #else branch (of #ifconfig CONFIG_PM).

Yup, please do so.

> Is gcc quiet about defined but unused static inline functions?

Yup, -Wunused-function doesn't warn about unused static inline function=
=2E

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
