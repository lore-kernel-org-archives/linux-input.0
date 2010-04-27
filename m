From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 2/2] hid: add PM support to PicoLCD device
Date: Tue, 27 Apr 2010 22:16:48 +0200
Message-ID: <20100427221648.39735c41@neptune.home>
References: <20100425214003.7e87c6a3@neptune.home>
	<20100425214306.5d7be049@neptune.home>
	<alpine.LNX.2.00.1004271525330.9849@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:50057 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab0D0URG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Apr 2010 16:17:06 -0400
In-Reply-To: <alpine.LNX.2.00.1004271525330.9849@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Oliver Neukum <oliver@neukum.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Nicu Pavel <npavel@ituner.com>, Jaya Kumar <jayakumar.lkml@gmail.com>, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>

On Tue, 27 April 2010 Jiri Kosina <jkosina@suse.cz> wrote:
> On Sun, 25 Apr 2010, Bruno Pr=C3=A9mont wrote:
>=20
> > Add PM support in order to turn off backlight on suspend, restore
> > it on resume and especially restore complete state on reset-resume.
> >=20
> > Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> > ---
> >  drivers/hid/hid-picolcd.c |   61 +++++++++++++++++++++++++++++++++=
++++++++++++
> >  1 files changed, 61 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
> > index aa6f2e1..c652390 100644
> > --- a/drivers/hid/hid-picolcd.c
> > +++ b/drivers/hid/hid-picolcd.c
> > @@ -852,6 +852,20 @@ static inline int picolcd_resume_backlight(str=
uct picolcd_data *data)
> >  	return picolcd_set_brightness(data->backlight);
> >  }
> > =20
> > +#ifdef CONFIG_PM
> > +static void picolcd_suspend_backlight(struct picolcd_data *data)
> > +{
> > +	int bl_power =3D data->lcd_power;
> > +	if (!data->backlight)
> > +		return;
> > +
> > +	data->backlight->props.power =3D FB_BLANK_POWERDOWN;
> > +	picolcd_set_brightness(data->backlight);
> > +	data->lcd_power =3D data->backlight->props.power =3D bl_power;
> > +}
> > +#else
> > +#define picolcd_suspend_backlight(a)
> > +#endif /* CONFIG_PM */
>=20
> Stylistic thing -- it would be nice if this was actually=20
>=20
> static inline void picolcd_suspend_backlight(struct picolcd_data *dat=
a)
> {
> 	return 0;
> }
>=20
> But why do you need to have it defined in !CONFIG_PM situation anyway=
?=20
> It's not used otherwise at all.

Yeah, I could drop the #else branch (of #ifconfig CONFIG_PM).

Is gcc quiet about defined but unused static inline functions?
It's in order to avoid those warnings that I used #define bla().
(same in other occasions of stubs returning void.

Might be I forgot the inline keyword for the case I got the warning
about defined but unused function. Will check tomorrow.

> >  #else
> >  static inline int picolcd_init_backlight(struct picolcd_data *data=
,
> >  		struct hid_report *report)
> > @@ -865,6 +879,7 @@ static inline int picolcd_resume_backlight(stru=
ct picolcd_data *data)
> >  {
> >  	return 0;
> >  }
> > +#define picolcd_suspend_backlight(a)
>=20
> Any why is it defined once more here?

Thats in the case where CONFIG_HID_PICOLCD_BACKLIGHT is not defined.
c.f. the #else at the beginning of this quote.


Thanks,
Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
