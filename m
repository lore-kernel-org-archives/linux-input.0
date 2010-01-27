From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v3] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Wed, 27 Jan 2010 13:18:00 +0100
Message-ID: <19296.12024.559688.606548@ipc1.ka-ro>
References: <1264586106.2463.23.camel@realization>
	<19296.5728.557535.920849@ipc1.ka-ro>
	<1264594452.2463.62.camel@realization>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:57036 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab0A0MSG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2010 07:18:06 -0500
In-Reply-To: <1264594452.2463.62.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, H Hartley Sweeten <hartleys@visionengravers.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,

Alberto Panizzo writes:
> > > +	irq =3D platform_get_irq(pdev, 0);
> > > +	if (irq < 0) {
> > > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > > +		return -ENXIO;
> > > +	}
> > >
> > This should be -ENODEV.
> >=20
> Lot of reference keyboard driver use -ENXIO..
> May should be better: return irq ?
>=20
Yes, of course. If a function returns an error code that should be
promoted to the caller instead of inventing a new error code.


Lothar Wa=DFmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
