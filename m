From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv4][ 1/4] Input: tsc2007: Add device tree support.
Date: Tue, 22 Oct 2013 15:35:05 -0700
Message-ID: <20131022223504.GA19819@core.coreip.homeip.net>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
 <20131021155927.GB4255@core.coreip.homeip.net>
 <20131022114947.30dc9c07@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:53578 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127Ab3JVWfJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Oct 2013 18:35:09 -0400
Content-Disposition: inline
In-Reply-To: <20131022114947.30dc9c07@ipc1.ka-ro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Denis Carikli <denis@eukrea.com>, linux-input@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org

On Tue, Oct 22, 2013 at 11:49:47AM +0200, Lothar Wa=DFmann wrote:
> Hi,
>=20
> > On Mon, Oct 21, 2013 at 03:54:24PM +0200, Denis Carikli wrote:
> > > =20
> > > +	if (ts->of)
> > > +		return tsc2007_get_pendown_state_dt(ts);
> > > +
> > >  	if (!ts->get_pendown_state)
> > >  		return true;
> >=20
> > Instead of special casing "if (ts->of)" all over the place why don'=
t you
> > set up the device structure as:
> >=20
> > 	if (<configuring_tsc2007_form_dt>)
> > 		ts->get_pendown_state =3D tsc2007_get_pendown_state_dt;
> >=20
> > and be done with it?
> >
> I also thought about that, but the existing function does not have an=
y
> parameters, while the DT version of get_pendown_state() requires to g=
et
> the GPIO passed to it somehow.

You can always have tsc2007_get_pendown_state_platform() wrapping the
call. Or we just go and fix board code.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
