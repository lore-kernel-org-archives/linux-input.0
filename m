From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv4][ 1/4] Input: tsc2007: Add device tree support.
Date: Wed, 23 Oct 2013 00:53:06 -0700
Message-ID: <20131023075306.GA18188@core.coreip.homeip.net>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
 <20131021155927.GB4255@core.coreip.homeip.net>
 <20131022114947.30dc9c07@ipc1.ka-ro>
 <20131022223504.GA19819@core.coreip.homeip.net>
 <20131023092553.6989a592@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:39609 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab3JWHxK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Oct 2013 03:53:10 -0400
Content-Disposition: inline
In-Reply-To: <20131023092553.6989a592@ipc1.ka-ro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <rob.herring@calxeda.com>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Oct 23, 2013 at 09:25:53AM +0200, Lothar Wa=DFmann wrote:
> Hi,
>=20
> > On Tue, Oct 22, 2013 at 11:49:47AM +0200, Lothar Wa=DFmann wrote:
> > > Hi,
> > >=20
> > > > On Mon, Oct 21, 2013 at 03:54:24PM +0200, Denis Carikli wrote:
> > > > > =20
> > > > > +	if (ts->of)
> > > > > +		return tsc2007_get_pendown_state_dt(ts);
> > > > > +
> > > > >  	if (!ts->get_pendown_state)
> > > > >  		return true;
> > > >=20
> > > > Instead of special casing "if (ts->of)" all over the place why =
don't you
> > > > set up the device structure as:
> > > >=20
> > > > 	if (<configuring_tsc2007_form_dt>)
> > > > 		ts->get_pendown_state =3D tsc2007_get_pendown_state_dt;
> > > >=20
> > > > and be done with it?
> > > >
> > > I also thought about that, but the existing function does not hav=
e any
> > > parameters, while the DT version of get_pendown_state() requires =
to get
> > > the GPIO passed to it somehow.
> >=20
> > You can always have tsc2007_get_pendown_state_platform() wrapping t=
he
> >
> Yes, but how would you pass the GPIO number to the
> get_pendown_state_dt() function? Global variables are just ugly.

You'd have

	get_pendown_state_dt(struct tsc *)
	get_pendown_state_platform(struct tsc *)
	{
		return ts->get_platform_pendown_state();
	}

and youd'd have

struct tsc {
	...
	bool (*get_pendown_state)(struct tsc);
	bool (*get_platform_pendown_state)(void);

>=20
> > call. Or we just go and fix board code.
> >
> That's IMO a better option, but not easy to achieve without breaking
> anything. The in-kernel platforms would be easy to fix, but there may=
 be
> external users that still use the old hook, so you can't just remove =
it
> or change its semantics.

Sure can - they are out of tree after all.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
