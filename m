From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 0/3] Input: rotary-encoder - use more than two gpios
Date: Tue, 2 Feb 2016 13:56:02 +0100
Message-ID: <20160202125602.GW13664@pengutronix.de>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <56B09C27.8070009@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48634 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754466AbcBBM4N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2016 07:56:13 -0500
Content-Disposition: inline
In-Reply-To: <56B09C27.8070009@zonque.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Hello Daniel,

On Tue, Feb 02, 2016 at 01:08:07PM +0100, Daniel Mack wrote:
> On 02/02/2016 11:24 AM, Uwe Kleine-K=F6nig wrote:
> > Some time ago I sent a v1 of this, now after testing the changes mo=
re
> > deeply patch 3 changed a bit. The old series started with
> >=20
> > 	Date: Wed,  2 Dec 2015 11:07:11 +0100
> > 	From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > 	Subject: [PATCH RFC 0/3] input: rotary_encoder: use more than two =
gpios as input
> > 	Message-Id: <1449050834-31779-1-git-send-email-u.kleine-koenig@pen=
gutronix.de>
> >=20
> > The two first patches are just preparation for the third patch.
> >=20
> > There is an obvious improvement that allows detection of quick chan=
ges
> > more reliably with >2 gpios, but I didn't implement this yet. (With=
 4
> > GPIOs you can distinguish a counter clockwise movement of three sta=
tes
> > from a clock wise movement of a single state. Still the patch is us=
eful
> > as it makes these devices work at all.
> >=20
> > My test device looks as follows:
> >=20
> >         rotary@0 {
> >                 compatible =3D "rotary-encoder";
> >                 gpios =3D <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 11 =
GPIO_ACTIVE_HIGH>, <&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIVE_=
HIGH>;
> >=20
> >                 rotary-encoder,steps =3D <16>;
> > 		rotary-encoder,steps-per-period =3D <16>;
> >         };
> >=20
> > While Daniel Mack and Rojhalat Ibrahim agreed that this device is a=
n
> > absolute encoder and should be supported by a simpler logic, I stil=
l
> > consider it worthwhile to get these patches in as a first step. Als=
o the
> > binding looks right, so IMHO the comments shouldn't stop this serie=
s
> > from going in.
>=20
> I still don't understand why this is implemented that way, rather tha=
n
> going for a much simpler logic of interpretation that also allows use=
rs
> to read out the absolute position.
>=20
> The code to read the value would be really just as simple as reading =
all
> GPIOs and or-ing their values into the result, and skip the state
> machine completely. This code would be active if a new attribute
> (something like 'rotary-encoder,hardware-absolute') is set, or even
> implicitly, when more than 2 GPIOs are specified.
>=20
> Is there any reason for not doing that?

Currently the reason is lack of time. And when implementing
rotary-encoder,hardware-absolute something similar would be the result
for the relative reporting anyhow. So the problem is only that I don't
have absolute support yet, but the patches as is would be the base for
that anyhow.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
