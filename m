From: Rojhalat Ibrahim <imr@rtschenk.de>
Subject: Re: [PATCH RFC 0/3] input: rotary_encoder: use more than two gpios as input
Date: Wed, 02 Dec 2015 13:52:58 +0100
Message-ID: <2266988.l83Fg404My@pcimr>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:42763 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467AbbLBMxH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2015 07:53:07 -0500
In-Reply-To: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Guido =?ISO-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org

On Wednesday 02 December 2015 11:07:11 Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> some time ago I worked on the rotary encoder driver to make it suppor=
t
> more than two input lines. This is the (only slightly tested[1]) reba=
se of
> this series on top of 4.4-rc2 (from 4.1).
>=20
> It would be great to get some feedback, especially (but not only) for=
 my
> change to raumfeld.c.
>=20
> Before Ezequiel's patch 3a341a4c30d4 ("Input: rotary-encoder - add
> support for quarter-period mode") we had a dt property
> "rotary-encoder,half-period" defined. It's presence meant that we had=
 2
> indents per period; it's absence that there is only 1. Ezequiel
> introduced rotary-encoder,steps-per-period instead when adding suppor=
t
> for quarter-period mode (which has 4 indents per period).
>=20
> Up to now (i.e. with two inputs) a period has length 4. Now with (say=
)
> four inputs a period has length 16 instead. Now how should this be
> modeled in dt? This series implements that I have to pass
>=20
> 	rotary-encoder,steps-per-period =3D <16>;
>=20
> now for "quarter-period mode" (i.e. 4 indents per 4 state changes[2])=
,
> but that feels unnatural. I'd prefer to set a property to <1> instead=
,
> meaning the device has an indent for each state change[2]. half-perio=
d
> mode would be <2> and full-period mode would be <4>. But I don't have=
 a
> nice name for such a property and maybe it's easier to live with
> steps-per-period =3D <16>? What do you think?
>=20
> Also note that these patches are not as technically versatile as
> possible. With 4 (n) input lines we could detect a quick rotation whe=
re the
> machine's latency only allows to sample after 7 (2^(n-1)-1) state
> changes. Currently this is not implemented, but can be done later.
>=20
> Best regards
> Uwe
>=20

AFAIUI the rotary encoder driver only handles incremental encoders not
absolute encoders. (So in fact the assumed rotary encoder could also be=
 a
linear encoder with an incremental interface.) Those encoders almost al=
ways
have an interface with two outputs (A, B) with a phase shift of 90 degr=
ees
between them. So in this case we have 4 steps per period. Sometimes the=
re
is only one line for 1 or 2 steps per period. But I have never seen or
heard of a device with more than 2 lines (except for the third output w=
hich
serves as a reference position index marker).

Do devices wirh more than two outputs actually exist?
Or is the purpose of supporting more than 2 lines something other than
connecting an actual encoder to them?

   Rojhalat

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
