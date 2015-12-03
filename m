From: Rojhalat Ibrahim <imr@rtschenk.de>
Subject: Re: [PATCH RFC 0/3] input: rotary_encoder: use more than two gpios as input
Date: Thu, 03 Dec 2015 14:01:18 +0100
Message-ID: <21976926.6E4NCDDElu@pcimr>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de> <2266988.l83Fg404My@pcimr> <20151202185920.GO5072@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58929 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759742AbbLCNB0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2015 08:01:26 -0500
In-Reply-To: <20151202185920.GO5072@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Guido =?ISO-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org

On Wednesday 02 December 2015 19:59:20 Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Wed, Dec 02, 2015 at 01:52:58PM +0100, Rojhalat Ibrahim wrote:
> > On Wednesday 02 December 2015 11:07:11 Uwe Kleine-K=F6nig wrote:
> > > some time ago I worked on the rotary encoder driver to make it su=
pport
> > > more than two input lines. This is the (only slightly tested[1]) =
rebase of
> > > this series on top of 4.4-rc2 (from 4.1).
> > >=20
> > > It would be great to get some feedback, especially (but not only)=
 for my
> > > change to raumfeld.c.
> > >=20
> > > Before Ezequiel's patch 3a341a4c30d4 ("Input: rotary-encoder - ad=
d
> > > support for quarter-period mode") we had a dt property
> > > "rotary-encoder,half-period" defined. It's presence meant that we=
 had 2
> > > indents per period; it's absence that there is only 1. Ezequiel
> > > introduced rotary-encoder,steps-per-period instead when adding su=
pport
> > > for quarter-period mode (which has 4 indents per period).
> > >=20
> > > Up to now (i.e. with two inputs) a period has length 4. Now with =
(say)
> > > four inputs a period has length 16 instead. Now how should this b=
e
> > > modeled in dt? This series implements that I have to pass
> > >=20
> > > 	rotary-encoder,steps-per-period =3D <16>;
> > >=20
> > > now for "quarter-period mode" (i.e. 4 indents per 4 state changes=
[2]),
> > > but that feels unnatural. I'd prefer to set a property to <1> ins=
tead,
> > > meaning the device has an indent for each state change[2]. half-p=
eriod
> > > mode would be <2> and full-period mode would be <4>. But I don't =
have a
> > > nice name for such a property and maybe it's easier to live with
> > > steps-per-period =3D <16>? What do you think?
> > >=20
> > > Also note that these patches are not as technically versatile as
> > > possible. With 4 (n) input lines we could detect a quick rotation=
 where the
> > > machine's latency only allows to sample after 7 (2^(n-1)-1) state
> > > changes. Currently this is not implemented, but can be done later=
=2E
> > >=20
> > > Best regards
> > > Uwe
> > >=20
> >=20
> > AFAIUI the rotary encoder driver only handles incremental encoders =
not
> > absolute encoders. (So in fact the assumed rotary encoder could als=
o be a
>=20
> There is a device tree property "rotary-encoder,relative-axis" which
> switches between absolute and relative reporting. This is maybe badly
> named, but IIUC is there to differenciate between incremental and
> absolute encoders.
>=20

IMHO the property switches between absolute and relative reporting but =
the
driver still handles only incremental encoders. Incremental encoder mea=
ns that
the input lines tell you when the encoder moves and in which direction.=
 So
by counting the steps you can generate an absolute value (which is what=
 the
driver does). But this absolute value is always _relative_ to the posit=
ion
at the time of start-up.

An absolute encoder allows you to determine its position by just lookin=
g at
the state of the input lines. There is no need to count steps.

> > linear encoder with an incremental interface.) Those encoders almos=
t always
> > have an interface with two outputs (A, B) with a phase shift of 90 =
degrees
> > between them. So in this case we have 4 steps per period. Sometimes=
 there
> > is only one line for 1 or 2 steps per period. But I have never seen=
 or
>=20
> I don't see how using only a single gpio would work for a rotary
> encoder. I suspect we use different vocabulary to describe our device=
s
> and so don't understand each other?! At least you cannot detect the
> direction of the movement with a single input line, do you?
>=20

Correct. With a single input line you can only count steps upwards and =
have
no direction information. Sometimes that is sufficient.

> > heard of a device with more than 2 lines (except for the third outp=
ut which
> > serves as a reference position index marker).
> >=20
> > Do devices wirh more than two outputs actually exist?
> > Or is the purpose of supporting more than 2 lines something other t=
han
> > connecting an actual encoder to them?
>=20
> I have a real rotary encoder with 4 input lines and so 16
> distinguishable positions. It would be described as:
>=20
> 	compatible =3D "rotary-encoder";
> 	gpios =3D <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 11 GPIO_ACTIVE_HIGH>=
, <&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIVE_HIGH>;
> 	rotary-encoder,steps =3D <16>;
> 	rotary-encoder,steps-per-period =3D <16>;
>=20
> with the binding implemented in my patches.
>=20
> The wikipedia article about rotary encoders[1] uses a device with 3
> input lines to explain gray encoding. So I didn't consider "my" devic=
e
> as exotic up to now.
>=20

So you have an absolute encoder. From the state of the four input lines=
 you
can determine the absolute position value. There is no need to count st=
eps.
At least that's the original purpose of your device.

Of course it might be conceivable to use that kind of absolute encoder =
in an
incremental way and count the steps throughout multiple revolutions.
But why would you do that? The resolution of 16 steps per revolution is=
 not
very good (incremental encoders often have hundreds or thousands of ste=
ps per
revolution). And the whole point of an absolute encoder is that you are=
 able
to determine the current position at any time just by looking at the in=
puts
without having to count steps.

   Rojhalat


> Best regards
> Uwe
>=20
> [1] https://en.wikipedia.org/wiki/Rotary_encoder
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
