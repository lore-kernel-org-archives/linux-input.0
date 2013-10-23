From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv4][ 1/4] Input: tsc2007: Add device tree support.
Date: Wed, 23 Oct 2013 09:25:53 +0200
Message-ID: <20131023092553.6989a592@ipc1.ka-ro>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
	<20131021155927.GB4255@core.coreip.homeip.net>
	<20131022114947.30dc9c07@ipc1.ka-ro>
	<20131022223504.GA19819@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:49289 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab3JWH0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Oct 2013 03:26:04 -0400
In-Reply-To: <20131022223504.GA19819@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <rob.herring@calxeda.com>, Denis Carikli <denis@eukrea.com>, Eric =?UTF-8?B?QsOpbmFyZA==?= <eric@eukrea.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

> On Tue, Oct 22, 2013 at 11:49:47AM +0200, Lothar Wa=C3=9Fmann wrote:
> > Hi,
> >=20
> > > On Mon, Oct 21, 2013 at 03:54:24PM +0200, Denis Carikli wrote:
> > > > =20
> > > > +	if (ts->of)
> > > > +		return tsc2007_get_pendown_state_dt(ts);
> > > > +
> > > >  	if (!ts->get_pendown_state)
> > > >  		return true;
> > >=20
> > > Instead of special casing "if (ts->of)" all over the place why do=
n't you
> > > set up the device structure as:
> > >=20
> > > 	if (<configuring_tsc2007_form_dt>)
> > > 		ts->get_pendown_state =3D tsc2007_get_pendown_state_dt;
> > >=20
> > > and be done with it?
> > >
> > I also thought about that, but the existing function does not have =
any
> > parameters, while the DT version of get_pendown_state() requires to=
 get
> > the GPIO passed to it somehow.
>=20
> You can always have tsc2007_get_pendown_state_platform() wrapping the
>
Yes, but how would you pass the GPIO number to the
get_pendown_state_dt() function? Global variables are just ugly.

> call. Or we just go and fix board code.
>
That's IMO a better option, but not easy to achieve without breaking
anything. The in-kernel platforms would be easy to fix, but there may b=
e
external users that still use the old hook, so you can't just remove it
or change its semantics.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
