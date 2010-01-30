From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
Date: Sat, 30 Jan 2010 12:56:53 +0100
Message-ID: <20100130115653.GA12444@pengutronix.de>
References: <1264799926.2975.3.camel@realization> <20100129213727.GB21364@pengutronix.de> <1264850841.2587.0.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39585 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab0A3L44 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jan 2010 06:56:56 -0500
Content-Disposition: inline
In-Reply-To: <1264850841.2587.0.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, H Hartley Sweeten <hartleys@visionengravers.com>, linux-input <linux-input@vger.kernel.org>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>

On Sat, Jan 30, 2010 at 12:27:21PM +0100, Alberto Panizzo wrote:
> On ven, 2010-01-29 at 22:37 +0100, Uwe Kleine-K=F6nig wrote:
> > > [...]
> > > +MODULE_LICENSE("GPL v2");
> > There is no space expected in the string passed to MODULE_LICENSE.=20
>=20
> in include/linux/module.h:
>=20
> /*
>  * The following license idents are currently accepted as indicating =
free
>  * software modules
>  *
>  *	"GPL"				[GNU Public License v2 or later]
>  *	"GPL v2"			[GNU Public License v2]
> ...
Hmmmm, then sorry.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
