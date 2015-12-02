From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RFC 0/3] input: rotary_encoder: use more than two gpios
 as input
Date: Wed, 2 Dec 2015 19:59:20 +0100
Message-ID: <20151202185920.GO5072@pengutronix.de>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <2266988.l83Fg404My@pcimr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39383 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757649AbbLBS7h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Dec 2015 13:59:37 -0500
Content-Disposition: inline
In-Reply-To: <2266988.l83Fg404My@pcimr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: linux-arm-kernel@lists.infradead.org, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org

Hello,

On Wed, Dec 02, 2015 at 01:52:58PM +0100, Rojhalat Ibrahim wrote:
> On Wednesday 02 December 2015 11:07:11 Uwe Kleine-K=F6nig wrote:
> > some time ago I worked on the rotary encoder driver to make it supp=
ort
> > more than two input lines. This is the (only slightly tested[1]) re=
base of
> > this series on top of 4.4-rc2 (from 4.1).
> >=20
> > It would be great to get some feedback, especially (but not only) f=
or my
> > change to raumfeld.c.
> >=20
> > Before Ezequiel's patch 3a341a4c30d4 ("Input: rotary-encoder - add
> > support for quarter-period mode") we had a dt property
> > "rotary-encoder,half-period" defined. It's presence meant that we h=
ad 2
> > indents per period; it's absence that there is only 1. Ezequiel
> > introduced rotary-encoder,steps-per-period instead when adding supp=
ort
> > for quarter-period mode (which has 4 indents per period).
> >=20
> > Up to now (i.e. with two inputs) a period has length 4. Now with (s=
ay)
> > four inputs a period has length 16 instead. Now how should this be
> > modeled in dt? This series implements that I have to pass
> >=20
> > 	rotary-encoder,steps-per-period =3D <16>;
> >=20
> > now for "quarter-period mode" (i.e. 4 indents per 4 state changes[2=
]),
> > but that feels unnatural. I'd prefer to set a property to <1> inste=
ad,
> > meaning the device has an indent for each state change[2]. half-per=
iod
> > mode would be <2> and full-period mode would be <4>. But I don't ha=
ve a
> > nice name for such a property and maybe it's easier to live with
> > steps-per-period =3D <16>? What do you think?
> >=20
> > Also note that these patches are not as technically versatile as
> > possible. With 4 (n) input lines we could detect a quick rotation w=
here the
> > machine's latency only allows to sample after 7 (2^(n-1)-1) state
> > changes. Currently this is not implemented, but can be done later.
> >=20
> > Best regards
> > Uwe
> >=20
>=20
> AFAIUI the rotary encoder driver only handles incremental encoders no=
t
> absolute encoders. (So in fact the assumed rotary encoder could also =
be a

There is a device tree property "rotary-encoder,relative-axis" which
switches between absolute and relative reporting. This is maybe badly
named, but IIUC is there to differenciate between incremental and
absolute encoders.

> linear encoder with an incremental interface.) Those encoders almost =
always
> have an interface with two outputs (A, B) with a phase shift of 90 de=
grees
> between them. So in this case we have 4 steps per period. Sometimes t=
here
> is only one line for 1 or 2 steps per period. But I have never seen o=
r

I don't see how using only a single gpio would work for a rotary
encoder. I suspect we use different vocabulary to describe our devices
and so don't understand each other?! At least you cannot detect the
direction of the movement with a single input line, do you?

> heard of a device with more than 2 lines (except for the third output=
 which
> serves as a reference position index marker).
>=20
> Do devices wirh more than two outputs actually exist?
> Or is the purpose of supporting more than 2 lines something other tha=
n
> connecting an actual encoder to them?

I have a real rotary encoder with 4 input lines and so 16
distinguishable positions. It would be described as:

	compatible =3D "rotary-encoder";
	gpios =3D <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 11 GPIO_ACTIVE_HIGH>, =
<&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIVE_HIGH>;
	rotary-encoder,steps =3D <16>;
	rotary-encoder,steps-per-period =3D <16>;

with the binding implemented in my patches.

The wikipedia article about rotary encoders[1] uses a device with 3
input lines to explain gray encoding. So I didn't consider "my" device
as exotic up to now.

Best regards
Uwe

[1] https://en.wikipedia.org/wiki/Rotary_encoder

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
