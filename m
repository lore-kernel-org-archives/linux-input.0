From: Rojhalat Ibrahim <imr@rtschenk.de>
Subject: Re: [PATCH RFC 0/3] input: rotary_encoder: use more than two gpios as input
Date: Mon, 07 Dec 2015 10:01:39 +0100
Message-ID: <1470515.ydY47qFlGL@pcimr>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de> <21976926.6E4NCDDElu@pcimr> <56633FFA.5080708@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58211 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbbLGJBq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Dec 2015 04:01:46 -0500
In-Reply-To: <56633FFA.5080708@zonque.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Sylvain Rochet <sylvain.rochet@finsecur.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Johan Hovold <johan@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, kernel@pengutronix.de, linux-input@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>

On Saturday 05 December 2015 20:50:18 Daniel Mack wrote:
> On 12/03/2015 02:01 PM, Rojhalat Ibrahim wrote:
> > On Wednesday 02 December 2015 19:59:20 Uwe Kleine-K=F6nig wrote:
>=20
> >> I have a real rotary encoder with 4 input lines and so 16
> >> distinguishable positions. It would be described as:
> >>
> >> 	compatible =3D "rotary-encoder";
> >> 	gpios =3D <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 11 GPIO_ACTIVE_HI=
GH>, <&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIVE_HIGH>;
> >> 	rotary-encoder,steps =3D <16>;
> >> 	rotary-encoder,steps-per-period =3D <16>;
> >>
> >> with the binding implemented in my patches.
> >>
> >> The wikipedia article about rotary encoders[1] uses a device with =
3
> >> input lines to explain gray encoding. So I didn't consider "my" de=
vice
> >> as exotic up to now.
> >>
> >=20
> > So you have an absolute encoder. From the state of the four input l=
ines you
> > can determine the absolute position value. There is no need to coun=
t steps.
> > At least that's the original purpose of your device.
> >=20
> > Of course it might be conceivable to use that kind of absolute enco=
der in an
> > incremental way and count the steps throughout multiple revolutions=
=2E
> > But why would you do that? The resolution of 16 steps per revolutio=
n is not
> > very good (incremental encoders often have hundreds or thousands of=
 steps per
> > revolution). And the whole point of an absolute encoder is that you=
 are able
> > to determine the current position at any time just by looking at th=
e inputs
> > without having to count steps.
>=20
> Yes, you're right, that's actually a very different kind of device wh=
ich
> should be supported with a different mode or something, so that the
> output of the driver reflects the absolute state of the encoder. This
> even simplifies things in the driver: The entire state logic would be
> bypassed in this mode, and the current state of the GPIO lines would =
be
> used directly to get the absolute value. Makes sense?
>=20

Definitely makes sense to me.

Thanks.
   Rojhalat


>=20
> Thanks,
> Daniel
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
